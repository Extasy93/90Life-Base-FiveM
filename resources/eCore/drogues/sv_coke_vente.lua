RegisterServerEvent('Extasy:SellItemToDrugsCoke')
AddEventHandler('Extasy:SellItemToDrugsCoke', function(token, item, _price, _count)
	if not CheckToken(token, source, "Extasy:SellItemToDrugsCoke") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
    local i = xPlayer.getInventoryItem(item).count

    if 0 < i then
        xPlayer.removeInventoryItem(item, _count)
        TriggerClientEvent('Extasy:ShowNotification', source, "~g~x1 "..item.." vendu~s~\n~c~+(".._price.."$)~s~ d'argent de source inconnu")
        xPlayer.addAccountMoney('black_money', _price)
    else
        TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez plus de "..item.." sur vous")
    end
end)

RegisterServerEvent('Extasy:SellItemToDrugsWeed')
AddEventHandler('Extasy:SellItemToDrugsWeed', function(token, item, _price, _count)
	if not CheckToken(token, source, "Extasy:SellItemToDrugsWeed") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
    local i = xPlayer.getInventoryItem(item).count

    if 0 < i then
        xPlayer.removeInventoryItem(item, _count)
        TriggerClientEvent('Extasy:ShowNotification', source, "~g~x1 "..item.." vendu~s~\n~c~+(".._price.."$)~s~ d'argent de source inconnu")
        xPlayer.addAccountMoney('black_money', _price)
    else
        TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez plus de "..item.." sur vous")
    end
end)

RegisterServerEvent('Extasy:SellItemToDrugsMeth')
AddEventHandler('Extasy:SellItemToDrugsMeth', function(token, item, _price, _count)
	if not CheckToken(token, source, "Extasy:SellItemToDrugsMeth") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
    local i = xPlayer.getInventoryItem(item).count

    if 0 < i then
        xPlayer.removeInventoryItem(item, _count)
        TriggerClientEvent('Extasy:ShowNotification', source, "~g~x1 "..item.." vendu~s~\n~c~+(".._price.."$)~s~ d'argent de source inconnu")
        xPlayer.addAccountMoney('black_money', _price)
    else
        TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez plus de "..item.." sur vous")
    end
end)