return {
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
	'nvim-lua/plenary.nvim',
	-- optional but recommended
	{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
	"debugloop/telescope-undo.nvim",
    },
    config = function()
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
	vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


	vim.api.nvim_create_autocmd('LspAttach', {
	    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
	    callback = function (event)
		local buf = event.buf
		-- Find references for the word under your cursor.
		vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })
		-- Jump to the implementation of the word under your cursor.
		-- Useful when your language has ways of declaring types without an actual implementation.
		vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })
		-- Jump to the definition of the word under your cursor.
		-- This is where a variable was first declared, or where a function is defined, etc.
		-- To jump back, press <C-t>.
		vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })
		-- Fuzzy find all the symbols in your current document.
		-- Symbols are things like variables, functions, types, etc.
		vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

		-- Fuzzy find all the symbols in your current workspace.
		-- Similar to document symbols, except searches over your entire project.
		vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

		-- Jump to the type of the word under your cursor.
		-- Useful when you're not sure what type a variable is and you want to see
		-- the definition of its *type*, not where it was *defined*.
		vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
	    end

	})

	--  See `:help telescope.builtin.live_grep()` for information about particular keys
	vim.keymap.set(
	    'n',
	    '<leader>s/',
	    function()
		builtin.live_grep {
		    grep_open_files = true,
		    prompt_title = 'Live Grep in Open Files',
		}
	    end,
	    { desc = '[S]earch [/] in Open Files' },
	    -- Shortcut for searching your Neovim configuration files
	    vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end, { desc = '[S]earch [N]eovim files' })
	)
    end
}

