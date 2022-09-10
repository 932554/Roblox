local Player = game:GetService("Players").LocalPlayer

local Bindable = Instance.new("BindableEvent")
Bindable.Name = Player.Name.."_Chatted_Event"

Index = hookmetamethod(game, "__index", function(self, key)
    if rawequal(self, Player) and rawequal(key, "Chatted") and not checkcaller() then
        return Bindable.Event
    end
    return Index(self, key)
end)

Namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if rawequal(self.Name, "MessagePosted") and rawequal(method, "Fire") and not checkcaller() then
        return Namecall(Bindable, ...)
    end
    return Namecall(self, ...)
end)
