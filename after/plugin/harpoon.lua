local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

-- telescope support
require('telescope').load_extension('harpoon')


-- nice keybindings for basic harpoon actions
vim.keymap.set('n', '<leader>mf', mark.add_file)
vim.keymap.set('n', '<leader>mm', ui.toggle_quick_menu)

vim.keymap.set('n', '<C-B>n', ui.nav_next)
vim.keymap.set('n', '<C-B>l', ui.nav_prev)
