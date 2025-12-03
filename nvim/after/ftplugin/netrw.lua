local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "q", ":close<CR>", { silent = true, nowait = true, buffer = bufnr })
