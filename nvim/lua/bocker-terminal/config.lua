local M = {}

M.defaults = {
    width = 1,
    height = 1,
    anchor = 'm',
    keymaps = {
        persistent = "<F10>",
        run = "<F11>",
        set_cmd = "<C-F11>",
    },
}

M.options = {}

M.setup = function(opts)
    M.options = vim.tbl_deep_extend("force", {}, M.defaults, opts or {})
end

return M
