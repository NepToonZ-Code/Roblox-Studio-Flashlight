local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local flashlightKey = Enum.KeyCode.F  -- Change this to the desired key

local flashlight = Instance.new("SpotLight")
flashlight.Color = Color3.fromRGB(115, 153, 86) -- Set the light color (optional)
flashlight.Brightness = 0 -- Set the light brightness (optional)
flashlight.Range = 25  -- Set the light range (optional)
flashlight.Enabled = false  -- Initially, the flashlight is off

local FlashlightSound = game.ReplicatedStorage.SFX.FlashlightSound

-- Attach the SpotLight to the player's character (e.g., head or hand)
-- Replace "Head" with the desired attachment name (e.g., "RightHand")
flashlight.Parent = player.Character.Head

-- Function to toggle the flashlight on and off
local function toggleFlashlight()
    flashlight.Enabled = not flashlight.Enabled
    flashlight.Brightness = 0
    if flashlight.Enabled then
        FlashlightSound:Play()
        for i = 1, 10 do
            flashlight.Brightness = flashlight.Brightness + 1
            wait(0.01)
        end
    else
        FlashlightSound:Play()
        for i = 1, 10 do
            flashlight.Brightness = flashlight.Brightness - 1
            wait(0.01)
        end
    end
end

-- Function to handle key presses
local function onKeyPress(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == flashlightKey then
        toggleFlashlight()
    end
end

-- Function to update flashlight direction based on mouse position
local function updateFlashlightDirection()
    local mousePosition = userInputService:GetMouseLocation()
    local camera = workspace.CurrentCamera
    local ray = camera:ScreenPointToRay(mousePosition.X, mousePosition.Y)
    local origin = camera.CFrame.Position
    local direction = (ray.Position - origin).Unit * flashlight.Range
    flashlight.CFrame = CFrame.new(origin, origin + direction)
end

-- Connect the key press event
userInputService.InputBegan:Connect(onKeyPress)
userInputService.MouseIconEnabled = false

-- Connect the RunService render step to continuously update flashlight direction
RunService.RenderStepped:Connect(updateFlashlightDirection)
