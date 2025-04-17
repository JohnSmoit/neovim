local config = require("clangd-cc.config")
local utils = require("clangd-cc.utils")
local array = utils.array

local function aggregate_json(file_info, output_path)

end

local function install_dir(output_path, dir)

end

local function update_clangd_manifest(cc_file)

end

local function generate_compile_commands(rootPath)
    print("Generating compile commands...")

    -- glob directories which contain header files based on the current working
    -- directory
    -- additionally, glob all directories which contain source files
    local file_paths = array.flatmap(utils.split(utils.multiglob(rootPath, {
        "**/*.c",
        "**/*.cpp"
    }), "\n"), function(_, val)
            return {
                filename = vim.fs.basename(val),
                path = vim.fs.normalize(val),
                intermediate_json = vim.fs.normalize(config.fs.intermediates_dir..'/'..vim.fs.basename(val))
            }
    end)


    for item in array.each(file_paths) do
        print(string.format("path: %s", vim.inspect(item)))

        local jobcmd = string.format("clang -MJ %s.o.json -fsyntax-only %s", item.intermediate_json, item.path)

        local success = os.execute(jobcmd)
        if not success then
            error(string.format("Failed to generate json file for %s", item.filename))
        end


    end

    local output_file = aggregate_json(file_paths, config.fs.intermediates_dir)
    install_dir(output_file, config.fs.cwd)

    update_clangd_manifest(output_file)
end

-- does zero-indexed lua exist???????????????????
local function init()
    vim.api.nvim_create_user_command("GenCDB", function(params)

        local root = nil
        print(vim.inspect(params.fargs))
        print(params.fargs[1])
        if params.fargs[1] == "Current" then
            root = utils.viewed_directory()
        else
            if params.fargs[1] ~= nil then
                error(string.format("Invalid Argument: %s", params.fargs[1]))
            end

            root = config.fs.cwd
        end

        print(string.format("Root: %s", root))

        generate_compile_commands(root)
    end, {desc = "Generates compile_commands.json for the current directory if applicable", nargs = "?", force = true})
end

return {
    init = init,
}
