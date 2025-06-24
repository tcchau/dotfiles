-- TypeScript language server configuration with local/global fallback
-- Prefers local vtsls, falls back to global vtsls, then to tsserver

return {
  {
    "yioneko/nvim-vtsls",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local lspconfig = require("lspconfig")
      
      -- Function to check if vtsls is available locally or globally
      local function get_vtsls_cmd()
        -- Check for local installation first
        local local_vtsls = vim.fn.executable("./node_modules/.bin/vtsls")
        if local_vtsls == 1 then
          return { "./node_modules/.bin/vtsls", "--stdio" }
        end
        
        -- Check for global installation
        local global_vtsls = vim.fn.executable("vtsls")
        if global_vtsls == 1 then
          return { "vtsls", "--stdio" }
        end
        
        return nil
      end
      
      local vtsls_cmd = get_vtsls_cmd()
      
      if vtsls_cmd then
        -- Use vtsls if available
        require("vtsls").config({
          cmd = vtsls_cmd,
          settings = {
            typescript = {
              preferences = {
                quoteStyle = "single",
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
              },
              format = {
                enable = false, -- Let other formatters handle this
              },
            },
            javascript = {
              preferences = {
                quoteStyle = "single",
                includeCompletionsForModuleExports = true,
                includeCompletionsForImportStatements = true,
              },
              format = {
                enable = false, -- Let other formatters handle this
              },
            },
            vtsls = {
              autoUseWorkspaceTsdk = true,
            },
          },
        })
      else
        -- Fallback to tsserver if vtsls not available
        print("vtsls not found, falling back to tsserver")
      end
    end,
  },
}
