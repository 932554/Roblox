# Signal
Open-source signal library

# Usage

## Adding the loadstring to your project
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Signal/Module.lua"))()
```

## Creating a new signal
```lua
<table> Library.new(<void>)
```

## Connecting to a signal
```lua
<void> Signal:Connect(<function> callback)
```

## Firing a signal
```lua
<void> Signal:Fire(<any> ...)
```

## Waiting until a signal is fired
```lua
<void> Signal:Wait(<number>? timeout)
```

## Destroying a signal
```lua
<void> Signal:Destroy(<void>)
```

## Disconnecting a signal
```lua
<void> Signal:Disconnect(<void>)
```

## Example
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Signal/Module.lua"))()

local Signal = Library.new()

Signal:Connect(print) -- printing the data that is fired.

Signal:Fire(("Signal '%s' has been fired"):format(Signal.Id))

Signal:Disconnect()

Signal:Destroy() -- if this is called, it will automatically call Signal.Disconnect
```

## Example with yielding
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Signal/Module.lua"))()

local Signal = Library.new()

Signal:Connect(print) -- printing the data that is fired.

task.delay(3, function() -- wait 3 seconds then fire (using for the wait example)
    Signal:Fire(("Signal '%s' has been fired"):format(Signal.Id))
end)

Signal:Wait() -- wait until the signal has been fired

warn("After waiting")

Signal:Disconnect()

Signal:Destroy() -- if this is called, it will automatically call Signal.Disconnect
```
