--~strict
local Strict = require(script.Strict)

local TaskManager = require(script.Core.TaskManager)
local PromiseMod = require(script.Core.Promise)
local QueueMod = require(script.Core.Queue)
local TimerMod = require(script.Core.Timer)

local RoAsync = Strict({
	-- TaskManager
	Run = TaskManager.Run,
	Defer = TaskManager.Defer,
	Delay = TaskManager.Delay,
	Cancel = TaskManager.Cancel,
	WaitForAll = TaskManager.WaitForAll,
	
	-- Promise
	Promise = function(executor)
		return PromiseMod.new(executor)
	end,
	
	-- Queue
	Queue = function(concurrency)
		return QueueMod.new(concurrency)
	end,
	
	-- Timer
	Timer = function(interval, callback, repeats)
		return TimerMod.new(interval, callback, repeats)
	end,
	
	-- Utils
	Sleep = require(script.Utils.Sleep),
	Retry = require(script.Utils.Retry),
	Debounce = require(script.Utils.Debounce),
	Throttle = require(script.Utils.Throttle),
	
})

return RoAsync
