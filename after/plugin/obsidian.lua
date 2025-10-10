local obsidian = require("obsidian")

obsidian.setup({
    workspaces = {
        {
            name = "vulkan",
            path = "~/vaults/vulkan"
        },
        {
            name = "misc",
            path = "~/vaults/misc",
        }
    },

    picker = {
        name = "telescope.nvim",
    },
})
