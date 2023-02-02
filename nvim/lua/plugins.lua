-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme inspired by Atom
  use 'joshdick/onedark.vim'

  -- Simple plugins can be specified as strings
  -- use 'rstacruz/vim-closer'

  -- Lazy loading:
  -- Load on specific commands
  -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  -- use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  -- use {
  --   'w0rp/ale',
  --   ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
  --   cmd = 'ALEEnable',
  --   config = 'vim.cmd[[ALEEnable]]'
  -- }

  -- Plugins can have dependencies on other plugins
  -- use {
  --   'haorenW1025/completion-nvim',
  --   opt = true,
  --   requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  -- }

  -- Plugins can also depend on rocks from luarocks.org:
  -- use {
  --   'my/supercoolplugin',
  --   rocks = {'lpeg', {'lua-cjson', version = '2.1.0'}}
  -- }

  -- You can specify rocks in isolation
  -- use_rocks 'penlight'
  -- use_rocks {'lua-resty-http', 'lpeg'}

  -- Local plugins can be included
  -- use '~/projects/personal/hover.nvim'

  -- Plugins can have post-install/update hooks
  -- use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Post-install/update hook with call of vimscript function with argument
  -- use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- Use specific branch, dependency and run lua file after load
  -- use {
  --   'glepnir/galaxyline.nvim', branch = 'main', config = function() require'statusline' end,
  --   requires = {'kyazdani42/nvim-web-devicons'}
  -- }

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup({
	  on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
		  opts = opts or {}
		  opts.buffer = bufnr
		  vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map('n', ']c', function()
		  if vim.wo.diff then return ']c' end
		  vim.schedule(function() gs.next_hunk() end)
		  return '<Ignore>'
		end, {expr=true})

		map('n', '[c', function()
		  if vim.wo.diff then return '[c' end
		  vim.schedule(function() gs.prev_hunk() end)
		  return '<Ignore>'
		end, {expr=true})

		-- Actions
		map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
		map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
		map('n', '<leader>hS', gs.stage_buffer)
		map('n', '<leader>hu', gs.undo_stage_hunk)
		map('n', '<leader>hR', gs.reset_buffer)
		map('n', '<leader>hp', gs.preview_hunk)
		map('n', '<leader>hb', function() gs.blame_line{full=true} end)
		map('n', '<leader>tb', gs.toggle_current_line_blame)
		map('n', '<leader>hd', gs.diffthis)
		map('n', '<leader>hD', function() gs.diffthis('~') end)
		map('n', '<leader>td', gs.toggle_deleted)

		-- Text object
		map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
	  end
	  })
  end
  }

  use {
	  'nvim-lualine/lualine.nvim',
	  config = function () require('lualine').setup() end
  }

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use 'tpope/vim-unimpaired'                  -- ]l jumps, etc
  -- Configurations for Nvim LSP
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- For luasnip users.
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'


  use "rafamadriz/friendly-snippets"

  use {
	  'nvim-telescope/telescope.nvim', branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {'nvim-telescope/telescope-fzf-native.nvim',
	  run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use 'ActivityWatch/aw-watcher-vim'

  use 'ericbn/vim-solarized'
  use 'folke/which-key.nvim'

  use {
	  'numToStr/Comment.nvim',
	  config = function ()
		  require("Comment").setup {
		  }
	  end
  }

  use 'tpope/vim-fugitive'

  use {
	  'kyazdani42/nvim-tree.lua',
	  config = function ()
		  require("nvim-tree").setup({})
	  end
  }

  use {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
	  "nvim-neotest/neotest-python",
    },
	config = function ()
		require("neotest").setup({
		  adapters = {
			require("neotest-python")({
			  dap = { justMyCode = false },
			}),
		  },
		})
	end
  }
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'akinsho/toggleterm.nvim'
  require("nvim-treesitter.configs").setup({
	  highlight = {
		enable = true,
	  },
	})



  -- You can specify multiple plugins in a single call
  -- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}

  -- You can alias plugin names
  -- use {'dracula/vim', as = 'dracula'}
  --
  use {
    "epwalsh/obsidian.nvim",
	config = function()
		require("obsidian").setup({
			dir = "~/Notes",
			completion = {
				nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
			},
			daily_notes = {
				"01_Osobiste/dziennik/daily",
			},
			use_advanced_uri = true,
			})
		end
		}

	use {
	  "folke/zen-mode.nvim",
	  config = function()
		require("zen-mode").setup {
		  -- your configuration comes here
		  -- or leave it empty to use the default settings
		  -- refer to the configuration section below
		}
	  end
	}
	-- Lua
	use {
	  "folke/twilight.nvim",
	  config = function()
		require("twilight").setup {
		  -- your configuration comes here
		  -- or leave it empty to use the default settings
		  -- refer to the configuration section below
		}
	  end
	}
end)
