return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		require("mini.ai").setup()
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
					local is_lsp = notif.data and string.find(notif.msg, "jdtls") 
					return is_lsp == false
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
