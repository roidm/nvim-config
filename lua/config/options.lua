local o = vim.opt
local g = vim.g
local fn = vim.fn

-- Basic Neovim o.ons
o.nu = true -- Número de línea normal
o.relativenumber = false -- Número de línea relativo

o.showmode = false

-- Indentation
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true -- Usa espacios en lugar de tabulaciones
--o.autoindent = true
o.switchbuf = "newtab"
o.showtabline = 1

-- Search
o.incsearch = true
--o.hlsearch = false

-- UI
o.termguicolors = true -- Permite usar colores verdaderos
o.cursorline = true -- Resalta la línea actual
o.scrolloff = 8 -- Mantiene 8 líneas de contexto al desplazarse
o.signcolumn = "yes"

-- Configure how new splits should be opened
o.splitright = true
o.splitbelow = true

-- Keys
g.mapleader = " " -- Setea el líder a la barra espaciadora

-- clipboard
o.clipboard = "unnamedplus"

-- swapfile
o.swapfile = false

-- Shada history
o.shada = {
	"!", -- Saves the command history
	"'100", -- Search history (100 elements)
	"@100", -- Registers (100 elements)
	"<50", -- Line history (50 elements)
	"f10", -- Recent files (10 elements)
}

--o.shada:remove("'") -- quita la flag de búsqueda del shada
o.undofile = true

local undo_path = fn.stdpath("data") .. "/undo"
o.undodir = undo_path

if fn.isdirectory(undo_path) == 0 then
	fn.mkdir(undo_path, "p")
end
