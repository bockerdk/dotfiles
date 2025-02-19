vim.api.nvim_command("packadd nohlsearch")

-- Options
vim.api.nvim_command("colorscheme catppuccin")
vim.o.completeopt = "menu,menuone,popup,fuzzy"
vim.o.laststatus = 3
vim.o.termguicolors = true
vim.o.pumheight = 10
vim.o.signcolumn = 'yes:1'
vim.o.wrap = false
vim.o.list = true
vim.o.confirm = true
vim.g.netrw_banner = 0
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
vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float)

-- Treesitter
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end
})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf)
    end,
})

vim.lsp.config('lua_ls', {
    cmd = { "lua-language-server" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
    filetypes = { "lua" },
    on_init = function(client)
        local path = vim.tbl_get(client, "workspace_folders", 1, "name")
        if not path then
            return
        end
        client.settings = vim.tbl_deep_extend('force', client.settings, {
            Lua = {
                runtime = {
                    version = 'LuaJIT'
                },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME
                    }
                }
            }
        })
    end
})

vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--clang-tidy',
        '--background-index',
        '--offset-encoding=utf-8',
    },
    root_markers = { 'compile_commands.json' },
    filetypes = { 'c' },
})

vim.lsp.config('rust-analyzer', {
    cmd = {
        'rust-analyzer'
    },
    root_markers = { 'Cargo.toml' },
    filetypes = { 'rust' },
})

vim.lsp.enable('lua_ls')
vim.lsp.enable('clangd')
vim.lsp.enable('rust-analyzer')
