-- Your personal LSP configurations
-- Handles TSServer and ESLint setup according to your preferences

return {
  "AstroNvim/astrolsp",
  opts = {
    -- Disable LSP formatting (use Prettier instead)
    formatting = {
      disabled = {
        "vtsls", -- Disable vtsls formatting
        "eslint", -- ESLint should not format, only lint
      },
    },
    -- Your LSP server configurations
    config = {
      -- Conditionally enable tsserver as fallback (handled by user-typescript.lua)
      tsserver = function()
        -- Only enable if vtsls is not available
        local has_vtsls = vim.fn.executable("vtsls") == 1 or vim.fn.executable("./node_modules/.bin/vtsls") == 1
        if has_vtsls then
          return { enabled = false }
        else
          return {
            settings = {
              typescript = {
                format = { enabled = false }, -- Disable TS formatting
                preferences = { 
                  quotePreference = "single",
                  includeCompletionsForModuleExports = true,
                  includeCompletionsForImportStatements = true,
                },
              },
              javascript = {
                format = { enabled = false }, -- Disable JS formatting  
                preferences = { 
                  quotePreference = "single",
                  includeCompletionsForModuleExports = true,
                  includeCompletionsForImportStatements = true,
                },
              },
            },
            on_attach = function(client, bufnr)
              -- Your custom TSServer setup
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end,
          }
        end
      end,
      eslint = {
        -- ESLint for ALL JS/TS files for linting (not formatting)
        filetypes = { 
          "javascript", 
          "javascriptreact", 
          "typescript", 
          "typescriptreact" 
        },
        settings = {
          workingDirectory = { mode = "location" },
          format = { enable = false }, -- Disable ESLint formatting
          codeActionOnSave = {
            enable = false, -- Disable auto-fix on save (use manual fix)
            mode = "all"
          },
        },
        root_markers = { ".eslintrc.json", ".eslintrc.js", "package.json", ".git" },
        on_attach = function(client, bufnr)
          -- Disable ESLint's formatting capability
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
    },
  },
}
