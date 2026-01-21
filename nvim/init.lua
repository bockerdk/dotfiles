-- Options
vim.opt.wildoptions:append("fuzzy")
vim.o.complete = "o"
vim.o.completeopt = "menu,menuone,popup,fuzzy,noselect"
vim.o.autocomplete = true
vim.opt.path:append({ ',**/*' })
vim.o.laststatus = 3
vim.o.termguicolors = true
vim.o.pumheight = 10
vim.o.signcolumn = 'yes:1'
vim.o.wrap = false
vim.o.list = true
vim.o.confirm = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 2000
vim.o.winborder = 'rounded'
vim.opt.mouse = ''
vim.o.splitbelow = true
vim.o.splitright = true
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -30
vim.g.c_syntax_for_h = 1

-- Helpers
local function toggle_qf()
    local win_id = vim.fn.getqflist({winid = 0}).winid
    if win_id ~= nil and win_id ~= 0 then
        vim.cmd 'ccl'
    else
        vim.cmd 'copen'
        vim.cmd 'wincmd p'
    end
end

-- Keymaps
vim.g.mapleader = " "
vim.keymap.set("n", "<F3>", ":e $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>r", ":source $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>R", ":mksession! /tmp/session.vim | restart source /tmp/session.vim<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>d", ":bd<CR>")
vim.keymap.set("n", "<leader>f", ":find ")
vim.keymap.set("n", "<leader>l", ":b ")
vim.keymap.set("n", "<F12>", ":make<CR>")
vim.keymap.set("n", "<C-F12>", ":make ")
vim.keymap.set("n", "<F2>", ":Lexplore<CR>", { silent = true })
vim.keymap.set("n", "<C-F2>", ":Lexplore %:p:h<CR>", { silent = true })
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]])
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<A-o>", "<C-w>w")
vim.keymap.set("n", "<leader>q", toggle_qf)
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- Autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = "1000"
        })
    end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    desc = "No auto comment",
    pattern = { '*' },
    callback = function()
        vim.opt.formatoptions:remove('r')
        vim.opt.formatoptions:remove('o')
    end
})

-- Extras
require('bocker-terminal').setup("<F10>", "<C-F10>", "<F11>", "<C-F11>", { width = 1, height = 1 })
require('bocker-colorscheme').setup(true)
