local targetModel = game:GetService("Workspace").Containers:GetChildren()[3]
--- model here ^^ 
local PathfindingService = game:GetService("PathfindingService")
local startPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position

-- Find the path
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

-- Move the player along the path
local currentIndex = 1
local lastWaypointTime = tick()
while currentIndex <= #waypoints do
    local currentWaypoint = waypoints[currentIndex]
    local currentPart = pathParts[currentIndex]
    local distanceToWaypoint = (currentWaypoint.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

    if distanceToWaypoint <= 3 then
        -- Remove the current part since it has been reached
        if currentPart then
            currentPart:Destroy()
            table.remove(pathParts, currentIndex)
        end

        -- Move on to the next waypoint
        currentIndex = currentIndex + 1
        lastWaypointTime = tick()
    else
        -- Move towards the current waypoint
        game.Players.LocalPlayer.Character.Humanoid:MoveTo(currentWaypoint.Position)
    end

    -- Teleport to next waypoint if stuck for too long
    if currentIndex <= #waypoints and tick() - lastWaypointTime > 5 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(waypoints[currentIndex].Position)
        lastWaypointTime = tick()
    end

    task.wait()
end

-- Remove the path visualizer parts
for _, part in ipairs(pathParts) do
    part:Destroy()
end
