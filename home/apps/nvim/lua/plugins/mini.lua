return {
  "echasnovski/mini.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("mini.clue").setup({
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
      },
      window = {
        delay = 800,
      },
    })
    require("mini.cursorword").setup({
      delay = 0,
    })
    require("mini.extra").setup()
    require("mini.files").setup()
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
    require("mini.pick").setup()
  end,
  keys = {
    {
      "-",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "File Navigation (file)",
    },
    {
      "_",
      function()
        require("mini.files").open(vim.loop.cwd(), true)
      end,
      desc = "File Navigation (cwd)",
    },
  },
}
