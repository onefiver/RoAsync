--!strict
local Promise = require(script.Parent.Parent.Core.Promise)

local function Sleep(seconds: number): typeof(Promise.new(function() end))
	return Promise.new(function(resolve)
		task.delay(seconds, resolve)
	end)
end

return Sleep
