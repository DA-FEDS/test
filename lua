local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to create ESP Box and username
local function createESPBox(character, player)
    -- Create the ESP box
    local highlight = Instance.new("BoxHandleAdornment")
    highlight.Adornee = character:FindFirstChild("HumanoidRootPart") -- Attach to HumanoidRootPart
    highlight.Size = Vector3.new(4, 6, 4) -- Adjust size
    highlight.Color3 = Color3.fromRGB(192, 192, 192) -- Light green color
    highlight.Transparency = 0.9 -- Slight transparency
    highlight.ZIndex = 0 -- Behind other GUI elements
    highlight.AlwaysOnTop = true -- Box always visible
    highlight.Parent = character:FindFirstChild("HumanoidRootPart") -- Add to HumanoidRootPart

    -- Create BillboardGui for username display
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = character:FindFirstChild("Head") -- Attach to the player's head
    billboard.Size = UDim2.new(0, 100, 0, 50) -- Set size of the GUI
    billboard.StudsOffset = Vector3.new(0, 2, 0) -- Position it above the player's head
    billboard.AlwaysOnTop = true -- Always visible

    -- Create TextLabel for displaying username
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0) -- Fill the entire BillboardGui
    nameLabel.BackgroundTransparency = 1 -- Make background transparent
    nameLabel.Text = player.Name -- Set the text to the player's username
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text color
    nameLabel.TextStrokeTransparency = 0.5 -- Add some outline to the text
    nameLabel.TextScaled = true -- Scale text to fit

    -- Parent the TextLabel to the BillboardGui
    nameLabel.Parent = billboard

    -- Parent the BillboardGui to the player's head
    billboard.Parent = character:FindFirstChild("Head")
end

-- Function to add ESP and username to a player
local function addESPToPlayer(player)
    if player ~= LocalPlayer then -- Exclude yourself
        local character = player.Character or player.CharacterAdded:Wait()
        if character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head") then
            if not character:FindFirstChildOfClass("BoxHandleAdornment") then
                createESPBox(character, player)
            end
        end
    end
end

-- Apply ESP and username to existing players
for _, player in pairs(Players:GetPlayers()) do
    addESPToPlayer(player)
end

-- Trigger ESP for new players when they join
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        addESPToPlayer(player)
    end)
end)
