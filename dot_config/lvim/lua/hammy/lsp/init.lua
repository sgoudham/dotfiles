require("hammy.lsp.haskell")
require("hammy.lsp.rust")

require("lspconfig.ui.windows").default_options.border = "rounded"

local lsp_diagnostics = {
  update_in_insert = true,
  float = { border = "rounded" },
}
local buffer_mappings = {
  normal_mode = {
    ["ge"] = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      "Display Workplace Diagnostics",
    },
    ["gr"] = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      "Goto References",
    },
    ["gd"] = {
      function()
        require("telescope.builtin").lsp_definitions()
      end,
      "Goto Definitions",
    },
    ["gI"] = {
      function()
        require("telescope.builtin").lsp_implementations()
      end,
      "Goto Implementations",
    },
  },
}

lvim.lsp.diagnostics = vim.tbl_deep_extend("keep", lsp_diagnostics, lvim.lsp.diagnostics)
lvim.lsp.buffer_mappings = vim.tbl_deep_extend("keep", buffer_mappings, lvim.lsp.buffer_mappings)

-- Requires `:LvimCacheReset` to take effect
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "hls", "rust_analyzer" })

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
