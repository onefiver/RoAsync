--!strict
local function Debounce(func: (...any) -> (), delaySeconds: number)
	local lastCall = 0

	return function(...: any)
		local now = os.clock()
		if now - lastCall >= delaySeconds then
			lastCall = now
			func(...)
		end
	end
end

return Debounce
