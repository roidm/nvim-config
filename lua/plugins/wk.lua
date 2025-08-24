return {

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			require("which-key").setup({
				-- You can add additional configurations here
			})
			vim.schedule(function()
				-- Color configuration for the which-key minibuffer and all floating windows
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#181825" })
			end)
			require("config.keymaps")
		end,
	},
}
