ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Jobs:sendToAllAdvancedMessage')
AddEventHandler('Jobs:sendToAllAdvancedMessage', function(token, title, subject, msg, icon, time, gravity)
	if not CheckToken(token, source, "Jobs:sendToAllAdvancedMessage") then return end

	if msg == nil then
		TriggerClientEvent('Extasy:ShowNotification', source, "Annonce Jobs", "~r~Merci d'écrire une annonce avec plus de 5 caractères")
	else
		TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, title, subject, msg, icon, time, gravity)
	end
end)

RegisterServerEvent('Jobs:handleMapAlert')
AddEventHandler('Jobs:handleMapAlert', function(token, type, job, pos, alertMessage, icon)
	if not CheckToken(token, source, "Jobs:handleMapAlert") then return end

	local players = ESX.GetPlayers()

	for index, player in ipairs(players) do
		local player = ESX.GetPlayerFromId(player)

		if player then
			if type == 1 then
				if player["job"]["name"] == "vcpd" then 
					TriggerClientEvent("Jobs:sendNotifToPlayerJob", -1, 1, alertMessage, pos)
				end
			elseif type == 2 then
				if player["job"]["name"] == "vcpd" then 
					TriggerClientEvent("Jobs:sendNotifToPlayerJob", -1, 2, alertMessage, pos)
				end
			elseif type == 3 then
				if player["job"]["name"] == "vcpd" then 
					TriggerClientEvent("Jobs:sendNotifToPlayerJob", -1, 3, alertMessage, pos)
				end
			end

			--TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, "Title", "~r~Alerte", alertMessage, "CHAR_")
		end
	end
end)

RegisterServerEvent('Jobs:sendMsgToJobClients')
AddEventHandler('Jobs:sendMsgToJobClients', function(token, type, job, message)
	if not CheckToken(token, source, "Jobs:sendMsgToJobClients") then return end

	local players = ESX.GetPlayers()

	for index, player in ipairs(players) do
		local player = ESX.GetPlayerFromId(player)

		if player then
			if type == 1 then
				if player["job"]["name"] == "vcpd" then 
					TriggerClientEvent("Jobs:sendNotifToPlayerJob", -1, 1, message)
				end
			elseif type == 2 then
				if player["job"]["name"] == "vcpd" then 
					TriggerClientEvent("Jobs:sendNotifToPlayerJob", -1, 2, message)
				end
			end

			--TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, "Title", "~r~Alerte", alertMessage, "CHAR_")
		end
	end
end)

RegisterNetEvent("Extasy:AddPayToPlayer")
AddEventHandler("Extasy:AddPayToPlayer", function(token, money)
    if not CheckToken(token, source, "Extasy:AddPayToPlayer") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addAccountMoney('bank', money)
end)

RegisterNetEvent("Jobs:getCountOfThisJob")
AddEventHandler("Jobs:getCountOfThisJob", function(token, job)
    local players = ESX.GetPlayers()
	local PlayerOnJobs = 0

	for index, player in ipairs(players) do
		local player = ESX.GetPlayerFromId(player)

		if player then
			if player["job"]["name"] == job then
				PlayerOnJobs = PlayerOnJobs + 1
			end
		end
	end

    TriggerClientEvent("Jobs:actCountOfThisJob", source, PlayerOnJobs)
end)

RegisterServerEvent('Jobs:resetLeaderboard')
AddEventHandler('Jobs:resetLeaderboard', function(token, job)
    if not CheckToken(token, source, "Jobs:resetLeaderboard") then return end
	local ids = GetPlayerIdentifiers(source)
    local license = GetPlayerLicense(ids)

	MySQL.Async.execute('UPDATE users SET farm_count=@farm_count WHERE job = @job', { ["@job"] = job, ["@farm_count"] = 0})
end)