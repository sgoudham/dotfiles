return {
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").load_extension("projects")
            require("telescope").load_extension("fzy_native")
            require("telescope").load_extension("catppuccin")
            require("telescope").load_extension("smart_open")
        end,
        keys = {
            { "<leader>ff", "<cmd>Telescope smart_open<cr>", "Find files" },
            { "<leader>fp", "<cmd>Telescope projects<cr>", "All Projects" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", "Live grep" },
            { "<leader>fc", "<cmd>Telescope catppuccin<cr>", "Catppuccin Colours" },
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
