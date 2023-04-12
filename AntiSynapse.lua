local function GetBanStatus(UserId)
	local Success, Message = pcall(function()
		return game.HttpService:RequestAsync({
			Url = 'https://oofd.net/api/ban/status/',
			Method = 'POST',
			Body = game.HttpService:JSONEncode({
				['UserId'] = UserId,
				['ReasonFilters'] = {
					"INJECT",
					"EXPLOIT",
					"GLITCH",
					"CHILD",
					"MACRO",
				}
			})
		})
	end)
	
	if Success then
		local Body = Message.Body and game.HttpService:JSONDecode(Message.Body) or nil
		if Body and Body.Success then
			return Body.Banned and Body.Data[1].BannedBy == "SYNAPSE"
		end
	end
end

local function GetFriends(UserId)
	local FriendsList = game.Players:GetFriendsAsync(UserId)
	local Friends = {}
	
	while true do
		for _,Friend in pairs(FriendsList:GetCurrentPage()) do
			Friends[#Friends + 1] = Friend
		end
		
		if FriendsList.IsFinished then
			break
		end
		
		FriendsList:AdvanceToNextPageAsync()
	end
	
	return Friends
end

local function GetBannedFriends(UserId)
	for Index,Friend in pairs(GetFriends(UserId)) do
		coroutine.resume(coroutine.create(function()
			if GetBanStatus(Friend.Id) == true then
				warn(Friend.Username)
			end
		end))
	end
end

GetBannedFriends(52707732)