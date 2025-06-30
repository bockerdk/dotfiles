vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>d", ":bd<CR>")
vim.keymap.set("n", "<leader>cc", ":cclose<CR>")
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]])
vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float)
