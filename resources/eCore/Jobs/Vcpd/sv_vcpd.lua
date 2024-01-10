ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'vcpd', 'vcpd', 'society_vcpd', 'society_vcpd', 'society_vcpd', {type = 'public'})

RegisterServerEvent('Outlawalert:gunshotInProgress')
AddEventHandler('Outlawalert:gunshotInProgress', function(token, targetCoords, playerGender)
	if not CheckToken(token, source, "Outlawalert:gunshotInProgress") then return end
	TriggerClientEvent('Outlawalert:outlawNotify', -1, "~r~[ALERTS - VCPD]\n~w~Des coups de feu ont été entendu par un citoyen !")
	TriggerClientEvent('Outlawalert:gunshotInProgress', -1, targetCoords)
end)

RegisterServerEvent('vcpd:drag')
AddEventHandler('vcpd:drag', function(token, target)
	if not CheckToken(token, source, "vcpd:drag") then return end
  local _source = source
  TriggerClientEvent('vcpd:drag1', target, _source)
end)

local playerCarteID = {}

RegisterServerEvent('vcpd:LookInfo')
AddEventHandler('vcpd:LookInfo', function(token, args)
	if not CheckToken(token, source, "vcpd:LookInfo") then return end
	local _source = source
	local xPlayer    = ESX.GetPlayerFromId(args)
    local identifier = xPlayer.identifier
    
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)

        for k,v in pairs(result) do
            if not playerCarteID[xPlayer.identifier] then 
                playerCarteID[xPlayer.identifier] =  {} 
                playerCarteID[xPlayer.identifier].firstname = v.firstname
                playerCarteID[xPlayer.identifier].lastname = v.lastname
                playerCarteID[xPlayer.identifier].dateofbirth = v.dateofbirth
                playerCarteID[xPlayer.identifier].sex = v.sex
                playerCarteID[xPlayer.identifier].height = v.height
            end
            TriggerClientEvent('Extasy:showAdvancedNotification', source, "Carte d'identité", "Préfecture", "~p~Prénom: ~s~".. playerCarteID[xPlayer.identifier].firstname.."\n~p~Nom: ~s~"..playerCarteID[xPlayer.identifier].lastname.."\n~p~Née le: ~s~"..playerCarteID[xPlayer.identifier].dateofbirth.."\n~p~Taille: ~s~"..playerCarteID[xPlayer.identifier].height.." cm\n~p~Sexe: ~s~"..playerCarteID[xPlayer.identifier].sex, "CHAR_LESTER", 8)
        end
    end)
end)

RegisterServerEvent('vcpd:blipcode')
AddEventHandler('vcpd:blipcode', function(token, Coords, Name, code, msg, gravity, color)
	if not CheckToken(token, source, "vcpd:blipcode") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.job.name == 'vcpd' then
		TriggerClientEvent("vcpd:SendRadioCall", -1, Coords, Name, code, msg, gravity, color)
	end
end)

RegisterServerEvent('vcpd:LookPermis')
AddEventHandler('vcpd:LookPermis', function(token, args)
	if not CheckToken(token, source, "vcpd:LookPermis") then return end
	local _source = source
	local xPlayer    = ESX.GetPlayerFromId(args)
    local identifier = xPlayer.identifier
    
    MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
        ['@owner'] = xPlayer.identifier
    }, function(result)

        for k,v in pairs(result) do
            if not playerCarteID[xPlayer.identifier] then 
                playerCarteID[xPlayer.identifier] =  {} 
                playerCarteID[xPlayer.identifier].Voiture = v.Voiture
                playerCarteID[xPlayer.identifier].Armes = v.Armes
                playerCarteID[xPlayer.identifier].Camion = v.Camion
                playerCarteID[xPlayer.identifier].Moto = v.Moto
                playerCarteID[xPlayer.identifier].Chasse = v.Chasse
				playerCarteID[xPlayer.identifier].taille = v.taille
            end
            TriggerClientEvent('Extasy:showAdvancedNotification', source, "Permis", "Préfecture", "~p~Voiture: ~s~"..playerCarteID[xPlayer.identifier].Voiture.."\n~p~Moto: ~s~"..playerCarteID[xPlayer.identifier].Moto.."\n~p~Camion: ~s~"..playerCarteID[xPlayer.identifier].Camion.."\n~p~Chasse: ~s~"..playerCarteID[xPlayer.identifier].Chasse.."\n~p~PPA: ~s~"..playerCarteID[xPlayer.identifier].Armes.."\n~p~Type de PPA: ~s~"..playerCarteID[xPlayer.identifier].taille, "CHAR_LESTER", 8)
        end
    end)
end)

RegisterNetEvent('vcpdjob:confiscatePlayerItem')
AddEventHandler('vcpdjob:confiscatePlayerItem', function(token, target, itemType, itemName, amount)
	if not CheckToken(token, source, "vcpdjob:confiscatePlayerItem") then return end
	local _source = source
	local _target = target
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'vcpd' or sourceXPlayer.job.name == 'fbi' then
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		
		-- does the target player have enough in their inventory?

		if targetItem.count > 0 and targetItem.count >= amount then
			targetXPlayer.removeInventoryItem(itemName, amount)
			sourceXPlayer.addInventoryItem   (itemName, amount)
		end

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon(itemName, amount)

		TriggerEvent("over:logsmoica", _target, _source, 0, itemName)

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney(itemName, amount)
	end
end)


RegisterServerEvent('vcpdjob:handcuff')
AddEventHandler('vcpdjob:handcuff', function(token, target)
	if not CheckToken(token, source, "vcpdjob:handcuff") then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('vcpdjob:handcuff', target)
end)

RegisterServerEvent('vcpdjob:handcuff2')
AddEventHandler('vcpdjob:handcuff2', function(token, target)
	if not CheckToken(token, source, "vcpdjob:handcuff2") then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('vcpdjob:handcuff', target)
end)

RegisterServerEvent('vcpdjob:drag')
AddEventHandler('vcpdjob:drag', function(token, target)
	if not CheckToken(token, source, "vcpdjob:drag") then return end
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent('vcpdjob:drag', target, source)
end)

RegisterServerEvent('vcpdjob:putInVehicle')
AddEventHandler('vcpdjob:putInVehicle', function(token, target)
	if not CheckToken(token, source, "vcpdjob:putInVehicle") then return end
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'vcpd' then
		TriggerClientEvent('vcpdjob:putInVehicle', target)
	else
		print(('vcpdjob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('vcpdjob:OutVehicle')
AddEventHandler('vcpdjob:OutVehicle', function(token, target)
	if not CheckToken(token, source, "vcpdjob:OutVehicle") then return end
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'vcpd' then
		TriggerClientEvent('vcpdjob:OutVehicle', target)
	else
		print(('vcpdjob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('vcpdjob:getStockItem')
AddEventHandler('vcpdjob:getStockItem', function(token, itemName, count)
	if not CheckToken(token, source, "vcpdjob:getStockItem") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('eAddoninventory:getSharedInventory', 'society_vcpd', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
        if count > 0 and inventoryItem.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
			TriggerClientEvent('Extasy:showNotification', _source, 'objet retiré', count, inventoryItem.label)
        else
            TriggerClientEvent('Extasy:showNotification', _source, "quantité invalide")
        end
    end)
end)

RegisterServerEvent('vcpdjob:putStockItems')
AddEventHandler('vcpdjob:putStockItems', function(token, itemName, count)
	if not CheckToken(token, source, "vcpdjob:putStockItems") then return end
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('eAddoninventory:getSharedInventory', 'society_vcpd', function(inventory)
		local sourceItem = xPlayer.getInventoryItem(itemName)

		-- does the player have enough of the item?
        if sourceItem.count >= count and count > 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent('Extasy:showNotification', _source, "objet déposé "..count..""..inventoryItem.label.."")
        else
            TriggerClientEvent('Extasy:showNotification', _source, "quantité invalide")
        end
    end)
end)

ESX.RegisterServerCallback('vcpdjob:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("Extasy:showNotification", target, "~r~Quelqu'un vous fouille ...")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    end
end)

ESX.RegisterServerCallback('vcpdjob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('vcpdjob:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then
			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if cfg_vcpd.EnableESXIdentity then
					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				else
					retrivedInfo.owner = result2[1].name
				end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('vcpdjob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if cfg_vcpd.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb('inconnu', false)
		end
	end)
end)

ESX.RegisterServerCallback('vcpdjob:getArmoryWeapons', function(source, cb)
	TriggerEvent('eDatastore:getSharedDataStore', 'society_vcpd', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('vcpdjob2:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
		TriggerEvent("over:logsmoicadelete", _source, weaponName, 0)
	end

	TriggerEvent('eDatastore:getSharedDataStore', 'society_vcpd', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('vcpdjob:removeArmoryWeapon', function(source, cb, weaponName)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, weaponName, 500, "Coffre de la LSPD")

	TriggerEvent('eDatastore:getSharedDataStore', 'society_vcpd', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('vcpdjob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = cfg_vcpd.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('vcpdjob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeapon(weaponName, 100)

				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)

			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					xPlayer.addWeaponComponent(weaponName, component.name)

					cb(true)
				else
					cb(false)
				end
			else
				print(('vcpdjob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end
		end
	end
end)


ESX.RegisterServerCallback('vcpdjob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('vcpdjob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)

			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('vcpdjob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('vcpdjob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = cfg_vcpd.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = cfg_vcpd.AuthorizedVehicles[jobGrade]
		local shared = cfg_vcpd.AuthorizedVehicles['Shared']

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end

		for k,v in ipairs(shared) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

ESX.RegisterServerCallback('GangsBuilderJob:getStockItems', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('eAddoninventory:getSharedInventory', 'society_vcpd', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('vcpdjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source

	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)

		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'vcpd' then
			Citizen.Wait(5000)
			TriggerClientEvent('vcpdjob:updateBlip', -1)
		end
	end
end)

RegisterServerEvent('vcpdjob:spawned')
AddEventHandler('vcpdjob:spawned', function(token)
	if not CheckToken(token, source, "vcpdjob:spawned") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'vcpd' then
		Citizen.Wait(5000)
		TriggerClientEvent('vcpdjob:updateBlip', -1)
	end
end)

RegisterServerEvent('vcpdjob:forceBlip')
AddEventHandler('vcpdjob:forceBlip', function(token)
	if not CheckToken(token, source, "vcpdjob:forceBlip") then return end

	TriggerClientEvent('vcpdjob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('vcpdjob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'vcpd')
	end
end)

RegisterServerEvent('vcpdjob:message')
AddEventHandler('vcpdjob:message', function(token, target, msg)
	if not CheckToken(token, source, "vcpdjob:message") then return end
	TriggerClientEvent('Extasy:showNotification', target, msg)
end)

-- ALERTE LSPD

RegisterServerEvent('TireEntenduServeur')
AddEventHandler('TireEntenduServeur', function(token, gx, gy, gz)
	if not CheckToken(token, source, "TireEntenduServeur") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'vcpd' then
			TriggerClientEvent('TireEntendu', xPlayers[i], gx, gy, gz)
		end
	end
end)


RegisterServerEvent('PriseAppelServeur')
AddEventHandler('PriseAppelServeur', function(token, gx, gy, gz)
	if not CheckToken(token, source, "PriseAppelServeur") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local name = xPlayer.getName(source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'vcpd' then
			TriggerClientEvent('PriseAppel', xPlayers[i], name)
		end
	end
end)



RegisterServerEvent('vcpdjob:requestarrest')
AddEventHandler('vcpdjob:requestarrest', function(token, targetid, playerheading, playerCoords,  playerlocation)
	if not CheckToken(token, source, "vcpdjob:requestarrest") then return end
	_source = source
	TriggerClientEvent('vcpdjob:getarrested', targetid, playerheading, playerCoords, playerlocation)
	TriggerClientEvent('vcpdjob:doarrested', _source)
end)

RegisterServerEvent('vcpdjob:requestrelease')
AddEventHandler('vcpdjob:requestrelease', function(token, targetid, playerheading, playerCoords,  playerlocation)
	if not CheckToken(token, source, "vcpdjob:requestrelease") then return end
	_source = source
	TriggerClientEvent('vcpdjob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
	TriggerClientEvent('vcpdjob:douncuffing', _source)
end)

RegisterServerEvent('vcpd:buyPpa')
AddEventHandler('vcpd:buyPpa', function(token, target, price)
    if not CheckToken(token, source, "vcpd:buyPpa") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer.getBank() >= price then
        xPlayer.removeMoney(price)
        TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~g~Vous avez reçu x1 Permis port d'arme")
		TriggerClientEvent('Extasy:ShowNotification', source, "~g~La personne a reçu x1 Permis port d'arme")
        xPlayer.addInventoryItem("Permis_arme", 1)
    else
        TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
		TriggerClientEvent('Extasy:ShowNotification', source, "~r~La personne n'a pas assez d'argent sur son compte")
	end
end)

RegisterServerEvent('renfort')
AddEventHandler('renfort', function(token, coords, raison)
	if not CheckToken(token, source, "renfort") then return end

	local _source = source
	local _raison = raison
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'vcpd' then
			TriggerClientEvent('renfort:setBlip', xPlayers[i], coords, _raison)
		end
	end
end)

RegisterNetEvent('Extasy_lspd:plainte')
AddEventHandler('Extasy_lspd:plainte', function(token, msg)
	if not CheckToken(token, source, "Extasy_lspd:plainte") then return end

	local _src = source
	sendToDiscordWithSpecialURL("Plaintes en ligne","**Plainte reçue de: __"..GetPlayerName(_src).."__**:\n\n"..msg, 16744192, cfg_vcpd.PlaintesWebhook)
end)

RegisterNetEvent('Extasy_lspd:rdv')
AddEventHandler('Extasy_lspd:rdv', function(token, msg)
	if not CheckToken(token, source, "Extasy_lspd:rdv") then return end

	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, phone_number FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
	local firstname = result[1].firstname
	local lastname  = result[1].lastname
	local phone = result[1].phone_number

	sendToDiscordWithSpecialURL("Demande de rendez-vous","Demande de rendez-vous émise par: __"..firstname.." "..lastname.. "__. Tél: **__"..phone.."__**", 2061822, cfg_vcpd.RdvWebhook)
end)

function sendToDiscordWithSpecialURL (name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "Extasy_lspd",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback('vcpdjob:getFineList', function(source, token, cb, category)
	if not CheckToken(token, source, "vcpdjob:getFineList") then return end

	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('vcpdjob:getArmoryWeapons', function(source, token, cb)
	if not CheckToken(token, source, "vcpdjob:getArmoryWeapons") then return end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_vcpd', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

--[[ESX.RegisterServerCallback('vcpdjob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
		TriggerEvent("over:logsmoicadelete", _source, weaponName, 0)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_vcpd', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)--]]

ESX.RegisterServerCallback('vcpdjob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('vcpdjob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)

			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('vcpdjob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('vcpdjob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end
end)



ESX.RegisterServerCallback('vcpdjob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_vcpd', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('vcpdjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local playerId = source

	-- Did the player ever join?
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)

		-- Is it worth telling all clients to refresh?
		if xPlayer and xPlayer.job.name == 'vcpd' then
			Citizen.Wait(5000)
			TriggerClientEvent('vcpdjob:updateBlip', -1)
		end
	end
end)




































RegisterNetEvent("vcpd:putInVehicle")
AddEventHandler("vcpd:putInVehicle", function(token, target)
    if not CheckToken(token, source, "vcpd:putInVehicle") then return end
	print(target)
    TriggerClientEvent("vcpd:putInVehicle", target)
end)

RegisterNetEvent("vcpd:putOutVehicle")
AddEventHandler("vcpd:putOutVehicle", function(token, target)
    if not CheckToken(token, source, "vcpd:putOutVehicle") then return end
    TriggerClientEvent("vcpd:putOutVehicle", target)
end)

RegisterNetEvent("vcpd:drag")
AddEventHandler("vcpd:drag", function(token, target)
    if not CheckToken(token, source, "vcpd:drag") then return end
    TriggerClientEvent("vcpd:drag", target, source)
end)

RegisterServerEvent('vcpd:sendBilling')
AddEventHandler('vcpd:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "vcpd:sendBilling") then return end
	TriggerEvent("ext:AST", source, "vcpd:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterNetEvent("vcpd:starthandcuff")
AddEventHandler("vcpd:starthandcuff", function(token, target)
    if not CheckToken(token, source, "vcpd:starthandcuff") then return end
    TriggerClientEvent("vcpd:arrest", target, source)
	TriggerClientEvent("vcpd:arrest_source", source)
end)

RegisterNetEvent("vcpd:handcuff")
AddEventHandler("vcpd:handcuff", function(token, target)
    if not CheckToken(token, source, "vcpd:handcuff") then return end

    TriggerClientEvent("vcpd:handcuff", target)
end)

RegisterServerEvent('vcpd:teleportMain')
AddEventHandler('vcpd:teleportMain', function(token, player)
    if not CheckToken(token, source, "vcpd:teleportMain") then return end

    SetEntityCoords(source, 3641.15, 5711.32, 5.45)
end)

RegisterServerEvent('vcpd:teleportLobby')
AddEventHandler('vcpd:teleportLobby', function(token, player)
    if not CheckToken(token, source, "vcpd:teleportLobby") then return end

    SetEntityCoords(source, 3612.15, 5704.68, 11.28)
end)

RegisterServerEvent('vcpd:teleportMainT')
AddEventHandler('vcpd:teleportMainT', function(token, player)
    if not CheckToken(token, source, "vcpd:teleportMainT") then return end

    SetEntityCoords(source, 3644.83, 5724.15, 8.56)
end)

RegisterServerEvent('vcpd:teleportOnTop')
AddEventHandler('vcpd:teleportOnTop', function(token, player)
    if not CheckToken(token, source, "vcpd:teleportOnTop") then return end

    SetEntityCoords(source, 3642.36, 5718.77, 20.53)
end)


ESX.RegisterUsableItem('Herse', function(source)
	TriggerClientEvent('item:useHerse', source)
end)

ESX.RegisterUsableItem('Bouclier', function(source)
	TriggerClientEvent('item:useShield', source)
end)

RegisterServerEvent('vcpd:buyWeapon')
AddEventHandler('vcpd:buyWeapon', function(token, index, price, item, itemLabel)
	if not CheckToken(token, source, "vcpd:buyWeapon") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if index == 1 then
        if xPlayer.getBank() >= price then
            xPlayer.removeAccountMoney('bank',price)
            xPlayer.addInventoryItem(item, 1)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~b~VCPD", "Achat éfféctué", "Vous venez d'acheter ~g~"..itemLabel.."", "CHAR_VCPD")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
        end
    elseif index == 2 then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            xPlayer.addInventoryItem(item, 1)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~b~VCPD", "Achat éfféctué", "Vous venez d'acheter ~g~"..itemLabel.."", "CHAR_VCPD")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
        end
	end
end)

RegisterServerEvent('vcpd:buyEquipment')
AddEventHandler('vcpd:buyEquipment', function(token, index, price, item, itemLabel)
	if not CheckToken(token, source, "vcpd:buyEquipment") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if index == 1 then
        if xPlayer.getBank() >= price then
            xPlayer.removeAccountMoney('bank',price)
            xPlayer.addInventoryItem(item, 1)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~b~VCPD", "Achat éfféctué", "Vous venez d'acheter ~g~"..itemLabel.."", "CHAR_VCPD")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
        end
    elseif index == 2 then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            xPlayer.addInventoryItem(item, 1)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~b~VCPD", "Achat éfféctué", "Vous venez d'acheter ~g~"..itemLabel.."", "CHAR_VCPD")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
        end
	end
end)