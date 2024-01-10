ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'bikeshop', 'bikeshop', 'society_bikeshop', 'society_bikeshop', 'society_bikeshop', {type = 'private'})

RegisterServerEvent('bikeshop:setupBilling')
AddEventHandler('bikeshop:setupBilling', function(token, reason, price, society, buyer, action, execute, deduce, isForce, hash, name)
	if not CheckToken(token, source, "bikeshop:setupBilling") then return end
	TriggerEvent("ext:AST", source, "bikeshop:setupBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute, deduce, isForce, hash, name)
    SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('bikeshop:processVehicle')
AddEventHandler('bikeshop:processVehicle', function(token, buyer, plate, properties, name)
	if not CheckToken(token, source, "bikeshop:processVehicle") then return end
	TriggerEvent("ext:AST", source, "bikeshop:processVehicle")

	local xPlayer = ESX.GetPlayerFromId(buyer)

    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, vehicleName, type, isBuyed, state) VALUES (@owner, @plate, @vehicle, @vehicleName, @type, @isBuyed, @state)',
    {
        ['@owner']          = xPlayer.identifier,
        ['@plate']          = plate,
        ['@vehicle']        = json.encode(properties),
        ['@vehicleName']    = name,
        ['@state']          = 1,
        ['@type']           = "car",
        ['@isBuyed']        = true

    }, function (rowsChanged)
        TriggerClientEvent('Extasy:showNotification', buyer, "Le véhicule avec la plaque ~y~" ..plate.. "~s~ est désormais à ~p~vous !~s~")
    end)
    SendLog("``Le joueur ["..source.."] "..GetPlayerName(source).." à vendu le véhicule (Moto) "..name.." à ["..tonumber(buyer).."] "..GetPlayerName(tonumber(buyer)).."``", "concess")
end)

RegisterServerEvent('bikeshop:takeStockItem')
AddEventHandler('bikeshop:takeStockItem', function(token, itemName, count, societe)
	if not CheckToken(token, source, "bikeshop:takeStockItem") then return end
    local _source = sourcebikeshop
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('eAddoninventory:getSharedInventory', 'society_bikeshop', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- is there enough in the society?
        if count > 0 and inventoryItem.count >= count then

            inventory.removeItem(itemName, count)
            xPlayer.addInventoryItem(itemName, count)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Concessionnaire moto", "Coffre", "Vous venez de retirer ~g~x"..count.." "..inventoryItem.label, "CHAR_BIKESHOP")
        else
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Concessionnaire moto", "Coffre", "~r~Quantité invalide", "CHAR_BIKESHOP")
        end
    end)
end)

RegisterNetEvent('bikeshop:DepositStockItem')
AddEventHandler('bikeshop:DepositStockItem', function(token, itemName, count, societe)
	if not CheckToken(token, source, "bikeshop:DepositStockItem") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('eAddoninventory:getSharedInventory', 'society_bikshop', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- does the player have enough of the item?
        if sourceItem.count >= count and count > 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Concessionnaire moto", "Coffre", "Vous venez de déposer ~g~x"..count.." "..inventoryItem.label, "CHAR_BIKESHOP")
        else
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Concessionnaire moto", "Coffre", "~r~Quantité invalide", "CHAR_BIKESHOP")
        end
    end)
end)

ESX.RegisterServerCallback('bikeshop:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
end)

ESX.RegisterServerCallback('bikeshop:getSharedInventory', function(source, cb, societe)
    TriggerEvent('eAddoninventory:getSharedInventory', 'society_bikeshop', function(inventory)
        cb(inventory.items)
    end)
end)