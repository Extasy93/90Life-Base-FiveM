ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Extasy:GetTimeInfo")
AddEventHandler("Extasy:GetTimeInfo", function(token)
    if not CheckToken(token, source, "Extasy:GetTimeInfo") then return end
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {['@identifier'] = xPlayer.identifier}, function(getInfo)
            if getInfo[1] ~= nil then
                TriggerClientEvent("Extasy:initializeTimeToWait", _source, getInfo[1].TimeToWait)
            else
                print("Données corompus")
            end
        end)
    else
        Wait(15000)
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {['@identifier'] = xPlayer.identifier}, function(getInfo)
            if getInfo[1] ~= nil then
                TriggerClientEvent("Extasy:initializeTimeToWait", _source, getInfo[1].TimeToWait)
            else
                print("Données corompus")
            end
        end)
    end
end)

RegisterServerEvent("Extasy:SaveTime")
AddEventHandler("Extasy:SaveTime", function(token, NewTime)
    if not CheckToken(token, source, "Extasy:SaveTime") then return end
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {['@identifier'] = xPlayer.identifier}, function(getInfo)
		if getInfo[1] ~= nil then
            local TimeToSend = getInfo[1].TimeToWait + NewTime
            MySQL.Async.execute("UPDATE users SET TimeToWait=@TimeToWait WHERE identifier=@identifier", {["@TimeToWait"] = TimeToSend, ['@identifier'] = xPlayer.identifier})
            TriggerClientEvent("Extasy:initializeTimeToWait", _source, TimeToSend)
        else
            print("Donnée corompu")
        end
	end)
end)