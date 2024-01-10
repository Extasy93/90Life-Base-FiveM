ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Extasy:WashMoney', function (source, cb, price)
	TriggerEvent("ext:AST", source, "Extasy:WashMoney")
	local xPlayer     = ESX.GetPlayerFromId(source)
	
	if xPlayer.getAccount('black_money').money >= price then
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('Extasy:blanchiement')
AddEventHandler('Extasy:blanchiement', function(token, argent)
	if not CheckToken(token, source, "Extasy:blanchiement") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local taxe = 0.65

	argent = ESX.Math.Round(tonumber(argent))
	pourcentage = argent * taxe
	Total = ESX.Math.Round(tonumber(pourcentage))

	if argent > 0 and xPlayer.getAccount('black_money').money >= argent then
		xPlayer.removeAccountMoney('black_money', argent)
		xPlayer.addMoney(Total)
	else
		TriggerClientEvent('Extasy:showAdvancedNotification', xPlayer.source, 'Information', 'Blanchiement', '~r~Montant invalide', 'CHAR_MP_FM_CONTACT', 8)
	end	
end)
