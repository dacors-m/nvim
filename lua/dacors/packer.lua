-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    --theme
    use({ 'folke/tokyonight.nvim' })
    use({ 'rebelot/kanagawa.nvim' })
    use({ 'EdenEast/nightfox.nvim' })
    use({ 'rose-pine/neovim' })
    use({ "catppuccin/nvim", as = "catppuccin" })
    --tmux
    use({ 'christoomey/vim-tmux-navigator', lazy = false })
    --git
    use({ 'tpope/vim-fugitive' })
    --utilities
    use({ 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } })
    --code
    use({ 'nvim-treesitter/nvim-treesitter' })
    use({ 'folke/sidekick.nvim' })
    use({
        'neovim/nvim-lspconfig',
        requires = {
            { 'mason-org/mason.nvim' },
            { 'mason-org/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            -- Snippets
            { 'saadparwaiz1/cmp_luasnip' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' }
        }
    })
    --markdown
    use({
        'MeanderingProgrammer/render-markdown.nvim',
        after = { 'nvim-treesitter' },
        requires = { 'nvim-mini/mini.nvim', opt = true }, -- if you use the mini.nvim suite
        config = function()
            require('render-markdown').setup({})
        end,
    })
end)
