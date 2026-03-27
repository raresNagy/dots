return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",

	opts = {
		ensure_installed = {
			"lua",
			"c",
			"vim",
			"c_sharp",
			"razor",
			"html",
			"css",
			"javascript",
			"python",
		},
		highlight = { enable = true },
		auto_install = false,
	},
	init = function()
		vim.filetype.add({
			extension = {
				razor = "razor",
				cshtml = "razor",
			},
		})
		vim.treesitter.language.register("razor", "razor")
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "razor",
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
