vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Autoformat
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Terminal autoinsert
vim.cmd [[autocmd TermOpen * startinsert]]
vim.cmd [[autocmd BufWinEnter,WinEnter term://* startinsert]]

-- Spell check
--vim.opt.spelllang = 'en_us'
--vim.opt.spell = true
