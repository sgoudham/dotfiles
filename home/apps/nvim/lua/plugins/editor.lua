return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          any = {
            { event = "notify", find = "No information available" },
            { event = "msg_show", find = "fewer lines" },
            { event = "msg_show", find = "more lines" },
            {
              event = "lsp",
              kind = "progress",
              find = "Checking document",
              cond = function(message)
                local client = vim.tbl_get(message.opts, "progress", "client")
                return client == "ltex" -- skip checking document indicators
              end,
            },
          },
        },
        opts = { skip = true },
      })
      opts.presets.lsp_doc_border = false
    end,
  },
  {
    "folke/persistence.nvim",
    keys = function()
      -- stylua: ignore
      return {
        { "<leader>as", function() require("persistence").load() end, desc = "Restore Session", },
        { "<leader>al", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session", },
        { "<leader>ad", function() require("persistence").stop() end, desc = "Don't Save Current Session", },
      }
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      enable_normal_mode_for_inputs = true,
      window = { mappings = { ["o"] = "open" } },
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      disable_commit_confirmation = true,
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit kind=replace<cr>", desc = "Open Neogit" },
      { "<leader>gG", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Open Neogit (cwd)" },
    },
  },
  {
    "ahmedkhalf/project.nvim",
    opts = {
      detection_methods = { "pattern" },
    },
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension("projects")
    end,
    keys = {
      { "<leader>fp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  },
  {
    "stevearc/dressing.nvim",
    opts = {
      input = { insert_only = false },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    config = true,
    cmd = "ToggleTerm",
    keys = {
      { [[<C-/>]], "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    },
    opts = {
      -- TODO: Add in keymaps for <M-hjkl> for toggleterm
      open_mapping = [[<C-/]],
      direction = "vertical",
      size = vim.o.columns * 0.5,
      shade_filetypes = {},
      autochdir = true,
      hide_numbers = true,
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      shell = "fish",
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.black,
        -- nls.builtins.diagnostics.ruff,
      })
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}, -- this is equalent to setup({}) function
  },
}
