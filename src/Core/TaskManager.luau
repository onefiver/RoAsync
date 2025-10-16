--!strict
-- Types
type TaskMap = { [number]: thread }

local TaskManager = {}
TaskManager.__index = TaskManager

local _taskIdCounter: number = 0

local ActiveTasks: TaskMap = {}
TaskManager.ActiveTasks = ActiveTasks

local MaxConcurrency: number? = nil
local CurrentRunning: number = 0
local TaskQueue: { {fn: (...any) -> (), args: {any}} } = {}

local function _generateId(): number
	_taskIdCounter += 1
	return _taskIdCounter
end

function TaskManager.Run(fn: (...any) -> (), ...: any): number
	local taskId = _generateId()
	local args = {...}
	
	local threadHandle = task.spawn(function()
		CurrentRunning += 1
		ActiveTasks[taskId] = coroutine.running()
		fn(table.unpack(args))
		ActiveTasks[taskId] = nil
		CurrentRunning -= 1
		
		if MaxConcurrency and #TaskQueue > 0 and CurrentRunning < MaxConcurrency then
			local nextTask = table.remove(TaskQueue, 1)
			TaskManager.Run(nextTask.fn, table.unpack(nextTask.args))
		end
	end)
	
	ActiveTasks[taskId] = threadHandle
	return taskId
end

function TaskManager.Defer(fn: (...any) -> (), ...: any): number
	local taskId = _generateId()
	local args = {...}

	local threadHandle = task.defer(function()
		CurrentRunning += 1
		ActiveTasks[taskId] = coroutine.running()
		fn(table.unpack(args))
		ActiveTasks[taskId] = nil
		CurrentRunning -= 1

		if MaxConcurrency and #TaskQueue > 0 and CurrentRunning < MaxConcurrency then
			local nextTask = table.remove(TaskQueue, 1)
			TaskManager.Run(nextTask.fn, table.unpack(nextTask.args))
		end
	end)

	ActiveTasks[taskId] = threadHandle
	return taskId
end

function TaskManager.Delay(seconds: number, fn: (...any) -> (), ...: any): number
	local taskId = _generateId()
	local args = {...}

	local threadHandle = task.spawn(function()
		ActiveTasks[taskId] = coroutine.running()
		task.wait(seconds)
		fn(table.unpack(args))
		ActiveTasks[taskId] = nil
	end)

	ActiveTasks[taskId] = threadHandle
	return taskId
end

function TaskManager.Cancel(taskId: number): boolean
	local threadHandle = ActiveTasks[taskId]
	if threadHandle then
		ActiveTasks[taskId] = nil
		return true
	end
	return false
end

function TaskManager.WaitForAll(): nil
	while next(ActiveTasks) do
		task.wait()
	end
end

return TaskManager
