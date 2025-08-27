return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Variables para tracking
      local startup_plugins_count = 0
      local startup_start_time = nil
      local all_plugins_loaded = false
      local timer_initialized = false

      ---@diagnostic disable-next-line: redefined-local
      local startup_start_time = os.clock()
      local startup_plugins_cnt = 0

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyLoad",
        callback = function()
          startup_plugins_cnt = startup_plugins_cnt + 1
        end,
      })

      local function get_startup_time()
        return string.format("%.1fms", (os.clock() - startup_start_time) * 1000)
      end

      local function get_plugin_count()
        return startup_plugins_cnt
      end

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
        dashboard.button("c", "  Config", ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})<CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "󰅚  Quit", ":qa<CR>"),
      }

      -- Footer con información de inicio
      dashboard.section.footer.val = function()
        local nvim_version = vim.version()

        return string.format(
          "⚡ Neovim %d.%d.%d loaded in %s | Plugins: %d ⚡",
          nvim_version.major,
          nvim_version.minor,
          nvim_version.patch,
          get_startup_time(),
          get_plugin_count()
        )
      end

      -- Align sections
      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)
    end,
  },
}
