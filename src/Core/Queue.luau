--!strict
local TaskManager = require(script.Parent.TaskManager)

local Queue = {}
Queue.__index = Queue

--[[ Internal fields in each instance:
	_tasks = array that saves all current pending functions
	_concurrency = maximum multi task quantity
	_running = current number of tasks running
--]]

function Queue.new(concurrency: number?)
	local self = setmetatable({}, Queue)
	
	self._tasks = {} :: { () -> () }
	self._concurrency = concurrency or math.huge -- inf if not defined
	self._running = 0
	return self
end

function Queue:Add(task: () -> ())
	table.insert(self._tasks, task)
	self:_tryProcess()
end

function Queue:_tryProcess()
	while self._running < self._concurrency and #self._tasks > 0 do
		local taskFunc = table.remove(self._tasks, 1)
		self._running += 1
		TaskManager.Defer(function()
			taskFunc()
			self._running -= 1
			self:_tryProcess()
		end)
	end
end

function Queue:Clear()
	self._tasks = {}
end

function Queue:Size()
	return #self._tasks
end

function Queue:SetConcurrency(n: number)
	self._concurrency = n
	self:_tryProcess()
end

return Queue
