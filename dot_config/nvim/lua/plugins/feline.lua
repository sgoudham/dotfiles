return {
  {
    "feline-nvim/feline.nvim",
    config = function()
      local feline = require("feline")
      local ctp_feline = require("catppuccin.groups.integrations.feline")

      feline.setup({
        components = ctp_feline.get(),
        force_inactive = {
          filetypes = {
            "^packer$",
            "^startify$",
            "^fugitive$",
            "^fugitiveblame$",
            "^qf$",
            "^help$",
          },
        },
      })
      -- catppuccin statusline
      ctp_feline.setup({})
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
