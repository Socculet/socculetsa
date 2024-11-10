local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local aimAssistActive = false
local aimAssistConnection
local autoClickerActive = false
local flyActive = false
local chatSpammerActive = false
local superJumpActive = false
local noFallActive = false
local antiVoidActive = false
local highJumpActive = false
local godModeActive = false
local emoteActive = false
local espActive = false

-- Create the ScreenGui and Button
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UtilityGui"
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

-- Create the "Toggle UI" Button
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 150, 0, 40)
toggleButton.Position = UDim2.new(1, -160, 0, 10)
toggleButton.BackgroundTransparency = 0.5
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.TextScaled = true
toggleButton.Text = "OPEN SOCCULET"
toggleButton.Visible = true
toggleButton.Parent = screenGui

-- Create a Frame to hold all the buttons
local buttonFrame = Instance.new("Frame")
buttonFrame.Name = "ButtonFrame"
buttonFrame.Size = UDim2.new(0, 200, 0, 360)
buttonFrame.Position = UDim2.new(1, -220, 0, 70)
buttonFrame.BackgroundTransparency = 0.5
buttonFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
buttonFrame.Visible = false
buttonFrame.Parent = screenGui

-- Function to create buttons
local function createButton(name, text, position)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 200, 0, 30)
    button.Position = position
    button.TextWrapped = true
    button.TextStrokeTransparency = 0
    button.TextStrokeColor3 = Color3.fromRGB(0, 0, 255)
    button.TextSize = 12
    button.TextColor3 = Color3.fromRGB(105, 105, 105)
    button.TextScaled = true
    button.BackgroundColor3 = Color3.fromRGB(4, 4, 4)
    button.FontFace = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    button.BorderColor3 = Color3.fromRGB(28, 43, 54)
    button.Text = text
    button.Parent = buttonFrame
    return button
end

-- Creating all the utility buttons
local aaButton = createButton("aa", "AA", UDim2.new(0, 0, 0, 0))
local kaButton = createButton("ka", "KA", UDim2.new(0, 0, 0, 35))
local superJumpButton = createButton("superjump", "Super Jump", UDim2.new(0, 0, 0, 70))
local espButton = createButton("esp", "ESP", UDim2.new(0, 0, 0, 105))
local chatSpammerButton = createButton("chatspammer", "Chat Spammer", UDim2.new(0, 0, 0, 140))
local emoteButton = createButton("emote", "Emote", UDim2.new(0, 0, 0, 175))
local flyButton = createButton("fly", "Fly", UDim2.new(0, 0, 0, 210))
local noFallButton = createButton("nofall", "No Fall", UDim2.new(0, 0, 0, 245))
local antiVoidButton = createButton("antivoid", "ANTI VOID", UDim2.new(0, 0, 0, 280))
local godModeButton = createButton("godmode", "God Mode", UDim2.new(0, 0, 0, 315))
local autoClickerButton = createButton("autoclicker", "Auto Clicker", UDim2.new(0, 0, 0, 350))
local tpAllButton = createButton("tpall", "TP All", UDim2.new(0, 0, 0, 385))
local highJumpButton = createButton("highjump", "High Jump", UDim2.new(0, 0, 0, 420))

-- Toggle the visibility of the buttonFrame (where all buttons are placed) when the "Toggle UI" button is clicked
toggleButton.MouseButton1Click:Connect(function()
    buttonFrame.Visible = not buttonFrame.Visible
end)

-- Aim Assist (AA) functionality
local function activateAimAssist()
    aimAssistActive = true
    aimAssistConnection = RunService.RenderStepped:Connect(function()
        local targetPlayer = nil
        local shortestDistance = math.huge

        -- Find the closest enemy player
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player ~= localPlayer then
                local distance = (Camera.CFrame.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    targetPlayer = player
                end
            end
        end

        -- If a target is found, adjust the aim towards it
        if targetPlayer then
            local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
            local direction = (targetPosition - Camera.CFrame.Position).unit
            local targetRotation = CFrame.lookAt(Camera.CFrame.Position, targetPosition)
            
            -- Smooth camera movement
            Camera.CFrame = Camera.CFrame:Lerp(targetRotation, 0.1) -- 0.1 gives a smooth transition
        end
    end)
end

local function deactivateAimAssist()
    if aimAssistConnection then
        aimAssistConnection:Disconnect()
    end
    aimAssistActive = false
end

aaButton.MouseButton1Click:Connect(function()
    if aimAssistActive then
        deactivateAimAssist()
    else
        activateAimAssist()
    end
end)

-- Auto-clicker functionality
local function startAutoClicker()
    autoClickerActive = true
    while autoClickerActive do
        local mouse = localPlayer:GetMouse()
        local clickEvent = Instance.new("InputObject")
        clickEvent.UserInputType = Enum.UserInputType.MouseButton1
        game:GetService("UserInputService").InputBegan:Fire(clickEvent)
        wait(1 / 20)  -- Simulate 20 CPS
    end
end

local function stopAutoClicker()
    autoClickerActive = false
end

autoClickerButton.MouseButton1Click:Connect(function()
    if autoClickerActive then
        stopAutoClicker()
    else
        startAutoClicker()
    end
end)

-- ESP functionality
local function activateESP()
    espActive = true
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local usernameLabel = Instance.new("BillboardGui")
            usernameLabel.Parent = player.Character.Head
            usernameLabel.Size = UDim2.new(0, 100, 0, 50)
            usernameLabel.StudsOffset = Vector3.new(0, 2, 0)
            
            local usernameText = Instance.new("TextLabel")
            usernameText.Parent = usernameLabel
            usernameText.Size = UDim2.new(1, 0, 1, 0)
            usernameText.Text = player.Name
            usernameText.TextColor3 = Color3.fromRGB(255, 0, 0)
            usernameText.BackgroundTransparency = 1
        end
    end
end

local function deactivateESP()
    espActive = false
    -- Remove all ESP labels
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            for _, gui in ipairs(head:GetChildren()) do
                if gui:IsA("BillboardGui") then
                    gui:Destroy()
                end
            end
        end
    end
end

espButton.MouseButton1Click:Connect(function()
    if espActive then
        deactivateESP()
    else
        activateESP()
    end
end)

-- Super Jump functionality
local function activateSuperJump()
    superJumpActive = true
    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    humanoid.JumpHeight = 200
end

local function deactivateSuperJump()
    superJumpActive = false
    humanoid.JumpHeight = 50
end

superJumpButton.MouseButton1Click:Connect(function()
    if superJumpActive then
        deactivateSuperJump()
    else
        activateSuperJump()
    end
end)

-- Fly functionality
local function startFlying()
    flyActive = true
    -- Set humanoid to 'Physics' state
    humanoid.PlatformStand = true
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
    bodyVelocity.Velocity = Vector3.new(0, 10, 0)
    bodyVelocity.Parent = humanoidRootPart
end

local function stopFlying()
    flyActive = false
    humanoid.PlatformStand = false
    humanoidRootPart:FindFirstChildOfClass("BodyVelocity"):Destroy()
end

flyButton.MouseButton1Click:Connect(function()
    if flyActive then
        stopFlying()
    else
        startFlying()
    end
end)

-- God Mode functionality
local function activateGodMode()
    godModeActive = true
    humanoid.Health = humanoid.Health + 1000000  -- Set a very high health value
    humanoid.MaxHealth = math.huge  -- Make health unlimited
    humanoid.HealthChanged:Connect(function()
        humanoid.Health = math.huge  -- Keep health constant
    end)
end

local function deactivateGodMode()
    godModeActive = false
    humanoid.Health = humanoid.MaxHealth  -- Restore health to normal
    humanoid.MaxHealth = 100
end

godModeButton.MouseButton1Click:Connect(function()
    if godModeActive then
        deactivateGodMode()
    else
        activateGodMode()
    end
end)

-- No fall damage functionality
local function enableNoFallDamage()
    noFallActive = true
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
end

local function disableNoFallDamage()
    noFallActive = false
    humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
end

noFallButton.MouseButton1Click:Connect(function()
    if noFallActive then
        disableNoFallDamage()
    else
        enableNoFallDamage()
    end
end)

-- Anti-Void functionality
local function activateAntiVoid()
    antiVoidActive = true
    -- Implement Anti-Void mechanics
end

local function deactivateAntiVoid()
    antiVoidActive = false
end

antiVoidButton.MouseButton1Click:Connect(function()
    if antiVoidActive then
        deactivateAntiVoid()
    else
        activateAntiVoid()
    end
end)

-- High Jump functionality
local function activateHighJump()
    highJumpActive = true
    humanoid.JumpHeight = 100
end

local function deactivateHighJump()
    highJumpActive = false
    humanoid.JumpHeight = 50
end

highJumpButton.MouseButton1Click:Connect(function()
    if highJumpActive then
        deactivateHighJump()
    else
        activateHighJump()
    end
end)

-- Chat Spammer functionality
local function startChatSpammer()
    chatSpammerActive = true
    while chatSpammerActive do
        local message = "SOCCULET ON TOP!!!"  -- Customize the spam message
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        wait(1)  -- Adjust spam rate
    end
end

local function stopChatSpammer()
    chatSpammerActive = false
end

chatSpammerButton.MouseButton1Click:Connect(function()
    if chatSpammerActive then
        stopChatSpammer()
    else
        startChatSpammer()
    end
end)
