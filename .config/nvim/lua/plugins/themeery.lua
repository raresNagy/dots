return {
	"zaldih/themery.nvim",
	lazy = false,
	config = function()
		require("themery").setup({
			themes = {
				"moonfly",
				"github_dark",
				"github_light",
				"github_dark_dimmed",
				"github_light_default",
				"github_dark_high_contrast",
				"github_light_high_contrast",
			},
		})
	end,
}
