---@diagnostic disable: missing-fields
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      on_colors = function(colors)
        -- Cambia el fondo de #1A1B26 a #11111b
        colors.bg = "#11111b"
        colors.bg_dark = "#11111b"
        colors.bg_statusline = "#16161E"
      end,
      on_highlights = function(highlights, colors)
        -- Ajustes adicionales si necesitas modificar highlights específicos
        highlights.Normal = { bg = colors.bg }
        highlights.NormalFloat = { bg = colors.bg_float }
        highlights.StatusLine = { bg = colors.bg_statusline }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
