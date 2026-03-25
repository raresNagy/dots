return {
    "neovim/nvim-lspconfig",
    config = function()
	require("lspconfig").lua_ls.setup {}
    end,
    }),
}

--vim.api.nvim_create_autocmd('LspAttach', {
--	callback = function(event)
--		vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
--	    end

	    --- MAPS
--	    map('gd', require('telescope.builtin').lsp_definitions, "[G]oto [D]efinition")
--	    map('gr', require('telescope.builtin').lsp_references, "[G]oto [R]eferences")
--	    map('gI', require('telescope.builtin').lsp_implementations, "[G]oto [I]mplementations")
--
--	    -- Jump to the type of the word
--	    map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinitions')
--	end

