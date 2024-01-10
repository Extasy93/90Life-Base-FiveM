InitAvocat = function()
    print("loaded")
    registerSocietyFarmZone({ 
        pos           = vector3(2373.50, 5746.00, 10.07),
        spawnPoint    = {
            {pos = vector3(2380.63, 5747.35, 10.20), heading = 188.15},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage Avocat",
        garage        = {
            {name     = "Windsor 2", hash = "WINDSOR2"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Avocat",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(2380.63, 5747.35, 10.20),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Avocat",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos      = vector3(2351.04, 5739.81, 12.07),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(2170.46, 4847.08, 10.85),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2356.09, 5733.44, 12.07),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Avocat",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(2351.04, 5739.81, 12.07)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Avocat")
    EndTextCommandSetBlipName(aBlip)

    local b = {
        {pos = vector3(2170.53, 4847.15, 10.85), sprite = 557, color = 2,  scale = 0.60, title = "Avocat | Coffre d'entreprise"},
        {pos = vector3(2356.09, 5733.44, 12.07), sprite = 557, color = 3,  scale = 0.60, title = "Avocat | Vestaire"},
        {pos = vector3(2372.29, 5747.50, 9.07), sprite = 557, color = 17, scale = 0.60, title = "Avocat | Garage"},
        {pos = vector3(2380.63, 5747.35, 10.20), sprite = 557, color = 59, scale = 0.60, title = "Avocat | Rangement véhicule"},
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

OpenAvocatMenu = function()
    RMenu.Add('avocat', 'main', RageUI.CreateMenu("Avocat", "Que souhaitez-vous faire ?", 1, 100))
    RMenu.Add('avocat', 'billing', RageUI.CreateSubMenu(RMenu:Get('avocat', 'main'), "Facturation", "Qui souhaitez-vous facturer ?"))
    RMenu:Get('avocat', "main").Closed = function()
        avocat_menu_openned = false

        RMenu:Delete('avocat', 'main')
        RMenu:Delete('avocat', 'billing')
    end
    
    if avocat_menu_openned then
        avocat_menu_openned = false
        return
    else
        RageUI.CloseAll()

        avocat_menu_openned = true
        RageUI.Visible(RMenu:Get('avocat', 'main'), true)
    end

    local buy = {}

    CreateThread(function()
        while avocat_menu_openned do
            Wait(1)

            RageUI.IsVisible(RMenu:Get('avocat', 'main'), true, true, true, function()

                RageUI.Button("Annonce Avocat", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                    if s then
                        local a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                        if a ~= nil then
                            if string.sub(a, 1, string.len("-")) == "-" then
                                Extasy.ShowNotification("~r~Quantité invalide")
                            else
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Cabinet Avocat', '~r~Publicité~s~', a, 'CHAR_AVOCAT', 2, "Avocat")
                                end
                            end
                        else
                            Extasy.ShowNotification("~r~Heure invalide")
                        end
                    end
                end)

                RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('avocat', 'billing'))                           

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('avocat', 'billing'), true, true, true, function()

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
                                                TriggerServerEvent('avocat:sendBilling', token, "Facture Avocat", i, "society_avocat", GetPlayerServerId(player), false, nil)
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

CreateThread(function()
    for k,v in pairs(cfg_avocat.blip) do
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
