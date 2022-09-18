-- Name: Character Patcher
-- Description: A library to help make scripts for games which use custom characters
-- Author: 932554
-- Supported: Bad Business, and all games which use Player.Character (more coming soon)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teams = game:GetService("Teams")

-- // Auxiliary \\ --

local function FindFirstChild(p, c)
    local s, o = pcall(function() return p[c]; end)
    if s and o then return o; end
end

local function FindFirstChildOfClass(p, c) -- if someone knows a better way to do let me know pls
    for _, v in ipairs(p:GetChildren()) do
        if v.ClassName == c then return v; end
    end
end

-- // Library \\ --

local Patcher = {}
do -- default methods will work for most games
    function Patcher.getCharacter(player)
        return (player.ClassName == "Model" and player) or player.Character
    end
    Patcher.GetCharacter = Patcher.getCharacter

    function Patcher.getHealth(char)
        local hum = FindFirstChildOfClass(char, "Humanoid")
        return hum.Health or 0, hum.MaxHealth or 100
    end
    Patcher.GetHealth = Patcher.getHealth

    function Patcher.getBodyParts(char)
        return { -- kinda aids but whatever (also if someone knows a better way to do this pls let me know)
            PrimaryPart = char.PrimaryPart or
                FindFirstChild(char, "HumanoidRootPart"),

            Head = FindFirstChild(char, "Head"),

            UpperTorso = FindFirstChild(char, "UpperTorso") or
                FindFirstChild(char, "Torso"),
            LowerTorso = FindFirstChild(char, "LowerTorso") or
                FindFirstChild(char, "Torso"),

            LeftUpperArm = FindFirstChild(char, "LeftUpperArm") or
                FindFirstChild(char, "Left Arm"),
            RightUpperArm = FindFirstChild(char, "RightUpperArm") or
                FindFirstChild(char, "Right Arm"),

            LeftLowerArm = FindFirstChild(char, "LeftLowerArm") or
                FindFirstChild(char, "Left Arm"),
            RightLowerArm = FindFirstChild(char, "RightLowerArm") or
                FindFirstChild(char, "Right Arm"),

            LeftUpperLeg = FindFirstChild(char, "LeftUpperLeg") or
                FindFirstChild(char, "Left Leg"),
            RightUpperLeg = FindFirstChild(char, "RightUpperLeg") or
                FindFirstChild(char, "Right Leg"),

            LeftLowerLeg = FindFirstChild(char, "LeftLowerLeg") or
                FindFirstChild(char, "Left Leg"),
            RightLowerLeg = FindFirstChild(char, "RightLowerLeg") or
                FindFirstChild(char, "Right Leg")
        }
    end
    Patcher.GetBodyParts = Patcher.getBodyParts

    function Patcher.getTeam(player)
        return player.Team
    end
    Patcher.GetTeam = Patcher.getTeam
end


do -- game specific overrides
    if game.PlaceId == 3233893879 then -- bad business
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
end

return Patcher
