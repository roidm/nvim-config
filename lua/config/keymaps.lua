-- lua/config/keymaps.lua

---@diagnostic disable: unused-local
-- Mapeos básicos y de movimiento
vim.keymap.set("n", "<S-Left>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Down>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Up>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Right>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Mapeos para comentarios de código
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

-- Función de terminal flotante
function OpenCenteredInteractiveTerm()
	-- Tu función completa aquí...
end
vim.keymap.set("n", "<leader>T", OpenCenteredInteractiveTerm, { desc = "Floating Interactive Terminal" })

-- Requerir los módulos de plugins
local wk = require("which-key")
local picker = require("config.picker")
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

-- Mapeos organizados con which-key
wk.add({
	-- Categorías de atajos
	{ "<leader>c", group = "Code" },
	{ "<leader>f", group = "Files" },
	--	{ "<leader>q", group = "Quit" },
	{ "<leader>w", group = "Windows" },
	{ "<leader>b", group = "Buffers" },
	{ "<leader>p", group = "Pickers" },
	{ "<leader>t", group = "Telescope" },
	{ "<leader>s", group = "Snacks" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>g", group = "Git" },
	{ "<leader>u", group = "Toggles" },

	-- Atajos específicos de Telescope, organizados bajo <leader>t
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
	{
		"<leader>te",
		function()
			local opts = require("telescope.themes").get_ivy({
				cwd = vim.fn.stdpath("config"),
			})
			builtin.find_files(opts)
		end,
		desc = "Edit Nvim config",
	},

	-- Navegador de archivos con Telescope
	{
		"<leader>.",
		function()
			local opts = require("telescope.themes").get_ivy({
				layout_config = {
					height = 0.33, -- Altura de la ventana (33% de la pantalla)
				},
				path = "%:p:h",
				grouped = true,
				previewer = true,
				initial_mode = "normal",
				mappings = {
					n = {
						["h"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
						["l"] = require("telescope.actions").select_default,
						["-"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
						["q"] = require("telescope.actions").close,
					},
				},
			})
			require("telescope").extensions.file_browser.file_browser(opts)
		end,
		desc = "Browse Files",
	},
	{
		"<leader>fe",
		function()
			local opts = require("telescope.themes").get_ivy({
				layout_config = {
					height = 0.33, -- Altura de la ventana (33% de la pantalla)
				},
				sorting_strategy = "ascending",
				path = "%:p:h",
				grouped = true,
				previewer = true,
				initial_mode = "normal",
				mappings = {
					n = {
						["h"] = fb_actions.goto_parent_dir,
						["l"] = actions.select_default,
						["-"] = fb_actions.goto_parent_dir,
						["q"] = actions.close,
					},
				},
			})
			require("telescope").extensions.file_browser.file_browser(opts)
		end,
		desc = "File browser",
	},

	-- Atajo para Nvim directory
	{
		"<leader>fc",
		function()
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
		end,
		desc = "Nvim directory",
	},

	-- Atajo para Nvim config files
	{
		"<leader>fn", -- Cambiado de 'fn' a 'fN'
		function()
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
		end,
		desc = "Find nvim config files",
	},

	--Pickers
	{ "<leader>p", group = "Pickers" },
	{ "<leader>d", picker.dotfiles_picker, desc = "Edit dotfiles" },
	{ "<leader>M", picker.media_picker, desc = "Show Pictures" },
	{ "<leader>pd", picker.dotfiles_picker, desc = "Edit dotfiles" },
	{ "<leader>pm", picker.media_picker, desc = "Show Pictures" },

	-- Otros atajos
	{ "<leader>S", "<cmd>w<CR>", desc = "Save file" },
	{ "<leader>r", "<cmd>lua Snacks.picker.recent()<CR>", desc = "Recent Files" },
	{
		"<leader>st",
		"<cmd>lua require('snacks.terminal').open(nil, {win = {split = 'below'}})<CR>",
		desc = "Snacks terminal below",
	},
	{ "<leader>fN", "<cmd>enew<CR>", desc = "Create new file" },

	-- Búsqueda y reemplazo
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
					vim.ui.input({ prompt = "Reemplazar todo (a) o ir uno por uno (i)? [a/i]: " }, function(choice)
						if choice == nil then
							return
						end
						local command = ""
						if choice == "i" or choice == "I" then
							command = "%s/" .. find .. "/" .. replace .. "/gc"
						else
							command = "%s/" .. find .. "/" .. replace .. "/g"
						end
						vim.cmd(command)
					end)
				end)
			end)
		end,
		desc = "Search & Replace",
	},

	-- Atajos LSP
	{ "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to Declaration" },
	{ "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition" },
	{ "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover Documentation" },
	{ "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go to References" },
	{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },

	-- Otros atajos
	{ "<Tab>", "<cmd>tabnext<CR>", desc = "Next tab" },
	{ "<S-Tab>", "<cmd>tabprevious<CR>", desc = "Previous tab" },
	{ "<F5>", "<cmd>Alpha<CR>", desc = "Open Dashboard" },

	-- Manejo de ventanas
	{ "<leader>wh", "<C-w>h", desc = "Move to left window" },
	{ "<leader>wj", "<C-w>j", desc = "Move to lower window" },
	{ "<leader>wk", "<C-w>k", desc = "Move to upper window" },
	{ "<leader>wl", "<C-w>l", desc = "Move to right window" },
	{ "<leader>wv", "<cmd>vsp<CR>", desc = "Split window vertically" },
	{ "<leader>ws", "<cmd>sp<CR>", desc = "Split window horizontally" },
	{ "<leader>wo", "<cmd>only<CR>", desc = "Close all other windows" },
	{ "<leader>wc", "<cmd>q<CR>", desc = "Close current window" },

	-- Lazy
	{ "<leader>L", "<cmd>Lazy<CR>", desc = "Open Lazy" },

	-- Buffers
	{ "<leader>bc", "<cmd>bdelete<CR>", desc = "Close buffer" },
	{
		"<leader>,",
		function()
			require("telescope.builtin").buffers(require("telescope.themes").get_ivy({
				layout_config = {
					height = 0.33, -- Altura de la ventana (60% de la pantalla)
				},
				sorting_strategy = "ascending",
				ignore_current_buffer = false,
				previewer = true,
			}))
		end,
		desc = "List buffers (Ivy)",
	},
	{ "<leader>bn", "<cmd>bnext<CR>", desc = "Next buffer" },
	{ "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous buffer" },

	-- Salir
	--	{ "<leader>qq", "<cmd>qa<CR>", desc = "Quit Neovim" },
	--	{ "<leader>qw", "<cmd>wq<CR>", desc = "Save and Quit" },
})
