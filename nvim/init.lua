-- Options
vim.cmd.colorscheme('catppuccin')
vim.opt.wildoptions:append("fuzzy")
-- vim.o.complete = "o"
-- vim.o.completeopt = "menu,menuone,popup,fuzzy,noselect"
-- vim.o.autocomplete = false
vim.opt.path:append({ ',**/*' })
vim.o.pumheight = 10
vim.o.pumwidth = 50
vim.o.pummaxwidth = 50
vim.o.pumborder = 'single'
vim.o.laststatus = 3
vim.o.termguicolors = true
vim.o.signcolumn = 'yes:1'
vim.o.wrap = false
vim.o.list = true
vim.o.confirm = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 2000
vim.o.winborder = 'single'
vim.opt.mouse = ''
vim.o.splitbelow = true
vim.o.splitright = true
vim.g.c_syntax_for_h = 1

-- Helpers
local function toggle_qf()
    local win_id = vim.fn.getqflist({ winid = 0 }).winid
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
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>d", ":bd<CR>")
vim.keymap.set("n", "<leader>f", ":find ")
vim.keymap.set("n", "<leader>l", ":b ")
vim.keymap.set("n", "<F12>", ":make<CR>")
vim.keymap.set("n", "<C-F12>", ":make ")
vim.keymap.set("t", "<C-[>", [[<C-\><C-n>]])
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<A-o>", "<C-w>w")
vim.keymap.set("n", "<leader>q", toggle_qf)
vim.keymap.set("n", "<leader><leader>", "<C-^>")

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)

-- Autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    callback = function()
        vim.hl.hl_op({
            higroup = "IncSearch",
            timeout = "1000"
        })
    end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    desc = "No newline auto comment",
    pattern = { '*' },
    callback = function()
        vim.opt.formatoptions:remove('r')
        vim.opt.formatoptions:remove('o')
    end
})

-- Plugins
require('bocker-terminal').setup({
    width = 1,
    height = 1,
    keymaps = {
        persistent = "<F10>",
        run = "<F11>",
        set_cmd = "<C-F11>",
    },
})

vim.pack.add({ 'https://github.com/kylechui/nvim-surround' })

vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })
require('oil').setup()
vim.keymap.set("n", "-", "<Cmd>Oil<CR>")

vim.pack.add({ 'https://github.com/nvim-mini/mini.completion' })
require('mini.completion').setup()

vim.pack.add({ 'https://github.com/catppuccin/nvim' })
require('catppuccin').setup({
    flavour = 'auto',
    transparent_background = false,
    integrations = {
        treesitter = true,
        native_lsp = { enabled = true },
    },
})
vim.cmd.colorscheme('catppuccin')
