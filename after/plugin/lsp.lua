require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        'clangd',
        'lua_ls',
        'zls'
    },
}

-- dumping my lsp stuff here I guess...
local lsp_group = vim.api.nvim_create_augroup("lumpy_space_princess", {})

-- Enabling specific lsp features based on client/server support
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        -- Note: This sucks
        -- if client:supports_method('textDocument/completion') then
        --     local chars = {}
        --     for i = 32, 126 do table.insert(chars, string.char(i)) end

        --     client.server_capabilities.completionProvider.triggerCharacters = chars
        --     vim.lsp.completion.enable(true, client.id, args.buf)
        -- end

        if client:supports_method("textDocument/formatting") then
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --     group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
            --     buffer = args.buf,
            --     callback = function()
            --         vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1500 })
            --     end
            -- })
        end

        -- other keymaps
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
vim.keymap.set('n', '<leader>sad', function()
    vim.diagnostic.open_float({
        header = "Oopsies Detected"
    })
end)

-- c/c++
vim.keymap.set('n', '<leader>sh', ':ClangdSwitchSourceHeader<CR>')

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

vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd")
