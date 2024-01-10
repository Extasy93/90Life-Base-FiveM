ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'boatshop', 'boatshop', 'society_boatshop', 'society_boatshop', 'society_boatshop', {type = 'private'})

RegisterServerEvent('boatshop:setupBilling')
AddEventHandler('boatshop:setupBilling', function(token, reason, price, society, buyer, action, execute, deduce, isForce, hash, name)
	if not CheckToken(token, source, "boatshop:setupBilling") then return end
	TriggerEvent("ext:AST", source, "boatshop:setupBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute, deduce, isForce, hash, name)
    SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('boatshop:processVehicle')
AddEventHandler('boatshop:processVehicle', function(token, buyer, plate, properties, name)
	if not CheckToken(token, source, "boatshop:processVehicle") then return end
	TriggerEvent("ext:AST", source, "boatshop:processVehicle")

	local xPlayer = ESX.GetPlayerFromId(buyer)

    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, vehicleName, type, isBuyed, state) VALUES (@owner, @plate, @vehicle, @vehicleName, @type, @isBuyed, @state)',
    {
        ['@owner']          = xPlayer.identifier,
        ['@plate']          = plate,
        ['@vehicle']        = json.encode(properties),
        ['@vehicleName']    = name,
        ['@state']          = 1,
        ['@type']           = "boat",
        ['@isBuyed']        = true

    }, function (rowsChanged)
        TriggerClientEvent('Extasy:showNotification', buyer, "Le véhicule avec la plaque ~y~" ..plate.. "~s~ est désormais à ~p~vous !~s~")
    end)
    SendLog("``Le joueur ["..source.."] "..GetPlayerName(source).." à vendu le véhicule (Bateau) "..name.." à ["..tonumber(buyer).."] "..GetPlayerName(tonumber(buyer)).."``", "concess")
end)