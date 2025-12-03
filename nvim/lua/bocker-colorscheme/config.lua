local M = {}

M.defaults = {
    theme = "dark",
    transparent = false,
    italics = {
        comments = false,
        keywords = false,
        functions = false,
        strings = false,
        variables = false,
        bufferline = false,
    },
    overrides = {},
}

M.options = {}

M.setup = function(opts)
    M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

return M
