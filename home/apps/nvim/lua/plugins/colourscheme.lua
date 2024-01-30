return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    no_italic = true,
    priority = 10000,
    opts = {
      flavour = "latte",
      -- styles = {
      --   comments = { "italic" },
      -- },
      integrations = {
        telescope = {
          style = "nvchad",
        },
      },
      custom_highlights = function(c)
        local u = require("catppuccin.utils.colors")

        return {
          -- ["@parameter"] = { style = {} },
          -- Parameter = { style = {} },
          -- ["@conditional"] = { style = {} },
          -- Conditional = { style = {} },
          -- ["@namespace"] = { style = {} },
          MiniIndentscopeSymbol = { fg = c.pink },
          NoiceCmdLinePopupTitle = { fg = c.base, bg = c.blue },
          NoiceCmdlinePopup = { bg = c.mantle },
          NoiceCmdlinePopupBorder = { bg = c.mantle, fg = c.mantle },

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
