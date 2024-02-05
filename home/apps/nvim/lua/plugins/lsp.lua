return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "nix",
          "java",
        })
      end
      opts.indent = {
        enable = true,
        disable = { "python", "yaml" },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "barreiroleo/ltex_extra.nvim",
        ft = { "markdown", "tex" },
        dependencies = { "neovim/nvim-lspconfig" },
      },
    },
    ---@class PluginLspOpts
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      local function swap_prefix(before, after)
        for _, keymap in ipairs(keys) do
          local key = keymap[1]
          if key:sub(1, #before) == before then
            keymap[1] = after .. key:sub(#before + 1)
          end
        end
      end

      local leader_c = "<leader>c"
      local leader_l = "<leader>l"
      swap_prefix(leader_c, leader_l)

      keys[#keys + 1] = { "gy", false }
    end,
    opts = {
      diagnostics = { underline = false, update_in_insert = true },
      inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        lua_ls = {
          ---@type LazyKeys[]
          settings = {
            Lua = { telemetry = { enabled = false } },
          },
        },
      },
      setup = {
        ltex = function(_, _)
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client.name == "ltex" then
                require("ltex_extra").setup({
                  load_langs = { "en-GB" }, -- languages for which dictionaries will be loaded
                  init_check = true, -- whether to load dictionaries on startup
                  path = vim.fn.stdpath("data") .. "/spell", -- path to store dictionaries.
                })
              end
            end,
          })
        end,
      },
    },
    config = function()
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          -- lsp
          "deno",
          "nil",
          "ltex-ls",
          "marksman",
          "yaml-language-server",
          "elixir-ls",
          -- linter
          "yamllint",
          "jsonlint",
        })
      end
    end,
    keys = {
      { "<leader>cm", false },
    },
  },
  {
    "stevearc/conform.nvim",
    keys = {
      { "<leader>cF", false },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.window = {
        completion = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
        }),
      }
      opts.experimental.ghost_text = false
      opts.mapping = {
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<M-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<M-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.confirm({ select = true })
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
              cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
              fallback()
            end
          end,
          s = cmp.mapping.confirm({ select = true }),
          c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
      }
      opts.sources = {
        { name = "nvim_lsp", priority = 200 },
        { name = "path", priority = 150 },
        { name = "buffer", priority = 125 },
      }
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    opts = {
      tools = { inlay_hints = { auto = false } },
    },
  },
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_mappings_enabled = 0
    end,
  },
}
