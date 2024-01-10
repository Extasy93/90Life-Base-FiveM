TriggerEvent('Society:registerSociety', 'avocat', 'avocat', 'society_avocat', 'society_avocat', 'society_avocat', {type = 'private'})

RegisterServerEvent('avocat:sendBilling')
AddEventHandler('avocat:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "avocat:sendBilling") then return end
	TriggerEvent("ext:AST", source, "avocat:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

