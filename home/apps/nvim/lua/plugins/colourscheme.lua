return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      styles = {
        comments = { "italic" },
      },
      integrations = {
        navic = {
          custom_bg = "#181825",
        },
      },
      custom_highlights = function(c)
        return {
          ["@parameter"] = { style = {} },
          ["@conditional"] = { style = {} },
          Conditional = { style = {} },
          ["@namespace"] = { style = {} },
          MiniIndentscopeSymbol = { fg = c.pink },
        }
      end,
    },
  },
}
