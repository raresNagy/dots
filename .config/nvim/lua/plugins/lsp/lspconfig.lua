return {
    "neovim/nvim-lspconfig",
    dependencies = {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
	    library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	    }
	}
    },
    --lua
    vim.lsp.enable("lua_ls"),

    --C++
    vim.lsp.enable("clangd"),
}
