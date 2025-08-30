-- lua/config/keymaps.lua

-- Mappings
vim.keymap.set("n", "<S-Left>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Down>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Up>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Right>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })


local wk = require("which-key")
local picker = require("config.picker")

-- which-key
wk.add({

  -- Groups
  { "<leader>c",   group = "Code" },
  { "<leader>f",   group = "Files" },
  { "<leader>q",   group = "Quit" },
  { "<leader>w",   group = "Windows" },
  { "<leader>b",   group = "Buffers" },
  { "<leader>t",   group = "Telescope" },
  { "<leader>s",   group = "Snacks" },
  { "<leader>p",   group = "Snacks Files" },
  { "<leader>l",   group = "LSP" },
  { "<leader>g",   group = "Git" },
  { "<leader>u",   group = "Toggles" },

  -- Telescope shortcuts
  { "<leader>tf",  "<cmd>Telescope find_files<CR>",                    desc = "Find Files" },
  { "<leader>tg",  "<cmd>Telescope live_grep<CR>",                     desc = "Live Grep" },
  { "<leader>tr",  "<cmd>Telescope oldfiles<CR>",                      desc = "Recent Files" },
  { "<leader>tb",  "<cmd>Telescope buffers<CR>",                       desc = "List Buffers" },
  { "<leader>tl",  "<cmd>Telescope lsp_document_symbols<CR>",          desc = "Document Symbols" },
  { "<leader>tL",  "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Workspace Symbols" },
  { "<leader>tgs", "<cmd>Telescope git_status<CR>",                    desc = "Git Status" },
  { "<leader>tgc", "<cmd>Telescope git_commits<CR>",                   desc = "Git Commits" },
  { "<leader>tgb", "<cmd>Telescope git_branches<CR>",                  desc = "Git Branches" },
  { "<leader>td",  "<cmd>Telescope diagnostics<CR>",                   desc = "Diagnostics" },
  { "<leader>tm",  "<cmd>Telescope marks<CR>",                         desc = "Marks" },
  { "<leader>th",  "<cmd>Telescope help_tags<CR>",                     desc = "Help Tags" },
  { "<leader>tc",  "<cmd>Telescope commands<CR>",                      desc = "Commands" },
  { "<leader>tk",  "<cmd>Telescope keymaps<CR>",                       desc = "Keymaps" },
  { "<leader>tt",  "<cmd>Telescope treesitter<CR>",                    desc = "Treesitter Symbols" },
  { "<leader>tC",  "<cmd>Telescope colorscheme<CR>",                   desc = "Colorscheme" },
  { "<leader>r",   "<cmd>Telescope oldfiles<CR>",                      desc = "Recent Files" },

  -- Edit Neovim config
  {
    "<leader>te",
    function()
      require("telescope.builtin").find_files({
        cwd = vim.fn.stdpath("config"),
        prompt_title = "⚡ Edit Nvim Config",
        hidden = true,
      })
    end,
    desc = "Edit Nvim config",
  },

  -- Navegar archivos (file_browser)
  {
    "<leader>.",
    function()
      require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h",
        grouped = true,
        previewer = true,
        initial_mode = "normal",
        mappings = {
          n = {
            ["h"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
            ["l"] = require("telescope.actions").select_default,
            ["-"] = require("telescope._extensions.file_browser.actions").goto_parent_dir,
            ["q"] = require("telescope.actions").close,
          },
        },
      })
    end,
    desc = "Browse Files",
  },
  {
    "<leader>fe",
    function()
      local fb_actions = require("telescope._extensions.file_browser.actions")
      local actions = require("telescope.actions")
      require("telescope").extensions.file_browser.file_browser({
        path = "%:p:h",
        grouped = true,
        previewer = true,
        initial_mode = "normal",
        mappings = {
          n = {
            ["h"] = fb_actions.goto_parent_dir,
            ["l"] = actions.select_default,
            ["-"] = fb_actions.goto_parent_dir,
            ["q"] = actions.close,
          },
        },
      })
    end,
    desc = "File browser",
  },
  {
    "<leader>fc",
    function()
      require("telescope.builtin").find_files({
        cwd = "~/.config/nvim",
        prompt_title = "📁 CONFIG Files",
        hidden = true,
        file_ignore_patterns = {
          "node_modules",
          ".git",
          ".cache",
          ".npm",
          ".yarn",
          "vendor",
        },
      })
    end,
    desc = "Nvim directory",
  },
  { "<leader>fn", "<cmd>enew<CR>",        { desc = "New File" } },
  { "<leader>fs", "<cmd>w<CR>",           desc = "Save file" },

  --Pickers
  { "<leader>d",  picker.dotfiles_picker, desc = "Edit dotfiles" },
  { "<leader>m",  picker.media_picker,    desc = "Show Pictures" },

  {
    "<leader>st",
    "<cmd>lua require('snacks.terminal').open(nil, {win = {split = 'below'}})<CR>",
    desc = "Snacks terminal below",
  },
  -- Search and replace
  {
    "<leader>sr",
    function()
      -- Centrar la pantalla primero
      vim.cmd("normal! zz")

      local find = vim.fn.input("Search: ")
      if find == "" then
        return
      end

      vim.cmd("normal! zz")
      local replace = vim.fn.input("Replace with: ")
      if replace == "" then
        return
      end

      vim.cmd("normal! zz")
      local choice = vim.fn.input("Reemplazar todo (a) o ir uno por uno (i)? [a/i]: ")

      if choice:lower() == "i" then
        vim.cmd("%s/" .. find .. "/" .. replace .. "/gc")
      else
        vim.cmd("%s/" .. find .. "/" .. replace .. "/g")
      end
    end,
    desc = "Search & Replace",
  },

  -- LSP shortcuts
  { "gD",         "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to Declaration" },
  { "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>",  desc = "Go to Definition" },
  { "K",          "<cmd>lua vim.lsp.buf.hover()<CR>",       desc = "Hover Documentation" },
  { "gr",         "<cmd>lua vim.lsp.buf.references()<CR>",  desc = "Go to References" },
  { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },

  -- Otros atajos
  { "<Tab>",      "<cmd>tabnext<CR>",                       desc = "Next tab" },
  { "<S-Tab>",    "<cmd>tabprevious<CR>",                   desc = "Previous tab" },
  { "<F5>",       "<cmd>Alpha<CR>",                         desc = "Open Dashboard" },

  -- Windows
  { "<leader>wh", "<C-w>h",                                 desc = "Move to left window" },
  { "<leader>wj", "<C-w>j",                                 desc = "Move to lower window" },
  { "<leader>wk", "<C-w>k",                                 desc = "Move to upper window" },
  { "<leader>wl", "<C-w>l",                                 desc = "Move to right window" },
  { "<leader>wv", "<cmd>vsp<CR>",                           desc = "Split window vertically" },
  { "<leader>ws", "<cmd>sp<CR>",                            desc = "Split window horizontally" },
  { "<leader>wo", "<cmd>only<CR>",                          desc = "Close all other windows" },
  { "<leader>wc", "<cmd>q<CR>",                             desc = "Close current window" },
  { "<leader>wd", "<C-W>c",                                 desc = "Delete window" },

  -- Lazy
  { "<leader>L",  "<cmd>Lazy<CR>",                          desc = "Open Lazy" },

  -- Buffers
  { "<leader>bc", "<cmd>bdelete<CR>",                       desc = "Close buffer" },
  {
    "<leader>,",
    function()
      require("telescope.builtin").buffers({
        sorting_strategy = "ascending", -- prompt arriba y lista ordenada
        ignore_current_buffer = false,
        previewer = true,
      })
    end,
    desc = "List buffers",
  },
  { "<leader>bl", "<cmd>Telescope buffers<CR>", desc = "List Buffers" },
  { "<leader>bn", "<cmd>bnext<CR>",             desc = "Next buffer" },
  { "<leader>bp", "<cmd>bprevious<CR>",         desc = "Previous buffer" },

  -- Quit Neovim
  { "<leader>qq", "<cmd>qa<CR>",                desc = "Quit Neovim" },
  { "<leader>qw", "<cmd>wq<CR>",                desc = "Save and Quit" },
})
