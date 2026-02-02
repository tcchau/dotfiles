-- Your AstroCommunity plugin imports
-- This is separate from the template community.lua file

return {
  "AstroNvim/astrocommunity",
  
  -- Import language packs you want
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  
  -- Import other community plugins you want
  -- { import = "astrocommunity.colorscheme.catppuccin" },
  -- { import = "astrocommunity.completion.copilot-lua" },
  -- { import = "astrocommunity.editing-support.auto-save-nvim" },
}
