-- unmapping defaults
lvim.keys.normal_mode["<C-j>"] = false
lvim.keys.normal_mode["<C-l>"] = false
lvim.keys.normal_mode["<C-k>"] = false
lvim.keys.insert_mode["<M-j>"] = false
lvim.keys.insert_mode["<M-k>"] = false
lvim.builtin.which_key.mappings["s"] = nil

-- navigation
lvim.keys.normal_mode["<M-j>"] = "<C-w>j"
lvim.keys.normal_mode["<M-k>"] = "<C-w>k"
lvim.keys.normal_mode["<M-l>"] = "<C-w>l"
lvim.keys.normal_mode["<M-h>"] = "<C-w>h"

-- useful
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["J"] = "mzJ`z"
lvim.keys.normal_mode["n"] = "nzzzv"
lvim.keys.normal_mode["N"] = "Nzzzv"
lvim.keys.normal_mode["<CR>"] = "o<ESC>"
lvim.keys.normal_mode["0"] = "^"
lvim.keys.normal_mode["[d"] = ":lua vim.diagnostic.goto_prev()<CR>"
lvim.keys.normal_mode["]d"] = ":lua vim.diagnostic.goto_next()<CR>"
lvim.keys.normal_mode["[c"] = ":lua require('gitsigns').prev_hunk()<CR>"
lvim.keys.normal_mode["]c"] = ":lua require('gitsigns').next_hunk()<CR>"

-- clipboard
lvim.keys.visual_block_mode["<leader>p"] = [["_dp]]
lvim.keys.visual_mode["<leader>y"] = [["+y]]
lvim.keys.normal_mode["<leader>y"] = [["+y]]
lvim.keys.normal_mode["<leader>Y"] = [["+Y]]
