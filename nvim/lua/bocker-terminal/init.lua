local config = require('bocker-terminal.config')

local M = {}

local p_term_win = nil
local p_term_buf = nil
local p_create_new_term = false
local p_term_leave_auto_cmd = nil

local r_term_buf = nil
local r_init_cmd = ""
local r_term_leave_auto_cmd = nil

local cal_size = function(max, val)
    if val <= 1 then
        return math.floor(max * val)
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
    local border_offset = config.options.border == 'none' and 0 or 2
    local max_width = vim.o.columns - border_offset
    local max_height = vim.o.lines - vim.o.cmdheight - border_offset

    local width = cal_size(max_width, config.options.width)
    local height = cal_size(max_height, config.options.height)

    local col = (max_width - width) / 2
    local row
    if config.options.anchor == 'm' then
        row = (max_height - height) / 2
    elseif config.options.anchor == 't' then
        row = 0
    elseif config.options.anchor == 'b' then
        row = max_height - height
    end

    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        height = height,
        width = width,
        col = col,
        row = row,
        border = config.options.border,
    })

    vim.bo[buf].buflisted = false
    return win
end

local open_p_term = function(buf)
    p_term_win = create_window(buf)

    if p_create_new_term then
        vim.cmd('terminal')
        p_create_new_term = false
    end

    vim.cmd('startinsert')

    p_term_leave_auto_cmd = vim.api.nvim_create_autocmd('WinLeave', {
        buffer = 0,
        callback = function()
            bury_term(p_term_win, p_term_leave_auto_cmd)
        end
    })
end

local open_r_term = function(buf, cmd)
    create_window(buf)

    vim.cmd('terminal ' .. cmd)
    vim.cmd('startinsert')

    r_term_leave_auto_cmd = vim.api.nvim_create_autocmd('WinLeave', {
        buffer = 0,
        callback = function()
            kill_term(buf, r_term_leave_auto_cmd)
        end
    })
end

M.toggle_p_term = function()
    if p_term_buf == nil
        or not vim.api.nvim_buf_is_valid(p_term_buf) then
        p_term_buf = vim.api.nvim_create_buf(false, false)
        p_create_new_term = true
    end

    if p_term_buf == vim.api.nvim_get_current_buf() then
        bury_term(p_term_win, p_term_leave_auto_cmd)
    else
        open_p_term(p_term_buf)
    end
end

M.toggle_r_term = function()
    if r_init_cmd == "" then
        vim.notify("No command set", vim.log.levels.ERROR)
        return
    end

    if r_term_buf == vim.api.nvim_get_current_buf() then
        kill_term(r_term_buf, r_term_leave_auto_cmd)
    else
        r_term_buf = vim.api.nvim_create_buf(false, false)
        open_r_term(r_term_buf, r_init_cmd)
    end
end

M.set_cmd = function()
    vim.ui.input({ prompt = 'Enter command: ' }, function(input)
        r_init_cmd = input
    end)
end

M.setup = function(opts)
    config.setup(opts)

    local keymaps = opts.keymaps or {}

    if keymaps.persistent then
        vim.keymap.set({ "n", "i", "v", "t" }, keymaps.persistent, M.toggle_p_term)
    end

    if keymaps.run then
        vim.keymap.set({ "n", "i", "v", "t" }, keymaps.run, M.toggle_r_term)
    end

    if keymaps.set_cmd then
        vim.keymap.set({ "n", "i", "v", "t" }, keymaps.set_cmd, M.set_cmd)
    end
end

return M
