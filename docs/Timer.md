# Timer
**Timer** is a core module of RoAsync that allows you to execute tasks repeatedly or after a delay, with full control over pausing, resuming, and stopping.
> In RoAsync, you create a timer using `RoAsync.Timer(interval, callback, repeats)`.

---

## Table of Contents
- [Overview](#overview)
- [Creating a Timer](#creating-a-timer)
- [API](#api)
  - [Start](#start)
  - [Stop](#stop)
  - [Pause](#pause)
  - [Resume](#resume)
  - [IsRunning](#isrunning)
- [Examples](#examples)

---

## Overview
A **Timer** allows you to:
- Execute a function periodically with a fixed interval  
- Control how many times the function runs (`repeats`)  
- Pause, resume, or stop the timer at any moment  
- Run asynchronously using TaskManager, so it doesn't block your game  

---

## Creating a Timer
```lua
local RoAsync = require(pathToRoAsync)

-- Create a timer that runs every 1 second, 5 times
local t = RoAsync.Timer(1, function()
	print("Tick")
end, 5)
```
* **interval**: time in seconds between each execution
* **callback**: function to execute
* **repeats**: optional number of times to run the timer; if omitted, it runs indefinitely

---

## API
### `Start()`
Starts the timer. Resets the execution count.
```lua
t:Start()
```

---

### `Stop()`
Stops the timer and resets the execution count.
```lua
t:Stop()
```

---

### `Pause()`
Pauses the timer temporarily. Does not reset the execution count.
```lua
t:Pause()
```

---

### `Resume()`
Resumes a paused timer.
```lua
t:Resume()
```

---

### `IsRunning()`
Returns `true` if the timer is active and not paused.
```lua
print(t:IsRunning())
```

---

## Examples
### Basic timer
```lua
local t = RoAsync.Timer(1, function()
	print("Tick")
end, 5)

t:Start()
```

### Pause and resume
```lua
local t = RoAsync.Timer(1, function()
	print("Tick")
end)

t:Start()

task.delay(3, function()
	t:Pause()
	print("Timer paused")
end)

task.delay(5, function()
	t:Resume()
	print("Timer resumed")
end)
```

### Stop the timer
```lua
task.delay(10, function()
	t:Stop()
	print("Timer stopped")
end)
```

---

> Timer works together with TaskManager to execute callbacks asynchronously, preventing blocking in your game.
