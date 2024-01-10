ESX = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("DeleteEntityHunt")
AddEventHandler("DeleteEntityHunt", function(token, VehiculeDeChasse)
    if not CheckToken(token, source, "DeleteEntityHunt") then return end
    local entity = NetworkGetEntityFromNetworkId(VehiculeDeChasse)
    Citizen.InvokeNative(`DELETE_ENTITY` & 0xFFFFFFFF, entity)
end)

RegisterServerEvent('GetWeaponsChasse')
AddEventHandler('GetWeaponsChasse', function(token)
    if not CheckToken(token, source, "GetWeaponsChasse") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addWeapon("WEAPON_MUSKET", 250)
    TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, "WEAPON_MUSKET", 250, "Chasse")

    TriggerClientEvent('Extasy:showNotification', _source, "~g~Vous reçu votre fusil.")
end)

RegisterServerEvent('GetWeaponsChasse2')
AddEventHandler('GetWeaponsChasse2', function(token)
    if not CheckToken(token, source, "GetWeaponsChasse2") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addWeapon("WEAPON_SNIPERRIFLE", 250)
    TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, "WEAPON_SNIPERRIFLE", 250, "Chasse")

    TriggerClientEvent('Extasy:showNotification', _source, "~g~Vous reçu votre fusil de pro.")
end)

RegisterServerEvent('RemoveWeaponsChasse')
AddEventHandler('RemoveWeaponsChasse', function(token, source)
    if not CheckToken(token, source, "RemoveWeaponsChasse") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeWeapon("WEAPON_SNIPERRIFLE")
    xPlayer.removeWeapon("WEAPON_MUSKET")
    TriggerEvent("over:logsmoicadelete", source, "WEAPON_MUSKET", 0)
    TriggerEvent("over:logsmoicadelete", source, "WEAPON_SNIPERRIFLE", 0)

    --TriggerClientEvent('Extasy:showNotification', _source, "~r~Vous êtes sortis de la zone, vous avez donc rendu votre fusil de chasse !")
end)

RegisterNetEvent("Extasy:huntSell")
AddEventHandler("Extasy:huntSell", function(token)
    if not CheckToken(token, source, "Extasy:huntSell") then return end
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local baseprice = 50
    local IViande = xPlayer.getInventoryItem("viande").count

    if IViande >= 15 then
        VenteViande = 15
        VenteViandeEnCours = 1
        
        if IViande >= VenteViande then
            VenteViandeEnCours = VenteViande
        end

        TriggerClientEvent('Extasy:showNotification', _source, 'Viande vendue. ~g~'..(baseprice*VenteViandeEnCours)..' $')
        xPlayer.removeInventoryItem("viande", VenteViandeEnCours)

        local Viandeprice = baseprice*VenteViandeEnCours
        
        xPlayer.addMoney(Viandeprice)
    else
        TriggerClientEvent('Extasy:showNotification', _source, "~r~Vous devez avoir minimum ~r~x15~s~ viandes sur vous !")
    end
end)

RegisterNetEvent("Extasy:huntFarm")
AddEventHandler("Extasy:huntFarm", function(token, RandomHunt)
    if not CheckToken(token, source, "Extasy:huntFarm") then return end
    local _source = source
    local _RandomHunt = RandomHunt
	local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addInventoryItem('viande', _RandomHunt)
end)

RegisterServerEvent('BuyPermisChasse')
AddEventHandler('BuyPermisChasse', function(token)
    if not CheckToken(token, source, "BuyPermisChasse") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= 500 then
        xPlayer.removeMoney(500)
        xPlayer.addInventoryItem('permis', 1)

	    MySQL.Async.execute('UPDATE `user_licenses` SET `Chasse` = "OUI" WHERE `owner`=@owner', {["@owner"] = xPlayer.identifier}, nil)

        TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Vice Chasse", "~r~ INFO !", "~w~Vous avez achetez le Permis de Chasse" , "CHAR_AMMUNATION", 24,5)
    else
  	    TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Vice Chasse", "~r~ INFO !", "~w~Vous n'avez pas assez ~h~ d'argent " , "CHAR_AMMUNATION", 24,5)
	end
end)