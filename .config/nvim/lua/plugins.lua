return require('packer').startup({function()
    use 'wbthomason/packer.nvim'

    use 'hrsh7th/nvim-compe'

    use 'neovim/nvim-lspconfig'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
    }
    use {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle',
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'}
        }
    }

    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }


    --use 'ludovicchabant/vim-gutentags'
    --use {
    --    'majutsushi/tagbar',
    --    cmd = {"Tagbar", "TagbarClose", "TagbarCurrentTag", "TagbarDebug",
    --    "TagbarDebugEnd", "TagbarForceUpdate", "TagbarGetTypeConfig",
    --    "TagbarJump", "TagbarJumpNext", "TagbarJumpPrev", "TagbarOpen",
    --    "TagbarOpenAutoClose", "TagbarSetFoldlevel", "TagbarShowTag",
    --    "TagbarToggle", "TagbarTogglePause"},
    --}

    -- use 'itchyny/lightline.vim'

    use {
        'cespare/vim-toml',
        ft = 'toml',
    }
    use {
        'aklt/plantuml-syntax',
        ft = 'plantuml',
    }

    use 'gruvbox-community/gruvbox'

    use {
        'ThePrimeagen/vim-be-good',
        cmd = 'VimBeGood',
    }
    use {
        'alec-gibson/nvim-tetris',
        cmd = 'Tetris',
    }

    use 'windwp/nvim-autopairs'
end,
    config = {
        max_jobs = 2,
        git = {
            clone_timeout = 1200
        }
    }
})
