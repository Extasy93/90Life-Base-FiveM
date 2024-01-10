ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'greasychopper', 'greasychopper', 'society_greasychopper', 'society_greasychopper', 'society_greasychopper', {type = 'private'})

RegisterServerEvent('greasychopper:sendBilling')
AddEventHandler('greasychopper:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "greasychopper:sendBilling") then return end
	TriggerEvent("ext:AST", source, "greasychopper:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

ESX.RegisterUsableItem('Joint', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('Joint', 1)

    TriggerClientEvent('Extasy:UseWeed', source)
end)

ESX.RegisterUsableItem('rhum', function(source)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('rhum', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 5)
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:UseAlcool', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "Tu as bu un rhum")
end)