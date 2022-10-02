local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")

-- // Auxiliary \\ --

local function IsDescendantOfCharacter(inst)
    for _, v in ipairs(Players:GetPlayers()) do
        local char = v.Character
        if char and inst:IsDescendantOf(char) then
            return true
        end
    end
    return false
end

local function OptimizeInst(inst)
    if not IsDescendantOfCharacter(inst) then
        if inst:IsA("DataModelMesh") then
            sethiddenproperty(inst, "LODX", Enum.LevelOfDetailSetting.Low)
            sethiddenproperty(inst, "LODY", Enum.LevelOfDetailSetting.Low)
        elseif inst:IsA("FaceInstance") then
            inst.Shiny = 1
        elseif inst:IsA("ParticleEmitter") or
            inst:IsA("Trail") or inst:IsA("Smoke") or
            inst:IsA("Fire") or inst:IsA("Sparkles") or
            inst:IsA("PostEffect") then
            inst.Enabled = false
        elseif inst:IsA("Explosion") then
            inst.Visible = false
        elseif inst:IsA("BasePart") then
            inst.Material = Enum.Material.Plastic
            inst.Reflectance = 0
        elseif inst:IsA("Model") then
            sethiddenproperty(inst, "LevelOfDetail", 1)
        end
    end
end

-- // Main \\ --

settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
settings().Rendering.EagerBulkExecution = false

local Sky = Lighting:FindFirstChildOfClass("Sky")
if Sky then Sky.StarCount = 0; end

local Terrain = workspace:FindFirstChildOfClass("Terrain")
if Terrain then
    sethiddenproperty(Terrain, "Decoration", false)

    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 0
end

for _, inst in ipairs(workspace:GetDescendants()) do OptimizeInst(inst); end
workspace.DescendantAdded:Connect(OptimizeInst)

for _, inst in ipairs(Lighting:GetDescendants()) do OptimizeInst(inst); end
Lighting.DescendantAdded:Connect(OptimizeInst)
