-- Inspired from Roact strict module
--!strict
local function Strict(t: { [string]: any }, name: string?)
	local newName = name or "Module"

	local proxy = {}
	for k, v in t do
		proxy[k] = v
	end

	return setmetatable(proxy, {
		__index = function(_self, key: string)
			error(("%q (%s) is not a valid member of %s"):format(tostring(key), typeof(key), newName), 2)
		end,
		__newindex = function(_self, key: string, _value: any)
			error(("%q (%s) is not a valid member of %s"):format(tostring(key), typeof(key), newName), 2)
		end,
	})
end

return Strict
