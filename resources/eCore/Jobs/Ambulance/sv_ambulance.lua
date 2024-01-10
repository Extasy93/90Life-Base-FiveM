ESX = nil
local playersHealing, deadPlayers = {}, {}

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

RegisterServerEvent('esx_ambulance:reviveExtasyyy')
AddEventHandler('esx_ambulance:reviveExtasyyy', function(token, target)
	if not CheckToken(token, source, "esx_ambulance:reviveExtasyyy") then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	if xPlayer.job.name == 'ambulance' then
		local societyAccount = nil
		TriggerEvent('eAddonaccount:getSharedAccount', 'society_ambulance', function(account)
			societyAccount = account
		end)
		if societyAccount ~= nil then
			xPlayer.addMoney(cfg_ambulance.ReviveReward)
			TriggerClientEvent('esx_ambulance:reviveExtasyyy', target)
			societyAccount.addMoney(150)
			--print('150$ ajouté')
		end
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'ambulance' then
				TriggerClientEvent('esx_ambulance:notif', xPlayers[i])
			end
		end
	else
		--print(('esx_ambulance: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('Pharmacy:giveItem')
AddEventHandler('Pharmacy:giveItem', function(token, item, count)
	if not CheckToken(token, source, "Pharmacy:giveItem") then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item, count)
	TriggerClientEvent("Extasy:ShowNotification", source, 'Vous avez récuperé vos ~p~medikits')
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = 'dead'
	TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
end)

RegisterNetEvent('esx_ambulancejob:onPlayerDistress')
AddEventHandler('esx_ambulancejob:onPlayerDistress', function(token)
	if not CheckToken(token, source, "esx_ambulancejob:onPlayerDistress") then return end
	if deadPlayers[source] then
		deadPlayers[source] = 'distress'
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(token, target, type)
	if not CheckToken(token, source, "esx_ambulancejob:heal") then return end
	local xPlayer = ESX.GetPlayerFromId(source)

	print(target)
	TriggerClientEvent('esx_ambulancejob:heal', target, type)
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(token, target)
	if not CheckToken(token, source, "esx_ambulancejob:putInVehicle") then return end
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if cfg_ambulance.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if cfg_ambulance.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if cfg_ambulance.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if cfg_ambulance.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= cfg_ambulance.EarlyRespawnFineAmount)
	end)

	RegisterNetEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function(token)
		if not CheckToken(token, source, "esx_ambulancejob:payFine") then return end
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = cfg_ambulance.EarlyRespawnFineAmount

		xPlayer.showNotification('vous avez payé ~r~$'..ESX.Math.GroupDigits(fineAmount)..'~s~ pour être réanimer.')
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)


RegisterNetEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(token, item)
	if not CheckToken(token, source, "esx_ambulancejob:removeItem") then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)
	if item == 'bandage' then
		TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, '~p~Vous avez utilisé un bandage.')
	elseif item == 'medikit' then
		TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, '~p~Vous avez utilisé un medikit.')
	end
end)


ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)



ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('doliprane', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('doliprane', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'doliprane')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
			--print(('esx_ambulancejob: %s attempted combat logging!'):format(identifier))
		end

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(token, isDead)
	if not CheckToken(token, source, "esx_ambulancejob:setDeathStatus") then return end
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	if type(isDead) ~= 'boolean' then
		--print(('esx_ambulancejob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
		['@isDead'] = isDead
	})
end)

function sendToDiscordWithSpecialURL (name,message,color,url)
    local DiscordWebHook = url
    -- Modify here your discordWebHook username = name, content = message,embeds = embeds
  
  local embeds = {
      {
          ["title"]=message,
          ["type"]="rich",
          ["color"] =color,
          ["footer"]=  {
          ["text"]= "90Life-BOT, tout droits réservés ©",
         },
      }
  }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
  end

-- Prise Appel EMS 


-- Notification appel ems pour tout les ems
RegisterServerEvent("Server:emsAppel")
AddEventHandler("Server:emsAppel", function(token, coords, id)
	if not CheckToken(token, source, "Server:emsAppel") then return end
	--local xPlayer = ESX.GetPlayerFromId(source)
	local _coords = coords
	local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          if xPlayer.job.name == 'ambulance' then
               TriggerClientEvent("AppelemsTropBien", xPlayers[i], _coords, id)
		end
	end
end)

-- Prise d'appel ems
RegisterServerEvent('EMS:PriseAppelServeur')
AddEventHandler('EMS:PriseAppelServeur', function(token)
	if not CheckToken(token, source, "EMS:PriseAppelServeur") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = xPlayer.getName(source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('EMS:AppelDejaPris', xPlayers[i], name)
		end
	end
end)

ESX.RegisterServerCallback('EMS:GetID', function(source, cb)
	local idJoueur = source
	cb(idJoueur)
end)

local AppelTotal = 0
RegisterServerEvent('EMS:AjoutAppelTotalServeur')
AddEventHandler('EMS:AjoutAppelTotalServeur', function(token)
	if not CheckToken(token, source, "EMS:AjoutAppelTotalServeur") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = xPlayer.getName(source)
	local xPlayers = ESX.GetPlayers()
	AppelTotal = AppelTotal + 1

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'ambulance' then
			TriggerClientEvent('EMS:AjoutUnAppel', xPlayers[i], AppelTotal)
		end
	end

end)

RegisterNetEvent("eAmbulance:revive")
AddEventHandler("eAmbulance:revive", function(token)
	if not CheckToken(token, source, "eAmbulance:revive") then return end
     local _src = source
     sendToDiscordWithSpecialURL("Ambulance Revive","**"..GetPlayerName(_src).."** a été réanimer par les EMS ! ", 16744192, "https://discord.com/api/webhooks/835154408933163039/cE4xaVGk8En67U21UPW1_Id-CPH1hCbFghEUX6hGUB9YXaRfVlg42uqXPuFYhZa67meA")
end)

RegisterNetEvent("eAmbulance:revivestaff")
AddEventHandler("eAmbulance:revivestaff", function(token)
	if not CheckToken(token, source, "eAmbulance:revivestaff") then return end
     local _src = source
     sendToDiscordWithSpecialURL("Staff Revive","**"..GetPlayerName(_src).."** as été réanimer par un STAFF ! ", 16744192, "https://discord.com/api/webhooks/835154408933163039/cE4xaVGk8En67U21UPW1_Id-CPH1hCbFghEUX6hGUB9YXaRfVlg42uqXPuFYhZa67meA")
end)