return {

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- Add the rainbow-delimiters plugin dependency here
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim"
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "javascript", "typescript", "c", "cpp", "python", "css", "html" },
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
  }

}
