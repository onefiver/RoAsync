# Queue
**Queue** is a core module of RoAsync that allows you to manage a queue of tasks in Roblox.  
It ensures tasks are executed in order (FIFO) and supports limiting concurrency.
> In RoAsync, you create a queue using `RoAsync.Queue(concurrency)`.

---

## Table of Contents
- [Overview](#overview)
- [Creating a Queue](#creating-a-queue)
- [API](#api)
  - [Add(task)](#addtask)
  - [SetConcurrency(n)](#setconcurrencyn)
  - [Clear()](#clear)
  - [Size()](#size)
- [Examples](#examples)

---

## Overview
A **Queue** allows you to:
- Add tasks to be executed in order  
- Limit the number of tasks running simultaneously  
- Integrate seamlessly with TaskManager for asynchronous execution  
- Dynamically adjust concurrency  
- Clear or inspect pending tasks  

---

## Creating a Queue
```lua
local RoAsync = require(game:GetService("ReplicatedStorage").RoAsync)

-- Create a queue with 2 concurrent tasks
local q = RoAsync.Queue(2)
```
* **concurrency**: maximum number of tasks that can run at the same time.
  Default is unlimited if omitted.

---

## API
### `Add(task)`
Adds a task (function) to the queue. Executes automatically if there is available concurrency.
```lua
q:Add(function()
	print("Task running")
	task.wait(1)
	print("Task finished")
end)
```

---

### `SetConcurrency(n)`
Changes the maximum number of tasks that can run concurrently.
```lua
q:SetConcurrency(3)
```
* Starts executing more tasks if there are pending tasks in the queue.

---

### `Clear()`
Clears all pending tasks from the queue. Does not affect tasks already running.
```lua
q:Clear()
```

---

### `Size()`
Returns the number of pending tasks in the queue.
```lua
print("Pending tasks:", q:Size())
```

---

## Examples
### Simple queue
```lua
local q = RoAsync.Queue(2)

for i = 1, 5 do
	q:Add(function()
		print("Task", i, "started")
		task.wait(1)
		print("Task", i, "finished")
	end)
end
```

### Dynamic concurrency
```lua
q:SetConcurrency(3) -- increase concurrency while tasks are running
```

### Clearing the queue
```lua
q:Clear() -- remove all pending tasks
```

---

> Queue works together with TaskManager to ensure all tasks run asynchronously without blocking the game.
