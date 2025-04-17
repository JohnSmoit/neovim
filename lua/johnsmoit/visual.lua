

local PosVal = {
    BUFNUM = 1,
    LNUM = 2,
    COL = 3,
    OFF = 4,
}

return {
    selected_text = function()
        local sel1 = vim.fn.getpos(".")
        local sel2 = vim.fn.getpos("v")

        local lstart = nil
        local cstart = nil

        local lend = nil
        local cend = nil

        if sel1[PosVal.LNUM] > sel2[PosVal.LNUM] then
            lstart = sel2[PosVal.LNUM]
            cstart = sel2[PosVal.COL]
            lend = sel1[PosVal.LNUM]
            cend = sel1[PosVal.COL]
        elseif sel1[PosVal.LNUM] < sel2[PosVal.LNUM] then
            lstart = sel1[PosVal.LNUM]
            cstart = sel1[PosVal.COL]
            lend = sel2[PosVal.LNUM]
            cend = sel2[PosVal.COL]
        else
            lstart = sel2[PosVal.LNUM]
            lend = sel1[PosVal.LNUM]

            if sel2[PosVal.COL] > sel1[PosVal.COL] then
                cstart = sel1[PosVal.COL]
                cend = sel2[PosVal.COL]
            else
                cstart = sel2[PosVal.COL]
                cend = sel1[PosVal.COL]
            end
        end

        local lines = vim.api.nvim_buf_get_lines(0, lstart - 1, lend, true)
        print(cstart)
        print(cend)
        -- trim start and end line
        if #lines == 0 then return "" end

        print(vim.inspect(lines))
        lines[1] = string.sub(lines[1], cstart, -1)
        lines[#lines] = string.sub(lines[#lines], 1, cend - cstart + 1)

        print(vim.inspect(lines))

        local v = ""
        for _, line in ipairs(lines) do
            v = v..line

        end
        print(string.format("Selected:\n%s", v))
        return v
    end
}
