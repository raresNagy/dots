-- Use native Neovim 0.11+ LSP configuration. Avoid calling NvChad helper
-- that relies on the deprecated lspconfig "framework".

local servers = { "html", "cssls", "pyright", "templ" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
