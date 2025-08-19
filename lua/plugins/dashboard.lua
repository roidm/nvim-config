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
        dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "󰄉  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "󰈬  Live grep", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
      }

      -- Footer
      dashboard.section.footer.val = "⚡ Neovim with LazyVim + Doom Dashboard ⚡"

      -- Align sections
      dashboard.config.opts.noautocmd = true
      --dashboard.config.opts.buflisted = false
      --dashboard.config.opts.bufhidden = "hide"
      alpha.setup(dashboard.config)
    end,
  }
}
