return {
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry", -- provides roslyn, rzls, netcoredbg
  },
  ensure_installed = {
    "black",
    "clangd",
    "clang-format",
    "gofumpt",
    "goimports",
    "golines",
    "gopls",
    "lua-language-server",
    "pyright",
    "rust-analyzer",
    "rustfmt",
    "stylua",
    "ruff",
    "shfmt",
    "htmx-lsp",
    "prettier",
    "css-lsp",
    -- HTML language server (vscode-html-language-server via mason)
    "html-lsp",
    -- ESLint (use eslint_d for faster performance if available)
    "eslint_d",
    "roslyn",
    "csharpier",
  },
}
