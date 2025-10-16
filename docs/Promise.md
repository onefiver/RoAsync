# Promise
**Promise** is a core feature of RoAsync that allows you to handle asynchronous operations in Roblox.  
You can create promises, chain success and error callbacks, and integrate smoothly with TaskManager.
> Note: In RoAsync, you create a promise using `RoAsync.Promise(executor)`.

---

## Table of Contents

- [Overview](#overview)
- [Creating a Promise](#creating-a-promise)
- [API](#api)
  - [:Then(callback)](#thencallback)
  - [:Catch(callback)](#catchcallback)
  - [Promise.Resolve(value)](#promiseresolvevalue)
  - [Promise.Reject(reason)](#promiserejectreason)
- [Examples](#examples)

---

## Overview
A **Promise** represents a value that may be available now, later, or never.  
It allows you to:
- Execute asynchronous tasks  
- Chain multiple callbacks for success or failure  
- Handle errors in a structured way  
- Integrate seamlessly with TaskManager  

---

## Creating a Promise
```lua
local RoAsync = require(pathToRoAsync)

local p = RoAsync.Promise(function(resolve, reject)
	-- Asynchronous operation
	task.wait(1)
	if math.random() > 0.5 then
		resolve("Success!")
	else
		reject("Failure")
	end
end)
````

* **executor**: function that receives two callbacks:
  * `resolve(value)` → called when the operation succeeds
  * `reject(reason)` → called when the operation fails

---

## API
### `:Then(callback)`
Adds a callback to be executed when the promise is resolved successfully.
* **Parameters:**
  * `callback(value)` → function to execute on success
* **Returns:**
  * The same promise instance (allows chaining)

---

### `:Catch(callback)`
Adds a callback to be executed when the promise is rejected.
* **Parameters:**
  * `callback(reason)` → function to execute on failure
* **Returns:**
  * The same promise instance (allows chaining)

---

### `Promise.Resolve(value)`
Creates a promise **already resolved** with the given value.
* **Parameters:**
  * `value` → value to resolve
* **Returns:**
  * Promise instance

---

### `Promise.Reject(reason)`
Creates a promise **already rejected** with the given reason.
* **Parameters:**
  * `reason` → error or rejection reason
* **Returns:**
  * Promise instance
  
---

## Examples
### Basic usage
```lua
local p = RoAsync.Promise(function(resolve, reject)
	task.wait(1)
	resolve("Hello Promise")
end)

p:Then(print) -- Output: Hello Promise
```

### Handling rejection
```lua
local p = RoAsync.Promise(function(resolve, reject)
	task.wait(1)
	reject("Something went wrong")
end)

p:Catch(print) -- Output: Something went wrong
```

### Chaining multiple callbacks
```lua
RoAsync.Promise(function(resolve)
	task.wait(1)
	resolve(10)
end)
:Then(function(value)
	print("First then:", value)
	return value * 2
end)
:Then(function(value)
	print("Second then:", value)
end)
:Catch(function(err)
	print("Error:", err)
end)
```

---

> For more details on asynchronous execution and integration with TaskManager, see [TaskManager](TaskManager.md).
