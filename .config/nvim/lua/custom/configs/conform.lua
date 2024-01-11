-- For config options and more, head to:
-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#setup
-- For formatter options, see:
-- https://github.com/stevearc/conform.nvim/blob/master/doc/formatter_options.md

local options = {
  lsp_fallback = true,
  notify_on_error = true,

  -- To configure the formatters themselves and override defaults,
  -- see https://github.com/stevearc/conform.nvim?tab=readme-ov-file#customizing-formatters

  -- Configure formatters by file type:
  formatters_by_ft = {
    lua = { "stylua" },

    -- Confirm will run multiple formatters sequentially
    javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
    typescrypt = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },

    -- Use a sublist to run only the first available formatter
    -- javascript = { { "prettierd", "prettier" } }

    css = { "prettier" },
    html = { "prettier" },

    sh = { "shfmt" },
    markdown = { "markdownlint" },
  },

  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

  format_on_save = function(bufnr)
    -- Disable autoformatting on certain filetypes
    local ignore_fts = { "java", "sql" }
    if vim.tbl_contains(ignore_fts, vim.bo[bufnr].filetype) then
      return
    end

    -- Disable autoformatting using a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    -- Disable autoformat on certain paths
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/node_modules/") then
      return
    end

    return {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_fallback = true,
    }
  end,
}

require("conform").setup(options)
