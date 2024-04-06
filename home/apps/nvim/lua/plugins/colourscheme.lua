return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 10000,
    opts = {
      flavour = "mocha",
      custom_highlights = function(c)
        local u = require("catppuccin.utils.colors")
        local latte = require("catppuccin.palettes.latte")

        return {
          NoiceCmdLinePopupTitle = { fg = c.base, bg = c.blue },
          NoiceCmdlinePopup = { bg = c.base },
          NoiceCmdlinePopupBorder = { fg = c.blue },

          -- Making the background of mini.files lighter
          MiniFilesNormal = { bg = c.base },
          -- Make the indentline nicer on the eyes
          MiniIndentscopeSymbol = { fg = c.pink },

          -- Setting the borders and background of the completion/documentation menu
          BorderBG = { fg = c.blue },
          -- PmenuSel = { bg = c.mantle }, -- enable when using latte
          -- Setting the background of the lsp.buf.hover() and other floats
          NormalFloat = { bg = c.base },
          -- Setting the background of the lsp diagnostics - stuff like [d, [w
          TroubleNormal = { bg = c.base },

          -- Markdown headlines
          Headline1 = { bg = c.transparent },

          EyelinerPrimary = { fg = latte.red },
          EyelinerSecondary = { fg = latte.peach },

          -- Neogit
          -- NeogitUnstagedchanges = { bg = c.base },
          -- NeogitUnstagedchangesRegion = { bg = c.base },
          -- NeogitHunkHeader = {
          --   bg = u.darken(c.blue, 0.095, c.base),
          --   fg = u.darken(c.blue, 0.5, c.base),
          -- },
          -- NeogitHunkHeaderHighlight = {
          --   bg = u.darken(c.blue, 0.215, c.base),
          --   fg = c.blue,
          -- },
          -- NeogitCursorLine = { link = "CursorLine" },
          -- NeogitDiffHeader = { fg = c.pink },
          -- NeogitDiffContextHighlight = { bg = c.base },
          -- NeogitDiffContext = { bg = c.base },
          -- NeogitDiffAddRegion = { bg = c.base },
          -- NeogitDiffDeleteRegion = { bg = c.base },
          -- NeogitDiffAdd = { fg = c.green, bg = c.base },
          -- NeogitDiffAddHighlight = { fg = c.green, bg = c.base },
          -- NeogitDiffDelete = { fg = c.red, bg = c.base },
          -- NeogitDiffDeleteHighlight = { fg = c.red, bg = c.base },
        }
      end,
    },
  },
}
