-- Name: Phantom Forces Patch
-- Description: A custom character fix for Phantom Forces
-- Author: 932554

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
    local clientManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/ROBLOX/master/Games/Phantom%20Forces/ClientManager.lua"))()
    local client = clientManager.new()

    Patcher.getCharacter = function(player)
        local parts = client.Characters[player]
        return parts and parts.torso.Parent
    end
    Patcher.GetCharacter = Patcher.getCharacter

    Patcher.getHealth = function(player)
        local health, maxHealth = client.hud:getplayerhealth(player)
        return health, maxHealth
    end
    Patcher.GetHealth = Patcher.getHealth

    Patcher.getBodyParts = function(char)
        return {
            Root = FindFirstChild(char, "Torso"),

            Head = FindFirstChild(char, "Head"),

            UpperTorso = FindFirstChild(char, "Torso"),
            LowerTorso = FindFirstChild(char, "Torso"),

            LeftUpperArm = FindFirstChild(char, "Left Arm"),
            RightUpperArm = FindFirstChild(char, "Left Arm"),

            LeftLowerArm = FindFirstChild(char, "Left Arm"),
            RightLowerArm = FindFirstChild(char, "Left Arm"),

            LeftUpperLeg = FindFirstChild(char, "Right Leg"),
            RightUpperLeg = FindFirstChild(char, "Right Leg"),

            LeftLowerLeg = FindFirstChild(char, "Left Leg"),
            RightLowerLeg = FindFirstChild(char, "Left Leg"),
        }
    end
    Patcher.GetBodyParts = Patcher.getBodyParts

    Patcher.getTeam = function(player)
    end
    Patcher.GetTeam = Patcher.getTeam
end

return Patcher
