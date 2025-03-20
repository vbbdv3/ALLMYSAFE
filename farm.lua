local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
local MarketplaceService = game:GetService("MarketplaceService")
local gamename = MarketplaceService:GetProductInfo(game.PlaceId).Name

local Window = Fluent:CreateWindow({
    Title = "Apel Hub",
    SubTitle = tostring(gamename),
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})


local Tabs = {
    Credits = Window:AddTab({Title = "Credits", Icon = "book"}),
    Farm = Window:AddTab({ Title = "Farming", Icon = "align-center" }),
    Raids = Window:AddTab({Title = "Raids & Trial", Icon = "apple"}),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })

}

local Options = Fluent.Options
local player = game:GetService("Players").LocalPlayer
local character = player.Character
local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local bb=game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
    bb:CaptureController()bb:ClickButton2(Vector2.new())end)

    local autoclickbutton = game:GetService("Players").LocalPlayer.PlayerGui.Game.LowerButons["Auto Click"]
    
do
    local AutoClick = Tabs.Farm:AddToggle("Auto Energy", {Title = "Auto Energy", Default = false, Description = ""})

    local function enableclicker()
        if autoclickbutton then
                firesignal(autoclickbutton.Activated)
                firesignal(autoclickbutton.MouseButton1Click)
        end
    end
    
    AutoClick:OnChanged(function(state)
        getgenv().AutoEnergy = state
        while getgenv().AutoEnergy do
            local checkenabled = game:GetService("Players").LocalPlayer.PlayerGui.Game.LowerButons["Auto Click"]["green gradient"].Enabled
            if not checkenabled then
                pcall(enableclicker)
            end
            wait(1)
        end
    end)

    local EnemiesFolder = workspace.Enemies

    local Enemies = {}
    local nameSet = {}

    if EnemiesFolder then
        for _, enemy in ipairs(EnemiesFolder:GetChildren()) do
            local enemyname = enemy.Name
            if enemyname and not nameSet[enemyname] then
                table.insert(Enemies, enemyname)
                nameSet[enemyname] = true
            end
        end
    end

    local EnemyDropdown = Tabs.Farm:AddDropdown("Enemy", {Title = "Enemy Selector", Description = "Select enemy for farm", Values = Enemies, Multi = true, Default = {}})

    local CurrentEnemy = {}
    EnemyDropdown:OnChanged(function(Value)
        for Value, State in next, Value do
            table.insert(CurrentEnemy, Value)
        end
    end)

    function EnemyDropdown:GetSelectedValues()
        local selected = {}
        for value, state in pairs(self.Value) do
            if state then
                table.insert(selected, value)
            end
        end
        return selected
    end

    local function RefreshEnemyDropdownWithNewEnemies()
        local newEnemies = {}
        local nameSet = {}
        if EnemiesFolder then
            for _, enemy in ipairs(EnemiesFolder:GetChildren()) do
                local enemyname = enemy.Name
                if enemyname and not nameSet[enemyname] then
                    table.insert(newEnemies, enemyname)
                    nameSet[enemyname] = true
                end
            end
        end
        EnemyDropdown:SetValues(newEnemies)
    end

    Tabs.Farm:AddButton({
        Title = "Refresh Enemies",
        Description = "Update Enemies Dropdown with your current enemies on map",
        Callback = function()
            RefreshEnemyDropdownWithNewEnemies()
        end
    })

    local AutoFarm = Tabs.Farm:AddToggle("AutoFarm", {Title = "Auto Farm", Default = false, Description = ""})
    local function containsValue(value, table)
        for _, v in ipairs(table) do
            if v == value then
                return true
            end
        end
    end


    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    local teleportRadius = 10
    
    local function findNearestEnemy(selectedEnemies)
        local closestEnemy = nil
        local closestDistance = math.huge
    
        for _, enemy in pairs(EnemiesFolder:GetChildren()) do
            if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") and enemy:GetAttribute("Died") == false then
                local enemyRootPart = enemy.HumanoidRootPart
                local distance = (rootPart.Position - enemyRootPart.Position).Magnitude
    
                if containsValue(enemy.Name, selectedEnemies) and distance < closestDistance then
                    closestDistance = distance
                    closestEnemy = enemy
                end
            end
        end
    
        return closestEnemy
    end
    
    local function teleportToNearestEnemy()
        local selectedEnemies = {}
        for _, value in ipairs(EnemyDropdown:GetSelectedValues()) do
            table.insert(selectedEnemies, value)
        end
    
        local nearestEnemy = findNearestEnemy(selectedEnemies)
    
        if nearestEnemy and nearestEnemy:FindFirstChild("HumanoidRootPart") then
            local targetRootPart = nearestEnemy.HumanoidRootPart
            local distanceToEnemy = (rootPart.Position - targetRootPart.Position).Magnitude
    
            if distanceToEnemy > teleportRadius then
                rootPart.CFrame = CFrame.new(targetRootPart.Position + Vector3.new(0, 0, 3), targetRootPart.Position) -- Телепортируемся за врага
            end
        end
    end
    
    AutoFarm:OnChanged(function(state)
        getgenv().AutoFarm = state
    
        while getgenv().AutoFarm do
            task.wait()
            local Values = {}
            for _, value in ipairs(EnemyDropdown:GetSelectedValues()) do
                table.insert(Values, value)
            end
    
            -- Проверяем состояние врагов в каждом цикле
            for _, enemy in pairs(EnemiesFolder:GetChildren()) do
                if enemy:IsA("Model") and containsValue(enemy.Name, Values) then
                    -- Проверяем здоровье и состояние врага
                    if tonumber(enemy:GetAttribute("Health")) > 0 and (enemy:GetAttribute("Died") == false) then
                        teleportToNearestEnemy() -- Вызываем функцию для телепортации
                    end
                end
            end
        end
    end)



end


SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Apel Hub")
SaveManager:SetFolder("Apel Hub/"..tostring(gamename))
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

local Menu = game:GetService("CoreGui"):FindFirstChild("Menu")
if Menu then
    print("Найдено меню")
else
    local Menu = Instance.new("ScreenGui")
Menu.Name = "Menu"
local Frame = Instance.new("Frame")
Frame.Name = "Menu Button"
local ImageButton = Instance.new("ImageButton")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")

--Properties:
local coreGui = game:GetService("CoreGui")
Menu.Parent = coreGui
Menu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = Menu
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.167999998, 0, 0.230493277, 0)
Frame.Size = UDim2.new(0.040533334, 0, 0.0681614354, 0)

ImageButton.Parent = Frame
ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageButton.BorderSizePixel = 0
ImageButton.Size = UDim2.new(1, 0, 1, 0)
ImageButton.Image = "http://www.roblox.com/asset/?id=181239831"
ImageButton.MouseButton1Up:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true,"LeftControl",false,game)
end)

UIAspectRatioConstraint.Parent = ImageButton

UIAspectRatioConstraint_2.Parent = Frame
end
