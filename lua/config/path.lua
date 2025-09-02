local M = {}

-- Función auxiliar: solo agregar al PATH si existe
local function add_to_path(dir)
	---@diagnostic disable-next-line: undefined-field
	local ok = vim.loop.fs_stat(dir) -- comprueba si la carpeta existe
	if ok then
		vim.env.PATH = dir .. ":" .. vim.env.PATH
	end
end

function M.setup()
	local home = os.getenv("HOME")

	-- Carpetas de binarios personalizadas
	local bin_paths = {
		vim.fn.stdpath("data") .. "/mason/bin", -- Mason
		home .. "/.local/node/bin", -- Node
		home .. "/.local/go/bin", -- Go
	}

	-- Agregar cada ruta al PATH solo si existe
	for _, path in ipairs(bin_paths) do
		add_to_path(path)
	end

	-- Variables específicas de cada runtime
	---@diagnostic disable-next-line: undefined-field
	if vim.loop.fs_stat(home .. "/.local/node/lib/node_modules") then
		vim.env.NODE_PATH = home .. "/.local/node/lib/node_modules"
	end

	if vim.loop.fs_stat(home .. "/.local/go") then
		vim.env.GOPATH = home .. "/.local/go"
	end
end

return M
