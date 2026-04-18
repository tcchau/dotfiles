-- TypeScript language server plugin (vtsls only)

return {
  {
    "yioneko/nvim-vtsls",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
