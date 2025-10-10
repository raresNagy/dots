-- copied from dreamsofcode
-- Plugins that are related to coding. Such as lsp
-- or language specific.
return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    opts = function()
      return require "plugins.configs.mason"
    end,
    config = function(_, opts)
      -- opts may be a function result; ensure it is resolved
      local cfg = opts or require "plugins.configs.mason"
      require("mason").setup(cfg)

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        local runtime_cfg = require "plugins.configs.mason"
        if runtime_cfg and runtime_cfg.ensure_installed then
          vim.cmd("MasonInstall " .. table.concat(runtime_cfg.ensure_installed, " "))
        end
      end, {})

      -- set a global list for other plugins to reference
      vim.g.mason_binaries_list = (cfg and cfg.ensure_installed) or {}
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    dependencies = {
      "apple/pkl-neovim",
    },
    opts = function()
      return require "plugins.configs.treesitter"
    end,
    config = function(_, opts)
      -- resolve opts at runtime in case it's a function or not yet loaded
      local cfg = opts or require "plugins.configs.treesitter"
      require("nvim-treesitter.configs").setup(cfg)

      -- create a helper command to install all configured parsers
      vim.api.nvim_create_user_command("TSInstallAll", function()
        local runtime_cfg = require "plugins.configs.treesitter"
        if runtime_cfg and runtime_cfg.ensure_installed then
          vim.cmd("TSInstall " .. table.concat(runtime_cfg.ensure_installed, " "))
        end
      end, {})

      -- expose the list for other plugins/scripts
      vim.g.treesitter_parsers_list = (cfg and cfg.ensure_installed) or {}
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "jayp0521/mason-null-ls.nvim",
    },
    opts = function()
      return require "plugins.configs.null-ls"
    end,
  },
}
