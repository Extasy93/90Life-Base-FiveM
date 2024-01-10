local index = 1
local playersInArea = {}
local inAreaData = {}

InitRobina = function()    
    registerSocietyFarmZone({
        pos           = vector3(2080.283, 5572.087, 10.81784),
        spawnPoint    = {
            {pos = vector3(2084.667, 5570.445, 10.60307), heading = 96.0406265258789},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage du Robina's Café",
        garage        = {
            {name     = "Speedo", hash = "speedo"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Robina's Café",
        size          = 2.5,
    })
    registerSocietyFarmZone({
        pos           = vector3(2084.667, 5570.445, 10.60307),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Robina's Café",
        size          = 2.5,
    })

    registerSocietyFarmZone({
        pos      = vector3(2081.426, 5593.164, 10.81465),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(2081.755, 5590.57, 10.81451),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2082.053, 5587.432, 10.81439),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Robina's Café",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(2081.426, 5593.164, 10.81465)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Robina's Café")
    EndTextCommandSetBlipName(aBlip)

    --

    registerSocietyFarmZone({
        pos      = vector3(3484.098, 5842.393, 10.50245),
        type     = 1,
        item     = "Pain_burger",
        count    = 1,
        size     = 5.0,
        time     = 6000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récupérer des pains à hamburger",
    })
    registerSocietyFarmZone({
        pos      = vector3(2903.356, 7622.553, 9.192783),
        type     = 2,
        item     = "Pain_burger",
        item_g   = "hamburger",
        size     = 5.0,
        time     = 6000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour faire des hamburgers",
    })
    registerSocietyFarmZone({
        pos      = vector3(2377.999, 4893.554, 11.86771),
        type     = 3,
        item     = "hamburger",
        price    = extasy_core_cfg["private_society_sell_price"],
        society  = playerJob,
        size     = 5.0,
        time     = 5000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour vendre votre hamburger",
    })

    local b = {
        {pos = vector3(3484.098, 5842.393, 10.50245), sprite = 502, color = 48, scale = 0.60, title = "Robina's Café | Récolte pain à hamburger"},
        {pos = vector3(2903.356, 7622.553, 9.192783), sprite = 503, color = 48, scale = 0.60, title = "Robina's Café | Transformation hamburger"},
        {pos = vector3(2377.999, 4893.554, 11.86771), sprite = 504, color = 48, scale = 0.60, title = "Robina's Café | Vente hamburger"},
        {pos = vector3(2080.283, 5572.087, 10.81784), sprite = 557, color = 48, scale = 0.60, title = "Robina's Café | Garage"},
        {pos = vector3(2080.594, 5569.706, 10.60308), sprite = 557, color = 59, scale = 0.60, title = "Robina's Café | Rangement véhicule"},
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

robina_inmenu = false

RMenu.Add('Robina_menu', 'main_menu', RageUI.CreateMenu("Robina's Café", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('Robina_menu', 'main_artifices', RageUI.CreateSubMenu(RMenu:Get('Robina_menu', 'main_menu'), "Robina's Café", "Que souhaitez-vous faire ?"))
RMenu.Add('Robina_menu', 'main_blacklist', RageUI.CreateSubMenu(RMenu:Get('Robina_menu', 'main_menu'), "Robina's Café", "Que souhaitez-vous faire ?"))
RMenu.Add('Robina_menu', 'main_blacklist_choose', RageUI.CreateSubMenu(RMenu:Get('Robina_menu', 'main_blacklist'), "Robina's Café", "Qui souhaitez-vous blacklist ?"))
RMenu.Add('Robina_menu', 'main_blacklist_list', RageUI.CreateSubMenu(RMenu:Get('Robina_menu', 'main_blacklist'), "Robina's Café", "Que souhaitez-vous faire ?"))
RMenu.Add('Robina_menu', 'main_citizen_billing', RageUI.CreateSubMenu(RMenu:Get('Robina_menu', 'main_menu'), "Robina's Café", "Que souhaitez-vous faire ?"))
RMenu.Add('Robina_menu', 'main_jukebox', RageUI.CreateSubMenu(RMenu:Get('Robina_menu', 'main_menu'), "Robina's Café", "Que souhaitez-vous faire ?"))
RMenu:Get('Robina_menu', 'main_menu').Closed = function()
    robina_inmenu = false
end

openRobina = function()
    if robina_inmenu then
        robina_inmenu = false
        return
    else
        robina_inmenu = true
        RageUI.Visible(RMenu:Get('Robina_menu', 'main_menu'), true)

        blacklistIndex = 1

        local buy = {}

        Citizen.CreateThread(function()
            while robina_inmenu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('Robina_menu', 'main_menu'), true, false, true, function()
                    if #(GetEntityCoords(GetPlayerPed(-1)) - vector3(2078.4130859375, 5585.8134765625, 10.813915252686)) < 50.0 then
                        if buy.index == nil then buy.index = 1 end
                        RageUI.Button("Faire un hamburger", nil, {RightLabel = Extasy.Math.GroupDigits(cfg_robina.hamburgerPrice).." Pains à hamburger - ← "..buy.index.." →"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                buy.payIndex = buy.index*cfg_robina.hamburgerPrice
                                --buy.capacity = Extasy.GetPlayerCapacity()
                                
                                TriggerServerEvent("robina:buy", token, buy.payIndex)
    
                                TriggerEvent("eCore:AfficherBar", 4000, "⏳ Création du hamburger en cours...")
                                
                                buy.payIndex = nil
                                buy.capacity = nil
                            end
    
                            if Active then
                                if IsControlJustPressed(0, 174) then
                                    if buy.index - 1 < 1 then
                                        buy.index = 100
                                    else
                                        buy.index = buy.index - 1
                                    end
    
                                    RageUI.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "NAV_LEFT_RIGHT")
                                end
                                if IsControlJustPressed(0, 175) then
                                    if buy.index + 1 > 100 then
                                        buy.index = 1
                                    else
                                        buy.index = buy.index + 1
                                    end
    
                                    RageUI.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "NAV_LEFT_RIGHT")
                                end
                            end
                        end)
                    else
                        RageUI.Button("~c~Robina's Café", "Trop loin du siège de l'entreprise pour fabriquer un hamburger", {RightBadge = RageUI.BadgeStyle.Lock, RightLabel = "~c~2 Pains à hamburger - ← 1 →"}, true, function(Hovered, Active, Selected) end)
                    end
    
                    RageUI.Separator("")
    

                    RageUI.Button("Annonce Robina's Café", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                        if s then
                            a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                            if a ~= nil then
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Robina\'s Café', 'Publicité', a, 'CHAR_ROBINA')
                                end
                            else
                                Extasy.ShowNotification("~r~Message invalide")
                            end
                        end
                    end)
                    RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('Robina_menu', 'main_citizen_billing'))                           
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Robina_menu', 'main_citizen_billing'), true, false, true, function()

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
                                                    TriggerServerEvent('robina:sendBilling', token, "Facture Robina's Café", i, "robina", GetPlayerServerId(player), false, nil)
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

Citizen.CreateThread(function()
    for k,v in pairs(cfg_robina.blip) do
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