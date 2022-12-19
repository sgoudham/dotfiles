local cmp = require("cmp")
local mappings = {
  ["<A-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
  ["<A-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
  ["<A-p>"] = cmp.mapping.scroll_docs(-4),
  ["<A-n>"] = cmp.mapping.scroll_docs(4),
}

lvim.builtin.cmp.cmdline.enable = true
lvim.builtin.cmp.mapping = vim.tbl_deep_extend("keep", mappings, lvim.builtin.cmp.mapping)
