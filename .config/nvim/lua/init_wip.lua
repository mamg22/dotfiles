-- mamg22's init.lua

--[[
    Powered by packer.nvim
    https://github.com/wbthomason/packer.nvim
    Install with
    git clone https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
]]

require('plugins')

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.lazyredraw = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd = true
vim.opt.showmode = false

vim.opt.shortmess:append({c = true})

vim.opt.hlsearch = false

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.signcolumn = "yes"

vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.completeopt = {"noinsert", "menuone", "noselect"}

vim.cmd([[colorscheme gruvbox]])

local function is_linux_term()
    return vim.env.TERM == "linux"
end

if (is_linux_term()) then
    vim.opt.termguicolors = false
    vim.opt.cursorline = false
    vim.cmd([[colorscheme default]])
end

require'lspconfig'.clangd.setup{}

require'compe'.setup {
    enabled = true;
    autocomplete = false;

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = false;
        ultisnips = false;
        luasnip = false;
        emoji = false;
    };
}

require('lualine').setup({
    theme = 'gruvbox'
})
