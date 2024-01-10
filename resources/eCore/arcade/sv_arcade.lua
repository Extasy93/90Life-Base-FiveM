ESX = nil
TriggerEvent("ext:getSharedObject", function(esx) ESX = esx end)

RegisterNetEvent("arcade:buyTicket")
AddEventHandler("arcade:buyTicket", function(token, price, index)
    if not CheckToken(token, source, "arcade:buyTicket") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if index == 1 then
        if xPlayer.getBank() >= price then
            xPlayer.removeAccountMoney('bank',price)
            TriggerClientEvent("arcade:ticketResult", xPlayer.source)
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
        end
    elseif index == 2 then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            TriggerClientEvent("arcade:ticketResult", xPlayer.source)
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
        end
    elseif index == 3 then
        if xPlayer.getAccount('black_money').money >= price then
            xPlayer.removeAccountMoney('black_money', tonumber(price))
            TriggerClientEvent("arcade:ticketResult", xPlayer.source)
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent de source inconnue")
        end
    end
end)

RegisterServerEvent('Arcade:BuyItemsByBankMoney')
AddEventHandler('Arcade:BuyItemsByBankMoney', function(token, thePrice, theItem, s_index, theLabel)
    if not CheckToken(token, source, "Arcade:BuyItemsByBankMoney") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getBank() >= thePrice then
        xPlayer.removeAccountMoney('bank',thePrice)
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~g~Vous avez reçu x"..s_index.." "..theLabel)
        xPlayer.addInventoryItem(theItem, s_index)
    else
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
	end
end)

RegisterServerEvent('Arcade:BuyItemsByMoney')
AddEventHandler('Arcade:BuyItemsByMoney', function(token, thePrice, theItem, s_index, theLabel)
    if not CheckToken(token, source, "Arcade:BuyItemsByMoney") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= thePrice then
        xPlayer.removeMoney(thePrice)
        xPlayer.addInventoryItem(theItem, s_index)
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~g~Vous avez reçu x"..s_index.." "..theLabel)
    else
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
	end
end)

RegisterServerEvent('Arcade:BuyItemsByDirtyMoney')
AddEventHandler('Arcade:BuyItemsByDirtyMoney', function(token, thePrice, theItem, s_index, theLabel)
    if not CheckToken(token, source, "Arcade:BuyItemsByByDirtyMoney") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getAccount('black_money').money >= thePrice then
        xPlayer.removeAccountMoney('black_money', tonumber(thePrice))
        xPlayer.addInventoryItem(theItem, s_index)
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~g~Vous avez reçu x"..s_index.." "..theLabel)
    else
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent de source inconnue sur vous")
	end
end)