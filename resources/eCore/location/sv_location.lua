ESX = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Extasy:BuyLocationCar', function (source, cb, price)
	TriggerEvent("ext:AST", source, "Extasy:BuyLocationCar")
	local xPlayer     = ESX.GetPlayerFromId(source)
	
	if xPlayer.getMoney() >= price then
		cb(true)
	elseif xPlayer.getAccount('bank').money >= price then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('carlock:location')
AddEventHandler('carlock:location', function(token, plate)
	if not CheckToken(token, source, "carlock:location") then return end
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('REPLACE INTO owned_rented (`identifier`, `plate`) VALUES (@owner, @plate)', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	})
	--print('REPLACE INTO owned_rented (`identifier`, `plate`) VALUES ('.. xPlayer.identifier ..', '.. plate ..')')
	--TriggerClientEvent('Extasy:showNotification', source, '~y~Tu as les clés de ce véhicule de location, tu peux le verrouiller ! :)')
	TriggerClientEvent('Extasy:ShowAdvancedNotification', source, '90\'s Life', '~y~Clés', 'Vous avez recu un double de clés ', 'CHAR_HAO', 7)
end)

ESX.RegisterServerCallback('carlock:isVehicleOwner', function(source, cb, plate, idowner)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier

	--print('SELECT owner FROM owned_vehicles WHERE owner = "'..identifier..'" AND plate = "'..plate..'" UNION SELECT identifier FROM owned_rented  WHERE identifier = "'..identifier..'" AND plate = "'..plate..'"')
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate UNION SELECT identifier FROM owned_rented  WHERE identifier = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			--if idowner == source then
			--	cb(true)
			--else
				cb(false)
			--end
		end
	end)
end)