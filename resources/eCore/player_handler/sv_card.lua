ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

local playerCarteID = {}

RegisterServerEvent('Extasy:recupcarteid')
AddEventHandler('Extasy:recupcarteid', function(token)
    if not CheckToken(token, source, "Extasy:recupcarteid") then return end
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local carteidQuantity = xPlayer.getInventoryItem('CarteID').count

    if 0 >= carteidQuantity then
        local _source = source
	    local xPlayer = ESX.GetPlayerFromId(_source)

        TriggerClientEvent('Extasy:ShowNotification', _source, 'Tu as récupéré ta carte d\'identitée.')
        TriggerClientEvent("CheckSuccesIdentiteCard", _source)
        xPlayer.addInventoryItem('CarteID', 1)
    else
        TriggerClientEvent('Extasy:ShowNotification', _source, 'Tu às déja récupéré ta carte d\'identitée.')
    end
end)

RegisterCommand('info', function(source, args)
	local _source = source
	local xPlayer    = ESX.GetPlayerFromId(args[1])
    local identifier = xPlayer.identifier
    
    MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)

        for k,v in pairs(result) do
            if not playerCarteID[xPlayer.identifier] then 
                playerCarteID[xPlayer.identifier] =  {} 
                playerCarteID[xPlayer.identifier].firstname = v.firstname
                playerCarteID[xPlayer.identifier].lastname = v.lastname
                playerCarteID[xPlayer.identifier].dateofbirth = v.dateofbirth
                playerCarteID[xPlayer.identifier].sex = v.sex
                playerCarteID[xPlayer.identifier].height = v.height
            end
            TriggerClientEvent('Extasy:showAdvancedNotification', source, "Carte d'identité", "Préfecture", "~p~Prénom: ~s~".. playerCarteID[xPlayer.identifier].firstname.."\n~p~Nom: ~s~"..playerCarteID[xPlayer.identifier].lastname.."\n~p~Née le: ~s~"..playerCarteID[xPlayer.identifier].dateofbirth.."\n~p~Taille: ~s~"..playerCarteID[xPlayer.identifier].height.." cm\n~p~Sexe: ~s~"..playerCarteID[xPlayer.identifier].sex, "CHAR_LESTER", 8)
        end
    end)
end, true)

