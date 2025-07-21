-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Use `<C-H>`, `<C-Up>`, `<M-h>` casing (instead of `<C-h>`, `<C-up>`, -- `<M-H>`)
-- to match the `lhs` of keymap info. Otherwise it will just say that mapping doesn't
-- exist when in fact it does.
local function map(modes, lhs, rhs, opts)
  if type(modes) == "string" then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    opts = vim.tbl_deep_extend("force", { silent = true }, opts or {})
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local function unmap(mode, key)
  vim.keymap.del(mode, key, {})
end

-- Unbind stuff relating to splitting windows
unmap("n", "<leader>wd")
unmap("n", "<leader>bb")
-- Restore "H" & "L" from neovim
unmap("n", "H")
unmap("n", "L")
-- Remove the default quit
unmap("n", "<leader>qq")
-- Idk what this does "Keywordprg"
unmap("n", "<leader>K")
-- I can just type :Lazy
unmap("n", "<leader>l")

-- Rebind format from cf to lf
unmap({ "n", "v" }, "<leader>cf")
map({ "n", "v" }, "<leader>lf", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- Copy/paste with system clipboard
map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
map("n", "gp", '"+p', { desc = "Paste from system clipboard" })
-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
map("x", "gp", '"+P', { desc = "Paste from system clipboard" })

map("n", "0", "0^", { desc = "which_key_ignore" })
map("n", "<CR>", "o<ESC>", { desc = "which_key_ignore" })
map("n", "<S-CR>", "o<ESC>", { desc = "which_key_ignore" })
map("n", "<C-u>", "<C-u>zz", { desc = "which_key_ignore" })
map("n", "<C-d>", "<C-d>zz", { desc = "which_key_ignore" })

map("n", "<leader>w", "<CMD>w<CR>", { desc = "Write", nowait = true })
map("n", "<leader>Q", "<CMD>qa<CR>", { desc = "Quit All" })
map("n", "<leader>q", "<CMD>q<CR>", { desc = "Quit", nowait = true })

map("n", "<M-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<M-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<M-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<M-l>", "<C-w>l", { desc = "Go to right window", remap = true })
