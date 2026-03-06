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
        mouse = "a", -- Enable mouse support in all modes
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
      terminal_window_navigation = {
        {
          event = "TermOpen",
          pattern = "*",
          desc = "Enable window navigation in all terminal buffers",
          callback = function()
            local opts = { buffer = true, silent = true }
            -- Window navigation
            vim.keymap.set("t", "<C-w>h", "<Cmd>wincmd h<CR>", opts)
            vim.keymap.set("t", "<C-w>j", "<Cmd>wincmd j<CR>", opts)
            vim.keymap.set("t", "<C-w>k", "<Cmd>wincmd k<CR>", opts)
            vim.keymap.set("t", "<C-w>l", "<Cmd>wincmd l<CR>", opts)
            vim.keymap.set("t", "<C-w>w", "<Cmd>wincmd w<CR>", opts)
            vim.keymap.set("t", "<C-w>W", "<Cmd>wincmd W<CR>", opts)
            -- Window management
            vim.keymap.set("t", "<C-w>c", "<Cmd>close<CR>", opts)
            vim.keymap.set("t", "<C-w>o", "<Cmd>only<CR>", opts)
            vim.keymap.set("t", "<C-w>s", "<Cmd>split<CR>", opts)
            vim.keymap.set("t", "<C-w>v", "<Cmd>vsplit<CR>", opts)
            vim.keymap.set("t", "<C-w>=", "<Cmd>wincmd =<CR>", opts)
          end,
        },
      },
    },
  },
}
