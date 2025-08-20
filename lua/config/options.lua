-- Basic Neovim options
vim.opt.nu = true -- Número de línea normal
vim.opt.relativenumber = false -- Número de línea relativo

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- Usa espacios en lugar de tabulaciones

vim.opt.switchbuf = "newtab"
vim.opt.showtabline = 0

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- UI
vim.opt.termguicolors = true -- Permite usar colores verdaderos
vim.opt.cursorline = true -- Resalta la línea actual
vim.opt.scrolloff = 8 -- Mantiene 8 líneas de contexto al desplazarse

-- Keys
vim.g.mapleader = " " -- Setea el líder a la barra espaciadora

-- clipboard
vim.opt.clipboard = "unnamedplus"

-- Shada history
vim.opt.shada = {
  "!",    -- Saves the command history
  "'100",  -- Search history (100 elements)
  "@100", -- Registers (100 elements)
  "<50",   -- Line history (50 elements)
  "f10",  -- Recent files (10 elements)
}
