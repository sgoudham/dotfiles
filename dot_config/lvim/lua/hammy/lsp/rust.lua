local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
local codelldb_adapter = {
  type = "server",
  port = "${port}",
  executable = {
    command = mason_path .. "bin/codelldb",
    args = { "--port", "${port}" },
  },
}

pcall(function()
  require("rust-tools").setup({
    tools = {
      reload_workspace_from_cargo_toml = true,
      runnables = {
        use_telescope = true,
      },
      inlay_hints = {
        auto = true,
        only_current_line = false,
        show_parameter_hints = false,
        parameter_hints_prefix = "<-",
        other_hints_prefix = "=> ",
        highlight = "Comment",
      },
      hover_actions = {
        border = "rounded",
      },
      on_initialized = function()
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
          pattern = { "*.rs" },
          callback = function()
            local _, _ = pcall(vim.lsp.codelens.refresh)
          end,
        })
      end,
    },
    dap = {
      adapter = codelldb_adapter,
    },
    server = {
      on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        local rt = require("rust-tools")
        vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
      end,

      capabilities = require("lvim.lsp").common_capabilities(),
      settings = {
        ["rust-analyzer"] = {
          lens = {
            enable = true,
          },
          checkOnSave = {
            enable = true,
            command = "clippy",
          },
        },
      },
    },
  })
end)

lvim.builtin.dap.on_config_done = function(dap)
  dap.adapters.codelldb = codelldb_adapter
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        vim.fn.jobstart("cargo test --no-run")
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
    },
  }
end

-- vim.api.nvim_set_keymap("n", "<m-d>", "<cmd>RustOpenExternalDocs<Cr>", { noremap = true, silent = true })

-- lvim.builtin.which_key.mappings["C"] = {
--   name = "Rust",
--   r = { "<cmd>RustRunnables<Cr>", "Runnables" },
--   t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
--   m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
--   c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
--   p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
--   d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
--   v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
--   R = {
--     "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
--     "Reload Workspace",
--   },
--   o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
--   y = { "<cmd>lua require'crates'.open_repository()<cr>", "[crates] open repository" },
--   P = { "<cmd>lua require'crates'.show_popup()<cr>", "[crates] show popup" },
--   i = { "<cmd>lua require'crates'.show_crate_popup()<cr>", "[crates] show info" },
--   f = { "<cmd>lua require'crates'.show_features_popup()<cr>", "[crates] show features" },
--   D = { "<cmd>lua require'crates'.show_dependencies_popup()<cr>", "[crates] show dependencies" },
-- }
