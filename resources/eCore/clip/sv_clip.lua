ESX = nil

TriggerEvent('ext:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('Clip:remove')
AddEventHandler('Clip:remove', function(token)
	if not CheckToken(token, source, "Clip:remove") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Chargeur', 1)
end)

ESX.RegisterUsableItem('Chargeur', function(source)
	TriggerClientEvent('Clip:clipcli', source)
end)