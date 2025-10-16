local Promise = require(script.Parent.Parent.Core.Promise)
local Sleep = require(script.Parent.Sleep)

local function Retry<T>(func: () -> T, attempts: number, delaySeconds: number?): typeof(Promise.new(function() end))
	return Promise.new(function(resolve, reject)
		local attempt = 1

		local function tryFunc()
			local success, result = pcall(func)
			if success then
				resolve(result)
			else
				if attempt < attempts then
					attempt += 1
					if delaySeconds then
						Sleep(delaySeconds):Then(tryFunc)
					else
						tryFunc()
					end
				else
					reject(result)
				end
			end
		end

		tryFunc()
	end)
end

return Retry
