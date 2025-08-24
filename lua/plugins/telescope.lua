return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},

		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")
			-- Carga la extensión de ui-select
			telescope.load_extension("ui-select")

			-- Configura Telescope para usar la extensión
			telescope.setup({
				defaults = {
					file_ignore_patterns = {
						"^node_modules/",
						"^.git/",
						".vscode-oss/",
						"vendor/",
						"build/",
						".local/share/flatpak/",
						".bun/",
						".atuin/",
						".cache/",
						".mozilla/",
						".var/",
						".ssh/",
						"go/",
						".fzf",
						".npm/",
						".local/",
						".straight/",
						".cache/",
						".config/emacs/tree-sitter/",
						".ocat/",
						".zen/",
					},
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--glob=!**/.vscode-oss/**",
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
				extensions = {
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

			-- Cargar extensiones
			telescope.load_extension("file_browser")

			-- 🔥 KEYMAPS PARA FILE BROWSER
			local fb_actions = require("telescope").extensions.file_browser.actions

			--vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
			--vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			--vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
			--vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

			-- 🔥 NUEVOS KEYMAPS: Búsqueda en ~/.config
			vim.keymap.set("n", "<leader>fc", function()
				builtin.find_files({
					cwd = "~/.config/nvim",
					prompt_title = "📁 CONFIG Files",
					hidden = true,
					file_ignore_patterns = {
						"node_modules",
						".git",
						".cache",
						".npm",
						".yarn",
						"vendor",
					},
				})
			end, { desc = "Nvim directory" })

			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({
					cwd = "~/.config/nvim",
					prompt_title = "⚡ NVIM Config",
					file_ignore_patterns = {
						"node_modules",
						".git",
						"lock.json",
						".undo",
					},
				})
			end, { desc = "Find nvim config files" })

			-- File Browser específico
			vim.keymap.set("n", "<leader>fe", function()
				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					grouped = true,
					previewer = true,
					initial_mode = "normal",
					layout_config = {
						width = 135,
						height = 40,
						preview_width = 0.6,
					},
					mappings = {
						n = {
							["h"] = fb_actions.goto_parent_dir,
							["l"] = actions.select_default,
							["-"] = fb_actions.goto_parent_dir,
							["q"] = actions.close,
						},
					},
				})
			end, { desc = "File browser" })

			-- File Browser desde directorio actual
			vim.keymap.set("n", "<leader>fE", function()
				telescope.extensions.file_browser.file_browser({
					path = vim.fn.getcwd(),
					grouped = true,
					previewer = true,
				})
			end, { desc = "File browser (cwd)" })

			-- 🔥 NUEVO KEYMAP: File Browser flotante con <leader>.
			vim.keymap.set("n", "<leader>.", function()
				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					layout_config = {
						anchor = "CENTER",
						width = 135,
						height = 40,
						mirror = true,
					},
					previewer = true,
					grouped = true,
					initial_mode = "normal",
					mappings = {
						n = {
							["h"] = fb_actions.goto_parent_dir,
							["l"] = actions.select_default,
							["-"] = fb_actions.goto_parent_dir,
							["q"] = actions.close,
							["<leader>."] = actions.close, -- Cerrar con el mismo keymap
						},
					},
				})
			end, { desc = "File browser (float)" })
		end,
	},
}
