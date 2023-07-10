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
      window = { mappings = { ["o"] = "open" } },
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
}
