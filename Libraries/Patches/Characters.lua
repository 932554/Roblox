-- Module: Patcher
-- Description: A library to manage game specific character patches.
-- Author: 932554

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- // Library \\ --

local Patcher = {
    Games = {
        ["Bad Business"] = {3233893879}
    }
}
Patcher.__index = Patcher
do
    function Patcher.getCharacterFromPlayer(self: table, player, index)
        if table.find(self.Games["Bad Business"], game.PlaceId) then -- bad business
            index = index or "Body"

            local ts = require(ReplicatedStorage.TS)
            local characters = debug.getupvalue(ts.Characters.GetCharacter, 1)

            local character = characters[player]
            if not character then return; end

            return (index == "Character" and character) or character:FindFirstChild(index)
        end
        return player.Character
    end
    Patcher.GetCharacterFromPlayer = Patcher.getCharacterFromPlayer
end

return Patcher
