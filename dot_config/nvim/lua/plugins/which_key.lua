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
                c = { name = "Code" },
                f = { name = "Find" },
                g = { name = "Git" },
                j = { name = "Jump" },
                l = { name = "LSP" },
                o = { name = "Open" },
                s = { name = "Search" },
                t = { name = "Tasks" },
                x = { name = "Debug" },
            }, { prefix = "<leader>" })
        end,
    },
}
