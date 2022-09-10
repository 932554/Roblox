local Signal = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/signal/main/Signal.lua"))()

local SignalManager = {}
SignalManager.__index = SignalManager
do
    function SignalManager.new()
        local self = {}
        self.Signals = {}
        return setmetatable(self, SignalManager)
    end

    function SignalManager.Construct(self: table, name: string)
        local signal = Signal.new(name)
        self.Signals[signal.Name] = signal
        return self.Signals[signal.Name]
    end
    SignalManager.construct = SignalManager.Construct

    function SignalManager.Destroy(self: table, signal)
        self.Signals[signal.Name] = nil
    end
    SignalManager.destroy = SignalManager.Destroy

    function SignalManager.DestroyAll(self: table)
        for _, signal in pairs(self.Signals) do self.Signals[signal.Name] = nil; end
    end
    SignalManager.destroyAll = SignalManager.DestroyAll

    function SignalManager.Connect(self: table, signal, ...)
        assert(signal, "Expected argument #1 for 'Connect', got nil")
        if type(signal) == "table" then return signal:Connect(...); end

        local found = self.Signals[signal]
        assert(found, "Attempted to fire a signal that does not exist.")
        return found:Connect(...)
    end
    SignalManager.connect = SignalManager.Connect

    function SignalManager.Disconnect(self: table, signal)
        assert(signal, "Expected argument #1 for 'Disconnect', got nil")
        if type(signal) == "table" then return signal:Disconnect(); end

        local found = self.Signals[signal]
        assert(found, "Attempted to disconnect a signal that does not exist.")
        found:Disconnect()
    end
    SignalManager.disconnect = SignalManager.Disconnect

    function SignalManager.DisconnectAll(self: table)
        for _, signal in pairs(self.Signals) do signal:Disconnect(); end
    end
    SignalManager.disconnectAll = SignalManager.DisconnectAll

    function SignalManager.Fire(self: table, signal, ...)
        assert(signal, "Expected argument #1 for 'Fire', got nil")
        if type(signal) == "table" then return signal:Fire(...); end

        local found = self.Signals[signal]
        assert(found, "Attempted to fire a signal that does not exist.")
        found:Fire(...)
    end
    SignalManager.fire = SignalManager.Fire

    function SignalManager.Yield(self: table, signal, timeout: number)
        assert(signal, "Expected argument #1 for 'Fire', got nil")
        if type(signal) == "table" then return signal:Yield(timeout); end

        local found = self.Signals[signal]
        assert(found, "Attempted to yield a signal that does not exist.")
        found:Yield(timeout)
    end
    SignalManager.yield = SignalManager.Yield
end

return SignalManager
