-- puts current line number on current line
-- relative line numbers on everything else
vim.opt.number = true
vim.opt.relativenumber = true

-- default to 4 spaces for indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- keep some lines at the top/bottom of the window
vim.opt.scrolloff = 8

-- smarter smartindent
vim.opt.cindent = true

-- global statusline
vim.opt.laststatus = 3

-- apparently this makes cmp work
vim.opt.completeopt = "menu,menuone,noselect"

-- no more jumping around when signs arrive
vim.opt.signcolumn = "yes"

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

-- gui/neovide stuff
vim.opt.guifont = "Fantasque Sans Mono:h13"

if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_cursor_vfx_particle_density = 50
end
