local function set_custom_highlights()
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#1E1E2E", bg = "#11111b" })
	vim.api.nvim_set_hl(0, "Float", { bg = "#11111b" })
end

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = set_custom_highlights,
})

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

require("config.options")

require("lazy").setup("plugins")

vim.cmd.colorscheme("catppuccin")

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.cmd(":%s/\\s\\+$//e")
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.fn.setreg("/", "")
	end,
})
