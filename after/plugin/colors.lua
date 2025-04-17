-- just enable the theme yay.
local function SetupColorScheme(color)
	color = color or "tokyonight-moon"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

SetupColorScheme()
