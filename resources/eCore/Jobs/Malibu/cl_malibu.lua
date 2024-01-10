local index = 1
local playersInArea = {}
local inAreaData = {}
local JK = {}
JK.volume = 0.3
JK.sound = exports.xsound

InitMalibu = function()    
    registerSocietyFarmZone({
        pos           = vector3(3710.22, 6158.06, 9.02),
        spawnPoint    = {
            {pos = vector3(3709.18, 6169.76, 9.25), heading = 269.69},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage du Malibu",
        garage        = {
            {name     = "Speedo 3", hash = "speedo3"},
            {name     = "cognoscenti", hash = "cognoscenti"},
            {name     = "Stretch", hash = "stretch"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Malibu",
        size          = 2.5,
    })
    registerSocietyFarmZone({
        pos           = vector3(3709.23, 6169.82, 9.25),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Malibu",
        size          = 2.5,
    })

    registerSocietyFarmZone({
        pos      = vector3(3720.59, 6148.83, 14.45),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(3720.32, 6150.73, 10.30),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(3717.34, 6125.46, 10.23),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Malibu",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(3720.59, 6148.83, 14.45)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Malibu")
    EndTextCommandSetBlipName(aBlip)

    --

    registerSocietyFarmZone({
        pos      = vector3(2330.30, 7689.75, 10.97),
        type     = 1,
        item     = "Pinoit_noir",
        count    = 1,
        size     = 5.0,
        time     = 6000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter du pinot noir",
    })
    registerSocietyFarmZone({
        pos      = vector3(3258.48, 4653.66, 9.42),
        type     = 2,
        item     = "Pinoit_noir",
        item_g   = "Champagne",
        size     = 5.0,
        time     = 6000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour transformer en champagne",
    })
    registerSocietyFarmZone({
        pos      = vector3(3436.448, 4826.031, 10.03322),
        type     = 3,
        item     = "Champagne",
        price    = extasy_core_cfg["private_society_sell_price"],
        society  = playerJob,
        size     = 5.0,
        time     = 5000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour vendre vos bouteilles d'alcool",
    })

    local b = {
        {pos = vector3(2330.30, 7689.75, 10.97), sprite = 502, color = 48, scale = 0.60, title = "Malibu | Récolte alcool"},
        {pos = vector3(3258.48, 4653.66, 9.42), sprite = 503, color = 48, scale = 0.60, title = "Malibu | Traitement de l'alcool en bouteilles"},
        {pos = vector3(2561.94, 4685.25, 11.50), sprite = 504, color = 48, scale = 0.60, title = "Malibu | Vente de bouteilles"},
        {pos = vector3(3710.22, 6158.06, 9.02), sprite = 557, color = 48, scale = 0.60, title = "Malibu | Garage"},
        {pos = vector3(3709.23, 6169.82, 9.25), sprite = 557, color = 59, scale = 0.60, title = "Malibu | Rangement véhicule"},
    }
    
    for _, info in pairs(b) do
        info.blip = AddBlipForCoord(info.pos.x, info.pos.y, info.pos.z)
        SetBlipSprite(info.blip, info.sprite)
        SetBlipDisplay(info.blip, 4)
        SetBlipColour(info.blip, info.color)
        SetBlipScale(info.blip, info.scale)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end

malibu_inmenu = false

RMenu.Add('Malibu_menu', 'main_menu', RageUI.CreateMenu("Malibu", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('Malibu_menu', 'main_artifices', RageUI.CreateSubMenu(RMenu:Get('Malibu_menu', 'main_menu'), "Malibu", "Que souhaitez-vous faire ?"))
RMenu.Add('Malibu_menu', 'main_blacklist', RageUI.CreateSubMenu(RMenu:Get('Malibu_menu', 'main_menu'), "Bahama Mamas", "Que souhaitez-vous faire ?"))
RMenu.Add('Malibu_menu', 'main_blacklist_choose', RageUI.CreateSubMenu(RMenu:Get('Malibu_menu', 'main_blacklist'), "Bahama Mamas", "Qui souhaitez-vous blacklist ?"))
RMenu.Add('Malibu_menu', 'main_blacklist_list', RageUI.CreateSubMenu(RMenu:Get('Malibu_menu', 'main_blacklist'), "Bahama Mamas", "Que souhaitez-vous faire ?"))
RMenu.Add('Malibu_menu', 'main_citizen_billing', RageUI.CreateSubMenu(RMenu:Get('Malibu_menu', 'main_menu'), "Malibu", "Que souhaitez-vous faire ?"))
RMenu.Add('Malibu_menu', 'main_jukebox', RageUI.CreateSubMenu(RMenu:Get('Malibu_menu', 'main_menu'), "Malibu", "Que souhaitez-vous faire ?"))
RMenu:Get('Malibu_menu', 'main_menu').Closed = function()
    malibu_inmenu = false
end

openMalibu = function()
    if malibu_inmenu then
        malibu_inmenu = false
        return
    else
        malibu_inmenu = true
        RageUI.Visible(RMenu:Get('Malibu_menu', 'main_menu'), true)

        blacklistIndex = 1

        Citizen.CreateThread(function()
            while malibu_inmenu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('Malibu_menu', 'main_menu'), true, false, true, function()

                    RageUI.Button("Annonce Malibu", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                        if s then
                            a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                            if a ~= nil then
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Malibu', 'Publicité', a, 'CHAR_MALIBU')
                                end
                            else
                                Extasy.ShowNotification("~r~Message invalide")
                            end
                        end
                    end)
                    RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('Malibu_menu', 'main_citizen_billing'))                           
                    --RageUI.Button("Jukebox", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('Malibu_menu', 'main_jukebox')) #Désactivé pour le moment car pas xSound

                    --if DoesPlayerCanUseArtifices(playerJob, playerJob_grade) then
                        RageUI.Button("Artifices", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('Malibu_menu', 'main_artifices'))
                    --else
                    --    RageUI.Button("~c~Artifices", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function() end)
                    --end

                    --if DoesPlayerCanBlacklist(playerJob, playerJob_grade) then
                        --RageUI.Button("Blacklist", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('Malibu_menu', 'main_blacklist')) #Désactivé pour le moment car pas de coté server crée
                    --else
                    --    RageUI.Button("~c~Blacklist", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function() end)
                    --end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Malibu_menu', 'main_artifices'), true, false, true, function()

                    RageUI.Button("Feu d'artifices 'Progressif'", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            local playersInArea = {}

                            for _, player in ipairs(GetActivePlayers()) do
                                local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)

                                if dst < 50.0 then
                                    table.insert(playersInArea, GetPlayerServerId(player))
                                end
                            end

                            local firework = CreateObject(GetHashKey('ind_prop_firework_04'), GetEntityCoords(PlayerPedId()), true, false, false)
                            local fireworkID = NetworkGetNetworkIdFromEntity(firework)
                            SetNetworkIdCanMigrate(fireworkID, true)
                            PlaceObjectOnGroundProperly(firework)
                            FreezeEntityPosition(firework, true)
                            SetEntityVisible(firework, false, 0)

                            TriggerServerEvent("malibu:firework_1", token, playersInArea, {entity=fireworkID, asset="scr_indep_fireworks", name="scr_indep_firework_fountain", scale=0.25})
                        end
                    end)

                    RageUI.Button("Feu d'artifices 'Statique'", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            local playersInArea = {}

                            for _, player in ipairs(GetActivePlayers()) do
                                local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)

                                if dst < 50.0 then
                                    table.insert(playersInArea, GetPlayerServerId(player))
                                end
                            end

                            local firework = CreateObject(GetHashKey('ind_prop_firework_04'), GetEntityCoords(PlayerPedId()), true, false, false)
                            local fireworkID = NetworkGetNetworkIdFromEntity(firework)
                            SetNetworkIdCanMigrate(fireworkID, true)
                            PlaceObjectOnGroundProperly(firework)
                            FreezeEntityPosition(firework, true)
                            SetEntityVisible(firework, false, 0)

                            TriggerServerEvent("malibu:firework_2", token, playersInArea, {entity=fireworkID, asset="scr_indep_fireworks", name="scr_indep_firework_fountain", scale=0.25})
                        end
                    end)

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Malibu_menu', 'main_blacklist'), true, false, true, function()
                
                    RageUI.Button("Ajouter quelqu'un à la blacklist", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('Malibu_menu', 'main_blacklist_choose'))
                    RageUI.Button("Liste des personnes blacklist", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            TriggerServerEvent("easyBlacklist:get", token)
                        end
                    end, RMenu:Get('Malibu_menu', 'main_blacklist_list'))
                
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Malibu_menu', 'main_blacklist_list'), true, false, true, function()

                    for k,v in pairs(EBLCK.myBlacklistList) do
                        local name = replaceText('')
                        RageUI.Button(name.." ["..v.ID.."]", "La personne ne sera plus blacklist à "..v.date, {}, true, function(h, a, s)
                            if s then
                                TriggerServerEvent("easyBlacklist:remove", token, v.identifier)
                            end
                        end)
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Malibu_menu', 'main_blacklist_choose'), true, false, true, function()

                    RageUI.List("Temps", cfg_easyBlacklist.timeList, blacklistIndex, nil, {}, true, function(h, a, s, Index)
                        blacklistIndex = Index
                    end)

                    RageUI.Separator("")

                    for _, player in ipairs(GetActivePlayers()) do
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                        local sta = Extasy.IsMyId(player)
                        local coords = GetEntityCoords(GetPlayerPed(player))
                        local name = replaceText(player)
            
                        if dst < 3.0 then
                            -- if sta ~= "me" then
                                RageUI.Button(name.." #".._, nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                    if a then
                                        DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                    end
                                    if s then
                                        local table = {
                                            target  = GetPlayerServerId(player),
                                            time    = cfg_easyBlacklist.timeListR[blacklistIndex],
                                        }
                                        TriggerServerEvent("easyBlacklist:add", token, table)
                                    end
                                end)
                            -- end
                        end
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Malibu_menu', 'main_jukebox'), true, true, true, function()
            
                    if not JK.isPlaying then
                        RageUI.Button("Jouer une musique", nil, {}, true, function(h, a, s)
                            if s then
                                local i = nil

                                exports.xnlrankbar:openDialog("Indiquez le lien YouTube de votre musique", function(value)
                                    i = value
                                end)
                                while i == nil do Wait(1) end
                                i = tostring(i)

                                if string.len(i) > 3 then
                                    JK.link = i

                                    playersInArea = {}

                                    for _, player in ipairs(GetActivePlayers()) do
                                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                                    
                                        if dst < 50.0 then
                                            table.insert(playersInArea, GetPlayerServerId(player))
                                        end
                                    end
                                    TriggerServerEvent("Malibu:soundStatus", token, 'play', {link = JK.link, volume = JK.volume}, playersInArea)
                                end
                            end
                        end)
                    else
                        RageUI.Button("Synchroniser la musique avec tout le monde", nil, {}, true, function(h, a, s)
                            if s then
                                playersInArea = {}

                                for _, player in ipairs(GetActivePlayers()) do
                                    local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                                
                                    if dst < 50.0 then
                                        table.insert(playersInArea, GetPlayerServerId(player))
                                    end
                                end

                                TriggerServerEvent("Malibu:soundStatus", token, 'sync', {link = JK.link, time = JK.sound:getTimeStamp("yellowjack_music")}, playersInArea)
                            end
                        end)
                        RageUI.Button("Arrêter la musique", nil, {}, true, function(h, a, s)
                            if s then
                                playersInArea = {}

                                for _, player in ipairs(GetActivePlayers()) do
                                    local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                                
                                    if dst < 50.0 then
                                        table.insert(playersInArea, GetPlayerServerId(player))
                                    end
                                end

                                JK.link = nil
                                TriggerServerEvent("Malibu:soundStatus", token, 'stop', {}, playersInArea)
                            end
                        end)
                        RageUI.Button("Mettre une autre musique", nil, {}, true, function(h, a, s)
                            if s then
                                local i = nil

                                exports.xnlrankbar:openDialog("Indiquez le lien YouTube de votre musique", function(value)
                                    i = value
                                end)
                                while i == nil do Wait(1) end
                                i = tostring(i)

                                if string.len(i) > 3 then
                                    JK.link = i

                                    playersInArea = {}

                                    for _, player in ipairs(GetActivePlayers()) do
                                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                                    
                                        if dst < 50.0 then
                                            table.insert(playersInArea, GetPlayerServerId(player))
                                        end
                                    end
                                    TriggerServerEvent("Malibu:soundStatus", token, 'play', {link = JK.link, volume = JK.volume}, playersInArea)
                                end
                            end
                        end)
                    end
                    if JK.link ~= nil then
                        if not JK.isResume then
                            RageUI.Button("Mettre la musique sur lecture", nil, {}, true, function(h, a, s)
                                if s then
                                    playersInArea = {}

                                    for _, player in ipairs(GetActivePlayers()) do
                                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                                    
                                        if dst < 50.0 then
                                            table.insert(playersInArea, GetPlayerServerId(player))
                                        end
                                    end

                                    TriggerServerEvent("Malibu:soundStatus", token, 'resume', {link = JK.link, volume = JK.volume}, playersInArea)
                                    JK.isResume = true
                                end
                            end)
                        else
                            RageUI.Button("Mettre la musique sur pause", nil, {}, true, function(h, a, s)
                                if s then
                                    playersInArea = {}

                                    for _, player in ipairs(GetActivePlayers()) do
                                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                                    
                                        if dst < 50.0 then
                                            table.insert(playersInArea, GetPlayerServerId(player))
                                        end
                                    end

                                    TriggerServerEvent("Malibu:soundStatus", token, 'pause', {link = JK.link, volume = JK.volume}, playersInArea)
                                    JK.isResume = false
                                end
                            end)
                        end
                    end
                    if JK.link ~= nil then
                        RageUI.Button("Monter/baisser le volume de la musique", "Appuyez sur ENTRER pour valider", {RightLabel = "← "..JK.volume.."% →"}, true, function(h, a, s)
                            if a then
                                if IsControlJustPressed(0, 175) then
                                    if JK.volume + 0.05 < 1.05 then
                                        JK.volume = Extasy.Math.Round(JK.volume + 0.05, 2)
                                    else
                                        JK.volume = 0.0
                                    end
                                end
                                if IsControlJustPressed(0, 174) then
                                    if JK.volume - 0.05 > -0.05 then
                                        JK.volume = Extasy.Math.Round(JK.volume - 0.05, 2)
                                    else
                                        JK.volume = 1.0
                                    end
                                end
                            end
                            
                            if s then
                                playersInArea = {}

                                for _, player in ipairs(GetActivePlayers()) do
                                    local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                                
                                    if dst < 50.0 then
                                        table.insert(playersInArea, GetPlayerServerId(player))
                                    end
                                end
                                TriggerServerEvent("Malibu:soundStatus", token, 'volume', {link = i, volume = JK.volume}, playersInArea)
                            end
                        end)
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Malibu_menu', 'main_citizen_billing'), true, false, true, function()

                    for _, player in ipairs(GetActivePlayers()) do
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                        local sta = Extasy.IsMyId(player)
                        local coords = GetEntityCoords(GetPlayerPed(player))
                        local name = Extasy.ReplaceText(player)
            
                        if dst < 3.0 then
                            if sta ~= "me" then
                                RageUI.Button(name.." #".._, nil, {RightLabel = curr_pl_billing}, true, function(Hovered, Active, Selected)
                                    if (Active) then
                                        DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                        curr_pl_billing = ""
                                    else
                                        curr_pl_billing = "💰"
                                    end
                                    if (Selected) then
                                        i = Extasy.KeyboardInput("Définissez le montant", "", 10)
                                        i = tonumber(i)
                                        if i ~= nil then
                                            if i > 0 then
                                                if string.sub(i, 1, string.len("-")) == "-" then
                                                    Extasy.ShowNotification("~r~Quantité invalide")
                                                else
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                    TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", -1, true)

                                                    Wait(2500)
                                                    TriggerServerEvent('malibu:sendBilling', token, "Facture Malibu", i, "malibu", GetPlayerServerId(player), false, nil)
                                                end
                                            else
                                                Extasy.ShowNotification("~r~Montant invalide")
                                            end
                                        else
                                            Extasy.ShowNotification("~r~Montant invalide")
                                        end
                                    end
                                end)
                            end
                        end
                    end

                end, function()
                end)
            end
        end)
    end
end

RegisterNetEvent("Malibu:sendMusicForArea")
AddEventHandler("Malibu:sendMusicForArea", function(_name, _music, _coords, _last_music)
    xSound:PlayUrlPos(_name, _music, 0.07, _coords, false)
    xSound:Distance(_name, 30.0)
    xSound:setVolumeMax(_name, 0.07)
    xSound:onPlayEnd(_name, function(event)  
        TriggerServerEvent("Malibu:boolisPlaying", token)
    end)
    table.insert(soundList, {
        name = _name,
        pos = _coords,
        dst = 30.0,
        link = _music,
        title = _name,
        volume = 0.07,
        pause = false,
    })
end)

RegisterNetEvent("Malibu:soundStatus")
AddEventHandler("Malibu:soundStatus", function(type, musicId, data)
    if type == "play" then
        JK.sound:PlayUrlPos(musicId, data.link, data.volume, vector3(375.3, 275.91, 91.4), false)
        JK.sound:Distance(musicId, 30)

        JK.isPlaying = true
        JK.isResume = true
    end

    if type == "stop" then
        JK.sound:Destroy(musicId)

        JK.isPlaying = false
        JK.isResume = false
    end

    if type == "resume" then
        if JK.sound:isPaused(musicId) then
            JK.sound:Resume(musicId)
        end

        JK.isPlaying = true
        JK.isResume = true
    end

    if type == "pause" then
        if not JK.sound:isPaused(musicId) then
            JK.sound:Pause(musicId)
        end

        JK.isPlaying = true
        JK.isResume = false
    end

    if type == "sync" then
        if JK.sound:soundExists(musicId) then
            JK.sound:setTimeStamp(musicId, data.time)
        else
            JK.sound:PlayUrlPos(musicId, data.link, data.volume, vector3(375.3, 275.91, 91.4), false)
            JK.sound:Distance(musicId, 20)

            JK.sound:setTimeStamp(musicId, data.time)

            JK.isPlaying = true
            JK.isResume = true
        end
    end

    if type == "volume" then
        JK.sound:setVolume(musicId, data.volume)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(cfg_malibu.blip) do
        b = AddBlipForCoord(v.pos)
        SetBlipSprite(b, v.sprite)
        SetBlipDisplay(b, v.display)
        SetBlipScale(b, v.scale)
        SetBlipColour(b, v.colour)
        SetBlipAsShortRange(b, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.name)
        EndTextCommandSetBlipName(b)
    end
end)