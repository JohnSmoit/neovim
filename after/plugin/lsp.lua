require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "hls",
        "astro",
        "lemminx",
        "fsautocomplete",
        "lua_ls",
        "ols",
        "clangd",
        "zls@0.14",
        "glsl_analyzer",
        "rust_analyzer",
    },
}

-- dumping my lsp stuff here I guess...
local lsp_group = vim.api.nvim_create_augroup("lumpy_space_princess", {})

-- Enabling specific lsp features based on client/server support
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function()
        vim.keymap.set("n", "<leader>gd", function()
            vim.lsp.buf.definition({ reuse_win = true, loclist = true })
        end)
    end
})

vim.keymap.set("n", "<leader>rn", function()
    vim.lsp.buf.rename()
end)


vim.keymap.set("n", "<leader>df", function()
    vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() });
end)

vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>')

vim.keymap.set('n', '<leader>sad', ':Telescope diagnostics<CR>')
vim.keymap.set('n', '<leader>ssd', ':Telescope diagnostics bufnr=0<CR>')

-- expand diagnostic detail
vim.keymap.set('n', '<leader>sd', function()
    vim.diagnostic.open_float({
        header = "Oopsies Detected"
    })
end)

-- c/c++
vim.keymap.set('n', '<leader>sh', ':LspClangdSwitchSourceHeader<CR>')

local cmp = require("cmp")
-- code completion stuff [WIP]
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- base config options
vim.lsp.config("*", {
    capabilities = vim.tbl_deep_extend("force", capabilities, {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        },
    }),
    root_markers = { ".git" },
})


-- specific configurations for language servers

vim.lsp.enable("fsautocomplete")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ols")
vim.lsp.enable("clangd")
vim.lsp.enable("zls")
vim.lsp.enable("glsl_analyzer")
vim.lsp.enable("lemminx")
vim.lsp.enable("astro")
vim.lsp.enable("hls")
vim.lsp.enable("rust_analyzer")
