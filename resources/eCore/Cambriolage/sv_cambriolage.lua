ESX = nil

TriggerEvent('ext:getSharedObject', function(obj)   ESX = obj   end)

RegisterServerEvent("Extasy:sellItem")
AddEventHandler("Extasy:sellItem", function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config_heist_house.SellPrice[itemName]
	local Item = xPlayer.getInventoryItem(itemName)

	if not price then
		if Item.name == "Outil_crochetage" then 
			xPlayer.removeInventoryItem(Item.name, 1)
			return
		else
			DropPlayer(source, "Exploit")
			return
		end
	end

	xPlayer.addAccountMoney('black_money', price)

	xPlayer.removeInventoryItem(Item.name, 1)
end)

RegisterNetEvent('Extasy:buy')
AddEventHandler('Extasy:buy', function(itemName) 
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem(itemName, 1)
end)

RegisterNetEvent('Extasy:vcpdGetSmugglerAlert')
AddEventHandler('Extasy:vcpdGetSmugglerAlert', function(coords)
    local players = ESX.GetPlayers()
    
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'vcpd' then
            TriggerClientEvent('Extasy:vcpdSendSmugglerAlert', players[i], coords)
        end
    end
end)
