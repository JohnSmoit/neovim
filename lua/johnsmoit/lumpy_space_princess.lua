

local lsp_group = vim.api.nvim_create_augroup("lumpy_space_princess", {})
-- Enabling specific lsp features based on client/server support
vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    end
})

-- specific configurations for language servers

