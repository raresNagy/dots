return {
	"GustavEikaas/easy-dotnet.nvim",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-lua/plenary.nvim",
		"folke/snacks.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("easy-dotnet").setup()
	end,
}
