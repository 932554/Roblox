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
            Root = FindFirstChild(char, "HumanoidRootPart"),

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

return Patcher
