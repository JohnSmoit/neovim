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

-- TODO: Move all lsp stuff into their respective LSP configurations
-- Planning on dropping lspzero and lspconfig and using the base provider since it seems better now
-- lsp stuff
vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', '<leader>sad', function()
    vim.diagnostic.open_float({
        header = "Oopsies Detected"
    })
end)
-- c/c++
vim.keymap.set('n', '<leader>sh', ':ClangdSwitchSourceHeader<CR>')

