-- puts current line number on current line
-- relative line numbers on everything else
vim.opt.number = true
vim.opt.relativenumber = true

-- free real estate
vim.opt.cmdheight = 0

-- don't show status
vim.opt.showmode = false

-- https://www.reddit.com/r/neovim/comments/10fpqbp/gist_statuscolumn_separate_diagnostics_and/
-- local M = {}
-- _G.Status = M
--
-- ---@return {name:string, text:string, texthl:string}[]
-- function M.get_signs()
--   local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
--   return vim.tbl_map(function(sign)
--     return vim.fn.sign_getdefined(sign.name)[1]
--   end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
-- end
--
-- function M.column()
--   local sign, git_sign
--   for _, s in ipairs(M.get_signs()) do
--     if s.name:find("GitSign") then
--       git_sign = s
--     else
--       sign = s
--     end
--   end
--   local components = {
--     sign and ("%#" .. sign.texthl .. "#" .. sign.text .. "%*") or " ",
--     [[%=]],
--     [[%{&nu?(&rnu&&v:relnum?v:relnum:v:lnum):''} ]],
--     git_sign and ("%#" .. git_sign.texthl .. "#" .. git_sign.text .. "%*") or "  ",
--   }
--   return table.concat(components, "")
-- end
--
-- vim.opt.statuscolumn = [[%!v:lua.Status.column()]]

-- don't jump around when signs appear
vim.opt.signcolumn = "yes"

-- default to 2 spaces for indentation
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- keep some lines at the top/bottom/left/right of the window
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- smarter smartindent
vim.opt.cindent = true

-- global statusline
vim.opt.laststatus = 3

-- apparently this makes cmp work
vim.opt.completeopt = "menu,menuone,noselect"

-- live life dangerously
vim.opt.swapfile = true
vim.opt.backup = true
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo/"
vim.opt.backupdir = vim.fn.stdpath("data") .. "/backup/"
vim.opt.directory = vim.fn.stdpath("data") .. "/swap/"

-- no more noh and incremental search highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- make cursorhold happen faster
vim.opt.updatetime = 100

-- make which key show up faster
vim.opt.timeoutlen = 500

-- 24bit tui colours
vim.opt.termguicolors = true
