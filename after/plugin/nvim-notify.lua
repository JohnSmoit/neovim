vim.notify = require("notify")

local telescope = require("telescope")

telescope.load_extension("notify")

vim.keymap.set("n", "<leader>fn", function()
    telescope.extensions.notify.notify()
end)
