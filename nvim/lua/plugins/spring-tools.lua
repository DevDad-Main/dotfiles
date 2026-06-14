return {
  "devdad-main/spring-tools.nvim",
  -- dir = "~/spring-tools.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("spring-tools").setup({
      command_input = {
        position = "center", -- "top", "center" (default), or "bottom"
      },
      highlights = {
        SpringToolsSelected = { link = "@function" },
        SpringToolsHeader = { link = "@function" },
        SpringToolsDim = { link = "@comment" },
        SpringToolsRunning = { link = "@comment" },

        -- NOTE: Used for updating the colour of the verbs in Endpoints Tab
        SpringToolsMethodHeader = { link = "@variable" },
        SpringToolsBeanHeader = { link = "@variable" }, -- "Controllers", "Services" etc
        SpringToolsBeanName = { link = "@comment" }, -- "UserController", "UserService"
        SpringToolsBeanMethod = { link = "@comment" }, -- "@appName()", "@maxConnections()"

        SpringToolsAccent = { link = "@comment" },

        -- NOTE: Overwrite Http Verbs in Endpoints.
        SpringToolsGet = { link = "@comment" },
        SpringToolsPost = { link = "@comment" },
        SpringToolsPut = { link = "@comment" },
        SpringToolsPatch = { link = "@comment" },
        SpringToolsDelete = { link = "@comment" },

        -- NOTE: Overwrite Tests tab
        SpringToolsTestRunAll = { link = "@function" },
        SpringToolsTestClass = { link = "@variable" },
        SpringToolsTestMethod = { link = "@comment" },
        -- SpringToolsKey = { link = "SpringToolsRunning" },
        -- SpringToolsError = { link = "SpringToolsRunning" },

        -- NOTE: Config highlight Overrides
        SpringToolsConfigFile = { link = "@variable" },
        SpringToolsConfigSection = { link = "@variable" },
        -- SpringToolsConfigKey = { link = "@variable" }, -- White key
        SpringToolsConfigKey = { link = "@comment" }, -- Darker comment key variant
        SpringToolsConfigValue = { link = "@comment" },

        -- NOTE: Dashboard Projects
        -- Dashboard
        SpringToolsDashboardProject = { link = "@variable", bold = true }, -- Project name
        SpringToolsDashboardStatus = { link = "@comment" }, -- stopped/running/failed
        SpringToolsDashboardBuildType = { link = "@comment" }, -- maven/gradle
      },
    })
  end,
}
