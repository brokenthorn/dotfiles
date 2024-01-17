---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "Format code",
    },

    ["<leader>fd"] = {
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        vim.notify(vim.g.disable_autoformat and "Format on save disabled" or "Format on save enabled")
      end,
      "Toggle format on save",
    },
  },

  v = {
    [">"] = { ">gv", "indent" },
  },
}

return M
