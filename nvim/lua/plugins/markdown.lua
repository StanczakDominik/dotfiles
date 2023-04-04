return {
	{'vimwiki/vimwiki',
	   init = function () --replace 'config' with 'init'
		  vim.g.vimwiki_list = {{path = '~/Notes', syntax = 'markdown', ext = '.md', links_space_char='_', diary_rel_path='dziennik/daily'}}
	   end
	},
	{"ElPiloto/telescope-vimwiki.nvim",
		dependencies = {
			{
				"nvim-telescope/telescope.nvim",
			},
		},
		config = function()
			require('telescope').load_extension('vimwiki')
		end
	}
}
