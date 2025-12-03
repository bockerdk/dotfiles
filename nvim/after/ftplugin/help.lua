local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "q", ":helpclose<CR>", { silent = true, nowait = true, buffer = bufnr })
