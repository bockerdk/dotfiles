return {
    cmd = { 'clangd', '--background-index', '--clang-tidy' },
    root_markers = { 'compile_commands.json', '.clangd', 'CMakeLists.txt', 'Makefile', '.git' },
    filetypes = { 'c', 'cpp' },
}
