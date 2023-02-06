local extremely_zen = function()
  require("zen-mode").toggle({ plugins = { twilight = { enabled = true } } })
end

return {
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        twilight = { enabled = false },
      },
    },
    cmd = { "ZenMode" },
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
      { "<leader>Z", extremely_zen, desc = "Extremely Zen Mode" },
    },
    dependencies = { "folke/twilight.nvim" },
  },
}
