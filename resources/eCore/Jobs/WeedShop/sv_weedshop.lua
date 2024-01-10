ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'weedshop', 'weedshop', 'society_weedshop', 'society_weedshop', 'society_weedshop', {type = 'private'})

RegisterServerEvent('weedshop:sendBilling')
AddEventHandler('weedshop:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "weedshop:sendBilling") then return end
	TriggerEvent("ext:AST", source, "weedshop:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('weedshop:buy')
AddEventHandler('weedshop:buy', function(token, buy)
	if not CheckToken(token, source, "weedshop:buy") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
	local i = xPlayer.getInventoryItem('Weed_traite').count

    if i <= 1 then
        TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez plus de Weed traitée sur vous")
    else
        xPlayer.removeInventoryItem("Weed_traite", buy)
		Wait(4000)
		xPlayer.addInventoryItem("Joint", 1)
    end
end)

ESX.RegisterUsableItem('Joint', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('Joint', 1)

    TriggerClientEvent('Extasy:UseWeed', source)
end)

ESX.RegisterUsableItem('marijuana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('marijuana', 1)

	TriggerClientEvent('Extasy:UseWeed', source)
end)

ESX.RegisterUsableItem('opium', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('opium', 1)

	TriggerClientEvent('Extasy:UseWeed', source)
end)

ESX.RegisterUsableItem('meth', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('meth', 1)

	TriggerClientEvent('Extasy:UseWeed', source)
end)

ESX.RegisterUsableItem('coke', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('coke', 1)

	TriggerClientEvent('Extasy:UseWeed', source)
end)