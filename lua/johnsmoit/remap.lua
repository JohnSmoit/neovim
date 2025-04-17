
vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

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

-- lsp stuff
vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>sad', function()
    vim.diagnostic.open_float({
        header = "Oopsies Detected"
    })
end)
-- c/c++
vim.keymap.set('n', '<leader>sh', ':ClangdSwitchSourceHeader<CR>')

