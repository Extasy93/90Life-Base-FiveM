ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'tabac', 'tabac', 'society_tabac', 'society_tabac', 'society_tabac', {type = 'private'})

RegisterServerEvent('tabac:sendBilling')
AddEventHandler('tabac:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "tabac:sendBilling") then return end
	TriggerEvent("ext:AST", source, "tabac:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('tabac:buy')
AddEventHandler('tabac:buy', function(token, buy)
	if not CheckToken(token, source, "tabac:buy") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
	local i = xPlayer.getInventoryItem('Tabac_traite').count

    if i <= 1 then
        TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez plus de tabac traité sur vous")
    else
        xPlayer.removeInventoryItem("Tabac_traite", buy)
		Wait(4000)
		xPlayer.addInventoryItem("Cigarette", 1)
    end
end)

RegisterServerEvent('tabac:getLeaderboard')
AddEventHandler('tabac:getLeaderboard', function(token)
	if not CheckToken(token, source, "tabac:getLeaderboard") then return end

	MySQL.Async.fetchAll("SELECT * FROM users WHERE job = @job ORDER BY farm_count DESC", {['@job'] = 'tabac'}, function(result)
        if result[1].job == 'tabac' then
            TriggerClientEvent('tabac:sendLeaderboard', -1, result)
        end
	end)
end)

RegisterServerEvent('tabac:add')
AddEventHandler('tabac:add', function(token)
    if not CheckToken(token, source, "tabac:add") then return end
	local ids = GetPlayerIdentifiers(source)
    local license = GetPlayerLicense(ids)

	MySQL.Async.execute('UPDATE users SET farm_count=farm_count + @farm_count WHERE identifier = @identifier', { ["@identifier"] = license, ["@farm_count"] = 1})

	MySQL.Async.fetchAll("SELECT * FROM users WHERE job = @job ORDER BY farm_count DESC", {['@job'] = 'tabac'}, function(result)
        if result[1].job == 'tabac' then
            TriggerClientEvent('tabac:sendLeaderboard', -1, result)
        end
	end)
end)

GetPlayerLicense = function(ids)
	for _,v in pairs(ids) do
	  if string.find(v, 'license') then
		return v
	  end
	end
  
	return false
end