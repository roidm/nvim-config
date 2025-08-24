[![Preview](https://github.com/roidm/nvim-config/blob/main/pics/pic.png?raw=true)](https://github.com/roidm/nvim-config)

# 🚀 Welcome

Welcome to my Neovim configuration! This config is designed to be
modular, fast, and efficient, using LazyVim for optimized plugin
management.

# ✨ Key Features

-   ****LazyVim****: A fast and minimalist package manager.
-   ****Colorscheme****: `catppuccin` with the `mocha` variant for a
    pleasant visual experience.
-   ****Completion****: Configuration with `nvim-cmp` and `luasnip`.
-   ****LSP****: Robust `Mason` and `nvim-lspconfig` setup for language
    support.
-   ****Git****: Full integration with `neogit`, an interactive Git
    client.
-   ****Statusline****: `lualine` with `nvim-web-devicons` icons for an
    informative and aesthetic statusline.
-   ****File Explorer****: `nvim-tree` for project navigation.
-   ****Fuzzy Finder****: `telescope` for quick file and content
    searching.
-   ****Snippets****: `luasnip` for code snippet autocompletion.
-   ****Visuals****: `nvim-treesitter` for syntax highlighting, and
    `rainbow-delimiters` for better parenthesis readability.
-   ****Others****: `which-key` for keyboard shortcuts, `Comment.nvim`
    for easy commenting, and `nvim-autopairs` for auto-closing
    parentheses and quotes.

# 📦 File Structure

The configuration follows a modular structure to facilitate easy editing
and plugin management.

    ├── init.lua
    └── lua/
        ├── config/
        │   ├── keymaps.lua
        │   ├── picker.lua
        │   ├── options.lua
        └── plugins/
            ├── completion.lua
            ├── dashboard.lua
            ├── formatting.lua
            ├── gitsigns.lua
            ├── lazydev.lua
            ├── lazygit.lua
            ├── lsp.lua
            ├── lualine.lua
            ├── noice.lua
            ├── others.lua
            ├── outline.lua
            ├── snacks.lua
            ├── telescope.lua
            ├── theme.lua
            ├── treesitter.lua
            ├── wk.lua
            └── yazi.lua

# ⚙️ Installation

Clone the repository into your Neovim configuration folder:

``` {.bash org-language="sh"}
git clone https://github.com/roidm/nvim-config ~/.config/nvim
```

Open Neovim. LazyVim will automatically handle installing the necessary
plugins.

💡 Acknowledgments

To the Neovim community for their amazing plugins.

To the developers of LazyVim for such an intuitive package manager.
