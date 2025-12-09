-- Сохрани этот код как .txt файл и загрузи на pastebin/raw.github
-- Или используй напрямую через loadstring

local function LoadScript()
    -- Defuse Division ESP by Anonymous
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    local Workspace = game:GetService("Workspace")
    
    -- Удаляем старый GUI если есть
    local oldGui = CoreGui:FindFirstChild("DD_ESP_GUI")
    if oldGui then
        oldGui:Destroy()
    end
    
    -- Настройки
    local ESPEnabled = false
    local MenuVisible = false
    
    -- Создаем папку для ESP
    local ESPFolder = Instance.new("Folder")
    ESPFolder.Name = "DD_ESP_Objects"
    ESPFolder.Parent = CoreGui
    
    -- Создаем GUI
    local ScreenGUI = Instance.new("ScreenGui")
    ScreenGUI.Name = "DD_ESP_GUI"
    ScreenGUI.ResetOnSpawn = false
    ScreenGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Основное меню
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 320, 0, 220)
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -110)
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.BackgroundTransparency = 0.15
    MainFrame.BorderSizePixel = 2
    MainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
    MainFrame.Visible = false
    
    -- Скругление углов
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = MainFrame
    
    -- Заголовок
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.BackgroundTransparency = 0.3
    Title.Text = "🔫 DEFUSE DIVISION ESP"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame
    
    -- Кнопка ESP
    local ESPButton = Instance.new("TextButton")
    ESPButton.Name = "ESPButton"
    ESPButton.Size = UDim2.new(0.85, 0, 0, 45)
    ESPButton.Position = UDim2.new(0.075, 0, 0.25, 0)
    ESPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ESPButton.BackgroundTransparency = 0.1
    ESPButton.BorderSizePixel = 1
    ESPButton.BorderColor3 = Color3.fromRGB(100, 100, 100)
    ESPButton.Text = "🎯 ESP: OFF"
    ESPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ESPButton.TextSize = 16
    ESPButton.Font = Enum.Font.GothamSemibold
    ESPButton.Parent = MainFrame
    
    -- Кнопка закрытия
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 18
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = MainFrame
    
    -- Информация
    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Name = "InfoLabel"
    InfoLabel.Size = UDim2.new(1, 0, 0, 25)
    InfoLabel.Position = UDim2.new(0, 0, 1, -30)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Text = "RightControl - Open/Close Menu"
    InfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    InfoLabel.TextSize = 12
    InfoLabel.Font = Enum.Font.Gotham
    InfoLabel.Parent = MainFrame
    
    MainFrame.Parent = ScreenGUI
    ScreenGUI.Parent = CoreGui
    
    -- Функция переключения ESP
    local function ToggleESP()
        ESPEnabled = not ESPEnabled
        
        if ESPEnabled then
            ESPButton.Text = "🎯 ESP: ON 🔴"
            ESPButton.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
        else
            ESPButton.Text = "🎯 ESP: OFF"
            ESPButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            
            -- Очищаем ESP
            for _, obj in pairs(ESPFolder:GetChildren()) do
                obj:Destroy()
            end
        end
    end
    
    -- Функция создания ESP для игрока
    local function CreateESP(Player)
        if not Player.Character then return nil end
        
        local Character = Player.Character
        local Humanoid = Character:FindFirstChild("Humanoid")
        local Head = Character:FindFirstChild("Head")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        
        if not Humanoid or not Head or not HumanoidRootPart then return nil end
        
        -- Красный прямоугольник
        local Box = Instance.new("BoxHandleAdornment")
        Box.Name = Player.Name .. "_Box"
        Box.Adornee = Character
        Box.AlwaysOnTop = true
        Box.ZIndex = 10
        Box.Size = Character:GetExtentsSize() * 1.05
        Box.Color3 = Color3.fromRGB(255, 0, 0)
        Box.Transparency = 0.6
        Box.Visible = ESPEnabled
        Box.Parent = ESPFolder
        
        -- Текст с информацией
        local Billboard = Instance.new("BillboardGui")
        Billboard.Name = Player.Name .. "_Info"
        Billboard.Size = UDim2.new(0, 200, 0, 60)
        Billboard.Adornee = Head
        Billboard.AlwaysOnTop = true
        Billboard.MaxDistance = 1000
        Billboard.ExtentsOffset = Vector3.new(0, 3.5, 0)
        Billboard.StudsOffset = Vector3.new(0, 3, 0)
        
        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Text = Player.Name
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextSize = 14
        TextLabel.Font = Enum.Font.GothamBold
        TextLabel.TextStrokeTransparency = 0.5
        TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel.Parent = Billboard
        
        Billboard.Parent = ESPFolder
        
        return {
            Box = Box,
            Billboard = Billboard,
            Player = Player
        }
    end
    
    -- Функция обновления ESP
    local function UpdateESP()
        if not ESPEnabled then return end
        
        local LocalPlayer = Players.LocalPlayer
        if not LocalPlayer or not LocalPlayer.Character then return end
        
        local LocalRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not LocalRoot then return end
        
        for _, Player in pairs(Players:GetPlayers()) do
            if Player ~= LocalPlayer and Player.Character then
                local Character = Player.Character
                local Humanoid = Character:FindFirstChild("Humanoid")
                local Head = Character:FindFirstChild("Head")
                local Root = Character:FindFirstChild("HumanoidRootPart")
                
                if Humanoid and Head and Root and Humanoid.Health > 0 then
                    local ESP = ESPFolder:FindFirstChild(Player.Name .. "_Box")
                    
                    if not ESP then
                        CreateESP(Player)
                    else
                        -- Обновляем позицию
                        ESP.Adornee = Character
                        
                        -- Обновляем текст
                        local Info = ESPFolder:FindFirstChild(Player.Name .. "_Info")
                        if Info then
                            local TextLabel = Info:FindFirstChild("TextLabel")
                            if TextLabel then
                                local Distance = (Root.Position - LocalRoot.Position).Magnitude
                                TextLabel.Text = string.format("%s\nHP: %d | %dm", 
                                    Player.Name,
                                    math.floor(Humanoid.Health),
                                    math.floor(Distance)
                                )
                            end
                        end
                    end
                else
                    -- Удаляем ESP если игрок мертв
                    local Box = ESPFolder:FindFirstChild(Player.Name .. "_Box")
                    if Box then Box:Destroy() end
                    
                    local Info = ESPFolder:FindFirstChild(Player.Name .. "_Info")
                    if Info then Info:Destroy() end
                end
            end
        end
    end
    
    -- Обработчики событий
    ESPButton.MouseButton1Click:Connect(ToggleESP)
    
    CloseButton.MouseButton1Click:Connect(function()
        MenuVisible = false
        MainFrame.Visible = false
    end)
    
    -- Управление GUI
    UserInputService.InputBegan:Connect(function(Input, Processed)
        if not Processed then
            if Input.KeyCode == Enum.KeyCode.RightControl then
                MenuVisible = not MenuVisible
                MainFrame.Visible = MenuVisible
            end
        end
    end)
    
    -- Перетаскивание GUI
    local Dragging, DragInput, DragStart, StartPos
    
    local function Update(Input)
        local Delta = Input.Position - DragStart
        MainFrame.Position = UDim2.new(
            StartPos.X.Scale, 
            StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale, 
            StartPos.Y.Offset + Delta.Y
        )
    end
    
    Title.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = Input.Position
            StartPos = MainFrame.Position
            
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    
    Title.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement then
            DragInput = Input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and Input == DragInput then
            Update(Input)
        end
    end)
    
    -- Основной цикл
    local ESPLoop
    ESPLoop = RunService.RenderStepped:Connect(function()
        UpdateESP()
    end)
    
    -- Очистка при выходе игроков
    Players.PlayerRemoving:Connect(function(Player)
        local Box = ESPFolder:FindFirstChild(Player.Name .. "_Box")
        if Box then Box:Destroy() end
        
        local Info = ESPFolder:FindFirstChild(Player.Name .. "_Info")
        if Info then Info:Destroy() end
    end)
    
    -- Уведомление
    warn("🎮 Defuse Division ESP loaded!")
    warn("📌 Press RightControl to open menu")
    warn("🎯 Click ESP button to enable/disable")
    
    -- Возвращаем функцию для отключения
    return function()
        ESPLoop:Disconnect()
        ScreenGUI:Destroy()
        ESPFolder:Destroy()
        warn("🔚 ESP script unloaded")
    end
end

-- Запуск скрипта
success, unloadFunc = pcall(LoadScript)
if not success then
    warn("❌ Error loading script:", success)
end