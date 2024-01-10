TriggerEvent('Society:registerSociety', 'cityhall', 'cityhall', 'society_cityhall', 'society_cityhall', 'society_cityhall', {type = 'private'})

RegisterServerEvent('cityhall:sendBilling')
AddEventHandler('cityhall:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "cityhall:sendBilling") then return end
	TriggerEvent("ext:AST", source, "cityhall:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
    SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('gouvernement:teleportMain')
AddEventHandler('gouvernement:teleportMain', function(token, player)
    if not CheckToken(token, source, "gouvernement:teleportMain") then return end

    SetEntityCoords(source, 2865.09, 7390.19, 173.46)
end)

RegisterServerEvent('gouvernement:teleportLobby')
AddEventHandler('gouvernement:teleportLobby', function(token, player)
    if not CheckToken(token, source, "gouvernement:teleportLobby") then return end

    SetEntityCoords(source, 2888.24, 7384.32, 10.51)
end)
