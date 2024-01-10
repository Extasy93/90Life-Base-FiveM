ESX              = nil
local Categories = {}
local Vehicles   = {}

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'cardealer', 'client concession', false, false)
TriggerEvent('esx_society:registerSociety', 'cardealer', 'concessionnaire', 'society_cardealer', 'society_cardealer', 'society_cardealer', {type = 'private'})

--[[Citizen.CreateThread(function()
	local char = cfg_concess.PlateLetters
	char = char + cfg_concess.PlateNumbers
	if cfg_concess.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('Extasy_vehicleshop: ^1WARNING^7 plate character count reached, %s/8 characters.'):format(char))
	end
end)--]]

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

RegisterServerEvent('Extasy_vehicleshop:setVehicleOwned93LA6T')
AddEventHandler('Extasy_vehicleshop:setVehicleOwned93LA6T', function(token, vehicleProps, vehicleName)
	if not CheckToken(token, source, "Extasy_vehicleshop:setVehicleOwned93LA6T") then return end

	TriggerEvent("ext:AST", source, "Extasy_vehicleshop:setVehicleOwned93LA6T")

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, vehicleName, isBuyed) VALUES (@owner, @plate, @vehicle, @vehicleName, @isBuyed)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@vehicleName'] = vehicleName,
		['@isBuyed'] = true
	}, function (rowsChanged)
		TriggerClientEvent('Extasy:showNotification', _source, "Le véhicule avec la plaque ~y~" ..vehicleProps.plate.. "~s~ est désormais à ~p~vous !~s~")
	end)
end)

ESX.RegisterServerCallback('Extasy_vehicleshop:buyVehicle', function (source, cb, price)

	TriggerEvent("ext:AST", source, "Extasy_vehicleshop:buyVehicle")

	local xPlayer     = ESX.GetPlayerFromId(source)
	local vehicleData = nil
	local monnaie = 0
		
	if xPlayer.getMoney() >= price then
		cb(true)
	elseif xPlayer.getAccount('bank').money >= price then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('Extasy_vehicleshop:debit')
AddEventHandler('Extasy_vehicleshop:debit', function(token, price)
	if not CheckToken(token, source, "Extasy_vehicleshop:debit") then return end
	TriggerEvent("ext:AST", source, "Extasy_vehicleshop:debit")

	local _source = source
	local xPlayer     = ESX.GetPlayerFromId(_source)

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)
	else
		xPlayer.removeAccountMoney('bank', price)
	end
end)

ESX.RegisterServerCallback('Extasy_vehicleshop:isPlateTaken', function (source, cb, plate)

	TriggerEvent("ext:AST", source, "Extasy_vehicleshop:isPlateTaken")

	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

RegisterServerEvent('AnnounceConcessionnaireOuvert')
AddEventHandler('AnnounceConcessionnaireOuvert', function(token)
	
	if not CheckToken(token, source, "AnnounceConcessionnaireOuvert") then return end

	TriggerEvent("ext:AST", source, "AnnounceConcessionnaireOuvert")

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Concessionnaire', '~b~Annonce Concessionnaire', 'Le Concessionnaire vient d\'ouvrir ! Venez faire vos meillieurs achats !', 'CHAR_CARSITE', 8)
	end
end)

RegisterServerEvent('AnnounceConcessionnaireFerme')
AddEventHandler('AnnounceConcessionnaireFerme', function(token)
	if not CheckToken(token, source, "AnnounceConcessionnaireFerme") then return end

	TriggerEvent("ext:AST", source, "AnnounceConcessionnaireFerme")

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Concessionnaire', '~b~Annonce Concessionnaire', 'Le Concessionnaire vient de fermer, repasser plus tard !', 'CHAR_CARSITE', 8)
	end
end)
