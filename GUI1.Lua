local function CreateUIElement(class, props)
	local inst = Instance.new(class)
	for prop, val in pairs(props) do
		inst[prop] = val
	end
	return inst
end

local ScreenGui = CreateUIElement("ScreenGui", {
	Name = "MarkleHub",
	Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"),
	ResetOnSpawn = false
})

local MainFrame = CreateUIElement("Frame", {
	Name = "MainFrame",
	Parent = ScreenGui,
	BackgroundColor3 = Color3.fromRGB(30, 30, 35),
	Size = UDim2.fromOffset(450, 300),
	Position = UDim2.new(0.5, -225, 0.5, -150),
	Active = true,
	Draggable = true
})

local Shadow = CreateUIElement("ImageLabel", {
	Name = "Shadow",
	Parent = MainFrame,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0.5, 0, 0.5, 0),
	Size = UDim2.new(1, 60, 1, 60),
	BackgroundTransparency = 1,
	Image = "rbxassetid://1316045217",
	ImageTransparency = 0.5,
	ZIndex = -1
})

CreateUIElement("UICorner", {
	CornerRadius = UDim.new(0, 12),
	Parent = MainFrame
})

local Title = CreateUIElement("TextLabel", {
	Name = "Title",
	Parent = MainFrame,
	BackgroundColor3 = Color3.fromRGB(30, 30, 35),
	BackgroundTransparency = 1,
	Size = UDim2.new(1, -40, 0, 50),
	Position = UDim2.new(0, 10, 0, 0),
	Font = Enum.Font.GothamBold,
	Text = "Hub",
	TextColor3 = Color3.fromRGB(200, 200, 255),
	TextScaled = true,
	TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left
})

local CloseButton = CreateUIElement("TextButton", {
	Name = "CloseButton",
	Parent = MainFrame,
	BackgroundColor3 = Color3.fromRGB(255, 0, 0),
	Position = UDim2.new(1, -40, 0, 10),
	Size = UDim2.new(0, 30, 0, 30),
	Font = Enum.Font.GothamBold,
	Text = "X",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextScaled = true,
	TextWrapped = true
})

CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

CloseButton.MouseEnter:Connect(function()
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
end)
CloseButton.MouseLeave:Connect(function()
	CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end)

local ScrollingFrame = CreateUIElement("ScrollingFrame", {
	Name = "ScrollingFrame",
	Parent = MainFrame,
	BackgroundColor3 = Color3.fromRGB(25, 25, 25),
	BackgroundTransparency = 1,
	Size = UDim2.new(1, 0, 1, -50),
	Position = UDim2.new(0, 0, 0, 50),
	CanvasSize = UDim2.new(0, 0, 0, 0),
	ScrollBarThickness = 6
})

local UIGridLayout = CreateUIElement("UIGridLayout", {
	Parent = ScrollingFrame,
	SortOrder = Enum.SortOrder.LayoutOrder,
	CellSize = UDim2.new(0, 100, 0, 100),
	CellPadding = UDim2.new(0, 10, 0, 10)
})

-- زر تصغير / إظهار الواجهة
local MiniButton = CreateUIElement("TextButton", {
	Name = "MiniButton",
	Parent = ScreenGui,
	BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	Size = UDim2.new(0, 30, 0, 30),
	Position = UDim2.new(0, 10, 0.5, -15),
	Font = Enum.Font.GothamBold,
	Text = "≡",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextScaled = true,
	TextWrapped = true,
	Draggable = true
})

CreateUIElement("UICorner", {
	CornerRadius = UDim.new(0, 6),
	Parent = MiniButton
})

MiniButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

local function AddTitle(text)
	Title.Text = text
end

local function AddButton(text, callback, color)
	local Button = CreateUIElement("TextButton", {
		Parent = ScrollingFrame,
		BackgroundColor3 = color or Color3.fromRGB(35, 35, 35),
		Size = UDim2.new(0, 100, 0, 100),
		Font = Enum.Font.Gotham,
		Text = text,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextScaled = true,
		TextWrapped = true
	})
	Button.MouseButton1Click:Connect(callback)
	task.delay(0.05, function()
		local totalHeight = UIGridLayout.AbsoluteContentSize.Y + 10
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
	end)
end

return {
	AddTitle = AddTitle,
	AddButton = AddButton
}
