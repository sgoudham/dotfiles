lvim.plugins = {
  { "andweeb/presence.nvim" },
  { "hrsh7th/cmp-cmdline" },
  { "gpanders/editorconfig.nvim" },
  { "p00f/nvim-ts-rainbow" },
  { "nvim-treesitter/playground" },
  { "nvim-treesitter/nvim-treesitter-textobjects"},
  { "simrat39/rust-tools.nvim" },
  {
    "saecki/crates.nvim",
    tag = "v0.3.0",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
        popup = {
          border = "rounded",
        },
      })
    end,
  },
  {
    "axkirillov/easypick.nvim",
    config = function()
      local easypick = require("easypick")
      easypick.setup({
        pickers = {
          {
            name = "chezmoi",
            command = [[chezmoi managed -x encrypted -i files | awk '{ printf("%s/%s\n", "~", $0) }']],
            opts = require("telescope.themes").get_dropdown({}),
          },
        },
      })
    end,
  },
  {
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({ input = { insert_only = false } })
    end,
  },
  {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      local cp = require("catppuccin.palettes").get_palette()

      require("catppuccin").setup({
        flavour = "mocha",
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        transparent_background = true,
        term_colors = true,
        no_italic = true,
        integrations = {
          ts_rainbow = true,
          which_key = true,
          dap = { enabled = true, enable_ui = true },
          navic = { enabled = true, custom_bg = "NONE" },
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
        },
      })

      vim.api.nvim_command("colorscheme catppuccin")
    end,
  },
}
