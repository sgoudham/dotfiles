-- vim.api.nvim_create_autocmd("BufWritePost",
--   {
--     group = vim.api.nvim_create_augroup("haskell", { clear = true }),
--     pattern = "*.hs",
--     desc = "Automatically output "
--     callback = function()
--   }
-- )

local M = {}

M.haskell_buf = nil

local append_data = function(_, data)
  if data then
    vim.api.nvim_buf_set_lines(M.haskell_buf, -1, -1, false, data)
  end
end

function M:run_haskell()
  local path_to_file = vim.fn.expand("%:p")

  if M.haskell_buf == nil then
    vim.cmd [[vsplit]]
    vim.cmd [[enew]]
    M.haskell_buf = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_attach(M.haskell_buf, false, {
      on_detach = function()
        M.haskell_buf = nil
      end
    })
  end

  vim.api.nvim_buf_set_lines(M.haskell_buf, 0, -1, false, { "---- RESULTS ----" })
  vim.fn.jobstart("runhaskell " .. path_to_file, {
    stdout_buffered = true,
    on_stdout = append_data,
    on_stderr = append_data
  })
end

return M
