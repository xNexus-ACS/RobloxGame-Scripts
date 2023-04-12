dist = 10
local bin = script.Parent
local box = bin.Parent.Decals
local painting = script.Parent
local qlock = painting.BeingObserved

decals = box
check = box:GetChildren()

function paint(decal,color)
	if decals:findFirstChild(decal) == nil then print('Error '..decal) return end
	local painting = decals[decal]:clone()
	painting.Parent = bin
	bin.BrickColor = BrickColor.new(color)
end

function clear()
	local clean = script.Parent:GetChildren()
	for i = 1, #clean do
		if clean[i].ClassName == "Decal" then
			clean[i]:remove()
		end
	end
end

--[[function onTouched()
	--local val = box.Randomizer
	--paint(box.Randomizer.Value,
	paint('1','Navy blue')
end
script.Parent.Touched:connect(onTouched)]]

function Lock()
if (qlock.Value) then return end
qlock.Value = true
clear()
wait(.01)
paint('1','Navy blue')
end

function Unlock()
if (not qlock.Value) then return end
qlock.Value = false
clear()
wait(.1)
paint('Grey','Dark stone grey')
end

function CanBeSeen()
for i,v in pairs(game.Players:children()) do
if (v.Character ~= nil) and (v.Character:findFirstChild("Torso") ~= nil) then
if (v.Character.Torso.Position - painting.Position).magnitude < dist then
if (v.Character:findFirstChild('MoveTo') == nil) then
script.Parent.Effects.MoveTo:Clone().Parent = v.Character
end
local distA =  (painting.Position - (v.Character.Torso.CFrame * CFrame.new(5,0,-10)).p).magnitude 
local distB=  (painting.Position - (v.Character.Torso.CFrame * CFrame.new(-5,0,-10)).p).magnitude 
local distC=  (painting.Position - (v.Character.Torso.CFrame * CFrame.new(0,0,2)).p).magnitude 
if distA < distC and distB < distC then return true end
end
end
end
return false end

Unlock()
while true do
wait(0.1)
if (CanBeSeen()) then
Lock()
else
Unlock()
end
end