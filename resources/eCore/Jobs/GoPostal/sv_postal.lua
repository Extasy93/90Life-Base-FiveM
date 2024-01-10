RegisterNetEvent('goPostal:pay', function(token, quantity)
	if not CheckToken(token, source, "goPostal:pay") then return end
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addMoney(quantity)
	TriggerClientEvent('Extasy:ShowNotification', source, 'Vous avez reçu ~g~$' ..tonumber(quantity))
end)