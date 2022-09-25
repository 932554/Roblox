# Signal
Open-source library for creating and using signals.

# Usage

## Adding the loadstring to your project
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Signal/Module.lua"))()
```

## Creating a new signal
```lua
Library.new(): table
```

## Connecting to a signal
```lua
Signal:Connect(callback: function): table
```

## Disconnecting a connection
```lua
Connection:Disconnect(): nil
```

## Firing a signal
```lua
Signal:Fire(...?: any): nil
```

## Waiting until a signal is fired
```lua
Signal:Wait(timeout?: number): nil
```

## Destroying a signal
```lua
Signal:Destroy(): nil
```

## Example
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Signal/Module.lua"))()

local Signal = Library.new()

local Conn = Signal:Connect(print) -- printing the data that is fired.

Signal:Fire(("Signal '%s' has been fired"):format(Signal.Id))

Conn:Disconnect()

Signal:Destroy() -- if this is called then it will automatically disconnect all connections
```

## Example with yielding
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Signal/Module.lua"))()

local Signal = Library.new()

local Conn = Signal:Connect(print) -- printing the data that is fired.

task.delay(3, function() -- wait 3 seconds then fire (using for the wait example)
    Signal:Fire(("Signal '%s' has been fired"):format(Signal.Id))
end)

Signal:Wait() -- wait until the signal has been fired

warn("After waiting")

Conn:Disconnect()

Signal:Destroy() -- if this is called then it will automatically disconnect all connections
```
