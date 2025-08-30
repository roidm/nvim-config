---@class config.util.lualine
local M = {}

---@param component any
---@param text string
---@param hl_group? string
---@return string
function M.format(component, text, hl_group)
  text = text:gsub("%%", "%%%%")
  if not hl_group or hl_group == "" then return text end
  component.hl_cache = component.hl_cache or {}
  local lualine_hl_group = component.hl_cache[hl_group]
  if not lualine_hl_group then
    local utils = require("lualine.utils.utils")
    local gui = vim.tbl_filter(function(x) return x end, {
      utils.extract_highlight_colors(hl_group, "bold") and "bold",
      utils.extract_highlight_colors(hl_group, "italic") and "italic",
    })
    lualine_hl_group = component:create_hl({
      fg = utils.extract_highlight_colors(hl_group, "fg"),
      gui = #gui > 0 and table.concat(gui, ",") or nil,
    }, "LV_" .. hl_group)
    component.hl_cache[hl_group] = lualine_hl_group
  end
  return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

---@param opts? {icon?:string, color?:fun():table}
function M.root_dir(opts)
  opts = vim.tbl_extend("force", {
    icon = "",
    color = function() return { fg = require("snacks.util").color("Special") } end,
  }, opts or {})

  return {
    function()
      local path = vim.fn.expand("%:p:h") -- directorio del archivo actual
      if path == "" then return "" end
      local name = vim.fn.fnamemodify(path, ":t")
      return opts.icon .. " " .. name
    end,
    cond = function() return vim.fn.expand("%:p:h") ~= "" end,
    color = opts.color,
  }
end

---@param opts? {filename_hl?:string, modified_hl?:string, modified_sign?:string}
function M.pretty_path(opts)
  opts = vim.tbl_extend("force", {
    filename_hl = "Bold",
    modified_hl = "MatchParen",
    modified_sign = " [+]",
  }, opts or {})

  return function(self)
    local name = vim.fn.expand("%:t")
    if name == "" then return "" end
    if vim.bo.modified then
      name = M.format(self, name .. opts.modified_sign, opts.modified_hl)
    else
      name = M.format(self, name, opts.filename_hl)
    end
    return name
  end
end

return M
