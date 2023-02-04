return {
    {
        "feline-nvim/feline.nvim",
        config = function()
            local feline = require("feline")
            local ctp_feline = require("catppuccin.groups.integrations.feline")

            -- catppuccin statusline
            ctp_feline.setup({})
            feline.setup({ components = ctp_feline.get() })
        end,
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
}
