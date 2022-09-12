local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local Connection = {}
Connection.__index = Connection
do
    function Connection.new(signal, callback)
        local self = {}
        self.Signal = signal
        self.Callback = callback

        return setmetatable(self, Connection)
    end

    function Connection.Disconnect(self)
        local connections = self.Signal.Connections
        table.remove(connections, table.find(connections, self))
    end
end

local Signal = {}
Signal.__index = Signal
do
    function Signal.new()
        local self = {}
        self.Id = HttpService:GenerateGUID(false)
        self.Connections = {}

        self.Connect = function(self: table, callback)
            local connection = Connection.new(self, callback)
            self.Connections[#self.Connections + 1] = connection
            return connection
        end

        self.Disconnect = function(self: table)
            for _, connection in pairs(self.Connections) do
                pcall(connection.Disconnect, connection)
            end
        end

        self.Fire = function(self: table, ...)
            for _, connection in pairs(self.Connections) do
                task.spawn(connection.Callback, ...)
            end
        end

        self.Wait = function(self: table, timeout: number)
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

        self.Destroy = function(self: table)
            self:Disconnect()
            for i in pairs(Signal) do
                if i.Id == self.Id then Signal[i] = nil; end
            end
        end

        return setmetatable(self, Signal)
    end
end

return Signal
