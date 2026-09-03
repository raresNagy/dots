return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"mason-org/mason.nvim",
			---@module 'mason.settings'
			---@type MasonSettings
			---@diagnostic disable-next-line: missing-fields
			opts = {
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			},
		},
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{
			"mrcjkb/rustaceanvim",
			version = "^8", -- Recommended
			lazy = false, -- This plugin is already lazy
		},
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},

	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Rename the variable under your cursor.
				--  Most Language Servers support renaming across files, etc.
				map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

				-- WARN: This is not Goto Definition, this is Goto Declaration.
				--  For example, in C this would take you to the header.
				map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				vim.api.nvim_create_autocmd("CursorHold", {
					buffer = event.buf,
					callback = function()
						vim.lsp.buf.hover({ focusable = false })
					end,
				})
			end,
		})

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--  See `:help lsp-config` for information about keys and how to configure
		---@type table<string, vim.lsp.Config>
		local servers = {
			-- C/C++
			clangd = {},

			-- HTML/Emmet
			html = {},
			emmet_language_server = {
				filetypes = {
					"astro",
					"razor",
					"css",
					"eruby",
					"html",
					"htmlangular",
					"htmldjango",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"svelte",
					"typescriptreact",
					"vue",
				},
			},
			cssls = {},

			-- Python
			pyright = {},

			--docker
			dockerls = {},
			yamlls = {},

			--Kotlin
			kotlin_language_server = {
				filetypes = {
					"kotlin",
				},
				env = {
					JAVA_HOME = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home",
				},
			},
			-- Go
			gopls = {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
					},
					staticcheck = true,
				},
			},

			-- CMake
			neocmakelsp = {},

			-- rust
			rust_analyzer = {},

			-- Lua
			stylua = {},
			lua_ls = {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath("config")
							and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
						then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							version = "LuaJIT",
							path = { "lua/?.lua", "lua/?/init.lua" },
						},
						workspace = {
							checkThirdParty = false,
						},
					})
				end,

				settings = {
					Lua = {},
				},
			},
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"emmet-language-server",
			"black",
			"rustfmt",
			"stylua",
			"isort",
			"csharpier",
			"neocmakelsp",
		})

		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for name, server in pairs(servers) do
			vim.lsp.config(name, server)
			vim.lsp.enable(name)
		end

		-- makes C# work
		-- vim.lsp.enable("roslyn_ls")
		-- vim.lsp.config("roslyn_ls", {
		-- 	filetypes = { "razor", "cs" },
		-- 	settings = {
		-- 		["csharp|background_analysis"] = {
		-- 			dotnet_analyzer_diagnostics_scope = "openFiles",
		-- 			dotnet_compiler_diagnostics_scope = "openFiles",
		-- 		}
		-- 	}
		-- })
	end,
}
