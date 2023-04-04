return {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
	'saadparwaiz1/cmp_luasnip',
	{
		"L3MON4D3/LuaSnip",
		version = "<CurrentMajor>.*",
	},
	{'williamboman/mason.nvim', build=":MasonUpdate", lazy=false},
	{'williamboman/mason-lspconfig.nvim', opts = { automatic_installation=true}},
}
