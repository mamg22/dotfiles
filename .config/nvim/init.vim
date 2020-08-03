" mamg22's init.vim

"{{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Core ncm2 completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif
" Sources
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-tagprefix'
Plug 'ncm2/ncm2-vim' | Plug 'shougo/neco-vim'
Plug 'ncm2/ncm2-neosnippet' | Plug 'Shougo/neosnippet.vim'
Plug 'ncm2/ncm2-neoinclude' | Plug 'Shougo/neoinclude.vim'
Plug 'ncm2/ncm2-syntax' | Plug 'shougo/neco-syntax'

" Tag generation and listing
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'

" Snippets
Plug 'Shougo/neosnippet-snippets'

" Status line
Plug 'itchyny/lightline.vim'

" Highlight
Plug 'cespare/vim-toml'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Misc
Plug 'vim-pandoc/vim-pandoc'
" Plug 'junegunn/goyo.vim'

" Colors
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
" Plug 'dracula/vim', {'as': 'dracula'}

call plug#end()
"}}}

"{{{ Core configuration

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
    " iceberg's Specialkey highlight is barely visible
    highlight SpecialKey guifg=#6b7089 guibg=NONE
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

" Use universal ctags
let g:gutentags_ctags_exectuable = 'uctags'

"}}}

"{{{ Autocmd

augroup filespecific
    autocmd!
    autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
    autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
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
nnoremap <Left> :bp<CR>
nnoremap <Right> :bn<CR>

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

"}}}
