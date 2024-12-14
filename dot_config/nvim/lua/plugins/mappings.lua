return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      -- first key is the mode
      n = {
        [",,"] = { "<cmd>Telescope oldfiles<cr>", desc = "Shortcut to find files" },
        -- second key is the lefthand side of the map
        -- mappings seen under group name "Buffer"
        -- ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        -- ["<Leader>bD"] = {
        --   function()
        --     require("astroui.status").heirline.buffer_picker(function(bufnr)
        --       require("astrocore.buffer").close(bufnr)
        --     end)
        --   end,
        --   desc = "Pick to close",
        -- },
        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { name = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      },
      -- t = {
      --   -- setting a mapping to false will disable it
      --   -- ["<esc>"] = false,
      -- },
    },
  },
}
