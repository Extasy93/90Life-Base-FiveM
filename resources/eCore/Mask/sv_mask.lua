ESX                    = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Extasy:MaskMoney')
AddEventHandler('Extasy:MaskMoney', function(token, index, price, typ, n, value, value_2, num, GXT)
	if not CheckToken(token, source, "Extasy:MaskMoney") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if index == 1 then
        if xPlayer.getBank() >= price then
            xPlayer.removeAccountMoney('bank',price)
            TriggerClientEvent('Extasy:canHaveMask', xPlayer.source, price, typ, n, value, value_2, num, GXT)
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~g~Paiement effectué avec succès")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
        end
    elseif index == 2 then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            TriggerClientEvent('Extasy:canHaveMask', xPlayer.source, price, typ, n, value, value_2, num, GXT)
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~g~Paiement effectué avec succès")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
        end
    elseif index == 3 then
        if xPlayer.getAccount('black_money').money >= price then
            xPlayer.removeAccountMoney('black_money', tonumber(price))
            TriggerClientEvent('Extasy:canHaveMask', xPlayer.source, price, typ, n, value, value_2, num, GXT)
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~g~Paiement effectué avec succès")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent de source inconnue")
        end
    end
end)

RegisterServerEvent('Extasy:GiveMask')
AddEventHandler('Extasy:GiveMask', function(token, item, count, data, label)
	if not CheckToken(token, source, "Extasy:GiveMask") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local FinalResult = {}

    --xPlayer.addInventoryItem(item, count)

    MySQL.Async.execute('INSERT INTO player_masks (identifier, data, label) VALUES (@identifier, @data, @label)',{
        ['@identifier']  = xPlayer.identifier,
        ['@data']        = json.encode(data),
        ['@label']       = label, 
      },function(rowsChange)
            MySQL.Async.fetchAll('SELECT * FROM player_masks WHERE identifier = @identifier',
            {
                ['@identifier'] = xPlayer.identifier
            },
            function(result)
                for _,v in pairs(result) do
                    d = json.decode(v.data)
                    table.insert(FinalResult, {
                        id   	 	= v.id,
                        identifier  = v.identifier,
                        data      	= d,
                        label   	= v.label
                    })
                    TriggerClientEvent("Extasy:sendMasksData", _source, FinalResult)
                end
            end)
      end)
end)

RegisterServerEvent('Extasy:updateNameForThisMask')
AddEventHandler('Extasy:updateNameForThisMask', function(token, id, newName)
	if not CheckToken(token, source, "Extasy:updateNameForThisMask") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local FinalResult = {}

    MySQL.Async.execute('UPDATE player_masks SET label = @label WHERE id = @id', {
		['@id'] = id,
		['@label'] = newName
	}, function()
	end)

	MySQL.Async.fetchAll('SELECT * FROM player_masks WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.identifier
      },
      function(result)
		for _,v in pairs(result) do
			d = json.decode(v.data)
            table.insert(FinalResult, {
				id   	 	= v.id,
				identifier  = v.identifier,
				data      	= d,
				label   	= v.label
            })
			TriggerClientEvent("Extasy:sendMasksData", _source, FinalResult)
        end
    end)
end)

RegisterServerEvent('Extasy:deleteThisMask')
AddEventHandler('Extasy:deleteThisMask', function(token, id)
	if not CheckToken(token, source, "Extasy:deleteThisMask") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local FinalResult = {}

    MySQL.Async.execute('DELETE FROM player_masks WHERE id = @id', {
		['@id'] = id
	}, function()
	end)

	MySQL.Async.fetchAll('SELECT * FROM player_masks WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.identifier
      },
      function(result)
		for _,v in pairs(result) do
			d = json.decode(v.data)
            table.insert(FinalResult, {
				id   	 	= v.id,
				identifier  = v.identifier,
				data      	= d,
				label   	= v.label
            })
			TriggerClientEvent("Extasy:sendMasksData", _source, FinalResult)
        end
    end)
end)