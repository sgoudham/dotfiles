lvim.builtin.telescope.defaults.prompt_prefix = "🔍 "
lvim.builtin.telescope.defaults.selection_caret = "> "
lvim.builtin.telescope.defaults.file_ignore_patterns = { ".git/" }

lvim.builtin.which_key.mappings["f"] = {
  name = "Find",
  b = { "<cmd>Telescope buffers<CR>", "Open Buffers" },
  f = { "<cmd>Telescope find_files<CR>", "Find File" },
  h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
  H = { "<cmd>Telescope highlights<CR>", "Find Highlights" },
  g = { "<cmd>Telescope live_grep<CR>", "Find Text" },
  R = { "<cmd>Telescope registers<CR>", "Find Registers" },
  k = { "<cmd>Telescope keymaps<CR>", "Find Keymaps" },
  c = {
    "<cmd>Telescope current_buffer_fuzzy_find<CR>",
    "Find Text In Current Buffer",
  },
  C = { "<cmd>Telescope commands<CR>", "Find Commands" },
  r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
  p = { "<cmd>Telescope projects<CR>", "Open Projects" },
  d = { "<cmd>Easypick chezmoi<CR>", "Open Dotfiles" },
}

local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<A-j>"] = actions.move_selection_next,
    ["<A-k>"] = actions.move_selection_previous,
    ["<A-n>"] = actions.cycle_history_next,
    ["<A-p>"] = actions.cycle_history_prev,
  },
  n = {
    ["<A-j>"] = actions.move_selection_next,
    ["<A-k>"] = actions.move_selection_previous,
    ["<A-n>"] = actions.preview_scrolling_down,
    ["<A-p>"] = actions.preview_scrolling_up,
  },
}
