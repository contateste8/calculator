-- Made by Conta Teste (Open Source)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "CalculadoraGui"
screenGui.ResetOnSpawn = false

local normalSize = UDim2.new(0, 270, 0, 310)
local minimizedSize = UDim2.new(0, 270, 0, 40)

local mainFrame = Instance.new("Frame")
mainFrame.Size = normalSize
mainFrame.Position = UDim2.new(0.5, -135, 0.5, -155)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

local shadow = Instance.new("ImageLabel", mainFrame)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.ZIndex = 0

local topBar = Instance.new("Frame", mainFrame)
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundTransparency = 1
topBar.BorderSizePixel = 0

local title = Instance.new("TextLabel", topBar)
title.Text = "Calculadora"
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20

local minimize = Instance.new("TextButton", topBar)
minimize.Text = "—"
minimize.Size = UDim2.new(0, 35, 1, 0)
minimize.Position = UDim2.new(1, -75, 0, 0)
minimize.BackgroundColor3 = Color3.fromRGB(49, 91, 255)
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.Font = Enum.Font.SourceSansBold
minimize.TextSize = 20
Instance.new("UICorner", minimize).CornerRadius = UDim.new(0, 6)

local close = Instance.new("TextButton", topBar)
close.Text = "X"
close.Size = UDim2.new(0, 35, 1, 0)
close.Position = UDim2.new(1, -35, 0, 0)
close.BackgroundColor3 = Color3.fromRGB(49, 91, 255)
close.TextColor3 = Color3.new(1, 1, 1)
close.Font = Enum.Font.SourceSansBold
close.TextSize = 20
Instance.new("UICorner", close).CornerRadius = UDim.new(0, 6)

local input = Instance.new("TextBox", mainFrame)
input.Size = UDim2.new(1, -20, 0, 40)
input.Position = UDim2.new(0, 10, 0, 40)
input.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
input.TextColor3 = Color3.new(1, 1, 1)
input.Text = ""
input.TextScaled = true
input.ClearTextOnFocus = false
input.Font = Enum.Font.SourceSans
input.TextXAlignment = Enum.TextXAlignment.Right
input.BorderSizePixel = 0
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

local buttonContainer = Instance.new("Frame", mainFrame)
buttonContainer.Position = UDim2.new(0, 10, 0, 90)
buttonContainer.Size = UDim2.new(1, -20, 1, -100)
buttonContainer.BackgroundTransparency = 1

local buttons = {
    {"C", "", "(", ")"},
    {"7", "8", "9", "/"},
    {"4", "5", "6", "-"},
    {"1", "2", "3", "+"},
    {"0", "×", "%", "="},
}

local function createButton(text, x, y)
    if text == "" then return end
    local btn = Instance.new("TextButton", buttonContainer)
    btn.Text = text
    btn.Size = UDim2.new(0.25, -4, 0.19, -4)
    btn.Position = UDim2.new(0.25 * x, 4 * x, 0.19 * y, 4 * y)
    btn.BackgroundColor3 = Color3.fromRGB(49, 91, 255)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        if text == "=" then
            local code = input.Text:gsub("×", "*")
            local success, result = pcall(function()
                return loadstring("return " .. code)()
            end)
            input.Text = success and tostring(result) or "?"
        elseif text == "C" then
            input.Text = ""
        else
            input.Text = input.Text .. text
        end
    end)
end

local function createDelButton(x, y)
    local btn = Instance.new("ImageButton", buttonContainer)
    btn.Image = "rbxassetid://123491330315523"
    btn.Size = UDim2.new(0.25, -4, 0.19, -4)
    btn.Position = UDim2.new(0.25 * x, 4 * x, 0.19 * y, 4 * y)
    btn.BackgroundColor3 = Color3.fromRGB(49, 91, 255)
    btn.ImageColor3 = Color3.new(1, 1, 1)
    btn.ScaleType = Enum.ScaleType.Fit
    btn.BackgroundTransparency = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local padding = Instance.new("UIPadding", btn)
    padding.PaddingTop = UDim.new(0.15, 0)
    padding.PaddingBottom = UDim.new(0.15, 0)
    padding.PaddingLeft = UDim.new(0.15, 0)
    padding.PaddingRight = UDim.new(0.15, 0)

    btn.MouseButton1Click:Connect(function()
        input.Text = input.Text:sub(1, -2)
    end)
end

for y, row in ipairs(buttons) do
    for x, char in ipairs(row) do
        createButton(char, x - 1, y - 1)
    end
end

createDelButton(1, 0)

local minimized = false
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
        Size = minimized and minimizedSize or normalSize
    })
    tween:Play()
    input.Visible = not minimized
    buttonContainer.Visible = not minimized
end)

close.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
