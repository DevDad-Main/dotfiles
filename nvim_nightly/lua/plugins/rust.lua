local function mason_bin_path(package)
  local ok, registry = pcall(require, "mason-registry")
  if not ok then
    return nil
  end
  if not registry.is_installed(package) then
    return nil
  end
  local pkg = registry.get_package(package)
  local receipt = pkg:get_receipt()
  local bin = receipt and receipt:get() and receipt:get().links.bin[package]
  if not bin then
    return nil
  end
  local path = pkg:get_install_path() .. "/" .. bin
  if vim.fn.filereadable(path) == 1 then
    return path
  end
  return nil
end

vim.g.rustaceanvim = {
  server = {
    cmd = function()
      return { mason_bin_path("rust-analyzer") or "rust-analyzer" }
    end,
    default_settings = {
      ["rust-analyzer"] = {
        completion = {
          fullFunctionSignatures = { enable = true },
          callable = { snippets = "fill_arguments" },
          autoimport = { enable = true },
          autoself = { enable = true },
          postfix = { enable = true },
          addSemicolonToUnit = true,
          addColonsToModule = true,
        },
        signatureInfo = {
          detail = "full",
          documentation = { enable = true },
        },
        hover = {
          actions = { enable = true },
          documentation = { enable = true },
          links = { enable = true },
          memoryLayout = {
            enable = true,
            size = "both",
            offset = "both",
            alignment = "both",
            padding = "both",
            niches = true,
          },
        },
        inlayHints = {
          bindingModeHints = { enable = true },
          chainingHints = { enable = true },
          closingBraceHints = { enable = true, minLines = 25 },
          closureReturnTypeHints = { enable = "always" },
          discriminantHints = { enable = "always" },
          expressionAdjustmentHints = { enable = "always", mode = "prefix" },
          lifetimeElisionHints = { enable = "always", useParameterNames = true },
          parameterHints = { enable = true, missingArguments = { enable = true } },
          reborrowHints = { enable = "always" },
          renderColons = true,
          typeHints = { enable = true },
          maxLength = 80,
        },
        cargo = {
          buildScripts = { enable = true, rebuildOnSave = true },
          autoreload = true,
          allTargets = true,
          features = "all",
        },
        check = {
          command = "clippy",
          allTargets = true,
          workspace = true,
        },
        procMacro = { enable = true, attributes = { enable = true } },
        files = { watcher = "client", exclude = { ".git", "target", "node_modules" } },
        diagnostics = {
          enable = true,
          experimental = { enable = true },
          styleLints = { enable = true },
        },
        lens = {
          enable = true,
          implementations = { enable = true },
          references = {
            adt = { enable = true },
            enumVariant = { enable = true },
            method = { enable = true },
            trait = { enable = true },
          },
          run = { enable = true },
        },
        imports = {
          granularity = { group = "module", enforce = true },
          group = { enable = true },
          prefix = "plain",
        },
      },
    },
  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable inlay hints for rust-analyzer",
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "rust-analyzer" then
      vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
    end
  end,
})

-- Cargo terminal runner with auto-rerun on save
local cargo_state = { term_buf = nil, pkg_dir = nil }

local function find_pkg_dir()
  local dir = vim.fn.expand("%:p:h")
  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/Cargo.toml") then
      return dir
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
end

local function term_send(chan, text)
  if chan and vim.fn.chansend(chan, text) == 0 then
    vim.notify("Terminal closed, press <leader>rr to restart", vim.log.levels.WARN)
    cargo_state.term_buf = nil
  end
end

local function cargo_term_run(cmd, label)
  local pkg_dir = find_pkg_dir()
  if not pkg_dir then
    vim.notify("No Cargo.toml found in an ancestor directory", vim.log.levels.WARN)
    return
  end
  cargo_state.pkg_dir = pkg_dir

  if cargo_state.term_buf and vim.api.nvim_buf_is_valid(cargo_state.term_buf) then
    local win = vim.fn.bufwinid(cargo_state.term_buf)
    if win ~= -1 then
      vim.api.nvim_set_current_win(win)
    else
      vim.cmd("below split")
      vim.api.nvim_win_set_buf(0, cargo_state.term_buf)
    end
    local chan = vim.bo[cargo_state.term_buf].channel
    term_send(chan, "\x03")
    vim.defer_fn(function()
      term_send(chan, "clear; " .. cmd .. "\r")
    end, 300)
  else
    vim.cmd("below split | terminal")
    cargo_state.term_buf = vim.api.nvim_get_current_buf()
    local chan = vim.bo[cargo_state.term_buf].channel
    term_send(chan, "cd " .. vim.fn.shellescape(pkg_dir) .. " && " .. cmd .. "\r")
  end

  vim.notify(label .. ": " .. vim.fn.fnamemodify(pkg_dir, ":t"), vim.log.levels.INFO)
end

local function cargo_run()
  cargo_term_run("cargo run", "Running")
end

local function cargo_check()
  cargo_term_run("cargo check", "Checking")
end

local function cargo_test()
  cargo_term_run("cargo test", "Testing")
end

local function cargo_kill()
  if cargo_state.term_buf and vim.api.nvim_buf_is_valid(cargo_state.term_buf) then
    local win = vim.fn.bufwinid(cargo_state.term_buf)
    if win ~= -1 then
      vim.api.nvim_win_close(win, true)
    end
    vim.api.nvim_buf_delete(cargo_state.term_buf, { force = true })
  end
  cargo_state.term_buf, cargo_state.pkg_dir = nil, nil
end

vim.api.nvim_create_autocmd("BufWritePost", {
  desc = "Re-run cargo run on save",
  group = vim.api.nvim_create_augroup("RustCargoRerun", { clear = true }),
  pattern = "*.rs",
  callback = function()
    local state = cargo_state
    if not state.term_buf or not vim.api.nvim_buf_is_valid(state.term_buf) then
      return
    end
    if state.pkg_dir and not vim.fn.expand("%:p"):find(state.pkg_dir, 1, true) then
      return
    end
    local chan = vim.bo[state.term_buf].channel
    if not chan then
      state.term_buf = nil
      return
    end
    vim.fn.chansend(chan, "\x03")
    vim.defer_fn(function()
      if vim.api.nvim_buf_is_valid(state.term_buf) then
        vim.fn.chansend(vim.bo[state.term_buf].channel, "clear; cargo run\r")
      end
    end, 300)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function(ev)
    local buf = ev.buf
    local opts = function(desc)
      return { buffer = buf, silent = true, desc = desc }
    end

    vim.keymap.set("n", "<leader>rr", cargo_run, opts("Run cargo run (auto-rerun on save)"))
    vim.keymap.set("n", "<leader>rq", cargo_kill, opts("Kill cargo terminal"))
    vim.keymap.set("n", "<leader>rc", cargo_check, opts("Run cargo check"))
    vim.keymap.set("n", "<leader>rt", cargo_test, opts("Run cargo test"))

    vim.keymap.set("n", "K", "<cmd>RustLsp hover actions<CR>", opts("Hover actions (type/memory layout)"))
    vim.keymap.set("n", "<leader>ca", "<cmd>RustLsp codeAction<CR>", opts("Code action (grouped)"))
    vim.keymap.set("n", "<leader>rh", "<cmd>RustLsp hover actions<CR>", opts("Hover actions"))
    vim.keymap.set("n", "<leader>re", "<cmd>RustLsp expandMacro<CR>", opts("Expand macro"))
    vim.keymap.set("n", "<leader>rd", "<cmd>RustLsp openDocs<CR>", opts("Open docs.rs"))
    vim.keymap.set("n", "<leader>rC", "<cmd>RustLsp openCargo<CR>", opts("Open Cargo.toml"))
    vim.keymap.set("n", "<leader>rp", "<cmd>RustLsp parentModule<CR>", opts("Go to parent module"))
    vim.keymap.set("n", "<leader>rx", "<cmd>RustLsp explainError current<CR>", opts("Explain error"))
    vim.keymap.set("n", "<leader>rR", "<cmd>RustLsp renderDiagnostic<CR>", opts("Render diagnostic"))
    vim.keymap.set("n", "<leader>rT", "<cmd>RustLsp relatedTests<CR>", opts("Related tests"))
    vim.keymap.set("n", "<leader>rD", "<cmd>RustLsp relatedDiagnostics<CR>", opts("Related diagnostics"))
    vim.keymap.set("n", "<leader>rl", "<cmd>RustLsp runnables<CR>", opts("List runnables"))
    vim.keymap.set("n", "<leader>rs", "<cmd>RustLsp syntaxTree<CR>", opts("Syntax tree"))
    vim.keymap.set("n", "<leader>rf", "<cmd>RustLsp flyCheck<CR>", opts("Fly check (clippy)"))
    vim.keymap.set("n", "<leader>rmu", "<cmd>RustLsp moveItem up<CR>", opts("Move item up"))
    vim.keymap.set("n", "<leader>rmd", "<cmd>RustLsp moveItem down<CR>", opts("Move item down"))
  end,
})

require("crates").setup({
  lsp = {
    enabled = true,
    actions = true,
    completion = true,
    hover = true,
  },
  popup = {},
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "toml",
  callback = function(ev)
    local buf = ev.buf
    local opts = function(desc)
      return { buffer = buf, silent = true, desc = desc }
    end
    local crates = require("crates")
    vim.keymap.set("n", "<leader>Cu", crates.upgrade_crate, opts("Upgrade crate"))
    vim.keymap.set("n", "<leader>CU", crates.upgrade_all_crates, opts("Upgrade all crates"))
    vim.keymap.set("n", "<leader>Cf", crates.show_features_popup, opts("Show crate features"))
    vim.keymap.set("n", "<leader>Co", crates.open_documentation, opts("Open docs for crate"))
    vim.keymap.set("n", "<leader>Cr", crates.open_repository, opts("Open crate repository"))
    vim.keymap.set("n", "<leader>cA", crates.reload, opts("Reload crate info"))
  end,
})

