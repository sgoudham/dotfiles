local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
    float = { border = "rounded" },
    update_in_insert = true,
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local default_config = {
    on_attach = function(client, bufnr)
        require("lsp-format").on_attach(client)

        -- add lsp-only keybinds
        local map = function(sequence, cmd, desc)
            vim.keymap.set("n", sequence, cmd, { buffer = bufnr, desc = desc })
        end

        map("gd", function()
            require("telescope.builtin").lsp_definitions()
        end, "LSP Definitions")
        map("gr", function()
            require("telescope.builtin").lsp_references()
        end, "LSP References")
        map("gI", function()
            require("telescope.builtin").lsp_implementations()
        end, "LSP Implementations")
        map("K", vim.lsp.buf.hover, "Hover")
        map("]d", vim.diagnostic.goto_next, "Next diagnostic")
        map("[d", vim.diagnostic.goto_prev, "Previous diagnostic")

        map("<leader>la", vim.lsp.buf.code_action, "Code Action")
        map("<leader>lr", vim.lsp.buf.rename, "Rename")
        map("<leader>lf", vim.lsp.buf.format, "Format")
        map("<leader>li", "<cmd>LspInfo<cr>", "LSP Info")
        map("<leader>lI", "<cmd>Mason<cr>", "Mason Info")
        map("<leader>lw", function()
            require("telescope.builtin").diagnostics()
        end, "LSP Workplace Diagnostics")
        map("<leader>ld", function()
            require("telescope.builtin").diagnostics({ bufnr = 0 })
        end, "LSP Buffer Diagnostics")
        map("<leader>ls", function()
            require("telescope.builtin").lsp_document_symbols()
        end, "LSP Document Symbols")
        map("<leader>lS", function()
            require("telescope.builtin").lsp_workspace_symbols()
        end, "LSP Workplace Symbols")
    end,
}

local custom_config = function(config)
    local merged_config = vim.deepcopy(default_config)
    merged_config = vim.tbl_extend("force", merged_config, config)
    return merged_config
end

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig.ui.windows").default_options.border = "rounded"
        end,
        dependencies = {
            {
                "williamboman/mason-lspconfig.nvim",
                config = function()
                    require("mason-lspconfig").setup({
                        ensure_installed = { "rust_analyzer", "pyright", "sumneko_lua" },
                    })
                    require("mason-lspconfig").setup_handlers({
                        -- default handler
                        function(server_name)
                            require("lspconfig")[server_name].setup(default_config)
                        end,
                        ["rust_analyzer"] = function()
                            -- https://github.com/simrat39/rust-tools.nvim/issues/300
                            local config = custom_config({
                                settings = {
                                    ["rust-analyzer"] = {
                                        inlayHints = { locationLinks = false },
                                    },
                                },
                            })
                            require("rust-tools").setup({
                                server = config,
                                dap = {
                                    adapter = {
                                        type = "server",
                                        port = "${port}",
                                        host = "127.0.0.1",
                                        executable = {
                                            command = "codelldb",
                                            args = { "--port", "${port}" },
                                        },
                                    },
                                },
                            })
                        end,
                        ["pyright"] = function()
                            require("py_lsp").setup(default_config)
                        end,
                        ["hls"] = function()
                            local ht = require("haskell-tools")
                            local def_opts = { noremap = true, silent = true }
                            ht.setup({
                                hls = {
                                    on_attach = function(client, bufnr)
                                        local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr })
                                        -- haskell-language-server relies heavily on codeLenses,
                                        -- so auto-refresh (see advanced configuration) is enabled by default
                                        -- vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, opts)
                                        -- vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
                                    end,
                                },
                            })
                            -- Suggested keymaps that do not depend on haskell-language-server
                            -- Toggle a GHCi repl for the current package
                            vim.keymap.set("n", "<leader>rr", ht.repl.toggle, def_opts)
                            -- Toggle a GHCi repl for the current buffer
                            vim.keymap.set("n", "<leader>rf", function()
                                ht.repl.toggle(vim.api.nvim_buf_get_name(0))
                            end, def_opts)
                            vim.keymap.set("n", "<leader>rq", ht.repl.quit, def_opts)
                        end,
                        ["sumneko_lua"] = function()
                            require("lspconfig")["sumneko_lua"].setup(custom_config({
                                settings = {
                                    Lua = {
                                        format = {
                                            enable = false,
                                        },
                                        workspace = {
                                            checkThirdParty = false,
                                        },
                                        telemetry = {
                                            enable = false,
                                        },
                                    },
                                },
                            }))
                        end,
                    })
                end,
                dependencies = {
                    "williamboman/mason.nvim",
                    { "folke/neodev.nvim", config = true },
                },
            },
            "simrat39/rust-tools.nvim",
            "mrcjkb/haskell-tools.nvim",
            "HallerPatrick/py_lsp.nvim",
            { "SmiteshP/nvim-navic", config = { highlight = true } },
            "onsails/lspkind.nvim",
            { "lukas-reineke/lsp-format.nvim", config = true },
            "folke/neodev.nvim",
            "ray-x/lsp_signature.nvim",
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua.with({
                        extra_args = { "--indent-type", "spaces" },
                    }),
                    --         null_ls.builtins.formatting.black,
                    --         null_ls.builtins.formatting.isort.with({
                    --             extra_args = { "--profile", "black" },
                    --         }),
                },
            })
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        config = {
            ensure_installed = { "stylua" },
        },
    },
}
