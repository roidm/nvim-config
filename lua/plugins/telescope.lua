-- lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        "<leader>.",
        function()
          local telescope = require("telescope")
          local fb_actions = require("telescope._extensions.file_browser.actions")
          local actions = require("telescope.actions")

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            grouped = true, -- carpetas primero
            hidden = true,  -- mostrar ocultos
            previewer = true,
            initial_mode = "normal",
            layout_strategy = "horizontal",
            layout_config = {
              prompt_position = "top",
              width = 0.8,
              height = 0.8,
              preview_width = 0.55,
            },
            mappings = {
              ["n"] = {
                ["h"] = fb_actions.goto_parent_dir,
                ["l"] = actions.select_default,
                ["-"] = fb_actions.goto_parent_dir,
                ["q"] = actions.close,
              },
            },
          })
        end,
        desc = "Browse Files",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(vim.tbl_deep_extend("force", {
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.5,         -- 50% global
            prompt_position = "top",
            preview_width = 0.5, -- mitad para preview, mitad para results
          },
          sorting_strategy = "ascending",
        },
      }, opts or {}))
      telescope.load_extension("file_browser")
    end,
  },
}
