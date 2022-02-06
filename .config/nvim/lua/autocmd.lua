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
