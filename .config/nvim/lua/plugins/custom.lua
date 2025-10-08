local plugins = {
	-- Telescope undo extension: shows undo history in a Telescope picker
		{
			"debugloop/telescope-undo.nvim",
			-- load only when pressing <leader>u
			keys = { { "<leader>u", mode = "n", desc = "Telescope: undo history" } },
			dependencies = { "nvim-telescope/telescope.nvim" },
			config = function()
				local ok, telescope = pcall(require, "telescope")
				if not ok then
					return
				end

				-- load the extension
				pcall(function()
					telescope.load_extension("undo")
				end)

				-- map <leader>u to the undo picker (this mapping will also trigger lazy loading)
				vim.keymap.set("n", "<leader>u", function()
					local ok2, ext = pcall(function()
						return require("telescope").extensions.undo
					end)
					if ok2 and ext and ext.undo then
						pcall(ext.undo)
					else
						-- fallback: try to load extension then call
						pcall(function()
							telescope.load_extension("undo")
							require("telescope").extensions.undo.undo()
						end)
					end
				end, { desc = "Telescope: undo history" })
			end,
		},
}

return plugins
