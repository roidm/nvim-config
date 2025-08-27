---@diagnostic disable: missing-fields
return {
	{
		"catppuccin/nvim",
		lazy = true,
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
						custom = "#4D678A",
					},
				},
			})

			-- custom highlights
			local function set_custom_highlights()
				local p = require("catppuccin.palettes").get_palette("mocha")

				---@diagnostic disable-next-line: undefined-field
				vim.api.nvim_set_hl(0, "FloatBorder", { fg = p.custom, bg = p.mantle })
				vim.api.nvim_set_hl(0, "Float", { bg = p.crust })
			end

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "catppuccin",
				callback = function()
					vim.schedule(set_custom_highlights)
				end,
			})

			vim.cmd.colorscheme("catppuccin")
			set_custom_highlights()
		end,
	},
}
