local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("discord library")

local serv = win:Server("Anime_Power", "")

local btns = serv:Channel("Buttons")

btns:Button("ShadowsEgg", function()
getgenv().on = true
while true do
    if not on then break end
local args = {
    [1] = "rollChampion",
    [2] = "one",
    [3] = "shadows city"
}
game:Button("ReplicatedStorage").Shared.events.RemoteEvent:FireServer(unpack(args))
wait(0.1)
        end
end)

btns:Button("Roll_Swords", function()
getgenv().on = true
while true do
    if not on then break end
local args = {
    [1] = "rollSwords",
    [2] = "one"
}
game:GetService("ReplicatedStorage").Shared.events.RemoteEvent:FireServer(unpack(args))
wait(0.1)
        end
end)

btns:Button("Roll_Lineages", function()
getgenv().on = true
while true do
    if not on then break end
local args = {
    [1] = "rollLineages"
}
game:GetService("ReplicatedStorage").Shared.events.RemoteEvent:FireServer(unpack(args))
wait(0.1)
        end
end)

btns:Button("Roll_Hakis", function()
getgenv().on = true
while true do
    if not on then break end
local args = {
    [1] = "rollHakis"
}
game:GetService("ReplicatedStorage").Shared.events.RemoteEvent:FireServer(unpack(args))
wait(0.1)
        end
end)
