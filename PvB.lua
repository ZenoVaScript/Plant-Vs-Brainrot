-- Load Zeno UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZenoVaScript/Zeno-Ui/main/ZenoUI.lua"))()

-- Create Main Window
local Window = Library:Window({
    Title = "Zeno Hub [ Plant Vs Brainrot ] v1",
    Desc = "by ZenoID",
    Icon = 105059922903197,
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 500, 0, 400)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "Zenoo"
    }
})

-- Sidebar Vertical Separator
local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(0, 140, 0, 0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 5
SidebarLine.Name = "SidebarLine"
SidebarLine.Parent = game:GetService("CoreGui")

-- 🌱 SEED SHOP TAB
local SeedShop = Window:Tab({Title = "Seed Shop", Icon = "leaf"}) do
    SeedShop:Section({Title = "Auto Buy Plant"})

    local PlantOptions = {  
        "Cactus Seed",  
        "Strawberry Seed",  
        "Pumpkin Seed",  
        "Sunflower Seed",  
        "Dragon Fruit Seed",  
        "Eggplant Seed",  
        "Watermelon Seed",  
        "Cocotank Seed",  
        "Carnivorous Plant Seed",  
        "Mr Carrot Seed"  
    }  

    local SelectedPlants = {}  
    local AutoBuyPlants = false -- FLAG kontrol  

    SeedShop:Dropdown({  
        Title = "Select Plants",  
        List = PlantOptions,  
        Multi = true,  
        Value = {},  
        Callback = function(options)  
            SelectedPlants = options  
        end  
    })  

    SeedShop:Toggle({  
        Title = "Auto Buy Plant",  
        Desc = "Automatically buys selected plants",  
        Value = false,  
        Callback = function(state)  
            AutoBuyPlants = state  
            if state then  
                task.spawn(function()  
                    while AutoBuyPlants do  
                        for _, plant in ipairs(SelectedPlants) do  
                            local args = { {plant, "\a"} }  
                            game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2")
                                :WaitForChild("dataRemoteEvent"):FireServer(unpack(args))  
                            task.wait(0.5)  
                        end  
                        task.wait(1)  
                    end  
                end)  
            end  
        end  
    })
end

-- 🛸 TELEPORT TAB
local TeleportTab = Window:Tab({Title = "Teleport", Icon = "arrow"}) do
    TeleportTab:Section({Title = "Teleport Features"})

    TeleportTab:Button({
        Title = "Auto Claim Money", -- pakai Title, bukan Name
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ZenoVaScript/Plant-Vs-Brainrot/main/Teleport.lua"))()
        end
    })
end

-- ⚙️ MISC TAB
local MiscTab = Window:Tab({Title = "Misc", Icon = "gear"}) do
    MiscTab:Section({Title = "Misc Features"})

    local AntiAFK = false

    MiscTab:Toggle({
        Title = "Anti AFK", -- pakai Title
        Desc = "Prevents being kicked for idling",
        Value = false,
        Callback = function(state)
            AntiAFK = state
            if state then
                local Players = game:GetService("Players")
                local vu = game:GetService("VirtualUser")
                local player = Players.LocalPlayer

                player.Idled:Connect(function()
                    if AntiAFK then
                        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                        task.wait(1)
                        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    end
                end)

                -- Notification GUI
                local TweenService = game:GetService("TweenService")
                local gui = Instance.new("ScreenGui")
                gui.Name = "AFK_Notice"
                gui.ResetOnSpawn = false
                gui.IgnoreGuiInset = false
                gui.Parent = player:WaitForChild("PlayerGui")

                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(0, 560, 0, 60)
                frame.Position = UDim2.new(0.5, 0, 0, -150)
                frame.AnchorPoint = Vector2.new(0.5, 0)
                frame.BackgroundColor3 = Color3.fromRGB(70, 90, 70)
                frame.BackgroundTransparency = 0
                frame.BorderSizePixel = 0
                frame.ZIndex = 10
                frame.Parent = gui

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0, 12)
                corner.Parent = frame

                local stroke = Instance.new("UIStroke")
                stroke.Color = Color3.fromRGB(180, 255, 180)
                stroke.Thickness = 2
                stroke.Transparency = 0.05
                stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                stroke.Parent = frame

                local gradient = Instance.new("UIGradient")
                gradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 255, 160)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                }
                gradient.Rotation = 45
                gradient.Parent = frame

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -20, 1, -10)
                label.Position = UDim2.new(0, 10, 0, 5)
                label.BackgroundTransparency = 1
                label.Text = "✅ Anti-AFK aktif. Anda tidak akan dikeluarkan karena diam."
                label.Font = Enum.Font.GothamSemibold
                label.TextSize = 18
                label.TextColor3 = Color3.fromRGB(240, 255, 240)
                label.TextWrapped = true
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.TextYAlignment = Enum.TextYAlignment.Center
                label.ClipsDescendants = false
                label.ZIndex = 11
                label.Parent = frame

                TweenService:Create(frame, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0.5, 0, 0, -50)
                }):Play()

                task.delay(10, function()
                    local out = TweenService:Create(frame, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                        Position = UDim2.new(0.5, 0, 0, -120)
                    })
                    out:Play()
                    out.Completed:Wait()
                    gui:Destroy()
                end)
            end
        end
    })
end

-- ✅ Final Notification
Window:Notify({
    Title = "Zenoo Hub",
    Desc = "All tabs loaded!",
    Time = 4
})