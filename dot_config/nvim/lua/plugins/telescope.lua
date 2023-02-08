return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("projects")
      require("telescope").load_extension("fzy_native")
      require("telescope").load_extension("catppuccin")
      require("telescope").load_extension("smart_open")

      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<A-j>"] = actions.move_selection_next,
              ["<A-k>"] = actions.move_selection_previous,
              ["<A-n>"] = actions.cycle_history_next,
              ["<A-p>"] = actions.cycle_history_prev,
            },
            n = {
              ["<A-j>"] = actions.move_selection_next,
              ["<A-k>"] = actions.move_selection_previous,
              ["<A-n>"] = actions.preview_scrolling_down,
              ["<A-p>"] = actions.preview_scrolling_up,
            },
          },
        },
      })
    end,
    keys = {
      { "<leader>ff", "<cmd>Telescope smart_open<cr>", "Find Files" },
      { "<leader>fp", "<cmd>Telescope projects<cr>", "All Projects" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", "Find Text" },
      { "<leader>fh", "<cmd>Telescope highlights<cr>", "Find Highlights" },
      { "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find In File" },
      { "<leader>fC", "<cmd>Telescope catppuccin<cr>", "Catppuccin Colours" },
      { "<leader>fj", "<cmd>Telescope jumplist<cr>", "Jumplist" },
    },
    cmd = "Telescope",
    dependencies = {
      "backwardspy/telescope-catppuccin.nvim",
      {
        "nvim-telescope/telescope-fzy-native.nvim",
        dependencies = { "kkharji/sqlite.lua" },
      },
      "danielfalk/smart-open.nvim",
      "backwardspy/telescope-catppuccin.nvim",
    },
  },
}
