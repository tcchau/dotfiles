-- plugins/user-ollama-completion.lua
return {
  {
    "trevin-j/olly.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("olly").setup({
        server = {
          endpoint = "http://127.0.0.1:11434",
          model = "qwen2.5-coder:7b",
        },
        -- optional: restrict to certain filetypes
        -- filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "python" },
      })
    end,
  },
}
