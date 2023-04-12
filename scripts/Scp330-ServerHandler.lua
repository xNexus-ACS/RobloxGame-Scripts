local ServerStorage = game:GetService("ServerStorage")
local StorageFile = ServerStorage.Tools:WaitForChild("Object Class SCPs")
local Group = script.Parent
local Bowl = Group:WaitForChild("Bowl")
local MouseClicker = Group:WaitForChild("MouseClick")
local CandyColors = {"Crimson", "Persimmon", "Really red", "Bright red", "Maroon", "Terra Cotta", "Dusty Rose", "Cocoa", "Salmon", "Tawny", "Medium red", "Burgundy", "Copper", "Sand red"}

local function AssignColorToDescendants(Object, Color)
	for index, descendant in pairs(Object:GetChildren()) do
		if descendant:IsA("BasePart") then
			descendant.BrickColor = Color
		end
	end
end

spawn(function ()
	for index, descendant in ipairs(Group:GetChildren()) do
		if string.lower(descendant.Name) == string.lower("CandyModel") then
			local CandyColor = descendant:WaitForChild("CandyColor")
			CandyColor.Value = BrickColor.new(CandyColors[math.random(1, #CandyColors)])
			AssignColorToDescendants(descendant, CandyColor.Value)
		end
	end
end)

MouseClicker.MouseClick:connect(function (playerWhoClicked)
	local Character = playerWhoClicked.Character or playerWhoClicked.CharacterAdded:wait()
	local CandyPieces = 0
	if playerWhoClicked and Character then
		for index, descendant in pairs(playerWhoClicked:WaitForChild("Backpack"):GetChildren()) do
			if string.lower(descendant.Name) == string.lower("Candy") then
				CandyPieces = CandyPieces + 1
			end
		end
		if CandyPieces == 2 then
			if Character and Character:FindFirstChild("Left Arm") and Character:FindFirstChild("Right Arm") then
				Character:WaitForChild("Left Arm"):Destroy()
				Character:WaitForChild("Right Arm"):Destroy()
				local SeverSound = script:WaitForChild("LimbSever"):Clone()
				SeverSound.Parent = Character:WaitForChild("Torso")
				SeverSound:Play()
				game:GetService("Debris"):AddItem(SeverSound, SeverSound.TimeLength + 0.5)
			end
		elseif CandyPieces ~= 2 and Character:FindFirstChild("Left Arm") and Character:FindFirstChild("Right Arm") then
			Bowl:WaitForChild("Grab"):Play()
			local NewCandy = StorageFile:WaitForChild("Candy"):Clone()
			NewCandy:WaitForChild("CandyColor").Value = BrickColor.new(CandyColors[math.random(1, #CandyColors)])
			NewCandy.Parent = playerWhoClicked:WaitForChild("Backpack")
			wait()
			Character:WaitForChild("Humanoid"):EquipTool(NewCandy)
		end
	end
end)