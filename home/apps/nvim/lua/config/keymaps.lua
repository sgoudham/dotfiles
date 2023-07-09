-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function unmap(mode, key)
  vim.keymap.del(mode, key, {})
end

unmap("n", "<leader>ww")
unmap("n", "<leader>w-")
unmap("n", "<leader>w|")
unmap("n", "<leader>wd")
unmap("n", "<leader>l")
unmap("n", "H")
unmap("n", "L")
unmap("i", "<M-j>")
unmap("i", "<M-k>")
require("which-key").register({
  ["<leader>w"] = "which_key_ignore",
})

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "0", "0^", { desc = "which_key_ignore " })
map("n", "<CR>", "o<ESC>", { desc = "which_key_ignore " })
map("n", "<C-u>", "<C-u>zz", { desc = "which_key_ignore " })
map("n", "<C-d>", "<C-d>zz", { desc = "which_key_ignore " })

map("n", "<leader>w", "<cmd>w<CR>", { desc = "which_key_ignore", nowait = true })
map("n", "<leader>Q", "<cmd>qa<CR>", { desc = "which_key_ignore" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "which_key_ignore", nowait = true })

-- Clipboard
map("n", "<leader>y", [["+y]], { desc = "which_key_ignore" })
map("n", "<leader>p", [["+p]], { desc = "which_key_ignore" })

map("n", "<M-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<M-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<M-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<M-l>", "<C-w>l", { desc = "Go to right window", remap = true })
