return {

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- Using Mocha as the base
        background = {
          light = 'latte',
          dark = 'mocha',
        },
        color_overrides = {
          all = {
            base = '#11111b', -- Using crust as the main background color
            mantle = '#181825', -- And mantle for secondary elements
            crust = '#1e1e2e', -- And the old base for the "darker" (now lighter) elements
          },
        },
      })
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup({
        -- You can add additional configurations here
      })
      vim.schedule(function()
        -- Color configuration for the which-key minibuffer and all floating windows
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#181825" })
      end)
      require("config.keymaps")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = "catppuccin",
          -- We use the thick section separators that give you the "filled" effect
          section_separators = { left = '', right = '' },
          -- And we use thinner component separators for the space between them
          component_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'filesize', 'filetype', 'location'},
          lualine_y = {},
          lualine_z = {'progress'},
        },
      })
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup()
    end,
  }

}
