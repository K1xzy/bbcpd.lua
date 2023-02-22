local targetModel = game:GetService("Workspace").Containers.LightHouse.LargeABPOPABox
--- model path      ^
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local targetPart = targetModel.PrimaryPart
local targetCFrame = targetPart and targetPart.CFrame or targetModel:GetBoundingBox()

local studsPerFrame = 32 -- how fast to get to the model/pos

local stopTeleporting = false
UserInputService.InputBegan:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.Keyboard then
        local keyCode = inputObject.KeyCode
        if keyCode == Enum.KeyCode.W or keyCode == Enum.KeyCode.A or keyCode == Enum.KeyCode.S or keyCode == Enum.KeyCode.D then
            stopTeleporting = true
        end
    end
end)

while true do
    local frameDelta = task.wait()
    local playerCFrame = character.PrimaryPart.CFrame
    local distance = (targetCFrame.Position - playerCFrame.Position).Magnitude
    if distance <= studsPerFrame or stopTeleporting then
        break
    end
    local alpha = (studsPerFrame / distance) * frameDelta
    local pivotCFrame = playerCFrame:Lerp(targetCFrame, alpha)
    character:PivotTo(pivotCFrame)
end

if not stopTeleporting then
    character.HumanoidRootPart.CFrame = targetCFrame
end
