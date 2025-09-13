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
                name = "misc",
                path = "~/vaults/misc",
            },
            {
                name = "ray-eater",
                path = "~/vaults/ray-eater",
            },
        },

    },
}
