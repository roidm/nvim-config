return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('Comment').setup({
      toggler = {
        line = '<leader>cc',  -- Toggle línea actual
        block = '<leader>cb', -- Toggle bloque actual
      },
      opleader = {
        line = '<leader>c',  -- Comentar líneas en modo visual
        block = '<leader>b', -- Comentar bloque en modo visual
      },
      extra = {
        above = '<leader>cO', -- Agregar comentario arriba
        below = '<leader>co', -- Agregar comentario abajo
        eol = '<leader>cA',   -- Agregar comentario al final
      },
      mappings = {
        basic = true,
        extra = true,
      }
    })
  end,
}
