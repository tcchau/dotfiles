-- ~/.config/nvim/lua/user/init.lua
return {
  plugins = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          -- Configure TypeScript server
          tsserver = {
            settings = {
              typescript = {
                format = {
                  enabled = false, -- Disable formatting (use Prettier instead)
                },
                preferences = {
                  quotePreference = "single",
                },
              },
              javascript = {
                format = {
                  enabled = false, -- Disable formatting (use Prettier instead)
                },
                preferences = {
                  quotePreference = "single",
                },
              },
            },
          },
        },
      },
    },
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "typescript-language-server", -- tsserver
          "prettier", -- formatter
          "eslint-lsp", -- linter for JS files
        },
      },
    },
    -- Use conform.nvim for formatting (modern approach)
    {
      "stevearc/conform.nvim",
      optional = false,
      opts = {
        formatters_by_ft = {
          javascript = { "prettier" },
          javascriptreact = { "prettier" },
          typescript = { "prettier" },
          typescriptreact = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = false,
        },
      },
    },
  },
  -- LSP configurations
  lsp = {
    config = {
      eslint = {
        -- Eslint only for JS files, not TS
        filetypes = { "javascript", "javascriptreact" },
        settings = {
          workingDirectory = { mode = "location" },
        },
      },
      tsserver = {
        -- TS server for type checking only, not formatting
        init_options = {
          preferences = {
            disableSuggestions = false,
          },
        },
      },
    },
    formatting = {
      disabled = {
        -- Disable lsp formatting to use conform.nvim instead
        "tsserver",
        "eslint",
      },
    },
    -- Enable built-in language servers
    servers = {
      "tsserver", -- TypeScript/JavaScript
      "cssls", -- CSS
      "html", -- HTML
      "jsonls", -- JSON
      "pyright", -- Python
      "eslint", -- For JS files only
    },
  },
}
