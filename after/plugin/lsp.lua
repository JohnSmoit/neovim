require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        'clangd',
        'lua_ls'
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
    end
})

local cmp = require("cmp")
-- code completion stuff [WIP]
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['C-a'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            end
        end, {"i", "s"}),
    })
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- base config options
vim.lsp.config("*", {
    capabilities = vim.tbl_deep_extend("force", capabilities, {
        textDocument = {
            semanticTokens = {
                multilineTokenSupport = true,
            }
        }
    }),
    root_markers = { ".git" },
})


-- specific configurations for language servers

vim.lsp.enable('lua_ls')
