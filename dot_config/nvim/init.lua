-- set this early so plugins etc can all use it
vim.g.mapleader = " "
-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 0
-- vim.g.loaded_netrwPlugin = 0

-- bootstrap & set up lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  install = {
    colorscheme = { "catppuccin" },
    missing = true,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  ui = {
    border = "rounded",
    icons = {
      list = { "●" },
    },
  },
})

-- load remaining config
require("options")
require("binds")

vim.api.nvim_create_augroup("disable_mini", {})
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  group = "disable_mini",
  pattern = { "NvimTr*" },
  callback = function()
    vim.b.miniindentscope_disable = true
    vim.b.minicursorword_disable = true
  end,
})
vim.api.nvim_create_autocmd({ "User" }, {
  group = "disable_mini",
  pattern = "AlphaReady",
  callback = function()
    vim.b.miniindentscope_disable = true
    vim.b.minicursorword_disable = true
  end,
})

-- highlight yank
vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  group = "highlight_yank",
  pattern = { "*" },
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = 150,
    })
  end,
})
-- Disable semantic highlights
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})
-- Stop comments on new lines when pressing 'o'
vim.api.nvim_create_augroup("stop_comments_on_o", {})
vim.api.nvim_create_autocmd("BufEnter", {
  group = "stop_comments_on_o",
  callback = function(_)
    vim.opt.formatoptions:remove("o")
  end,
})
vim.api.nvim_create_augroup("last_loc", {})
vim.api.nvim_create_autocmd("BufReadPost", {
  group = "last_loc",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
