-- ~/.config/nvim/lua/neovim4j/plugins/java.lua
-- Simple jdtls configuration without nvim-java wrapper

return {
  -------------------------------------------
  -- Mason for installing jdtls
  -------------------------------------------
  -- {
  --   'williamboman/mason.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('mason').setup({
  --       ui = {
  --         icons = {
  --           package_installed = "✓",
  --           package_pending = "➜",
  --           package_uninstalled = "✗",
  --         },
  --       },
  --     })
  --   end,
  -- },
  --
  -------------------------------------------
  -- Mason LSP Config
  -------------------------------------------
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    lazy = false,
    priority = 999,
    opts = {
      ensure_installed = { "jdtls" },
    },
  },

  -------------------------------------------
  -- jdtls configuration
  -------------------------------------------
  -- {
  --   "mfussenegger/nvim-jdtls",
  --   ft = { "java" },
  --   dependencies = {
  --     "mfussenegger/nvim-dap",
  --   },
  --   config = function()
  --     local jdtls = require("jdtls")
  --
  --     -- Find jdtls installation path
  --     local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  --     local config_path = jdtls_path .. "/config_linux"
  --     local plugins_path = jdtls_path .. "/plugins/"
  --     local launcher_jar = vim.fn.glob(plugins_path .. "org.eclipse.equinox.launcher_*.jar")
  --     local lombok_jar = jdtls_path .. "/lombok.jar"
  --
  --     -- Data directory for workspace
  --     local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
  --     local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls-workspace/" .. project_name
  --
  --     local config = {
  --       cmd = {
  --         "java",
  --         "-javaagent:" .. lombok_jar,
  --         "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  --         "-Dosgi.bundles.defaultStartLevel=4",
  --         "-Declipse.product=org.eclipse.jdt.ls.core.product",
  --         "-Dlog.protocol=true",
  --         "-Dlog.level=ALL",
  --         "-Xmx1g",
  --         "--add-modules=ALL-SYSTEM",
  --         "--add-opens",
  --         "java.base/java.util=ALL-UNNAMED",
  --         "--add-opens",
  --         "java.base/java.lang=ALL-UNNAMED",
  --         "-jar",
  --         launcher_jar,
  --         "-configuration",
  --         config_path,
  --         "-data",
  --         workspace_dir,
  --       },
  --       root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  --       settings = {
  --         java = {
  --           signatureHelp = { enabled = true },
  --           contentProvider = { preferred = "fernflower" },
  --           completion = {
  --             favoriteStaticMembers = {
  --               "org.junit.Assert.*",
  --               "org.junit.jupiter.api.Assertions.*",
  --               "org.mockito.Mockito.*",
  --             },
  --             filteredTypes = {
  --               "com.sun.*",
  --               "io.micrometer.shaded.*",
  --             },
  --           },
  --           sources = {
  --             organizeImports = {
  --               starThreshold = 9999,
  --               staticStarThreshold = 9999,
  --             },
  --           },
  --           codeGeneration = {
  --             toString = {
  --               template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
  --             },
  --             useBlocks = true,
  --           },
  --         },
  --       },
  --       init_options = {
  --         bundles = {},
  --       },
  --     }
  --
  --     jdtls.start_or_attach(config)
  --   end,
  -- },
  {
    "nvim-java/nvim-java",
    ft = { "java", "yaml", "jproperties" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "JavaHello/spring-boot.nvim",
        commit = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
      },
    },
    config = function()
      -- Register LspAttach handler BEFORE java.setup() so it catches
      -- the spring-boot LS when it starts during setup.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("spring-boot-handshake", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "spring-boot" then
            client.server_capabilities.semanticTokensProvider = nil
            client._enabled_capabilities.semantic_tokens = false
            local cap_mod = require("vim.lsp._capability")
            local st_h = cap_mod.all.semantic_tokens
            if st_h then
              for bufnr in pairs(client.attached_buffers) do
                local h = st_h.active[bufnr]
                if h and h.client_state and h.client_state[client.id] then
                  h:on_detach(client.id)
                end
              end
            end

            -- Override the sts/addClasspathListener handler to respond
            -- immediately and retry registering with jdtls in background.
            client.handlers["sts/addClasspathListener"] = function(_, result)
              local callbackCommandId = result.callbackCommandId
              vim.lsp.commands[callbackCommandId] = function(param, _)
                return require("spring_boot.util").boot_execute_command(callbackCommandId, param)
              end
              vim.defer_fn(function()
                local function try_register(remaining)
                  if remaining <= 0 then return end
                  local jdtls = require("spring_boot.util").get_client("jdtls")
                  if jdtls then
                    pcall(require("spring_boot.jdtls").execute_command,
                      "sts.java.addClasspathListener", { callbackCommandId })
                  else
                    vim.defer_fn(function() try_register(remaining - 1) end, 2000)
                  end
                end
                try_register(15)
              end, 0)
              return vim.empty_dict()
            end
          end
        end,
      })

      require("java").setup({
        checks = {
          nvim_version = true,
          nvim_jdtls_conflict = true,
        },
        jdtls = {
          version = "1.43.0",
        },
        lombok = {
          enable = true,
          version = "1.18.40",
        },
        java_test = {
          enable = true,
          version = "0.40.1",
        },
        java_debug_adapter = {
          enable = true,
          version = "0.58.2",
        },
        spring_boot_tools = {
          enable = true,
          version = "1.55.1",
        },
        jdk = {
          auto_install = true,
          version = "17",
        },
        log = {
          use_console = true,
          use_file = true,
          level = "info",
          log_file = vim.fn.stdpath("state") .. "/nvim-java.log",
          max_lines = 1000,
          show_location = false,
        },
      })

      -- Patch the local ls_config in launch.lua to enable classpath
      -- listening from the start. The ls_config.init_options has
      -- enableJdtClasspath = false hardcoded - changing it here
      -- ensures the spring-boot LS starts with classpath support.
      pcall(function()
        local launch = require("spring_boot.launch")
        for i = 1, 50 do
          local name, value = debug.getupvalue(launch.setup, i)
          if name == "ls_config" then
            value.init_options.enableJdtClasspath = true
            break
          end
          if not name then break end
        end
      end)

      -- Wrap the registerCapability handler to filter out semantic tokens for
      -- the spring-boot LS.
      local orig_reg_cap = vim.lsp.handlers["client/registerCapability"]
      vim.lsp.handlers["client/registerCapability"] = function(err, params, ctx)
        local client = ctx and vim.lsp.get_client_by_id(ctx.client_id)
        if client and client.name == "spring-boot" and params and params.registrations then
          local filtered = {}
          for _, reg in ipairs(params.registrations) do
            if reg.method ~= "textDocument/semanticTokens" then
              filtered[#filtered + 1] = reg
            end
          end
          params.registrations = filtered
        end
        return orig_reg_cap(err, params, ctx)
      end
    end,
  },
}
