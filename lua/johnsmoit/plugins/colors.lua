local function doLiterallyNothing()
end
return {
    {
        "dracula/vim",
        lazy = false,
        name = "dracula",
        opts = {},
        config = doLiterallyNothing
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = doLiterallyNothing
    },
    {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
        opts = {},
        config = doLiterallyNothing
    }
}
