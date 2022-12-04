-- Vim Options
vim.opt.timeoutlen = 500
vim.opt.relativenumber = true
vim.opt.laststatus = 3
vim.opt.pumheight = 20
vim.opt.clipboard = ""
vim.opt.lazyredraw = true
vim.opt.showtabline = 0
vim.opt.completeopt = [[menuone,noinsert,noselect]]
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "catppuccin"
lvim.leader = "space"

-- unmapping defaults
lvim.keys.normal_mode["<C-j>"] = false
lvim.keys.normal_mode["<C-l>"] = false
lvim.keys.normal_mode["<C-k>"] = false
lvim.keys.insert_mode["<M-j>"] = false
lvim.keys.insert_mode["<M-k>"] = false

-- navigation
lvim.keys.normal_mode["<M-j>"] = "<C-w>j"
lvim.keys.normal_mode["<M-k>"] = "<C-w>k"
lvim.keys.normal_mode["<M-l>"] = "<C-w>l"
lvim.keys.normal_mode["<M-h>"] = "<C-w>h"

-- cmp
local cmp = require("cmp")
local mappings = {
  ['<A-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
  ['<A-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  ['<A-p>'] = cmp.mapping.scroll_docs(-4),
  ['<A-n>'] = cmp.mapping.scroll_docs(4),
}
lvim.builtin.cmp.cmdline.enable = true
lvim.builtin.cmp.mapping = vim.tbl_deep_extend("keep", mappings, lvim.builtin.cmp.mapping)

-- lsp
local lsp_diagnostics = {
  update_in_insert = true,
  float = {
    border = "rounded"
  }
}
local buffer_mappings = {
  normal_mode = {
    ["ge"] = { function() require("telescope.builtin").diagnostics() end, "Display Workplace Diagnostics" },
    ["gr"] = { function() require("telescope.builtin").lsp_references() end, "Goto References" },
    ["gd"] = { function() require("telescope.builtin").lsp_definitions() end, "Goto Definitions" },
    ["gI"] = { function() require("telescope.builtin").lsp_implementations() end, "Goto Implementations" }
  }
}
lvim.lsp.diagnostics = vim.tbl_deep_extend("keep", lsp_diagnostics, lvim.lsp.diagnostics)
lvim.lsp.buffer_mappings = vim.tbl_deep_extend("keep", buffer_mappings, lvim.lsp.buffer_mappings)

-- useful
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<CR>"] = "o<ESC>"
lvim.keys.normal_mode["0"] = "^"
lvim.keys.normal_mode["[d"] = ":lua vim.diagnostic.goto_prev()<CR>"
lvim.keys.normal_mode["]d"] = ":lua vim.diagnostic.goto_next()<CR>"
lvim.keys.normal_mode["[c"] = ":lua require('gitsigns').prev_hunk()<CR>"
lvim.keys.normal_mode["]c"] = ":lua require('gitsigns').next_hunk()<CR>"

-- which-key
lvim.builtin.which_key.mappings["s"] = nil
lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  b = { "<cmd>Telescope buffers<cr>", "Open Buffers" },
  f = { "<cmd>Telescope find_files<cr>", "Find File" },
  h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
  H = { "<cmd>Telescope highlights<cr>", "Find Highlights" },
  g = { "<cmd>Telescope live_grep<cr>", "Find Text" },
  R = { "<cmd>Telescope registers<cr>", "Find Registers" },
  k = { "<cmd>Telescope keymaps<cr>", "Find Keymaps" },
  c = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find Text In Current Buffer" },
  C = { "<cmd>Telescope commands<cr>", "Find Commands" },
  r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
}

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.prompt_prefix = "🔍 "
lvim.builtin.telescope.defaults.selection_caret = "> "
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  ".git/"
}
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<A-j>"] = actions.move_selection_next,
    ["<A-k>"] = actions.move_selection_previous,
    ["<A-n>"] = actions.cycle_history_next,
    ["<A-p>"] = actions.cycle_history_prev,
  },
  n = {
    ["<A-j>"] = actions.move_selection_next,
    ["<A-k>"] = actions.move_selection_previous,
    ["<A-n>"] = actions.preview_scrolling_down,
    ["<A-p>"] = actions.preview_scrolling_up
  },
}

lvim.builtin.project.active = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.bufferline.active = false
lvim.builtin.breadcrumbs.active = true
lvim.builtin.terminal.active = false
lvim.builtin.indentlines.active = false
lvim.builtin.illuminate.active = false
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

lvim.builtin.alpha.dashboard.section.header.val = {
  [[                               __                ]],
  [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
  [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
  [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
  [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
  [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "haskell",
  "markdown",
  "markdown_inline",
  "html",
  "go",
  "erlang"
}

require("lspconfig.ui.windows").default_options.border = "rounded"

---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "hls" })
local opts = {
  cmd = {
    "haskell-language-server-9.2.4", "--lsp"
  }
} -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("hls", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "hls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  { "hrsh7th/cmp-cmdline" },
  { "gpanders/editorconfig.nvim" },
  { "p00f/nvim-ts-rainbow" },
  { "nvim-treesitter/playground" },
  {
    'stevearc/dressing.nvim',
    config = function()
      require("dressing").setup {
        input = {
          insert_only = false
        }
      }
    end
  },
  {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup()
    end
  },
  {
    "catppuccin/nvim", as = "catppuccin",
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
          dap = {
            enabled = true,
            enable_ui = true,
          },
          navic = {
            enabled = true,
            custom_bg = "NONE",
          },
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
          TelescopeTitle = { fg = cp.subtext0 }
        },
      })

      vim.api.nvim_command "colorscheme catppuccin"
    end
  }
}


-- SOME PROPER CUSTOM CONFIGURATION --

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("editorconfig", { clear = true }),
  pattern = "*.editorconfig",
  desc = "Refresh open buffers configuration on .editorconfig save",
  callback = function()
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) then
        require("editorconfig").config(buf)
      end
    end
  end,
})
