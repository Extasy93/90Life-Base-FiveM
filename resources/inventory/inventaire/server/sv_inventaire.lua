ESX = nil

TriggerEvent("ext:getSharedObject", function(obj) ESX = obj end)

ESX.RegisterServerCallback("esx_inventoryhud:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil then
		cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout, weight = targetXPlayer.getWeight(), maxWeight = targetXPlayer.maxWeight})
	else
		cb(nil)
	end
end)

RegisterServerEvent('Extasy:sendAllMasksFromPlayerInv')
AddEventHandler('Extasy:sendAllMasksFromPlayerInv', function()
    local FinalResult = {}
    local player
	local _source = source
	
	for k,v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	MySQL.Async.fetchAll('SELECT * FROM player_masks WHERE identifier = @identifier',
      {
        ['@identifier'] = player
      },
      function(result)
		for _,v in pairs(result) do
			d = json.decode(v.data)
            table.insert(FinalResult, {
				id   	 	= v.id,
				identifier  = v.identifier,
				data      	= d,
				label   	= v.label
            })
			TriggerClientEvent("Extasy:sendMasksData", _source, FinalResult)
        end
    end)
end)

RegisterServerEvent('Extasy:sendAllClothesFromPlayerInv')
AddEventHandler('Extasy:sendAllClothesFromPlayerInv', function()
    local FinalResult = {}
    local player
	local _source = source
	
	for k,v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	MySQL.Async.fetchAll('SELECT * FROM player_clothes WHERE identifier = @identifier', {
        ['@identifier'] = player
      },
      function(result)
		for _,v in pairs(result) do
			d = json.decode(v.data)
            table.insert(FinalResult, {
				id   	 	= v.id,
				identifier  = v.identifier,
				data      	= d,
				label   	= v.label
            })
			TriggerClientEvent("Extasy:sendClothesData", _source, FinalResult)
        end
    end)
end)

RegisterServerEvent('Extasy:getPlayerIdentityInv')
AddEventHandler('Extasy:getPlayerIdentityInv', function()
	local _source = source
    local MyIdentityData = {}
    local player
	
	for k,v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = player}, function(result)
        for _, v in pairs(result) do
            MyIdentityData = {
				prenom   = v.firstname,
				nom      = v.lastname,
				age      = v.age,
				sexe     = v.sex,
				taille   = v.height,
			}
        end
		TriggerClientEvent("Extasy:sendIdentityData", _source, MyIdentityData)
    end)
end)

RegisterServerEvent('Extasy:updateNameForThisMaskInv')
AddEventHandler('Extasy:updateNameForThisMaskInv', function(id, newName)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local FinalResult = {}

    MySQL.Async.execute('UPDATE player_masks SET label = @label WHERE id = @id', {
		['@id'] = id,
		['@label'] = newName
	}, function()
	end)

	MySQL.Async.fetchAll('SELECT * FROM player_masks WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.identifier
      },
      function(result)
		for _,v in pairs(result) do
			d = json.decode(v.data)
            table.insert(FinalResult, {
				id   	 	= v.id,
				identifier  = v.identifier,
				data      	= d,
				label   	= v.label
            })
			TriggerClientEvent("Extasy:sendMasksData", _source, FinalResult)
        end
    end)
end)

RegisterServerEvent('Extasy:deleteThisMaskInv')
AddEventHandler('Extasy:deleteThisMaskInv', function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local FinalResult = {}

    MySQL.Async.execute('DELETE FROM player_masks WHERE id = @id', {
		['@id'] = id
	}, function()
	end)

	MySQL.Async.fetchAll('SELECT * FROM player_masks WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.identifier
      },
      function(result)
		for _,v in pairs(result) do
			d = json.decode(v.data)
            table.insert(FinalResult, {
				id   	 	= v.id,
				identifier  = v.identifier,
				data      	= d,
				label   	= v.label
            })
			TriggerClientEvent("Extasy:sendMasksData", _source, FinalResult)
        end
    end)
end)

RegisterServerEvent('Extasy:deleteThisClothesInv')
AddEventHandler('Extasy:deleteThisClothesInv', function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local FinalResult = {}

    MySQL.Async.execute('DELETE FROM player_clothes WHERE id = @id', {
		['@id'] = id
	}, function()
	end)

	MySQL.Async.fetchAll('SELECT * FROM player_clothes WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.identifier
      },
      function(result)
		for _,v in pairs(result) do
			d = json.decode(v.data)
            table.insert(FinalResult, {
				id   	 	= v.id,
				identifier  = v.identifier,
				data      	= d,
				label   	= v.label
            })
			TriggerClientEvent("Extasy:sendClothesData", _source, FinalResult)
        end
    end)
end)

RegisterServerEvent('Extasy:updateUserForThisClothesInv')
AddEventHandler('Extasy:updateUserForThisClothesInv', function(id, newUser, type)
    local xPlayer = ESX.GetPlayerFromId(newUser)
	local sourcePlayer = ESX.GetPlayerFromId(source)
    local FinalResult = {}

	if type == "item_tenue" then
		MySQL.Async.execute('UPDATE player_clothes SET identifier = @identifier WHERE id = @id', {
			['@id'] = id,
			['@identifier'] = xPlayer.identifier
		}, function()
		end)

		MySQL.Async.fetchAll('SELECT * FROM player_clothes WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)
			for _,v in pairs(result) do
				d = json.decode(v.data)
				table.insert(FinalResult, {
					id   	 	= v.id,
					identifier  = v.identifier,
					data      	= d,
					label   	= v.label
				})
				TriggerClientEvent("Extasy:sendClothesData", xPlayer.source, FinalResult)
			end
		end)

		MySQL.Async.fetchAll('SELECT * FROM player_clothes WHERE identifier = @identifier',
		{
			['@identifier'] = sourcePlayer.identifier
		},
		function(result)
			for _,v in pairs(result) do
				d = json.decode(v.data)
				table.insert(FinalResult, {
					id   	 	= v.id,
					identifier  = v.identifier,
					data      	= d,
					label   	= v.label
				})
				TriggerClientEvent("Extasy:sendClothesData", sourcePlayer.source, FinalResult)
			end
		end)
	else
		MySQL.Async.execute('UPDATE player_masks SET identifier = @identifier WHERE id = @id', {
			['@id'] = id,
			['@identifier'] = xPlayer.identifier
		}, function()
		end)

		MySQL.Async.fetchAll('SELECT * FROM player_masks WHERE identifier = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)
			for _,v in pairs(result) do
				d = json.decode(v.data)
				table.insert(FinalResult, {
					id   	 	= v.id,
					identifier  = v.identifier,
					data      	= d,
					label   	= v.label
				})
				TriggerClientEvent("Extasy:sendMasksData", xPlayer.source, FinalResult)
			end
		end)

		MySQL.Async.fetchAll('SELECT * FROM player_masks WHERE identifier = @identifier',
		{
			['@identifier'] = sourcePlayer.identifier
		},
		function(result)
			for _,v in pairs(result) do
				d = json.decode(v.data)
				table.insert(FinalResult, {
					id   	 	= v.id,
					identifier  = v.identifier,
					data      	= d,
					label   	= v.label
				})
				TriggerClientEvent("Extasy:sendMasksData", source, FinalResult)
			end
		end)
	end
end)

RegisterServerEvent("esx_inventoryhud:tradePlayerItem")
AddEventHandler("esx_inventoryhud:tradePlayerItem",	function(from, target, type, itemName, itemCount)
	local _source = from

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if type == "item_standard" then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if targetXPlayer.canCarryItem(itemName, itemCount) then

				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem(itemName, itemCount)
			else
				sourceXPlayer.showNotification('~r~Impossible~s~l\'inventaire de l\'individu est plein.')
			end
		end
	elseif type == "item_money" then
		if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney(itemCount)
		end
	elseif type == "item_account" then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney(itemName, itemCount)
		end
	elseif type == "item_weapon" then
		if not targetXPlayer.hasWeapon(itemName) then
			sourceXPlayer.removeWeapon(itemName)
			targetXPlayer.addWeapon(itemName, itemCount)
		end
	end
end)

RegisterCommand("openinventory", function(source, args, rawCommand)
	local target = tonumber(args[1])
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil then
		TriggerClientEvent("esx_inventoryhud:openPlayerInventory", source, target, targetXPlayer.name)
	end
end)

RegisterServerEvent(Shared.prefix.."getgps")
AddEventHandler(Shared.prefix.."getgps", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local  getgpsinventory = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "gps" then
            getgpsinventory = item.count
		end
	end
    
    if getgpsinventory > 0 then
		TriggerClientEvent(Shared.prefix.."addgps", _source)
    end
end)

RegisterNetEvent('blockcontrol')
AddEventHandler('blockcontrol', function(target)

	TriggerClientEvent('esx_inventoryhud:blockcontrol1', target, source)
	TriggerClientEvent('esx_inventoryhud:blockcontrol', target, source)
end)

RegisterNetEvent('debloqueontrol')
AddEventHandler('debloqueontrol', function(target)
	TriggerClientEvent('esx_inventoryhud:debloqueontrol', target, source)
end)

RegisterServerEvent('identity:showToPlayerInv')
AddEventHandler('identity:showToPlayerInv', function(player, playerShowIdentity)
    TriggerClientEvent('Inventory:ShowAdvancedNotification', player, "Carte d'identité", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age.."\n~p~Taille: ~s~"..playerShowIdentity.taille.."\n~p~Sexe: ~s~"..playerShowIdentity.sexe, "CHAR_PREF")
end)

RegisterServerEvent('car_licence:showToPlayerInv')
AddEventHandler('car_licence:showToPlayerInv', function(player, playerShowIdentity)
    TriggerClientEvent('Inventory:ShowAdvancedNotification', player, "Permis de conduire (voiture)", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age, "CHAR_PREF")
end)

RegisterServerEvent('bike_licence:showToPlayerInv')
AddEventHandler('bike_licence:showToPlayerInv', function(player, playerShowIdentity)
    TriggerClientEvent('Inventory:ShowAdvancedNotification', player, "Permis de conduire (moto)", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age, "CHAR_PREF")
end)

RegisterServerEvent('truck_licence:showToPlayerInv')
AddEventHandler('truck_licence:showToPlayerInv', function(player, playerShowIdentity)
    TriggerClientEvent('Inventory:ShowAdvancedNotification', player, "Permis de conduire (camion)", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age, "CHAR_PREF")
end)

RegisterServerEvent('boat_licence:showToPlayerInv')
AddEventHandler('boat_licence:showToPlayerInv', function(player, playerShowIdentity)
    TriggerClientEvent('Inventory:ShowAdvancedNotification', player, "Permis de conduire (bateau)", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age, "CHAR_PREF")
end)

RegisterServerEvent('license_ppa:showToPlayerInv')
AddEventHandler('license_ppa:showToPlayerInv', function(player, playerShowIdentity)
    TriggerClientEvent('Inventory:ShowAdvancedNotification', player, "Permis port d'arme", "Préfecture", "~p~Prénom: ~s~"..playerShowIdentity.prenom.."\n~p~Nom: ~s~"..playerShowIdentity.nom.."\n~p~Âge: ~s~"..playerShowIdentity.age, "CHAR_PREF")
end)

CreateThread(function()
    Wait(0)
    MySQL.Async.fetchAll('SELECT * FROM items WHERE LCASE(name) LIKE \'%weapon_%\'', {}, function(results)
        for k, v in pairs(results) do
            ESX.RegisterUsableItem(v.name, function(source)
                TriggerClientEvent('WeaponItem:useWeapon', source, v.name)
            end)
        end
    end)
end)

RegisterServerEvent('WeaponItem:updateAmmoCount')
AddEventHandler('WeaponItem:updateAmmoCount', function(hash, count)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE ammo_weapons SET count = @count WHERE hash = @hash AND owner = @owner', {
        ['@owner'] = player.identifier,
        ['@hash'] = hash,
        ['@count'] = count
    }, function(results)
        if results == 0 then
            MySQL.Async.execute('INSERT INTO ammo_weapons (owner, hash, count) VALUES (@owner, @hash, @count)', {
                ['@owner'] = player.identifier,
                ['@hash'] = hash,
                ['@count'] = count
            })
        end
    end)
end)

ESX.RegisterServerCallback('WeaponItem:getAmmoCount', function(source, cb, hash)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM ammo_weapons WHERE owner = @owner and hash = @hash', {
        ['@owner'] = player.identifier,
        ['@hash'] = hash
    }, function(results)
        if #results == 0 then
            cb(nil)
        else
            cb(results[1].count)
        end
    end)
end)

ESX.RegisterServerCallback('disc-base:takePlayerItem', function(source, cb, item, count)
	local player = ESX.GetPlayerFromId(source)
	local invItem = player.getInventoryItem(item)
	if invItem.count - count < 0 then
		cb(false)
	else
		player.removeInventoryItem(item, count)
		cb(true)
	end
end)

---- Ammo ----

CreateThread(function()
    Wait(0)
    for k, v in pairs(Shared.Ammo) do
        ESX.RegisterUsableItem(v.name, function(source)
            TriggerClientEvent('UseAmmo', source, v)
        end)
    end
end)

RegisterServerEvent('RemoveAmmo')
AddEventHandler('RemoveAmmo', function(ammo)
    local player = ESX.GetPlayerFromId(source)
    player.removeInventoryItem(ammo.name, 1)
end)

ESX.RegisterUsableItem("CarteID", function(source)
end)

ESX.RegisterUsableItem("Permis_bateau", function(source)
end)

ESX.RegisterUsableItem("Permis_arme", function(source)
end)

ESX.RegisterUsableItem("Permis_camion", function(source)
end)

ESX.RegisterUsableItem("Permis_chasse", function(source)
end)

ESX.RegisterUsableItem("Permis_moto", function(source)
end)

ESX.RegisterUsableItem("Permis_voiture", function(source)
end)