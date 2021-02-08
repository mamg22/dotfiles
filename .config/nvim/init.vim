" mamg22's init.vim

"{{{ Plugins

" Powered by minpac
" https://github.com/k-takata/minpac
" install with
" git clone https://github.com/k-takata/minpac.git ~/.config/nvim/pack/minpac/opt/minpac

packadd minpac

if exists('g:loaded_minpac')
    call minpac#init()

    call minpac#add('k-takata/minpac', {'type': 'opt'})

    " Core ncm2 completion
    call minpac#add('ncm2/ncm2')
    call minpac#add('roxma/nvim-yarp')
    if !has('nvim')
        call minpac#add('roxma/vim-hug-neovim-rpc')
    endif
    " Sources
    call minpac#add('ncm2/ncm2-pyclang')
    call minpac#add('ncm2/ncm2-jedi')
    call minpac#add('ncm2/ncm2-bufword')
    call minpac#add('ncm2/ncm2-path')
    " call minpac#add('ncm2/ncm2-tagprefix'
    call minpac#add('ncm2/ncm2-vim') | call minpac#add('shougo/neco-vim')
    call minpac#add('ncm2/ncm2-neosnippet') | call minpac#add('Shougo/neosnippet.vim')
    call minpac#add('ncm2/ncm2-neoinclude') | call minpac#add('Shougo/neoinclude.vim')
    call minpac#add('ncm2/ncm2-syntax') | call minpac#add('shougo/neco-syntax')

    " Tag generation and listing
    call minpac#add('ludovicchabant/vim-gutentags')
    call minpac#add('majutsushi/tagbar')

    " Snippets
    call minpac#add('Shougo/neosnippet-snippets')

    " Status line
    call minpac#add('itchyny/lightline.vim')

    " Highlight
    call minpac#add('cespare/vim-toml')
    " call minpac#add('vim-pandoc/vim-pandoc-syntax')

    " Misc
    " call minpac#add('vim-pandoc/vim-pandoc')
    " call minpac#add('junegunn/goyo.vim')

    " Colors
    call minpac#add('cocopon/iceberg.vim')
    " call minpac#add('arcticicestudio/nord-vim')
    " call minpac#add('dracula/vim', {'name': 'dracula'})
endif
"}}}

"{{{ Core configuration

command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

"
syntax on
" Detection
filetype plugin indent on

" Tab size 4 and spaces instead
set tabstop=4
set shiftwidth=4
set expandtab

set lazyredraw

set number
set showcmd
set noshowmode

set shortmess+=c

set nocompatible

set nohlsearch

set splitbelow splitright

"}}}

"{{{ Style configuration

if (!empty($DISPLAY))
    " Running in GUI
    set termguicolors

    colorscheme iceberg
    " Transparency
    highlight Normal guibg=NONE
    highlight EndOfBUffer guibg=NONE
    hi CursorLine guibg=NONE
    hi LineNr guibg=NONE
    hi Conceal guibg=NONE guifg=#ada0d3
    set cursorline
else
    " Linux console
    set t_Co=16
    colorscheme default
endif

"}}}

"{{{ Plugin configuration

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'

if (!empty($DISPLAY))
    let g:lightline = {
                    \ 'colorscheme':'iceberg'
                    \}
else
    let g:lightline = {
                    \ 'colorscheme':'16color'
                    \}
endif

"let g:pandoc#syntax#conceal#use = 0
" Disable automatic folding and spellcheck
let g:pandoc#modules#disabled = ["folding", "spell"]

" ncm2 settings

augroup ncm2autocmd
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

set completeopt=noinsert,menuone,noselect

let g:ncm2_pyclang#database_path = [
            \ 'compile_commands.json',
            \ 'build/compile_commands.json'
            \ ]

let g:ncm2_pyclang#library_path = '/usr/lib/llvm-6.0/lib/libclang.so.1'

" Less completion items, because C libraries produce a lot
" let g:ncm2#total_popup_limit = 200

let g:gutentags_cache_dir = expand('~/.cache/nvim/ctags/')

"}}}

"{{{ Autocmd

augroup filespecific
    autocmd!
    autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
    "autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

"}}}

"{{{ Mappings

" Forget the arrow keys
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
vnoremap <Up> <nop>
vnoremap <Down> <nop>
vnoremap <Left> <nop>
vnoremap <Right> <nop>

" and use some of them
nnoremap <silent> <Left> :bp<CR>
nnoremap <silent> <Right> :bn<CR>

" Neosnippet mappings from the doc
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Exit terminal mode with C-q
tnoremap <C-q> <C-\><C-n>

" ncm2 mappings
inoremap <silent> <expr> <cr> (pumvisible() ? ncm2_neosnippet#expand_or("", "<C-Y>") : "\<CR>")
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Quick C++ documentation search with menu to select match
function! Cppman(str)
    exec 'silent !cppman -f ' . shellescape(a:str) . ' | sed -E "s/\s\[.+\]$//g"'  . ' > "/tmp/vim cppman results"'
    split /tmp/vim cppman results
    setlocal nobuflisted
    setlocal readonly
    setlocal nomodifiable
    nnoremap <buffer> <CR> :exec ':term cppman ' . shellescape(getline('.')) <cr>i
    
endf
command! -nargs=1 Cppman :call Cppman('<args>')

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
nnoremap <silent> <C-a> :<C-U>call Better_incdec(1)<CR>
nnoremap <silent> <C-x> :<C-U>call Better_incdec(-1)<CR>

"}}}
