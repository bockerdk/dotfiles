-- Color
vim.cmd('colorscheme quiet')

-- Options
vim.o.completeopt = "menu,menuone,popup,fuzzy,noinsert"
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
vim.o.foldlevel = 99
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>d", ":bd<CR>")
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]])
vim.keymap.set("i", "<C-j>", function()
    if vim.fn.pumvisible() == 1 then
        return "<Down>"
    else
        return "<C-j>"
    end
end, { expr = true, noremap = true })
vim.keymap.set("i", "<C-k>", function()
    if vim.fn.pumvisible() == 1 then
        return "<Up>"
    else
        return "<C-k>"
    end
end, { expr = true, noremap = true })
vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float)

require('autocmds')
require('treesitter')
require('lsp')
