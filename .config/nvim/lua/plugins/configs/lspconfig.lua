local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
                disable = { "different-requires" },
            },
        },
    },
})

lspconfig.pyright.setup({
  filetypes = {"python"}
})

lspconfig.rust_analyzer.setup({
    cargo = {
        features = { "a ll" },
    },
})

lspconfig.gopls.setup({
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
})
