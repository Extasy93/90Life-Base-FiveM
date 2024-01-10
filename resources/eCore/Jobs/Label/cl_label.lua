InitLabel = function()
    registerSocietyFarmZone({ 
        pos           = vector3(2159.36, 7489.57, 7.70),
        spawnPoint    = {
            {pos = vector3(2129.03, 7465.63, 7.70), heading = 242.69},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage Label",
        garage        = {
            {name     = "", hash = ""},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Label",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(2129.03, 7465.63, 7.70),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Label",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos      = vector3(2144.15, 7520.90, 8.42),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(2124.13, 7538.42, 8.87),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2150.58, 7528.43, 8.46),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Label",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(2144.15, 7520.90, 8.42)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Label")
    EndTextCommandSetBlipName(aBlip)

    local b = {
        {pos = vector3(2124.13, 7538.42, 8.87), sprite = 557, color = 2,  scale = 0.60, title = "Label | Coffre d'entreprise"},
        {pos = vector3(2150.58, 7528.43, 8.46), sprite = 557, color = 3,  scale = 0.60, title = "Label | Vestaire"},
        {pos = vector3(2159.36, 7489.57, 7.70), sprite = 557, color = 17, scale = 0.60, title = "Label | Garage"},
        {pos = vector3(2129.03, 7465.63, 7.70), sprite = 557, color = 59, scale = 0.60, title = "Label | Rangement véhicule"},
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

OpenLabelMenu = function()
    RMenu.Add('label', 'main', RageUI.CreateMenu("Cigarettes", "Que souhaitez-vous faire ?", 1, 100))
    RMenu.Add('label', 'billing', RageUI.CreateSubMenu(RMenu:Get('label', 'main'), "Facturation", "Qui souhaitez-vous facturer ?"))
    RMenu:Get('label', "main").Closed = function()
        label_menu_openned = false

        RMenu:Delete('label', 'main')
        RMenu:Delete('label', 'billing')
    end
    
    if label_menu_openned then
        label_menu_openned = false
        return
    else
        RageUI.CloseAll()

        label_menu_openned = true
        RageUI.Visible(RMenu:Get('label', 'main'), true)
    end

    local buy = {}

    CreateThread(function()
        while label_menu_openned do
            Wait(1)

            RageUI.IsVisible(RMenu:Get('label', 'main'), true, true, true, function()

                RageUI.Button("Annonce Label", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                    if s then
                        local a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                        if a ~= nil then
                            if string.sub(a, 1, string.len("-")) == "-" then
                                Extasy.ShowNotification("~r~Quantité invalide")
                            else
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Label', '~o~Publicité~s~', a, 'CHAR_RECORD', 2, "Label")
                                end
                            end
                        else
                            Extasy.ShowNotification("~r~Heure invalide")
                        end
                    end
                end)

                RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('label', 'billing'))                           

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('label', 'billing'), true, true, true, function()

                for _, player in ipairs(GetActivePlayers()) do
                    local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                    local sta = Extasy.IsMyId(player)
                    local coords = GetEntityCoords(GetPlayerPed(player))
                    local name = Extasy.ReplaceText(player)
        
                    if dst < 3.0 then
                        if sta ~= "me" then
                            RageUI.Button(name.." #".._, nil, {RightLabel = c}, true, function(Hovered, Active, Selected)
                                if Active then
                                    DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                    c = ""
                                else
                                    c = "💰"
                                end

                                if Selected then
                                    local i = Extasy.KeyboardInput("Définissez le montant", "", 10)
                                    i = tonumber(i)
                                    if i ~= nil then
                                        if i > 0 then
                                            if string.sub(i, 1, string.len("-")) == "-" then
                                                Extasy.ShowNotification("~r~Quantité invalide")
                                            else
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", -1, true)

                                                Wait(2500)
                                                TriggerServerEvent('label:sendBilling', token, "Facture Label", i, "label", GetPlayerServerId(player), false, nil)
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