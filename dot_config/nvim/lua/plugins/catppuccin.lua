return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            local cp = require("catppuccin.palettes").get_palette()

            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                term_colors = true,
                no_italic = true,
                integrations = {
                    mason = true,
                    native_lsp = { enabled = true },
                    navic = {
                        enabled = true,
                        custom_bg = "NONE",
                    },
                    noice = true,
                    notify = true,
                    dap = {
                        enabled = true,
                        enable_ui = true,
                    },
                    cmp = true,
                    treesitter = true,
                    overseer = true,
                    telescope = true,
                    which_key = true,
                },
                color_overrides = {
                    mocha = {
                        base = "#000000",
                        mantle = "#000000",
                        surface2 = cp.subtext0,
                        overlay0 = cp.subtext0,
                    },
                },
                custom_highlights = {
                    ErrorMsg = { fg = cp.red, style = { "bold" } },
                    LspInfoBorder = { link = "FloatBorder" },
                    PmenuSel = { bg = cp.surface0 },
                    FloatBorder = { fg = cp.overlay0, bg = "NONE" },
                    TelescopeBorder = { link = "FloatBorder" },
                    TelescopeMatching = { link = "TelescopeNormal" },
                    TelescopeSelection = { fg = "NONE", bg = cp.surface0 },
                    TelescopeTitle = { fg = cp.subtext0 },
                    QuickScopePrimary = { fg = cp.maroon },
                    QuickScopeSecondary = { fg = cp.peach },
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
