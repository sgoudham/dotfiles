local lsp = require("lsp")

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  underline = {
    severity = { max = vim.diagnostic.severity.WARN },
  },
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR },
  },
  float = { border = "rounded" },
  update_in_insert = true,
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local custom_config = function(config)
  local merged_config = vim.deepcopy(lsp.default_config)
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
            ensure_installed = { "rust_analyzer", "pyright", "lua_ls", "marksman" },
          })
          require("mason-lspconfig").setup_handlers({
            -- default handler
            function(server_name)
              require("lspconfig")[server_name].setup(lsp.default_config)
            end,

            ["ltex"] = function()
              require("lspconfig")["ltex"].setup(lsp.default_config)
              require("ltex_extra").setup({
                load_langs = { "es-AR", "en-US" },
                init_check = true,
                path = vim.fn.stdpath("data") .. "/dictionary",
              })
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
              require("py_lsp").setup(lsp.default_config)
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
              -- vim.keymap.set("n", "<leader>rr", ht.repl.toggle, def_opts)
              -- Toggle a GHCi repl for the current buffer
              -- vim.keymap.set("n", "<leader>rf", function()
              --   ht.repl.toggle(vim.api.nvim_buf_get_name(0))
              -- end, def_opts)
              -- vim.keymap.set("n", "<leader>rq", ht.repl.quit, def_opts)
            end,

            ["lua_ls"] = function()
              require("lspconfig")["lua_ls"].setup(custom_config({
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
          {
            "williamboman/mason.nvim",
            opts = {
              ui = { border = "rounded" },
            },
          },
          { "folke/neodev.nvim", config = true },
        },
      },
      "simrat39/rust-tools.nvim",
      "mrcjkb/haskell-tools.nvim",
      "HallerPatrick/py_lsp.nvim",
      "mfussenegger/nvim-jdtls",
      {
        "ray-x/lsp_signature.nvim",
        opts = {
          hint_enable = false,
          hint_prefix = "",
        },
      },
      "barreiroleo/ltex_extra.nvim",
      "lervag/vimtex",
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.ruff,
          null_ls.builtins.formatting.yamlfmt,
          null_ls.builtins.formatting.latexindent,
          null_ls.builtins.formatting.beautysh,
          null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "spaces" },
          }),
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.formatting.mdformat.with({
            extra_args = { "--wrap", "80", "--number" },
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
    opts = {
      ensure_installed = { "stylua", "markdownlint", "clang-format" },
    },
  },
}
