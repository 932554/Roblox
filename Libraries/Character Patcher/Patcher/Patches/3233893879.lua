-- Name: Bad Business Patch
-- Description: A custom character fix for Bad Business
-- Author: 932554

local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

    Patcher.getCharacter = function(player)
        return characters[player]
    end
    Patcher.GetCharacter = Patcher.getCharacter

    Patcher.getHealth = function(char)
        local health = FindFirstChild(char, "Health")
        local maxHealth = FindFirstChild(health, "MaxHealth")
        if not health or not maxHealth then return; end

        return health.Value, maxHealth.Value
    end
    Patcher.GetHealth = Patcher.getHealth

    Patcher.getBodyParts = function(char)
        local body = FindFirstChild(char, "Body")
        if not body then return; end
        return {
            PrimaryPart = FindFirstChild(char, "Root"),

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
    Patcher.GetBodyParts = Patcher.getBodyParts

    Patcher.getTeam = function(player)
        for _, v in ipairs(Teams:GetChildren()) do
            if FindFirstChild(v.Players, player.Name) then
                return v
            end
        end
    end
    Patcher.GetTeam = Patcher.getTeam
end

return Patcher
