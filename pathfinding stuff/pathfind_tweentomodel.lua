local targetModel = game:GetService("Workspace").Containers:GetChildren()[3]
--targetmodel here  ^
local TweenService = game:GetService("TweenService")
local startPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

-- Find the path
local PathfindingService = game:GetService("PathfindingService")
local path = PathfindingService:CreatePath()
path:ComputeAsync(startPosition, targetModel.PrimaryPart.Position)

-- Create part objects for each waypoint
local waypoints = path:GetWaypoints()
local pathParts = {}
for i, waypoint in ipairs(waypoints) do
	local pathPart = Instance.new("Part")
	pathPart.Name = "Waypoint" .. i
	pathPart.Size = Vector3.new(2, 0.2, 2)
	pathPart.Position = waypoint.Position
	pathPart.Anchored = true
	pathPart.CanCollide = false
	pathPart.Shape = Enum.PartType.Ball
	pathPart.Orientation = Vector3.new(0, 0, 0)
	pathPart.Color = Color3.fromRGB(0.3843137323856354, 0.14509804546833038, 0.8196078538894653)
	pathPart.BrickColor = BrickColor.new(0.3843137323856354, 0.14509804546833038, 0.8196078538894653)
	pathPart.Transparency = 0.699999988079071
	pathPart.Material = Enum.Material["Neon"]
	pathPart.Parent = game.Workspace
	table.insert(pathParts, pathPart)
end

-- Teleport the player to each waypoint
for i, waypoint in ipairs(waypoints) do
	local previousWaypoint = waypoints[i - 1]
	if previousWaypoint then
		local distance = (waypoint.Position - previousWaypoint.Position).Magnitude
		local duration = distance / 50

		local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Sine)
		local tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(waypoint.Position)})
		tween:Play()
		tween.Completed:Wait()
	end
	
	wait(1) -- Wait for a second between each teleport
end

-- Teleport the player to the target model
local lastWaypoint = waypoints[#waypoints]
local distance = (targetModel.PrimaryPart.Position - lastWaypoint.Position).Magnitude
local duration = distance / 50

local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Sine)
local tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, tweenInfo, {CFrame = CFrame.new(targetModel.PrimaryPart.Position)})
tween:Play()
tween.Completed:Wait()

-- Delete the path parts
for _, part in ipairs(pathParts) do
	part:Destroy()
end
