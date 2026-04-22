return {
	"MeanderingProgrammer/render-markdown.nvim",
	ft = { "markdown", "quarto" },
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		completions = { lsp = { enabled = true } },
		render_modes = { "n", "c", "t" },
	},
}
