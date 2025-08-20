-- lua/config/keymaps.lua

vim.keymap.set('n', '<leader>fh', function()
    telescope.find_files({ hidden = true })
  end, { desc = "Find files (hidden)" })

vim.api.nvim_set_keymap('v', '<leader>-', ':-:normal! I--<CR>', {
  noremap = true,
  silent = true,
  desc = 'Add -- to selected lines'
})

vim.api.nvim_set_keymap('v', '<leader>;', ":'<,'>normal! I;; <CR>", {
  noremap = true,
  silent = true,
  desc = 'Add ;; to selected lines'
})

local wk = require("which-key")

wk.add({
  -- Global keymaps
  { "<leader>.", "<cmd>Telescope file_browser<CR>", desc = "File Browser" },
  { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "NvimTree" },
  { "<leader>S", "<cmd>w<CR>", desc = "Save file" },
  { "<leader>c", group = "Code" },
  { "<leader>f", group = "Files" },
  { "<leader>q", group = "Quit" },

  -- Keymaps for LSP (Language Server Protocol)
  { "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to Declaration" },
  { "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to Definition" },
  { "K", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover Documentation" },
  { "gr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Go to References" },
  { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
  { "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename Symbol" },

  { "<C-t>", "<cmd>lua require('nvim-tree.api').node.open.tab()<CR>", desc = "Open in new tab (NvimTree)" },
  { "<Tab>", "<cmd>tabnext<CR>", desc = "Next tab" },
  { "<S-Tab>", "<cmd>tabprevious<CR>", desc = "Previous tab" },

  -- Dashboard Keymaps
  { "<F5>", "<cmd>Alpha<CR>", desc = "Open Dashboard" },

  -- Telescope Keymaps
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
  { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
  { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
  { "<leader>fn", "<cmd>enew<CR>", desc = "Create new file" },

  -- window management 
  { "<leader>w", group = "Windows" },
  { "<leader>wh", "<C-w>h", desc = "Move to left window" },
  { "<leader>wj", "<C-w>j", desc = "Move to lower window" },
  { "<leader>wk", "<C-w>k", desc = "Move to upper window" },
  { "<leader>wl", "<C-w>l", desc = "Move to right window" },
  { "<leader>wv", "<cmd>vsp<CR>", desc = "Split window vertically" },
  { "<leader>ws", "<cmd>sp<CR>", desc = "Split window horizontally" },
  { "<leader>wo", "<cmd>only<CR>", desc = "Close all other windows" },
  { "<leader>wc", "<cmd>q<CR>", desc = "Close current window" },

  -- Lazy Keymaps
  { "<leader>L", "<cmd>Lazy<CR>", desc = "Open Lazy" },

  -- Menu for buffer management
  { "<leader>b", group = "Buffers" }, -- Creates the main group for buffers
  { "<leader>bc", "<cmd>bdelete<CR>", desc = "Close buffer" },
  { "<leader>bn", "<cmd>bnext<CR>", desc = "Next buffer" },
  { "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous buffer" },
  { "<leader>bl", "<cmd>Telescope buffers<CR>", desc = "List buffers" },

  { "<leader>q", group = "Quit" },
  { "<leader>qq", "<cmd>qa<CR>", desc = "Quit Neovim" },
  { "<leader>qw", "<cmd>wq<CR>", desc = "Save and Quit" },
})
