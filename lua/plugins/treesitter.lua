return {

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    -- Add the rainbow-delimiters plugin dependency here
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
      "OXY2DEV/markview.nvim",
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "go",
          "yaml",
          "html",
          "css",
          "python",
          "http",
          "markdown",
          "markdown_inline",
          "bash",
          "lua",
          "vim",
          "gitignore",
          "query",
          "rust",
          "ron",
        },
        highlight = {
          enable = true,
        },
        -- Activate the rainbow-delimiters plugin here
        rainbow_delimiters = {
          enable = true,
          -- Additional options, if needed
        },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    enabled = true,
    ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
    config = function()
      -- Independent nvim-ts-autotag setup
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,           -- Auto-close tags
          enable_rename = true,          -- Auto-rename pairs
          enable_close_on_slash = false, -- Disable auto-close on trailing `</`
        },
        per_filetype = {
          ["html"] = {
            enable_close = true, -- Disable auto-closing for HTML
          },
          ["typescriptreact"] = {
            enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
          },
        },
      })
    end,
  },
}
