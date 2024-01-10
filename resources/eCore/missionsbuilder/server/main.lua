local ESX, presets, isMissionRunning, runningMissionID = nil, {}, false, nil
local includedPlayers = {}

local function getLicense(source) 
    for k,v in pairs(GetPlayerIdentifiers(source))do      
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
    return ""
end

local function updateEventsPresets()
    presets = {}
    MySQL.Async.fetchAll("SELECT * FROM eventsPresets", {}, function(result)
        for k,v in pairs(result) do 
            presets[v.id] = {label = v.label, infos = json.decode(v.presetInfos), id = v.id}
        end
    end) 
end

local function start(id)
    TriggerClientEvent("eventsbuilder_receiveStart", -1, presets[id].infos)
end

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("missionsbuilder", function(source)
    if source == 0 then return end
    TriggerClientEvent("eventsbuilder_openMenu", source, presets, isMissionRunning)
end, true)

RegisterNetEvent("eventsbuilder_missionDone")
AddEventHandler("eventsbuilder_missionDone", function(token)
    if not CheckToken(token, source, "eventsbuilder_missionDone") then return end
    local source = source
    if not isMissionRunning then
        return
    end
    if not presets[runningMissionID] then
        TriggerClientEvent("Extasy:showNotification", source, "~r~La mission que vous avez terminé n'existe plus.")
        return
    end
    if not includedPlayers[source] then
        TriggerClientEvent("Extasy:showNotification", source, "~r~Vous n'êtes pas compris dans l'event")
        return
    end
    local missionInfos = presets[runningMissionID].infos
    local reward = missionInfos.reward
    local type = missionInfos.rewardType

    local xPlayer = ESX.GetPlayerFromId(source)

    if type == 1 then
        xPlayer.addMoney(tonumber(reward))
    elseif type == 2 then
        xPlayer.addAccountMoney("black_money", tonumber(reward))
    else
        xPlayer.addMoney(tonumber(reward))
    end
    TriggerClientEvent("Extasy:showNotification", source, "~g~Vous avez remporté ~y~"..reward.."$ ~g~pour avoir réussi la mission!")
    includedPlayers[source] = nil
end)

RegisterNetEvent("eventsbuilder_create")
AddEventHandler("eventsbuilder_create", function(token, builder)
    if not CheckToken(token, source, "eventsbuilder_create") then return end
    local source = source
    local license = getLicense(source)
    MySQL.Async.execute("INSERT INTO eventsPresets (createdBy, label, presetInfos) VALUES(@a, @b, @c)",
    {
        ['a'] = GetPlayerName(source),
        ['b'] = builder.name,
        ['c'] = json.encode(builder)
    }, function()
        updateEventsPresets()
        TriggerClientEvent("Extasy:showNotification", source, "~g~La mission ~y~"..builder.name.."~g~ a été créée")
    end)
end)

RegisterNetEvent("eventsbuilder_removemission")
AddEventHandler("eventsbuilder_removemission", function(token, eventID)
    if not CheckToken(token, source, "eventsbuilder_removemission") then return end
    local source = source
    local license = getLicense(source)
    if presets[eventID] == nil then
        TriggerClientEvent("Extasy:showNotification", source, "~r~Cette mission n'existe plus :( !")
        return
    end
    MySQL.Async.execute("DELETE FROM eventsPresets WHERE id = @a",
    {
        ['a'] = eventID
    }, function()
        TriggerClientEvent("Extasy:showNotification", source, "~g~La mission ~y~"..presets[eventID].label.."~g~ a été supprimée")
        updateEventsPresets()
    end)
end)

RegisterNetEvent("eventsbuilder_startMissionRoleplay")
AddEventHandler("eventsbuilder_startMissionRoleplay", function(token, missionID)
    if not CheckToken(token, source, "eventsbuilder_startMissionRoleplay") then return end
    local source = source
    local license = getLicense(source)
    if isMissionRunning then
        TriggerClientEvent("Extasy:showNotification", source, "~r~Une mission est déjà en cours !")
        return
    end
    includedPlayers = {}
    for k,v in pairs(ESX.GetPlayers()) do
        includedPlayers[v] = true
    end
    runningMissionID = missionID
    isMissionRunning = true
    TriggerClientEvent("Extasy:showNotification", source, "~g~Mission démarrée")
    start(missionID)
    -- FAIRE LE RESTE
end)

RegisterNetEvent("eventsbuilder_stopCurrentMission")
AddEventHandler("eventsbuilder_stopCurrentMission", function(token)
    if not CheckToken(token, source, "eventsbuilder_stopCurrentMission") then return end
    local source = source
    local license = getLicense(source)
    if isMissionRunning then
        isMissionRunning = false
        runningMissionID = nil
        TriggerClientEvent("Extasy:showNotification", source, "~g~La mission a été stoppée")
        TriggerClientEvent("eventsbuilder_receiveStop", -1)
        
    else
        TriggerClientEvent("Extasy:showNotification", source, "~r~Il n'y a aucune mission active!")
    end
end)

MySQL.ready(function()
    updateEventsPresets()
end)