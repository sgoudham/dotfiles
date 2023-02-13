return {
  {
    "goolord/alpha-nvim",
    config = function()
      local alpha = require("alpha")
      -- require("alpha.term")
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
        dashboard.button("f", "  Find a file", ":Telescope find_files<CR>"),
        dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("p", "  Find a project", ":Telescope projects<CR>"),
        dashboard.button("r", "  Recently used files", ":Telescope oldfiles<CR>"),
        dashboard.button("t", "  Find text", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
        dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
      }
      local function footer()
        -- Number of plugins
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
      -- dashboard.section.header.opts.hl = "Include"
      dashboard.section.buttons.opts.hl = "Keyword"

      dashboard.opts.opts.noautocmd = false

      -- local width = 52 -- 104
      -- local height = 15 -- 28
      -- dashboard.section.terminal.command = "cat | " .. os.getenv("HOME") .. "/.config/nvim/doom/render.sh"
      -- dashboard.section.terminal.width = width
      -- dashboard.section.terminal.height = height
      -- dashboard.section.terminal.opts.redraw = true
      --
      dashboard.config.layout = {
        { type = "padding", val = 3 },
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 1 },
        dashboard.section.footer,
      }
      dashboard.config.setup = function()
        vim.b.miniindentscope_disable = true
      end

      alpha.setup(dashboard.opts)
    end,
  },
}
