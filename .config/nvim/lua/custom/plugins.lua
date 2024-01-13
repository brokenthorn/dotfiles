local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  -- Override some default plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason, -- mainly to ensure some plugins are installed
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter, -- mainly to ensure some languages are installed
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Mainly to disable the annoying preselection that autocompletes
  -- when pressing Space.
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- apply nvchad default config and plugin setup:
      require "plugins.configs.lspconfig"
      -- apply our custom config and setup after that:
      require "custom.configs.lspconfig"
    end,
  },

  -- Install custom plugins
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- Conform takes care of all aspects of pretty formatting code
  -- for multiple language:
  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    event = "BufWritePre",
    config = function()
      require "custom.configs.conform"
    end,
  },

  -- Helps managing Rust crates.io dependencies:
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    tag = "stable",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      -- add it to cmp completions:
      require("cmp").setup.buffer {
        sources = { { name = "crates" } },
      }
      crates.show()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
