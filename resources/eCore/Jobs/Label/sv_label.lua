ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'label', 'label', 'society_label', 'society_label', 'society_label', {type = 'private'})

RegisterServerEvent('label:sendBilling')
AddEventHandler('label:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "label:sendBilling") then return end
	TriggerEvent("ext:AST", source, "label:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)