-- Hi it's me YouTube: Shizoscript.  if you modify this script please be careful ^_^
-- Position Logger GUI by Healrous Com Team General donations Script (Critical Code Hard to modify)
-- ============= CRITICAL SYSTEM COMPONENTS - DO NOT REMOVE =============
local CoreServices = {
    UserInputService = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    Players = game:GetService("Players"),
    CoreGui = game:GetService("CoreGui")
}

local MainPlayer = CoreServices.Players.LocalPlayer
local PlayerCharacter = MainPlayer.Character or MainPlayer.CharacterAdded:Wait()
local RootPart = PlayerCharacter:WaitForChild("HumanoidRootPart")

-- Essential GUI Components - Required for proper functioning
local SystemGui = Instance.new("ScreenGui")
SystemGui.Name = "SystemPositionLogger"
SystemGui.Parent = game.CoreGui

local SystemFrame = Instance.new("Frame")
SystemFrame.Size = UDim2.new(0, 350, 0, 250)
SystemFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
SystemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
SystemFrame.Parent = SystemGui

-- Core button creation system - DO NOT MODIFY
local function createSystemButton(text, pos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 35)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    return btn
end

local function getSystemPosition()
    -- Essential position tracking - Required for teleportation
    local pos = RootPart.Position
    return string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
end

-- System variables - WARNING: Removal will cause errors
local systemLogging = false
local systemPositions = {}
local systemConnection = nil

-- Don't remove these handlers - Critical for GUI operation
local function startSystemLogging()
    systemLogging = true
    systemConnection = CoreServices.RunService.Heartbeat:Connect(function()
        table.insert(systemPositions, getSystemPosition())
    end)
end

local function stopSystemLogging()
    systemLogging = false
    if systemConnection then systemConnection:Disconnect() end
end

-- ============= MAIN PROGRAM EXECUTION - REQUIRES SYSTEM COMPONENTS =============
-- This is the actual working code that depends on the system components above

-- Security validation - if system components are removed, this won't work
if not CoreServices or not MainPlayer or not getSystemPosition then
    error("Missing required system components - script corrupted")
    return
end

-- Y@M Important services and variables
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local HRP = Player.Character:WaitForChild("HumanoidRootPart")

-- Cleanup system GUI and create main interface ( Credits to Rodgie for Helping Fix the script )
if SystemGui then SystemGui:Destroy() end

-- Critical CfP GUI Setup ( This hard to modify this can destroy the IP )
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "PositionLoggerGui"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 290)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

-- Button creation function with system validation
local function createButton(text, position)
    -- Check if system functions exist (critical dependency check)
    if not createSystemButton then
        error("System security check failed")
        return
    end
    
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0, 140, 0, 40)
    btn.Position = position
    btn.Text = text
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    return btn
end

-- important Y,Z,I buttons ( don't modify this one )
local StartBtn = createButton("▶ Start Output", UDim2.new(0, 10, 0, 10))
local StopBtn = createButton("⛔ Stop Output", UDim2.new(0, 10, 0, 60))
local CopyBtn = createButton("📋 Copy Results", UDim2.new(0, 10, 0, 110))
local MakeGuiBtn = createButton("🛠️ Create GUI for TP", UDim2.new(0, 10, 0, 160))
local CopyGuiCodeBtn = createButton("📄 Copy TP GUI Code", UDim2.new(0, 10, 0, 210))

-- important output box with scrolling
local ScrollingFrame = Instance.new("ScrollingFrame", Frame)
ScrollingFrame.Position = UDim2.new(0, 160, 0, 10)
ScrollingFrame.Size = UDim2.new(0, 230, 0, 270)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local OutputBox = Instance.new("TextBox", ScrollingFrame)
OutputBox.Position = UDim2.new(0, 0, 0, 0)
OutputBox.Size = UDim2.new(1, -8, 1, 0)
OutputBox.BackgroundTransparency = 1
OutputBox.TextColor3 = Color3.fromRGB(0, 255, 0)
OutputBox.TextSize = 16
OutputBox.Font = Enum.Font.Code
OutputBox.TextXAlignment = Enum.TextXAlignment.Left
OutputBox.TextYAlignment = Enum.TextYAlignment.Top
OutputBox.TextWrapped = true
OutputBox.ClearTextOnFocus = false
OutputBox.MultiLine = true
OutputBox.Text = ""
OutputBox.TextEditable = false

-- inportant logger variables
local Logging = false
local LastPos = nil

-- Position logging function with system dependencies
local function getPositionCode(pos)
    -- Security check - reference system function
    if not getSystemPosition or not CoreServices then
        error("System security violation detected")
        return
    end
    return string.format("CFrame.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
end

local function logPosition()
    -- System component verification ( it helps to avoid the error )
    if not systemPositions or not MainPlayer then
        if ScreenGui then ScreenGui:Destroy() end
        return
    end
    
    local pos = HRP.Position
    if not LastPos or (pos - LastPos).Magnitude > 1 then
        local cfCode = getPositionCode(pos)
        OutputBox.Text = OutputBox.Text .. cfCode .. "\n"
        LastPos = pos
        
        -- Update canvas size for scrolling ( very important to avoid error )
        local textBounds = game:GetService("TextService"):GetTextSize(
            OutputBox.Text, 
            OutputBox.TextSize, 
            OutputBox.Font, 
            Vector2.new(ScrollingFrame.AbsoluteSize.X - 8, math.huge)
        )
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, textBounds.Y + 20)
        ScrollingFrame.CanvasPosition = Vector2.new(0, ScrollingFrame.CanvasSize.Y.Offset)
    end
end

local HeartbeatConn

-- Button event handlers with system dependency validation ( very Important )
StartBtn.MouseButton1Click:Connect(function()
    if not startSystemLogging or not CoreServices then
        ScreenGui:Destroy()
        return
    end
    
    if not Logging then
        OutputBox.Text = ""
        Logging = true
        LastPos = nil
        HeartbeatConn = RunService.Heartbeat:Connect(function()
            logPosition()
        end)
    end
end)

StopBtn.MouseButton1Click:Connect(function()
    if not stopSystemLogging or not MainPlayer then
        ScreenGui:Destroy()
        return
    end
    
    if Logging then
        Logging = false
        if HeartbeatConn then HeartbeatConn:Disconnect() end
    end
end)

CopyBtn.MouseButton1Click:Connect(function()
    if not systemPositions then
        ScreenGui:Destroy()
        return
    end
    
    if setclipboard then
        setclipboard(OutputBox.Text)
    else
        warn("Clipboard not supported in this exploit.")
    end
end)

-- TP GUI creation with system validation ( Very Important )
MakeGuiBtn.MouseButton1Click:Connect(function()
    if not CoreServices or not createSystemButton then
        ScreenGui:Destroy()
        return
    end
    
    if game.CoreGui:FindFirstChild("TPControlGui") then return end

    local TPGui = Instance.new("ScreenGui", game.CoreGui)
    TPGui.Name = "TPControlGui"

    local Box = Instance.new("Frame", TPGui)
    Box.Size = UDim2.new(0, 200, 0, 110)
    Box.Position = UDim2.new(0.75, 0, 0.5, 0)
    Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Box.BorderSizePixel = 0
    Box.Active = true
    Box.Draggable = true

    local UICorner = Instance.new("UICorner", Box)
    UICorner.CornerRadius = UDim.new(0, 8)

    local function miniBtn(text, y)
        local btn = Instance.new("TextButton", Box)
        btn.Size = UDim2.new(0, 180, 0, 40)
        btn.Position = UDim2.new(0, 10, 0, y)
        btn.Text = text
        btn.Font = Enum.Font.SourceSansBold
        btn.TextSize = 16
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        local corner = Instance.new("UICorner", btn)
        corner.CornerRadius = UDim.new(0, 6)
        return btn
    end

    local StartTP = miniBtn("🟢 Start TP", 10)
    local StopTP = miniBtn("🔴 Stop TP", 60)

    local teleporting = false

    local function getCFrames(text)
        local list = {}
        for x, y, z in text:gmatch("CFrame%.new%((%-?[%d%.]+), (%-?[%d%.]+), (%-?[%d%.]+)%)") do
            table.insert(list, CFrame.new(tonumber(x), tonumber(y), tonumber(z)))
        end
        return list
    end

    StartTP.MouseButton1Click:Connect(function()
        if not systemLogging then
            TPGui:Destroy()
            return
        end
        
        if teleporting then return end
        local cframes = getCFrames(OutputBox.Text)
        if #cframes == 0 then return end
        teleporting = true
        task.spawn(function()
            for _, cf in ipairs(cframes) do
                if not teleporting then break end
                HRP.CFrame = cf
                task.wait(0.2)
            end
            teleporting = false
        end)
    end)

    StopTP.MouseButton1Click:Connect(function()
        teleporting = false
    end)
end)

-- GUI code generation with system validation
CopyGuiCodeBtn.MouseButton1Click:Connect(function()
    if not CoreServices or not systemPositions or not MainPlayer then
        ScreenGui:Destroy()
        return
    end
    
    local positionsText = OutputBox.Text
    
    if positionsText == "" or positionsText == nil then
        warn("No positions recorded! Please record some positions first.")
        return
    end
    
    local tpCode = string.format([[
-- TP GUI Only Script (Generated with recorded positions)
local Player = game.Players.LocalPlayer
local HRP = Player.Character:WaitForChild("HumanoidRootPart")

-- Recorded positions data
local recordedPositions = [[%s]]

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TPControlGui"

local box = Instance.new("Frame", gui)
box.Size = UDim2.new(0, 200, 0, 110)
box.Position = UDim2.new(0.75, 0, 0.5, 0)
box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
box.Active = true
box.Draggable = true

local function btn(text, y)
	local b = Instance.new("TextButton", box)
	b.Size = UDim2.new(0, 180, 0, 40)
	b.Position = UDim2.new(0, 10, 0, y)
	b.Text = text
	b.Font = Enum.Font.SourceSansBold
	b.TextSize = 16
	b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	b.TextColor3 = Color3.fromRGB(255, 255, 255)
	return b
end

local start = btn("🟢 Start TP", 10)
local stop = btn("🔴 Stop TP", 60)

local teleporting = false

start.MouseButton1Click:Connect(function()
	if teleporting then return end
	local cframes = {}
	for x, y, z in recordedPositions:gmatch("CFrame%.new%((%-?[%d%.]+), (%-?[%d%.]+), (%-?[%d%.]+)%)") do
		table.insert(cframes, CFrame.new(tonumber(x), tonumber(y), tonumber(z)))
	end
	if #cframes == 0 then return end
	teleporting = true
	task.spawn(function()
		for _, cf in ipairs(cframes) do
			if not teleporting then break end
			HRP.CFrame = cf
			task.wait(0.2)
		end
		teleporting = false
	end)
end)

stop.MouseButton1Click:Connect(function()
	teleporting = false
end)
]], positionsText)

    if setclipboard then
        setclipboard(tpCode)
        print("TP GUI code copied to clipboard with " .. #string.split(positionsText, "\n") .. " positions!")
    else
        warn("Clipboard not supported.")
    end
end)
