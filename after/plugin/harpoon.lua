local harpoon = require('harpoon')

-- telescope support
require('telescope').load_extension('harpoon')


-- nice keybindings for basic harpoon actions
vim.keymap.set('n', '<leader>mf', function()
    harpoon:list():add()
end)
vim.keymap.set('n', '<leader>mm', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set('n', '<leader>n', function() harpoon:list():next() end)
vim.keymap.set('n', '<leader>p', function() harpoon:list():prev() end)

harpoon:setup {}

vim.keymap.set("n", "<leader>mf", function()
    vim.notify(string.format("Marked file: %s", vim.api.nvim_buf_get_name(0)));
    harpoon:list():add()
end)

vim.keymap.set("n", "<C-B>l", function() harpoon:list():prev() end,
    { desc = "Cycle to previous marked file" })
vim.keymap.set("n", "<C-B>n", function() harpoon:list():next() end,
    { desc = "Cycle to next marked file" })


-- telescope integration
-- Note: this is a good reference for the basic usage of telescope's user API
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end


    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon Files",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer {},
        sorter = conf.generic_sorter {},
    }):find()
end

vim.keymap.set("n", "<leader>tm", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open Harpoon window (via telescope)" })

vim.keymap.set("n", "<leader>mm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

