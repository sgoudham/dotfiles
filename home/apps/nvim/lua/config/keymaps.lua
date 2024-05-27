local function map(modes, lhs, rhs, opts)
  -- NOTE: Use `<C-H>`, `<C-Up>`, `<M-h>` casing (instead of `<C-h>`, `<C-up>`,
  -- `<M-H>`) to match the `lhs` of keymap info. Otherwise it will say that
  -- Otherwise it will just say that
  -- mapping doesn't exist when in fact it does.
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

local Util = require("lazyvim.util")

-- Unbind stuff relating to terminal
unmap("t", "<esc><esc>")
-- Unbind stuff relating to splitting windows
unmap("n", "<leader>ww")
unmap("n", "<leader>w-")
unmap("n", "<leader>w|")
unmap("n", "<leader>wd")
unmap("n", "<leader>bb")
-- Restore "H" & "L" from neovim
unmap("n", "H")
unmap("n", "L")
-- Unbind moving lines with ALT in INSERT/VISUAL mode
unmap({ "i", "v" }, "<M-j>")
unmap({ "i", "v" }, "<M-k>")
-- Unbind Telescope stuff
unmap("n", "<leader>fn")
-- Idk what this does "Keywordprg"
unmap("n", "<leader>K")
-- Remove the default quit
unmap("n", "<leader>qq")
-- I can just type :Lazy
unmap("n", "<leader>l")

-- Rebind format from cf to lf
unmap({ "n", "v" }, "<leader>cf")
map({ "n", "v" }, "<leader>lf", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- Easy repeat of last macro
map({ "n" }, "Q", '@@', { desc = "Repeat last macro" })

-- Copy/paste with system clipboard
map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
map("n", "gp", '"+p', { desc = "Paste from system clipboard" })
-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
map("x", "gp", '"+P', { desc = "Paste from system clipboard" })

-- I use gl for this
unmap("n", "<leader>cd")
map("n", "gl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Configure diagnostics with borders
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity, float = { border = "rounded" } })
  end
end
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

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
