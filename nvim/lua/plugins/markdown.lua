return {
	{'vimwiki/vimwiki',
	   init = function () --replace 'config' with 'init'
			vim.g.vimwiki_list = {
				{ path = '~/Notes',
				syntax = 'markdown',
				ext = '.md',
				links_space_char = '_',
				diary_rel_path = 'dziennik/daily',
			}
			}
			vim.api.nvim_create_autocmd("BufNewFile",
			{
				pattern = "*/Notes/dziennik/daily/*.md",
				command = "r ~/Notes/Templates/daily_journal_template.md",
			}
			)
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
