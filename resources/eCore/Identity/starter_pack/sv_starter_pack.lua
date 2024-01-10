RegisterNetEvent("starterpack:ProcessLegal")
AddEventHandler("starterpack:ProcessLegal", function(token, money)
    if not CheckToken(token, source, "starterpack:ProcessLegal") then return end
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if xPlayer then
        TriggerClientEvent("Extasy:showNotification", _src, "~g~Félicitations ! ~s~Vous venez de choisi le start: ~g~Légal ~s~!")
        xPlayer.addMoney(money)
        -- Véhicule
        TriggerClientEvent('ExtasyStarterPack:GiveCar', _src)
        Wait(1000)
        xPlayer.setJob("miner", 0) -- Job mieux payer
        TriggerClientEvent('Extasy:showAdvancedNotification', _src, "Johnny", "~r~Starter Pack", "Tu viens de choisir le pack ~g~Légal~s~, tous les avantages t'on été attribuer avec succès!\n" , "WEB_JACKSONBBJ", 24,5)
    end
end)

RegisterNetEvent("starterpack:ProcessIllegal")
AddEventHandler("starterpack:ProcessIllegal", function(token, money, moneySale)
    if not CheckToken(token, source, "starterpack:ProcessIllegal") then return end
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    if xPlayer then
        TriggerClientEvent("Extasy:showNotification", _src, "~g~Félicitations ! ~s~Vous venez de choisi le start: ~g~Légal ~s~!")
        if money == 35000 and moneySale == 15000 then
            xPlayer.addMoney(money)
            xPlayer.addAccountMoney('black_money', moneySale)
        else
            Print("Cheater :".._source)
            TriggerEvent("euhtesserieuxmek")
        end

        -- Arme (batte)
        xPlayer.addWeapon("WEAPON_BAT", 1) -- Arme de départ

        TriggerEvent("over:creationarmestupeuxpasdeviner", token, _src, "WEAPON_BAT", 1, "Starter Pack")
        
        TriggerClientEvent('Extasy:showAdvancedNotification', _src, "Johnny", "~r~Starter Pack", "Tu viens de choisir le pack ~r~Illégal~s~, tous les avantages t'on été attribuer avec succès!\n" , "WEB_JACKSONBBJ", 24,5)
    end
end)