return {
  {
    "feline-nvim/feline.nvim",
    config = function()
      local feline = require("feline")

      feline.setup({
        components = require("extra.feline").get(),
        force_inactive = {
          filetypes = {
            "^lazy$",
            "^startify$",
            "^fugitive$",
            "^fugitiveblame$",
            "^qf$",
            "^help$",
          },
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
