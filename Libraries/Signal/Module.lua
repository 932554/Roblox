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

    function Connection.Disconnect(self: table)
        local connections = self.Signal.Connections
        table.remove(connections, table.find(connections, self))
    end
    Connection.disconnect = Connection.Disconnect
end

local Signal = {}
Signal.__index = Signal
do
    function Signal.new()
        local self = {}
        self.Id = HttpService:GenerateGUID(false)
        self.Connections = {}

        self.Connect = function(self: table, callback)
            assert(type(callback) == "function",
                string.format("Bad argument #1 for 'Connect' (function expected, got %s)",
                typeof(callback)))

            local connection = Connection.new(self, callback)
            self.Connections[#self.Connections + 1] = connection
            return connection
        end
        self.connect = self.Connect

        self.Fire = function(self: table, ...)
            for _, connection in pairs(self.Connections) do
                task.spawn(connection.Callback, ...)
            end
        end
        self.fire = self.Fire

        self.Wait = function(self: table, timeout: number)
            timeout = timeout or math.huge

            local fired = false
            local connection = self:Connect(function()
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
        end
        self.wait = self.Wait

        self.Destroy = function(self: table)
            for _, v in pairs(self.Connections) do v:Disconnect(); end
            for i in pairs(self) do self[i] = nil; end
            self = nil
        end
        self.destroy = self.Destroy

        return setmetatable(self, Signal)
    end
end

return Signal
