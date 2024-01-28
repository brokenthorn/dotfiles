-- For config options and more, head to:
-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#setup
-- For formatter options, see:
-- https://github.com/stevearc/conform.nvim/blob/master/doc/formatter_options.md

local M = {}

M.lsp_fallback = true
M.notify_on_error = true

-- To configure the formatters themselves and override defaults,
-- see https://github.com/stevearc/conform.nvim?tab=readme-ov-file#customizing-formatters

-- Configure formatters by file type.
-- Confirm will run multiple formatters sequentially.
-- Use a sublist to run only the first available formatter.
M.formatters_by_ft = {
  lua = { "stylua" },

  javascript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
  javascriptreact = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
  typescript = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },
  typescriptreact = { { "prettierd", "prettier" }, { "eslint_d", "eslint" } },

  css = { { "prettierd", "prettier" } },
  html = { { "prettierd", "prettier" } },

  sh = { "shfmt" },
  markdown = { "markdownlint" },

  rust = { "rustfmt" },
}

-- adding same formatter for multiple filetypes can look too much work for some.
-- instead of the above code you could just use a loop!
-- the config is just a table after all!

-- If true, will always format on save.
-- If a function, when to apply autoformatting can be customized.
M.format_on_save = function(bufnr)
  -- Disable autoformatting using a global/buffer-local variable.
  -- This variable can be toggled using <leader>fd.
  if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
    return
  end

  -- Disable autoformatting on certain filetypes.
  local ignore_fts = { "java", "sql" }

  if vim.tbl_contains(ignore_fts, vim.bo[bufnr].filetype) then
    return
  end

  -- Disable autoformat on certain paths.
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  if bufname:match "/node_modules/" then
    return
  end

  return {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  }
end

return M
