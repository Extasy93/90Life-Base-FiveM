ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'malibu', 'malibu', 'society_malibu', 'society_malibu', 'society_malibu', {type = 'private'})

RegisterServerEvent('malibu:sendBilling')
AddEventHandler('malibu:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "malibu:sendBilling") then return end
	TriggerEvent("ext:AST", source, "malibu:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('malibu:firework_1')
AddEventHandler('malibu:firework_1', function(token, playersInArea, data)
	if not CheckToken(token, source, "malibu:firework_1") then return end
	TriggerEvent("ext:AST", source, "malibu:firework_1")

    TriggerClientEvent("malibu:firework_1", -1, data)
end)

RegisterServerEvent('malibu:firework_2')
AddEventHandler('malibu:firework_2', function(token, playersInArea, data)
	if not CheckToken(token, source, "malibu:firework_1") then return end
	TriggerEvent("ext:AST", source, "malibu:firework_1")

    TriggerClientEvent("malibu:firework_2", -1, data)
end)