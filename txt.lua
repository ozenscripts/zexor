--[[
    ZEXRO HUB V7 | BLACK / WHITE / RED
    Roblox Studio LocalScript
    Place in: StarterPlayer > StarterPlayerScripts

    This is a client-side GUI for a game you control.
    Movement options are local prototypes; implement and validate gameplay
    permissions on the server before using them in a published game.
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local COLORS = {
    Black = Color3.fromRGB(9, 9, 11),
    Panel = Color3.fromRGB(17, 17, 20),
    Panel2 = Color3.fromRGB(25, 25, 29),
    White = Color3.fromRGB(245, 245, 247),
    Muted = Color3.fromRGB(160, 160, 166),
    Red = Color3.fromRGB(235, 35, 48),
    DarkRed = Color3.fromRGB(120, 16, 25),
    Stroke = Color3.fromRGB(65, 30, 34),
}

local old = playerGui:FindFirstChild("ZEXRO_HUB_V7")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "ZEXRO_HUB_V7"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local function make(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local main = make("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(540, 370),
    Position = UDim2.new(0.5, -270, 0.5, -185),
    BackgroundColor3 = COLORS.Black,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, gui)
make("UICorner", {CornerRadius = UDim.new(0, 10)}, main)
make("UIStroke", {Color = COLORS.Red, Thickness = 1.4, Transparency = 0.12}, main)

local background = make("Frame", {
    Name = "AnimatedBackground",
    Size = UDim2.new(1, 0, 0, 3),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = COLORS.Red,
    BorderSizePixel = 0,
}, main)

local header = make("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
}, main)

local version = make("TextLabel", {
    Size = UDim2.fromOffset(38, 20),
    Position = UDim2.fromOffset(12, 8),
    BackgroundColor3 = COLORS.Red,
    BorderSizePixel = 0,
    Text = "V7",
    TextColor3 = COLORS.White,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
}, header)
make("UICorner", {CornerRadius = UDim.new(0, 4)}, version)

make("TextLabel", {
    Size = UDim2.fromOffset(250, 25),
    Position = UDim2.fromOffset(12, 27),
    BackgroundTransparency = 1,
    Text = "ZEXRO HUB",
    TextColor3 = COLORS.White,
    TextSize = 19,
    TextXAlignment = Enum.TextXAlignment.Left,
    Font = Enum.Font.GothamBlack,
}, header)

make("TextLabel", {
    Size = UDim2.fromOffset(180, 18),
    Position = UDim2.new(1, -222, 0, 28),
    BackgroundTransparency = 1,
    Text = "BLACK / WHITE / RED",
    TextColor3 = COLORS.Muted,
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Right,
    Font = Enum.Font.GothamMedium,
}, header)

local minimize = make("TextButton", {
    Size = UDim2.fromOffset(28, 27),
    Position = UDim2.new(1, -66, 0, 15),
    BackgroundColor3 = COLORS.Panel2,
    Text = "—",
    TextColor3 = COLORS.White,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = true,
}, header)
make("UICorner", {CornerRadius = UDim.new(0, 5)}, minimize)

local close = make("TextButton", {
    Size = UDim2.fromOffset(28, 27),
    Position = UDim2.new(1, -34, 0, 15),
    BackgroundColor3 = COLORS.Red,
    Text = "×",
    TextColor3 = COLORS.White,
    TextSize = 19,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = true,
}, header)
make("UICorner", {CornerRadius = UDim.new(0, 5)}, close)

local sidebar = make("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(0, 145, 1, -61),
    Position = UDim2.fromOffset(0, 61),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
}, main)
make("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, sidebar)
make("UIPadding", {
    PaddingTop = UDim.new(0, 10),
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8),
}, sidebar)

local content = make("ScrollingFrame", {
    Name = "Content",
    Size = UDim2.new(1, -157, 1, -77),
    Position = UDim2.fromOffset(151, 69),
    BackgroundColor3 = COLORS.Black,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = COLORS.Red,
    CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, main)
make("UIPadding", {
    PaddingTop = UDim.new(0, 3),
    PaddingBottom = UDim.new(0, 10),
    PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 8),
}, content)
local contentLayout = make("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, content)

local toast = make("TextLabel", {
    Size = UDim2.fromOffset(280, 34),
    Position = UDim2.new(0.5, -140, 1, -48),
    BackgroundColor3 = COLORS.Panel2,
    Text = "",
    TextColor3 = COLORS.White,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    Visible = false,
    ZIndex = 10,
}, gui)
make("UICorner", {CornerRadius = UDim.new(0, 7)}, toast)
make("UIStroke", {Color = COLORS.Red, Thickness = 1}, toast)

local function notify(message)
    toast.Text = "  " .. tostring(message)
    toast.Visible = true
    toast.TextTransparency = 0
    task.delay(2.2, function()
        if toast and toast.Parent then
            local tween = TweenService:Create(toast, TweenInfo.new(0.25), {TextTransparency = 1})
            tween:Play()
            tween.Completed:Wait()
            if toast and toast.Parent then toast.Visible = false end
        end
    end)
end

-- Dragging
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local minimized = false
local oldSize = main.Size
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    sidebar.Visible = not minimized
    main.Size = minimized and UDim2.fromOffset(540, 58) or oldSize
    minimize.Text = minimized and "+" or "—"
end)
close.MouseButton1Click:Connect(function() gui.Enabled = false end)

-- Animated red highlight bar.
task.spawn(function()
    while gui.Parent do
        TweenService:Create(background, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundColor3 = COLORS.White
        }):Play()
        task.wait(1.2)
        TweenService:Create(background, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundColor3 = COLORS.Red
        }):Play()
        task.wait(1.2)
    end
end)

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child ~= contentLayout and child:IsA("GuiObject") then child:Destroy() end
    end
end

local function section(title)
    return make("TextLabel", {
        Size = UDim2.new(1, -3, 0, 26),
        BackgroundColor3 = COLORS.Panel,
        BorderSizePixel = 0,
        Text = "  " .. string.upper(title),
        TextColor3 = COLORS.Red,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamBold,
    }, content)
end

local function rowLabel(text)
    return make("TextLabel", {
        Size = UDim2.new(1, -3, 0, 24),
        BackgroundTransparency = 1,
        Text = "  " .. text,
        TextColor3 = COLORS.White,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamMedium,
    }, content)
end

local function addButton(text, callback)
    local b = make("TextButton", {
        Size = UDim2.new(1, -3, 0, 31),
        BackgroundColor3 = COLORS.Panel2,
        BorderSizePixel = 0,
        Text = "  " .. text,
        TextColor3 = COLORS.White,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamMedium,
        AutoButtonColor = true,
    }, content)
    make("UICorner", {CornerRadius = UDim.new(0, 5)}, b)
    make("UIStroke", {Color = COLORS.Stroke, Thickness = 1}, b)
    b.MouseButton1Click:Connect(callback or function() notify(text .. " selected") end)
    return b
end

local function addToggle(text, defaultValue, callback)
    local state = defaultValue or false
    local b = make("TextButton", {
        Size = UDim2.new(1, -3, 0, 31),
        BackgroundColor3 = COLORS.Panel2,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
    }, content)
    make("UICorner", {CornerRadius = UDim.new(0, 5)}, b)
    make("TextLabel", {
        Size = UDim2.new(1, -65, 1, 0),
        Position = UDim2.fromOffset(9, 0),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = COLORS.White,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        Font = Enum.Font.GothamMedium,
    }, b)
    local switch = make("Frame", {
        Size = UDim2.fromOffset(34, 18),
        Position = UDim2.new(1, -43, 0.5, -9),
        BackgroundColor3 = state and COLORS.Red or Color3.fromRGB(70, 70, 75),
        BorderSizePixel = 0,
    }, b)
    make("UICorner", {CornerRadius = UDim.new(1, 0)}, switch)
    local knob = make("Frame", {
        Size = UDim2.fromOffset(14, 14),
        Position = state and UDim2.new(1, -16, 0, 2) or UDim2.fromOffset(2, 2),
        BackgroundColor3 = COLORS.White,
        BorderSizePixel = 0,
    }, switch)
    make("UICorner", {CornerRadius = UDim.new(1, 0)}, knob)
    b.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(switch, TweenInfo.new(0.15), {
            BackgroundColor3 = state and COLORS.Red or Color3.fromRGB(70, 70, 75)
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = state and UDim2.new(1, -16, 0, 2) or UDim2.fromOffset(2, 2)
        }):Play()
        if callback then callback(state) end
        notify(text .. (state and " enabled" or " disabled"))
    end)
    return function() return state end
end

local function addSlider(title, minValue, maxValue, defaultValue, callback)
    rowLabel(title .. ": " .. tostring(defaultValue))
    local holder = make("Frame", {
        Size = UDim2.new(1, -3, 0, 22),
        BackgroundColor3 = COLORS.Panel2,
        BorderSizePixel = 0,
    }, content)
    make("UICorner", {CornerRadius = UDim.new(0, 5)}, holder)
    local fill = make("Frame", {
        Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0),
        BackgroundColor3 = COLORS.Red,
        BorderSizePixel = 0,
    }, holder)
    make("UICorner", {CornerRadius = UDim.new(0, 5)}, fill)
    local valueText = make("TextLabel", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = tostring(defaultValue),
        TextColor3 = COLORS.White,
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        ZIndex = 2,
    }, holder)
    local function setFromX(x)
        local ratio = math.clamp((x - holder.AbsolutePosition.X) / holder.AbsoluteSize.X, 0, 1)
        local value = math.floor(minValue + ratio * (maxValue - minValue))
        fill.Size = UDim2.new(ratio, 0, 1, 0)
        valueText.Text = tostring(value)
        callback(value)
    end
    local sliding = false
    holder.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            setFromX(input.Position.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            setFromX(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliding = false end
    end)
end

local function getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

local function getHumanoid()
    return getCharacter():FindFirstChildOfClass("Humanoid")
end

local movement = {infiniteJump = false, sprint = false, jumpConnection = nil}
local function setWalkSpeed(value)
    local hum = getHumanoid()
    if hum then hum.WalkSpeed = value end
end
local function setJumpPower(value)
    local hum = getHumanoid()
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = value
    end
end

local tabNames = {"Movement", "Animations", "Tools", "Appearance", "Visuals", "Settings", "Owner"}
local tabButtons = {}

local function buildTab(name)
    clearContent()
    if name == "Movement" then
        section("Movement controls")
        addSlider("Walk speed", 8, 40, 16, setWalkSpeed)
        addSlider("Jump power", 25, 100, 50, setJumpPower)
        addToggle("Sprint mode", false, function(on) movement.sprint = on; setWalkSpeed(on and 26 or 16) end)
        addToggle("Infinite jump (your game)", false, function(on)
            movement.infiniteJump = on
            if on then
                if movement.jumpConnection then movement.jumpConnection:Disconnect() end
                movement.jumpConnection = UserInputService.JumpRequest:Connect(function()
                    local hum = getHumanoid()
                    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                end)
            elseif movement.jumpConnection then
                movement.jumpConnection:Disconnect()
                movement.jumpConnection = nil
            end
        end)
        addButton("Reset movement", function()
            movement.sprint = false
            setWalkSpeed(16)
            setJumpPower(50)
            notify("Movement reset")
        end)
        addButton("Return to spawn (if SpawnLocation exists)", function()
            local char = getCharacter()
            local root = char:FindFirstChild("HumanoidRootPart")
            local spawn = workspace:FindFirstChildWhichIsA("SpawnLocation", true)
            if root and spawn then root.CFrame = spawn.CFrame + Vector3.new(0, 4, 0)
            else notify("Add a SpawnLocation to your game first") end
        end)
        section("Test-game features")
        addButton("Noclip prototype note", function()
            notify("Implement noclip with server-side game permissions")
        end)
        addButton("Double-jump info", function() notify("Use Infinite jump toggle for this test character") end)
        addButton("Movement presets", function() notify("Choose speed and jump with the sliders above") end)
    elseif name == "Animations" then
        section("Character animations")
        addButton("Dance / emote browser", function()
            local hum = getHumanoid()
            if hum then
                local ok = pcall(function()
                    local animator = hum:FindFirstChildOfClass("Animator")
                    if not animator then animator = Instance.new("Animator", hum) end
                    -- Opens Roblox's built-in emote menu where supported.
                    game:GetService("GuiService"):SetEmotesMenuOpen(true)
                end)
                if not ok then notify("Use your game's supported emote system") end
            end
        end)
        addToggle("Loop animation preview", false, function(on) notify(on and "Loop preview enabled" or "Loop preview disabled") end)
        addSlider("Animation speed preview", 1, 3, 1, function(value)
            local hum = getHumanoid()
            if hum then
                local animator = hum:FindFirstChildOfClass("Animator")
                if animator then
                    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                        track:AdjustSpeed(value)
                    end
                end
            end
        end)
        addButton("Stop current animations", function()
            local hum = getHumanoid()
            local animator = hum and hum:FindFirstChildOfClass("Animator")
            if animator then
                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do track:Stop(0.2) end
            end
            notify("Stopped playing animation tracks")
        end)
        section("Animation categories")
        for _, item in ipairs({"Idle animation slot", "Walk animation slot", "Run animation slot", "Jump animation slot", "Wave emote", "Cheer emote", "Laugh emote", "Point emote", "Dance 1", "Dance 2", "Dance 3", "Custom animation ID"}) do
            addButton(item, function() notify("Add an approved animation ID in your game to use " .. item) end)
        end
    elseif name == "Tools" then
        section("Game tools")
        for _, item in ipairs({"Tool inventory overview", "Equip selected tool", "Unequip tools", "Training timer", "Checkpoint info", "Practice dummy info", "Reset character", "Copy position display", "Tool cooldown display", "Training props info"}) do
            addButton(item, function()
                if item == "Unequip tools" then
                    local hum = getHumanoid()
                    if hum then hum:UnequipTools() end
                    notify("Tools unequipped")
                elseif item == "Reset character" then
                    local hum = getHumanoid()
                    if hum then hum.Health = 0 end
                else notify(item .. " selected") end
            end)
        end
    elseif name == "Appearance" then
        section("Interface customization")
        addToggle("Animated red accent", true, function(on) background.Visible = on end)
        addToggle("High contrast", true, function(on)
            main.BackgroundColor3 = on and COLORS.Black or Color3.fromRGB(25, 25, 25)
        end)
        addToggle("Glow border", true, function(on)
            local stroke = main:FindFirstChildOfClass("UIStroke")
            if stroke then stroke.Transparency = on and 0.12 or 1 end
        end)
        addButton("Black / white / red theme", function() notify("Current theme: black, white and red") end)
        addButton("Compact window", function()
            main.Size = UDim2.fromOffset(500, 340)
            oldSize = main.Size
            notify("Compact size applied")
        end)
        addButton("Restore window size", function()
            main.Size = UDim2.fromOffset(540, 370)
            oldSize = main.Size
        end)
    elseif name == "Visuals" then
        section("Visual options for your own game")
        addSlider("Camera field of view", 50, 100, 70, function(value)
            local camera = workspace.CurrentCamera
            if camera then camera.FieldOfView = value end
        end)
        addToggle("Night preview", false, function(on)
            local Lighting = game:GetService("Lighting")
            Lighting.ClockTime = on and 0 or 14
        end)
        addToggle("Soft camera shake", false, function(on) notify(on and "Camera shake preview enabled" or "Camera shake disabled
