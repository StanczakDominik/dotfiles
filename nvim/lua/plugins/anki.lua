return ({
	"rareitems/anki.nvim",
	config = function()
		require("anki").setup({
			-- this function will add support for associating '.anki' extension with 'anki' filetype.
			tex_support = true,
			models = {
				-- Here you specify which notetype should be associated with which deck
				--Notetype = "Deck Path",
				--["Super Basic"] = "Deck::ChildDeck",
			},
		})
	end,
})
