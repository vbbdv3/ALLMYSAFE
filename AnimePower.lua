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

btns:Button("STOP", function()
getgenv().on = false
end)

btns:Button("KILL_ALL_SLOW...", function()
_G.Dungeon_enabled = not _G.Dungeon_enabled

local lplr = game.Players.LocalPlayer
local enemies_folder = workspace.temp
local target;

function getClosestEnemy()
    local result;
    local result_distance = math.huge
    local rootPart = lplr.Character and lplr.Character:FindFirstChild('HumanoidRootPart')
    if rootPart then
        for _, enemy in pairs(enemies_folder:GetChildren()) do
            local enemy_part = enemy:FindFirstChild('HumanoidRootPart')
            local enemy_distance = enemy_part and (enemy_part.Position - rootPart.Position).Magnitude
            local enemy_health = enemy:FindFirstChild('Humanoid') and enemy.Humanoid.Health
            if enemy_distance and enemy_distance < result_distance and enemy_health and enemy_health > 0 then
                result = enemy
                result_distance = enemy_distance
            end
        end
    end
    return result, result_distance
end

while task.wait() and _G.Dungeon_enabled do
    local rootPart = lplr.Character and lplr.Character:FindFirstChild('HumanoidRootPart')
    if rootPart then
        if
            not target or
            not target.Parent or
            not target:FindFirstChild('HumanoidRootPart') or
            not target:FindFirstChild('Humanoid') or
            target.Humanoid.Health <= 0
        then
            target = getClosestEnemy()
        end
        local target_part = target and target:FindFirstChild('HumanoidRootPart')
        if target_part then
            rootPart.CFrame = target_part.CFrame
        end
    end
end
end)
