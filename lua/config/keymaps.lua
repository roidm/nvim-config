-- lua/config/keymaps.lua

local wk = require("which-key")

wk.add({
  -- Global keymaps
  { "<leader>.", "<cmd>Telescope file_browser<CR>", desc = "File Browser" }, -- Atajo para abrir el navegador de archivos
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
})
wk.add({
  -- ... your existing keymaps ...
  { "<C-t>", "<cmd>lua require('nvim-tree.api').node.open.tab()<CR>", desc = "Open in new tab (NvimTree)" },
  -- New keymaps to navigate between tabs
  { "<Tab>", "<cmd>tabnext<CR>", desc = "Next tab" },
  { "<S-Tab>", "<cmd>tabprevious<CR>", desc = "Previous tab" },
})
wk.add({
  -- Dashboard Keymaps
  { "<F5>", "<cmd>Alpha<CR>", desc = "Open Dashboard" },
})

wk.add({
  -- Telescope Keymaps
  { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
  { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
  { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
  { "<leader>fn", "<cmd>enew<CR>", desc = "Create new file" },
})

wk.add({
  -- ✨ Add this new block for window management ✨
  { "<leader>w", group = "Windows" },
  { "<leader>wh", "<C-w>h", desc = "Move to left window" },
  { "<leader>wj", "<C-w>j", desc = "Move to lower window" },
  { "<leader>wk", "<C-w>k", desc = "Move to upper window" },
  { "<leader>wl", "<C-w>l", desc = "Move to right window" },
  { "<leader>wv", "<cmd>vsp<CR>", desc = "Split window vertically" },
  { "<leader>ws", "<cmd>sp<CR>", desc = "Split window horizontally" },
  { "<leader>wo", "<cmd>only<CR>", desc = "Close all other windows" },
  { "<leader>wc", "<cmd>q<CR>", desc = "Close current window" },
})

wk.add({
  -- Lazy Keymaps
  { "<leader>L", "<cmd>Lazy<CR>", desc = "Open Lazy" },
})

wk.add({
  -- Menu for buffer management
  { "<leader>b", group = "Buffers" }, -- Creates the main group for buffers
  { "<leader>bc", "<cmd>bdelete<CR>", desc = "Close buffer" },
  { "<leader>bn", "<cmd>bnext<CR>", desc = "Next buffer" },
  { "<leader>bp", "<cmd>bprevious<CR>", desc = "Previous buffer" },
  { "<leader>bl", "<cmd>Telescope buffers<CR>", desc = "List buffers" },
})

wk.add({
  { "<leader>q", group = "Quit" },
  { "<leader>qq", "<cmd>qa<CR>", desc = "Quit Neovim" },
  { "<leader>qw", "<cmd>wq<CR>", desc = "Save and Quit" },
})
