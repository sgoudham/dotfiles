return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
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
