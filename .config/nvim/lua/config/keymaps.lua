--Open lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>")

-- Telescope
vim.keymap.set("n", "<leader>t", "<cmd>Telescope<cr>")

-- Insert lines without entering insert mode
vim.keymap.set("n", "<M-o>", "o<Esc>")
vim.keymap.set("n", "<M-O>", "O<Esc>")

-- Alt+k/j to move line or visual selection up/down
vim.keymap.set("n", "<M-k>", "<cmd>m .-2<CR>==")
vim.keymap.set("n", "<M-j>", "<cmd>m .+1<CR>==")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { silent = true })

-- Keep visual mode after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Remove search highlighting with Escape
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { silent = true })

vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "jj", "<ESC>")


