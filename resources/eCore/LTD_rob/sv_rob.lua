ESX = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

local deadPeds = {}

RegisterServerEvent('Extasy:pedDead')
AddEventHandler('Extasy:pedDead', function(token, store)
    if not CheckToken(token, source, "Extasy:pedDead") then return end
    if not deadPeds[store] then
        deadPeds[store] = 'deadlol'
        TriggerClientEvent('Extasy:onPedDeath', -1, store)
        local second = 1000
        local minute = 60 * second
        local hour = 60 * minute
        local cooldown = ConfigLTD.Shops[store].cooldown
        local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
        Wait(wait)
        if not ConfigLTD.Shops[store].robbed then
            for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
            TriggerClientEvent('Extasy:resetStore', -1, store)
        end
    end
end)

RegisterServerEvent('Extasy:handsUp')
AddEventHandler('Extasy:handsUp', function(token, store)
    if not CheckToken(token, source, "Extasy:handsUp") then return end
    TriggerClientEvent('Extasy:handsUp', -1, store)
end)

RegisterServerEvent('Extasy:pickUp')
AddEventHandler('Extasy:pickUp', function(token, store)
    if not CheckToken(token, source, "Extasy:pickUp") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    local randomAmount = math.random(ConfigLTD.Shops[store].money[1], ConfigLTD.Shops[store].money[2])
    xPlayer.addMoney(randomAmount)
    TriggerClientEvent('Extasy:showNotification', source, Translation[ConfigLTD.Locale]['cashrecieved'] .. ' ~g~' .. randomAmount .. ' ' .. Translation[ConfigLTD.Locale]['currency'])
    TriggerClientEvent('Extasy:removePickup', -1, store) 
end)

ESX.RegisterServerCallback('Extasy:canRob', function(source, cb, store)
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
    end
    if cops >= ConfigLTD.Shops[store].cops then
        if not ConfigLTD.Shops[store].robbed and not deadPeds[store] then
            cb(true)
        else
            cb(false)
        end
    else
        cb('no_cops')
    end
end)

RegisterServerEvent('Extasy:rob')
AddEventHandler('Extasy:rob', function(token, store)
    if not CheckToken(token, source, "Extasy:rob") then return end
    TriggerClientEvent('Extasy:rob', -1, store)
    Wait(30000)
    TriggerClientEvent('Extasy:robberyOver', src)

    local second = 1000
    local minute = 60 * second
    local hour = 60 * minute
    local cooldown = ConfigLTD.Shops[store].cooldown
    local wait = cooldown.hour * hour + cooldown.minute * minute + cooldown.second * second
    Wait(wait)
    ConfigLTD.Shops[store].robbed = false
    for k, v in pairs(deadPeds) do if k == store then table.remove(deadPeds, k) end end
    TriggerClientEvent('Extasy:resetStore', -1, store)
end)

RegisterServerEvent('Extasy:robNotif')
AddEventHandler('Extasy:robNotif', function(token, store)
    if not CheckToken(token, source, "Extasy:robNotif") then return end
    local src = source
    ConfigLTD.Shops[store].robbed = true
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            TriggerClientEvent('Extasy:msgPolice', xPlayer.source, store, src)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #deadPeds do TriggerClientEvent('Extasy:pedDead', -1, i) end -- update dead peds
        Citizen.Wait(500)
    end
end)
