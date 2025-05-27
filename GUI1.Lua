local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIGridLayout = Instance.new("UIGridLayout")
local CloseButton = Instance.new("TextButton")
local MiniButton = Instance.new("TextButton")

local purpleColors = {
    main = Color3.fromRGB(102, 51, 153),
    light = Color3.fromRGB(147, 112, 219),
    accent = Color3.fromRGB(186, 85, 211),
    text = Color3.fromRGB(255, 255, 255)
}

ScreenGui.Name = "MarkleHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = purpleColors.main
MainFrame.Size = UDim2.fromOffset(500, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Color = purpleColors.light
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = purpleColors.main
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, -100, 0, 60)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "Markle Hub"
Title.TextColor3 = purpleColors.text
Title.TextScaled = true
Title.TextWrapped = true
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.TextSize = 24

CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
CloseButton.Position = UDim2.new(1, -45, 0, 15)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextScaled = true
CloseButton.TextWrapped = true

local CloseButtonCorner = Instance.new("UICorner")
CloseButtonCorner.CornerRadius = UDim.new(0, 8)
CloseButtonCorner.Parent = CloseButton

MiniButton.Name = "MiniButton"
MiniButton.Parent = ScreenGui
MiniButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MiniButton.Size = UDim2.new(0, 30, 0, 30)
MiniButton.Position = UDim2.new(0, 10, 0.5, -15)
MiniButton.Font = Enum.Font.GothamBold
MiniButton.Text = "≡"
MiniButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MiniButton.TextScaled = true
MiniButton.TextWrapped = true
MiniButton.Visible = false
MiniButton.Active = true
MiniButton.Draggable = true

local MiniButtonCorner = Instance.new("UICorner")
MiniButtonCorner.CornerRadius = UDim.new(0, 6)
MiniButtonCorner.Parent = MiniButton

ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundColor3 = purpleColors.main
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Size = UDim2.new(1, -20, 1, -70)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 60)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.ScrollBarImageColor3 = purpleColors.light

UIGridLayout.Parent = ScrollingFrame
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.CellSize = UDim2.new(0, 110, 0, 110)
UIGridLayout.CellPadding = UDim2.new(0, 15, 0, 15)

local function AddTitle(text)
    Title.Text = text
end

local function AddButton(text, callback)
    local Button = Instance.new("TextButton")
    Button.Parent = ScrollingFrame
    Button.BackgroundColor3 = purpleColors.light
    Button.Size = UDim2.new(0, 110, 0, 110)
    Button.Font = Enum.Font.GothamSemibold
    Button.Text = text
    Button.TextColor3 = purpleColors.text
    Button.TextScaled = true
    Button.TextWrapped = true
    
    Button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = purpleColors.accent}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = purpleColors.light}):Play()
    end)
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 12)
    ButtonCorner.Parent = Button
    
    local ButtonShadow = Instance.new("UIStroke")
    ButtonShadow.Parent = Button
    ButtonShadow.Color = purpleColors.main
    ButtonShadow.Thickness = 2
    
    Button.MouseButton1Click:Connect(callback)
    
    local totalHeight = UIGridLayout.AbsoluteContentSize.Y + 20
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
end

local isMinimized = false

CloseButton.MouseButton1Click:Connect(function()
    if isMinimized then
        MiniButton.Visible = false
        ScreenGui:Destroy()
    else
        MainFrame.Visible = false
        MiniButton.Visible = true
        isMinimized = true
    end
end)

MiniButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MiniButton.Visible = false
    isMinimized = false
end)

local draggingMiniButton = false
local offsetMiniButton = Vector2.new(0, 0)

MiniButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingMiniButton = true
        offsetMiniButton = Vector2.new(input.Position.X - MiniButton.AbsolutePosition.X, input.Position.Y - MiniButton.AbsolutePosition.Y)
    end
end)

MiniButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingMiniButton = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if draggingMiniButton and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        MiniButton.Position = UDim2.new(0, mousePos.X - offsetMiniButton.X, 0, mousePos.Y - offsetMiniButton.Y)
    end
end)

return {
    AddTitle = AddTitle,
    AddButton = AddButton
}
