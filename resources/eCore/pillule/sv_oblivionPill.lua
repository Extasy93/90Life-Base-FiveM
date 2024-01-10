ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('piluleoubli', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('OblivionPill:piluleoubli', source)
	xPlayer.removeInventoryItem('piluleoubli', 1)
	TriggerClientEvent('Extasy:showNotification', source, 'Vous prenez une ~b~pilule de l\'oubli~w~.')
	Citizen.Wait(180000)
	TriggerClientEvent('OblivionPill:stoppill', source)
end)

ESX.RegisterUsableItem('piluleoubli1', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('OblivionPill:piluleoubli', source)
	xPlayer.removeInventoryItem('piluleoubli1', 1)
	TriggerClientEvent('Extasy:showNotification', source, 'Vous prenez une ~b~pilule de l\'oubli~w~.')
	Citizen.Wait(360000)
	TriggerClientEvent('OblivionPill:stoppill', source)
end)


ESX.RegisterUsableItem('ghb_pooch', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('OblivionPill:piluleoubli', source)
	xPlayer.removeInventoryItem('ghb_pooch', 1)
	TriggerClientEvent('Extasy:showNotification', source, 'Vous prenez une ~b~pilule de l\'oubli~w~.')
	Citizen.Wait(540000)
	TriggerClientEvent('OblivionPill:stoppill', source)
end)

