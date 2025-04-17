local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

-- telescope support
require('telescope').load_extension('harpoon')


-- nice keybindings for basic harpoon actions
vim.keymap.set('n', '<leader>mf', mark.add_file)
vim.keymap.set('n', '<leader>mm', ui.toggle_quick_menu)
vim.keymap.set('n', '<C-n>', function()
	local fileNum = tonumber(vim.fn.input('Mark #: '))
	ui.nav_file(fileNum)
end)

vim.keymap.set('n', '<C-Right>', ui.nav_next)
vim.keymap.set('n', '<C-Left>', ui.nav_prev)
