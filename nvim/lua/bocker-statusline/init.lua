-- TODO: if user stops TS by calling vim.treesitter.stop()
--       it is not reflected in the statusline

local ts_status = 'off'
local lsp_status = 'off'

local function update_statusline()
    local statusline = {
        ' %t',
        '%r',
        '%m',
        '%=',
        'ts: ' .. ts_status .. ' | ',
        'lsp: ' .. lsp_status .. ' | ',
        'ft: %{&filetype} | ',
        '%3p%%',
        '%4l:%-2c '
    }
    vim.o.statusline = table.concat(statusline, '')
end

local function update_lsp_status()
    local bufnr = vim.api.nvim_get_current_buf()
    if next(vim.lsp.get_clients({ bufnr = bufnr }))
        == nil then
        lsp_status = 'off'
    else
        lsp_status = 'on'
    end
end

local function update_ts_status()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.treesitter.highlighter.active[bufnr]
        == nil then
        ts_status = 'off'
    else
        ts_status = 'on'
    end
end

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        update_ts_status()
        update_lsp_status()
        update_statusline()
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function()
        update_lsp_status()
        update_statusline()
    end
})
