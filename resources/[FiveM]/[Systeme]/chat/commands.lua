ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

local canAdvertise = true

if cfg_chat.AllowPlayersToClearTheirChat then
	RegisterCommand(cfg_chat.ClearChatCommand, function(source, args, rawCommand)
		TriggerClientEvent('chat:client:ClearChat', source)
	end)
end

if cfg_chat.AllowStaffsToClearEveryonesChat then
	RegisterCommand(cfg_chat.ClearEveryonesChatCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local time = os.date(cfg_chat.DateFormat)

		if isAdmin(xPlayer) then
			TriggerClientEvent('chat:client:ClearChat', -1)
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message system"><i class="fas fa-cog"></i> <b><span style="color: #df7b00">SYSTEM</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{0}</span></b><div style="margin-top: 5px; font-weight: 300;">The chat has been cleared!</div></div>',
				args = { time }
			})
		end
	end)
end

if cfg_chat.EnableStaffCommand then
	RegisterCommand(cfg_chat.StaffCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(cfg_chat.StaffCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(cfg_chat.DateFormat)
		playerName = xPlayer.getName()

		if isAdmin(xPlayer) then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message staff"><i class="fas fa-shield-alt"></i> <b><span style="color: #1ebc62">[STAFF] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
		end
	end)
end

if cfg_chat.EnableStaffOnlyCommand then
	RegisterCommand(cfg_chat.StaffOnlyCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(cfg_chat.StaffOnlyCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(cfg_chat.DateFormat)
		playerName = xPlayer.getName()

		if isAdmin(xPlayer) then
			showOnlyForAdmins(function(admins)
				TriggerClientEvent('chat:addMessage', admins, {
					template = '<div class="chat-message staffonly"><i class="fas fa-eye-slash"></i> <b><span style="color: #1ebc62">[STAFF ONLY] {0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
					args = { playerName, message, time }
				})
			end)
		end
	end)
end

if cfg_chat.EnableAdvertisementCommand then
	RegisterCommand(cfg_chat.AdvertisementCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(cfg_chat.AdvertisementCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(cfg_chat.DateFormat)
		playerName = xPlayer.getName()
		local bankMoney = xPlayer.getAccount('bank').money

		if canAdvertise then
			if bankMoney >= cfg_chat.AdvertisementPrice then
				xPlayer.removeAccountMoney('bank', cfg_chat.AdvertisementPrice)
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div class="chat-message advertisement"><i class="fas fa-ad"></i> <b><span style="color: #81db44">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
					args = { playerName, message, time }
				})

				TriggerClientEvent('okokNotify:Alert', source, "ADVERTISEMENT", "Advertisement successfully made for "..cfg_chat.AdvertisementPrice..'€', 10000, 'success')

				local time = cfg_chat.AdvertisementCooldown * 60
				local pastTime = 0
				canAdvertise = false

				while (time > pastTime) do
					Citizen.Wait(1000)
					pastTime = pastTime + 1
					timeLeft = time - pastTime
				end
				canAdvertise = true
			else
				TriggerClientEvent('okokNotify:Alert', source, "ADVERTISEMENT", "You don't have enough money to make an advertisement", 10000, 'error')
			end
		else
			TriggerClientEvent('okokNotify:Alert', source, "ADVERTISEMENT", "You can't advertise so quickly", 10000, 'error')
		end
	end)
end

if cfg_chat.EnableTwitchCommand then
	RegisterCommand(cfg_chat.TwitchCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(cfg_chat.TwitchCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(cfg_chat.DateFormat)
		playerName = xPlayer.getName()
		local twitch = twitchPermission(source)

		if twitch then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message twitch"><i class="fab fa-twitch"></i> <b><span style="color: #9c70de">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
		end
	end)
end

twitchPermission = function(id)
	for i, a in ipairs(cfg_chat.TwitchList) do
		for x, b in ipairs(GetPlayerIdentifiers(id)) do
			if string.lower(b) == string.lower(a) then
				return true
			end
		end
	end
end

if cfg_chat.EnableYoutubeCommand then
	RegisterCommand(cfg_chat.YoutubeCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(cfg_chat.YoutubeCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(cfg_chat.DateFormat)
		playerName = xPlayer.getName()
		local youtube = youtubePermission(source)

		if youtube then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message youtube"><i class="fab fa-youtube"></i> <b><span style="color: #ff0000">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
		end
	end)
end

youtubePermission = function(id)
	for i, a in ipairs(cfg_chat.YoutubeList) do
		for x, b in ipairs(GetPlayerIdentifiers(id)) do
			if string.lower(b) == string.lower(a) then
				return true
			end
		end
	end
end

if cfg_chat.EnableTwitterCommand then
	RegisterCommand(cfg_chat.TwitterCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(cfg_chat.TwitterCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(cfg_chat.DateFormat)
		playerName = xPlayer.getName()

		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div class="chat-message twitter"><i class="fab fa-twitter"></i> <b><span style="color: #2aa9e0">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
			args = { playerName, message, time }
		})
	end)
end

if cfg_chat.EnablePoliceCommand then
	RegisterCommand(cfg_chat.PoliceCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(cfg_chat.PoliceCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(cfg_chat.DateFormat)
		playerName = xPlayer.getName()
		local job = xPlayer.job.name

		if job == cfg_chat.PoliceJobName then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message police"><i class="fas fa-bullhorn"></i> <b><span style="color: #4a6cfd">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
		end
	end)
end

if cfg_chat.EnableAmbulanceCommand then
	RegisterCommand(cfg_chat.AmbulanceCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(cfg_chat.AmbulanceCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(cfg_chat.DateFormat)
		playerName = xPlayer.getName()
		local job = xPlayer.job.name

		if job == cfg_chat.AmbulanceJobName then
			TriggerClientEvent('chat:addMessage', -1, {
				template = '<div class="chat-message ambulance"><i class="fas fa-ambulance"></i> <b><span style="color: #e3a71b">{0}</span>&nbsp;<span style="font-size: 14px; color: #e1e1e1;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
				args = { playerName, message, time }
			})
		end
	end)
end

if cfg_chat.EnableOOCCommand then
	RegisterCommand(cfg_chat.OOCCommand, function(source, args, rawCommand)
		local xPlayer = ESX.GetPlayerFromId(source)
		local length = string.len(cfg_chat.OOCCommand)
		local message = rawCommand:sub(length + 1)
		local time = os.date(cfg_chat.DateFormat)
		playerName = xPlayer.getName()
		TriggerClientEvent('chat:ooc', -1, source, playerName, message, time)
	end)
end

isAdmin = function(xPlayer)
	for k,v in ipairs(cfg_chat.StaffGroups) do
		if xPlayer.getGroup() == v then 
			return true 
		end
	end
	return false
end

showOnlyForAdmins = function(admins)
	for k,v in ipairs(ESX.GetPlayers()) do
		if isAdmin(ESX.GetPlayerFromId(v)) then
			admins(v)
		end
	end
end