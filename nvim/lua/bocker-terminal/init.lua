local config = require('bocker-terminal.config')

local M = {}

-- Shared
local term_win = nil

-- Persistent term
local p_term_buf = nil
local p_create_new_term = false
local p_term_leave_auto_cmd = nil

-- Run term
local r_init_cmd = ""
local r_term_buf = nil
local r_term_leave_auto_cmd = nil

local cal_size = function(max, val)
    -- Negative
    if val < 0 then
        return max - (math.abs(val) * 2)
        -- Zero
    elseif val == 0 then
        return max
        -- Percentage
    elseif val > 0 and val <= 1 then
        return math.floor(max * val)
        -- Positive
    else
        return val
    end
end

local bury_term = function(win, autocmd)
    vim.api.nvim_del_autocmd(autocmd)
    vim.api.nvim_win_hide(win)
end

local kill_term = function(buf, autocmd)
    vim.api.nvim_del_autocmd(autocmd)
    vim.api.nvim_buf_delete(buf, { force = true })
end

local create_window = function(buf)
    local max_width = tonumber(vim.api.nvim_cmd({
        cmd = 'echo', args = { '&columns' } }, { output = true }
    )) - 2 --TODO: explain magic offset numbers
    local max_height = tonumber(vim.api.nvim_cmd({
        cmd = 'echo', args = { '&lines' } }, { output = true }
    )) - 4 --TODO: explain magic offset numbers

    local width = cal_size(max_width, config.options.width)
    local height = cal_size(max_height, config.options.height)

    local col
    local row

    if config.options.anchor == 'm' then
        col = (max_width - width) / 2
        row = (max_height - height) / 2
    elseif config.options.anchor == 't' then
        col = (max_width - width) / 2
        row = 0
    elseif config.options.anchor == 'b' then
        col = (max_width - width) / 2
        row = (max_height - height)
    end

    term_win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        height = height,
        width = width,
        col = col,
        row = row,
        border = config.options.border,
    })

    vim.bo.buflisted = false
end

local open_p_term = function(buf)
    create_window(buf)

    vim.cmd('startinsert')

    -- If user deletes the buffer
    if p_create_new_term then
        vim.cmd('startinsert')
        vim.cmd('terminal')
        p_create_new_term = false
    end

    -- Close term if user focus other window (e.g. 'CTRL-w w')
    p_term_leave_auto_cmd = vim.api.nvim_create_autocmd('WinLeave', {
        buffer = 0,
        callback = function()
            bury_term(term_win, p_term_leave_auto_cmd)
        end
    })
end

local open_r_term = function(buf, cmd)
    create_window(buf)

    vim.cmd('startinsert')
    vim.fn.jobstart(cmd, { term = true })

    -- Close term if user focus other window (e.g. 'CTRL-w w')
    r_term_leave_auto_cmd = vim.api.nvim_create_autocmd('WinLeave', {
        buffer = 0,
        callback = function()
            kill_term(buf, r_term_leave_auto_cmd)
        end
    })
end

-- p all purpose term
local toggle_p_term = function()
    -- First toggle or user deleted terminal buffer
    if p_term_buf == nil
        or not vim.api.nvim_buf_is_valid(p_term_buf) then
        p_term_buf = vim.api.nvim_create_buf(false, false)
        p_create_new_term = true
    end

    if p_term_buf == vim.api.nvim_get_current_buf() then
        bury_term(term_win, p_term_leave_auto_cmd)
    else
        open_p_term(p_term_buf)
    end
end

-- Run a single command and terminate term
local toggle_r_term = function()
    if r_term_buf == vim.api.nvim_get_current_buf() then
        kill_term(r_term_buf, r_term_leave_auto_cmd)
    else
        r_term_buf = vim.api.nvim_create_buf(false, false)
        open_r_term(r_term_buf, r_init_cmd)
    end
end

local set_init_cmd = function()
    vim.ui.input({ prompt = 'Enter command: ' }, function(input)
        r_init_cmd = input
    end)
end

M.setup = function(a, b, c, d, opts)
    config.setup(opts)

    vim.keymap.set({ "n", "i", "v", "t" }, a, function()
        toggle_p_term()
    end)
    -- vim.keymap.set({ "n", "i", "v", "t" }, b, function()
    --     vim.ui.input({ prompt = 'Enter path: ' }, function(input)
    --         p_term_path = input
    --     end)
    --     toggle_p_term()
    -- end)

    vim.keymap.set({ "n", "i", "v", "t" }, c, toggle_r_term)
    vim.keymap.set({ "n", "i", "v", "t" }, d,
        function()
            set_init_cmd()
            toggle_r_term()
        end)
end

return M
