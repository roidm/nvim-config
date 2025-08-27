return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "catppuccin/nvim",
    "folke/trouble.nvim",
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    -- Crear un tema custom basado en catppuccin-mocha
    local catppuccin = require("lualine.themes.catppuccin-mocha")
    for section, colors in pairs(catppuccin) do
      for name, col in pairs(colors) do
        col.gui = "bold" -- forzar bold en todas las secciones
      end
    end

    -- Componente custom para mostrar grabación de macros
    local function recording_macro()
      local rec = vim.fn.reg_recording()
      if rec ~= "" then
        return "rec @" .. rec
      end
      return ""
    end

    -- Configuración base de lualine
    local opts = {
      options = {
        theme = catppuccin,
        icons_enabled = true,
        disabled_filetypes = {
          statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
          winbar = {},
        },
        always_divide_middle = true,
        globalstatus = false,
      },
      sections = {
        lualine_a = { "mode", recording_macro }, -- usamos el componente custom
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "searchcount", "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }

    -- Integración con Trouble
    if package.loaded["trouble"] then
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end

    -- Configurar lualine
    require("lualine").setup(opts)

    -- Configuración adicional para DAP
    if package.loaded["dap"] then
      vim.api.nvim_create_autocmd("User", {
        pattern = "DapStopped",
        callback = function()
          require("lualine").refresh()
        end,
      })
    end

    -- Autocmd para limpiar búsquedas (tu configuración existente)
    vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
      callback = function()
        vim.cmd("noh")
      end,
    })
  end,
}
