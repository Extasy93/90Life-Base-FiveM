ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('realStateAgency:Save')
AddEventHandler('realStateAgency:Save', function(name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu,playerCreatorName,price)
    local x_source = source

    MySQL.Async.fetchAll("SELECT name FROM properties WHERE name = @name", {

   	   ['@name'] = name,

    }, 
    function(result)
        if result[1] ~= nil then 
       	   TriggerClientEvent('Extasy:ShowNotification', x_source, '~r~Ce nom existe déja')
       	else 
       	   Insert(x_source, name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu,playerCreatorName,price)   
        end 
    end)
end)

Insert = function(x_source, name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, playerCreatorName, price)
    MySQL.Async.execute('INSERT INTO properties (name, label ,entering ,`exit`,inside,outside,ipls,is_single,is_room,is_gateway,room_menu,playerCreatorName,price) VALUES (@name,@label,@entering,@exit,@inside,@outside,@ipls,@isSingle,@isRoom,@isGateway,@roommenu,@playerCreatorName,@price)',
		{
			['@name'] = name,
			['@label'] = label,
			['@entering'] = entering,
			['@exit'] = exit,
			['@inside'] = inside,
			['@outside'] = outside,
			['@ipls'] = ipl,
			['@isSingle'] = isSingle,
			['@isRoom'] = isRoom,
			['@isGateway'] = isGateway,
			['@roommenu'] = roommenu,
			['@playerCreatorName'] = playerCreatorName,
			['@price'] = price,

		}, 
		function (rowsChanged)
			TriggerClientEvent('Extasy:ShowNotification', x_source, '~g~Propriété bien enregistré')
		end
	)
end

ESX.RegisterServerCallback('nehco:getproperties', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local properties = {}

    MySQL.Async.fetchAll('SELECT * FROM properties', {}, 
        function(result)
        for listprop = 1, #result, 1 do
            table.insert(properties, {
				nid = result[listprop].id,
				id = result[listprop].name,
				type = result[listprop].label,
				price = result[listprop].price,
                playerCreatorName = result[listprop].playerCreatorName,
            })
        end
        cb(properties)

    end)
end)

ESX.RegisterServerCallback('nehco:propertiesnehco', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local propertiesnehco = {}

    MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, 
        function(result)
        for listprop = 1, #result, 1 do
            table.insert(propertiesnehco, {
				nid = result[listprop].id,
				id = result[listprop].name,
				type = result[listprop].label,
				price = result[listprop].price,
				player = result[listprop].owner,
            })
        end
        cb(propertiesnehco)

    end)
end)

RegisterServerEvent('nehco:supprimerprop')
AddEventHandler('nehco:supprimerprop', function(supprimer)
    MySQL.Async.execute('DELETE FROM properties WHERE id = @id', {
            ['@id'] = supprimer
    })
end)

RegisterServerEvent('nehco:supprimerprop2')
AddEventHandler('nehco:supprimerprop2', function(supprimer)
    MySQL.Async.execute('DELETE FROM owned_properties WHERE id = @id', {
            ['@id'] = supprimer
    })
end)


RegisterServerEvent('AgenceImmo:Ouverte')
AddEventHandler('AgenceImmo:Ouverte', function(args)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Agence Immobilière', 'Annonce', 'L\'Agence Immobilière est ~b~Ouverte ~s~!', 'CHAR_BRYONY', 1)
	end
end)

RegisterServerEvent('AgenceImmo:Fermer')
AddEventHandler('AgenceImmo:Fermer', function(args)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Agence Immobilière', 'Annonce', 'L\'Agence Immobilière est ~b~Fermer ~s~!', 'CHAR_BRYONY', 1)
	end
end)

RegisterServerEvent('AgenceImmo:Annonce')
AddEventHandler('AgenceImmo:Annonce', function(result)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Agence Immobilière', 'Annonce', result, 'CHAR_BRYONY', 1)
	end
end)












function GetProperty(name)
	for i=1, #cfg_prorerty.Properties, 1 do
		if cfg_prorerty.Properties[i].name == name then
			return cfg_prorerty.Properties[i]
		end
	end
end

function SetPropertyOwned(name, price, rented, owner)
	MySQL.Async.execute('INSERT INTO owned_properties (name, price, rented, owner) VALUES (@name, @price, @rented, @owner)', {
		['@name']   = name,
		['@price']  = price,
		['@rented'] = (rented and 1 or 0),
		['@owner']  = owner
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('esx_property:setPropertyOwned', xPlayer.source, name, true, rented)

			if rented then
				TriggerClientEvent("Extasy:ShowNotification", source, 'louer pour ' ..ESX.Math.GroupDigits(price))
			else
				print('Nehco test')
			end
		end
	end)
end

function RemoveOwnedProperty(name, owner, noPay)
	MySQL.Async.fetchAll('SELECT id, rented, price FROM owned_properties WHERE name = @name AND owner = @owner', {
		['@name']  = name,
		['@owner'] = owner
	}, function(result)
		if result[1] then
			MySQL.Async.execute('DELETE FROM owned_properties WHERE id = @id', {
				['@id'] = result[1].id
			}, function(rowsChanged)
				local xPlayer = ESX.GetPlayerFromIdentifier(owner)

				if xPlayer then
					xPlayer.triggerEvent('esx_property:setPropertyOwned', name, false)

					if not noPay then
						if result[1].rented == 1 then
							TriggerClientEvent("Extasy:ShowNotification", source, 'sortie ')
						else
							local sellPrice = ESX.Math.Round(result[1].price / cfg_prorerty.SellModifier)

							TriggerClientEvent("Extasy:ShowNotification", source, 'sortie' ..ESX.Math.GroupDigits(sellPrice))
							xPlayer.addAccountMoney('bank', sellPrice)
						end
					end
				end
			end)
		end
	end)
end

MySQL.ready(function()
	Citizen.Wait(1500)

	MySQL.Async.fetchAll('SELECT * FROM properties', {}, function(properties)

		for i=1, #properties, 1 do
			local entering  = nil
			local exit      = nil
			local inside    = nil
			local outside   = nil
			local isSingle  = nil
			local isRoom    = nil
			local isGateway = nil
			local roomMenu  = nil
			local garage    = nil 

			if properties[i].entering then
				entering = json.decode(properties[i].entering)
			end

			if properties[i].exit then
				exit = json.decode(properties[i].exit)
			end

			if properties[i].inside then
				inside = json.decode(properties[i].inside)
			end

			if properties[i].outside then
				outside = json.decode(properties[i].outside)
			end

			if properties[i].is_single == 0 then
				isSingle = false
			else
				isSingle = true
			end

			if properties[i].is_room == 0 then
				isRoom = false
			else
				isRoom = true
			end

			if properties[i].is_gateway == 0 then
				isGateway = false
			else
				isGateway = true
			end

			if properties[i].room_menu then
				roomMenu = json.decode(properties[i].room_menu)
			end

			if properties[i].garage ~= nil then
		       garage = json.decode(properties[i].garage)
		    end


			table.insert(cfg_prorerty.Properties, {
				name      = properties[i].name,
				label     = properties[i].label,
				entering  = entering,
				exit      = exit,
				inside    = inside,
				outside   = outside,
				ipls      = json.decode(properties[i].ipls),
				gateway   = properties[i].gateway,
				isSingle  = isSingle,
				isRoom    = isRoom,
				isGateway = isGateway,
				roomMenu  = roomMenu,
				garage    = garage,
				price     = properties[i].price
			})
		end

		TriggerClientEvent('esx_property:sendProperties', -1, cfg_prorerty.Properties)
	end)
end)

ESX.RegisterServerCallback('esx_property:getProperties', function(source, cb)
	cb(cfg_prorerty.Properties)
end)

AddEventHandler('esx_ownedproperty:getOwnedProperties', function(cb)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties', {}, function(result)
		local properties = {}

		for i=1, #result, 1 do
			table.insert(properties, {
				id     = result[i].id,
				name   = result[i].name,
				label  = GetProperty(result[i].name).label,
				price  = result[i].price,
				rented = (result[i].rented == 1 and true or false),
				owner  = result[i].owner
			})
		end

		cb(properties)
	end)
end)

AddEventHandler('esx_property:setPropertyOwned', function(name, price, rented, owner)
	SetPropertyOwned(name, price, rented, owner)
end)

AddEventHandler('esx_property:removeOwnedProperty', function(name, owner)
	RemoveOwnedProperty(name, owner)
end)

RegisterNetEvent('esx_property:rentProperty')
AddEventHandler('esx_property:rentProperty', function(propertyName)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)
	local rent     = ESX.Math.Round(property.price / cfg_prorerty.RentModifier)

	SetPropertyOwned(propertyName, rent, true, xPlayer.identifier)
end)

RegisterServerEvent('OsirisProperty:buyProperty')
AddEventHandler('OsirisProperty:buyProperty', function(token, propertyName)
	if not CheckToken(token, source, "OsirisProperty:buyProperty") then return end
	local xPlayer  = ESX.GetPlayerFromId(source)
	local property = GetProperty(propertyName)

	if property.price <= xPlayer.getMoney() then
		TriggerEvent('eAddonaccount:getSharedAccount', 'society_AgentImmo', function(account)
			societyAccount = account
		end)

		if societyAccount ~= nil then
			societyAccount.addMoney(property.price*25 / 100) -- 25% du prix de base
			TriggerClientEvent('Extasy:ShowNotification', source, 'la sociétée de l\'agence immobilière reçois ~g~+'..property.price*25 / 100)
		end

		xPlayer.removeMoney(property.price)
		SetPropertyOwned(propertyName, property.price, false, xPlayer.identifier)
	else
		TriggerClientEvent('Extasy:ShowNotification', source, 'vous n\'avez pas assez d\'argent')
	end
end)

RegisterNetEvent('esx_property:removeOwnedProperty')
AddEventHandler('esx_property:removeOwnedProperty', function(propertyName)
	local xPlayer = ESX.GetPlayerFromId(source)
	RemoveOwnedProperty(propertyName, xPlayer.identifier)
end)

AddEventHandler('esx_property:removeOwnedPropertyIdentifier', function(propertyName, identifier)
	RemoveOwnedProperty(propertyName, identifier)
end)

RegisterNetEvent('esx_property:saveLastProperty')
AddEventHandler('esx_property:saveLastProperty', function(property)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = @last_property WHERE identifier = @identifier', {
		['@last_property'] = property,
		['@identifier']    = xPlayer.identifier
	})
end)

RegisterNetEvent('esx_property:deleteLastProperty')
AddEventHandler('esx_property:deleteLastProperty', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET last_property = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterNetEvent('esx_property:getItem')
AddEventHandler('esx_property:getItem', function(type, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	if type == 'item_standard' then
		TriggerEvent('eAddoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)
			if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(item, count)
				xPlayer.addInventoryItem(item, count)
				TriggerClientEvent("Extasy:ShowNotification", source, 'tu a retirer : ' ..count.. ' x ' ..inventoryItem.label)
			else
				TriggerClientEvent("Extasy:ShowNotification", source, 'pas assez dans la propriter')
			end
		end)
	elseif type == 'item_account' then
		TriggerEvent('eAddoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)
			if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(item, count)
				xPlayer.addInventoryItem(item, count)
				TriggerClientEvent("Extasy:ShowNotification", source, 'tu a retirer : ' ..count.. ' x ' ..inventoryItem.label)
			else
				TriggerClientEvent("Extasy:ShowNotification", source, 'pas assez dans la propriter')
			end
		end)
	elseif type == 'item_weapon' then
		if xPlayer.hasWeapon(item) then
			xPlayer.removeWeapon(item)

			TriggerEvent('eDatastore:getDataStore', token, 'property', xPlayerOwner.identifier, function(store)
				local storeWeapons = store.get('weapons') or {}

				table.insert(storeWeapons, {
					name = item,
					ammo = count
				})

				store.set('weapons', storeWeapons)
			end)
		end
	end
end)

RegisterNetEvent('esx_property:putItem')
AddEventHandler('esx_property:putItem', function(type, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(source)
	
	print(item)
	print(count)
	if type == 'item_standard' then
		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('eAddoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				xPlayer.showNotification('Tu a deposer : ' ..count.. '' ..inventory.getItem(item).label)
			end)
		else
			xPlayer.showNotification('invalid_quantity')
		end
	end
end)

ESX.RegisterServerCallback('esx_property:getOwnedProperties', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT name, rented FROM owned_properties WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(result)
		cb(result)
	end)
end)

ESX.RegisterServerCallback('esx_property:getLastProperty', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_property FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_property)
	end)
end)
ESX.RegisterServerCallback('esx_property:getPropertyInventory', function(source, cb, owner)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(source)
	local blackMoney = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('eAddonaccount:getAccount', 'property_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('eAddoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('property:getPlayerInventory', function(source, cb)
	local xPlayer      = ESX.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount('black_money').money
	local items = xPlayer.inventory
	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = xPlayer.getLoadout()
	})
end)

ESX.RegisterServerCallback('property:getStockItems', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local blackMoney = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('eAddonaccount:getAccount', 'property_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('eAddoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)


	cb({
		blackMoney = blackMoney,
		items      = items,
		weapons    = weapons
	})
end)

RegisterServerEvent('property:getStockItem')
AddEventHandler('property:getStockItem', function(token, type, itemName, count, name, ammo)
	if not CheckToken(token, source, "property:getStockItem") then return end
		local _source = source
		local xPlayer  = ESX.GetPlayerFromId(source)
		local sourceItem = xPlayer.getInventoryItem(itemName)
	if type == 'item_standard' then
		TriggerEvent('eAddoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
			local inventoryItem = inventory.getItem(itemName)
	
			if count > 0 and inventoryItem.count >= count then
				if true then
					inventory.removeItem(itemName, count)
					xPlayer.addInventoryItem(itemName, count)
					TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, '~g~[COFFRE] :\n~b~Retrait : ~s~'..count..' '..inventoryItem.label..'')			

				else
					TriggerClientEvent('Extasy:ShowNotification', _source, 'Quantité Invalide')
				end
			else
				TriggerClientEvent('Extasy:ShowNotification', _source, 'Quantité Invalide')
			end
		end)
	end
end)



RegisterServerEvent('property:putStockItems')
AddEventHandler('property:putStockItems', function(token, type, itemName, count)
	if not CheckToken(token, source, "property:putStockItems") then return end
	local _source = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	if type == 'item_standard' then
		TriggerEvent('eAddoninventory:getInventory', 'property', xPlayer.identifier, function(inventory)
			local inventoryItem = inventory.getItem(itemName)

			if sourceItem.count >= count and count > 0 then
				xPlayer.removeInventoryItem(itemName, count)
				inventory.addItem(itemName, count)
				TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, '~g~[COFFRE] :\n~b~Dépot : ~s~'..count..' '..inventoryItem.label..'')			
			else
				TriggerClientEvent('Extasy:ShowNotification', _source, '~r~Quantité Invalide')
			end
		end)	
	end
end)

ESX.RegisterServerCallback('Osiris:GetTenuesProperty', function(source, cb, _)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll(
		'SELECT * FROM user_tenue WHERE identifier = @identifier',
		{
      ['@identifier'] = xPlayer.identifier
		},
    function(result)
			cb(result)
		end
	)
end)

function RemoveOwnedProperty(name, owner)
	MySQL.Async.execute('DELETE FROM owned_properties WHERE name = @name AND owner = @owner', {
		['@name']  = name,
		['@owner'] = owner
	}, function(rowsChanged)
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if xPlayer then
			TriggerClientEvent('OsirisProperty:setPropertyOwned', xPlayer.source, name, false)
			TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, 'vous avez rendu une propriété')
		end
	end)
end

AddEventHandler('OsirisProperty:removeOwnedProperty', function(token, name, owner)
	if not CheckToken(token, source, "OsirisProperty:removeOwnedProperty") then return end
	RemoveOwnedProperty(name, owner)
end)

RegisterServerEvent('OsirisProperty:removeOwnedProperty')
AddEventHandler('OsirisProperty:removeOwnedProperty', function(token, propertyName)
	if not CheckToken(token, source, "OsirisProperty:removeOwnedProperty") then return end
	local xPlayer  = ESX.GetPlayerFromId(source)
	RemoveOwnedProperty(propertyName, xPlayer.identifier)
end)

AddEventHandler('OsirisProperty:removeOwnedPropertyIdentifier', function(token, propertyName, identifier)
	if not CheckToken(token, source, "OsirisProperty:removeOwnedPropertyIdentifier") then return end
	RemoveOwnedProperty(propertyName, identifier)
end)






function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM owned_properties WHERE rented = 1', {}, function (result)
		for i=1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)

			-- message player if connected
			if xPlayer then
				xPlayer.removeAccountMoney('bank', result[i].price)
				TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, 'vous avez ~g~payé~s~ votre loyer:' ..ESX.Math.GroupDigits(result[i].price).. '~g~$~w~' )
			else -- pay rent either way
				MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE identifier = @identifier', {
					['@bank']       = result[i].price,
					['@identifier'] = result[i].owner
				})
			end

			TriggerEvent('eAddonaccount:getSharedAccount', 'society_AgentImmo', function(account)
				societyAccount = account
			end)
			if societyAccount ~= nil then
				societyAccount.addMoney(result[i].price)
			end
		end
	end)
end

TriggerEvent('cron:runAt', token, 22, 0, PayRent)

-- Garage 

RegisterServerEvent('esx_property:setParking')
AddEventHandler('esx_property:setParking', function(plate, name, zone, vehicleProps)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
  
  if vehicleProps ~= false then

    MySQL.Async.fetchAll("SELECT plate FROM owned_vehicles WHERE owner=@identifier AND plate =@plate",
      {
        ['@identifier'] = xPlayer.identifier,
        ['@plate'] = plate
      }, 
      function(result)
        if result[1] ~= nil then 
          print(result[1].plate)
          Insert(_source, plate, name, zone, vehicleProps)
        else
          TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, 'Ce véhicule n\'est pas le votre')  
        end 
      end
    )
  end   
end)

ESX.RegisterServerCallback('Property:addincoffreWeapon', function(source, cb, weaponName, removeWeapon)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
		TriggerEvent("over:logsmoicadelete", _source, weaponName, 0)
	end

	TriggerEvent('eDatastore:getDataStore', 'property', xPlayer.identifier, function(store)
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

ESX.RegisterServerCallback('Property:remouveincoffreWeapon', function(source, cb, weaponName)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, weaponName, 500, "Coffre Maison")

	TriggerEvent('eDatastore:getDataStore', 'property', xPlayer.identifier, function(store)

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


