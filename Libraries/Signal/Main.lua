local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Connection = {}
Connection.__index = Connection
do
    function Connection.new(signal: table, callback)
        assert(typeof(callback) == "function",
            string.format("Bad argument #2 for 'new' (function expected, got %s)",
            typeof(callback)))

        local self = {}
        self.Signal = signal
        self.Callback = callback

        return setmetatable(self, Connection)
    end

    function Connection.Disconnect(self: table)
        local connections = self.Signal.Connections
        local inTable = table.find(connections, self)
        table.remove(connections, inTable)
    end
end

local Signal = {}
Signal.__index = Signal
do
    function Signal.new(name: string)
        local self = {}
        self.Id = name
        self.Connections = {}

        return setmetatable(self, Signal)
    end

    function Signal.Connect(self: table, callback)
        assert(typeof(callback) == "function",
            string.format("Bad argument #2 for 'Connect' (function expected, got %s)",
            typeof(callback)))

        local connection = Connection.new(self, callback)

        self.Connections[#self.Connections + 1] = connection

        return connection
    end

    function Signal.Disconnect(self: table)
        for _, connection in pairs(self.Connections) do
            pcall(connection.Disconnect, connection)
        end
    end

    function Signal.Fire(self: table, ...)
        for _, connection in pairs(self.Connections) do
            task.spawn(connection.Callback, ...)
        end
    end

    function Signal.Yield(self: table, timeout: number)
        timeout = timeout or math.huge

        local t = {}
        local fired = false
        local connection = self:Connect(function(...)
            t = {...}
            fired = true
        end)

        local thread = coroutine.running()
        local taskId, timeSize = HttpService:GenerateGUID(false), 0
        RunService:BindToRenderStep(taskId,
            Enum.RenderPriority.First.Value,
            function(dT)
                if fired or timeSize >= timeout then
                    RunService:UnbindFromRenderStep(taskId)
                    coroutine.resume(thread)
                end
                timeSize += dT
            end
        )
        coroutine.yield()

        pcall(connection.Disconnect, connection)

        return unpack(t)
    end
end

return Signal
