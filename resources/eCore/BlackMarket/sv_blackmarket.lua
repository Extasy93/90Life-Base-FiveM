RegisterServerEvent('illegal_shop:buySomething')
AddEventHandler('illegal_shop:buySomething', function(token, Item, LabelItem, index, price)
    if not CheckToken(token, source, "illegal_shop:buySomething") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(Item, index)
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~g~Vous avez reçu x"..index.." "..LabelItem)
    else
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
	end
end)