vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  --tmux
  use ({'christoomey/vim-tmux-navigator', lazy = false})

  --theme
  use ({ "catppuccin/nvim", as = "catppuccin" })

  --code
  use ('tpope/vim-fugitive')
  use ('fatih/vim-go')
  use ({ 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'} })

  --utilities
  use ({ 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} }})
  use ('voldikss/vim-floaterm')

  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { {"nvim-lua/plenary.nvim"} }
  }

  use {
    "nvim-neotest/neotest",
    requires = {
        "nvim-neotest/nvim-nio",
        "andythigpen/nvim-coverage",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python"
        }
    }

  
  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},
          {'jose-elias-alvarez/null-ls.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
          {'saadparwaiz1/cmp_luasnip'},
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }
end)
