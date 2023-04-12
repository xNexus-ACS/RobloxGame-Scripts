function Activate()
	if script.Parent.Parent.Active.Value == true and script.Parent.Parent.Power.Value == true then
		wait()
		local g = script.Parent:GetChildren()
		for b = 1, 450 do
			for i = 1, # g do
				if g[i].className == "Part" then
					g[i].CFrame = g[i].CFrame + Vector3.new(0, .02, 0)
				end
			end
			wait(.025)
		end
		wait(2)
		script.Parent.Parent.Valid.Value = true
	elseif script.Parent.Parent.Active.Value == false then
		wait()
		local g = script.Parent:GetChildren()
		script.Parent.Parent.Frame.Sound.Sound:Play()
		wait()
		for b = 1, 450 do
			for i = 1, # g do
				if g[i].className == "Part" then
					g[i].CFrame = g[i].CFrame + Vector3.new(0, -.02, 0)
				end
			end
			wait(.025)
		end
		wait(2)
		wait(2)
		script.Parent.Parent.Valid.Value = true
	end
end

script.Parent.Parent.Active.Changed:connect(Activate)