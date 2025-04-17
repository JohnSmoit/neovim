local commands = require("clangd-cc.commands")
local config = require("clangd-cc.config")

-- keymaps (if any)


local function setup(setupOpts)
    print("Loading clangd-compile-commands")
    config.set(setupOpts)
    commands.init()
end

return {
    setup = setup,
}
