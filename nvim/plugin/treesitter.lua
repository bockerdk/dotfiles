vim.api.nvim_create_autocmd("BufEnter", {
    desc = 'Always start treesitter (and silently fail)',
    pattern = "",
    callback = function()
        pcall(vim.treesitter.start)
    end
})
