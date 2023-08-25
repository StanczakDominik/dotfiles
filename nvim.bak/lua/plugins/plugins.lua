return {
  "folke/which-key.nvim",
  "tpope/vim-unimpaired",
  "preservim/nerdcommenter",
  "tpope/vim-obsession",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
	{"RRethy/nvim-base16", lazy=false, config = function() vim.cmd([[colorscheme base16-solarized-dark]]) end,},
	{
	  "folke/zen-mode.nvim",
	  config = function()
		require("zen-mode").setup {
		  -- your configuration comes here
		  -- or leave it empty to use the default settings
		  -- refer to the configuration section below
				window = {
				options = {
					signcolumn = "no",
					number = false,
					},
				},
				plugins = {
				alacritty = {
					enabled = true,
					font = "14", -- font size
				},
		}
}
		end
	},
	{"folke/twilight.nvim",
  config = function()
    require("twilight").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end}
}


--    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
--
--    use {
--      "folke/trouble.nvim",
--      requires = "kyazdani42/nvim-web-devicons",
--      config = function()
--        require("trouble").setup {
--          -- your configuration comes here
--          -- or leave it empty to use the default settings
--          -- refer to the configuration section below
--        }
--      end
--    }
--
--    use 'tpope/vim-unimpaired'                  -- ]l jumps, etc
--    -- Configurations for Nvim LSP
--
--    -- For luasnip users.
--    use 'L3MON4D3/LuaSnip'
--    use 'saadparwaiz1/cmp_luasnip'
--
--
--    use "rafamadriz/friendly-snippets"
--
--    use {
--  	  'nvim-telescope/telescope.nvim', branch = '0.1.x',
--  	  requires = { {'nvim-lua/plenary.nvim'} }
--    }
--
--    use {'nvim-telescope/telescope-fzf-native.nvim',
--  	  run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
--    }
--    use 'ActivityWatch/aw-watcher-vim'
--
--    use
--    use 'folke/which-key.nvim'
--
--    use {
--  	  'numToStr/Comment.nvim',
--  	  config = function ()
--  		  require("Comment").setup {
--  		  }
--  	  end
--    }
--
--    use 'tpope/vim-fugitive'
--
--    use {
--  	  'kyazdani42/nvim-tree.lua',
--  	  config = function ()
--  		  require("nvim-tree").setup({})
--  	  end
--    }
--
--    use {
--      "nvim-neotest/neotest",
--      requires = {
--        "nvim-lua/plenary.nvim",
--        "nvim-treesitter/nvim-treesitter",
--        "antoinemadec/FixCursorHold.nvim",
--  	  "nvim-neotest/neotest-python",
--      },
--  	config = function ()
--  		require("neotest").setup({
--  		  adapters = {
--  			require("neotest-python")({
--  			  dap = { justMyCode = false },
--  			}),
--  		  },
--  		})
--  	end
--    }
--    use 'mfussenegger/nvim-dap'
--    use 'mfussenegger/nvim-dap-python'
--    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
--    use 'nvim-treesitter/nvim-treesitter-textobjects'
--    use 'akinsho/toggleterm.nvim'
--    require("nvim-treesitter.configs").setup({
--  	  highlight = {
--  		enable = true,
--  	  },
--  	})
--
--
--
--    -- You can specify multiple plugins in a single call
--    -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
--
--    -- You can alias plugin names
--    -- use {'dracula/vim', as = 'dracula'}
--    --
--    use {
--      "epwalsh/obsidian.nvim",
--  	config = function()
--  		require("obsidian").setup({
--  			dir = "~/Notes",
--  			completion = {
--  				nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
--  			},
--  			daily_notes = {
--  				"01_Osobiste/dziennik/daily",
--  			},
--  			use_advanced_uri = true,
--  			})
--  		end
--  		}
--
--  	use {
--  	  "folke/zen-mode.nvim",
--  	  config = function()
--  		require("zen-mode").setup {
--  		  -- your configuration comes here
--  		  -- or leave it empty to use the default settings
--  		  -- refer to the configuration section below
--  		}
--  	  end
--  	}
--  	-- Lua
--  	use {
--  	  "folke/twilight.nvim",
--  	  config = function()
--  		require("twilight").setup {
--  		  -- your configuration comes here
--  		  -- or leave it empty to use the default settings
--  		  -- refer to the configuration section below
--  		}
--  	  end
--  	}
--  end)
