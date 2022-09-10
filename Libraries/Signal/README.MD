# Signal
Open-source signal library

# Usage

## Adding the loadstring to your project
```lua
local Manager = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Signal/Manager.lua"))()
```

## Initializing the library
```lua
local Signal = Manager.new()
```

## Constructing a new signal
```lua
<table> Signal:Construct(<string> signalName)
```

## Connecting to a signal
```lua
<table> Signal:Connect(<string> signalName, <function> callback)
```

## Firing a signal
```lua
<void> Signal:Fire(<string> signalName, <any> ...)
```

## Yielding until a signal is fired
```lua
<void> Signal:Yield(<string> signalName, <number>? timeout)
```

## Destroying a signal
```lua
<void> Signal:Destroy(<table> signal)
```

## Destroying all signals
```lua
<void> Signal:DestroyAll(<void>)
```

## Disconnecting a signal
```lua
<void> Signal:Disconnect(<table> signal) -- can also put the signal name here
```

## Disconnecting all signals
```lua
<void> Signal:DisconnectAll(<void>)
```

## Example
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Signal/Manager.lua"))()

local Manager = Library.new()

local Signal = Manager:Construct("Print") -- using "Print" as the signal name

local Connection = Manager:Connect(Signal, print) -- connecting to "Print" and printing the data (can also use signal name here)

Manager:Fire(Signal, "This will be printed to the dev console.") -- can also use the signal name here

Manager:Disconnect(Connection) -- Manager:Disconnect("Print")

Manager:Destroy(Signal)
```

## Example with yielding
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Signal/Manager.lua"))()

local Manager = Library.new()

local Signal = Manager:Construct("Print") -- using "Print" as the signal name

local Connection = Manager:Connect(Signal, print) -- connecting to "Print" and printing the data (can also use signal name here)

task.delay(5, function() -- wait 5 seconds then fire the signal
    Manager:Fire(Signal, "This will be printed to the dev console.") -- can also use the signal name here
end)

Manager:Yield(Signal) -- Yield the thread until "Print" is fired (can also use the signal name here)

warn("Signal has been fired")

Manager:Disconnect(Connection) -- Manager:Disconnect("Print")

Manager:Destroy(Signal)
```
