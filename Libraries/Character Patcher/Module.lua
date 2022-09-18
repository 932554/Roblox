-- Name: Character Patcher Loader
-- Description: Use this when trying to load the character patcher. This will automatically search for game patches for the game you are playing.
-- Author: 932554

do
    local found, patcher = pcall(game.HttpGet, game, string.format("%s/%s.lua", "https://github.com/932554/Roblox/tree/main/Libraries/Character%20Patcher/Patcher/Patches", game.PlaceId))
    if not found then -- if a game specific patch for your current game isn't found then load the default patcher
        patcher = game:HttpGet("https://raw.githubusercontent.com/932554/Roblox/main/Libraries/Character%20Patcher/Patcher/Module.lua")
    end
    return loadstring(patcher)()
end
