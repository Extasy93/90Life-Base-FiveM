ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'frontpage', 'frontpage', 'society_frontpage', 'society_frontpage', 'society_frontpage', {type = 'public'})

RegisterServerEvent('front:sendBilling')
AddEventHandler('front:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "front:sendBilling") then return end
	TriggerEvent("ext:AST", source, "front:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
    SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('front:buy')
AddEventHandler('front:buy', function(token, buy)
	if not CheckToken(token, source, "front:buy") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
	local i = xPlayer.getInventoryItem('Cafe_moulu').count

    if i <= 1 then
        TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez plus de café moulu sur vous")
    else
        xPlayer.removeInventoryItem("Cafe_moulu", buy)
		Wait(4000)
		xPlayer.addInventoryItem("Cafe", 1)
    end
end)