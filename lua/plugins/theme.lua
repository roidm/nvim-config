return {

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				auto_integrations = true,
				flavour = "mocha", -- Using Mocha as the base
				background = {
					light = "latte",
					dark = "mocha",
				},
				color_overrides = {
					all = {
						base = "#11111b", -- Using crust as the main background color
						mantle = "#181825", -- And mantle for secondary elements
						crust = "#1e1e2e", -- And the old base for the "darker" (now lighter) elements
					},
				},
			})
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.tokyonight_style = "night"
			vim.g.tokyonight_transparent = false
			vim.g.tokyonight_italic_comments = true
			vim.g.tokyonight_italic_keywords = true

			-- Sobrescribir colores mediante setup
			require("tokyonight").setup({
				style = "night",
				transparent = false,
				on_highlights = function(hl, c)
					hl.Normal = { bg = "#11111b", fg = c.fg }
					hl.NormalNC = { bg = "#11111b", fg = c.fg }
					hl.VertSplit = { bg = "#11111b", fg = c.fg }
					hl.StatusLine = { bg = "#11111b", fg = c.fg }
					hl.StatusLineNC = { bg = "#11111b", fg = c.fg }
				end,
			})

			-- Cargar el colorscheme
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
}
