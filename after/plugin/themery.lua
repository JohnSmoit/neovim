require("themery").setup({
    themes = {{
        name = "Gruvbox Dark",
        colorscheme = "gruvbox",
        before = [[
            vim.opt.background = "dark"
            ]]
    },
    {
        name = "Gruvbox Light",
        colorscheme = "gruvbox",
        before = [[
            vim.opt.background = "light"
            ]]
    },
    {
        name = "TokyoNight -- Night",
        colorscheme = "tokyonight-night"
    },
    {
        name = "TokyoNight -- Storm",
        colorscheme = "tokyonight-storm"
    },
    {
        name = "TokyoNight -- Day",
        colorscheme = "tokyonight-day"
    },
    {
        name = "TokyoNight -- Moon",
        colorscheme = "tokyonight-moon"
    },
    {
        name = "Dracula",
        colorscheme = "dracula"
    }
    },
})
