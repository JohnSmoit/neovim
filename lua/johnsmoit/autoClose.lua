local autoClose = {}


-- Major TODOS For all features to be complete:
-- pattern construction for auto-blockify
-- replace blacklist with proper handling of special characters


local defaultKeyMaps =
{
	['"'] = {closer='"', blockify=false},
	["'"] = {closer="'", blockify=false},
	['('] = {closer=')', blockify=true},
	['['] = {closer=']', blockify=true},
	['{'] = {closer='}', blockify=true},

}

local defaultConfigKeys =
{
	toggleAutoClose = '<leader>ta',
	toggleAutoBlockify = '<leader>tb',
}


local defaultConfigVals =
{
	autoCloseEnabled = true,
	autoBlockifyEnabled = true,
	ignoreBlacklistVals = false,
}
local configKeyActions =
{
	toggleAutoClose = function()
		defaultConfigVals.autoCloseEnabled = not defaultConfigVals.autoCloseEnabled end,
	toggleAutoBlockify = function()
		defaultConfigVals.autoBlockifyEnabled = not defaultConfigVals.autoBlockifyEnabled end,
}

-- since I'm too lazy to handle cases of odd autoclose pairs,
-- I'm just gonna make a list of blacklisted keycodes


-- internal configuration values
local internalConfigs = {
	keyMaps = {},
	configVals = {},
	configKeys = {},
	blackListedKeys = {
		'<CR>',
		'<BS>',
		'<C-]>',
	},
}

local function hasSubStr(s, blackList)
	-- for item in unpack(blackList) do
	-- 	if string.find(s, item) then
	-- 		return true
	-- 	end
	-- end
	return false
end

-- handler for autoclosing parenthesis

local function handleAutoClose(key, options)
	if not internalConfigs.configVals.autoCloseEnabled then return end

	local closer = options.closer;

	return key..closer..'<Left>'
end

--handler for autoblockify
local function handleAutoBlockify(configs)
	if not internalConfigs.configVals.autoBlockifyEnabled then return end

	--find the nearest two non-whitespace characters
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))

	local line = unpack(vim.api.nvim_buf_get_lines(0, row-1, row, false))

	local s = nil
	local e = 0

	-- This is hardcoded for now until I can confirm that it works
	local pattern = "[%(%[%{]%w*[%)%]%}]"

	while true do
		s, e = string.find(line, pattern, e + 1)

		if not s or not e then break end

		local sc = string.sub(line, s, s)
		local se = string.sub(line, e, e)

		local keyConfig = configs.keyMaps[sc]
		if keyConfig and keyConfig.blockify then
			if keyConfig.closer == se and (s <= col and e > col) then
				-- perform action
				return '<CR><Tab><CR><Up><Right><Right><Right><Right>'
			end
		end
	end

	return '<CR>'
end


function autoClose.setup(configs)
	if configs == nil then
		error('No configs specified for autoClose.setup() (an empty table initialization is always required)')
		return
	end

	--process config values
	if configs.configVals ~= nil then
		for option, val in pairs(configs.configVals) do
			internalConfigs.configVals[option] = val
		end
	end

	--process config keys
	if configs.configKeys then
		for name, binding in pairs(internalConfigs.configKeys) do
			if not internalConfigs.configKeys[name] then
				error('tried to rebind nonexistent config action '..name)
			else
				internalConfigs.configKeys[name] = binding
			end
		end
	end

	--actually rebind the config values
	for name, binding in pairs(internalConfigs.configKeys) do
		vim.keymap.set('n', binding, configKeyActions[name])
	end

	--process autoClose keymaps
	if configs.keyMaps ~= nil then
		-- process each keymap and place it into the internal config storage
		local blackList = internalConfigs.blackListedKeys
		local configVals = internalConfigs.configVals
		for key, val in pairs(configs.keyMaps) do
			if not configVals.ignoreBlacklistVals and hasSubStr(key, blackList) then
				error('Attempted to use '..key..' as an autoclosed binding but '..key..' contains a blacklisted sequence!')
			else
				internalConfigs.keyMaps[key] = val
			end
		end
	end

	--rebind autoclosed keys to use handler function
	local findPairPattern = ""
	for key, val in pairs(internalConfigs.keyMaps) do
		vim.keymap.set('i', key, function() return handleAutoClose(key, val) end, {expr=true})
		--TODO: build an auto-blockify pattern matcher here as well 
	end
	

	--rebind <CR> to use blockify handler if enabled
	vim.keymap.set('i', '<CR>', function() return handleAutoBlockify(internalConfigs) end, {expr=true})
end

autoClose.setup({
	configVals = defaultConfigVals,
	configKeys = defaultConfigKeys,
	keyMaps = defaultKeyMaps,
})


return autoClose
