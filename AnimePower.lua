local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("discord library")

win:Server("Main", "http://www.roblox.com/asset/?id=6031075938")

btns:Button("ShadowsEgg", function()
_G.shadowsegg_enabled = not _G.shadowsegg_enabled
while _G.shadowsegg_enabled do
local args = {
    [1] = "rollChampion",
    [2] = "one",
    [3] = "shadows city"
}
game:GetService("ReplicatedStorage").Shared.events.RemoteEvent:FireServer(unpack(args))
wait(0.1)
end)

btns:Button("Roll_Swords", function()
_G.RollSwords_enabled = not _G.RollSwords_enabled
while _G.RollSwords_enabled do
local args = {
    [1] = "rollSwords",
    [2] = "one"
}
game:GetService("ReplicatedStorage").Shared.events.RemoteEvent:FireServer(unpack(args))
wait(0.1)
end)

btns:Button("Roll_Lineages", function()
_G.rollLineages_enabled = not _G.rollLineages_enabled
while _G.rollLineages_enabled do
local args = {
    [1] = "rollLineages"
}
game:GetService("ReplicatedStorage").Shared.events.RemoteEvent:FireServer(unpack(args))
wait(0.1)
end)

btns:Button("Roll_Hakis", function()
_G.rollHakis_enabled = not _G.rollHakis_enabled
while _G.rollHakis_enabled do
local args = {
    [1] = "rollHakis"
}
game:GetService("ReplicatedStorage").Shared.events.RemoteEvent:FireServer(unpack(args))
wait(0.1)
end)
