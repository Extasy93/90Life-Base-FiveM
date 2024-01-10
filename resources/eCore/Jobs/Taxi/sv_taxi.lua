ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'taxi', 'taxi', 'society_taxi', 'society_taxi', 'society_taxi', {type = 'private'})

RegisterServerEvent('taxi:sendBilling')
AddEventHandler('taxi:sendBilling', function(token, reason, price, society, buyer, action, execute, deduce, isForce, hash, name)
	if not CheckToken(token, source, "taxi:sendBilling") then return end
	TriggerEvent("ext:AST", source, "taxi:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute, deduce, isForce, hash, name)
    SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('Taxi:finishRun')
AddEventHandler('Taxi:finishRun', function(token, society, price_society, price_player)
	if not CheckToken(token, source, "Taxi:finishRun") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
    local societyAccount = nil

    TriggerEvent('eAddonaccount:getSharedAccount', "society_"..society, function(account)
        societyAccount = account
    end)

    xPlayer.addMoney(price_player)

    if societyAccount ~= nil then
        societyAccount.addMoney(price_society)
    end
end)
