return {
  setup = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    -- Listado de servidores que se autoinstalarán
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "cssls",
        "html",
        "jsonls",
        "ts_ls",
        "clangd",
        "pyright",
      },
    })

    -- Configuración básica para todos los LSP
    local on_attach = function(client, bufnr)
      -- Keymaps para LSP
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Go to Declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to Definition" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP: Go to References" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
    end

    -- Configuración específica del servidor lua_ls
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          workspace = {
            -- A menos que seas un desarrollador de Neovim, deshabilita la comprobación del 'runtime path'
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
      on_attach = on_attach,
    })

    -- Configuración de otros servidores (se aplica on_attach por defecto)
    lspconfig.ts_ls.setup({ on_attach = on_attach })
    lspconfig.cssls.setup({ on_attach = on_attach })
    lspconfig.html.setup({ on_attach = on_attach })
    lspconfig.clangd.setup({ on_attach = on_attach })
    lspconfig.pyright.setup({ on_attach = on_attach })
    lspconfig.jsonls.setup({ on_attach = on_attach })
  end,
}
