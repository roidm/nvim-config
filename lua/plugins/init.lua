-- This file imports plugin groups for lazy.nvim

return {
  { import = "plugins.dashboard"},
  { import = "plugins.lualine" }, -- Esta es la línea que debes tener
  { import = "plugins.ui" },
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.treesitter" },
  { import = "plugins.telescope" },
  { import = "plugins.others" },
  { import = "plugins.neogit" },
}
