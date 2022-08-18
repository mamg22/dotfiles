local globalaugroup = vim.api.nvim_create_augroup("globalaugroup",{})
local filespecific = vim.api.nvim_create_augroup("filespecific",{})

vim.api.nvim_create_autocmd({"BufWritePost"}, {
    pattern = {"*Xresources", "*Xdefaults"},
    command = "!xrdb %",
    group = filespecific,
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufFilePre", "BufRead"}, {
    pattern = {"*.md"},
    command = "set filetype=markdown.pandoc",
    group = filespecific,
})

vim.api.nvim_create_autocmd({"TextYankPost"}, {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = globalaugroup,
})

