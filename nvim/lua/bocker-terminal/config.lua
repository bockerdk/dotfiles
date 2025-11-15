local M = {}

M.defaults = {
    width = 0.9,
    height = 0.9,
    anchor = 'm',
    border = 'single',
}

M.options = {}

M.setup = function(opts)
    M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

return M
