
-- this file contains default values window options such as line numbers and such
vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd.set('tabstop=4')
vim.cmd.set('shiftwidth=4')

vim.cmd.set('expandtab')
vim.cmd.set('iskeyword-=_')

vim.opt.termguicolors = true

vim.lsp.inlay_hint.enable(true);

vim.api.nvim_create_user_command("TabWidth", function(props)
    vim.cmd.set('tabstop='..props.fargs[1])
    vim.cmd.set('shiftwidth='..props.fargs[1])
end, {
    nargs = 1
})
    vim.cmd.set('expandtab')
local function makeHandler(val, number)
	local formatted = string.format('%s=%d', val, number)
	return function()
		vim.cmd.set(formatted)
	end
end


for i = 0, 9 do
	local formatted = string.format('<leader>ts%d', i)
	local formatted2 = string.format('<leader>sw%d', i)

	vim.keymap.set('n', formatted, makeHandler('tabstop', i))
	vim.keymap.set('n', formatted2, makeHandler('shiftwidth', i))
end

