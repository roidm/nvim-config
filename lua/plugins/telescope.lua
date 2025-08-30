return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },

    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.load_extension("ui-select")
      telescope.load_extension("fzf")
      telescope.load_extension("media_files")

      telescope.setup({
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
          },
          mappings = {
            i = {
              ["<C-t>"] = actions.select_tab,
              ["<C-x>"] = actions.select_vertical,
              ["<C-v>"] = actions.select_horizontal,
              ["<CR>"] = actions.select_default,
              ["<C-q>"] = actions.close,
            },
            n = {
              ["<C-t>"] = actions.select_tab,
              ["<C-x>"] = actions.select_vertical,
              ["<C-v>"] = actions.select_horizontal,
              ["<CR>"] = actions.select_default,
              ["q"] = actions.close,
            },
          },
          sorting_strategy = "ascending", -- prompt arriba
          layout_strategy = "horizontal", -- lista izquierda, preview derecha
          layout_config = {
            prompt_position = "top",
            width = 0.8,
            height = 0.8,
            preview_width = 0.6,
          },
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type=f", "--hidden" },
          },
          oldfiles = {},
        },
        extensions = {
          fzf = {},
          file_browser = {
            hidden = { file_browser = true },
            initial_mode = "normal",
            grouped = true,
            previewer = true,
            hijack_netrw = true,
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
    end,
  },
}
