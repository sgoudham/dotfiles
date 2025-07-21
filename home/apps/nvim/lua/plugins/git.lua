return {
  {
    "NeogitOrg/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    cmd = { "Neogit" },
    opts = {
      disable_commit_confirmation = true,
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit kind=replace<cr>", desc = "Open Neogit" },
      { "<leader>gG", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Open Neogit (cwd)" },
    },
  },
}
