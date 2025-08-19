return {

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-t>"] = "select_tab",
              ["<C-x>"] = "select_vertical", -- Correct action for vertical split
              ["<C-v>"] = "select_horizontal", -- Correct action for horizontal split
              ["<CR>"] = "select_tab",
            },
            n = {
              ["<C-t>"] = "select_tab",
              ["<C-x>"] = "select_vertical",
              ["<C-v>"] = "select_horizontal",
              ["<CR>"] = "select_tab",
            },
          },
        },
        extensions = {
          file_browser = {
            hidden = {
              file_browser = true,
            },
            sorting_strategy = "ascending",
            initial_mode = "normal", -- Optional, but recommended
            grouped = true, -- Groups directories at the beginning
          },
        },
      })
      require("telescope").load_extension("file_browser")
    end,
  },

  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { "nvim-tree/nvim-tree.lua", "nvim-telescope/telescope.nvim" },
    config = function()
      -- Load the extension
      require("telescope").load_extension("file_browser")

      -- Configure the file browser with custom mappings
      require("telescope").setup({
        extensions = {
          file_browser = {
            hidden = { file_browser = true },
          },
        },
      })
    end,
  }

}
