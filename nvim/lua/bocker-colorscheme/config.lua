local M = {}

M.defaults = {
    theme = "dark",
    transparent = false,
    italics = {
        comments = true,
        keywords = true,
        functions = true,
        strings = true,
        variables = true,
        bufferline = false,
    },
    overrides = {},
}

M.options = {}

M.setup = function(opts)
    M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

return M
