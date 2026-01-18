return {
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    root_markers = { 'compile_commands.json' },
    filetypes = { 'c', 'cpp' },
}
