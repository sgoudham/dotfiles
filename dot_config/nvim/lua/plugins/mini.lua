return {
  {
    "echasnovski/mini.nvim",
    config = function()
      -- add gc/gcc actions, gc textobject
      require("mini.comment").setup({})

      -- autochange dir
      -- require("mini.misc").setup({})
      -- MiniMisc.setup_auto_root()

      -- highlight word under cursor
      require("mini.cursorword").setup({ delay = 0 })

      -- indent lines, `i` textobject, `]i`/`[i` motions
      require("mini.indentscope").setup({
        draw = { delay = 0 },
        symbol = "│",
      })
    end,
  },
}
