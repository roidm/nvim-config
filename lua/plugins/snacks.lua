return {
	{
		"folke/snacks.nvim",
		-- Optimización: Lazy loading para startup rápido
		event = "VeryLazy",
		opts = {
			dashboard = {
				enabled = false, -- Activado, pero optimizado para velocidad
			},
			image = { enabled = false }, -- Deshabilitado para menos overhead
			bigfile = { enabled = false },
			explorer = {
				enabled = true,
				show_hidden = true,
				keys = { h = nil }, -- Mantén tu custom
			},
			indent = { enabled = false },
			input = { enabled = false },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			picker = {
				enabled = true,
				projects = {
					"work/github",
					"work/wayland",
				},
			},
			quickfile = { enabled = false },
			scope = { enabled = false },
			scroll = { enabled = false },
			statuscolumn = { enabled = false },
			words = { enabled = false },
			styles = {
				notification = {},
			},
		},

    -- stylua: ignore
    keys = {
      {	"<leader><space>", function()	Snacks.picker.smart() end, desc = "Smart Find Files",	},
      {	"<leader>s,",	function() Snacks.picker.buffers()	end, desc = "Buffers", },
      {	"<leader>s/",	function() Snacks.picker.grep() end, desc = "Grep", },
      {	"<leader>:",	function() Snacks.picker.command_history() end,	desc = "Command History",	},
      {	"<leader>e",  function() Snacks.explorer() end,	desc = "File Explorer",	},

      -- find
      {	"<leader>b",  function() Snacks.picker.buffers()	end, desc = "Buffers", },
      {	"<leader>pc",	function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,	desc = "Find Config File", },
      {	"<leader>pf",	function() Snacks.picker.files() end,	desc = "Find Files", },
      {	"<leader>pp",	function() Snacks.picker.projects()	end,	desc = "Projects", },
      {	"<leader>pr",	function() Snacks.picker.recent()	end, desc = "Recent",	},
      -- search

      {	'<leader>s"',	function() Snacks.picker.registers() end,	desc = "Registers",	},
      {	"<leader>s/",	function() Snacks.picker.search_history()	end, desc = "Search History",	},
      {	"<leader>sa", function() Snacks.picker.autocmds()	end, desc = "Autocmds",		},
      {	"<leader>sb",	function() Snacks.picker.lines() end,	desc = "Buffer Lines", },
      {	"<leader>sc",	function() Snacks.picker.command_history() end, desc = "Command History",	},
      { "<leader>sC",	function() Snacks.picker.commands()	end, desc = "Commands",	},
      {	"<leader>sd", function() Snacks.picker.diagnostics() end,	desc = "Diagnostics",	},
      {	"<leader>sD",	function() Snacks.picker.diagnostics_buffer()	end, desc = "Buffer Diagnostics",	},
      {	"<leader>sh",	function() Snacks.picker.help()	end, desc = "Help Pages",	},
      {	"<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights",	},
      {	"<leader>si",	function() Snacks.picker.icons() end,	desc = "Icons",	},
      {	"<leader>sj",	function() Snacks.picker.jumps() end,	desc = "Jumps",	},
      {	"<leader>sk",	function() Snacks.picker.keymaps() end,	desc = "Keymaps",	},
      { "<leader>sl",	function() Snacks.picker.loclist() end,	desc = "Location List",	},
      {	"<leader>sm",	function() Snacks.picker.marks()	end,	desc = "Marks",	},
      { "<leader>sp",	function() Snacks.picker.lazy()	end, desc = "Search for Plugin Spec",	},
      {	"<leader>sq",	function() Snacks.picker.qflist()	end,	desc = "Quickfix List",	},
      {	"<leader>sR",	function() Snacks.picker.resume()	end,	desc = "Resume",	},
      {	"<leader>su",	function() Snacks.picker.undo()	end,	desc = "Undo History", },
      {	"<leader>tC",	function() Snacks.picker.colorschemes()	end, desc = "Colorschemes",	},
      -- LSP
      {	"gd",       	function() Snacks.picker.lsp_definitions() end,	desc = "Goto Definition",	},
      { "gD", 				function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration",	},
      {	"gI", 				function() Snacks.picker.lsp_implementations() end,	desc = "Goto Implementation",	},
      {	"gy", 				function() Snacks.picker.lsp_type_definitions()	end, desc = "Goto T[y]pe Definition",	},
      {	"<leader>ss",	function() Snacks.picker.lsp_symbols() end,	desc = "LSP Symbols",	},
      {	"<leader>sS",	function() Snacks.picker.lsp_workspace_symbols() end,	desc = "LSP Workspace Symbols",	},
      -- Other
      {	"<leader>n",	function() Snacks.notifier.show_history()	end, desc = "Notification History",	},
      {	"<leader>bd",	function() Snacks.bufdelete()	end, desc = "Delete Buffer",	},
      {	"<leader>cR",	function() Snacks.rename.rename_file() end,	desc = "Rename File",	},
      {	"<leader>gg",	function() Snacks.lazygit()	end, desc = "Lazygit", },
      {	"<leader>gl",	function() require("snacks").lazygit.log() end, desc = "Lazygit Logs", },
      { "<leader>tn",	function() Snacks.notifier.hide()	end, desc = "Dismiss All Notifications", },
      {	"<c-/>",  		function() Snacks.terminal() end,	desc = "Toggle Terminal",	},
    },
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Globals y toggles
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd

					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tL")
					Snacks.toggle.diagnostics():map("<leader>td")
					Snacks.toggle.line_number():map("<leader>tl")
					Snacks.toggle
						.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
						:map("<leader>tc")
					Snacks.toggle.treesitter():map("<leader>tT")
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "Dark Background" })
						:map("<leader>tb")
					Snacks.toggle.inlay_hints():map("<leader>th")
					Snacks.toggle.indent():map("<leader>tg")
					Snacks.toggle.dim():map("<leader>tD")
				end,
			})
		end,
	},
}
