return {
    cmd = { 'lua-language-server' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
    filetypes = { 'lua' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    }
}
