vim.api.nvim_create_user_command('Conf', function()
	vim.cmd.Ex(vim.fn.stdpath("config"))
	vim.cmd('echo "The madness continues..."')
end, {})

