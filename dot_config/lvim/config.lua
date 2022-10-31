-- Vim Options
vim.opt.laststatus = 3
vim.opt.timeoutlen = 500
vim.opt.relativenumber = true
vim.opt.pumheight = 20
vim.opt.clipboard = ""
vim.opt.cmdheight = 1
vim.opt.lazyredraw = true
vim.opt.showtabline = 0
vim.opt.completeopt = [[menuone,noinsert,noselect]]

lvim.log.level = "warn"
lvim.format_on_save = false
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
lvim.colorscheme = "catppuccin"

local lsp_diagnostics = {
  update_in_insert = true,
  float = {
    border = "rounded"
  }
}
lvim.lsp.diagnostics = vim.tbl_deep_extend("keep", lsp_diagnostics, lvim.lsp.diagnostics)

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- unmapping defaults
lvim.keys.normal_mode["<C-h>"] = false
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

-- telescope
local buffer_mappings = {
  normal_mode = {
    ["ge"] = { function() require("telescope.builtin").diagnostics() end, "Display Workplace Diagnostics" },
    ["gr"] = { function() require("telescope.builtin").lsp_references() end, "Goto References" },
    ["gd"] = { function() require("telescope.builtin").lsp_definitions() end, "Goto Definitions" },
    ["gI"] = { function() require("telescope.builtin").lsp_implementations() end, "Goto Implementations" }
  }
}
lvim.lsp.buffer_mappings = vim.tbl_deep_extend("keep", buffer_mappings, lvim.lsp.buffer_mappings)

-- useful
lvim.keys.normal_mode["<A-p>"] = "<C-u>"
lvim.keys.normal_mode["<A-n>"] = "<C-d>"
lvim.keys.normal_mode["<CR>"] = "o<ESC>"
lvim.keys.normal_mode["0"] = "^"
lvim.keys.normal_mode["[d"] = ":lua vim.diagnostic.goto_prev()<CR>"
lvim.keys.normal_mode["]d"] = ":lua vim.diagnostic.goto_next()<CR>"
lvim.keys.normal_mode["[c"] = ":lua require('gitsigns').prev_hunk()<CR>"
lvim.keys.normal_mode["]c"] = ":lua require('gitsigns').next_hunk()<CR>"
lvim.keys.normal_mode["<leader>ra"] = ":lua require('user.haskell').run_haskell()<CR>"

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

local cmp = require("cmp")
local mappings = {
  ['<A-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
  ['<A-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  ['<A-p>'] = cmp.mapping.scroll_docs(-4),
  ['<A-n>'] = cmp.mapping.scroll_docs(4),

}
local cmdline = {
  options = {
    {
      type = ":",
      sources = {
        { name = "path" },
        { name = "cmdline" },
      },
    },
  },
}
lvim.builtin.cmp.mapping = vim.tbl_deep_extend("keep", mappings, lvim.builtin.cmp.mapping)
lvim.builtin.cmp.cmdline = vim.tbl_deep_extend("keep", cmdline, lvim.builtin.cmp.cmdline)

local _, actions = pcall(require, "telescope.actions")
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
lvim.builtin.telescope.pickers = {
  find_files = {
    hidden = true,
  },
  live_grep = {
    --@usage don't include the filename in the search results
    only_sort_text = true,
  },
  grep_string = {
    only_sort_text = true,
  },
  planets = {
    show_pluto = true,
    show_moon = true,
  },
  git_files = {
    hidden = true,
    previewer = true,
    show_untracked = true,
  },
  lsp_references = {
    initial_mode = "normal",
  },
  lsp_definitions = {
    initial_mode = "normal",
  },
  lsp_declarations = {
    initial_mode = "normal",
  },
  lsp_implementations = {
    initial_mode = "normal",
  },
}
lvim.builtin.telescope.defaults.layout_config = {
  bottom_pane = {
    height = 25,
    preview_cutoff = 120,
    prompt_position = "top"
  },
  center = {
    height = 0.4,
    preview_cutoff = 40,
    prompt_position = "top",
    width = 0.5
  },
  cursor = {
    height = 0.9,
    preview_cutoff = 40,
    width = 0.8
  },
  horizontal = {
    height = 0.9,
    preview_cutoff = 120,
    prompt_position = "bottom",
    width = 0.8
  },
  vertical = {
    height = 0.9,
    preview_cutoff = 40,
    prompt_position = "bottom",
    width = 0.8
  }
}


-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.project.active = true
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = false
lvim.builtin.bufferline.active = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.terminal.active = false
lvim.builtin.indentlines.active = false
lvim.builtin.illuminate.active = false
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- lvim.builtin.bufferline.highlights = {
--   background = {
--     italic = false,
--   },
--   buffer_selected = {
--     italic = false,
--     bold = true,
--   },
--   diagnostic_selected = {
--     italic = false
--   },
--   hint_selected = {
--     italic = false
--   },
--   hint_diagnostic_selected = {
--     italic = false
--   },
--   info_selected = {
--     italic = false
--   },
--   info_diagnostic_selected = {
--     italic = false
--   },
--   warning_selected = {
--     italic = false
--   },
--   warning_diagnostic_selected = {
--     italic = false
--   },
--   error_selected = {
--     italic = false
--   },
--   error_diagnostic_selected = {
--     italic = false
--   },
--   duplicate_selected = {
--     italic = false
--   },
--   duplicate_visible = {
--     italic = false
--   },
--   duplicate = {
--     italic = false
--   },
--   pick_selected = {
--     italic = false
--   },
--   pick_visible = {
--     italic = false
--   },
--   pick = {
--     italic = false
--   },
-- }

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
  "go"
}

-- generic LSP settings

-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

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
        compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
        transparent_background = false,
        term_colors = true,
        styles = {
          comments = {},
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        integrations = {
          ts_rainbow = true,
          bufferline = true,
          native_lsp = {
            virtual_text = {
              errors = {},
              hints = {},
              warnings = {},
              information = {}
            }
          }
        },
        custom_highlights = {
          ErrorMsg = { fg = cp.red, style = { "bold" } },

          -- Treesitter
          TSProperty = { style = {} },
          TSInclude = { style = {} },
          TSOperator = { style = { "bold" } },
          TSKeywordOperator = { style = { "bold" } },
          TSPunctSpecial = { style = { "bold" } },
          TSFloat = { style = { "bold" } },
          TSNumber = { style = { "bold" } },
          TSBoolean = { style = { "bold" } },
          TSConditional = { style = { "bold" } },
          TSRepeat = { style = { "bold" } },
          TSException = { style = {} },
          TSConstBuiltin = { style = {} },
          TSFuncBuiltin = { style = {} },
          TSTypeBuiltin = { style = {} },
          TSVariableBuiltin = { style = {} },
          TSFunction = { style = {} },
          TSParameter = { style = {} },
          TSKeywordFunction = { style = {} },
          TSKeyword = { style = {} },
          TSMethod = { style = {} },
          TSNamespace = { style = {} },
          TSStringRegex = { style = {} },
          TSVariable = { style = {} },
          TSTagAttribute = { style = {} },
          TSURI = { style = { "underline" } },
          TSLiteral = { style = {} },
          TSEmphasis = { style = {} },
          TSStringEscape = { style = {} },
          ["@namespace"] = { style = {} },
          ["@parameter"] = { style = {} },
          ["@text.uri"] = { style = {} },
          ["@text.literal"] = { style = {} },

          FloatBorder = { fg = "#cdd6f4", bg = "#181825" }
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
