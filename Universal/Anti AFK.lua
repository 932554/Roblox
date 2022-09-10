local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local IdledEvent = Player.Idled

OldConn = hookfunction(IdledEvent.Connect, function(self, ...)
    local cn = OldConn(self, ...)
    for _, cn in ipairs(getconnections(IdledEvent)) do cn:Disable(); end
    return cn
end)

OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if rawequal(self, IdledEvent) and method == "Connect" then
        local cn = OldNamecall(self, ...)
        for _, cn in ipairs(getconnections(IdledEvent)) do cn:Disable(); end
        return cn
    end
    return OldNamecall(self, ...)
end)
