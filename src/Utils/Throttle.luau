--!strict
local function Throttle(func: (...any) -> (), interval: number)
	local lastCall = 0

	return function(...: any)
		local now = os.clock()
		if now - lastCall >= interval then
			lastCall = now
			func(...)
		end
	end
end

return Throttle
