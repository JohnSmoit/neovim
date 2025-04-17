vim.api.nvim_create_user_command('Conf', function()
	vim.cmd.Ex('$XDG_CONFIG_HOME'..'/nvim')
	vim.cmd('echo "The madness continues..."')
end, {})
