-- Opciones básicas de Neovim

-- Líneas de números
vim.opt.nu = true -- Número de línea normal
vim.opt.relativenumber = false -- Número de línea relativo

-- Sangría (indentation)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- Usa espacios en lugar de tabulaciones

vim.opt.switchbuf = "newtab"
vim.opt.showtabline = 0
-- Búsqueda
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- UI
vim.opt.termguicolors = true -- Permite usar colores verdaderos
vim.opt.cursorline = true -- Resalta la línea actual
vim.opt.scrolloff = 8 -- Mantiene 8 líneas de contexto al desplazarse

-- Teclas
vim.g.mapleader = " " -- Setea el líder a la barra espaciadora

-- Sincroniza el portapapeles de Neovim con el del sistema
vim.opt.clipboard = "unnamedplus"
