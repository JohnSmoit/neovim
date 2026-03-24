-- leader key (Yes I'm a space user)
vim.g.mapleader = ' '

-- some nice toggles
local wo = vim.wo
vim.keymap.set('n', '<leader>tl', function()
	wo.number = not wo.number
end)
vim.keymap.set('n', '<leader>tlr', function()
	wo.relativenumber = not wo.relativenumber
end)

vim.keymap.set('n', '<C-up>', ':cn<CR>')
vim.keymap.set('n', '<C-down>', ':cp<CR>')

-- file explorer preview
vim.keymap.set('n', '<leader>pv', vim.cmd.Oil)


