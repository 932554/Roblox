if not game:IsLoaded() then game.Loaded:Wait(); end

assert(rconsolename, "unsupported exploit")

rconsolename("Chat Spy")

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DefaultChat = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
local OnMessage = DefaultChat:FindFirstChild("OnMessageDoneFiltering")

local function Print(s: string, c: string)
    rconsoleprint((c and ("@@%s@@"):format(c:upper())) or "@@WHITE@@") -- might have issues on exploits other than Synapse
    rconsoleprint(s)
end

OnMessage.OnClientEvent:Connect(function(mData)
    local speaker = Players[mData.FromSpeaker]
    local message = mData.Message

    if speaker.Name == Player.Name then
        Print("[SELF] ", "light_blue")
    elseif speaker:IsFriendsWith(Player.UserId) then
        Print("[FRIEND] ", "green")
    elseif speaker.UserId == game.CreatorId then
        Print("[OWNER] ", "red")
    end

    Print(("[%s]: "):format(speaker.Name), "cyan")
    Print(("%s%s"):format(message, "\n"))
end)
