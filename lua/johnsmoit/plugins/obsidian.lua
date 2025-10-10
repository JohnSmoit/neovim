return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",

    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
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
    },
}
