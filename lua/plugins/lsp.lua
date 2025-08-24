-- lua/plugins/lsp.lua
return {
	-- Mason: gestor de binarios (LSP, linters, formatters)
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason-LSPconfig: puente entre mason y lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = { "lua_ls" }, -- instala el LSP de Lua
			automatic_installation = true,
		},
	},

	-- nvim-lspconfig: configuración de servidores LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			local lspconfig = require("lspconfig")

			-- Ajustes básicos de diagnósticos
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				update_in_insert = false,
				severity_sort = true,
			})

			-- Apaga los LSP clientes al salir de Neovim (evita procesos huérfanos)
			vim.api.nvim_create_autocmd("VimLeavePre", {
				callback = function()
					vim.lsp.stop_client(vim.lsp.get_active_clients())
				end,
			})

			-- Config optimizada para lua_ls
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							checkThirdParty = false, -- evita advertencias innecesarias
							library = vim.api.nvim_get_runtime_file("", true),
							ignoreDir = { "node_modules", ".git", "dist" }, -- no indexar basura
						},
						completion = {
							callSnippet = "Disable", -- menos carga en completado
						},
						telemetry = { enable = false },
					},
				},
			})
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			-- Añade estos mapeos en tu archivo de configuración (init.lua)

			-- Mapeos para el LSP
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
			vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "LSP Definition" })
			vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP Hover" })
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "LSP References" })
			vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "LSP Rename" })
			vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })

			-- Mapeos para diagnósticos
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open Diagnostic" })
		end,
	},
}
