RegisterServerEvent('Barber:buy')
AddEventHandler('Barber:buy', function(token, thePrice, index, label)
    if not CheckToken(token, source, "Barber:buy") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if index == 1 then
        if xPlayer.getBank() >= thePrice then
            xPlayer.removeAccountMoney('bank',thePrice)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~o~Barber", "Achat éfféctué", "Vous venez d'acheter ~g~"..label.."", "CHAR_BARBER")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
        end
    elseif index == 2 then
        if xPlayer.getMoney() >= thePrice then
            xPlayer.removeMoney(thePrice)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~o~Barber", "Achat éfféctué", "Vous venez d'acheter ~g~"..label.."", "CHAR_BARBER")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
        end
    elseif index == 3 then
        if xPlayer.getAccount('black_money').money >= thePrice then
            xPlayer.removeAccountMoney('black_money', tonumber(thePrice))
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~o~Barber", "Achat éfféctué", "Vous venez d'acheter ~g~"..label.."", "CHAR_BARBER")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent de source inconnue")
        end
    end
end)

RegisterServerEvent('Makeup:buy')
AddEventHandler('Makeup:buy', function(token, thePrice, index, label)
    if not CheckToken(token, source, "Makeup:buy") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if index == 1 then
        if xPlayer.getBank() >= thePrice then
            xPlayer.removeAccountMoney('bank',thePrice)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~o~Makeup", "Achat éfféctué", "Vous venez d'acheter ~g~"..label.."", "CHAR_MAKEUP")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
        end
    elseif index == 2 then
        if xPlayer.getMoney() >= thePrice then
            xPlayer.removeMoney(thePrice)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~o~Makeup", "Achat éfféctué", "Vous venez d'acheter ~g~"..label.."", "CHAR_MAKEUP")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
        end
    elseif index == 3 then
        if xPlayer.getAccount('black_money').money >= thePrice then
            xPlayer.removeAccountMoney('black_money', tonumber(thePrice))
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~o~Makeup", "Achat éfféctué", "Vous venez d'acheter ~g~"..label.."", "CHAR_MAKEUP")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent de source inconnue")
        end
    end
end)