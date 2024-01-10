vcpd_inmenu = false

VCPD = false
vcpd_menu, menus = {}, {}
IsHandcuffed = false
local vcpd_index = 1
local in_anim = false
local anim = 'mp_arrest_paired'
local anim_2 = 'cop_p2_back_left'
local anim_3 = 'crook_p2_back_left'
local vcpd_curr_id_player = nil

InitVCPD = function()

    -- for i = 11, 30 do
    --     exports["rp-radio"]:GivePlayerAccessToFrequencies(i)
    -- end

    RMenu.Add('vcpd', 'main_menu', RageUI.CreateMenu("V.C.P.D", "Que souhaitez-vous faire ?", 1, 100))
    RMenu:Get('vcpd', 'main_menu').Closed = function()
        vcpd_inmenu = false
    end
    RMenu.Add('vcpd', 'main_menu_garage', RageUI.CreateMenu("V.C.P.D", "Que souhaitez-vous faire ?", 1, 100))
    RMenu.Add('vcpd', 'main_menu_weapon', RageUI.CreateMenu("V.C.P.D", "Que souhaitez-vous acheter ?", 1, 100))
    
    RMenu.Add('vcpd', 'main_menu_garage_settings', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu_garage'), "V.C.P.D", "Que souhaitez-vous faire ?"))

    RMenu.Add('vcpd', 'main_menu_weapon_list', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu_weapon'), "V.C.P.D", "Que souhaitez-vous acheter ?"))
    RMenu.Add('vcpd', 'main_menu_weapon_equipement', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu_weapon'), "V.C.P.D", "Que souhaitez-vous acheter ?"))
    
    RMenu.Add('vcpd', 'main_menu_citizen', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_k9', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_k9_editSkin', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_k9'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_k9_searchPlayer', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_k9'), "V.C.P.D", "Qui le chien doit renifler ?"))
    RMenu.Add('vcpd', 'main_centrale', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_service', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_centrale_calls_list', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_centrale_renforts', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_menu_vehicle', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_menu_vehicle_extra', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_menu_status', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_menu_closest', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'main_menu_gav', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))
    RMenu.Add('vcpd', 'personnal_billing', RageUI.CreateSubMenu(RMenu:Get('vcpd', 'main_menu'), "V.C.P.D", "Que souhaitez-vous faire ?"))

    VCPDTakeCall = function(_serverID, _coords)
        CreateThread(function()
            Extasy.ShowNotification("~g~Appel pris\n~s~Suivez les indications de votre GPS")
    
            local emsBlip = AddBlipForCoord(_coords)
            SetBlipSprite(emsBlip, 353)
            SetBlipColour(emsBlip, 43)
            SetBlipShrink(emsBlip, true)
            SetBlipScale(emsBlip, 1.2)
            SetBlipPriority(emsBlip, 50)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName("APPEL VCPD")
            EndTextCommandSetBlipName(emsBlip)
            table.insert(callBlips, emsBlip)
    
            local emsBlip2 = AddBlipForCoord(_coords)
            SetBlipSprite(emsBlip2, 42)
            SetBlipColour(emsBlip2, 5)
            SetBlipShrink(emsBlip2, true)
            SetBlipScale(emsBlip2, 1.2)
            SetBlipAlpha(emsBlip2, 120)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName("APPEL VCPD")
            EndTextCommandSetBlipName(emsBlip2)
            table.insert(callBlips, emsBlip2)
            
            SetBlipRoute(emsBlip, true)
            SetThisScriptCanRemoveBlipsCreatedByAnyScript(true)
            
            local marker = true
    
            while marker do
                if GetDistanceBetweenCoords(_coords, GetEntityCoords(GetPlayerPed(-1))) < 100.0 then
                    DrawMarker(20, _coords.x, _coords.y, _coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                    Extasy.DrawText3D(_coords, "Un appel semble avoir été effectué par ici...", 1.0)
    
                    if GetDistanceBetweenCoords(_coords, GetEntityCoords(GetPlayerPed(-1))) < 2.5 then
                        RemoveBlip(emsBlip)
                        RemoveBlip(emsBlip2)
                        marker = false
                    end
                    Wait(1)
                else
                    Wait(150)
                end
            end
        end)
    end

    vcpd_spawnVehicle = function(model, coords, heading, livery)
        if coords then
            Extasy.SpawnVehicle(model, coords, heading, function(vehicle)
                local vProps = Extasy.GetVehicleProperties(vehicle)

                if livery then
                    vProps.modLivery = livery
                    Extasy.SetVehicleProperties(vehicle, vProps)
                end
                
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1) 

                if GetResourceKvpString("windowsTint") == "yes" then
                    vProps.windowTint = 1
                    Extasy.SetVehicleProperties(vehicle, vProps)
                end

				TriggerServerEvent('carlock:location', token, vProps.plate)
            end)
        else
            Extasy.ShowNotification("~r~Aucune sortie de véhicule disponible")
        end
    end
    
    openClosestPlayer = function(action)
        vcpd_menu.action = action
        RageUI.CloseAll()
        Wait(15)
        RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
        OpenVcpdMenu()
    end
    
    VCPD_Garage = function(type)
        if not vcpd_inmenu then
            vcpd_menu.type_g = type
            RageUI.Visible(RMenu:Get('vcpd', 'main_menu_garage'), true)
            OpenVcpdMenu()
        else
            vcpd_inmenu = false
            RageUI.CloseAll()
        end
    end

    VCPD_Weapon = function()
        if not vcpd_inmenu then
            RageUI.Visible(RMenu:Get('vcpd', 'main_menu_weapon'), true)
            OpenVcpdMenu()
        else
            vcpd_inmenu = false
            RageUI.CloseAll()
        end
    end

    vcpd_lookplaces = function(type)
        local found = false
        local pos = nil
        local heading = nil
        for k,v in pairs(cfg_vcpd.garages) do
            if vcpd_menu.type_g == v.value then
                for k,z in pairs(v.places) do
                    if Extasy.IsSpawnPointClear(z.pos, 3.0) then
                        found = true
                        pos = z.pos
                        heading = z.heading
                    end
                end
            end
        end
        if not found then
            return false
        else
            return pos, heading
        end
    end

    OpenVcpdMenu = function()
        if vcpd_inmenu then
            vcpd_inmenu = false
            return
        else
            vcpd_inmenu = true
            CreateThread(function()
                while vcpd_inmenu do
                    Wait(1)
                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu'), true, false, true, function()
            
                        RageUI.Button("État de service", nil, {RightLabel = "→→→"}, true, function(h, a, s) end, RMenu:Get('vcpd', 'main_service'))                           
                        RageUI.Button("Interaction citoyen", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then 
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_citizen'), true)
                            end 
                        end)
                        RageUI.Button("Interaction véhicule", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then 
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_vehicle'), true)
                            end
                        end)
                        RageUI.Button("Unité K-9", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('vcpd', 'main_k9'))
                        RageUI.Button("Centrale", nil, {RightBadge = RageUI.BadgeStyle.Lock}, false, function(Hovered, Active, Selected) end)
                        --RageUI.Button("Centrale", nil, {RightBadge = RageUI.BadgeStyle.Lock}, false, function(Hovered, Active, Selected) end, RMenu:Get('vcpd', 'main_centrale'))
                    
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_k9'), true, false, true, function()
            
                        print(K9.dogEntity)
                        if not DoesEntityExist(K9.dogEntity) then
                            RageUI.Button("Faire venir un chien", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                if s then
                                    CreateThread(function()
                                        K9.SpawnDog()
                                    end)
                                end
                            end)
                        else
                            RageUI.Button("Faire partir le chien", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                if s then
                                    CreateThread(function()
                                        K9.SpawnDog()
                                    end)
                                end
                            end)
                        end

                        if DoesEntityExist(K9.dogEntity) then
                            RageUI.Button("Modifier l'apparence", nil, {RightLabel = "→→→"}, true, function(h, a, s) end, RMenu:Get('vcpd', 'main_k9_editSkin'))

                            if K9.data.follow == nil then K9.data.follow = false end
                            if K9.data.follow then
                                RageUI.Button("Ordonner de suivre", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                    if s then
                                        CreateThread(function()
                                            K9.FollowDog()
                                        end)
                                    end
                                end)
                            else
                                RageUI.Button("Ordonner de ne plus suivre", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                    if s then
                                        CreateThread(function()
                                            K9.FollowDog()
                                        end)
                                    end
                                end)
                            end

                            if K9.data.stand == nil then K9.data.stand = false end
                            if K9.data.stand then
                                RageUI.Button("Ordonner de se lever", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                    if s then
                                        CreateThread(function()
                                            K9.SitDog()
                                        end)
                                    end
                                end)
                            else
                                RageUI.Button("Ordonner de s'asseoir", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                    if s then
                                        CreateThread(function()
                                            K9.SitDog()
                                        end)
                                    end
                                end)
                            end

                            if K9.data.inCar == nil then K9.data.inCar = true end
                            if K9.data.inCar then
                                RageUI.Button("Ordonner de monter dans la voiture", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                    if s then
                                        CreateThread(function()
                                            K9.CarDog()
                                        end)
                                    end
                                end)
                            else
                                RageUI.Button("Ordonner de descendre de la voiture", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                    if s then
                                        CreateThread(function()
                                            K9.CarDog()
                                        end)
                                    end
                                end)
                            end

                            RageUI.Button("Ordonner de rechercher de la drogue", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                if s then
                                    K9.searchType = 'drug'
                                end
                            end, RMenu:Get('vcpd', 'main_k9_searchPlayer'))

                            RageUI.Button("Ordonner de rechercher des armes", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                if s then
                                    K9.searchType = 'weapons'
                                end
                            end, RMenu:Get('vcpd', 'main_k9_searchPlayer'))
                        end
                    
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_k9_editSkin'), true, false, true, function()
            
                        RageUI.Button("Couleur globale", "Appuyez pour modifier", {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                if K9.currentColor == nil then K9.currentColor = 0 end
                                if K9.currentColor + 1 > 4 then K9.currentColor = 0 end

                                SetPedComponentVariation(K9.dogEntity, 0, 0, K9.currentColor, 2)
                                
                                K9.currentColor = K9.currentColor + 1
                            end
                        end)

                        RageUI.Button("Couleur gilet", "Appuyez pour modifier", {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                if K9.currentHands == nil then K9.currentHands = 0 end
                                if K9.currentHands + 1 > 4 then K9.currentHands = 0 end

                                SetPedComponentVariation(K9.dogEntity, 3, 0, K9.currentHands, 2)
                                
                                K9.currentHands = K9.currentHands + 1
                            end
                        end)

                        RageUI.Button("Insigne", "Appuyez pour modifier", {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                if K9.currentSign == nil then K9.currentSign = 0 end
                                if K9.currentSign + 1 > 4 then K9.currentSign = 0 end

                                SetPedComponentVariation(K9.dogEntity, 8, 0, K9.currentSign, 2)
                                
                                K9.currentSign = K9.currentSign + 1
                            end
                        end)
                    
                    end, function()
                    end)
        
                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_k9_searchPlayer'), true, false, true, function()
            
                        for _, player in ipairs(GetActivePlayers()) do
                            local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                            local coords = GetEntityCoords(GetPlayerPed(player))
                            local name = Extasy.ReplaceText(player)
                            local sta = Extasy.IsMyId(player)
            
                            if dst < 3.0 then
                                if sta ~= "me" then
                                    RageUI.Button("#".._.." "..name, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                        if Active then
                                            DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                        end
                                        if Selected then
                                            if K9.searchType == 'drug' then
                                                K9.SearchDrug()
                                            end

                                            if K9.searchType == 'weapons' then
                                                K9.SearchWeapons()
                                            end
                                        end
                                    end)  
                                end
                            end
                        end
                    
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_service'), true, false, true, function()
            
                        RageUI.Button("Commencer son service", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                if not playerInService then
                                    TriggerServerEvent("jobCounter:add", token, "vcpd")
                                    playerInService = true
                                    startServiceLoop(playerJob)
                                else
                                    Extasy.ShowNotification("~r~Vous êtes déjà en service !")
                                end
                            end
                        end)
                        RageUI.Button("Terminer son service", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                if not playerInService then
                                    Extasy.ShowNotification("~r~Vous n'êtes pas en service !")
                                else
                                    TriggerServerEvent("jobCounter:remove", token, "vcpd", GetPlayerServerId(GetPlayerIndex()))
                                    playerInService = false
                                    playerInServiceLoop = false
                                end
                            end
                        end)
                    
                    end, function()
                    end)
        
                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_centrale'), true, false, true, function()

                        RageUI.Button("Annonce aux citoyens", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                local i = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 200)
                                i = tostring(i)
                                if i ~= nil and string.len(i) > 5 then
                                    TriggerServerEvent("jobCounter:sendAllAdvancedMessageWithoutShit", token, 'V.C.P.D', 'Publicité', i, 'CHAR_VCPD', 2, "vcpd")
                                end
                            end
                        end)
                        RageUI.Button("Appels de renfort", nil, {RightLabel = "→→→"}, true, function(h, a, s) end, RMenu:Get('vcpd', 'main_centrale_renforts'))
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
                        RageUI.Button("Appels reçus", nil, {RightLabel = "→→→"}, true, function(h, a, s) end, RMenu:Get('vcpd', 'main_centrale_calls_list'))
                        RageUI.Button("Effacer la liste des appels", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                callList = {}
                            end
                        end)
                    
                    end, function()
                    end)
        
                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_centrale_renforts'), true, false, true, function()
            
                        RageUI.Button("Demande autorisation Blaine County", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                TriggerServerEvent("jobCounter:sendAlert", token, "bcsd", "~b~VCPD\n~s~Demande d'autorisation pour pénétrer dans Blaine County")
                                TriggerServerEvent("jobCounter:sendAlertOnMap", token, "bcsd", "ask_entry", GetEntityCoords(GetPlayerPed(-1)))
                                TriggerServerEvent("jobCounter:sendCallToJobClient", token, "bcsd", GetEntityCoords(GetPlayerPed(-1)), GetPlayerServerId(GetPlayerIndex()), "~b~VCPD~s~", "\nAgent: "..playerIdentity.prenom.." "..playerIdentity.nom.."\nDemande d'autorisation pour pénétrer dans Los Santos")
                            end
                        end)
                        RageUI.Button("Demande personnalisée Blaine County", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                local i = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 200)
                                i = tostring(i)
                                if i ~= nil then
                                    TriggerServerEvent("jobCounter:sendAlert", token, "bcsd", "~b~VCPD\n~s~"..i)
                                    TriggerServerEvent("jobCounter:sendAlertOnMap", token, "bcsd", "ask_entry", GetEntityCoords(GetPlayerPed(-1)))
                                    TriggerServerEvent("jobCounter:sendCallToJobClient", token, "bcsd", GetEntityCoords(GetPlayerPed(-1)), GetPlayerServerId(GetPlayerIndex()), "~b~VCPD~s~", "\nAgent: "..playerIdentity.prenom.." "..playerIdentity.nom.."\n"..i)
                                end
                            end
                        end)
                        RageUI.Button("Demande d'urgence EMS", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                TriggerServerEvent("jobCounter:sendAlert", token, "ambulance", "~b~VCPD\n~s~Appel d'urgence, besoin d'EMS sur position")
                                TriggerServerEvent("jobCounter:sendAlertOnMap", token, "ambulance", "ask_entry", GetEntityCoords(GetPlayerPed(-1)))
                                TriggerServerEvent("jobCounter:sendCallToJobClient", token, "ambulance", GetEntityCoords(GetPlayerPed(-1)), GetPlayerServerId(GetPlayerIndex()), "~b~VCPD~s~", "\nAgent: "..playerIdentity.prenom.." "..playerIdentity.nom.."\nAppel d'urgence, besoin d'EMS sur position")
                            end
                        end)

                        for k,v in pairs(cfg_vcpd.codes) do
                            RageUI.Button("["..v.code.."] "..v.msg, nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                if s then
                                    if playerIdentity.prenom ~= nil then
                                        local playersInArea = Extasy.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 30.0)
                                        local inAreaData = {}

                                        for i=1, #playersInArea, 1 do
                                            table.insert(inAreaData, GetPlayerServerId(playersInArea[i]))
                                        end

                                        TriggerServerEvent("core:setupMeTxt", token, " effectue un code radio", inAreaData)
                                        TriggerServerEvent("jobCounter:sendJobAdvancedMessageWithoutShit", token, 'V.C.P.D', 'Appel d\'urgence', "~p~Agent: ~s~\n"..playerIdentity.prenom.." "..playerIdentity.nom.."\n~p~Code: ~s~\n"..v.code.."\n~p~Informations: ~s~\n"..v.msg, 'CHAR_CALL911', 2, "vcpd", v.gravity)
                                        TriggerServerEvent("jobCounter:sendAlertOnMap", token, "vcpd", "ask_entry", GetEntityCoords(GetPlayerPed(-1)))
                                    end
                                end
                            end)
                        end
                    
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_centrale_calls_list'), true, false, true, function()
        
                        for k,v in ipairs(callList) do
                            if not v.taked then
                                RageUI.Button("Appel #"..k.." ("..v.map..")", "Heure d'appel: "..v.date.."\nRaison d'appel: "..v.reason.." (ID: "..v.serverID..")\nNuméro: "..v.number, {RightLabel = "~R~EN ATTENTE"}, true, function(h, a, s)
                                    if s then
                                        VCPDTakeCall(v.serverID, v.coords)
                                        TriggerServerEvent("jobCounter:sendMsgToJobClients", token, "vcpd", "L'appel #"..k.." a été pris par ~g~"..playerIdentity.prenom.." "..playerIdentity.nom)
                                        TriggerServerEvent("jobCounter:refreshCallsForClients", token, "vcpd", k, playerIdentity.prenom.." "..playerIdentity.nom)
                                        TriggerServerEvent("jobCounter:sendMsgToPlayerFromJob", token, v.serverID, "~g~Un policier a pris votre appel !")
                                    end
                                end)
                            else
                                RageUI.Button("Appel #"..k.." ("..v.map..")", "Heure d'appel: "..v.date.."\nRaison d'appel: "..v.reason.." (ID: "..v.serverID..")\nNuméro: "..v.number, {RightLabel = "~g~PRIS ("..v.name..")"}, true, function(h, a, s)
                                    if s then
                                        VCPDTakeCall(v.serverID, v.coords)
                                    end
                                end)
                            end
                        end
                    
                    end, function()
                    end)
                    
                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_citizen'), true, false, true, function()
            
                        RageUI.Button("Menotter", "Menotte la personne la plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "handcuff"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                            end
                        end)
                        RageUI.Button("Démenotter", "Démenotte la personne la plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "unhandcuff"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                            end
                        end)
                        RageUI.Button("Fouiller", "Fouille la personne la plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "search"
                                RageUI.CloseAll()
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), false)
                                Wait(1)
                                ExecuteCommand("fouiller")
                            end
                        end)
                        for k,v in pairs(cfg_vcpd.allPointsToKnow) do
                            local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v, true)

                            if dst < 250.0 then
                                RageUI.Button("Prise d'empreinte", "Donne l'identité de la personne la plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                                    if Selected then
                                        vcpd_menu.action = "identity_digital"
                                        RageUI.CloseAll()
                                        Wait(1)
                                        RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                                    end
                                end)                                
                            end
                        end
                        RageUI.Button("Escorter", "Attache et porte la personne la plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "drag"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                            end
                        end)
                        RageUI.Button("Mettre dans le véhicule", "Force la personne la plus proche à aller dans le véhicule le plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "putInVehicle"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                            end
                        end)
                        RageUI.Button("Sortir du véhicule", "Force la personne la plus proche à sortir du véhicule le plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "putOutVehicle"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                            end
                        end)
                        RageUI.Button("Donner le PPA", "Donner le PPA à la personne la plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "ppa"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                            end
                        end)
                        RageUI.Button("Amende", "Envoie une amende à la personne la plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "billing"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                            end
                        end)
                        RageUI.Button("Travaux d'intérêts généraux", "Envoie la personne la plus proche en TIG", {RightBadge = RageUI.BadgeStyle.Lock}, false, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "TIG"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                            end
                        end)
                        RageUI.Button("Garde à vue", "Envoie la personne la plus proche en GAV", {RightBadge = RageUI.BadgeStyle.Lock}, false, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "GAV"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                            end
                        end)
                        RageUI.Button("Prison fédérale", "Envoie la personne la plus proche en prison fédérale", {RightBadge = RageUI.BadgeStyle.Lock}, false, function(Hovered, Active, Selected) 
                            if Selected then
                                vcpd_menu.action = "prison"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), true)
                            end
                        end)

                        --if IsPatron(playerJob, playerJob_grade) then
                            for k,v in pairs(cfg_vcpd.badgePos) do
                                local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v, true)

                                if dst < 2.5 then
                                    RageUI.Button("Badge à broder", "Permet de broder vos badges", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                                        if Selected then
                                            local fName = Extasy.KeyboardInput("Indiquez le nom qui sera brodé sur le badge (définitif)", "", 30)
                                            fName = tostring(fName)
        
                                            if fName ~= nil then
                                                local lName = Extasy.KeyboardInput("Indiquez le prénom qui sera brodé sur le badge (définitif)", "", 30)
                                                lName = tostring(lName)
        
                                                if lName ~= nil then
                                                    local mNumber = Extasy.KeyboardInput("Indiquez le matricule qui sera brodé sur le badge (définitif)", "", 5)
                                                    mNumber = tonumber(mNumber)
        
                                                    if mNumber ~= nil then
                                                        args = {}
        
                                                        args["prenom"] = lName
                                                        args["nom"] = fName
                                                        args["matricule"] = mNumber
        
                                                        TriggerServerEvent("rF:GiveBadge", token, "Badge", 1, 45.0, args, mNumber, false)
        
                                                        Extasy.ShowNotification("~r~Vous avez brodé un nouveau badge pour le matricule "..mNumber)
                                                    else
                                                        Extasy.ShowNotification("~r~Matricule invalide")
                                                    end
                                                else
                                                    Extasy.ShowNotification("~r~Prénom invalide")
                                                end
                                            else
                                                Extasy.ShowNotification("~r~Nom invalide")
                                            end
                                        end
                                    end)
                                end
                            end
                        --end
                    
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_gav'), true, false, true, function()
            
                        for k,v in pairs(cfg_realTimeJailer.list) do
                            if v.job == playerJob then
                                for i,l in pairs(v.jails) do
                                    RageUI.Button(l.name, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                                        if Selected then
                                            local gCount = Extasy.KeyboardInput("Combien de temps ? (en minutes)", "", 30)
                                            gCount = tonumber(gCount)
                                            if gCount ~= nil then
                                                TriggerServerEvent("realTimeJailer:addPlayerInJail", token, vcpd_menu.curr_id, gCount, l.room)
                                            end
                                        end
                                    end)
                                end
                            end
                        end
                    
                    end, function()
                    end)
            
                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_vehicle'), true, false, true, function()
            
                        RageUI.Button("Faire une recherche", "Faire une recherche sur le véhicule le plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                SearchForClosestVehicle()
                            end
                        end)
                        RageUI.Button("Crochetter", "Crochète le véhicule le plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                local playerPed = PlayerPedId()
                                local vehicle   = Extasy.GetVehicleInDirection()
                                local coords    = GetEntityCoords(playerPed)
                                if IsPedSittingInAnyVehicle(playerPed) then
                                    Extasy.ShowNotification("~r~Vous devez être en dehors du véhicule")
                                    return
                                end
                            
                                if DoesEntityExist(vehicle) then
                                    TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
                                    CreateThread(function()
                                        TriggerEvent("eCore:AfficherBar", 10000, "⏳ Crochetage en cours...")
                                        Wait(10000)
                                    
                                        SetVehicleDoorsLocked(vehicle, 1)
                                        SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                                        ClearPedTasksImmediately(playerPed)
                                    
                                        Extasy.ShowNotification("~g~Véhicule ouvert")
                                    end)
                                else
                                    Extasy.ShowNotification("~r~Aucun véhicule à proximité")
                                end
                            end
                        end)
                        RageUI.Button("Fourrière", "Met en fourrière le véhicule le plus proche", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                            if Selected then
                                local playerPed = PlayerPedId()
                                local vehicles = Extasy.GetVehiclesInArea(GetEntityCoords(playerPed), 2.0)
                                local vehs = {}
                                local vProps = nil
                                for k,v in pairs(vehicles) do
                                    vProps = Extasy.GetVehicleProperties(v)
                                    table.insert(vehs, NetworkGetNetworkIdFromEntity(v))
                                end
                                TriggerServerEvent("Extasy:deleteEntity", vehs)
                                if vProps ~= nil then
                                    TriggerServerEvent("garage:updateStateForThisVehicle", token, vProps.plate)
                                end
                            end
                        end)
            
                        RageUI.Separator("")
            
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), vector3(3608.38, 5695.27, 10.67), false)
                        if dst < 30.0 then
                            if IsPedInAnyVehicle(PlayerPedId(), false) then
                                RageUI.Button("Extras du véhicule", nil, {RightLabel = "→→→"}, true, function() end, RMenu:Get('vcpd', 'main_menu_vehicle_extra'))
                            end
                        end

                    end, function()
                    end)
            
                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_vehicle_extra'), true, false, true, function()
            
                        if extraTable == nil then extraTable = {} end
                        for i=1, 20 do
                            if DoesExtraExist(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                    RageUI.Button("Extra #"..i, nil, {RightLabel = "❌"}, true, function(Hovered, Active, Selected)
                                        if Selected then
                                            if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                                extraTable[i] = true
                                                SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 0)
                                            else
                                                extraTable[i] = false
                                                SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 1)
                                            end
                                        end
                                    end)
                                else
                                    RageUI.Button("Extra #"..i, nil, {RightLabel = "✅"}, true, function(Hovered, Active, Selected)
                                        if Selected then
                                            if not IsVehicleExtraTurnedOn(GetVehiclePedIsIn(PlayerPedId(), false), i) then
                                                extraTable[i] = true
                                                SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 0)
                                            else
                                                extraTable[i] = false
                                                SetVehicleExtra(GetVehiclePedIsIn(PlayerPedId(), false), i, 1)
                                            end
                                        end
                                    end)
                                end
                            end
                        end
                    
                    end, function()
                    end)
            
                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_status'), true, false, true, function()
            
                        for k,v in pairs(menus) do
                            RageUI.Button(v.name, v.desc, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) 
                                if Selected then
                                    v.action()
                                end
                            end)
                        end
                    
                    end, function()
                    end)
            
                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_closest'), true, false, true, function()
            
                        for _, player in ipairs(GetActivePlayers()) do
                            local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                            local coords = GetEntityCoords(GetPlayerPed(player))
                            local name = Extasy.ReplaceText(player)
                            local sta = Extasy.IsMyId(player)
            
                            if dst < 3.0 then
                                if sta ~= "me" then
                                    RageUI.Button("#".._.." "..name, nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                        if a then
                                            DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                        end
                                        if s then
                                            if vcpd_menu.action == 'handcuff' then
                                                TriggerServerEvent('vcpd:starthandcuff', token, GetPlayerServerId(player))
                                                Wait(3100)									
                                                TriggerServerEvent('vcpd:handcuff', token, GetPlayerServerId(player))
                                            elseif vcpd_menu.action == 'unhandcuff' then
                                                TriggerServerEvent('vcpd:handcuff', token, GetPlayerServerId(player))
                                            elseif vcpd_menu.action == 'drag' then
                                                TriggerServerEvent('vcpd:drag', token, GetPlayerServerId(player))
                                            elseif vcpd_menu.action == 'putInVehicle' then
                                                TriggerServerEvent('vcpd:putInVehicle', token, GetPlayerServerId(player))
                                            elseif vcpd_menu.action == 'putOutVehicle' then
                                                TriggerServerEvent('vcpd:putOutVehicle', token, GetPlayerServerId(player))
                                            elseif vcpd_menu.action == 'billing' then
                                                vcpd_menu.curr_id = GetPlayerServerId(player)
                                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), false)
                                                RageUI.Visible(RMenu:Get('vcpd', 'personnal_billing'), true)
                                                Wait(25)
                                            elseif vcpd_menu.action == 'TIG' then
                                                vcpd_menu.curr_id = GetPlayerServerId(player)

                                                local tig_count = Extasy.KeyboardInput("Combien de travaux ?", "", 30)
                                                tig_count = tonumber(tig_count)
                                                if tig_count ~= nil then
                                                    TriggerServerEvent("tig:addPlayerTIG", token, vcpd_menu.curr_id, tig_count)
                                                end
                                            elseif vcpd_menu.action == 'GAV' then
                                                vcpd_menu.curr_id = GetPlayerServerId(player)
                                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), false)
                                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_gav'), true)
                                                Wait(25)
                                            elseif vcpd_menu.action == 'prison' then
                                                vcpd_menu.curr_id = GetPlayerServerId(player)
                                                local prison_time = Extasy.KeyboardInput("Combien de temps la personne restera en prison ? (1 = 1 heure)", "", 30)
                                                prison_time = tonumber(prison_time)

                                                if prison_time == nil then return end
                                                if prison_time == '' then return end
                                                if prison_time == 0 then return end
                                                if (prison_time < 0) then return end

                                                TriggerServerEvent("prison:add", token, {time = prison_time, target = vcpd_menu.curr_id})
                                            elseif vcpd_menu.action == 'identity_digital' then
                                                vcpd_menu.curr_id = GetPlayerServerId(player)
                                                TriggerServerEvent("identity:askForThisPlayer", token, vcpd_menu.curr_id)
                                            elseif vcpd_menu.action == 'ppa' then
                                                vcpd_menu.curr_id = GetPlayerServerId(player)
                                                TriggerServerEvent("vcpd:buyPpa", token, vcpd_menu.curr_id, 700)
                                                RageUI.Visible(RMenu:Get('vcpd', 'main_menu_closest'), false)
                                                RageUI.CloseAll()
                                                vcpd_inmenu = false
                                                vcpd_menu.action = nil
                                            end
                                        end
                                    end)  
                                end
                            end
                        end
                    
                    end, function()
                    end)
            
                    RageUI.IsVisible(RMenu:Get('vcpd', 'personnal_billing'), true, false, true, function()
            
                        if vcpd_menu.label ~= nil then
                            RageUI.Button("Chef d'inculpation", vcpd_menu.label, {RightLabel = "✏️"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    a = Extasy.KeyboardInput("", "", 300)
                                    a = tostring(a)
                                    if a ~= nil then
                                        if string.sub(a, 1, string.len("-")) == "-" then
                                            Extasy.ShowNotification("~r~Quantité invalide")
                                        else
                                            vcpd_menu.label = a
                                        end
                                    else
                                        Extasy.ShowNotification("~r~Valeur inscrite invalide")
                                    end
                                end
                            end)
                        else
                            RageUI.Button("Chef d'inculpation", nil, {RightLabel = "✏️"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    a = Extasy.KeyboardInput("", "", 300)
                                    a = tostring(a)
                                    if a ~= nil then
                                        if string.sub(a, 1, string.len("-")) == "-" then
                                            Extasy.ShowNotification("~r~Quantité invalide")
                                        else
                                            vcpd_menu.label = a
                                        end
                                    else
                                        Extasy.ShowNotification("~r~Valeur inscrite invalide")
                                    end
                                end
                            end)
                        end
            
                        if vcpd_menu.price ~= nil then
                            RageUI.Button("Montant de l'amende", nil, {RightLabel = Extasy.Math.GroupDigits(vcpd_menu.price).."$"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    a = Extasy.KeyboardInput("", "", 20)
                                    a = tonumber(a)
                                    if a ~= nil and type(a) == 'number' then
                                        if string.sub(a, 1, string.len("-")) == "-" then
                                            Extasy.ShowNotification("~r~Quantité invalide")
                                        else
                                            vcpd_menu.price = a
                                        end
                                    else
                                        Extasy.ShowNotification("~r~Valeur inscrite invalide")
                                    end
                                end
                            end)
                        else
                            RageUI.Button("Montant de l'amende", nil, {RightLabel = "💰"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    a = Extasy.KeyboardInput("", "", 20)
                                    a = tonumber(a)
                                    if a ~= nil and type(a) == 'number' then
                                        if string.sub(a, 1, string.len("-")) == "-" then
                                            Extasy.ShowNotification("~r~Quantité invalide")
                                        else
                                            vcpd_menu.price = a
                                        end
                                    else
                                        Extasy.ShowNotification("~r~Valeur inscrite invalide")
                                    end
                                end
                            end)
                        end
            
                        if vcpd_menu.label ~= nil and vcpd_menu.price ~= nil then
                            RageUI.Separator("")
                            RageUI.Button("~g~Envoyer l'amende", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if Selected then 
                                    TriggerServerEvent('vcpd:sendBilling', token, vcpd_menu.label, vcpd_menu.price, playerJob, vcpd_menu.curr_id, true)
                                    RageUI.Visible(RMenu:Get('vcpd', 'personnal_billing'), false)
                                    Wait(15)
                                    RageUI.Visible(RMenu:Get('vcpd', 'main_menu'), true)
                                end
                            end)
                        end
                    
                    end, function()
                    end)
            
                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_garage'), true, false, true, function()
                
                        RageUI.Button("Configurations véhicule", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                if GetResourceKvpString("windowsTint") == nil then print("nil") SetResourceKvp("windowsTint", "no") end
                                vcpd_menu.windowsTint = GetResourceKvpString("windowsTint")
                            end
                        end, RMenu:Get('vcpd', 'main_menu_garage_settings'))

                        RageUI.Separator("")

                        for k,v in pairs(cfg_vcpd.garages) do
                            if vcpd_menu.type_g == v.value then
                                for k,la in pairs(v.list) do
                                    RageUI.Button(la.name, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                        if Selected then
                                            if la.hash == "mocpacker" then
                                                found = true
                                                local pos = vector3(3596.97, 5674.94, 8.84)
                                                local heading = 147
                                                vcpd_spawnVehicle(la.hash, pos, heading, la.livery)
                                            else
                                                local pos, heading = vcpd_lookplaces(vcpd_menu.type_g)
                                                vcpd_spawnVehicle(la.hash, pos, heading, la.livery)
                                            end
                                        end
                                    end)
                                end
                            end
                        end
            
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_garage_settings'), true, false, true, function()
                    
                        if vcpd_menu.windowsTint == "yes" then
                            RageUI.Button("Vitres teintées", nil, {RightLabel = "✅"}, true, function(h, a, s)
                                if s then
                                    SetResourceKvp("windowsTint", "no")
                                    vcpd_menu.windowsTint = "no"
                                end
                            end)
                        elseif vcpd_menu.windowsTint == "no" then
                            RageUI.Button("Vitres teintées", nil, {RightLabel = "❌"}, true, function(h, a, s)
                                if s then
                                    SetResourceKvp("windowsTint", "yes")
                                    vcpd_menu.windowsTint = "yes"
                                end
                            end)
                        end
            
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_weapon'), true, false, true, function()
                    
                        RageUI.Button("Armes", nil, {}, true, function(h, a, s) end, RMenu:Get('vcpd', 'main_menu_weapon_list'))
                        RageUI.Button("Équipement", nil, {}, true, function(h, a, s) end, RMenu:Get('vcpd', 'main_menu_weapon_equipement'))
            
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_weapon_list'), true, false, true, function()
                    
                        RageUI.List("Mode de paiement", extasy_core_cfg["available_payments_billing"], vcpd_index, nil, {}, true, function(Hovered, Active, Selected, c)
                            vcpd_index = c
                        end)

                        RageUI.Separator("")

                        if cfg_vcpd.weapons[playerJob_grade] then
                            for k,v in pairs(cfg_vcpd.weapons[playerJob_grade]) do
                                RageUI.Button(v.name, nil, {RightLabel = v.price.."$"}, true, function(h, a, s) 
                                    if s then
                                        TriggerServerEvent("vcpd:buyWeapon", token, vcpd_index, v.price, v.item, v.name)
                                    end
                                end)
                            end
                        else
                            RageUI.Separator("Votre grade n'a pas d'armes disponibles")
                        end
            
                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('vcpd', 'main_menu_weapon_equipement'), true, false, true, function()
                
                        RageUI.Button("Réparer kevlar", nil, {}, true, function(h, a, s)
                            if s then
                                SetPedArmour(GetPlayerPed(-1), 100.0)
                            end
                        end)
    
                        RageUI.Separator("")
                        
                        for k,v in pairs(cfg_vcpd.equipement) do
                            if v.sex ~= nil then
                                RageUI.Button(v.name.." ("..v.sex..")", nil, {RightLabel = v.price.."$"}, true, function(h, a, s) 
                                    if s then
                                        TriggerServerEvent("vcpd:buyEquipment", token, vcpd_index, v.price, v.item, v.name)
                                    end
                                end)
                            else
                                RageUI.Button(v.name, nil, {RightLabel = v.price.."$"}, true, function(h, a, s) 
                                    if s then
                                        TriggerServerEvent("vcpd:buyEquipment", token, vcpd_index, v.price, v.item, v.name)
                                    end
                                end)
                            end
                        end
            
                    end, function()
                    end)
                end
            end)
        end
    end

    registerNewMarker({
        npcType          = 'drawmarker',
        interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour aller dans ~p~le poste de police",
        pos              = vector3(3637.45, 5722.96, 19.53),
        action          = function()
            TriggerServerEvent('vcpd:teleportMainT', token)
        end,
    
        spawned          = false,
        entity           = nil,
        load_dst         = 15,
    
    
        blip_enable      = false,
    
        marker           = true,
        size             = 0.6,
    
        drawmarkerType   = 6,
        drawmarkerRotation = 270.0,
    
        drawmarkerColorR = 100,
        drawmarkerColorG = 0,
        drawmarkerColorB = 200,
    })
    
    registerNewMarker({
        npcType          = 'drawmarker',
        interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour aller ~p~sur le toit",
        pos              = vector3(3644.83, 5724.15, 8.56),
        action          = function()
            TriggerServerEvent('vcpd:teleportOnTop', token)
        end,
    
        spawned          = false,
        entity           = nil,
        load_dst         = 15,
    
    
        blip_enable      = false,
    
        marker           = true,
        size             = 0.6,
    
        drawmarkerType   = 6,
        drawmarkerRotation = 270.0,
    
        drawmarkerColorR = 100,
        drawmarkerColorG = 0,
        drawmarkerColorB = 200,
    })

    local cooldown = 0
    RegisterCommand('+tackle_someone', function()
        if cooldown > GetGameTimer() then Extasy.ShowNotification("~r~Veuillez patienter entre chaque utilisation de cette fonctionnalité") return end
        playerTryToTackle = true
        cooldown = GetGameTimer() + 0 * 1000
    end, false)
    RegisterCommand('-tackle_someone', function()
        playerTryToTackle = false
    end)
    RegisterKeyMapping('+tackle_someone', 'Plaquer quelqu\'un (VCPD)', 'keyboard', '')

    registerSocietyFarmZone({
        pos           = vector3(463.57, -982.48, 43.69),
        spawnPoint    = {
            {pos = vector3(449.78, -981.21, 43.69), heading = 177.31},
        },
        type          = 5,
        msg           = "~b~Appuyez sur [E] pour ouvrir le garage aérien",
        garage        = {
            {name     = "Maverick", hash = "polmav", livery = 0},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage VCPD",
        size          = 2.5,
    })
    registerSocietyFarmZone({
        pos      = vector3(3602.07, 5703.34, 11.28),
        type     = 7,
        size     = 2.5,
        marker   = true,
        msg      = "~b~Appuyez sur [E] pour ranger votre véhicule",
    })

    registerSocietyFarmZone({
        pos      = vector3(3627.94, 5730.75, 5.56),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur [E] pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(3608.88, 5723.54, 5.52),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur [E] pour ouvrir le coffre des saisies",
    })

    registerSocietyFarmZone({
        pos      = vector3(3606.12, 5734.02, 5.57),
        type     = 4,
        size     = 1.5,
        marker   = true,
        msg      = "~b~Appuyez sur [E] pour prendre votre tenue de service",
    
        blip_enable     = false,
    })

    registerSocietyFarmZone({
        pos      = vector3(3631.13, 5715.92, 5.55),
        type     = 4,
        size     = 1.5,
        marker   = true,
        msg      = "~b~Appuyez sur [E] pour prendre votre tenue de service",
    
        blip_enable     = false,
    })

    registerSocietyFarmZone({
        pos      = vector3(3628.12, 5713.27, 5.55),
        type     = 4,
        size     = 1.5,
        marker   = true,
        msg      = "~b~Appuyez sur [E] pour prendre votre tenue de service",
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(-544.61, -199.19, 47.55)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise VCPD")
    EndTextCommandSetBlipName(aBlip)
end

RegisterNetEvent('vcpd:handcuff')
AddEventHandler('vcpd:handcuff', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()

	CreateThread(function()
		if IsHandcuffed then
			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            CreateThread(function()
                while IsHandcuffed do
                    Wait(1)
                    SetPedMoveRateOverride(playerPed, 0.5)
                    SetRunSprintMultiplierForPlayer(playerPed, 0.5)
                    DisableControlAction(0, 1, true) -- Disable pan
                    DisableControlAction(0, 2, true) -- Disable tilt
                    DisableControlAction(0, 24, true) -- Attack
                    DisableControlAction(0, 257, true) -- Attack 2
                    DisableControlAction(0, 25, true) -- Aim
                    DisableControlAction(0, 263, true) -- Melee Attack 1

                    DisableControlAction(0, 45, true) -- Reload
                    DisableControlAction(0, 22, true) -- Jump
                    DisableControlAction(0, 44, true) -- Cover
                    DisableControlAction(0, 37, true) -- Select Weapon
                    DisableControlAction(0, 23, true) -- Also 'enter'?

                    DisableControlAction(0, 288,  true) -- Disable phone
                    DisableControlAction(0, 289, true) -- Inventory
                    DisableControlAction(0, 170, true) -- Animations
                    DisableControlAction(0, 167, true) -- Job

                    DisableControlAction(0, 0, true) -- Disable changing view
                    DisableControlAction(0, 26, true) -- Disable looking behind
                    DisableControlAction(0, 73, true) -- Disable clearing animation
                    DisableControlAction(2, 199, true) -- Disable pause screen

                    DisableControlAction(0, 59, true) -- Disable steering in vehicle
                    DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
                    DisableControlAction(0, 72, true) -- Disable reversing in vehicle

                    DisableControlAction(2, 36, true) -- Disable going stealth

                    DisableControlAction(0, 47, true)  -- Disable weapon
                    DisableControlAction(0, 264, true) -- Disable melee
                    DisableControlAction(0, 257, true) -- Disable melee
                    DisableControlAction(0, 140, true) -- Disable melee
                    DisableControlAction(0, 141, true) -- Disable melee
                    DisableControlAction(0, 142, true) -- Disable melee
                    DisableControlAction(0, 143, true) -- Disable melee
                    DisableControlAction(0, 75, true)  -- Disable exit vehicle
                    DisableControlAction(27, 75, true) -- Disable exit vehicle
                end
            end)
		else
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
            DisablePlayerFiring(playerPed, false)
            SetPedMoveRateOverride(playerPed, 1.0)
            SetRunSprintMultiplierForPlayer(playerPed, 1.0)
		end
	end)
end)

RegisterNetEvent('vcpd:arrest')
AddEventHandler('vcpd:arrest', function(target)
	in_anim = true

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(anim)

	while not HasAnimDictLoaded(anim) do
		Wait(10)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, anim, anim_3, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Wait(950)
	DetachEntity(GetPlayerPed(-1), true, false)

	in_anim = false
end)

RegisterNetEvent('vcpd:arrest_source')
AddEventHandler('vcpd:arrest_source', function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict(anim)

	while not HasAnimDictLoaded(anim) do
		Wait(10)
	end

	TaskPlayAnim(playerPed, anim, anim_2, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Wait(3000)

	in_anim = false
end)

RegisterNetEvent('vcpd:drag')
AddEventHandler('vcpd:drag', function(copID)
	if not IsHandcuffed then
		return
	end

	vcpd_menu.IsDragged = not vcpd_menu.IsDragged
    vcpd_menu.CopId     = tonumber(copID)
end)

RegisterNetEvent('vcpd:putInVehicle')
AddEventHandler('vcpd:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then

			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
                TaskEnterVehicle(playerPed, vehicle, 10.0, freeSeat, 1.0, 0)
				vcpd_menu.IsDragged = false
			end

		end

	end
end)

SearchForClosestVehicle = function()
    local plate = Extasy.KeyboardInput("Quelle plaque ?", "", 8)
    
    if plate ~= nil then
        TriggerServerEvent("garage:checkOwnerForThisPlate", token, plate)
    else
        Extasy.ShowNotification("~r~Plaque invalide")
    end
end

CreateThread(function()
    local playerPed
    local targetPed
    while true do

        if IsHandcuffed then
            playerPed = PlayerPedId()

            if vcpd_menu.IsDragged then
                targetPed = GetPlayerPed(GetPlayerFromServerId(vcpd_menu.CopId))

                if not IsPedSittingInAnyVehicle(targetPed) then
                    AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
                else
                    vcpd_menu.IsDragged = false
                    DetachEntity(playerPed, true, false)
                end

            else
                DetachEntity(playerPed, true, false)
            end
        end

        if IsHandcuffed then
            Wait(1)
        else
            Wait(2000)
        end
    end
end)

RegisterNetEvent('vcpd:putOutVehicle')
AddEventHandler('vcpd:putOutVehicle', function()
    TriggerServerEvent('vcpd:handcuff', token, PlayerId())
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
    TaskLeaveVehicle(playerPed, vehicle, 1)
end)

RegisterNetEvent('vcpd:askentry')
AddEventHandler('vcpd:askentry', function(coords)
    local alpha = 250
    local alpha2 = 170

	local emsBlip = AddBlipForCoord(coords)
	SetBlipSprite(emsBlip, 353)
	SetBlipColour(emsBlip, 43)
	SetBlipShrink(emsBlip, true)
	SetBlipScale(emsBlip, 1.2)
	SetBlipPriority(emsBlio, 50)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("APPEL FORCES DE L'ORDRE")
	EndTextCommandSetBlipName(emsBlip)
	table.insert(callBlips, emsBlip)

	local emsBlip2 = AddBlipForCoord(coords)
	SetBlipSprite(emsBlip2, 42)
	SetBlipColour(emsBlip2, 5)
	SetBlipShrink(emsBlip2, true)
	SetBlipScale(emsBlip2, 1.2)
	SetBlipAlpha(emsBlip2, 120)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("APPEL FORCES DE L'ORDRE")
	EndTextCommandSetBlipName(emsBlip2)
    table.insert(callBlips, emsBlip2)

	while alpha ~= 0 do
		Wait(15 * 4)
		alpha = alpha - 1
		SetBlipAlpha(emsBlip, alpha)
		SetBlipAlpha(emsBlip2, alpha)

		if alpha == 0 then
			RemoveBlip(emsBlip)
			RemoveBlip(emsBlip2)
			return
		end
	end
end)

RegisterNetEvent('vcpd:atm_hacking')
AddEventHandler('vcpd:atm_hacking', function(coords)
    local alpha = 250
    local alpha2 = 170
    local bl2 = AddBlipForRadius(coords[1], coords[2], coords[3], 135.0)
    local bl = AddBlipForRadius(coords[1], coords[2], coords[3], 125.0)
    local info = AddBlipForCoord(coords[1], coords[2], coords[3])

	SetBlipHighDetail(bl, true)
	SetBlipColour(bl, 1)
	SetBlipAlpha(bl, alpha)
    SetBlipAsShortRange(bl, true)
    
    SetBlipHighDetail(bl2, true)
	SetBlipColour(bl2, 85)
	SetBlipAlpha(bl2, alpha2)
    SetBlipAsShortRange(bl2, true)
    
    SetBlipSprite(info, 434)
    SetBlipDisplay(info, 4)
    SetBlipColour(info, 1)
    SetBlipScale(info, 0.8)
    SetBlipAsShortRange(info, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("")
    EndTextCommandSetBlipName(info)

	while alpha ~= 0 do
		Wait(30 * 4)
		alpha = alpha - 1
		SetBlipAlpha(bl, alpha)
		SetBlipAlpha(bl2, alpha)
		SetBlipAlpha(info, alpha)

		if alpha == 0 then
			RemoveBlip(bl)
			RemoveBlip(bl2)
			RemoveBlip(info)
			return
		end
	end
end)

RegisterNetEvent("item:useHerse")
AddEventHandler("item:useHerse", function()
    -- function SpawnObj(obj, nam)
        local playerPed = PlayerPedId()
        local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
        local objectCoords = (coords + forward * 1.0)
        local Ent = nil
    
        SpawnObject("p_ld_stinger_s", objectCoords, function(obj)
            SetEntityCoords(obj, objectCoords, 0.0, 0.0, 0.0, 0)
            SetEntityHeading(obj, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(obj)
            Ent = obj
            Wait(1)
        end)
        Wait(1)
        while Ent == nil do Wait(1) end
        SetEntityHeading(Ent, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(Ent)
        local placed = false
        while not placed do
            Wait(1)
            local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
            local objectCoords = (coords + forward * 2.0)
            SetEntityCoords(Ent, objectCoords, 0.0, 0.0, 0.0, 0)
            SetEntityHeading(Ent, GetEntityHeading(playerPed))
            PlaceObjectOnGroundProperly(Ent)
            SetEntityAlpha(Ent, 170, 170)
            SetEntityCollision(Ent, 0, 0)
            
            -- Extasy.ShowHelpNotification("Appuyez sur ~INPUT_ATTACK~ pour poser la herse\nAppuyez sur ~INPUT_CELLPHONE_UP~ pour élever l'objet\nAppuyez sur ~INPUT_CELLPHONE_DOWN~ pour baisser l'objet\nAppuyez sur ~INPUT_AIM~ pour annuler")
            Extasy.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour poser la herse\nAppuyez sur ~INPUT_CELLPHONE_CAMERA_EXPRESSION~ pour annuler")
    
            if IsControlJustReleased(1, 38) then
                placed = true
                TriggerServerEvent("Extasy:RemoveItem", token, "Herse", 1)
            end
            if IsControlJustReleased(1, 186) then
                DeleteEntity(Ent)
                break
            end
            -- if IsControlJustReleased(1, 172) then
            --     Z = Z + 0.02
            -- end
            -- if IsControlJustReleased(1, 173) then
            --     Z = Z - 0.02
            -- end
        end
    
        SetEntityCollision(Ent, 1, 1)
        FreezeEntityPosition(Ent, true)
        SetEntityInvincible(Ent, true)
        ResetEntityAlpha(Ent)
        local NetId = NetworkGetNetworkIdFromEntity(Ent)
        SetNetworkIdCanMigrate(NetId, true)
        -- DecorSetInt(NetworkGetEntityFromNetworkId(NetId), "props", 1)
    -- end
end)

local shieldEntity = nil
local hasShield    = false
RegisterNetEvent("item:useShield")
AddEventHandler("item:useShield", function()
    local ped = GetPlayerPed(-1)
    local pedPos = GetEntityCoords(ped, false)
    
    RequestAnimDict("combat@gestures@gang@pistol_1h@beckon")
    while not HasAnimDictLoaded("combat@gestures@gang@pistol_1h@beckon") do
        Wait(100)
    end

    TaskPlayAnim(ped, "combat@gestures@gang@pistol_1h@beckon", "0", 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

    RequestModel(GetHashKey("prop_ballistic_shield"))
    while not HasModelLoaded(GetHashKey("prop_ballistic_shield")) do
        Wait(100)
    end

    local shield = CreateObject(GetHashKey("prop_ballistic_shield"), pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
    SetEntityCollision(shield, false, true)
    shieldEntity = shield
    AttachEntityToEntity(shieldEntity, ped, GetEntityBoneIndexByName(ped, "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))

    whileHavingShield()

    SetEnableHandcuffs(ped, true)
end)

whileHavingShield = function()
    shieldActive = true
    local ped = GetPlayerPed(-1)
    CreateThread(function()
        while shieldActive do
            Extasy.ShowHelpNotification("Appuyez sur ~INPUT_CELLPHONE_CAMERA_EXPRESSION~ pour ranger le bouclier")
    
            if IsControlJustReleased(1, 186) then
                shieldActive = false
                DeleteEntity(shieldEntity)
                shieldEntity = nil
                ClearPedTasksImmediately(ped)
                SetWeaponAnimationOverride(ped, GetHashKey("Default"))
                SetEnableHandcuffs(ped, false)
                break
            end

            if not IsEntityPlayingAnim(ped, "combat@gestures@gang@pistol_1h@beckon", "0", 1) then
                RequestAnimDict("combat@gestures@gang@pistol_1h@beckon")
                while not HasAnimDictLoaded("combat@gestures@gang@pistol_1h@beckon") do
                    Wait(100)
                end
            
                TaskPlayAnim(ped, "combat@gestures@gang@pistol_1h@beckon", "0", 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
            end
            Wait(0)
        end
    end)
    CreateThread(function()
        while shieldActive do
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)

            Wait(500)
        end
    end)
    CreateThread(function()
        while shieldActive do
            Wait(0)

            SetPedMoveRateOverride(ped, 0.4)
            SetRunSprintMultiplierForPlayer(ped, 0.4)
        end
        SetPedMoveRateOverride(ped, 1.0)
        SetRunSprintMultiplierForPlayer(ped, 1.0)
    end)
end

RegisterNetEvent("item:useWeaponAccessorie")
AddEventHandler("item:useWeaponAccessorie", function(data)
    RageUI.CloseAll()
    inventory_open = false
    Wait(50)

    weaponAccessories.compatibility = {}
    for k,v in pairs(playerInventory) do
        if string.sub(v.name, 1, string.len("WEAPON_")) == "WEAPON_" then
            for i,l in pairs(cfg_weaponAccessories.list) do
                if data == l.name then
                    for a,q in pairs(l.list) do
                        if q.weapon == GetHashKey(v.name) then
                            weaponAccessories.compatibility[v.name] = true
                        end
                    end
                end
            end
        end
    end

    weaponAccessories.numbers = 0
    for k,v in pairs(playerInventory) do
        if weaponAccessories.compatibility[v.name] then
            weaponAccessories.numbers = weaponAccessories.numbers + 1
        end
    end

    weaponAccessories.openMenu(data)
end)

local wKevlar = {}

RegisterNetEvent('VCPD:useKevlar')
AddEventHandler('VCPD:useKevlar', function(data)
    if not playerHaveKevlar then
        local wPed            = GetPlayerPed(-1)
        local wArmour         = GetPedArmour(wPed)
        local wSex            = nil

        if curr.args ~= nil then
            wKevlar.name      = curr.name
            wKevlar.itemId    = curr.itemId
            wKevlar.value     = curr.args["draw"]
            wKevlar.variation = curr.args["texture"]
            wKevlar.armour    = curr.args["damage"]

            SetPedComponentVariation(GetPlayerPed(-1), 9, curr.args["draw"], curr.args["texture"], 2)
            SetPedArmour(wPed, wKevlar.armour)

            TriggerServerEvent("VCPD:registerKevlar", token, {
                name          = wKevlar.name,
                itemId        = wKevlar.itemId,
                draw          = wKevlar.value,
                texture       = wKevlar.variation,
            })

            playerHaveKevlar  = true

            CreateThread(function()
                while playerHaveKevlar do
            
                    local pPed           = GetPlayerPed(-1)
                    local pArmour        = GetPedArmour(pPed)
            
                    if pArmour < 5 then
                        TriggerServerEvent("VCPD:deleteKevlar", token)
            
                        SetPedComponentVariation(pPed, 9, 0, 0, 2)
            
                        playerLastKevlar = nil
                        playerHaveKevlar = false
                        wKevlar          = {}
                    end
            
                    Wait(500)
                end
            end)
        end
    else
        Extasy.ShowNotification("~r~Vous avez déjà un kevlar d'équipé")
    end
end)

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour aller dans ~p~le poste de police",
    pos              = vector3(3611.98, 5704.63, 10.28),
    action          = function()
        TriggerServerEvent('vcpd:teleportMain', token)
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 15,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 6,
    drawmarkerRotation = 270.0,

    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour aller ~p~derière le batiment",
    pos              = vector3(3641.16, 5711.40, 4.45),
    action          = function()
        TriggerServerEvent('vcpd:teleportLobby', token)
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 15,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 6,
    drawmarkerRotation = 270.0,

    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})
