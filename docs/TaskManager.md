# TaskManager

**TaskManager** is the core module of RoAsync responsible for managing and executing asynchronous tasks in Roblox.  
It provides functions to run tasks immediately, defer execution, execute after a delay, and manage active tasks.

---

## Table of Contents

- [Overview](#overview)
- [API](#api)
  - [Run](#run)
  - [Defer](#defer)
  - [Delay](#delay)
  - [Cancel](#cancel)
  - [WaitForAll](#waitforall)
- [Examples](#examples)

---

## Overview

TaskManager is designed to make Roblox scripting asynchronous-friendly.  
It keeps track of active tasks, allows unique task IDs, and can optionally handle task queues and concurrency limits.  

It is the backbone for other modules like **Promise**, **Queue**, and **Timer**.

---

## API

### `TaskManager.Run(fn: (...any) -> (), ...: any): number`
Runs a function asynchronously **immediately** using `task.spawn`.
- **Parameters:**
  - `fn` → The function to execute.
  - `...` → Optional arguments to pass to the function.
- **Returns:**  
  - `taskId` → Unique identifier for the task.

---

### `TaskManager.Defer(fn: (...any) -> (), ...: any): number`
Runs a function asynchronously **deferred**, using `task.defer`.  
The task executes after higher priority tasks.
- **Parameters:** same as `Run`
- **Returns:** `taskId` unique

---

### `TaskManager.Delay(seconds: number, fn: (...any) -> (), ...: any): number`
Runs a function **after a delay** using `task.wait`.
- **Parameters:**
  - `seconds` → Delay in seconds.
  - `fn` → Function to execute after the delay.
  - `...` → Arguments to pass to `fn`.
- **Returns:** `taskId` unique

---

### `TaskManager.Cancel(taskId: number): boolean`
Attempts to cancel or remove a task by its ID.  
- **Parameters:**
  - `taskId` → ID of the task to cancel
- **Returns:**
  - `true` → Task removed from active tasks
  - `false` → Task not found
> ⚠️ Note: Cannot kill a thread that is already running; canceling only removes it from tracking.

---

### `TaskManager.WaitForAll(): nil`
Blocks until **all active tasks have finished**.
- **Parameters:** None
- **Returns:** None

---

## Examples
### Run a concurrent task
```lua
local taskId = TaskManager.Run(function(a, b)
    print("Sum:", a + b)
end, 5, 7)
```

### Run a deferred task
```lua
TaskManager.Defer(function()
    print("This task runs deferred")
end)
```

### Run a delayed task
```lua
TaskManager.Delay(2, function(name)
    print("Hello after 2 seconds,", name)
end, "Player")
```

### Cancel a task
```lua
local id = TaskManager.Delay(5, function() print("Won't run") end)
local canceled = TaskManager.Cancel(id)
print(canceled) -- true
```

### Wait for all tasks
```lua
TaskManager.Run(function() task.wait(2) print("Task 1 done") end)
TaskManager.Run(function() task.wait(1) print("Task 2 done") end)

print("Waiting for all tasks...")
TaskManager.WaitForAll()
print("All tasks finished")
```

---

## Related Modules
* [Promise](Promise.md) – For chaining async tasks
* [Queue](Queue.md) – Task queue management
* [Timer](Timer.md) – Timers with delays and repetition

---

> This documentation is part of RoAsync.
> For more examples and detailed guides, see [RoAsync Docs](index.md).
