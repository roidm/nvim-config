return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-media-files.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},

		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")

			-- Carga la extensión de ui-select
			telescope.load_extension("ui-select")
			telescope.load_extension("fzf")
			telescope.load_extension("media_files")

			-- Configura Telescope para usar la extensión
			telescope.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--glob=!**/.vscode-oss/**",
						"--hidden", -- Asegúrate de que rg también ignore los archivos ocultos
					},
					mappings = {
						i = {
							["<C-t>"] = actions.select_tab,
							["<C-x>"] = actions.select_vertical,
							["<C-v>"] = actions.select_horizontal,
							["<CR>"] = actions.select_default,
							["<C-q>"] = actions.close,
						},
						n = {
							["<C-t>"] = actions.select_tab,
							["<C-x>"] = actions.select_vertical,
							["<C-v>"] = actions.select_horizontal,
							["<CR>"] = actions.select_default,
							["q"] = actions.close,
						},
					},
					layout_config = {
						width = 0.9,
						height = 0.8,
						preview_width = 0.6,
					},
				},
				pickers = {
					find_files = {
						theme = "ivy",
						find_command = {
							"fd",
							"--type=f",
							"--hidden",
						},
					},
					oldfiles = {
						theme = "ivy",
					},
				},
				extensions = {
					fzf = {},
					file_browser = {
						hidden = { file_browser = true },
						sorting_strategy = "ascending",
						initial_mode = "normal",
						grouped = true,
						layout_config = {
							width = 135,
							height = 40,
							preview_width = 0.6,
						},
						previewer = true,
						hijack_netrw = true,
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- Opciones de configuración
						}),
					},
				},
			})
		end,
	},
}
