# Utils
**Utils** are helper functions in RoAsync that complement the core modules.  
They provide convenient tools for delays, retries, and controlling function execution frequency.
> All Utils are available directly via `RoAsync`:
```lua
local RoAsync = require(pathToRoAsync)
```

---

## Table of Contents
* [Sleep](#sleep)
* [Retry](#retry)
* [Debounce](#debounce)
* [Throttle](#throttle)

---

## Sleep
`RoAsync.Sleep(seconds)` returns a **Promise** that resolves after the specified number of seconds.
```lua
RoAsync.Sleep(2):Then(function()
	print("Done waiting 2 seconds!")
end)
```
* **seconds**: number of seconds to wait

---

## Retry
`RoAsync.Retry(func, attempts, delay)` retries a function until it succeeds or reaches the maximum attempts.
```lua
local count = 0

RoAsync.Retry(function()
	count += 1
	if math.random() < 0.7 then
		error("Failed attempt")
	end
	return "Success!"
end, 5, 1):Then(function(result)
	print("Succeeded:", result)
end):Catch(function(err)
	print("All attempts failed:", err)
end)
```
* **func**: function to execute
* **attempts**: maximum number of retries
* **delay**: optional seconds to wait between attempts

---

## Debounce
`RoAsync.Debounce(func, delay)` returns a **debounced function** that executes `func` only if it hasn’t been called in the last `delay` seconds.
```lua
local debouncedPrint = RoAsync.Debounce(print, 1)

for i = 1, 5 do
	debouncedPrint("Hello "..i)
	task.wait(0.3)
end
```
* Only the first and last calls will execute within the debounce window.
* Useful for controlling rapid event calls.

---

## Throttle
`RoAsync.Throttle(func, interval)` returns a **throttled function** that executes `func` at most once every `interval` seconds.
```lua
local throttledPrint = RoAsync.Throttle(print, 1)

for i = 1, 5 do
	throttledPrint("Hello "..i)
	task.wait(0.3)
end
```
* Ensures the function runs **at least once per interval**, ignoring extra calls in between.
* Useful for periodic updates or limiting execution frequency.

---

> All Utils are designed to work seamlessly with RoAsync's core modules for asynchronous execution.
