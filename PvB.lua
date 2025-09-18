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
                            local args = {
                                {plant, "\a"}
                            }
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

-- ✅ Final Notification
Window:Notify({
    Title = "Zeno Hub",
    Desc = "Thank you for using this script!",
    Time = 4
})