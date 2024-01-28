-- This list defines plugins that should be installed,
-- or if they are already installed with nvchad, overrides configs.

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
      autotag = {
        enable = true,
      },
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
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "tsx",
      "jsx",
      "rescript",
      "xml",
      "php",
      "markdown",
      "astro",
      "glimmer",
      "handlebars",
      "hbs",
    },
    -- opts = {
    --   autotag = {
    --     enable = true,
    --     enable_rename = true,
    --     enable_close = true,
    --     enable_close_on_slash = true,
    --   },
    -- },
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
    opts = function()
      -- load the default config:
      local config = require "plugins.configs.cmp"

      -- add our custom config overrides to the above default config:
      local cmp = require "cmp"

      -- the default has select = true, I do not want that
      config.mapping["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      }

      config.completion = {
        completeopt = "menu,menuone,noselect",
      }

      config.preselect = cmp.PreselectMode.None

      -- return the final merged config:
      return config
    end,
  },

  -- Add additional plugins that don't come with NvChad:

  -- Conform does code formatting for multiple language:
  {
    "stevearc/conform.nvim",
    -- lazyloading when format on save is triggered:
    event = "BufWritePre",
    opts = function()
      local config = require "custom.configs.conform"
      -- local conform = require "conform"
      return config
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

  {
    "justinmk/vim-sneak",
    lazy = false,
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
