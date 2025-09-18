local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local hrp = player.Character and player.Character:WaitForChild("HumanoidRootPart")

local lokasi = {}
for i = 1, 20 do
    lokasi["Lokasi "..i] = nil
end

local autoTeleport = false
local delayAntarSlot = 3
local checkboxes = {}

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "MiniTeleportGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 300)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Position = UDim2.fromScale(0.5,0.5)
frame.BackgroundColor3 = Color3.fromRGB(30,30,35)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true

local gradient = Instance.new("UIGradient", frame)
gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(40,40,45)), ColorSequenceKeypoint.new(1, Color3.fromRGB(60,60,70))})
gradient.Rotation = 45

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,28)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Teleport 🤑"
title.TextColor3 = Color3.fromRGB(245,230,180)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Center

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0,22,0,22)
closeBtn.Position = UDim2.new(1,-26,0,3)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(245,230,180)
closeBtn.BackgroundTransparency = 1
closeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.3), {Size=UDim2.new(0,0,0,0), Position=UDim2.fromScale(0.5,0.5)}):Play()
    task.wait(0.3)
    gui:Destroy()
end)

local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0,25,0,25)
openBtn.AnchorPoint = Vector2.new(0.5,0.5)
openBtn.Text = ">"
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 16
openBtn.TextColor3 = Color3.fromRGB(245,230,180)
openBtn.BackgroundColor3 = Color3.fromRGB(40,40,50)
openBtn.BorderSizePixel = 0
openBtn.Visible = false

local minBtn = Instance.new("TextButton", frame)
minBtn.Size = UDim2.new(0,22,0,22)
minBtn.Position = UDim2.new(1,-52,0,3)
minBtn.Text = ">"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 14
minBtn.TextColor3 = Color3.fromRGB(245,230,180)
minBtn.BackgroundTransparency = 1

minBtn.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.3), {Size=UDim2.new(0,40,0,28)}):Play()
    task.wait(0.3)
    frame.Visible = false
    openBtn.Position = frame.Position
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    openBtn.Visible = false
    frame.Visible = true
    TweenService:Create(frame, TweenInfo.new(0.3), {Size=UDim2.new(0,180,0,300)}):Play()
end)

local scrollFrame = Instance.new("ScrollingFrame", frame)
scrollFrame.Size = UDim2.new(1,-10,1,-90)
scrollFrame.Position = UDim2.new(0,5,0,30)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.CanvasSize = UDim2.new(0,0,0,20*28)
scrollFrame.ScrollBarThickness = 5
scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar

local layout = Instance.new("UIListLayout", scrollFrame)
layout.Padding = UDim.new(0,3)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local saveBtn = Instance.new("TextButton", frame)
saveBtn.Size = UDim2.new(1,-10,0,22)
saveBtn.Position = UDim2.new(0,5,1,-48)
saveBtn.Text = "Save Current Location"
saveBtn.BackgroundColor3 = Color3.fromRGB(60,60,70)
saveBtn.TextColor3 = Color3.fromRGB(245,230,180)
saveBtn.BorderSizePixel = 0

local slotBox = Instance.new("TextBox", frame)
slotBox.Size = UDim2.new(1,-10,0,18)
slotBox.Position = UDim2.new(0,5,1,-70)
slotBox.PlaceholderText = "Slot 1-20"
slotBox.BackgroundColor3 = Color3.fromRGB(50,50,60)
slotBox.TextColor3 = Color3.fromRGB(245,230,180)
slotBox.BorderSizePixel = 0

saveBtn.MouseButton1Click:Connect(function()
    local slot = tonumber(slotBox.Text)
    if slot and slot>=1 and slot<=20 then
        lokasi["Lokasi "..slot] = hrp.Position
        saveBtn.Text = "Slot "..slot.." Saved!"
        task.wait(1.5)
        saveBtn.Text = "Save Current Location"
    else
        saveBtn.Text = "Invalid Slot!"
        task.wait(1.5)
        saveBtn.Text = "Save Current Location"
    end
end)

for i=1,20 do
    local container = Instance.new("Frame", scrollFrame)
    container.Size = UDim2.new(1,0,0,25)
    container.BackgroundTransparency = 1

    local box = Instance.new("TextButton", container)
    box.Size = UDim2.new(0,18,1,0)
    box.Position = UDim2.new(0,0,0,0)
    box.BackgroundColor3 = Color3.fromRGB(70,70,80)
    box.Text = ""
    box.BorderSizePixel = 0

    local label = Instance.new("TextLabel", container)
    label.Size = UDim2.new(0,100,1,0)
    label.Position = UDim2.new(0,22,0,0)
    label.Text = "Slot "..i
    label.TextColor3 = Color3.fromRGB(245,230,180)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham

    checkboxes[i] = false
    box.MouseButton1Click:Connect(function()
        checkboxes[i] = not checkboxes[i]
        box.BackgroundColor3 = checkboxes[i] and Color3.fromRGB(80,80,90) or Color3.fromRGB(70,70,80)
    end)

    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(0.35,0,1,0)
    btn.Position = UDim2.new(0.65,0,0,0)
    btn.Text = "Teleport"
    btn.BackgroundColor3 = Color3.fromRGB(80,80,90)
    btn.TextColor3 = Color3.fromRGB(245,230,180)
    btn.BorderSizePixel = 0

    btn.MouseButton1Click:Connect(function()
        if lokasi["Lokasi "..i] then hrp.CFrame = CFrame.new(lokasi["Lokasi "..i]) else btn.Text = "Empty!" task.wait(1.5) btn.Text="Teleport" end
    end)
end

local autoBtn = Instance.new("TextButton", frame)
autoBtn.Size = UDim2.new(1,-10,0,22)
autoBtn.Position = UDim2.new(0,5,1,-24)
autoBtn.Text = "Auto Teleport: OFF"
autoBtn.BackgroundColor3 = Color3.fromRGB(50,50,70)
autoBtn.TextColor3 = Color3.fromRGB(245,230,180)
autoBtn.BorderSizePixel = 0

autoBtn.MouseButton1Click:Connect(function()
    autoTeleport = not autoTeleport
    autoBtn.Text = autoTeleport and "Auto Teleport: ON" or "Auto Teleport: OFF"
    autoBtn.BackgroundColor3 = autoTeleport and Color3.fromRGB(60,60,80) or Color3.fromRGB(50,50,70)
    if autoTeleport then
        task.spawn(function()
            local index = 1
            while autoTeleport do
                local selected = {}
                for i,v in pairs(checkboxes) do if v then table.insert(selected,i) end end
                if #selected>0 then
                    local slotNum = selected[index]
                    local slot = "Lokasi "..slotNum
                    if lokasi[slot] then hrp.CFrame = CFrame.new(lokasi[slot]) end
                    index=index+1
                    if index>#selected then index=1 end
                    task.wait(delayAntarSlot)
                else
                    task.wait(1)
                end
            end
        end)
    end
end)