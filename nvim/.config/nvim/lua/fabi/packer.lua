vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-lua/plenary.nvim',
        tag = 'v0.1.4',
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
    }

    use { "catppuccin/nvim", as = "catppuccin" }

    use {
        'nvim-treesitter/nvim-treesitter',
        tag = 'v0.9.1',
        run = ':TSUpdate',
    }

    use {
        'ThePrimeagen/harpoon'
    }

    -- use 'tpope/vim-fugitive'
    -- use 'mbbill/undotree'

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                tag = 'v1.8.3',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            {
                'williamboman/mason-lspconfig.nvim',
                tag = 'v1.20.0',
            },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            {
                'L3MON4D3/LuaSnip',
                tag = 'v2.0.0',
            },
        }
    }

    use 'mfussenegger/nvim-dap' -- Debugging

    use { 'tpope/vim-obsession' }

    use {
        'lervag/vimtex',
        tag = 'v2.14',
    }
    use {
        'kaarmu/typst.vim',
        ft = { 'typst' },
    }

    use {
        'cloudsftp/peek.nvim',
        run = 'deno task --quiet build:fast',
    }
end)
