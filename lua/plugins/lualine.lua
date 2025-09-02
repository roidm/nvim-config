return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/tokyonight.nvim",
		"folke/trouble.nvim",
		"nvim-neotest/nvim-nio",
	},
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			vim.o.statusline = " "
		else
			vim.o.laststatus = 0
		end
	end,
	opts = function()
		local icons = require("config.icons")
		local Util = require("config.util")
		local snacks_util = require("snacks.util")

		vim.o.laststatus = vim.g.lualine_laststatus

		-- Cache para evitar múltiples require en cada refresh
		local theme_cache = {}
		local function get_theme_colors()
			if theme_cache.colors then
				return theme_cache.colors
			end

			local tn_colors = require("tokyonight.colors").setup({ style = "night" })
			local ok, tema_module = pcall(require, "theme")
			if not ok then
				ok, tema_module = pcall(require, "config.theme")
			end

			if ok and tema_module.colors then
				theme_cache.colors = tema_module.colors
			else
				theme_cache.colors = {
					bg = "#16161E",
					fg = tn_colors.fg,
					pink = tn_colors.magenta,
					purple = tn_colors.purple,
					blue = tn_colors.blue,
					orange = tn_colors.orange,
					red = tn_colors.red,
					cyan = tn_colors.cyan,
					teal = "#2AC3DE",
					green = tn_colors.green,
					bg_dark = tn_colors.bg_dark,
					fg_dark = tn_colors.fg_dark,
				}
			end
			return theme_cache.colors
		end

		local colors = get_theme_colors()

		-- Crear tema de forma más eficiente
		local function create_mode_theme(accent_color)
			return {
				a = { bg = accent_color, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			}
		end

		local theme = {
			normal = create_mode_theme(colors.orange),
			command = create_mode_theme(colors.orange),
			visual = create_mode_theme(colors.red),
			insert = create_mode_theme(colors.cyan),
			replace = create_mode_theme(colors.red),
			inactive = {
				a = { bg = colors.bg_dark, fg = colors.fg_dark },
				b = { bg = colors.bg_dark, fg = colors.fg_dark },
				c = { bg = colors.bg_dark, fg = colors.fg_dark },
			},
		}

		-- Funciones optimizadas con cache local
		local function capitalize(str)
			return str:sub(1, 1):upper() .. str:sub(2):lower()
		end

		-- Cache para componentes costosos
		local component_cache = {
			noice_cmd = "",
			noice_mode = "",
			dap_status = "",
			last_update = 0,
		}

		local function get_cached_component(key, getter, ttl)
			ttl = ttl or 100 -- ms
			local now = vim.loop.now()
			if now - component_cache.last_update > ttl then
				component_cache[key] = getter()
				component_cache.last_update = now
			end
			return component_cache[key]
		end

		local function noice_cmd()
			return get_cached_component("noice_cmd", function()
				local ok, noice = pcall(require, "noice")
				return ok and noice.api.status.command.has() and noice.api.status.command.get() or ""
			end)
		end

		local function noice_mode()
			return get_cached_component("noice_mode", function()
				local ok, noice = pcall(require, "noice")
				return ok and noice.api.status.mode.has() and noice.api.status.mode.get() or ""
			end)
		end

		local function dap_status()
			return get_cached_component("dap_status", function()
				local ok, dap = pcall(require, "dap")
				return ok and dap.status() ~= "" and "  " .. dap.status() or ""
			end)
		end

		-- Colores pre-calculados
		local color_cache = {}
		local function get_color(name)
			if not color_cache[name] then
				color_cache[name] = { fg = snacks_util.color(name) }
			end
			return color_cache[name]
		end

		return {
			options = {
				theme = theme,
				globalstatus = vim.o.laststatus == 3,
				disabled_filetypes = {
					statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
				},
				component_separators = "",
				section_separators = "",
				refresh = {
					statusline = 200, -- Reducir frecuencia de refresh
					tabline = 200,
					winbar = 200,
				},
			},
			sections = {
				lualine_a = {
					{ "mode", fmt = capitalize },
				},
				lualine_b = {
					{
						"branch",
						color = { fg = colors.orange, bg = colors.bg }, -- <--- verde
					},
				},
				lualine_c = {
					Util.root_dir(),
					{
						"diagnostics",
						symbols = {
							error = icons.diagnostics.Error,
							warn = icons.diagnostics.Warn,
							info = icons.diagnostics.Info,
							hint = icons.diagnostics.Hint,
						},
						update_in_insert = false, -- No actualizar en modo insert
					},
					{
						Util.pretty_path(),
						cond = function()
							return vim.fn.winwidth(0) > 80 -- Solo mostrar en ventanas anchas
						end,
					},
				},
				lualine_x = {
					{
						noice_cmd,
						cond = function()
							return noice_cmd() ~= ""
						end,
						color = function()
							return get_color("Statement")
						end,
					},
					{
						dap_status,
						cond = function()
							return dap_status() ~= ""
						end,
						color = function()
							return get_color("Debug")
						end,
					},
					{
						noice_mode,
						cond = function()
							return noice_mode() ~= ""
						end,
						color = function()
							return get_color("Constant")
						end,
					},
					{
						require("lazy.status").updates,
						cond = require("lazy.status").has_updates,
						color = function()
							return get_color("Special")
						end,
					},
					{
						"diff",
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
						source = function()
							local gitsigns = vim.b.gitsigns_status_dict
							if gitsigns then
								return {
									added = gitsigns.added,
									modified = gitsigns.changed,
									removed = gitsigns.removed,
								}
							end
						end,
						cond = function()
							return vim.fn.winwidth(0) > 60 -- Solo mostrar en ventanas medianas
						end,
						color = { fg = colors.green, bg = colors.bg }, -- <--- aquí forzamos verde
					},
					{
						"filetype",
						padding = { left = 1, right = 1 },
						cond = function()
							return vim.fn.winwidth(0) > 70
						end,
					},
				},
				lualine_y = {
					{
						"location",
						padding = { left = 0, right = 1 },
						color = { bg = colors.bg, fg = colors.teal },
					},
					{
						"progress",
						padding = { left = 0, right = 1 },
						color = { bg = colors.bg, fg = colors.teal },
					},
				},
				lualine_z = {
					{
						function()
							return os.date("%R")
						end,
						cond = function()
							return vim.fn.winwidth(0) > 50
						end,
					},
				},
			},
			extensions = { "neo-tree", "lazy", "fzf" },
		}
	end,
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}
