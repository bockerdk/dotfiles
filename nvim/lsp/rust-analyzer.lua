return {
    cmd = { 'rust-analyzer' },
    check = { command = "clippy" },
    root_markers = { 'Cargo.toml' },
    filetypes = { 'rust' },
}
