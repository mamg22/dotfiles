local map = vim.keymap.set

local cmd = function(line)
    return "<Cmd>" .. line .. "<CR>"
end

map('n', '<Leader>bn', cmd "bnext")
map('n', '<Leader>bp', cmd "bprevious")
map('n', '<Leader>sf', function()
    local ft = vim.bo.filetype
    if ft == "vim" or ft == "lua" then
        vim.cmd("source %")
    else
        vim.api.nvim_err_writeln("Not in vim or lua file")
    end
end)

-- Disable space / leader key
map({'n', 'v'}, '<Space>', '<Nop>')

map({'n', 'v'}, '<Leader>y', [["+y]])
-- Can't use "+Y, because neovim's `Y` is defined as a mapping
-- which is canceled by the `noremap` option
map('n', '<Leader>Y', [["+y$]])

map({'n', 'v'}, '<Leader>pp', [["+p]])
map({'n', 'v'}, '<Leader>Pp', [["+P]])
map({'n', 'v'}, '<Leader>pP', [["*p]])
map({'n', 'v'}, '<Leader>PP', [["*P]])

map('t', '<C-q>', [[<C-\><C-n>]])

-- Telescope
local telescope = require('telescope')
local tbuiltin = require('telescope.builtin')

map('n', '<Leader>fb', telescope.extensions.file_browser.file_browser)
map('n', '<Leader>bb', tbuiltin.buffers)
map('n', '<Leader>ff', tbuiltin.find_files)

-- pf for panqueca flip
map("n", "<Leader>pf", require('panqueca').convert)

-- dial.nvim
map("n", "<C-a>", require("dial.map").inc_normal())
map("n", "<C-x>", require("dial.map").dec_normal())
map("v", "<C-a>", require("dial.map").inc_visual())
map("v", "<C-x>", require("dial.map").dec_visual())
map("v", "g<C-a>", require("dial.map").inc_gvisual())
map("v", "g<C-x>", require("dial.map").dec_gvisual())
