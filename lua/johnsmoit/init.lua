
local jconf = {
	-- pm = require('johnsmoit.johns_pm')
}


jconf.remaps = require("johnsmoit.remap")
jconf.commands = require('johnsmoit.commands')

-- no more janky ass custom autoclose...
-- jconf.autoClose = require('johnsmoit.autoClose')

jconf.windowing = require('johnsmoit.windowing')
jconf.format_utils = require("johnsmoit.format_utils")

require("johnsmoit.setup")

return jconf

