ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'icecream', 'icecream', 'society_icecream', 'society_icecream', 'society_icecream', {type = 'public'})

RegisterServerEvent('ice:sendBilling')
AddEventHandler('ice:sendBilling', function(token, reason, price, society, buyer, action, execute)
	if not CheckToken(token, source, "ice:sendBilling") then return end
	TriggerEvent("ext:AST", source, "ice:sendBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute)
    SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)

RegisterServerEvent('ice:buy')
AddEventHandler('ice:buy', function(token, buy)
	if not CheckToken(token, source, "ice:buy") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
	local i = xPlayer.getInventoryItem('Creme_glacee').count

    if i <= 1 then
        TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez plus de crème glacée sur vous")
    else
        xPlayer.removeInventoryItem("Creme_glacee", buy)
		Wait(4000)
		xPlayer.addInventoryItem("Glace_vanille", 1)
    end
end)

RegisterServerEvent('ice:getLeaderboard')
AddEventHandler('ice:getLeaderboard', function(token)
	if not CheckToken(token, source, "ice:getLeaderboard") then return end

	MySQL.Async.fetchAll("SELECT * FROM users WHERE job = @job ORDER BY farm_count DESC", {['@job'] = 'icecream'}, function(result)
        if result[1].job == 'icecream' then
            TriggerClientEvent('ice:sendLeaderboard', -1, result)
        end
	end)
end)

RegisterServerEvent('ice:add')
AddEventHandler('ice:add', function(token)
    if not CheckToken(token, source, "ice:add") then return end
	local ids = GetPlayerIdentifiers(source)
    local license = GetPlayerLicense(ids)

	MySQL.Async.execute('UPDATE users SET farm_count=farm_count + @farm_count WHERE identifier = @identifier', { ["@identifier"] = license, ["@farm_count"] = 1})

	MySQL.Async.fetchAll("SELECT * FROM users WHERE job = @job ORDER BY farm_count DESC", {['@job'] = 'icecream'}, function(result)
        if result[1].job == 'icecream' then
            TriggerClientEvent('ice:sendLeaderboard', -1, result)
        end
	end)
end)