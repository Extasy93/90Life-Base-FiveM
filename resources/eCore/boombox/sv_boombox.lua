RegisterNetEvent("boombox:soundStatus")
AddEventHandler("boombox:soundStatus", function(token, type, musicId, data, playersInArea)
    if not CheckToken(token, source, "boombox:soundStatus") then return end
    TriggerClientEvent("boombox:soundStatus", -1, type, musicId, data, playersInArea)
end)

RegisterNetEvent("boombox:soundStatus2")
AddEventHandler("boombox:soundStatus2", function(token, type, musicId, data, playersInArea)
    if not CheckToken(token, source, "boombox:soundStatus2") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent("boombox:soundStatus", xPlayer.source, type, musicId, data, playersInArea)
end)

ESX.RegisterUsableItem('boombox', function(source)
	TriggerClientEvent("item:Boombox", source)
end)