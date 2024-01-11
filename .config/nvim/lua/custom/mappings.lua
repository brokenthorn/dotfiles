---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "Conform/LSP formatting",
    },

    ["<leader>fd"] = {
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify(vim.g.disable_autoformat and "Autoformat disabled" or "Autoformat enabled")
      end,
      "Disable autoformat",
    },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

-- more keybinds!

return M
