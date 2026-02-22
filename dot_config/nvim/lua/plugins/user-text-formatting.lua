return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        text_formatting = {
          {
            event = "FileType",
            pattern = { "markdown", "text", "txt" },
            callback = function()
              vim.opt_local.wrap = true           -- Enable line wrapping
              vim.opt_local.linebreak = true      -- Break at word boundaries
              vim.opt_local.textwidth = 0         -- No hard breaks
              vim.opt_local.wrapmargin = 0        -- No wrap margin
              vim.opt_local.colorcolumn = "80"    -- Visual guide only
              
              -- Remove auto-formatting options
              vim.opt_local.formatoptions:remove("t")  -- No auto-wrap text
              vim.opt_local.formatoptions:remove("a")  -- No auto-format paragraphs
              
              vim.keymap.set("n", "j", "gj", { buffer = true })
              vim.keymap.set("n", "k", "gk", { buffer = true })
              vim.keymap.set("v", "j", "gj", { buffer = true })
              vim.keymap.set("v", "k", "gk", { buffer = true })
            end,
          },
        },
      },
    },
  },
}
