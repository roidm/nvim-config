return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")


      -- "Doom" style header
      dashboard.section.header.val = {
        [[  =================     ===============     ===============   ========  ========]],
        [[  \\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
        [[  ||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
        [[  || . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
        [[  ||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
        [[  || . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . .||]],
        [[  ||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. ||]],
        [[  || . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| .||]],
        [[  ||_-' ||  .|/    || ||    \\|. || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_||]],
        [[  ||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  ||]],
        [[  ||    `'         || ||         `'    || ||         `'    || ||   | \\  / |  ||]],
        [[  ||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
        [[  ||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
        [[  ||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
        [[  ||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
        [[  ||.=='    _-'                                                     `' |  /==.||]],
        [[  =='    _-'                                                            \/   `==]],
        [[  \   _-'                                                                `-_   /]],
        [[   `''                                                                      ``' ]],
      }

      -- Main buttons
      dashboard.section.buttons.val = {
        dashboard.button("e", "  New File", "<cmd>ene<CR>"),
        dashboard.button("f", "󰈞  Find file", ":lua Snacks.picker.smart()<CR>"),
        dashboard.button("r", "󰄉  Recent files", ":lua Snacks.picker.recent()<CR>"),
        dashboard.button("g", "󰈬  Live grep", ":lua Snacks.picker.grep()<CR>"),
        dashboard.button("c", "  Config",
          ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config'), prompt_title = '⚡ NVIM Config', hidden = true })<CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
      }

      -- Configuración minimalista
      dashboard.section.footer.val = function()
        local handle = io.popen("nvim --version | head -n 1")
        local version = "Neovim v?.?.?"
        if handle then
          version = handle:read("*a"):gsub("\n", "")
          handle:close()
        end
        return "⚡ " .. version .. " + Doom Dashboard ⚡"
      end
      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)
    end,
  },
}
