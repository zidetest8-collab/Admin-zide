-- [[ Zide admin GUI - Full English Edition with Player Dropdown ]] --

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variable to store selected player's name
local SelectedPlayerName = ""

-- Function to find Remote for silent command execution
local function GetSilentRemote()
    local hdClient = ReplicatedStorage:FindFirstChild("HDAdminHDClient")
    if hdClient then
        local signals = hdClient:FindFirstChild("Signals")
        if signals then
            return signals:FindFirstChild("RequestCommandSilent")
        end
    end
    return nil
end

-- Function to handle admin command execution with silent routing
local function RunAdminCommand(cmdText)
    local HDSignal = GetSilentRemote()
    
    local cleanCmd = cmdText
    if string.sub(cleanCmd, 1, 3) == "/e " then
        cleanCmd = string.sub(cleanCmd, 4)
    end
    
    if string.sub(cleanCmd, 1, 1) ~= "/" then
        cleanCmd = "/" .. cleanCmd
    end
    
    if HDSignal and HDSignal:IsA("RemoteFunction") then
        task.spawn(function()
            HDSignal:InvokeServer(cleanCmd)
        end)
    else
        local finalChat = cleanCmd
        if string.sub(finalChat, 1, 3) ~= "/e " then
            finalChat = "/e " .. finalChat
        end
        
        local chatService = game:GetService("TextChatService")
        if chatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local channel = chatService.TextChannels:FindFirstChild("RBXGeneral")
            if channel then channel:SendAsync(finalChat) end
        else
            local sayMsg = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
            if sayMsg then sayMsg:FireServer(finalChat, "All") end
        end
    end
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZideAdminGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Enabled = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Create Main Window
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 490)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -245)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Text = "Zide admin"
Title.Size = UDim2.new(0, 150, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Text = "X"
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

local MiniBtn = Instance.new("TextButton")
MiniBtn.Text = "-"
MiniBtn.Size = UDim2.new(0, 30, 0, 30)
MiniBtn.Position = UDim2.new(1, -75, 0, 5)
MiniBtn.Font = Enum.Font.SourceSansBold
MiniBtn.TextSize = 18
MiniBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
MiniBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MiniBtn.Parent = TopBar

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 5)
MiniCorner.Parent = MiniBtn

local Credit = Instance.new("TextLabel")
Credit.Text = "make by Zide"
Credit.Size = UDim2.new(0, 100, 0, 20)
Credit.Position = UDim2.new(0, 15, 1, -25)
Credit.Font = Enum.Font.SourceSansItalic
Credit.TextSize = 14
Credit.TextColor3 = Color3.fromRGB(150, 150, 150)
Credit.TextXAlignment = Enum.TextXAlignment.Left
Credit.BackgroundTransparency = 1
Credit.Parent = MainFrame

-- ==================== BUTTON 1: Start Destroy Player ====================
local Btn1 = Instance.new("TextButton")
Btn1.Size = UDim2.new(0, 370, 0, 40)
Btn1.Position = UDim2.new(0, 15, 0, 55)
Btn1.Text = "Start Destroy Player"
Btn1.Font = Enum.Font.SourceSansBold
Btn1.TextSize = 16
Btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn1.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
Btn1.Parent = MainFrame

local Corner1 = Instance.new("UICorner")
Corner1.CornerRadius = UDim.new(0, 6)
Corner1.Parent = Btn1

Btn1.MouseButton1Click:Connect(function()
    local commands = {"/time 0", "/disco", "/fog", "/bring all", "/ice others", "/explode others", "/re others", "/size others 10", "/god", "/warp others", "/blur others", "/freeze others", "/mute others", "/unfly all", "/unfly2 all", "/uncmdbar all", "/uncmdbar2 all"}
    for _, cmd in ipairs(commands) do
        RunAdminCommand(cmd)
    end
end)

-- ==================== BUTTON 2: Uncmdbar All ====================
local NewBtn = Instance.new("TextButton")
NewBtn.Size = UDim2.new(0, 370, 0, 40)
NewBtn.Position = UDim2.new(0, 15, 0, 105)
NewBtn.Text = "Uncmdbar All"
NewBtn.Font = Enum.Font.SourceSansBold
NewBtn.TextSize = 16
NewBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NewBtn.BackgroundColor3 = Color3.fromRGB(130, 80, 180)
NewBtn.Parent = MainFrame

local NewCorner = Instance.new("UICorner")
NewCorner.CornerRadius = UDim.new(0, 6)
NewCorner.Parent = NewBtn

NewBtn.MouseButton1Click:Connect(function()
    RunAdminCommand("/uncmdbar all")
    RunAdminCommand("/uncmdbar2 all")
end)

-- ==================== BUTTON 3: Music Theme ====================
local Btn2A = Instance.new("TextButton")
Btn2A.Size = UDim2.new(0, 370, 0, 40)
Btn2A.Position = UDim2.new(0, 15, 0, 155)
Btn2A.Text = "Play Music Theme"
Btn2A.Font = Enum.Font.SourceSansBold
Btn2A.TextSize = 15
Btn2A.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn2A.BackgroundColor3 = Color3.fromRGB(50, 120, 180)
Btn2A.Parent = MainFrame

local Corner2A = Instance.new("UICorner")
Corner2A.CornerRadius = UDim.new(0, 6)
Corner2A.Parent = Btn2A

Btn2A.MouseButton1Click:Connect(function()
    RunAdminCommand("/music 116925459199971")
    RunAdminCommand("/pitch 0.13")
    RunAdminCommand("/volume inf")
end)

-- ==================== PLAYER DROPDOWN SYSTEM (SCROLLABLE) ====================

-- Selected Player Label Indicator
local CurrentSelectLabel = Instance.new("TextLabel")
CurrentSelectLabel.Size = UDim2.new(0, 260, 0, 35)
CurrentSelectLabel.Position = UDim2.new(0, 15, 0, 205)
CurrentSelectLabel.Text = " Selected: None"
CurrentSelectLabel.Font = Enum.Font.SourceSansItalic
CurrentSelectLabel.TextSize = 14
CurrentSelectLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CurrentSelectLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CurrentSelectLabel.TextXAlignment = Enum.TextXAlignment.Left
CurrentSelectLabel.Parent = MainFrame

local CSLabelCorner = Instance.new("UICorner")
CSLabelCorner.CornerRadius = UDim.new(0, 6)
CSLabelCorner.Parent = CurrentSelectLabel

-- CONTROL BUTTON
local ControlBtn = Instance.new("TextButton")
ControlBtn.Size = UDim2.new(0, 100, 0, 35)
ControlBtn.Position = UDim2.new(0, 285, 0, 205)
ControlBtn.Text = "Control"
ControlBtn.Font = Enum.Font.SourceSansBold
ControlBtn.TextSize = 15
ControlBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ControlBtn.BackgroundColor3 = Color3.fromRGB(200, 120, 20)
ControlBtn.Parent = MainFrame

local ControlBtnCorner = Instance.new("UICorner")
ControlBtnCorner.CornerRadius = UDim.new(0, 6)
ControlBtnCorner.Parent = ControlBtn

ControlBtn.MouseButton1Click:Connect(function()
    if SelectedPlayerName ~= "" then
        RunAdminCommand("/control " .. SelectedPlayerName)
    else
        StarterGui:SetCore("SendNotification", {
            Title = "Zide admin",
            Text = "Please select a player from the list first!",
            Duration = 3
        })
    end
end)

-- ScrollingFrame for Player List
local PlayerListFrame = Instance.new("ScrollingFrame")
PlayerListFrame.Size = UDim2.new(0, 370, 0, 95)
PlayerListFrame.Position = UDim2.new(0, 15, 0, 245)
PlayerListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PlayerListFrame.BorderSizePixel = 0
PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerListFrame.ScrollBarThickness = 6
PlayerListFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
PlayerListFrame.Parent = MainFrame

local PLFrameCorner = Instance.new("UICorner")
PLFrameCorner.CornerRadius = UDim.new(0, 6)
PLFrameCorner.Parent = PlayerListFrame

-- UI List Layout
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = PlayerListFrame
UIListLayout.SortOrder = Enum.SortOrder.Name
UIListLayout.Padding = UDim.new(0, 4)

-- Refresh Dropdown Function (Real-time updates)
local function UpdatePlayerDropdown()
    for _, child in ipairs(PlayerListFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local PBtn = Instance.new("TextButton")
            PBtn.Name = player.Name
            PBtn.Size = UDim2.new(1, -10, 0, 25)
            PBtn.Text = "  " .. player.DisplayName .. " (@" .. player.Name .. ")"
            PBtn.Font = Enum.Font.SourceSans
            PBtn.TextSize = 14
            PBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            PBtn.TextXAlignment = Enum.TextXAlignment.Left
            PBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            PBtn.BorderSizePixel = 0
            PBtn.Parent = PlayerListFrame
            
            local PBtnCorner = Instance.new("UICorner")
            PBtnCorner.CornerRadius = UDim.new(0, 4)
            PBtnCorner.Parent = PBtn
            
            PBtn.MouseButton1Click:Connect(function()
                SelectedPlayerName = player.Name
                CurrentSelectLabel.Text = " Selected: " .. player.DisplayName
            end)
        end
    end
    
    PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
end

-- Listeners for Player Join/Leave
Players.PlayerAdded:Connect(UpdatePlayerDropdown)
Players.PlayerRemoving:Connect(function(player)
    if SelectedPlayerName == player.Name then
        SelectedPlayerName = ""
        CurrentSelectLabel.Text = " Selected: None"
    end
    UpdatePlayerDropdown()
end)

-- Initial Load
UpdatePlayerDropdown()

-- ==================== FEATURE 4: Chat Others ====================
local ChatInput = Instance.new("TextBox")
ChatInput.Size = UDim2.new(0, 260, 0, 40)
ChatInput.Position = UDim2.new(0, 15, 0, 350)
ChatInput.PlaceholderText = "Enter chat message here..."
ChatInput.Text = ""
ChatInput.Font = Enum.Font.SourceSans
ChatInput.TextSize = 16
ChatInput.TextColor3 = Color3.fromRGB(255, 255, 255)
ChatInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ChatInput.Parent = MainFrame

local ChatInputCorner = Instance.new("UICorner")
ChatInputCorner.CornerRadius = UDim.new(0, 6)
ChatInputCorner.Parent = ChatInput

local Btn3 = Instance.new("TextButton")
Btn3.Size = UDim2.new(0, 100, 0, 40)
Btn3.Position = UDim2.new(0, 285, 0, 350)
Btn3.Text = "Chat Others"
Btn3.Font = Enum.Font.SourceSansBold
Btn3.TextSize = 14
Btn3.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn3.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
Btn3.Parent = MainFrame

local Corner3 = Instance.new("UICorner")
Corner3.CornerRadius = UDim.new(0, 6)
Corner3.Parent = Btn3

Btn3.MouseButton1Click:Connect(function()
    if ChatInput.Text ~= "" then
        RunAdminCommand("/chat others " .. ChatInput.Text)
    end
end)

-- ==================== FEATURE 5: Server Message ====================
local SMInput = Instance.new("TextBox")
SMInput.Size = UDim2.new(0, 260, 0, 40)
SMInput.Position = UDim2.new(0, 15, 0, 400)
SMInput.PlaceholderText = "Enter server message here..."
SMInput.Text = ""
SMInput.Font = Enum.Font.SourceSans
SMInput.TextSize = 16
SMInput.TextColor3 = Color3.fromRGB(255, 255, 255)
SMInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SMInput.Parent = MainFrame

local SMInputCorner = Instance.new("UICorner")
SMInputCorner.CornerRadius = UDim.new(0, 6)
SMInputCorner.Parent = SMInput

local Btn4 = Instance.new("TextButton")
Btn4.Size = UDim2.new(0, 100, 0, 40)
Btn4.Position = UDim2.new(0, 285, 0, 400)
Btn4.Text = "Server Msg"
Btn4.Font = Enum.Font.SourceSansBold
Btn4.TextSize = 14
Btn4.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn4.BackgroundColor3 = Color3.fromRGB(150, 100, 30)
Btn4.Parent = MainFrame

local Corner4 = Instance.new("UICorner")
Corner4.CornerRadius = UDim.new(0, 6)
Corner4.Parent = Btn4

Btn4.MouseButton1Click:Connect(function()
    if SMInput.Text ~= "" then
        RunAdminCommand("/sm " .. SMInput.Text)
    end
end)

-- ==================== TOGGLE SYSTEM ====================
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

local isMinimized = false
MiniBtn.MouseButton1Click:Connect(function()
    if not isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 40)}):Play()
        MiniBtn.Text = "+"
        isMinimized = true
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 400, 0, 490)}):Play()
        MiniBtn.Text = "-"
        isMinimized = false
    end
end)

local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ZideToggleButton"
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ToggleButton.Text = "Zide"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 14
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

StarterGui:SetCore("SendNotification", {
    Title = "Zide admin",
    Text = "GUI fully translated to English! Ready to execute.",
    Duration = 5
})
