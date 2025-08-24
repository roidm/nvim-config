return {
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				columns = {
					"icon",
					--"permissions",
					--"size",
					-- "mtime"
				},
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-k>"] = false,
					["<C-j>"] = false,
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["<M-h>"] = "actions.select_split",
					["q"] = "actions.close",
					["<Esc>"] = "actions.close",
				},
				float = {
					max_width = 110,
					max_height = 30,
					col = function()
						return math.floor((vim.o.columns - 110) / 2)
					end,
					row = function()
						return math.floor((vim.o.lines - 30) / 2)
					end,
					border = "rounded",
					padding = 4,
					previe_split = "right",
					win_options = {
						signcolumn = "no",
						--winblend = 2,
						cursorline = true,
						-- Aumentar el tamaño de fuente en la ventana flotante
						winhighlight = "Normal:Normal,EndOfBuffer:Normal",
					},
				},
				-- Configuration for the file preview window
				preview_win = {
					update_on_cursor_moved = true,
					-- How to open the preview window "load"|"scratch"|"fast_scratch"
					preview_method = "fast_scratch",
					disable_preview = function(filename)
						return false
					end,
					win_options = {},
				},
				view_options = {
					show_hidden = true,
					is_always_hidden = function(name, _)
						local folder_skip = { "dev-tools.locks", "dune.lock", "_build" }
						return vim.tbl_contains(folder_skip, name)
					end,
				},
			})

			-- Autocomando para ajustar el tamaño de fuente en ventanas flotantes de Oil
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "oil",
				callback = function()
					if vim.api.nvim_win_get_config(0).relative ~= "" then
						vim.wo[0].winhighlight = "Normal:Normal,EndOfBuffer:Normal"
						-- Opcional: ajustar spacing si es necesario
						vim.wo[0].linebreak = true
					end
				end,
			})

			--      vim.keymap.set("n", "<space>'", "<CMD>Oil<CR>", { desc = "Open parent directory" })
			vim.keymap.set("n", "<space>,", require("oil").toggle_float, { desc = "Open oil float" })
		end,
	},
}
