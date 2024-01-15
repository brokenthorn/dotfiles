local cmp = require "cmp"

local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "rust",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  -- Package registry: https://mason-registry.dev/registry/list
  ensure_installed = {
    -- Lua stuff:
    "lua-language-server",
    "stylua",

    -- Web dev stuff:
    "css-lsp",
    "html-lsp",
    "emmet-language-server",
    "tailwindcss-language-server",
    "typescript-language-server",
    -- "deno",
    "prettier",
    "prettierd",
    "eslint_d",
    "eslint-lsp",

    -- Rust stuff:
    "rust-analyzer",
  },
}

-- git support in nvimtree
M.nvimtree = {
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
}

M.cmp = {
  completion = {
    -- compared to default, this adds noselect so that PreselectMode
    -- gets set to None, to disable annoying autocomplete and having
    -- to press C-e to cancel suggestion.
    completeopt = "menu,menuone,noselect",
    -- Some LSPs though don't listen to the opts above, so:
    preselect = cmp.PreselectMode.None,
  },
}

return M
