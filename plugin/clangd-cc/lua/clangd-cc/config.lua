local fs = {
    cwd = "",
    augroup_id = -1,
    intermediates_dir = ""
}

local function set(configOpts)
    fs.augroup_id = vim.api.nvim_create_augroup(
        "ClangdCompileCommands",
        {clear = true}
    )

    local cwd_callback = function()
        print(string.format("Setting CWD to %s", vim.fn.getcwd()))
        fs.cwd = vim.fn.getcwd()

        fs.intermediates_dir = vim.fn.stdpath("state")..'/nvim-data'

        local pp = vim.fs.find("nvim-data", { path = fs.intermediates_dir })
        print(string.format("Stuff: %s", vim.inspect(pp)))
    end

    vim.api.nvim_create_autocmd("VimEnter",
        {
            group = fs.augroup_id,
            desc = "Sets current working directory to the inital directory nvim was opened with",
            callback = cwd_callback,
            once = true,
        }
    )

end


return {
    fs = fs,
    set = set,
}
