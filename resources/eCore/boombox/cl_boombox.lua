BB = {}
local inAction = false
local isPlaying = false
local bModel = "prop_boombox_01"
local bAnimDict = "missheistdocksprep1hold_cellphone"
local bAnimName = "hold_cellphone"
local netID = nil
local sound = exports.Ambiance
local isAsked = false
local currentLink = nil
local currentVolume = 0.35
local isPause = false
local currentColorWaiting = "~s~"
local args = {}
local showHelp = true
local inboombox = false


RegisterCommand("link", function(source, args)
    if inboombox then 
        local musicId = "music_id_" .. PlayerPedId()

        playersInArea = {}

        for _, player in ipairs(GetActivePlayers()) do
            local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)

            if dst < 50.0 then
                table.insert(playersInArea, GetPlayerServerId(player))
            end
        end

        currentLink = args[1]
        TriggerServerEvent("boombox:soundStatus", token, "play", musicId, { position = GetEntityCoords(GetPlayerPed(-1)), link = currentLink, time = 0, volume = currentVolume }, playersInArea)
        isPlaying = true
        Citizen.CreateThread(function()
            Citizen.Wait(120)
            while isPlaying do
                Citizen.Wait(120) 
                TriggerServerEvent("boombox:soundStatus", token, "position", musicId, { position = GetEntityCoords(GetPlayerPed(-1)), link = currentLink, volume = currentVolume }, playersInArea)
            end
        end)
    else
        Extasy.ShowNotification("TU n'as pas de boombox")
    end
end)



RegisterNetEvent("item:Boombox")
AddEventHandler("item:Boombox", function()
    if getPlayerVip() ~= "AUCUN" then
        useBoombox()
        inboombox = true
    else
        Extasy.ShowNotification("~r~Vous devez être minimum ~g~GOLDEN~s~ pour utiliser une enceinte")
    end
end)

useBoombox = function()
    RageUI.CloseAll()
    inboombox = true


    RequestModel(GetHashKey(bModel))
    while not HasModelLoaded(GetHashKey(bModel)) do
        Citizen.Wait(100)
    end
    
    while not HasAnimDictLoaded(bAnimDict) do
        RequestAnimDict(bAnimDict)
        Citizen.Wait(100)
    end

    local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
    local boomSpawned = CreateObject(GetHashKey(bModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)

    Citizen.Wait(1000)
    
    local netid = ObjToNet(boomSpawned)
    SetNetworkIdExistsOnAllMachines(netid, true)
    NetworkSetNetworkIdDynamic(netid, true)
    SetNetworkIdCanMigrate(netid, false)
    AttachEntityToEntity(boomSpawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 57005), 0.30, 0, 0, 0, 260.0, 60.0, true, true, false, true, 1, true)
    TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0)
    TaskPlayAnim(GetPlayerPed(PlayerId()), bAnimDict, bAnimName, 1.0, -1, -1, 50, 0, 0, 0, 0)

    netID = netid
    inAction = true
    
    Citizen.CreateThread(function()
        while inAction do
            if not isPlaying then
                Extasy.ShowHelpNotification("Appuyez sur ~INPUT_FRONTEND_RRIGHT~ pour ranger l'enceinte\nFaites ~p~/link [lien Youtube]~s~ pour jouer une musique\nExemple: ~c~/link https://www.youtube.com/watch?v=91z2LmQVAXs")
            else
                if showHelp then
                    Extasy.ShowHelpNotification("Appuyez sur ~INPUT_FRONTEND_RRIGHT~ pour ranger l'enceinte\nAppuyez sur ~INPUT_VEH_DUCK~ pour cacher le menu\n\nFaites ~p~/link [lien Youtube]~s~ pour jouer une musique\nExemple: ~c~/link https://www.youtube.com/watch?v=91z2LmQVAXs\n\n~s~Appuyez sur ~INPUT_CONTEXT~ pour synchroniser la musique avec tout le monde~s~\nAppuyez sur ~INPUT_MP_TEXT_CHAT_TEAM~ pour stopper la musique\nAppuyez sur ~INPUT_FRONTEND_RIGHT_AXIS_Y~ ("..currentVolume.."%) pour régler le volume")
                else
                    Extasy.ShowHelpNotification("Appuyez sur ~INPUT_VEH_DUCK~ pour afficher le menu de l'enceinte")
                end
            end

            if IsControlJustPressed(0, 73) then
                showHelp = not showHelp
            end

            if showHelp then
                if IsControlJustPressed(0, 194) then
                    Wait(1000)
                    removeBoombox()
                end

                if IsControlJustPressed(0, 246) then
                    isPlaying = false
                    Wait(1000)
                    stopBoombox()
                end

                if IsControlJustPressed(0, 38) then
                    if not isAsked then
                        syncBoombox()
                        isAsked = true
                    end
                end

                if IsControlJustPressed(0, 14) then
                    volumeBooxbox("less")
                end

                if IsControlJustPressed(0, 15) then
                    volumeBooxbox("more")
                end
            end

            Citizen.Wait(0)

        end
    end)
end


stopBoombox = function()
    local musicId = "music_id_" .. PlayerPedId()
    playersInArea = {}

    for _, player in ipairs(GetActivePlayers()) do
        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
    
        if dst < 50.0 then
            table.insert(playersInArea, GetPlayerServerId(player))
        end
    end
    TriggerServerEvent("boombox:soundStatus", token, "stop", musicId, {}, playersInArea)
    isPlaying = false
end

volumeBooxbox = function(v)
    local musicId = "music_id_" .. PlayerPedId()
    playersInArea = {}

    for _, player in ipairs(GetActivePlayers()) do
        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)

        if dst < 50.0 then
            table.insert(playersInArea, GetPlayerServerId(player))
        end
    end

    if v == "more" then
        if currentVolume + 0.05 < 1.05 then
            currentVolume = Extasy.Math.Round(currentVolume + 0.05, 2)
            needEditArgs = true
        end
        TriggerServerEvent("boombox:soundStatus2", token, "volume", musicId, { position = GetEntityCoords(GetPlayerPed(-1)), link = currentLink, volume = currentVolume }, playersInArea)
    end
    
    if v == "less" then
        if currentVolume - 0.05 > -0.05 then
            currentVolume = Extasy.Math.Round(currentVolume - 0.05, 2)
            needEditArgs = true
        end
        TriggerServerEvent("boombox:soundStatus2", token, "volume", musicId, { position = GetEntityCoords(GetPlayerPed(-1)), link = currentLink, volume = currentVolume }, playersInArea)
    end
end

syncBoombox = function()
    local musicId = "music_id_" .. PlayerPedId()
    playersInArea = {}

    for _, player in ipairs(GetActivePlayers()) do
        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)

        if dst < 50.0 then
            table.insert(playersInArea, GetPlayerServerId(player))
        end
    end

    TriggerServerEvent("boombox:soundStatus", token, "sync", musicId, { position = GetEntityCoords(GetPlayerPed(-1)), link = currentLink, time = sound:getTimeStamp(musicId) }, playersInArea)
end

removeBoombox = function()
    inAction = false
    isPlaying = false
    isAsked = false
    inboombox = false
    showHelp = false

    ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
    DetachEntity(NetToObj(netID), 1, 1)
    DeleteEntity(NetToObj(netID))
    netID = nil

    local musicId = "music_id_" .. PlayerPedId()
    playersInArea = {}

    for _, player in ipairs(GetActivePlayers()) do
        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
    
        if dst < 50.0 then
            table.insert(playersInArea, GetPlayerServerId(player))
        end
    end

    TriggerServerEvent("boombox:soundStatus", token, "stop", musicId, {}, playersInArea)
end

RegisterNetEvent("boombox:soundStatus")
AddEventHandler("boombox:soundStatus", function(type, musicId, data)
    if type == "position" then
        if sound:soundExists(musicId) then
            sound:Position(musicId, data.position)
        else
            sound:PlayUrlPos(musicId, data.link, data.volume, data.position, false)
            sound:Distance(musicId, 20)
        end

        if sound:isPaused(musicId) then
            sound:Resume(musicId)
        end
    end

    if type == "play" then
        sound:PlayUrlPos(musicId, data.link, data.volume, data.position, false)
        sound:Distance(musicId, 20)
    end

    if type == "stop" then
        sound:Destroy(musicId)
    end

    if type == "pause" then
        if not sound:isPaused(musicId) then
            sound:Pause(musicId)
        end
    end

    if type == "sync" then
        sound:setTimeStamp(musicId, data.time)
    end

    if type == "volume" then
        sound:setVolume(musicId, data.volume)
    end
end)