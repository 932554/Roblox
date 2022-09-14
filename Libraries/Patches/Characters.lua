-- Module: Patcher
-- Author: 932554

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Auxiliary \\ --

local function FindFirstChild(p, c)
    local s, o = pcall(function() return p[c]; end)
    if s and o then return o; end
end

-- // Library \\ --

local Patcher = {
    Games = {
        ["Bad Business"] = {3233893879}
    }
}
Patcher.__index = Patcher
do
    function Patcher.get(self: table, player, name)
        if table.find(self.Games["Bad Business"], game.PlaceId) then -- bad business
            local ts = require(ReplicatedStorage.TS)
            local characters = debug.getupvalue(ts.Characters.GetCharacter, 1)

            local character = characters[player]
            if not character then return; end

            return (name == "Character" and character) or
                FindFirstChild(character, name)
        end
        return player.Character
    end
    Patcher.Get = Patcher.get

    function Patcher.getCharacter(self: table, player)
        player = player or Player
        return self.get(self, player, "Character")
    end

    function Patcher.getHealth(self: table, player)
        return self.get(self, player, "Health")
    end
end

return Patcher
