return {
  {
    "echasnovski/mini.nvim",
    config = function()
      -- add gc/gcc actions, gc textobject
      require("mini.comment").setup({})

      -- highlight word under cursor
      require("mini.cursorword").setup({ delay = 0 })

      -- indent lines, `i` textobject, `]i`/`[i` motions
      require("mini.indentscope").setup({
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(),
        },
        symbol = "│",
      })
    end,
  },
}
