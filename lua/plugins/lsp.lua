return {
  -- Mason: gestor de binarios (LSP, linters, formatters)
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason-LSPconfig: puente entre mason y lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = { "lua_ls" }, -- instala el LSP de Lua
      automatic_installation = true,
    },
  },
  -- nvim-lspconfig: configuración de servidores LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")

      -- Ajustes básicos de diagnósticos (API actualizada)
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Detener LSP clientes al salir de Neovim (API actualizada para 0.11+)
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          -- Usar vim.lsp.get_clients() en lugar de get_active_clients()
          for _, client in ipairs(vim.lsp.get_clients()) do
            client:stop() -- Usar client:stop() en lugar de vim.lsp.stop_client()
          end
        end,
      })

      -- Config optimizada para lua_ls
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,                        -- evita advertencias innecesarias
              library = vim.api.nvim_get_runtime_file("", true),
              ignoreDir = { "node_modules", ".git", "dist" }, -- no indexar basura
            },
            completion = {
              callSnippet = "Disable", -- menos carga en completado
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Mapeos para el LSP
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
      vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "LSP Definition" })
      vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "LSP Hover" })
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { desc = "LSP References" })
      vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = "LSP Rename" })
      vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })

      -- Mapeos para diagnósticos (API actualizada para 0.11+)
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1 }) -- Nueva API para ir al diagnóstico anterior
      end, { desc = "Prev Diagnostic" })
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1 }) -- Nueva API para ir al diagnóstico siguiente
      end, { desc = "Next Diagnostic" })
      vim.keymap.set("n", "<leader>e", function()
        vim.diagnostic.open_float() -- Esta función sigue siendo válida
      end, { desc = "Open Diagnostic" })
    end,
  },
}
