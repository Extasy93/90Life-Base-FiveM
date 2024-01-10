ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'robina', 'robina', 'society_robina', 'society_robina', 'society_robina', {type = 'public'})

RegisterServerEvent('robina:sendBilling')
AddEventHandler('robina:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "robina:sendBilling") then return end
	TriggerEvent("ext:AST", source, "robina:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
    SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('robina:buy')
AddEventHandler('robina:buy', function(token, buy)
	if not CheckToken(token, source, "robina:buy") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
	local i = xPlayer.getInventoryItem('Pain_burger').count

    if i <= 1 then
        TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez plus de pain à hamburger sur vous")
    else
        xPlayer.removeInventoryItem("Pain_burger", buy)
		Wait(4000)
		xPlayer.addInventoryItem("hamburger", 1)
    end
end)