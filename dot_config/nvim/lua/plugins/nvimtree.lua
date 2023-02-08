return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-tree").setup({
        hijack_cursor = true,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        view = {
          centralize_selection = true,
        },
        renderer = {
          group_empty = true,
        },
      })
    end,
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", "Open Explorer" },
    },
  },
}
