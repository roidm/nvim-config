return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
    "folke/trouble.nvim",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "echasnovski/mini.icons",
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
    local icons        = require("config.icons")
    local Util         = require("config.util")
    local catppuccin   = require("catppuccin.palettes").get_palette() -- paleta Mocha automáticamente

    vim.o.laststatus   = vim.g.lualine_laststatus

    -- Tema Catppuccin base
    local theme        = require("lualine.themes.catppuccin")

    -- Swap dinámico de colores normal <-> command
    local normal_bg    = theme.normal.a.bg
    local command_bg   = catppuccin.peach
    local visual_bg    = catppuccin.red
    local insert_bg    = catppuccin.sapphire
    theme.normal.a.bg  = command_bg
    theme.command.a.bg = normal_bg
    theme.visual.a.bg  = visual_bg
    theme.insert.a.bg  = insert_bg

    -- Función para capitalizar primera letra
    local capitalize   = function(str)
      return str:sub(1, 1):upper() .. str:sub(2):lower()
    end

    local opts_table   = {
      options = {
        theme                = theme,
        globalstatus         = vim.o.laststatus == 3,
        disabled_filetypes   = { statusline = { "dashboard", "alpha", "ministarter" } },
        component_separators = "",
        section_separators   = "",
      },
      sections = {
        lualine_a = { { "mode", fmt = capitalize } },
        lualine_b = { "branch" },
        lualine_c = {
          Util.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn  = icons.diagnostics.Warn,
              info  = icons.diagnostics.Info,
              hint  = icons.diagnostics.Hint,
            },
          },
          { Util.pretty_path() },
        },
        lualine_x = {
          {
            ---@diagnostic disable-next-line: undefined-field
            function() return require("noice").api.status.command.get() end,
            ---@diagnostic disable-next-line: undefined-field
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return { fg = require("snacks.util").color("Statement") } end,
          },
          {
            ---@diagnostic disable-next-line: undefined-field
            function() return require("noice").api.status.mode.get() end,
            ---@diagnostic disable-next-line: undefined-field
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = require("snacks.util").color("Constant") } end,
          },
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = require("snacks.util").color("Debug") } end,
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = require("snacks.util").color("Special") } end,
          },
          {
            "diff",
            symbols = {
              added    = icons.git.added,
              modified = icons.git.modified,
              removed  = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added    = gitsigns.added,
                  modified = gitsigns.changed,
                  removed  = gitsigns.removed,
                }
              end
            end,
          },
          { "filetype", padding = { left = 1, right = 1 } },
        },
        lualine_y = {
          { "location", padding = { left = 0, right = 1 }, color = { bg = catppuccin.mantle }, },
          { "progress", padding = { left = 0, right = 1 }, color = { bg = catppuccin.mantle }, },
        },
        lualine_z = { function() return os.date("%R") end },
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }

    return opts_table
  end,
}
