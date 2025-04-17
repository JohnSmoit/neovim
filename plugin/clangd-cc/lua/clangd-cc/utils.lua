-- filesystem and directory scanning utilities


-- array stuff
local function flatmap(arr, func)
    local out = {}
    for i, val in ipairs(arr) do
        table.insert(out, func(i, val))
    end

    return out
end

local function each(arr)
    local i = 0;
    local n = #arr
    return function()
        i = i + 1
        if i <= n then return arr[i] end
    end
end

return {
    viewed_directory = function()
        if vim.bo.filetype == "netrw" then
            return vim.b.netrw_curdir
        else
            return vim.fn.expand("%:p:h")
        end
    end,


    split = function(str, delim)
        local parts = {}

        local res_pattern = string.format("[^%s]+", delim)
        for s in str:gmatch(res_pattern) do
            table.insert(parts, s)
        end

        return parts
    end,

    multiglob = function(path, patterns)
        local resmatch = ""

        for _, pattern in ipairs(patterns) do
            local pattern2 = vim.fn.globpath(path, pattern)
            resmatch = resmatch..('\n')..pattern2
        end

        return resmatch
    end,

    array = {
        flatmap = flatmap,
        each = each,
    }
}
