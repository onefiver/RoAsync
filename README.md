# RoAsync
**RoAsync** is a lightweight asynchronous utilities library for Roblox, designed to make scripting concurrent tasks easier and more readable.  

With RoAsync, you can:
- Run tasks concurrently using `Run` or `Defer`
- Execute functions after a delay with `Delay`
- Use Promises for chaining tasks and handling errors
- Manage task queues with `Queue`
- Schedule timers with `Timer`
- Use utility functions like `Throttle`, `Debounce`, `Retry` and `Sleep`

RoAsync helps you avoid manually handling `task.spawn` and `task.wait`, making your code cleaner and more maintainable.

---

## 📦 Installation
Copy the `RoAsync` .rbxm file into **ReplicatedStorage** or **ServerStorage** (not recommended) and require it in your scripts:
```lua
local RoAsync = require(pathToRoAsync)
```

---

## ⚡ Quick Start
### Run a concurrent task
```lua
RoAsync.Run(function(a, b)
    print("Sum:", a + b)
end, 5, 7)
```

### Run a deferred task
```lua
RoAsync.Defer(function()
    print("This task runs deferred")
end)
```

### Run a delayed task
```lua
RoAsync.Delay(2, function(name)
    print("Hello after 2 seconds,", name)
end, "Player")
```

---

## 📚 Learn More
Full documentation, detailed API references, and advanced examples are available on [docs](https://onefiver.github.io/RoAsync).

---

## 🔖 License
MIT License © onefiver
