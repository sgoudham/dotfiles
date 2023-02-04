return {
    {
        "stevearc/overseer.nvim",
        config = true,
        cmd = { "OverseerRun", "OverseerToggle" },
        keys = {
            { "<leader>tr", vim.cmd.OverseerRun, desc = "Run Task" },
            { "<leader>tt", vim.cmd.OverseerToggle, desc = "Toggle task results" },
        },
    },
}
