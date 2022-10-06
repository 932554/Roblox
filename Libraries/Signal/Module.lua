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

    function Connection.disconnect(self: table)
        local connections = self.Signal.Connections
        table.remove(connections, table.find(connections, self))
    end
    Connection.Disconnect = Connection.disconnect
end

local Signal = {}
Signal.__index = Signal
do
    function Signal.new()
        local self = {}
        self.Id = HttpService:GenerateGUID(false)
        self.Connections = {}

        self.connect = function(self: table, callback)
            assert(type(callback) == "function",
                string.format("Bad argument #1 for 'Connect' (function expected, got %s)",
                typeof(callback)))

            local connection = Connection.new(self, callback)
            self.Connections[#self.Connections + 1] = connection
            return connection
        end
        self.Connect = self.connect

        self.fire = function(self: table, ...)
            for _, connection in pairs(self.Connections) do
                task.spawn(connection.Callback, ...)
            end
        end
        self.Fire = self.fire

        self.wait = function(self: table, timeout: number)
            timeout = timeout or math.huge

            local fired = false
            local connection; 
            connection = self:Connect(function()
                pcall(connection.Disconnect, connection)
                fired = true
            end)

            local thread = coroutine.running()
            local taskId, timeSize = HttpService:GenerateGUID(false), 0
            RunService:BindToRenderStep(taskId,
                Enum.RenderPriority.First.Value,
                function(dT)
                    if fired or (timeSize >= timeout) then
                        RunService:UnbindFromRenderStep(taskId)
                        coroutine.resume(thread)
                    end
                    timeSize += dT
                end
            )
            coroutine.yield()
        end
        self.Wait = self.wait

        self.destroy = function(self: table)
            for _, v in pairs(self.Connections) do v:Disconnect(); end
            for i in pairs(self) do self[i] = nil; end
            self = nil
        end
        self.Destroy = self.destroy

        return setmetatable(self, Signal)
    end
end

return Signal
