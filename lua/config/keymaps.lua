-- lua/config/keymaps.lua

vim.keymap.set("n", "<S-Left>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Down>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Up>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Right>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

vim.keymap.set("v", "<leader>-", ":-:normal! I--<CR>", {
	noremap = true,
	silent = true,
	desc = "Add -- to selected lines",
})

vim.keymap.set("v", "<leader>;", ":'<,'>normal! I;; <CR>", {
	noremap = true,
	silent = true,
	desc = "Add ;; to selected lines",
})

local wk = require("which-key")
local picker = require("config.picker")

wk.add({
	-- Global keymaps
	{ "<leader>.", "<cmd>Telescope file_browser<CR>", desc = "File Browser" },
	{ "<leader>S", "<cmd>w<CR>", desc = "Save file" },
	{ "<leader>c", group = "Code" },
	{ "<leader>f", group = "Files" },
	{ "<leader>q", group = "Quit" },

	{ "<leader>r", "<cmd>lua Snacks.picker.recent()<CR>", desc = "Recent Files" },
	-- Telescope
	{ "<leader>t", group = "Telescope" },
	{ "<leader>tf", "<cmd>Telescope find_files<CR>", desc = "Find Files" },
	{ "<leader>tg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },
	{ "<leader>tr", "<cmd>Telescope oldfiles<CR>", desc = "Recent Files" },
	{ "<leader>tb", "<cmd>Telescope buffers<CR>", desc = "List Buffers" },
	{ "<leader>tl", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
	{ "<leader>tL", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace Symbols" },
	{ "<leader>tgs", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
	{ "<leader>tgc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
	{ "<leader>tgb", "<cmd>Telescope git_branches<CR>", desc = "Git Branches" },
	{ "<leader>td", "<cmd>Telescope diagnostics<CR>", desc = "Diagnostics" },
	{ "<leader>tm", "<cmd>Telescope marks<CR>", desc = "Marks" },
	{ "<leader>th", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },
	{ "<leader>tc", "<cmd>Telescope commands<CR>", desc = "Commands" },
	{ "<leader>tk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
	{ "<leader>tt", "<cmd>Telescope treesitter<CR>", desc = "Treesitter Symbols" },
	{ "<leader>tC", "<cmd>Telescope colorscheme<CR>", desc = "Colorscheme" },

	{ "<leader>P", group = "Pickers" },
	{ "<leader>d", picker.dotfiles_picker, desc = "Edit dotfiles" },
	{ "<leader>M", picker.media_picker, desc = "Show Pictures" },
	{ "<leader>Pd", picker.dotfiles_picker, desc = "Edit dotfiles" },
	{ "<leader>Pm", picker.media_picker, desc = "Show Pictures" },

	-- Search word con Telescope
	{ "<leader>st", "<cmd>Telescope live_grep<CR>", desc = "Search word" },

	-- Search & Replace con prompt
	{
		"<leader>sr",
		function()
			vim.ui.input({ prompt = "Buscar: " }, function(find)
				if not find or find == "" then
					return
				end
				vim.ui.input({ prompt = "Reemplazar con: " }, function(replace)
					if replace == nil then
						return
					end

					-- Nuevo prompt para elegir el modo de reemplazo
					vim.ui.input({ prompt = "Reemplazar todo (a) o ir uno por uno (i)? [a/i]: " }, function(choice)
						if choice == nil then
							return
						end

						local command = ""
						if choice == "i" or choice == "I" then
							-- Opción interactiva: añade la bandera 'c' para confirmar cada reemplazo
							command = "%s/" .. find .. "/" .. replace .. "/gc"
						else
							-- Opción por defecto: reemplaza todas las coincidencias
							command = "%s/" .. find .. "/" .. replace .. "/g"
						end

						-- Ejecuta el comando
						vim.cmd(command)
					end)
				end)
			end)
		end,
		desc = "Search & Replace",
	},

	-- Keymaps for LSP (Language Server Protocol)
	{ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to Declaration" },
	{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition" },
	{ "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover Documentation" },
	{ "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go to References" },
	{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },

	{ "<Tab>", "<cmd>tabnext<CR>", desc = "Next tab" },
	{ "<S-Tab>", "<cmd>tabprevious<CR>", desc = "Previous tab" },

	-- Dashboard Keymaps
	{ "<F5>", "<cmd>Alpha<CR>", desc = "Open Dashboard" },

	--{ "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
	{ "<leader>fn", "<cmd>enew<CR>", desc = "Create new file" },

	-- window management
	{ "<leader>w", group = "Windows" },
	{ "<leader>wh", "<C-w>h", desc = "Move to left window" },
	{ "<leader>wj", "<C-w>j", desc = "Move to lower window" },
	{ "<leader>wk", "<C-w>k", desc = "Move to upper window" },
	{ "<leader>wl", "<C-w>l", desc = "Move to right window" },
	{ "<leader>wv", "<cmd>vsp<CR>", desc = "Split window vertically" },
	{ "<leader>ws", "<cmd>sp<CR>", desc = "Split window horizontally" },
	{ "<leader>wo", "<cmd>only<CR>", desc = "Close all other windows" },
	{ "<leader>wc", "<cmd>q<CR>", desc = "Close current window" },

	-- Lazy Keymaps
	{ "<leader>L", "<cmd>Lazy<CR>", desc = "Open Lazy" },

	-- Buffers
	{ "<leader>b", group = "Buffers" },
	{ "<leader>bc", "<cmd>bdelete<CR>", desc = "Close buffer" },
	{ "<leader>bl", "<cmd>Telescope buffers<CR>", desc = "List buffers" },
	{ "<leader>bn", "<cmd>bnext<CR>", desc = "Next buffer" },
	{ "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous buffer" },

	-- Quit
	{ "<leader>q", group = "Quit" },
	{ "<leader>qq", "<cmd>qa<CR>", desc = "Quit Neovim" },
	{ "<leader>qw", "<cmd>wq<CR>", desc = "Save and Quit" },
})
