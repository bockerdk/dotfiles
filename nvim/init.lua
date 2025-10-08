-- Options
vim.o.completeopt = "menu,menuone,popup,fuzzy"
vim.o.laststatus = 3
vim.o.termguicolors = true
vim.o.pumheight = 10
vim.o.signcolumn = 'yes:1'
vim.o.wrap = false
vim.o.list = true
vim.o.confirm = true
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>d", ":bd<CR>")
vim.keymap.set("n", "<leader>cc", ":cclose<CR>")
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]])
vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float)

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = "1000"
        })
    end
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "",
    command = ":%s/\\s\\+$//e"
})

-- No auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "",
    command = "set fo-=c fo-=r fo-=o"
})

-- Treesitter highlighter
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"c", "h", "lua"},
    callback = function()
        vim.treesitter.start()
    end
})

-- Open help/man buffers in vertical split
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"help", "man"},
    command = "wincmd L",
})

-- LSP
vim.lsp.enable("clangd")

-- Colorscheme
vim.pack.add({
    'https://github.com/WTFox/jellybeans.nvim',
})
vim.cmd([[colorscheme jellybeans]])

-- Status line
vim.pack.add({
    'https://github.com/nvim-lualine/lualine.nvim',
})
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'jellybeans',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    }
}
