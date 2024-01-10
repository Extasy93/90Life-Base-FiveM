ESX = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('Card', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerClientEvent("bank:useCard", source)
end)

RegisterServerEvent('Extasy:recupCb')
AddEventHandler('Extasy:recupCb', function(token)
    if not CheckToken(token, source, "Extasy:recupCb") then return end
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local cbQuantity = xPlayer.getInventoryItem('Card').count

    if 0 >= cbQuantity then
        local _source = source
	    local xPlayer = ESX.GetPlayerFromId(_source)

        TriggerClientEvent('Extasy:ShowNotification', _source, "~g~Tu as récupéré ta carte bancaire.")
        xPlayer.addInventoryItem('Card', 1)
    else
        TriggerClientEvent('Extasy:ShowNotification', _source, "~r~Tu as déja une carte bancaire sur toi.")
    end
end)

RegisterNetEvent("bank:withdrawMoney")
AddEventHandler("bank:withdrawMoney", function(token, input)
    if not CheckToken(token, source, "bank:withdrawMoney") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    input = tonumber(input)
    base = xPlayer.getAccount('bank').money

    if input == nil or input <= 0 or input > base then
        TriggerClientEvent('Extasy:ShowNotification', _source, "~r~Montant invalide !")
    else
        xPlayer.removeAccountMoney('bank', input)
        TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "Vice City Central Bank", "Transaction", "Vous avez retiré : ~g~" ..input.. "~w~ dollars", "CHAR_BANK_FLEECA")
        SendLog("Le joueur **"..source.." "..GetPlayerName(source).."** à retiré "..input.."$", "bank")
        xPlayer.addMoney(input)
    end

end)

RegisterServerEvent('bank:depositMoney')
AddEventHandler('bank:depositMoney', function(token, input)
    if not CheckToken(token, source, "bank:depositMoney") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local base = 0
    input = tonumber(input)
    local xPlayer = ESX.GetPlayerFromId(_source)

    if input == nil or input <= 0 then
        TriggerClientEvent('Extasy:ShowNotification', _source, "~r~Montant invalide !")
    else
        if input > xPlayer.getMoney() then
            input = xPlayer.getMoney()
        end
        xPlayer.removeMoney(input)
        TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "Vice City Central Bank", "Transaction", "Vous avez déposé : ~g~" ..input.. "~w~ dollars", "CHAR_BANK_FLEECA")
        SendLog("Le joueur **"..source.." "..GetPlayerName(source).."** à déposé "..input.."$", "bank")
        xPlayer.addAccountMoney('bank', tonumber(input))
    end

end)

RegisterServerEvent('bank:transferMoney')
AddEventHandler('bank:transferMoney', function(token, to, input)
    if not CheckToken(token, source, "bank:transferMoney") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(to)
    local balance = 0
    if zPlayer ~= nil then
        balance = xPlayer.getAccount('bank').money
        zbalance = zPlayer.getAccount('bank').money
        if tonumber(_source) == tonumber(to) then
            -- advanced notification with bank icon
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Vice City Central Bank", "Transaction", "Tu ne peut pas transféré de l'argent a toi même", 'CHAR_BANK_FLEECA')
        else
            if balance <= 0 or balance < tonumber(input) or tonumber(input) <=
                0 then
                -- advanced notification with bank icon
                TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Vice City Central Bank", "Transaction", "Pas assez de money pour éffectuer le transfert !", "CHAR_BANK_FLEECA")
            else
                xPlayer.removeAccountMoney('bank', tonumber(input))
                zPlayer.addAccountMoney('bank', tonumber(input))
                -- advanced notification with bank icon
                TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Vice City Central Bank", "Transaction", "Vous avez transféré ~r~$" ..input.. "~s~ a ~r~".. to .." .", 'CHAR_BANK_FLEECA')
                SendLog("**Le joueur: [".._source.."] - "..joueur.."** a transférer à **"..joueur2.." - ["..to.."]** un total de ***"..input.." $***.", "bank")
                TriggerClientEvent('Extasy:ShowAdvancedNotification', to, "Vice City Central Bank", "Transaction", "Tu as reçu ~r~$" ..input.. "~s~ de ~r~" .._source.." .", "CHAR_BANK_FLEECA")
            end

        end
    end
end)