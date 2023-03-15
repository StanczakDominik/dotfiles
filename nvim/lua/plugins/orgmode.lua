return {
	{'nvim-orgmode/orgmode',
		dependencies = {'nvim-treesitter/nvim-treesitter', },
		config = function()
			require('orgmode').setup{}
			require('orgmode').setup_ts_grammar()
		end
	}
}
