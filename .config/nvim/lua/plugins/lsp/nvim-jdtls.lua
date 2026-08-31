return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = {
		"neovim/nvim-lspconfig",
	},
	vim.lsp.enable("jdtls"),
	require("mason-tool-installer").setup({ ensure_installed = { { "jdtls" } } }),
}
