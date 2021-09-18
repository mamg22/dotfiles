return require('packer').startup({function()
    use 'wbthomason/packer.nvim'

    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'

    use 'neovim/nvim-lspconfig'

    use 'L3MON4D3/LuaSnip'

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
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
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

    --use {
    --    'cespare/vim-toml',
    --    ft = 'toml',
    --}
    use {
        'aklt/plantuml-syntax',
        ft = 'plantuml',
    }

    use 'gruvbox-community/gruvbox'
    -- use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

    use {
        'ThePrimeagen/vim-be-good',
        cmd = 'VimBeGood',
    }
    use {
        'alec-gibson/nvim-tetris',
        cmd = 'Tetris',
    }

    use 'windwp/nvim-autopairs'

    --use {
    --    'nvim-neorg/neorg',
    --    branch = 'unstable',
    --}

    use {
        'lewis6991/impatient.nvim',
    }
end,
    config = {
        max_jobs = 2,
        git = {
            clone_timeout = 1200
        }
    }
})
