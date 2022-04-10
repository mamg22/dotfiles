vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.lazyredraw = true
vim.opt.scrolloff = 4

vim.opt.showcmd = true
vim.opt.showmode = false

-- vim.opt.hlsearch = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.signcolumn = "yes"

vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.completeopt = {"noinsert", "menuone", "noselect"}
vim.opt.shortmess:append({c = true})

vim.cmd([[colorscheme gruvbox]])

-- If running in Linux virtual terminal (tty)
if vim.env.TERM == "linux" then
    vim.opt.termguicolors = false
    vim.opt.cursorline = false
    vim.cmd([[colorscheme default]])
end

-- Disable (for now), because of performance issues
vim.g.loaded_matchparen = 1
