return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    lazy = false,
    opts = {
        highlight = {
            enable = true
        }
    }
}
