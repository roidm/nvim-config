return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"catppuccin/nvim", -- Asegura que catppuccin esté disponible
	},
	config = function()
		-- Crear un tema custom basado en catppuccin-mocha
		local catppuccin = require("lualine.themes.catppuccin-mocha")
		for section, colors in pairs(catppuccin) do
			for name, col in pairs(colors) do
				col.gui = "bold" -- forzar bold en todas las secciones
			end
		end
		vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
			callback = function()
				vim.cmd("noh")
			end,
		})
		require("lualine").setup({
			options = {
				theme = catppuccin, -- usar el tema modificado
				icons_enabled = true,
				-- component_separators = { left = '', right = '' },
				-- section_separators = { left = '', right = '' },
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
					winbar = {},
				},
				always_divide_middle = true,
				globalstatus = false,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "searchcount", "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
