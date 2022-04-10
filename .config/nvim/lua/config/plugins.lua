-- Bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1',
  'https://github.com/wbthomason/packer.nvim', install_path})
end

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

    -- Disable for now, got performance issues in my crappy laptop
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
            {'nvim-treesitter/playground'},
        },
        opt = true,
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-file-browser.nvim'},
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

    use {
        'aklt/plantuml-syntax',
        ft = 'plantuml',
    }

    use 'gruvbox-community/gruvbox'
    -- use "ellisonleao/gruvbox.nvim"

    use {
        'ThePrimeagen/vim-be-good',
        cmd = 'VimBeGood',
    }
    use {
        'alec-gibson/nvim-tetris',
        cmd = 'Tetris',
    }

    use 'windwp/nvim-autopairs'

    -- Bootstrap
    if packer_bootstrap then
        require('packer').sync()
    end

end,
    config = {
        max_jobs = 2,
        git = {
            clone_timeout = 1200
        },
    }
})
