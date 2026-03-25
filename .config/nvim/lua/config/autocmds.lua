vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Add trailing whitespace function

vim.api.nvim_create_autocmd("InsertLeave", {
    callback=function()
    vim.opt.relativenumber = true
    --trim_trailing_whitespaces()
    end
})
