local neogen = require('neogen')

neogen.setup {
    enabled = true,
    languages = {
        c = {
            template = {
                annotation_convention = "jsdoc",
                }
        },
    }
}

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Leader>nf", function ()
    neogen.generate()
end, opts)
