return {
  { -- do not lazyload
    -- and don't use default section operators!
    "nvim-lualine/lualine.nvim",
    lazy = false,
    event = function()
      return {}
    end,
    opts = function(_, opts)
      opts.options.section_separators = ""
    end,
  },
  {
    "LazyVim/LazyVim",
    init = function()
      -- "I" keeps the startup message, which I've grown to like over time
      vim.opt.shortmess:append({ W = true, I = false, c = true, C = true })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "mdformat" },
      },
    },
  },
  {
    "folke/noice.nvim",
    lazy = false,
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
      opts.presets.lsp_doc_border = true
    end,
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
      direction = "float",
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
