--!strict
local TaskManager = require(script.Parent.TaskManager)

-- Types
type Callback = (any) -> ()
type PromiseState = "Pending" | "Resolved" | "Rejected"

local Promise = {}
Promise.__index = Promise

--[[ Each promise has: 
	_state = current state
	_value = success or error value
	_then = callbacks list to execute when success
	_catch = callbacks list to execute when error
--]]

function Promise.new(executor: (resolve: (any) -> (), reject: (any) -> ()) -> ())
	local self = setmetatable({}, Promise)
	self._state = "Pending" :: PromiseState
	self._value = nil :: any
	self._then = {} :: { Callback }
	self._catch = {} :: { Callback }
	
	local function safeExecutor()
		local success, err = pcall(function()
			executor(
				function(value)
					self:_resolve(value)
				end,
				function(reason)
					self:_reject(reason)
				end
			)
		end)
			
		if not success then
			self:_reject(err)
		end
	end
	
	TaskManager.Defer(safeExecutor)
	return self
end


function Promise:_resolve(value: any)
	if self._state ~= "Pending" then return end
	self._state = "Resolved"
	self._value = value
	
	for _, callback in ipairs(self._then) do
		TaskManager.Defer(function()
			callback(value)
		end)
	end
	
	self._then = {}
	self._catch = {}
end

function Promise:_reject(reason: any)
	if self._state ~= "Pending" then return end
	self._state = "Rejected"
	self._value = reason
	
	for _, callback in ipairs(self._catch) do
		TaskManager.Defer(function()
			callback(reason)
		end)
	end

	self._then = {}
	self._catch = {}
end

-- Public methods
function Promise:Then(callback: Callback)
	if self._state == "Resolved" then
		TaskManager.Defer(function() callback(self._value) end)
	elseif self._state == "Pending" then
		table.insert(self._then, callback)
	end
	return self
end

function Promise:Catch(callback: Callback)
	if self._state == "Rejected" then
		TaskManager.Defer(function() callback(self._value) end)
	elseif self._state == "Pending" then
		table.insert(self._catch, callback)
	end
	return self
end

-- Auxiliary methods
function Promise.Resolve(value: any)
	local p = setmetatable({}, Promise)
	p._state = "Resolved"
	p._value = value
	p._then = {}
	p._catch = {}
	return p
end

function Promise.Reject(reason: any)
	local p = setmetatable({}, Promise)
	p._state = "Rejected"
	p._value = reason
	p._then = {}
	p._catch = {}
	return p
end

return Promise
