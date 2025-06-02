local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

return {
  sources = {
    require("none-ls.formatting.ruff").with({
      extra_args = { "--extend-select", "I" },
    }),
    require "none-ls.formatting.ruff_format",
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.golines,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.shfmt.with { args = {"-i", "4"}}
  },


  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          lsp_formatting(bufnr)
        end
      })
    end
  end,
}
