-- Инжектируемый скрипт для ESP с GUI
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Настройки
local guiEnabled = false
local espEnabled = false
local espFolder = Instance.new("Folder")
espFolder.Name = "ESP_Folder"
espFolder.Parent = CoreGui

-- Создание GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CheatMenu"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главный фрейм
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 250)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 3
mainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Внутренний фрейм для эффекта
local innerFrame = Instance.new("Frame")
innerFrame.Name = "InnerFrame"
innerFrame.Size = UDim2.new(1, -10, 1, -10)
innerFrame.Position = UDim2.new(0, 5, 0, 5)
innerFrame.BackgroundTransparency = 1
innerFrame.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 35)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.BackgroundTransparency = 0.2
title.Text = "💀 CHEAT MENU 💀"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = innerFrame

-- Кнопка ESP
local espButton = Instance.new("TextButton")
espButton.Name = "ESPButton"
espButton.Size = UDim2.new(0.85, 0, 0, 45)
espButton.Position = UDim2.new(0.075, 0, 0.25, 0)
espButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
espButton.BackgroundTransparency = 0.1
espButton.BorderSizePixel = 2
espButton.BorderColor3 = Color3.fromRGB(100, 100, 100)
espButton.Text = "❌ ESP: OFF"
espButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espButton.TextSize = 16
espButton.Font = Enum.Font.GothamSemibold
espButton.Parent = innerFrame

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "✕"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = innerFrame

-- Информация
local infoLabel = Instance.new("TextLabel")
infoLabel.Name = "InfoLabel"
infoLabel.Size = UDim2.new(1, 0, 0, 20)
infoLabel.Position = UDim2.new(0, 0, 1, -25)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "RightControl - Open/Close"
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.TextSize = 12
infoLabel.Font = Enum.Font.Gotham
infoLabel.Parent = innerFrame

-- Добавляем GUI
screenGui.Parent = CoreGui

-- Функции
local function toggleGUI()
    guiEnabled = not guiEnabled
    mainFrame.Visible = guiEnabled
end

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        espButton.Text = "✅ ESP: ON"
        espButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    else
        espButton.Text = "❌ ESP: OFF"
        espButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        for _, child in pairs(espFolder:GetChildren()) do
            if child:IsA("BoxHandleAdornment") or child:IsA("BillboardGui") then
                child:Destroy()
            end
        end
    end
end

-- ESP функция
local function updateESP()
    if not espEnabled then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        local localPlayer = Players.LocalPlayer
        if not localPlayer then continue end
        
        if player ~= localPlayer and player.Character then
            local character = player.Character
            local humanoid = character:FindFirstChild("Humanoid")
            local head = character:FindFirstChild("Head")
            
            if humanoid and head and humanoid.Health > 0 then
                -- Бокс ESP
                local box = espFolder:FindFirstChild(player.Name .. "_Box")
                if not box then
                    box = Instance.new("BoxHandleAdornment")
                    box.Name = player.Name .. "_Box"
                    box.Adornee = character
                    box.AlwaysOnTop = true
                    box.ZIndex = 10
                    box.Size = character:GetExtentsSize() * 1.05
                    box.Color3 = Color3.fromRGB(255, 0, 0)
                    box.Transparency = 0.7
                    box.Parent = espFolder
                else
                    box.Adornee = character
                end
                
                -- Текст с информацией
                local textGui = espFolder:FindFirstChild(player.Name .. "_Text")
                if not textGui then
                    textGui = Instance.new("BillboardGui")
                    textGui.Name = player.Name .. "_Text"
                    textGui.Adornee = head
                    textGui.Size = UDim2.new(0, 200, 0, 100)
                    textGui.AlwaysOnTop = true
                    textGui.MaxDistance = 1000
                    textGui.ExtentsOffset = Vector3.new(0, 3, 0)
                    
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(1, 0, 0, 50)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextStrokeTransparency = 0.5
                    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                    textLabel.Font = Enum.Font.GothamBold
                    textLabel.TextSize = 14
                    textLabel.Parent = textGui
                    
                    textGui.Parent = espFolder
                end
                
                -- Обновляем текст
                local distance = (localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")) 
                    and (head.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude 
                    or 0
                
                local textLabel = textGui:FindFirstChildOfClass("TextLabel")
                if textLabel then
                    textLabel.Text = string.format("[%s]\nDist: %d\nHP: %d", 
                        player.Name, 
                        math.floor(distance), 
                        math.floor(humanoid.Health)
                    )
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            else
                -- Удаляем ESP если игрок мертв
                local box = espFolder:FindFirstChild(player.Name .. "_Box")
                if box then box:Destroy() end
                
                local textGui = espFolder:FindFirstChild(player.Name .. "_Text")
                if textGui then textGui:Destroy() end
            end
        end
    end
end

-- Обработчики событий
espButton.MouseButton1Click:Connect(toggleESP)
closeButton.MouseButton1Click:Connect(function()
    toggleGUI()
end)

-- Горячие клавиши
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.RightControl then
            toggleGUI()
        end
    end
end)

-- Перетаскивание GUI
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

-- Основной цикл ESP
RunService.RenderStepped:Connect(function()
    updateESP()
end)

-- Автоочистка ESP при выходе игроков
Players.PlayerRemoving:Connect(function(player)
    local box = espFolder:FindFirstChild(player.Name .. "_Box")
    if box then box:Destroy() end
    
    local textGui = espFolder:FindFirstChild(player.Name .. "_Text")
    if textGui then textGui:Destroy() end
end)

-- Уведомление
task.spawn(function()
    print("✅ Инжект успешен!")
    print("📌 RightControl - открыть/закрыть меню")
    print("🎯 ESP - показывает врагов с инфой")
    
    if setclipboard then
        setclipboard("Инжект успешен! RightControl - меню")
    end
end)