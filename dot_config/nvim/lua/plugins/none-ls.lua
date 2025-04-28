-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local function has_eslint_config(utils)
  return utils.root_has_file {
    ".eslintrc",
    ".eslintrc.cjs",
    ".eslintrc.js",
    ".eslintrc.json",
    "eslint.config.cjs",
    "eslint.config.js",
    "eslint.config.mjs",
  }
end

-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, config)
    -- config variable is the default configuration table for the setup function call
    local null_ls = require "null-ls"
    local extras = require "none-ls.diagnostics.eslint_d"

    -- Check supported formatters and linters
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- https://github.com/nvimtools/none-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    config.sources = {
      -- Set a formatter
      extras.with { condition = has_eslint_config },
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.formatting.prettier,
    }
    return config -- return final config table
  end,
}
