" mamg22's init.vim

lua require('init_wip')

" TODO: Complete convesion to init.lua 

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

let g:gutentags_cache_dir = expand('~/.cache/nvim/ctags/')

"{{{ Autocmd

augroup filespecific
    autocmd!
    autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
    "autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

"}}}

"{{{ Mappings

nnoremap <Left> <Cmd>bp<CR>
nnoremap <Right> <Cmd>bn<CR>

" Exit terminal mode with C-q
tnoremap <C-q> <C-\><C-n>

" Make Y behave as D and C
nnoremap Y y$

" Better increase and decrease which also handles booleans and keeps the case
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

"}}}
