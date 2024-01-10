





formatPlayerInventoryOrg = function(xPlayer)
    local playerInventory = {}
    for name, count in pairs(xPlayer.getInventory(true)) do
        playerInventory[name] = count
    end
    return playerInventory
end

RegisterServerEvent('recoltActivity:refreshMyPlayerContent')
AddEventHandler('recoltActivity:refreshMyPlayerContent', function(token)
    if not CheckToken(token, source, "recoltActivity:refreshMyPlayerContent") then return end
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	local inventory = xPlayer.getInventory(true)
	local playerInventory = {}
    for name, count in pairs(inventory) do
        playerInventory[name] = count
    end

	TriggerClientEvent("recoltActivity:refreshPlayerContent", _source, formatPlayerInventoryOrg(xPlayer))
end)

RegisterServerEvent('recoltActivity:giveItem')
AddEventHandler('recoltActivity:giveItem', function(token, item, _count, PlayerCapacity)
    if not CheckToken(token, source, "recoltActivity:giveItem") then return end
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local qty = xPlayer.getInventoryItem(item).count

    if qty >= PlayerCapacity then
        TriggerClientEvent('Extasy:showNotification', _source, 'Tu n\'a plus de place dans ton inventaire')
    else
        xPlayer.addInventoryItem(item, _count)
    end
end)

RegisterServerEvent('recoltActivity:sell')
AddEventHandler('recoltActivity:sell', function(token, itemName, count, price)
    if not CheckToken(token, source, "recoltActivity:sell") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local qty = xPlayer.getInventoryItem(itemName).count
    local realPrice = count*price

    if qty > 0 then
        xPlayer.removeInventoryItem(itemName, count)
        TriggerClientEvent('Extasy:showNotification', _source, "Bravo! Vous venez de vendre des "..itemName.." pour ~g~"..realPrice.."$")
        xPlayer.addMoney(realPrice)
    else
        TriggerClientEvent('Extasy:showNotification', _source, "Tu n\'as plus de "..itemName.." à vendre...")
    end
end)