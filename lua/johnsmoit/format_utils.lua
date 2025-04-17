local namespace = vim.api.nvim_create_namespace("LongLinesHighlight")

local highlighter_cmd = -1
local len = 0


vim.api.nvim_set_hl(namespace, "LongLines", {
    bg = "#ff66f5",
    fg = "#abff9e"
})

vim.api.nvim_set_hl_ns(namespace)

local function highlight_lines(bufnr, row)
    local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)
    if #line == 0 then return end


    local marks = vim.api.nvim_buf_get_extmarks(bufnr, namespace, {row - 1, 0}, {row - 1, 0}, {})
    for _, mark in ipairs(marks) do
        for _, id in ipairs(mark) do
            print(id)
            vim.api.nvim_buf_del_extmark(bufnr, namespace, id)
        end
    end
    if #line[1] < len then return end

    vim.api.nvim_buf_set_extmark(bufnr, namespace, row - 1, 0, {
        end_row = row - 1,
        end_col = #line[1],
        hl_group = "LongLines",
        hl_eol = false,
        virt_text = {{string.format("Over Length -- %d", #line[1]), "LongLines"}},
        virt_text_pos = "right_align"
    })
end
local function paint_window_highlights(bufnr, win)
    local win_pos = vim.fn.line("w0", win)
    local win_end = win_pos + vim.api.nvim_win_get_height(win)

    for row=win_pos, win_end do
        highlight_lines(bufnr, row)
    end
end

local function do_win_scroll(bufnr, win, dir, lines)
end

local function repaint_current_window(key)

    return function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), "n", false)
        local bufnr = vim.api.nvim_get_current_buf()
        local win = vim.api.nvim_get_current_win()

        paint_window_highlights(bufnr, win)
    end
end

local function add_key_maps()
    vim.keymap.set({"n", "i"}, "<PageUp>", repaint_current_window("<PageUp>"), {noremap = true})
    vim.keymap.set({"n", "i"}, "<PageDown>", repaint_current_window("<PageDown>"), {remap = true})
    vim.keymap.set({"n", "i"}, "<Up>", repaint_current_window("<Up>"), {remap = true})
    vim.keymap.set({"n", "i"}, "<Down>", repaint_current_window("<Down>"), {remap = true})
end

local function del_key_maps()
    vim.keymap.del({"n", "i"}, "<PageUp>")
    vim.keymap.del({"n", "i"}, "<PageDown>")
    vim.keymap.del({"n", "i"}, "<Up>")
    vim.keymap.del({"n", "i"}, "<Down>")
end

local function make_highlighter_cmd(length)
    if highlighter_cmd ~= -1 then return end -- prevent multiple instances of the autocmd from being created/deleted
    print(string.format("Highlighter is ON for lines greater than %d characters", length))

    len = length

    highlighter_cmd = vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI", "BufEnter"}, {
        callback = function(ev)
            -- depending on event type, the following should happen
            -- TextChanged/TextChangedI -- Simply recompute the current line's highlight status
            -- BufEnter -- Compute the entire visible area for the window's highlight status
            if ev.event == "TextChanged" or ev.event == "TextChangedI" then
                local row = vim.api.nvim_win_get_cursor(0)[1]
                highlight_lines(ev.buf, row)
            else
                local win = vim.api.nvim_get_current_win()
                paint_window_highlights(0, win)
            end
        end,
    })

    local win = vim.api.nvim_get_current_win()
    paint_window_highlights(0, win)
    add_key_maps()
end


local function clear_highlighter_cmd()
    if highlighter_cmd == -1 then return end
    print("Highlighter is now OFF")

    vim.api.nvim_del_autocmd(highlighter_cmd)

    vim.api.nvim_buf_clear_namespace(0, namespace, 0, -1)
    highlighter_cmd = -1
    del_key_maps()
end

vim.api.nvim_create_user_command("ShowLn", function(props)
    local option = props.fargs[1]
    local as_num = tonumber(option)
    if string.lower(option) == "off" then
        clear_highlighter_cmd()
    elseif as_num ~= nil then
        make_highlighter_cmd(as_num)
    end
end, {
    nargs = 1
})

