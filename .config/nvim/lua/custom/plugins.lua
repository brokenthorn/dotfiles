-- This list defines plugins that should be installed,
-- or if they are already installed with nvchad, overrides configs.

local cmp = require "cmp"
local cmpTypes = require "cmp.types"

---@type NvPluginSpec[]
local plugins = {
  -- These plugins come with NvChad, and I only need to override some configs:
  {
    "williamboman/mason.nvim",
    opts = {
      -- Package registry: https://mason-registry.dev/registry/list
      ensure_installed = {
        "css-lsp",
        "emmet-language-server",
        "eslint-lsp",
        "eslint_d",
        "html-lsp",
        "lua-language-server",
        "prettier",
        "prettierd",
        "rust-analyzer",
        "stylua",
        "tailwindcss-language-server",
        "typescript-language-server",
        -- "deno",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c",
        "css",
        "html",
        "javascript",
        "lua",
        "markdown",
        "markdown_inline",
        "rust",
        "tsx",
        "typescript",
        "vim",
      },
      indent = {
        enable = true,
        -- disable = {
        --   "python"
        -- },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          -- when true, auto-selects the first item if nothing was selected,
          -- making noselect below not take effect.
          select = false,
        },
      },
      -- adding noselect compared to default, to prevent autocomplete when typing,
      -- and this is actually nvim-cmp defaults, but NvChad overrides this.
      completion = {
        completeopt = "menu,menuone,noselect",
      },
      -- this overrides LSPs that specify this feature and enable preselection:
      preselect = cmp.PreselectMode.None,
    },
  },

  -- Add additional plugins that don't come with NvChad:

  -- Conform does code formatting for multiple language:
  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    event = "BufWritePre",
    config = function()
      require "custom.configs.conform"
    end,
  },

  -- Crates helps manage Rust crates.io dependencies:
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
  -- For a plugin to be loaded, you will need to set either
  -- `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup,
  -- add `lazy = false` to a plugin spec, for example:
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
