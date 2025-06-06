-- Your personal tool installation configuration
-- Ensures all your development tools are installed

return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    -- Extend the default ensure_installed list with your tools
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      -- Language servers
      "typescript-language-server",
      "eslint-lsp",
      "css-lsp",
      "html-lsp",
      "json-lsp",
      
      -- Formatters
      "prettier",
      
      -- Additional tools you want
      "pyright", -- if you work with Python
      -- Add more tools as needed
    })
  end,
}
