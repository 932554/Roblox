if not game:IsLoaded() then game.Loaded:Wait(); end

assert(setfpscap, "bad exploit")
assert(sethiddenproperty, "bad exploit")

setfpscap(300)

local lighting = game:GetService("Lighting")
lighting.Brightness = 1

local sky = lighting:FindFirstChildOfClass("Sky")
if sky then sky.StarCount = 0; end

sethiddenproperty(lighting, "Technology", Enum.Technology.Voxel)

local terrain = workspace:FindFirstChildOfClass("Terrain")
terrain.WaterWaveSize = 0
terrain.WaterWaveSpeed = 0
terrain.WaterReflectance = 0
terrain.WaterTransparency = 0

sethiddenproperty(terrain, "Decoration", false)

settings().Rendering.QualityLevel = 2
settings().Network.IncomingReplicationLag = -1000
settings().Rendering.EagerBulkExecution = false

for _, v in ipairs(lighting:GetChildren()) do
    if v:IsA("BloomEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BlurEffect") then
        v.Enabled = false
    end
end

for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and not v.Parent:FindFirstChild("HumanoidRootPart") and not v.Parent:IsA("Tool") then
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
    elseif v:IsA("DataModelMesh") then
        sethiddenproperty(v, "LODX", Enum.LevelOfDetailSetting.Low)
        sethiddenproperty(v, "LODY", Enum.LevelOfDetailSetting.Low)
    end
end

workspace.DescendantAdded:Connect(function(inst)
    if inst:IsA("BasePart") and not inst.Parent:FindFirstChild("HumanoidRootPart") and not inst.Parent:IsA("Tool") then
        inst.Material = Enum.Material.Plastic
        inst.Reflectance = 0
    elseif inst:IsA("DataModelMesh") then
        sethiddenproperty(inst, "LODX", Enum.LevelOfDetailSetting.Low)
        sethiddenproperty(inst, "LODY", Enum.LevelOfDetailSetting.Low)
    end
end)
