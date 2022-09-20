-- Name: Phantom Forces Patch
-- Description: A custom character fix for Phantom Forces
-- Author: 932554

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")

-- // Auxiliary \\ --

local function FindFirstChild(p, c)
    local s, o = pcall(function() return p[c]; end)
    if s and o then return o; end
end

local function FindFirstChildOfClass(p, c)
    for _, v in ipairs(p:GetChildren()) do
        if v.ClassName == c then return v; end
    end
end

-- // Library \\ --

local Patcher = loadstring(game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Character%20Patcher/Patcher/Module.lua"))()
do
    local ts = require(ReplicatedStorage.TS)
    local characters = debug.getupvalue(ts.Characters.GetCharacter, 1)

    Patcher.getPlayerCharacter = function(player)
        return characters[player]
    end
    Patcher.GetPlayerCharacter = Patcher.getPlayerCharacter

    Patcher.getPlayerHealth = function(player)
        local char = Patcher.getPlayerCharacter(player)
        if not char then return; end

        local health = FindFirstChild(char, "Health")
        local maxHealth = FindFirstChild(health, "MaxHealth")
        if not health or not maxHealth then return; end

        return health.Value, maxHealth.Value
    end
    Patcher.GetPlayerHealth = Patcher.getPlayerHealth

    Patcher.getCharacterBodyParts = function(char)
        local body = FindFirstChild(char, "Body")
        if not body then return; end
        return {
            Root = FindFirstChild(char, "Root"),

            Head = FindFirstChild(body, "Head"),

            UpperTorso = FindFirstChild(body, "Chest"),
            LowerTorso = FindFirstChild(body, "Abdomen"),

            LeftUpperArm = FindFirstChild(body, "LeftArm"),
            RightUpperArm = FindFirstChild(body, "RightArm"),

            LeftLowerArm = FindFirstChild(body, "LeftForearm"),
            RightLowerArm = FindFirstChild(body, "RightForearm"),

            LeftUpperLeg = FindFirstChild(body, "LeftLeg"),
            RightUpperLeg = FindFirstChild(body, "RightLeg"),

            LeftLowerLeg = FindFirstChild(body, "LeftForeleg"),
            RightLowerLeg = FindFirstChild(body, "RightForeleg"),
        }
    end
    Patcher.GetCharacterBodyParts = Patcher.getCharacterBodyParts

    Patcher.getPlayerTeam = function(player)
        for _, v in ipairs(Teams:GetChildren()) do
            if FindFirstChild(v.Players, player.Name) then
                return v
            end
        end
    end
    Patcher.GetPlayerTeam = Patcher.getPlayerTeam
end

return Patcher
