-- mamg22's init.lua

--[[
    Powered by packer.nvim
    https://github.com/wbthomason/packer.nvim
    Install with
    git clone https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
]]

vim.g.mapleader = " "

require('config')

-- Core configuration

-- Plugin configuration

require('lualine').setup({
    theme = 'gruvbox'
})

