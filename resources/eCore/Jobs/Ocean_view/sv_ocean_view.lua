ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'oceanview', 'oceanview', 'society_oceanview', 'society_oceanview', 'society_oceanview', {type = 'private'})


RegisterServerEvent('ocean_view:sendBilling')
AddEventHandler('ocean_view:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "ocean_view:sendBilling") then return end
	TriggerEvent("ext:AST", source, "ocean_view:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('ocean_view:firework_1')
AddEventHandler('ocean_view:firework_1', function(token, playersInArea, data)
	if not CheckToken(token, source, "ocean_view:firework_1") then return end
	TriggerEvent("ext:AST", source, "ocean_view:firework_1")

    TriggerClientEvent("ocean_view:firework_1", -1, data)
end)

RegisterServerEvent('ocean_view:firework_2')
AddEventHandler('ocean_view:firework_2', function(token, playersInArea, data)
	if not CheckToken(token, source, "ocean_view:firework_1") then return end
	TriggerEvent("ext:AST", source, "ocean_view:firework_1")

    TriggerClientEvent("ocean_view:firework_2", -1, data)
end)

RegisterServerEvent('ocean_view:getLeaderboard')
AddEventHandler('ocean_view:getLeaderboard', function(token)
	if not CheckToken(token, source, "ocean_view:getLeaderboard") then return end

	MySQL.Async.fetchAll("SELECT * FROM users WHERE job = @job ORDER BY farm_count DESC", {['@job'] = 'oceanview'}, function(result)
        if result[1].job == 'oceanview' then
            TriggerClientEvent('ocean_view:sendLeaderboard', -1, result)
        end
	end)
end)

RegisterServerEvent('ocean_view:add')
AddEventHandler('ocean_view:add', function(token)
    if not CheckToken(token, source, "ocean_view:add") then return end
	local ids = GetPlayerIdentifiers(source)
    local license = GetPlayerLicense(ids)

	MySQL.Async.execute('UPDATE users SET farm_count=farm_count + @farm_count WHERE identifier = @identifier', { ["@identifier"] = license, ["@farm_count"] = 1})

	MySQL.Async.fetchAll("SELECT * FROM users WHERE job = @job ORDER BY farm_count DESC", {['@job'] = 'oceanview'}, function(result)
        if result[1].job == 'oceanview' then
            TriggerClientEvent('ocean_view:sendLeaderboard', -1, result)
        end
	end)
end)