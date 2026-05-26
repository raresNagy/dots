return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("easy-dotnet").setup({
			lsp = {
				set_fold_expr = true,
				suggest_updates = false, -- Periodically suggest roslyn-language-server updates
			},
			notifications = false,
		})
	end,
}
