return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  config = function()
    require("neogit").setup({
      disable_hint = true,
      kind = "split",
      signs = {
        item = { "", "" },
        hunk = { "", "" },
        section = { "", "" },
      },
    })

    vim.keymap.set("n", "<leader>gg", function()
      require("neogit").open()
    end, { desc = "Abrir Neogit" })
  end,
}
