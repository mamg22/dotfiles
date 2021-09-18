-- mamg22's init.lua

--[[
    Powered by packer.nvim
    https://github.com/wbthomason/packer.nvim
    Install with
    git clone https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
]]

vim.g.mapleader = " "

require('impatient')
require('plugins')

-- Core configuration

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.lazyredraw = true
vim.opt.scrolloff = 4

vim.opt.showcmd = true
vim.opt.showmode = false

vim.opt.inccommand = "nosplit"

vim.opt.hlsearch = false
--vim.opt.ignorecase = true
--vim.opt.smartcase = true

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

-- Key mappings

local mapopts = {silent = true, noremap = true}

vim.api.nvim_set_keymap('n', 'Y', [[y$]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>fb', [[<Cmd>lua require('telescope.builtin').file_browser()<CR>]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>bb', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>ff', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>bn', [[<Cmd>bn<CR>]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>bp', [[<Cmd>bp<CR>]], mapopts)

vim.api.nvim_set_keymap('t', '<C-q>', [[<C-\><C-n>]], mapopts)

-- Autocmd

vim.cmd([[
augroup filespecific
    autocmd!
    autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
    "autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

augroup globalaugroup
    autocmd!
    autocmd TextYankPost * lua vim.highlight.on_yank()
augroup END
]])

-- Plugin configuration

-- vim.g.gutentags_cache_dir = vim.fn.expand('~/.cache/nvim/ctags/')

require'nvim-treesitter.configs'.setup{
    highlight = {
        enable = true
    }
}

local on_attach = function(client, bufnr)    
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end    
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end    

    -- Enable completion triggered by <c-x><c-o>    
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')    

    -- Mappings.    
    local opts = { noremap=true, silent=true }    

    -- See `:help vim.lsp.*` for documentation on any of the below functions    
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)    
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)    
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)    
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)    
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)    
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)    
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)    
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)    
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)    
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)    
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)    
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)    
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)    
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)    
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)    
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)    
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)    
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

require'lspconfig'.clangd.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}
require'lspconfig'.pylsp.setup{
    capabilities = capabilities,
    on_attach = on_attach,
}

local cmp = require('cmp')
cmp.setup {
    completion = {
        autocomplete = false
    },

    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end
    },

    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        })
    },

    sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
    },
}

local function prequire(...)
    local status, lib = pcall(require, ...)
    if (status) then return lib end
    return nil
end

local luasnip = prequire('luasnip')

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif luasnip and luasnip.expand_or_jumpable() then
        return t "<Plug>luasnip-expand-or-jump"
    else
        return t "<Tab>"
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif luasnip and luasnip.jumpable(-1) then
        return t "<Plug>luasnip-jump-prev"
    else
        return t "<S-Tab>"
    end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})

require('lualine').setup({
    theme = 'gruvbox'
})

require('telescope').setup{
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

