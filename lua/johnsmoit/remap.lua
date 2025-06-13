-- leader key (Yes I'm a space user)
vim.g.mapleader = ' '

-- the essentials:
vim.keymap.set('n', '<C-s>', vim.cmd.w)

-- some nice toggles
local wo = vim.wo
vim.keymap.set('n', '<leader>tl', function()
	wo.number = not wo.number
end)
vim.keymap.set('n', '<leader>tlr', function()
	wo.relativenumber = not wo.relativenumber
end)

-- file explorer preview
vim.keymap.set('n', '<leader>pv', vim.cmd.Oil)


