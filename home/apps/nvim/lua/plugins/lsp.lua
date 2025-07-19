return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    init = function()
      require("lspconfig.ui.windows").default_options.border = "rounded"

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
      ---@type lspconfig.Config.command
      servers = {
        lua_ls = {
          ---@type LazyKeysLspSpec[]
          settings = {
            Lua = { telemetry = { enabled = false } },
          },
        },
      },
    },
  },
}
