local Players = game:GetService("Players")
local Player = Players.LocalPlayer

hookfunction(Player.Kick, function() return; end)

namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if rawequal(method, "Kick") and rawequal(self, Player) then return; end
    return namecall(self, ...)
end)
