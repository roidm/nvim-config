---@diagnostic disable: undefined-global
-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
  local ok = pcall(vim.fn.system, {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  if not ok then
    vim.notify("Failed to clone lazy.nvim into " .. lazypath, vim.log.levels.ERROR)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Configuración modular
require("config.options")
require("config.util")
require("config.autocmds")

-- Plugins
require("lazy").setup("plugins")
