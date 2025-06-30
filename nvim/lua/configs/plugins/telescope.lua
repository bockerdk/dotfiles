return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    keys = {
        -- Find
        {
            desc = "Files",
            "<leader>ff",
            function()
                require("telescope.builtin").find_files({ hidden = false, no_ignore = false, prompt_title = "Find files" })
            end,
        },
        {
            desc = "All files",
            "<leader>fF",
            function()
                require("telescope.builtin").find_files({
                    hidden = true,
                    no_ignore = true,
                    prompt_title =
                    "Find all Files"
                })
            end,
        },
        {
            desc = "Git files",
            "<leader>fg",
            function()
                require("telescope.builtin").git_files({ prompt_title = "Find git files" })
            end,
        },
        {
            desc = "Recent files",
            "<leader>fo",
            function()
                require("telescope.builtin").oldfiles({ prompt_title = "Recent files" })
            end,
        },
        -- Search
        {
            desc = "Search",
            "<leader>ss",
            function()
                require("telescope.builtin").live_grep( { hidden = true } )
            end,
        },
        {
            desc = "Symbol under cursor",
            "<leader>sS",
            function()
                require("telescope.builtin").grep_string()
            end,
        },
        -- Buffers
        {
            desc = "Buffers",
            "<leader><leader>",
            function()
                require("telescope.builtin").buffers()
            end,
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        pcall(require('telescope').load_extension, 'fzf')

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                },
                layout_strategy = "vertical",
                layout_config = {
                    height = 0.90,
                    width = 0.90,
                    preview_cutoff = 0,
                },
            },
            pickers = {
                find_files = {
                    previewer = false,
                },
                git_files = {
                    previewer = false,
                },
                buffers = {
                    previewer = false,
                },
            },
        })
    end,
}

