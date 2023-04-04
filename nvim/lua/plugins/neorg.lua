return {
	{
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        opts = {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
                ["core.norg.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = "~/Notes",
                        },
                    },
                },
				["core.norg.completion"] = { config = {engine = "nvim-cmp"}},
				["core.norg.concealer"] = {},
				["core.integrations.telescope"] = {},

            },
        },
		dependencies = { { "nvim-lua/plenary.nvim"}, {"nvim-treesitter/nvim-treesitter"}, { "nvim-neorg/neorg-telescope" },
		},
    }
}
