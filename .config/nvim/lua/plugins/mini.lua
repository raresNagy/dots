return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		require("mini.ai").setup()
		require("mini.files").setup({
			vim.keymap.set("n", "<leader>e", "<CMD>lua MiniFiles.open()<CR>", {desc = "Open parent directory"}),
			options = {
				-- Whether to delete permanently or move into module-specific trash
				permanent_delete = false,
			}
		})
		require("mini.pairs").setup()
		require("mini.splitjoin").setup()
		require("mini.surround").setup()
		require("mini.cmdline").setup()
		require("mini.icons").setup()
		require("mini.tabline").setup()
		require("mini.comment").setup()
		local notify = require("mini.notify")
		notify.setup({
			sort = function(notif_arr)
				local filtered = vim.tbl_filter(function(notif)
					local silenced = notif.data and (
									 string.find(notif.msg, "jdtls") or
									 string.find(notif.msg, "hover") or
									 string.find(notif.msg, "No information available")
								 )
					return !silenced
				end, notif_arr)
				return notify.default_sort(filtered)
			end,
			lsp_progress = {
				-- Whether to enable showing
				enable = false,

				-- Notification level
				level = "WARN",

				-- Duration (in ms) of how long last message should be shown
				duration_last = 1000,
			},
		})
		require("mini.pick").setup()
		require("mini.clue").setup()
		require("mini.statuscolumn").setup()
		require("mini.indentscope").setup({
			draw = {
				delay = 10,
				animation = function()
					return 20
				end,
			},
		})
	end,
}
