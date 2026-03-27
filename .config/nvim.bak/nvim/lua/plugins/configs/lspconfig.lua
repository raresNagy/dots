local base = require "nvchad.configs.lspconfig"
local on_attach = base.on_attach
local capabilities = base.capabilities

local function register_and_enable(name, opts)
  opts = opts or {}
  -- Register/override the server config
  vim.lsp.config(name, opts)
  -- Enable the server so it activates for matching filetypes
  vim.lsp.enable(name)
end

-- Server configurations using the new vim.lsp.config / vim.lsp.enable API
register_and_enable('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
        disable = { 'different-requires' },
      },
    },
  },
})

register_and_enable('clangd', {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--header-insertion=iwyu',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--fallback-style=llvm',
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
})

register_and_enable('rust_analyzer', {
  cargo = {
    features = { 'a ll' },
  },
})

register_and_enable('gopls', {
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
})

register_and_enable('templ', {
  filetypes = { 'templ' },
})

register_and_enable('html', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'templ', 'css', 'js' },
})

register_and_enable('htmx', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'html', 'templ' },
})

-- CSS language server for autocomplete in CSS files
register_and_enable('cssls', {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { 'css', 'scss', 'less' },
})
