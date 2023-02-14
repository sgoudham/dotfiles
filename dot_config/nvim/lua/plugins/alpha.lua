return {
  {
    "goolord/alpha-nvim",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        [[=================     ===============     ===============   ========  ========]],
        [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
        [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
        [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
        [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
        [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
        [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
        [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
        [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
        [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
        [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
        [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
        [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
        [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
        [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
        [[||.=='    _-'                                                     `' |  /==.||]],
        [[=='    _-'                        N E O V I M                         \/   `==]],
        [[\   _-'                                                                `-_   /]],
        [[ `''                                                                      ``' ]],
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
        dashboard.button("e", "  New File", ":ene <BAR> startinsert<CR>"),
        dashboard.button("p", "  Find Project", ":Telescope projects<CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles<CR>"),
        dashboard.button("t", "  Find Text", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }
      local function footer()
        local total_plugins = require("lazy").stats().count
        local datetime = os.date("%d-%m-%Y %H:%M:%S")
        local plugins_text = "   "
          .. total_plugins
          .. " plugins"
          .. "   v"
          .. vim.version().major
          .. "."
          .. vim.version().minor
          .. "."
          .. vim.version().patch
          .. "   "
          .. datetime
        return plugins_text
      end

      dashboard.section.footer.val = footer()
      dashboard.section.footer.opts.hl = "Type"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = false

      dashboard.config.layout = {
        { type = "padding", val = 3 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }

      alpha.setup(dashboard.opts)
    end,
  },
}
