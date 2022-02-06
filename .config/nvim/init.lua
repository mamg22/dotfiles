-- mamg22's init.lua

--[[
    Powered by packer.nvim
    https://github.com/wbthomason/packer.nvim
    Install with
    git clone https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
]]

vim.g.mapleader = " "

require('plugins')

-- Core configuration

require('options')

vim.cmd([[
function! Better_incdec(dir) range
    " Get word under cursor
    let current_word = expand("<cword>")

    " TODO: Jump to the next true or false and change it
    " || search('\<false\>', 'c', line("."))
    " BUG: Pressing either C-x or C-a in whitespace near word
    "      causes it to type true/flase replacing that space
    "      instead of flipping the nearest, example:
    "      This is a true
    "               ^here
    "      results in
    "      This is afalsetrue
    "             
    " TODO: Add support for yes/no, on/off, enabled/disabled?,
    " TODO: Rewrite this in lua or something
    if a:dir == 1
        if current_word ==# "false"
            normal ciwtrue
        elseif current_word ==# "False"
            normal ciwTrue
        elseif current_word ==# "FALSE"
            normal ciwTRUE
        else
            execute "normal! " . v:count1 . "\<C-a>"
        endif
    elseif a:dir == -1
        if current_word ==# "true"
            normal ciwfalse
        elseif current_word ==# "True"
            normal ciwFalse
        elseif current_word ==# "TRUE"
            normal ciwFALSE
        else
            execute "normal! " . v:count1 . "\<C-x>"
        endif
    else
        echoerr "Better_incdec: Invalid argument"
    endif
endf
nnoremap <C-a> <Cmd>call Better_incdec(1)<CR>
nnoremap <C-x> <Cmd>call Better_incdec(-1)<CR>
]])

require('mappings')
require('autocmd')

-- Plugin configuration

-- vim.g.gutentags_cache_dir = vim.fn.expand('~/.cache/nvim/ctags/')

require'nvim-treesitter.configs'.setup{
    highlight = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
        },
    },
}

require('lsp')
require('completion')
-- TODO: Reorder and rename snippet files
require('snips')
require('teles')

require('lualine').setup({
    theme = 'gruvbox'
})

panqueca = require('panqueca')
panqueca.setup({
    shifts = {
        {"true", "false"},
        {"enabled", "disabled",},
        {"yes", "no",},
        {"first", "second", "third"},
        {"systemd", "systemD", config = {case_sensitive = true}},
        --[[ In the future, I'll add something like
        lisp = {
            {"t", "nil"},
        }
        ]]
    }
})
