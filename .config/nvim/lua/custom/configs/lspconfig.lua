local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local lsp_servers_with_default_configs = { "html", "cssls", "tsserver", "tailwindcss", "eslint" }

for _, lsp in ipairs(lsp_servers_with_default_configs) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Setup the Rust Analyzer LSP server:
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        -- helps with autocomplete on cargo crates:
        allFeatures = true,
      },
    },
  },
}
-- End setup for the Rust Analyzer LSP server

-- Setup the Emmet LSP server:
lspconfig.emmet_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "pug",
    "typescriptreact",
  },

  -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
  -- Only the options listed in the table are supported.
  init_options = {
    --- @type string[]
    excludeLanguages = {},

    --- @type string[]
    extensionsPath = {},

    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {},

    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,

    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = "always",

    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = false,

    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles = {},

    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables = {},
  },
}
-- End setup for the Emmet LSP server
