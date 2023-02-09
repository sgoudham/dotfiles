local get_python_path = function()
  for _, client in pairs(vim.lsp.get_active_clients()) do
    if client.name == "pyright" then
      local path = client.config.settings.python.pythonPath
      if path ~= nil then
        return path
      else
        return "python"
      end
    end
  end
end

return {
  {
    "jayp0521/mason-nvim-dap.nvim",
    config = function()
      local dap = require("dap")
      local mason_dap = require("mason-nvim-dap")

      mason_dap.setup({
        ensure_installed = { "python", "codelldb" },
        automatic_setup = true,
      })
      mason_dap.setup_handlers({
        -- default handler
        function(source)
          require("mason-nvim-dap.automatic_setup")(source)
        end,

        -- custom handlers
        python = function(_)
          dap.adapters.python = {
            type = "executable",
            command = "debugpy-adapter",
          }

          dap.configurations.python = {
            {
              name = "Launch current file",
              type = "python",
              request = "launch",
              program = "${file}",
              pythonPath = get_python_path,
            },
            {
              name = "Launch pytest",
              type = "python",
              request = "launch",
              module = "pytest",
              pythonPath = get_python_path,
            },
          }

          dap.configurations.java = {
            {
              type = "java",
              request = "attach",
              name = "Debug (Attach) - Remote",
              hostName = "127.0.0.1",
              port = 5005,
            },
          }
        end,
      })

      -- apply suggestions from catppuccin theme
      local sign = vim.fn.sign_define

      sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    end,
    keys = {
      { "<leader>bb", vim.cmd.DapToggleBreakpoint, desc = "Toggle Breakpoint" },
      {
        "<leader>bf",
        function()
          require("dap").list_breakpoints()
        end,
        desc = "List Breakpoints",
      },
      {
        "<leader>bc",
        function()
          require("dap").clear_breakpoints()
        end,
        desc = "Clear Breakpoints",
      },

      { "<leader>dc", vim.cmd.DapContinue, desc = "Start / Continue" },
      {
        "<leader>dj",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>dk",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dd",
        function()
          require("dap").disconnect()
        end,
        desc = "Disconnect",
      },

      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Toggle UI",
      },
    },
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      { "rcarriga/nvim-dap-ui", config = true },
      { "theHamsta/nvim-dap-virtual-text", config = true },
    },
  },
}
