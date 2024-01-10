ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)
RegisterNetEvent("Cross:rentBike")
AddEventHandler("Cross:rentBike", function(token, Label, car, price, index)
    if not CheckToken(token, source, "Cross:rentBike") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    if index == 1 then
        if xPlayer.getBank() >= price then
            xPlayer.removeAccountMoney('bank', price)
            TriggerClientEvent('Cross:sendBike', xPlayer.source, car)
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
        end
    elseif index == 2 then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            TriggerClientEvent('Cross:sendBike', xPlayer.source, car)
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
        end
    elseif index == 3 then
        if xPlayer.getAccount('black_money').money >= price then
            xPlayer.removeAccountMoney('black_money', tonumber(price))
            TriggerClientEvent('Cross:sendBike', xPlayer.source, car)
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent de source inconnue")
        end
    end
end)
