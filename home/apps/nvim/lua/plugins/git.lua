return {
  {
    "NeogitOrg/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      disable_commit_confirmation = true,
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit kind=replace<cr>", desc = "Open Neogit" },
      { "<leader>gG", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Open Neogit (cwd)" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    keys = {
      { "]h", "<CMD>Gitsigns next_hunk<CR>zz", desc = "Next Hunk" },
      { "[h", "<CMD>Gitsigns prev_hunk<CR>zz", desc = "Prev Hunk" },
      { "<leader>ghP", "<CMD>Gitsigns preview_hunk<CR>zz", desc = "Preview Hunk" },
    },
  },
}
