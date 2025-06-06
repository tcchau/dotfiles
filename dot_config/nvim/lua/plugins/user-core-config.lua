-- Your personal global options, keymaps, and autocommands
-- This file contains YOUR customizations only

return {
  "AstroNvim/astrocore",
  opts = {
    options = {
      opt = {
        -- Your global vim options
        expandtab = true,
        shiftwidth = 2,
        tabstop = 2,
        -- Add any other global settings you want
      },
    },
    mappings = {
      n = {
        -- Your custom keymaps
        ["<leader>fp"] = { 
          function() require("conform").format() end, 
          desc = "Format with Prettier" 
        },
        ["<leader>tc"] = { ":TSC<cr>", desc = "TypeScript type check" },
        ["<leader>ef"] = { ":EslintFixAll<cr>", desc = "ESLint fix all" },
        -- Add more of your custom keymaps here
      },
    },
    autocmds = {
      -- Your custom autocommands
      user_typescript_config = {
        {
          event = "BufWritePre",
          pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
          desc = "Auto-organize imports on save",
          callback = function()
            -- Your custom logic here
          end,
        },
      },
    },
  },
}
