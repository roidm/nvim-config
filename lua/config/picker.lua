-- lua/config/picker.lua
local snacks = require("snacks")
local M = {}

-- Tabla de dotfiles fija
local dotfiles = {
	{ "init.lua (nvim)", "~/.config/nvim/init.lua" },
	{ "keymaps.lua (nvim)", "~/.config/nvim/lua/config/keymaps.lua" },
	{ "Hyprland config", "~/.config/hypr/hyprland.conf" },
	{ "Niri config", "~/.config/niri/config.kdl" },
	{ "Sway config", "~/.config/sway/config" },
	{ "Mango config", "~/.config/mango/config.conf" },
	{ "Waybar config", "~/.config/waybar/config.json" },
	{ "Waybar style", "~/.config/waybar/style.css" },
	{ "foot", "~/.config/foot/foot.ini" },
	{ "Wezterm", "~/.config/wezterm/wezterm.lua" },
	{ "zshrc", "~/.config/zsh/.zshrc" },
}

-- Función genérica para crear pickers
function M.create_picker(opts)
	opts = opts or {}
	local items = {}

	-- 1️⃣ agregar ficheros manuales
	if opts.files then
		for _, f in ipairs(opts.files) do
			table.insert(items, {
				text = f[1],
				desc = f[2],
				file = f[2],
				action = function()
					if opts.open_cmd then
						opts.open_cmd(f[2])
					else
						vim.cmd.edit(vim.fn.expand(f[2]))
					end
				end,
			})
		end
	end

	-- 2️⃣ escanear directorios
	if opts.dirs then
		local seen = {}
		for _, dir in ipairs(opts.dirs) do
			local handle = io.popen("find " .. dir .. " -type f 2>/dev/null")
			if handle then
				for path in handle:lines() do
					if (not opts.filter or opts.filter(path)) and not seen[path] then
						seen[path] = true
						local name = path:match("^.+/(.+)$")
						if opts.name_prefix then
							name = opts.name_prefix .. name
						end
						table.insert(items, {
							text = name,
							desc = path,
							file = path,
							action = function()
								if opts.open_cmd then
									opts.open_cmd(path)
								else
									vim.cmd.edit(vim.fn.expand(path))
								end
							end,
						})
					end
				end
				handle:close()
			end
		end
	end

	-- lanzar picker
	snacks.picker({ items = items })
end

-- 📌 Picker de dotfiles
function M.dotfiles_picker()
	M.create_picker({
		files = dotfiles,
		dirs = { vim.fn.expand("~/.config/nvim") },
		filter = function(path)
			return path:match("%.lua$")
		end,
		name_prefix = "[nvim] ",
	})
end

-- 📌 Picker de media
function M.media_picker()
	M.create_picker({
		dirs = { vim.fn.expand("~/Pictures"), vim.fn.expand("~/work/varios/cosas") },
		filter = function(path)
			local dirs_to_exclude = { "bigb", "tar", "pics", "mpv" }
			for _, dir_name in ipairs(dirs_to_exclude) do
				if path:match("work/varios/cosas/" .. dir_name .. "/") then
					return false -- Retorna falso para excluir el archivo
				end
			end
			return path:match("%.png$")
				or path:match("%.jpg$")
				or path:match("%.webp$")
				or path:match("%.gif$")
				or path:match("%.mp4$")
		end,
		name_prefix = "[Media] ",
		open_cmd = function(path)
			vim.fn.system({ "xdg-open", path })
		end,
	})
end
return M
