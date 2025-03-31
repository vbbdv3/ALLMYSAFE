local DiscordLib = loadstring(game:HttpGet"https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/discord%20lib.txt")()

local win = DiscordLib:Window("discord library")

local serv = win:Server("Anime_Power", "")

local btns = serv:Channel("Buttons")

btns:Button("One Piece", function()
getgenv().on = true
while true do
    if not on then break end
local args = {
    [1] = "One Piece",
    [2] = "Single"
}
game:GetService("ReplicatedStorage").Remotes.CrystalOpen:FireServer(unpack(args))
wait(0.1)
        end
end)

btns:Button("Bleach", function()
getgenv().on = true
while true do
    if not on then break end
local args = {
    [1] = "Bleach",
    [2] = "Single"
}
game:GetService("ReplicatedStorage").Remotes.CrystalOpen:FireServer(unpack(args))
wait(0.1)
        end
end)

btns:Button("Dragon Ball", function()
getgenv().on = true
while true do
    if not on then break end
local args = {
    [1] = "Dragon Ball",
    [2] = "Single"
}
game:GetService("ReplicatedStorage").Remotes.CrystalOpen:FireServer(unpack(args))
wait(0.1)
        end
end)

btns:Button("Click", function()
getgenv().on = true
while true do
    if not on then break end
game:GetService("ReplicatedStorage").Remotes.Click:FireServer()

wait(0.01)
        end
end)

btns:Button("STOP", function()
 getgenv().on = false
 end)
