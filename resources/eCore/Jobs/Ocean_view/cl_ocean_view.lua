local index = 1
local playersInArea = {}
local inAreaData = {}
local JK = {}
local bestOceanviewSeller = {}
local showLeaderboard = true
local askedData = false
JK.volume = 0.3
JK.sound = exports.xsound

InitOceanView = function()    
    registerSocietyFarmZone({
        pos           = vector3(3447.42, 4917.36, 11.03),
        spawnPoint    = {
            {pos = vector3(3445.87, 4932.81, 9.54), heading = 346.80},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage du Ocean View",
        garage        = {
            {name     = "Pounder 2", hash = "pounder2"},
            {name     = "Rumpo", hash = "rumpo"},
            {name     = "Stretch", hash = "stretch"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Ocean View",
        size          = 2.5,
    })
    registerSocietyFarmZone({
        pos           = vector3(3445.87, 4932.81, 9.54),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Ocean View",
        size          = 2.5,
    })

    registerSocietyFarmZone({
        pos      = vector3(3465.10, 4931.93, 11.03),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(3462.55, 4932.97, 11.03),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(3478.77, 4941.78, 19.06),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Ocean View",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(3465.10, 4931.93, 11.03)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Ocean View")
    EndTextCommandSetBlipName(aBlip)

    --

    registerSocietyFarmZone({
        pos      = vector3(2621.36, 4731.47, 11.55),
        type     = 1,
        item     = "patate",
        count    = 1,
        size     = 2.0,
        time     = 6000,
        marker   = true,
        msg      = "Appuyez sur ~INPUT_CONTEXT~ pour prendre ~p~des Pommes de terre",
    })
    registerSocietyFarmZone({
        pos      = vector3(3459.2, 4911.02, 11.03),
        type     = 2,
        item     = "patate",
        item_g   = "frite",
        size     = 2.0,
        time     = 6000,
        marker   = true,
        msg      = "Appuyez sur ~INPUT_CONTEXT~ pour frire vos pommes de terre",
    })
    registerSocietyFarmZone({
        pos      = vector3(2538.78, 7467.64, 10.76),
        type     = 3,
        item     = "frite",
        price    = extasy_core_cfg["private_society_sell_price"],
        society  = playerJob,
        size     = 3.0,
        time     = 5000,
        marker   = true,
        msg      = "Appuyez sur ~INPUT_CONTEXT~ pour vendre vos frites",
    })

    local b = {
        {pos = vector3(2608.67, 4699.92, 11.55), sprite = 502, color = 6, scale = 0.60, title = "Ocean View | Récolte cabillaud"},
        {pos = vector3(2621.36, 4731.47, 11.55), sprite = 502, color = 6, scale = 0.60, title = "Ocean View | Récolte pommes de terre"},
        {pos = vector3(3459.2, 4911.02, 11.03), sprite = 503, color = 6, scale = 0.60, title = "Ocean View | Cuisine"},
        {pos = vector3(2536.84, 7467.54, 10.76), sprite = 504, color = 6, scale = 0.60, title = "Ocean View | Vente fish & chips"},
        {pos = vector3(3447.42, 4917.36, 11.03), sprite = 557, color = 6, scale = 0.60, title = "Ocean View | Garage"},
        {pos = vector3(3445.87, 4932.81, 9.54), sprite = 557, color = 6, scale = 0.60, title = "Ocean View | Rangement véhicule"},
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

    Citizen.CreateThread(function()
        while true do
    
            local nearThing = false
    
            for k,l in pairs(cfg_ocean_view.leaderboard) do
                local dst = GetDistanceBetweenCoords(l.pos, GetEntityCoords(PlayerPedId()), false)
    
                if dst < 5.0 then
                    nearThing = true
    
                    if showLeaderboard then
                        Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + 2.39), "~s~[G] pour cacher le tableau", 0.75)
                        Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + 2.35), "~p~Tableau des employées~s~", 1.75)
    
                        local zOffset = 0
                        zOffset = 0.230*9
                        for k,v in pairs(bestOceanviewSeller) do
                            print(k)
                            if k == 1 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~y~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            elseif k == 2 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~r~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            elseif k == 3 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~w~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            elseif k == 4 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            elseif k == 5 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            elseif k == 6 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            elseif k == 7 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            elseif k == 8 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            elseif k == 9 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            elseif k == 10 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            elseif k == nil then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." bouteille(s) vendu ~s~", 1.0)
                            end

                            zOffset = zOffset - 0.150
                        end
                    end
                end
            end
    
            if IsControlJustPressed(0, 47) then
                showLeaderboard = not showLeaderboard
            end
    
            if nearThing then
                Wait(0)
            else
                Wait(3000)
            end
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Wait(2000)
            for k,v in pairs(cfg_ocean_view.leaderboard) do
                local dst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
    
                if dst < 5.0 then
                    if not askedData then
                        TriggerServerEvent("ocean_view:getLeaderboard", token)
                    end
                end
            end
        end
    end)

    Draw2DText = function(x, y, text, scale)
        SetTextFont(4)
        SetTextProportional(7)
        SetTextScale(scale, scale)
        SetTextColour( 198, 25, 66, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
    end
end

oceanview_inmenu = false

RMenu.Add('oceanview_menu', 'main_menu', RageUI.CreateMenu("Ocean View", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('oceanview_menu', 'main_artifices', RageUI.CreateSubMenu(RMenu:Get('oceanview_menu', 'main_menu'), "Ocean View", "Que souhaitez-vous faire ?"))
RMenu.Add('oceanview_menu', 'main_blacklist', RageUI.CreateSubMenu(RMenu:Get('oceanview_menu', 'main_menu'), "Bahama Mamas", "Que souhaitez-vous faire ?"))
RMenu.Add('oceanview_menu', 'main_blacklist_choose', RageUI.CreateSubMenu(RMenu:Get('oceanview_menu', 'main_blacklist'), "Bahama Mamas", "Qui souhaitez-vous blacklist ?"))
RMenu.Add('oceanview_menu', 'main_blacklist_list', RageUI.CreateSubMenu(RMenu:Get('oceanview_menu', 'main_blacklist'), "Bahama Mamas", "Que souhaitez-vous faire ?"))
RMenu.Add('oceanview_menu', 'main_citizen_billing', RageUI.CreateSubMenu(RMenu:Get('oceanview_menu', 'main_menu'), "Ocean View", "Que souhaitez-vous faire ?"))
RMenu.Add('oceanview_menu', 'main_jukebox', RageUI.CreateSubMenu(RMenu:Get('oceanview_menu', 'main_menu'), "Ocean View", "Que souhaitez-vous faire ?"))
RMenu:Get('oceanview_menu', 'main_menu').Closed = function()
    oceanview_inmenu = false
end

OpenOceanviewMenu = function()
    if oceanview_inmenu then
        oceanview_inmenu = false
        return
    else
        oceanview_inmenu = true
        RageUI.Visible(RMenu:Get('oceanview_menu', 'main_menu'), true)

        blacklistIndex = 1

        Citizen.CreateThread(function()
            while oceanview_inmenu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('oceanview_menu', 'main_menu'), true, false, true, function()

                    RageUI.Button("Annonce Ocean View", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                        if s then
                            a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                            if a ~= nil then
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Ocean View', '~p~Publicité', a, 'CHAR_OCEANVIEW', 2, "Ocean View")
                                end
                            else
                                Extasy.ShowNotification("~r~Message invalide")
                            end
                        end
                    end)

                    RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('oceanview_menu', 'main_citizen_billing'))  
                    
                    RageUI.Button("Réinitialisation du tableau employer", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                        if s then
                            TriggerServerEvent("Jobs:resetLeaderboard", token, "oceanview")
                            Wait(1000)
                            Extasy.ShowNotification("~g~Le tableau des employé a bien été réinitialisé")
                        end
                    end)  

                    --RageUI.Button("Jukebox", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('oceanview_menu', 'main_jukebox')) #Désactivé pour le moment car pas xSound

                    --if DoesPlayerCanUseArtifices(playerJob, playerJob_grade) then
                        RageUI.Button("Artifices", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('oceanview_menu', 'main_artifices'))
                    --else
                    --    RageUI.Button("~c~Artifices", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function() end)
                    --end

                    --if DoesPlayerCanBlacklist(playerJob, playerJob_grade) then
                        --RageUI.Button("Blacklist", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('oceanview_menu', 'main_blacklist')) #Désactivé pour le moment car pas de coté server crée
                    --else
                    --    RageUI.Button("~c~Blacklist", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function() end)
                    --end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('oceanview_menu', 'main_artifices'), true, false, true, function()

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

                            TriggerServerEvent("ocean_view:firework_1", token, playersInArea, {entity=fireworkID, asset="scr_indep_fireworks", name="scr_indep_firework_fountain", scale=0.25})
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

                            TriggerServerEvent("ocean_view:firework_2", token, playersInArea, {entity=fireworkID, asset="scr_indep_fireworks", name="scr_indep_firework_fountain", scale=0.25})
                        end
                    end)

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('oceanview_menu', 'main_blacklist'), true, false, true, function()
                
                    RageUI.Button("Ajouter quelqu'un à la blacklist", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('oceanview_menu', 'main_blacklist_choose'))
                    RageUI.Button("Liste des personnes blacklist", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            TriggerServerEvent("easyBlacklist:get", token)
                        end
                    end, RMenu:Get('oceanview_menu', 'main_blacklist_list'))
                
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('oceanview_menu', 'main_blacklist_list'), true, false, true, function()

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

                RageUI.IsVisible(RMenu:Get('oceanview_menu', 'main_blacklist_choose'), true, false, true, function()

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

                RageUI.IsVisible(RMenu:Get('oceanview_menu', 'main_jukebox'), true, true, true, function()
            
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
                                    TriggerServerEvent("oceanview:soundStatus", token, 'play', {link = JK.link, volume = JK.volume}, playersInArea)
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

                                TriggerServerEvent("oceanview:soundStatus", token, 'sync', {link = JK.link, time = JK.sound:getTimeStamp("yellowjack_music")}, playersInArea)
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
                                TriggerServerEvent("oceanview:soundStatus", token, 'stop', {}, playersInArea)
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
                                    TriggerServerEvent("oceanview:soundStatus", token, 'play', {link = JK.link, volume = JK.volume}, playersInArea)
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

                                    TriggerServerEvent("oceanview:soundStatus", token, 'resume', {link = JK.link, volume = JK.volume}, playersInArea)
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

                                    TriggerServerEvent("oceanview:soundStatus", token, 'pause', {link = JK.link, volume = JK.volume}, playersInArea)
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
                                TriggerServerEvent("oceanview:soundStatus", token, 'volume', {link = i, volume = JK.volume}, playersInArea)
                            end
                        end)
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('oceanview_menu', 'main_citizen_billing'), true, false, true, function()

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
                                                    TriggerServerEvent('oceanview:sendBilling', token, "Facture Ocean View", i, "oceanview", GetPlayerServerId(player), false, nil)
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

RegisterNetEvent("oceanview:sendMusicForArea")
AddEventHandler("oceanview:sendMusicForArea", function(_name, _music, _coords, _last_music)
    xSound:PlayUrlPos(_name, _music, 0.07, _coords, false)
    xSound:Distance(_name, 30.0)
    xSound:setVolumeMax(_name, 0.07)
    xSound:onPlayEnd(_name, function(event)  
        TriggerServerEvent("oceanview:boolisPlaying", token)
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

RegisterNetEvent("oceanview:soundStatus")
AddEventHandler("oceanview:soundStatus", function(type, musicId, data)
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
    for k,v in pairs(cfg_ocean_view.blip) do
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

RegisterNetEvent("ocean_view:sendLeaderboard")
AddEventHandler("ocean_view:sendLeaderboard", function(data)
    bestOceanviewSeller = data
end)