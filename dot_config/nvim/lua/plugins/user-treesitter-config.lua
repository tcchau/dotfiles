-- Your personal Treesitter configuration
-- Ensures syntax highlighting for your languages

return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Add your preferred languages to the ensure_installed list
    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, {
      "typescript",
      "javascript",
      "tsx",
      "css",
      "scss",
      "html",
      "json",
      "yaml",
      "markdown",
      "markdown_inline",
      "vim",
      "vimdoc",
      "lua",
      -- Add other languages you work with
    })
  end,
}
