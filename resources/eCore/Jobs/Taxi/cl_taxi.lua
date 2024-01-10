InitTaxi = function()
    registerSocietyFarmZone({ 
        pos           = vector3(2247.05, 6416.37, 10.38),
        spawnPoint    = {
            {pos = vector3(2243.98, 6411.72, 10.35), heading = 173.60},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage Downtown Cab Co",
        garage        = {
            {name     = "Taxi", hash = "taxi32"},
            {name     = "Taxi-Bus", hash = "rentalbus"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Downtown Cab Co",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(2243.98, 6411.72, 10.35),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Downtown Cab Co",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos      = vector3(2254.59, 6387.64, 11.39),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(2255.05, 6391.18, 11.39),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2255.22, 6405.18, 14.18),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Downtown Cab Co",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(2254.59, 6387.64, 11.39)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Downtown Cab Co")
    EndTextCommandSetBlipName(aBlip)

    local b = {
        {pos = vector3(2255.02, 6391.18, 10.39), sprite = 557, color = 2,  scale = 0.60, title = "Downtown Cab Co | Coffre d'entreprise"},
        {pos = vector3(2255.22, 6405.81, 13.18), sprite = 557, color = 3,  scale = 0.60, title = "Downtown Cab Co | Vestaire"},
        {pos = vector3(2247.05, 6416.37, 10.38), sprite = 557, color = 17, scale = 0.60, title = "Downtown Cab Co | Garage"},
        {pos = vector3(2243.98, 6411.72, 10.35), sprite = 557, color = 59, scale = 0.60, title = "Downtown Cab Co | Rangement véhicule"},
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

    local perKilometer = 500
    local min = 50

    local perGTAHourDay = 10
    local perGTAHourNight = 15

    local averageV = 0
    local total = 0
    local price = 0
    local maxPrice = 0

    local night = false
    local started = false
    local time = 0
    local waypoint = false

    Extasy.RegisterControlKey("taxi_metter", "Ouvrir le compteur taxi", "", function()
        if not playerIsOnKeyBoard then
            if not playerIsDead == 0 then
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
            else
                if IsWaypointActive() then
                    total = 0
                    time = 0
                    price = 0
                    maxPrice = 0
                    started = false
                    Wait(5)
                    started = true
                    taxiCabCalculate()
                else
                    Extasy.ShowNotification("~r~Vous devez avoir un point GPS pour que le calcul s'effectue")
                end
            end
        end
    end)

    Extasy.RegisterControlKey("taxi_metter_clear", "Rénitialiser le compteur taxi", "", function()
        if not playerIsOnKeyBoard then
            if not playerIsDead == 0 then
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
            else
                total = 0
                time = 0
                price = 0
                maxPrice = 0
                waypoint = false
                started = false
            end
        end
    end)

    taxiCabCalculate = function()
        waypoint = true
        while waypoint do
            Wait(500)
            local player = GetPlayerPed(-1)
            local plVehicle = GetLastDrivenVehicle(player)
            waypoint = IsWaypointActive()
            
            time = time + 1
            total = total + GetEntitySpeed(plVehicle) * 3.6
            averageV = total / time
    
            local distance = averageV * time / 3600 / 20
    
            price = (min + perKilometer * distance + (time / 600 * perGTAHourDay))
        
            CreateThread(function()
                while waypoint do

                    Extasy.ShowHelpNotification("Course en cours...\nPrix actuel: ~g~"..tostring(Extasy.Math.Round(price, 1)).."$")

                    Wait(1)
                end
            end)
        end
        total = 0
        time = 0
        started = false
        maxPrice = price * 2.0
        Extasy.ShowAdvancedNotification('Downtown Cab Co', 'Course terminée', "Prix de la course: "..tostring(Extasy.Math.Round(price, 1)).."$\n~s~Vous pouvez facturer le client jusqu'à "..tostring(Extasy.Math.Round(maxPrice, 1)).."$", 'CHAR_TAXI')
        -- TODO: log finish in a taxi log channel with the price and x2 price to proof it
    end

    taxicab_in_menu = false
    local callBlips = {}
    local inTCLoop  = false
    local playerIsTaxiCabMission = false
    missionTaxiCabStop = false

    RMenu.Add('taxicab_menu', 'main_menu', RageUI.CreateMenu("Downtown Cab Co", "Que souhaitez-vous faire ?", 1, 100))
    RMenu.Add('taxicab_menu', 'main_service', RageUI.CreateSubMenu(RMenu:Get('taxicab_menu', 'main_menu'), "Downtown Cab Co", "Que souhaitez-vous faire ?"))
    RMenu.Add('taxicab_menu', 'main_centrale', RageUI.CreateSubMenu(RMenu:Get('taxicab_menu', 'main_menu'), "Downtown Cab Co", "Que souhaitez-vous faire ?"))
    RMenu.Add('taxicab_menu', 'main_centrale_calls_list', RageUI.CreateSubMenu(RMenu:Get('taxicab_menu', 'main_menu'), "Downtown Cab Co", "Que souhaitez-vous faire ?"))
    RMenu.Add('taxicab_menu', 'main_citizen_billing', RageUI.CreateSubMenu(RMenu:Get('taxicab_menu', 'main_menu'), "Downtown Cab Co", "Que souhaitez-vous faire ?"))
    RMenu:Get('taxicab_menu', 'main_menu').Closed = function()
        taxicab_in_menu = false
    end

    opentaxicab = function()
        if taxicab_in_menu then
            taxicab_in_menu = false
            return
        else
            taxicab_in_menu = true
            RageUI.Visible(RMenu:Get('taxicab_menu', 'main_menu'), true)

            Citizen.CreateThread(function()
                while taxicab_in_menu do
                    Wait(1)
                    RageUI.IsVisible(RMenu:Get('taxicab_menu', 'main_menu'), true, false, true, function()

                        RageUI.Button("État de service", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('taxicab_menu', 'main_service'))                           
                        --RageUI.Button("Centrale", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('taxicab_menu', 'main_centrale'))
                        RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('taxicab_menu', 'main_citizen_billing'))                           

                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('taxicab_menu', 'main_centrale'), true, false, true, function()
                
                        RageUI.Button("Annuler l'appel en cours", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                for k,v in ipairs(callList) do
                                    if v.taked then
                                        table.remove(callList, k)
                                    end
                                end
                                for k,v in pairs(callBlips) do
                                    RemoveBlip(v)
                                end
                            end
                        end)
                        RageUI.Button("Appels reçus", nil, {RightLabel = "→→→"}, true, function(h, a, s) end, RMenu:Get('taxicab_menu', 'main_centrale_calls_list'))
                        RageUI.Button("Effacer la liste des appels", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                for k,v in ipairs(callList) do
                                    table.remove(callList, k)
                                end
                            end
                        end)
                    
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('taxicab_menu', 'main_centrale_calls_list'), true, false, true, function()
            
                        for k,v in ipairs(callList) do
                            if not v.taked then
                                RageUI.Button("Appel #"..k.." ("..v.map..")", "Heure d'appel: "..v.date.."\nRaison d'appel: "..v.reason.." (ID: "..v.serverID..")\nNuméro: "..v.number, {RightLabel = "~R~EN ATTENTE"}, true, function(h, a, s)
                                    if s then
                                        TaxiCabTakeCall(v.serverID, v.coords)
                                        TriggerServerEvent("jobCounter:sendMsgToJobClients", token, "taxicab", "L'appel #"..k.." a été pris par ~g~"..playerIdentity.prenom.." "..playerIdentity.nom)
                                        TriggerServerEvent("jobCounter:refreshCallsForClients", token, "taxicab", k, playerIdentity.prenom.." "..playerIdentity.nom)
                                        -- TriggerServerEvent("jobCounter:sendAdvancedMsgToPlayerFromJob", token, v.serverID, 'Downtown Cab Co', 'Informations', 'Un taxi vient de prendre votre appel\nRestez à votre position, il arrive !', 'CHAR_TAXI', 8)
                                        TriggerServerEvent("jobCounter:sendMsgToPlayerFromJob", token, v.serverID, "~g~Un taxi a pris votre appel !")
                                    end
                                end)
                            else
                                RageUI.Button("Appel #"..k.." ("..v.map..")", "Heure d'appel: "..v.date.."\nRaison d'appel: "..v.reason.." (ID: "..v.serverID..")\nNuméro: "..v.number, {RightLabel = "~g~PRIS ("..v.name..")"}, true, function(h, a, s)
                                    if s then
                                        TaxiCabTakeCall(v.serverID, v.coords)
                                    end
                                end)
                            end
                        end
                    
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('taxicab_menu', 'main_service'), true, false, true, function()

                        if playerInService then
                            RageUI.Button("État de service", nil, {RightLabel = "✅"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    playerInService = not playerInService
    
                                    inTCLoop = false
                                    missionTaxiCabStop = true

                                    TriggerServerEvent("Jobs:remove", token, playerJob)
                                    startServiceLoop()
                                end
                            end)
                        else
                            RageUI.Button("État de service", nil, {RightLabel = "❌"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    playerInService = not playerInService
    
                                    startTCLoop()

                                    TriggerServerEvent("Jobs:add", token, playerJob)
                                end
                            end)
                        end

                        RageUI.Button("Annonce Downtown Cab Co", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                            if s then
                                a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                                if a ~= nil then
                                    if string.sub(a, 1, string.len("-")) == "-" then
                                        Extasy.ShowNotification("~r~Quantité invalide")
                                    else
                                        if string.len(a) > 5 then
                                            TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Downtown Cab Co', 'Publicité', a, 'CHAR_TAXI')
                                        end
                                   end
                                else
                                    Extasy.ShowNotification("~r~Heure invalide")
                                end
                            end
                        end)

                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('taxicab_menu', 'main_citizen_billing'), true, false, true, function()

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
                                                        if i <= maxPrice then
                                                            ClearPedTasks(GetPlayerPed(-1))
                                                            TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", -1, true)

                                                            Wait(2500)
                                                            TriggerServerEvent('taxi:sendBilling', token, "Facture Downtown Cab Co", i, "taxi", GetPlayerServerId(player), true, 'taxicab:processBilling', i * extasy_core_cfg["taxi_global_mult"])
                                                            RageUI.CloseAll()
                                                            taxicab_in_menu = false
                                                            maxPrice = 0
                                                        else
                                                            Extasy.ShowNotification("~r~Le montant dépasse votre limite de facturation de la course\n"..i.."$/"..maxPrice.."$")
                                                        end
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

    RegisterNetEvent("taxicab:processBilling")
    AddEventHandler("taxicab:processBilling", function()
        Extasy.ShowAdvancedNotification('Downtown Cab Co', 'Facturation course', tostring(Extasy.Math.Round(maxPrice * 0.25, 1)).."$ pour la société\n"..tostring(Extasy.Math.Round(maxPrice * 0.75, 1)).."$", 'CHAR_TAXI', 8)
        TriggerServerEvent("rF:AddSocietyMoney", token, playerJob, maxPrice * 0.25)
        TriggerServerEvent("rF:AddMoney", token, maxPrice * 0.75)
    end)

    startTCLoop = function()
        inTCLoop = true
        Citizen.CreateThread(function()
            while inTCLoop do
                local rSeed   = GetGameTimer()
                math.randomseed(rSeed)
                local pChance = math.random(1, 1000000)

                if pChance < extasy_core_cfg["taxi_min_chance_npc_mission"] then
                    processTCMission()
                end

                Wait(1000)
            end
        end)

        Citizen.CreateThread(function()
            while inTCLoop do

                Extasy.ShowHelpNotification("Recherche de client en cours...\nRoulez en ville pour trouver un client")

                Wait(1)
            end
        end)
    end

    local blip = nil
    processTCMission = function()
        inTCLoop = false
        Citizen.CreateThread(function()
            local dst   = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 350.0, -1400.0, 0.0, false)
            local dTogo = nil
            local sTogo = nil
            local rPed  = nil
            local cPed  = nil
    
            dTogo = cfg_taxicab.doors[math.random(2, #cfg_taxicab.doors)]
    
            rPed = cfg_taxicab.missionPedList[math.random(1, #cfg_taxicab.missionPedList)]
    
            RequestModel(rPed) while not HasModelLoaded(rPed) do Wait(1) end
    
            cPed = CreatePed(1, rPed, dTogo, 50.0, 1, 0)
            cPedID = NetworkGetNetworkIdFromEntity(cPed)
            FreezeEntityPosition(cPed, 0)
    
            local pedCoords = GetEntityCoords(cPed)
        
            Extasy.ShowNotification("~y~Dirigez-vous vers la position du client")
            
            blip = AddBlipForCoord(pedCoords.x, pedCoords.y, pedCoords.z)
            SetBlipSprite(blip, 280)
            SetBlipColour(blip, 66)
            SetBlipRoute(blip, true)
            
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            local dst = GetDistanceBetweenCoords(pCoords, dTogo, true)
            playerIsTaxiCabMission = true
            while dst > 150 do
                Wait(100)
                pPed = GetPlayerPed(-1)
                pCoords = GetEntityCoords(pPed)
                dst = GetDistanceBetweenCoords(pCoords, dTogo, true)
                if missionTaxiCabStop then return end
                if missionTaxiCabStop then break end
            end
    
            while playerIsTaxiCabMission do
                Wait(1)
                pPed = GetPlayerPed(-1)
                pCoords = GetEntityCoords(pPed)
                dst = GetDistanceBetweenCoords(pCoords, dTogo.x, dTogo.y, dTogo.z, true)
                if dst < 25.0 then
                    Extasy.ShowHelpNotification("~g~Appuyez sur E pour faire entrer le client dans votre véhicule")
    
                    local waitToEnter = true
    
                    if IsControlJustReleased(1, 38) then
                        SetPedIntoVehicle(cPedID, GetVehiclePedIsIn(GetPlayerPed(-1), 0), 2)
    
                        playerIsTaxiCabMission = false
                    end
                end
            end
            RemoveBlip(blip)

            sTogo = cfg_taxicab.doors[math.random(2, #cfg_taxicab.doors)]
    
            Extasy.ShowNotification("~y~Déposez le client à la position GPS")
    
            blip = AddBlipForCoord(sTogo)
            SetBlipSprite(blip, 280)
            SetBlipColour(blip, 66)
            SetBlipRoute(blip, true)
    
            pPed = GetPlayerPed(-1)
            pCoords = GetEntityCoords(pPed)
            dst = GetDistanceBetweenCoords(pCoords, sTogo, true)
            playerIsTaxiCabMission = true
            while dst > 150 do
                Wait(100)
                pPed = GetPlayerPed(-1)
                pCoords = GetEntityCoords(pPed)
                dst = GetDistanceBetweenCoords(pCoords, sTogo, true)
                if missionTaxiCabStop then return end
                if missionTaxiCabStop then break end
            end
    
            while playerIsTaxiCabMission do
                Wait(1)
                pPed = GetPlayerPed(-1)
                pCoords = GetEntityCoords(pPed)
                dst = GetDistanceBetweenCoords(pCoords, sTogo.x, sTogo.y, sTogo.z, true)
                if dst < 75.0 then
                    Extasy.ShowHelpNotification("~y~Appuyez sur E pour déposer le client")
    
                    if IsControlJustReleased(1, 38) then
                        TaskLeaveAnyVehicle(NetworkGetEntityFromNetworkId(cPedID), 0, 0)
                        while IsPedInAnyVehicle(NetworkGetEntityFromNetworkId(cPedID), 0) do Wait(1) NetworkRequestControlOfEntity(NetworkGetEntityFromNetworkId(cPedID)) end
    
                        playerIsTaxiCabMission = false
                    end
                end
            end
    
            TriggerServerEvent("Extasy:deleteEntityOne", token, cPedID)
            RemoveBlip(blip)
    
            Extasy.ShowAdvancedNotification("Downtown Cab Co", "Facturation course", tostring(Extasy.Math.Round(extasy_core_cfg["taxi_transfert_mission_price_society"], 1)).."$ pour la société\n"..tostring(Extasy.Math.Round(extasy_core_cfg["taxi_transfert_mission_price_player"], 1)).."$ pour vous", "CHAR_TAXI")
            TriggerServerEvent("Taxi:finishRun", token, playerJob, extasy_core_cfg["taxi_transfert_mission_price_society"], extasy_core_cfg["taxi_transfert_mission_price_player"])
            
            startTCLoop()
        end)
    end

    TaxiCabTakeCall = function(_serverID, _coords)
        Citizen.CreateThread(function()
            RemoveBlip(blip)
            Extasy.ShowNotification("~g~Appel pris\n~s~Suivez les indications de votre GPS")

            local tBlip = AddBlipForCoord(_coords)
            SetBlipSprite(tBlip, 280)
            SetBlipColour(tBlip, 66)
            SetBlipShrink(tBlip, true)
            SetBlipScale(tBlip, 0.80)
            SetBlipPriority(emsBlio, 50)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName("APPEL TAXI")
            EndTextCommandSetBlipName(tBlip)
            table.insert(callBlips, tBlip)
            
            SetBlipRoute(tBlip, true)
            SetThisScriptCanRemoveBlipsCreatedByAnyScript(true)
            
            local marker = true

            while marker do
                if GetDistanceBetweenCoords(_coords, GetEntityCoords(GetPlayerPed(-1))) < 100.0 then
                    DrawMarker(20, _coords.x, _coords.y, _coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                    Extasy.DrawText3D(_coords, "Un appel semble avoir été effectué par ici...", 1.0)

                    if GetDistanceBetweenCoords(_coords, GetEntityCoords(GetPlayerPed(-1))) < 2.5 then
                        RemoveBlip(tBlip)
                        marker = false
                    end
                    Wait(1)
                else
                    Wait(150)
                end
            end
        end)
    end
end


Citizen.CreateThread(function()
    b = AddBlipForCoord(2246.52, 6404.42, 0.0)
    SetBlipSprite(b, 198)
    SetBlipDisplay(b, 4)
    SetBlipColour(b, 66)
    SetBlipScale(b, 0.75)
    SetBlipAsShortRange(b, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Entreprise Downtown Cab Co")
    EndTextCommandSetBlipName(b)
end)