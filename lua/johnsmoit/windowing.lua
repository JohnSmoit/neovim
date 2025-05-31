-- implements basic configuration for terminal window splits
-- Functions/Keybinds:
-- 	- Toggle terminal split

-- How this works:
-- (Order is not necessarily important)
--
-- 1. Create a buffer to contain the contents of the
--    integrated terminal
--
-- 2. create a window to contain the buffer
--
-- 3. Whilst supplying the previously created (empty)
--    buffer, create an integrated terminal instance
--
-- 4. Anchor the window as a split to the bottom of the screen
--
-- 5. Profit

-- ==============================
-- ******* CONFIG OPTIONS *******
-- ==============================

-- =======================
-- ******* KEYMAPS *******
-- =======================

vim.keymap.set('n', '<leader>hs', function()
	vim.cmd('vsplit')
end)



-- =======================
-- ****** COMMANDS *******
-- =======================




-- =======================
-- ****** FUNCTIONS ******
-- =======================
