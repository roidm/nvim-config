return {

	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
					border = "rounded",
				},
				install_root_dir = vim.fn.stdpath("data") .. "/mason",
				pip = { upgrade_pip = false },
				log_level = vim.log.levels.INFO,
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local mason_lspconfig = require("mason-lspconfig")

			local servers = {
				-- Web
				"html",
				"ts_ls",
				"eslint",
				"jsonls",
				"tailwindcss",
				"svelte",
				"astro",
				-- Backend
				"pyright",
				"rust_analyzer",
				"gopls",
				"jdtls",
				"kotlin_language_server",
				-- Sistemas/Config
				"lua_ls",
				"bashls",
				"yamlls",
				"taplo",
				"dockerls",
				"docker_compose_language_service",
				-- Markdown/Docs
				"marksman",
				"texlab",
			}

			mason_lspconfig.setup({
				ensure_installed = servers,
				automatic_installation = true,
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
			"saghen/blink.cmp", -- integración con blink
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")

			-- Capacidades para blink
			local capabilities = vim.tbl_deep_extend(
				"force",
				vim.lsp.protocol.make_client_capabilities(),
				require("blink.cmp").get_lsp_capabilities()
			)

			-- Configuración de diagnósticos
			vim.diagnostic.config({
				underline = true,
				virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				update_in_insert = false,
				severity_sort = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					---@diagnostic disable-next-line: assign-type-mismatch
					source = "always",
					header = "",
					prefix = "",
				},
			})

			-- on_attach genérico
			local function on_attach(client, bufnr)
				if client.name == "ts_ls" or client.name == "html" then
					client.server_capabilities.documentFormattingProvider = false
				end

				if client.server_capabilities.documentHighlightProvider then
					local lsp_group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
					vim.api.nvim_clear_autocmds({ group = lsp_group, buffer = bufnr })

					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						group = lsp_group,
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd("CursorMoved", {
						group = lsp_group,
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end

				if client.server_capabilities.semanticTokensProvider then
					vim.lsp.semantic_tokens.start(bufnr, client.id)
				end

				local function map(mode, lhs, rhs, opts)
					opts = opts or {}
					opts.silent = opts.silent ~= false
					vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { buffer = bufnr }, opts))
				end

				-- Core LSP
				map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
				map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
				map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
				map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
				map("n", "gr", vim.lsp.buf.references, { desc = "References" })
				map("n", "gs", vim.lsp.buf.signature_help, { desc = "Signature Help" })
				map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
				map("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
				map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
				map("n", "<leader>cf", function()
					vim.lsp.buf.format({ async = true })
				end, { desc = "Format Document" })
				map("v", "<leader>cf", function()
					vim.lsp.buf.format({ async = true })
				end, { desc = "Format Selection" })
			end

			-- Configuración por servidor
			local server_configs = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
							diagnostics = {
								globals = {
									"vim",
									"use",
									"describe",
									"it",
									"assert",
									"before_each",
									"after_each",
									"pending",
								},
							},
							workspace = {
								checkThirdParty = false,
								library = {
									vim.env.VIMRUNTIME,
									"${3rd}/luv/library",
									"${3rd}/busted/library",
									"${3rd}/luassert/library",
								},
								maxPreload = 100000,
								preloadFileSize = 10000,
							},
							completion = { callSnippet = "Replace", postfix = ".", showWord = "Fallback" },
							telemetry = { enable = false },
							hint = { enable = true },
							codeLens = { enable = true },
							format = { enable = false },
						},
					},
				},
				ts_ls = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "workspace",
								useLibraryCodeForTypes = true,
								typeCheckingMode = "basic",
							},
						},
					},
				},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true, loadOutDirsFromCheck = true, runBuildScripts = true },
							checkOnSave = { allFeatures = true, command = "clippy", extraArgs = { "--no-deps" } },
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
				jsonls = {
					settings = {
						json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } },
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = { enable = false, url = "" },
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
				tailwindcss = {
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									"tw`([^`]*)",
									'tw="([^"]*)',
									'tw={"([^"}]*)',
									"tw\\.\\w+`([^`]*)",
									"tw\\(.*?\\)`([^`]*)",
									{ "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
									{ "classnames\\(([^)]*)\\)", "'([^']*)'" },
									{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								},
							},
						},
					},
				},
			}

			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(server_configs), automatic_installation = true })

			for server_name, server_opts in pairs(server_configs) do
				local config =
					vim.tbl_deep_extend("force", { on_attach = on_attach, capabilities = capabilities }, server_opts)
				lspconfig[server_name].setup(config)
			end
		end,
	},
}
