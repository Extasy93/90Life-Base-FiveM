RegisterNetEvent("Triso:GiveItem")
AddEventHandler("Triso:GiveItem", function(token, item, _count)
    if not CheckToken(token, source, "Triso:GiveItem") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    if CopsConnected < 1 then
        TriggerClientEvent('Extasy:showNotification', source, '~r~Il n\'y a pas assez de flic connecter  ')
		return
    end
    xPlayer.addInventoryItem(item, _count)
end)

RegisterNetEvent("Triso:Traitememt")
AddEventHandler("Triso:Traitememt", function(token, item, item_g, _count)
    if not CheckToken(token, source, "Triso:Traitememt") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    if CopsConnected < 1 then
        TriggerClientEvent('Extasy:showNotification', source, '~r~Il n\'y a pas assez de flic connecter  ')
		return
    end
    xPlayer.removeInventoryItem(item, _count)
    xPlayer.addInventoryItem(item_g, _count)
end)

RegisterNetEvent("Triso:ItemCount")
AddEventHandler("Triso:ItemCount", function(token, item)
    if not CheckToken(token, source, "Triso:ItemCount") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local drogueDureQuantite = xPlayer.getInventoryItem(item).count
    TriggerClientEvent("Triso:ItemCount", source, drogueDureQuantite)
end)

function CountCops()
	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end
	SetTimeout(5000, CountCops)
end

CountCops()