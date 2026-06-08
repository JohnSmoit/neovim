vim.api.nvim_create_user_command('Conf', function()
    local configPath = vim.fn.stdpath("config")
    vim.cmd.Oil(configPath)
    vim.fn.chdir(configPath)
    vim.cmd('echo "The madness continues..."')
end, {})


-- WIP: Set based on current buffer directory options as well as oil viewed directory
vim.api.nvim_create_user_command("SetDir", function(opts)
    vim.notify(string.format("SetDir args: %s", vim.inspect(opts.fargs)), vim.log.levels.INFO)
end, {
        desc = "Changes the working directory to the provided directory (or the directory of the active buffer if none is specified)",
        nargs = "?"
    })

-- too lazy to set this up zzzzzzzz.
-- local builtin = require('telescope.builtin')
--
-- vim.keymap.set('n', '<leader>rg', function()
--     local results = builtin.grep_string{search = vim.fn.input('Enter search string: ')}
--     print(vim.inspect(results))
-- end, {
--     desc = "Find and replace for all files in a project folder I guess", 
-- })
