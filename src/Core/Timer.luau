local TaskManager = require(script.Parent.TaskManager)

local Timer = {}
Timer.__index = Timer

function Timer.new(interval: number, callback: () -> (), repeats: number?)
	local self = setmetatable({}, Timer)
	self._interval = interval
	self._callback = callback
	self._repeats = repeats
	self._running = false
	self._paused = false
	self._executed = 0
	return self
end

function Timer:_runLoop()
	while self._running and (self._repeats == nil or self._executed < self._repeats) do
		if not self._paused then
			TaskManager.Defer(self._callback)
			self._executed += 1
		end
		local timeElapsed = 0
		while timeElapsed < self._interval and self._running do
			if not self._paused then
				local dt = 0.1
				task.wait(dt)
				timeElapsed += dt
			else
				task.wait(0.1)
			end
		end
	end
	self._running = false
end

function Timer:Start()
	if self._running then return end
	self._running = true
	self._paused = false
	self._executed = 0
	TaskManager.Defer(function()
		self:_runLoop()
	end)
end

function Timer:Stop()
	self._running = false
	self._paused = false
	self._executed = 0
end

function Timer:Pause()
	self._paused = true
end

function Timer:Resume()
	if self._running then
		self._paused = false
	end
end

function Timer:IsRunning(): boolean
	return self._running and not self._paused
end

return Timer
