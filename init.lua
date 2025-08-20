-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- carga las opciones de configuración
require("config.options")

-- carga todos los plugins
require("lazy").setup("plugins")

-- Nuevo mapeo de teclas para F5
vim.keymap.set("n", "<F5>", "<cmd>Alpha<CR>", { desc = "Abrir Dashboard" })
-- Después de la configuración de todos tus plugins
local telescope = require('telescope.builtin')

require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      '^node_modules/',
      '^.git/',
      '.vscode-oss/',
      'vendor/',
      'build/',
      'work/',
      '.local/share/flatpak/',
      '.bun/',
      '.atuin/',
      '.cache/',
      '.mozilla/',
      '.var/',
      '.ssh/',
      'go/',
      '.fzf',
      '.npm/',
      '.local/',
      '.straight/',
      '.cache/',
      '.config/emacs/tree-sitter/',
      '.ocat/',
      '.zen/',
    },
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--glob=!**/.vscode-oss/**',
    },
  },
})
--require('colorizer').setup()
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = "Find files" })

vim.keymap.set('n', '<leader>fh', function()
    telescope.find_files({ hidden = true })
  end, { desc = "Find files (hidden)" })

-- "--" a líneas lua
vim.api.nvim_set_keymap('v', '<leader>-', ':-:normal! I--<CR>', {
  noremap = true,
  silent = true,
  desc = 'Añadir -- a lineas seleccionadas'
})
vim.cmd.colorscheme('catppuccin')
require("plugins.neogit")
