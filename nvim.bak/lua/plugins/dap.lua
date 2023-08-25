return {
	{"mfussenegger/nvim-dap",
	config = function()
			vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
			vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

			vim.keymap.set('n', '<F5>', require 'dap'.continue)
			vim.keymap.set('n', '<F10>', require 'dap'.step_over)
			vim.keymap.set('n', '<F11>', require 'dap'.step_into)
			vim.keymap.set('n', '<F12>', require 'dap'.step_out)
			vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
		end
	},
	{"mfussenegger/nvim-dap-python", dependencies = {"mfussenegger/nvim-dap"},
	config = function()
		require("dap-python").setup("python")
	end
	},
	{"Weissle/persistent-breakpoints.nvim", dependencies = {"mfussenegger/nvim-dap"},
	config = function()
		require("persistent-breakpoints").setup({
			load_breakpoints_event = { "BufReadPost" }
		})
	end
	},
	{ "rcarriga/nvim-dap-ui",
		dependencies = {"mfussenegger/nvim-dap"},
		config = function()
			local dap, dapui =require("dap"),require("dapui")
			dapui.setup({})
			dap.listeners.after.event_initialized["dapui_config"]=function()
			  dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"]=function()
			  dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"]=function()
			  dapui.close()
			end
		end
		},
		{"theHamsta/nvim-dap-virtual-text",
		dependencies = {"mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter"},
		config = function()
			require("nvim-dap-virtual-text").setup({
				highlight_new_as_changed = true,
				}
			)
		end
	}
}
