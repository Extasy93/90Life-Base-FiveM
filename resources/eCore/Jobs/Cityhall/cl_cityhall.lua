InitCityHall = function()
    registerSocietyFarmZone({ 
        pos           = vector3(2830.13, 7396.12, 10.51),
        spawnPoint    = {
            {pos = vector3(2812.93, 7379.11, 9.05), heading = 356.15},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage de la City Hall",
        garage        = {
            {name     = "Washington", hash = "washington"},
            {name     = "Packard 48 (chevrolet)", hash = "packard48"},
            {name     = "Cali 57 (Maire)", hash = "cali57"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage City Hall",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(2812.93, 7379.11, 9.05),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage City Hall",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos      = vector3(2889.75, 7392.75, 173.47),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(2885.85, 7391.1, 173.46),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2878.93, 7391.07, 173.46),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "City Hall",
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
    AddTextComponentString("Gestion entreprise City Hall")
    EndTextCommandSetBlipName(aBlip)

    local b = {
        {pos = vector3(2885.85, 7391.1, 183.1), sprite = 557, color = 2,  scale = 0.60, title = "City Hall | Coffre d'entreprise"},
        {pos = vector3(2878.93, 7391.07, 173.07), sprite = 557, color = 3,  scale = 0.60, title = "City Hall | Vestaire"},
        {pos = vector3(2830.13, 7396.12, 10.51), sprite = 557, color = 17, scale = 0.60, title = "City Hall | Garage"},
        {pos = vector3(2812.93, 7379.11, 9.05), sprite = 557, color = 59, scale = 0.60, title = "City Hall | Rangement véhicule"},
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

OpenCityhallMenu = function()
    RMenu.Add('cityhall', 'main', RageUI.CreateMenu("City Hall", "Que souhaitez-vous faire ?", 1, 100))
    RMenu.Add('cityhall', 'billing', RageUI.CreateSubMenu(RMenu:Get('cityhall', 'main'), "Facturation", "Qui souhaitez-vous facturer ?"))
    RMenu:Get('cityhall', "main").Closed = function()
        cityhall_menu_openned = false

        RMenu:Delete('cityhall', 'main')
        RMenu:Delete('cityhall', 'billing')
    end
    
    if cityhall_menu_openned then
        cityhall_menu_openned = false
        return
    else
        RageUI.CloseAll()

        cityhall_menu_openned = true
        RageUI.Visible(RMenu:Get('cityhall', 'main'), true)
    end

    local buy = {}

    CreateThread(function()
        while cityhall_menu_openned do
            Wait(1)

            RageUI.IsVisible(RMenu:Get('cityhall', 'main'), true, true, true, function()

                RageUI.Button("Annonce City Hall", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                    if s then
                        local a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                        if a ~= nil then
                            if string.sub(a, 1, string.len("-")) == "-" then
                                Extasy.ShowNotification("~r~Quantité invalide")
                            else
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'City Hall (Mairie)', '~r~Annonce Gouvernementale~s~', a, 'CHAR_AGENT14', 2, "City Hall")
                                end
                            end
                        else
                            Extasy.ShowNotification("~r~Heure invalide")
                        end
                    end
                end)

                RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('cityhall', 'billing'))                           

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('cityhall', 'billing'), true, true, true, function()

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
                                                TriggerServerEvent('cityhall:sendBilling', token, "Facture City Hall (Mairie)", i, "cityhall", GetPlayerServerId(player), false, nil)
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

cityhallBlip = AddBlipForCoord(2886.6, 7382.47, 10.51)
SetBlipSprite(cityhallBlip, 304)
SetBlipDisplay(cityhallBlip, 4)
SetBlipColour(cityhallBlip, 26)
SetBlipScale(cityhallBlip, 0.65)
SetBlipAsShortRange(cityhallBlip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Mairie de Vice City")
EndTextCommandSetBlipName(cityhallBlip)

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~monter dans l'ascenceur",
    pos              = vector3(2888.24, 7384.32, 9.51),
    action          = function()
        TriggerServerEvent('gouvernement:teleportMain', token)
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
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~monter dans l'ascenceur",
    pos              = vector3(2865.09, 7390.19, 172.46),
    action          = function()
        TriggerServerEvent('gouvernement:teleportLobby', token)
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
