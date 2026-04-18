-- Your personal LSP configurations
-- Handles vtsls and ESLint setup according to your preferences

return {
  "AstroNvim/astrolsp",
  opts = {
    -- Disable LSP formatting (use dedicated formatters instead)
    formatting = {
      disabled = {
        "ts_ls", -- Disable ts_ls formatting
        "tsserver", -- Disable tsserver formatting (legacy name)
        "vtsls", -- Disable vtsls formatting
        "eslint", -- ESLint should not format, only lint
        "pyright", -- Disable Python LSP formatting (use black)
        "lua_ls", -- Disable Lua LSP formatting (use stylua)
      },
    },
    -- Your LSP server configurations
    config = {
      ts_ls = { enabled = false },
      tsserver = { enabled = false },
      vtsls = {
        settings = {
          typescript = {
            preferences = {
              quoteStyle = "single",
              includeCompletionsForModuleExports = true,
              includeCompletionsForImportStatements = true,
            },
            format = {
              enable = false,
            },
          },
          javascript = {
            preferences = {
              quoteStyle = "single",
              includeCompletionsForModuleExports = true,
              includeCompletionsForImportStatements = true,
            },
            format = {
              enable = false,
            },
          },
          vtsls = {
            autoUseWorkspaceTsdk = true,
          },
        },
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
      eslint = {
        -- ESLint for ALL JS/TS files for linting (not formatting)
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        settings = {
          workingDirectory = { mode = "location" },
          format = { enable = false }, -- Disable ESLint formatting
          codeActionOnSave = {
            enable = false, -- Disable auto-fix on save (use manual fix)
            mode = "all",
          },
        },
        root_markers = { ".eslintrc.json", ".eslintrc.js", "package.json", ".git" },
        on_attach = function(client)
          -- Disable ESLint's formatting capability
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
      pyright = {
        -- Python LSP for type checking and completions
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
        on_attach = function(client)
          -- Disable Python LSP formatting (use black instead)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
      lua_ls = {
        -- Lua LSP configuration
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" }, -- Recognize vim global in neovim configs
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
            format = {
              enable = false, -- Disable lua_ls formatting (use stylua)
            },
          },
        },
        on_attach = function(client)
          -- Disable Lua LSP formatting (use stylua instead)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
    },
  },
}
