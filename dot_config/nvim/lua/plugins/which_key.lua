return {
    {
        "folke/which-key.nvim",
        config = function()
            local wk = require("which-key")
            wk.setup({
                window = {
                    border = "rounded",
                },
           })

            wk.register({
                g = { name = "Go to" },
                ["]"] = { name = "Next" },
                ["["] = { name = "Previous" },
            })

            wk.register({
                f = { name = "Find" },
                g = { name = "Git" },
                -- j = { name = "Jump" },
                l = { name = "LSP" },
                -- o = { name = "Open" },
                t = { name = "Tasks" },
                d = { name = "Debug" },
            }, { prefix = "<leader>" })
        end,
    },
}
