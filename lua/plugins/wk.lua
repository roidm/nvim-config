return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			local wk = require("which-key")

			wk.setup({})

			-- Ajuste visual para ventanas flotantes
			vim.schedule(function()
				--				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#181825" })
			end)

			-- Pasamos wk y picker al módulo de keymaps
			local picker = require("config.picker")
			require("config.keymaps")(wk, picker)
		end,
	},
}
