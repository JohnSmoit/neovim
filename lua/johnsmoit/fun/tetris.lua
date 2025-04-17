

local function init_tetris()
    local buf = vim.api.nvim_create_buf(false, true)

    local win = vim.api.nvim_open_win(buf, true, {
        split = 'right',
        win = 0,
        width = 10,
        style = 'minimal',
    })
end

vim.api.nvim_create_user_command("Tetris",function()
    print("Starting Tetris...")
    init_tetris()
end, {
    desc="Run tetris, from neovim to achieve peak productivity and unlock all of the centers of your brain."}
)


