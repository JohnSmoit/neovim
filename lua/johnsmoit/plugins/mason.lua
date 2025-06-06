return {
    'williamboman/mason.nvim',
    "williamboman/mason-lspconfig.nvim",
    'neovim/nvim-lspconfig',
    {
        "L3MON4D3/LuaSnip",
        version = "v2.4.0",
        build = "make install_jsregexp CC=gcc",
    },
}
