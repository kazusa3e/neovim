local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = false

-- install packer.nvim automatically
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    packer_bootstrap = true
    vim.fn.system {
        'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path
    }
    vim.cmd [[ packeradd packer.nvim ]]
end

-- load plugin configs
require 'packer'.startup {
    function(use)
        -- libs
        use 'wbthomason/packer.nvim'
        use 'nvim-lua/plenary.nvim'
        use 'lewis6991/impatient.nvim'
        use 'kevinhwang91/promise-async'

        -- features
        use 'nvim-telescope/telescope.nvim'
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        use 'kyazdani42/nvim-tree.lua'
        use 'mickael-menu/zk-nvim'
        use 'folke/trouble.nvim'
        use 'sindrets/diffview.nvim'
        use 'lewis6991/gitsigns.nvim'
        use 'Shatur/neovim-session-manager'
        use 'ethanholz/nvim-lastplace'
        use 'akinsho/toggleterm.nvim'
        use 'lervag/vimtex'
        use 'famiu/bufdelete.nvim'
        use 'jose-elias-alvarez/null-ls.nvim'
        use 'kevinhwang91/nvim-ufo'

        -- appearences
        -- use { 'shatur/neovim-ayu', commit = '88f427fbdd9ba7fe2c60f7c6e6ba68834b39ccd1' }
        use 'shatur/neovim-ayu'
        use 'kyazdani42/nvim-web-devicons'
        use 'nvim-lualine/lualine.nvim'
        use 'lukas-reineke/indent-blankline.nvim'
        use 'kosayoda/nvim-lightbulb'
        use 'kkharji/lspsaga.nvim'
        use 'dnlhc/glance.nvim'
        use 'folke/todo-comments.nvim'

        -- treesitters
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use 'romgrk/nvim-treesitter-context'
        use 'nvim-treesitter/nvim-treesitter-textobjects'

        -- lsp
        use 'neovim/nvim-lspconfig'
        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'

        -- cmp
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-buffer'
        use 'onsails/lspkind-nvim'
        use 'L3MON4D3/LuaSnip'
        use 'saadparwaiz1/cmp_luasnip'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-cmdline'
        use 'benfowler/telescope-luasnip.nvim'
        use 'rafamadriz/friendly-snippets'

        -- edit
        use 'windwp/nvim-autopairs'
        use 'numToStr/Comment.nvim'
        use 'RRethy/vim-illuminate'
        use 'ray-x/lsp_signature.nvim'
        use 'monaqa/dial.nvim'
        use 'AckslD/nvim-trevJ.lua'
        use 'kylechui/nvim-surround'
        -- use 'phaazon/hop.nvim'
        use 'michaeljsmith/vim-indent-object'
        use 'junegunn/vim-easy-align'

        if packer_bootstrap then
            require 'packer'.sync()
        end
    end,
    config = {
        display = {
            open_fn = require 'packer/util'.float
        }
    }
}

require 'plugins/telescope'
require 'plugins/nvim-tree'
require 'plugins/zk'
require 'plugins/trouble'
require 'plugins/diffview'
require 'plugins/gitsigns'
require 'plugins/session-manager'
require 'plugins/toggleterm'
require 'plugins/lastplace'
require 'plugins/ufo'
require 'plugins/vimtex'

require 'plugins/lspsaga'

require 'plugins/treesitter'

require 'plugins/autopairs'
require 'plugins/comment'
require 'plugins/illuminate'
require 'plugins/dial'
require 'plugins/surround'
require 'plugins/lsp_signature'
-- require 'plugins/hop'
require 'plugins/glance'
require 'plugins/todo-comments'
