local mapopts = {silent = true, noremap = true}

vim.api.nvim_set_keymap('n', '<Leader>bn', [[<Cmd>bn<CR>]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>bp', [[<Cmd>bp<CR>]], mapopts)

vim.api.nvim_set_keymap('n', '<Leader>y', [["+y]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>Y', [["+Y]], mapopts)
vim.api.nvim_set_keymap('v', '<Leader>y', [["+y]], mapopts)

vim.api.nvim_set_keymap('n', '<Leader>pp', [["+p]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>Pp', [["+P]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>pP', [["*p]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>PP', [["*P]], mapopts)

-- Disable space / leader key
vim.api.nvim_set_keymap('n', '<Space>', '<Nop>', mapopts)
vim.api.nvim_set_keymap('v', '<Space>', '<Nop>', mapopts)

vim.api.nvim_set_keymap('t', '<C-q>', [[<C-\><C-n>]], mapopts)

-- Telescope
vim.api.nvim_set_keymap('n', '<Leader>fb', [[<Cmd>lua require('telescope').extensions.file_browser.file_browser()<CR>]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>bb', [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], mapopts)
vim.api.nvim_set_keymap('n', '<Leader>ff', [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], mapopts)

-- pf for panqueca flip
vim.api.nvim_set_keymap("n", "<Leader>pf", "<Cmd>lua require('panqueca').convert()<CR>", mapopts)
