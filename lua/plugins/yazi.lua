return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{
			"<leader>-",
			function()
				require("yazi").yazi(nil, {
					-- Forzar tamaño en la llamada
					win_width = 100,
					win_height = 20,
					win_border = "rounded",
					win_blend = 0,
				})
			end,
			desc = "Open yazi",
		},
		{
			"<leader>cw",
			function()
				require("yazi").yazi(vim.loop.cwd(), {
					win_width = 100,
					win_height = 20,
					win_border = "double",
					win_blend = 0,
				})
			end,
			desc = "Open Yazi at nvim's working directory",
		},
	},
	opts = {
		open_for_directories = false,
		-- Algunos wrappers usan nombres diferentes
		floating_window_scaling_factor = 0.8,
		win_border = "rounded",
		win_blend = 0,
	},
}
