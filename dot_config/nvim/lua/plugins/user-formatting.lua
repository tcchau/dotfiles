--- Your personal code formatting configuration
-- Dedicated to Prettier via conform.nvim

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({ async = true, lsp_fallback = false })
      end,
      mode = "",
      desc = "Format buffer with Prettier",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      vue = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      less = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      python = { "black" },
      lua = { "stylua" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = false, -- Never fallback to LSP formatting
    },
    formatters = {
      prettier = {
        -- Use local prettier if available, fallback to global
        command = function()
          -- Check for local prettier first
          local prettier_local = vim.fn.fnamemodify(vim.fn.getcwd(), ":p") .. "node_modules/.bin/prettier"
          if vim.fn.executable(prettier_local) == 1 then
            return prettier_local
          end
          -- Fallback to global prettier
          return "prettier"
        end,
        args = { "--stdin-filepath", "$FILENAME" },
        stdin = true,
        -- Working directory will be automatically detected by prettier
      },
      ["markdownlint-cli2"] = {
        command = "markdownlint-cli2",
        args = { "--fix", "$FILENAME" },
        stdin = false,
      },
    },
  },
}
