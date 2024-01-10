InitWeedshop = function()
    registerSocietyFarmZone({ 
        pos           = vector3(2376.79, 5773.27, 10.50),
        spawnPoint    = {
            {pos = vector3(2377.21, 5787.19, 10.07), heading = 180.61},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage WeedShop",
        garage        = {
            {name     = "Rebel 2", hash = "rebel2", props = {color1=42, color2=42}},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage WeedShop",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(2375.07, 5787.32, 10.50),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage WeedShop",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos      = vector3(2347.69, 5798.57, 12.35),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(2343.45, 5802.64, 12.35),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2347.73, 5795.86, 12.32),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "WeedShop",
        service  = false,
    
        blip_enable     = false,
    })

    --
    
    registerSocietyFarmZone({
        pos      = vector3(2337.87, 5802.24, 11.4),
        type     = 1,
        item     = "Weed",
        count    = 1,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter de la Weed",
    })

    registerSocietyFarmZone({
        pos      = vector3(2590.56, 4814.8, 10.03),
        type     = 2,
        item     = "Weed",
        item_g   = "Weed_traite",
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour transformer votre Weed",
    })
    
    registerSocietyFarmZone({
        pos      = vector3(3277.97, 7115.61, 9.91),
        type     = 3,
        item     = "Weed_traite",
        price    = extasy_core_cfg["private_society_sell_price"],
        society  = playerJob,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour vendre votre Weed traitée",
    })

    local b = {
        {pos = vector3(2347.69, 5798.57, 11.35), sprite = 619, color = 26, scale = 0.65, title = "Gestion entreprise WeedShop"},
        {pos = vector3(2337.87, 5802.24, 11.40), sprite = 502, color = 17, scale = 0.60, title = "WeedShop | Récolte Weed"},
        {pos = vector3(2590.56, 4814.8, 10.03), sprite = 503, color = 17, scale = 0.60, title = "WeedShop | Traitement de la Weed"},
        {pos = vector3(3277.97, 7115.61, 9.91), sprite = 504, color = 17, scale = 0.60, title = "WeedShop | Vente de Weed traité"},
        {pos = vector3(2343.45, 5802.64, 12.35), sprite = 557, color = 2,  scale = 0.60, title = "WeedShop | Coffre d'entreprise"},
        {pos = vector3(2347.73, 5795.86, 12.32), sprite = 557, color = 3,  scale = 0.60, title = "WeedShop | Vestaire"},
        {pos = vector3(2376.79, 5773.27, 10.50), sprite = 557, color = 17, scale = 0.60, title = "WeedShop | Garage"},
        {pos = vector3(2375.07, 5787.32, 9.07),  sprite = 557, color = 59, scale = 0.60, title = "WeedShop | Rangement véhicule"},
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

OpenWeedshopMenu = function()
    RMenu.Add('weedshop', 'main', RageUI.CreateMenu("Joint", "Que souhaitez-vous faire ?", 1, 100))
    RMenu.Add('weedshop', 'billing', RageUI.CreateSubMenu(RMenu:Get('weedshop', 'main'), "Joint", "Qui souhaitez-vous facturer ?"))
    RMenu:Get('weedshop', "main").Closed = function()
        weedshop_menu_openned = false

        RMenu:Delete('weedshop', 'main')
        RMenu:Delete('weedshop', 'billing')
    end
    
    if weedshop_menu_openned then
        weedshop_menu_openned = false
        return
    else
        RageUI.CloseAll()

        weedshop_menu_openned = true
        RageUI.Visible(RMenu:Get('weedshop', 'main'), true)
    end

    local buy = {}

    CreateThread(function()
        while weedshop_menu_openned do
            Wait(1)

            RageUI.IsVisible(RMenu:Get('weedshop', 'main'), true, true, true, function()

                if #(GetEntityCoords(GetPlayerPed(-1)) - vector3(2352.24, 5796.44, 12.32)) < 30.0 then
                    if buy.index == nil then buy.index = 1 end
                    RageUI.Button("Joint", nil, {RightLabel = Extasy.Math.GroupDigits(cfg_weedshop.weedPrice).." Weed traitée - ← "..buy.index.." →"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            buy.payIndex = buy.index*cfg_weedshop.weedPrice
                            --buy.capacity = Extasy.GetPlayerCapacity()
                            
                            TriggerServerEvent("weedshop:buy", token, buy.payIndex)

                            TriggerEvent("eCore:AfficherBar", 4000, "⏳ Création de(s) joint(s) en cours...")
                            
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
                    RageUI.Button("~c~Joint", "Trop loin du siège de l'entreprise pour créer des Joints ", {RightBadge = RageUI.BadgeStyle.Lock, RightLabel = "~c~2 Weed traitée - ← 1 →"}, true, function(Hovered, Active, Selected) end)
                end

                RageUI.Separator("")

                RageUI.Button("Annonce WeedShop", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                    if s then
                        local a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                        if a ~= nil then
                            if string.sub(a, 1, string.len("-")) == "-" then
                                Extasy.ShowNotification("~r~Quantité invalide")
                            else
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'WeedShop', '~o~Publicité~s~', a, 'CHAR_WEEDSHOP', 2, "WeedShop")
                                end
                            end
                        else
                            Extasy.ShowNotification("~r~Heure invalide")
                        end
                    end
                end)

                RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('weedshop', 'billing'))                           

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('weedshop', 'billing'), true, true, true, function()

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
                                                TriggerServerEvent('weedshop:sendBilling', token, "Facture WeedShop", i, "weedshop", GetPlayerServerId(player), false, nil)
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

RegisterNetEvent("Extasy:UseWeed")
AddEventHandler("Extasy:UseWeed", function()
    TriggerEvent("Ambiance:PlayUrl", "weed", "https://www.youtube.com/watch?v=zvEJu3VPE9A", 0.05, false)
    StartScreenEffect("ChopVision", 0, 0)
    Wait(1*60000)
    --Destroy("weed")
    StopScreenEffect("ChopVision")
end)

RegisterNetEvent("Extasy:UseAlcool")
AddEventHandler("Extasy:UseAlcool", function()
    --TriggerEvent("Ambiance:PlayUrl", "weed", "https://www.youtube.com/watch?v=zvEJu3VPE9A", 0.05, false)
    StartScreenEffect("ChopVision", 0, 0)
    Wait(1*60000)
    --Destroy("weed")
    StopScreenEffect("ChopVision")
end)



