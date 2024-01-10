local token = nil

Citizen.CreateThread(function()
    TriggerEvent("token:RequestTokenAcces", "zCore", function(t)
        token = t
    end)
end)

loadHawick = function()
    HAWICK = {}

    HAWICK.openMainMenu = function()
        RMenu.Add('hawick_menu', 'main_menu', RageUI.CreateMenu("24/7 Hawick", "Que voulez-vous faire ?", 1, 100))
        RMenu.Add('hawick_menu', 'main_citizen_billing', RageUI.CreateSubMenu(RMenu:Get('hawick_menu', 'main_menu'), "24/7 Hawick", "Que voulez-vous faire ?"))
        RMenu.Add('hawick_menu', 'main_setup_logs', RageUI.CreateSubMenu(RMenu:Get('hawick_menu', 'main_menu'), "24/7 Banham", "Que voulez-vous faire ?"))
        RMenu:Get('hawick_menu', 'main_menu').Closed = function()
            hawick_inmenu = false
    
            RMenu:Delete('hawick_menu', 'main_menu')
            RMenu:Delete('hawick_menu', 'main_citizen_billing')
        end

        settings.color[1] = GetResourceKvpInt("menuR")
        settings.color[2] = GetResourceKvpInt("menuG")
        settings.color[3] = GetResourceKvpInt("menuB")
        
        if not settings.color[1] or not settings.color[2] or not settings.color[3] then
            for name, menu in pairs(RMenu['hawick_menu']) do
                RMenu:Get('hawick_menu', name):SetRectangleBanner(72, 0, 255, 100)
            end
        else
            for name, menu in pairs(RMenu['hawick_menu']) do
                RMenu:Get('hawick_menu', name):SetRectangleBanner(settings.color[1], settings.color[2], settings.color[3], 100)
            end
        end
        
        if hawick_inmenu then
            hawick_inmenu = false
            return
        else
            hawick_inmenu = true
            RageUI.Visible(RMenu:Get('hawick_menu', 'main_menu'), true)
            Citizen.CreateThread(function()
                while hawick_inmenu do
                    Wait(1)
                    RageUI.IsVisible(RMenu:Get('hawick_menu', 'main_menu'), true, false, true, function()

                        if playerInService then
                            RageUI.Button("État de service", nil, {RightLabel = "✅"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    playerInService = not playerInService
    
                                    TriggerServerEvent("jobCounter:remove", token, playerJob)
                                end
                            end)
                        else
                            RageUI.Button("État de service", nil, {RightLabel = "❌"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    playerInService = not playerInService
    
                                    TriggerServerEvent("jobCounter:add", token, playerJob)
                                end
                            end)
                        end

                        RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('hawick_menu', 'main_citizen_billing'))                           
                        RageUI.Button("Annonce 24/7 Hawick", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                            if s then
                                a = zUtils.KeyboardInput("Que voulez-vous dire ?", "", 300)
                                if a ~= nil then
                                    if string.sub(a, 1, string.len("-")) == "-" then
                                        zUtils.ShowNotification("~r~Quantité invalide")
                                    else
                                        if string.len(a) > 5 then
                                            TriggerServerEvent("jobCounter:sendAllAdvancedMessageWithoutShit", token, '24/7 Hawick', 'Publicité', a, 'CHAR_247HAWICK', 8, "24/7 Hawick")
                                        end
                                    end
                                else
                                    zUtils.ShowNotification("~r~Annonce invalide")
                                end
                            end
                        end)

                        if IsPatron(playerJob, tonumber(playerJob_grade)) then
                            for k,v in pairs(cfg_hawick.blip) do
                                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.pos, false) < 50.0 then
                                    RageUI.Button("Gérer les webhooks", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                    end, RMenu:Get('hawick_menu', 'main_setup_logs'))                           
                                else
                                    RageUI.Button("~c~Gérer les webhooks", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                                        if Selected then
                                            zUtils.ShowNotification("~r~Vous devez être à moins de 50 mètres de votre épicerie pour configurer les webhooks")
                                        end
                                    end)                           
                                end
                            end
                        end

                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('hawick_menu', 'main_setup_logs'), true, false, true, function()

                        RageUI.Button("Logs d'achat au grossiste", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local link = zUtils.KeyboardInput("Indiquez le lien webhook", "", 3)
                                if link ~= nil and link ~= '' then
                                    TriggerServerEvent("247shops:setupWebhook", token, 'achats_grossiste', link)
                                else
                                    zUtils.ShowNotification("~r~Webhook invalide")
                                end
                            end
                        end)
                        RageUI.Button("Logs de facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local link = zUtils.KeyboardInput("Indiquez le lien webhook", "", 3)
                                if link ~= nil and link ~= '' then
                                    TriggerServerEvent("247shops:setupWebhook", token, 'facturation', link)
                                else
                                    zUtils.ShowNotification("~r~Webhook invalide")
                                end
                            end
                        end)

                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('hawick_menu', 'main_citizen_billing'), true, false, true, function()

                        for _, player in ipairs(GetActivePlayers()) do
                            local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                            local sta = zUtils.IsMyId(player)
                            local coords = GetEntityCoords(GetPlayerPed(player))
                            local name = replaceText(player)
                
                            if dst < 3.0 then
                                if sta ~= "me" then
                                    RageUI.Button(name.." #".._, nil, {RightLabel = curr_pl_billing}, true, function(Hovered, Active, Selected)
                                        if (Active) then
                                            DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, settings.color[1], settings.color[2], settings.color[3], 100, true, true)
                                            curr_pl_billing = ""
                                        else
                                            curr_pl_billing = "💰"
                                        end
                                        if (Selected) then
                                            i = zUtils.KeyboardInput("Définissez le montant", "", 10)
                                            i = tonumber(i)
                                            if i ~= nil then
                                                if i > 0 then
                                                    if string.sub(i, 1, string.len("-")) == "-" then
                                                        zUtils.ShowNotification("~r~Quantité invalide")
                                                    else
                                                        RageUI.CloseAll()
                                                        hawick_inmenu = false

                                                        ClearPedTasks(GetPlayerPed(-1))
                                                        TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", -1, true)

                                                        Wait(2500)
                                                        TriggerServerEvent('247shops:sendBilling', token, "Facture 24/7 Hawick", i, "24/7 Hawick", GetPlayerServerId(player), false, nil, i * 2.5)
                                                        zUtils.ShowNotification("~g~Vous venez de faire une facture de "..zUtils.Math.GroupDigits(i).."$\nSi la facture est payée, votre société recevra "..zUtils.Math.GroupDigits(i * 2.5).."$ (x2.5)")
                                                    end
                                                else
                                                    zUtils.ShowNotification("~r~Montant invalide")
                                                end
                                            else
                                                zUtils.ShowNotification("~r~Montant invalide")
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

    registerSocietyFarmZone({
        pos      = vector3(-542.29, -183.03, 42.7),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_TEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos           = vector3(216.24, -22.09, 69.72),
        spawnPoint    = {
            {pos = vector3(190.7, -45.05, 68.44), heading = 160.0},
        },
        type          = 5,
        msg           = "~p~Appuyez sur E pour ouvrir le garage de l'épicerie",
        garage        = {
            {name     = "Box ville retro", hash = "boxvilleretro"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Fourrière",
        size          = 2.5,
    })
    
    registerSocietyFarmZone({
        pos           = vector3(190.7, -45.05, 68.44),
        type          = 7,
        msg           = "~r~Appuyez sur E pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Épicerie",
        size          = 2.5,
    })

    aBlip = AddBlipForCoord(-542.29, -183.03, 42.7)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise 24/7 Hawick")
    EndTextCommandSetBlipName(aBlip)

    registerSocietyFarmZone({
        pos      = vector3(196.37, -34.18, 69.89),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_TEXT~ pour ouvrir le coffre de la société",
    })

    local currentIndex, payIndex = 1, 1

    HAWICK.openCatalogMenu = function()
        RMenu.Add('hawick_menu_catalog', 'main_menu', RageUI.CreateMenu("24/7 Hawick", "Que voulez-vous faire ?", 1, 100))
        RMenu:Get('hawick_menu_catalog', 'main_menu').Closed = function()
            hawick_inmenu = false
    
            RMenu:Delete('hawick_menu_catalog', 'main_menu')

            for k,v in pairs(cfg_hawick.catalog) do
                RMenu:Delete('hawick_menu_catalog', v.value)
            end
        end

        for k,v in pairs(cfg_hawick.catalog) do
            RMenu.Add('hawick_menu_catalog', v.value, RageUI.CreateSubMenu(RMenu:Get('hawick_menu_catalog', 'main_menu'), "24/7 Hawick", "Que voulez-vous faire ?"))
        end

        settings.color[1] = GetResourceKvpInt("menuR")
        settings.color[2] = GetResourceKvpInt("menuG")
        settings.color[3] = GetResourceKvpInt("menuB")
        
        if not settings.color[1] or not settings.color[2] or not settings.color[3] then
            for name, menu in pairs(RMenu['hawick_menu_catalog']) do
                RMenu:Get('hawick_menu_catalog', name):SetRectangleBanner(72, 0, 255, 100)
            end
        else
            for name, menu in pairs(RMenu['hawick_menu_catalog']) do
                RMenu:Get('hawick_menu_catalog', name):SetRectangleBanner(settings.color[1], settings.color[2], settings.color[3], 100)
            end
        end
        
        if hawick_inmenu then
            hawick_inmenu = false
            return
        else
            hawick_inmenu = true
            RageUI.Visible(RMenu:Get('hawick_menu_catalog', 'main_menu'), true)
            Citizen.CreateThread(function()
                while hawick_inmenu do
                    Wait(1)
                    RageUI.IsVisible(RMenu:Get('hawick_menu_catalog', 'main_menu'), true, false, true, function()

                        RageUI.List("Mode de paiement", core_cfg["available_payments_billing_society"], payIndex, nil, {}, true, function(h, a, s, Index)
                            payIndex = Index
                        end)
                        RageUI.Separator("")

                        for k,v in pairs(cfg_hawick.catalog) do
                            RageUI.Button(v.name, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('hawick_menu_catalog', v.value))                           
                        end

                    end, function()
                    end)

                    for k,v in pairs(cfg_hawick.catalog) do
                        RageUI.IsVisible(RMenu:Get('hawick_menu_catalog', v.value), true, false, true, function()

                            RageUI.List("Mode de paiement", core_cfg["available_payments_billing_society"], payIndex, nil, {}, true, function(h, a, s, Index)
                                payIndex = Index
                            end)
                            RageUI.Separator("")

                            for i,l in pairs(v.list) do
                                local desc = nil
                                if l.index > 1 then
                                    desc = "Acheter x"..l.index.." "..l.name.." vous coute "..zUtils.Math.GroupDigits(l.price * l.index).."$"
                                end
                                RageUI.Button(l.name, desc, {RightLabel = zUtils.Math.GroupDigits(l.price).."$ - ← "..l.index.." →"}, true, function(Hovered, Active, Selected)
                                    if Selected then
                                        l.payIndex = payIndex
                                        l.capacity = zUtils.GetPlayerCapacity()
                                        
                                        TriggerServerEvent("24/7:buy", token, l)
                                        
                                        l.payIndex = nil
                                        l.capacity = nil
                                    end

                                    if Active then
                                        if IsControlJustPressed(0, 174) then
                                            if l.index - 1 < 1 then
                                                l.index = 100
                                            else
                                                l.index = l.index - 1
                                            end
            
                                            RageUI.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "NAV_LEFT_RIGHT")
                                        end
                                        if IsControlJustPressed(0, 175) then
                                            if l.index + 1 > 100 then
                                                l.index = 1
                                            else
                                                l.index = l.index + 1
                                            end
            
                                            RageUI.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "NAV_LEFT_RIGHT")
                                        end
                                    end
                                end)                           
                            end

                        end, function()
                        end)
                    end
                end
            end)
        end
    end

    Citizen.CreateThread(function()
        while true do
            local nearThing = false

            for k,v in pairs(cfg_hawick.catalogPos) do
                local dst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(GetPlayerPed(-1)), false)

                if dst < 5.0 then
                    nearThing = true

                    zUtils.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu grossiste des épiceries")
                    DrawMarker(6, v.pos.x, v.pos.y, v.pos.z - 1.0, nil, nil, nil, -90, nil, nil, 5.0, 5.0, 5.0, settings.color[1], settings.color[2], settings.color[3], 100, false, false)

                    if IsControlJustPressed(0, 38) then
                        HAWICK.openCatalogMenu()
                    end
                end
            end

            if nearThing then
                Citizen.Wait(0)
            else
                Citizen.Wait(500)
            end
        end
    end)

    local blips = {}
    for k,v in pairs(cfg_hawick.catalogPos) do
        blips[k] = AddBlipForCoord(v.pos)
        SetBlipSprite(blips[k], 478)
        SetBlipDisplay(blips[k], 4)
        SetBlipColour(blips[k], 47)
        SetBlipScale(blips[k], 0.65)
        SetBlipAsShortRange(blips[k], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Magasin grossiste épiceries")
        EndTextCommandSetBlipName(blips[k])
    end
end

Citizen.CreateThread(function()
    for k,v in pairs(cfg_hawick.blip) do
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