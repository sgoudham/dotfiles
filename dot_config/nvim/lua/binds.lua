local wk = require("which-key")

-- what a workaround (screw you @nekowinston :sob:)
-- https://github.com/wez/wezterm/discussions/2426
-- https://github.com/neovim/neovim/issues/2252
wk.register({
  ["<A-N>"] = { "<cmd>lua io.popen('wezterm cli split-pane --right --cwd .')<cr>", "All my homies hate OSC 7" },
  ["<A-M>"] = { "<cmd>lua io.popen('wezterm cli split-pane --bottom --cwd .')<cr>", "All my homies hate OSC 7" },
}, { mode = { "n", "i", "v", "t" } })

-- normal binds
wk.register({
  ["0"] = { "0^", "Start of Line" },
  ["<CR>"] = { "o<ESC>", "New Line Without Insert" },
  ["<C-s>"] = { "<cmd>write<cr>", "Save" },
  ["<C-d>"] = { "<C-d>zz", "Half page down" },
  ["<C-u>"] = { "<C-u>zz", "Half page up" },
  n = { "nzzzv", "Next result (centered)" },
  N = { "Nzzzv", "Previous result (centered)" },
  J = { "mzJ`z", "Join lines (stable)" },
  ["<leader>li"] = { "<cmd>LspInfo<cr>", "LSP Info" },
  ["<leader>lI"] = { "<cmd>Mason<cr>", "Mason Info" },
})

-- visual binds
wk.register({
  J = { ":m '>+1<CR>gv=gv", "Move line down" },
  K = { ":m '<-2<CR>gv=gv", "Move line up" },
}, { mode = "v" })

-- terminal binds
wk.register({
  ["<A-Esc>"] = { [[<C-\><C-n>]], "Normal mode" },
}, { mode = "t" })

-- normal + terminal binds
wk.register({
  ["<A-h>"] = { "<cmd>wincmd h<cr>", "Go to the left window" },
  ["<A-j>"] = { "<cmd>wincmd j<cr>", "Go to the down window" },
  ["<A-k>"] = { "<cmd>wincmd k<cr>", "Go to the up window" },
  ["<A-l>"] = { "<cmd>wincmd l<cr>", "Go to the right window" },
}, { mode = { "n", "t" } })

-- leader binds
wk.register({
  p = { [["+p]], "Put from clipboard" },
  w = { [[:w<CR>]], "Quick Save" },
  q = { [[:q<CR>]], "Quick Exit" },
}, { prefix = "<leader>" })

-- nv leader binds
wk.register({
  d = { [["_d]], "Delete w/o yank" },
  y = { [["+y]], "Yank to clipboard" },
}, { prefix = "<leader>", mode = { "n", "v" } })

-- x leader binds
wk.register({
  p = { [["_dP"]], "Put w/o yank" },
}, { prefix = "<leader>", mode = "x" })
