-- TODO: Enable, but only for some filetypes?
-- Disable for now, too slow performance in my crappy laptop
--[[
require('nvim-treesitter.configs').setup{
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
]]
