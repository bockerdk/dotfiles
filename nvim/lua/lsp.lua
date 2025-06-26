-- Auto format on save using the attached LSP
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "",
    command = ":silent lua vim.lsp.buf.format()"
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = false })
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
