require("hammy.set")
require("hammy.remap")
require("hammy.formatter")
-- require("hammy.linter")
require("hammy.packer")
require("hammy.lsp")
require("hammy.plugin")

-- Some "Proper" Custom Configuration --
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("editorconfig", { clear = true }),
  pattern = "*.editorconfig",
  desc = "Refresh open buffers configuration on .editorconfig save",
  callback = function()
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) then
        require("editorconfig").config(buf)
      end
    end
  end,
})
