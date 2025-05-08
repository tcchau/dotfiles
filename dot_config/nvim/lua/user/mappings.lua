-- ~/.config/nvim/lua/user/mappings.lua
return {
  n = {
    -- Format document with Prettier through conform.nvim
    ["<leader>fp"] = {
      function() require("conform").format() end,
      desc = "Format with Prettier",
    },
    -- Run TypeScript type checking
    ["<leader>tc"] = {
      function() vim.cmd "TSC" end,
      desc = "TypeScript type check",
    },
  },
}
