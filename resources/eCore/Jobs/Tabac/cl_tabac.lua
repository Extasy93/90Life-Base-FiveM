local started = false
local grade = 0.5
local disabledControl = 0
local bestTabacSeller = {}
local showLeaderboard = true
local askedData = false
local MyData = {}

InitTabac = function()
    registerSocietyFarmZone({ 
        pos           = vector3(2151.32, 4817.81, 10.85),
        spawnPoint    = {
            {pos = vector3(2142.53, 4827.13, 10.56), heading = 70.30},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage Tabac & Co",
        garage        = {
            {name     = "Rebel", hash = "rebel", props = {color1=42, color2=42}},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Tabac & Co",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(2141.66, 4827.56, 10.55),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Tabac & Co",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos      = vector3(2147.07, 4853.04, 11.10),
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
        pos      = vector3(2162.69, 4850.74, 10.85),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Tabac & Co",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(2147.07, 4853.04, 11.10)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Tabac & Co")
    EndTextCommandSetBlipName(aBlip)
    
    registerSocietyFarmZone({
        pos      = vector3(3452.82, 7436.56, 16.35),
        type     = 1,
        item     = "Tabac",
        count    = 1,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter du tabac",
    })

    registerSocietyFarmZone({
        pos      = vector3(2159.53, 4836.89, 10.85),
        type     = 2,
        item     = "Tabac",
        item_g   = "Tabac_traite",
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour transformer votre tabac",
    })
    
    registerSocietyFarmZone({
        pos      = vector3(2589.13, 4809.32, 10.03),
        type     = 3,
        item     = "Tabac_traite",
        price    = extasy_core_cfg["private_society_sell_price"],
        society  = playerJob,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour vendre votre tabac traité",
    })

    local b = {
        {pos = vector3(3452.82, 7436.56, 16.35), sprite = 502, color = 17, scale = 0.60, title = "Tabac & Co | Récolte tabac"},
        {pos = vector3(2159.53, 4836.89, 10.85), sprite = 503, color = 17, scale = 0.60, title = "Tabac & Co | Traitement du tabac"},
        {pos = vector3(2589.13, 4809.32, 10.03), sprite = 504, color = 17, scale = 0.60, title = "Tabac & Co | Vente de tabac traité"},
        {pos = vector3(2170.53, 4847.15, 10.85), sprite = 557, color = 2,  scale = 0.60, title = "Tabac & Co | Coffre d'entreprise"},
        {pos = vector3(2144.61, 4860.91, 11.10), sprite = 557, color = 3,  scale = 0.60, title = "Tabac & Co | Vestaire"},
        {pos = vector3(2151.32, 4817.81, 10.85), sprite = 557, color = 17, scale = 0.60, title = "Tabac & Co | Garage"},
        {pos = vector3(2141.66, 4827.56, 10.55), sprite = 557, color = 59, scale = 0.60, title = "Tabac & Co | Rangement véhicule"},
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
    
            for k,l in pairs(cfg_tabac.leaderboard) do
                local dst = GetDistanceBetweenCoords(l.pos, GetEntityCoords(PlayerPedId()), false)
    
                if dst < 5.0 then
                    nearThing = true
    
                    if showLeaderboard then
                        Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + 2.39), "~s~[G] pour cacher le tableau", 0.75)
                        Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + 2.35), "~p~Tableau des employées~s~", 1.75)
    
                        local zOffset = 0
                        zOffset = 0.230*9
                        for k,v in pairs(bestTabacSeller) do
                            if k == 1 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~y~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            elseif k == 2 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~r~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            elseif k == 3 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~w~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            elseif k == 4 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            elseif k == 5 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            elseif k == 6 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            elseif k == 7 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            elseif k == 8 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            elseif k == 9 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            elseif k == 10 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            elseif k == nil then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." tabac traité(s) vendu ~s~", 1.0)
                            end

                            zOffset = zOffset - 0.150
                        end
                    end
                end
    
                --if dst < 1.5 and place == 0 then
                --    Extasy.ShowHelpNotification("Appuyez sur ~p~~INPUT_TALK~ ~w~pour interagir avec ~p~la table de bras de fer")
                --end
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
            for k,v in pairs(cfg_tabac.leaderboard) do
                local dst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
    
                if dst < 5.0 then
                    if not askedData then
                        TriggerServerEvent("tabac:getLeaderboard", token)
                    end
                end
            end
        end
    end)
end

OpenTabacMenu = function()
    RMenu.Add('tabac', 'main', RageUI.CreateMenu("Cigarettes", "Que souhaitez-vous faire ?", 1, 100))
    RMenu.Add('tabac', 'billing', RageUI.CreateSubMenu(RMenu:Get('tabac', 'main'), "Cigarettes", "Qui souhaitez-vous facturer ?"))
    RMenu:Get('tabac', "main").Closed = function()
        tabac_menu_openned = false

        RMenu:Delete('tabac', 'main')
        RMenu:Delete('tabac', 'billing')
    end
    
    if tabac_menu_openned then
        tabac_menu_openned = false
        return
    else
        RageUI.CloseAll()

        tabac_menu_openned = true
        RageUI.Visible(RMenu:Get('tabac', 'main'), true)
    end

    local buy = {}

    CreateThread(function()
        while tabac_menu_openned do
            Wait(1)

            RageUI.IsVisible(RMenu:Get('tabac', 'main'), true, true, true, function()

                if #(GetEntityCoords(GetPlayerPed(-1)) - vector3(2147.66, 4859.96, 11.10)) < 50.0 then
                    if buy.index == nil then buy.index = 1 end
                    RageUI.Button("Cigarettes", nil, {RightLabel = Extasy.Math.GroupDigits(cfg_tabac.tabacPrice).." Tabac traité - ← "..buy.index.." →"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            buy.payIndex = buy.index*cfg_tabac.tabacPrice
                            --buy.capacity = Extasy.GetPlayerCapacity()
                            
                            TriggerServerEvent("tabac:buy", token, buy.payIndex)

                            TriggerEvent("eCore:AfficherBar", 4000, "⏳ Création de(s) cigarette(s) en cours...")
                            
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
                    RageUI.Button("~c~Cigarettes", "Trop loin du siège de l'entreprise pour créer des Cigarettes", {RightBadge = RageUI.BadgeStyle.Lock, RightLabel = "~c~2 Tabac traité - ← 1 →"}, true, function(Hovered, Active, Selected) end)
                end

                RageUI.Separator("")

                RageUI.Button("Annonce Tabac & Co", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                    if s then
                        local a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                        if a ~= nil then
                            if string.sub(a, 1, string.len("-")) == "-" then
                                Extasy.ShowNotification("~r~Quantité invalide")
                            else
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Tabac & Co', '~o~Publicité~s~', a, 'CHAR_TABAC', 2, "Tabac & Co")
                                end
                            end
                        else
                            Extasy.ShowNotification("~r~Heure invalide")
                        end
                    end
                end)

                RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('tabac', 'billing'))  

                RageUI.Button("Réinitialisation du tableau employer", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                    if s then
                        TriggerServerEvent("Jobs:resetLeaderboard", token, "tabac")
                        Wait(1000)
                        Extasy.ShowNotification("~g~Le tableau des employé a bien été réinitialisé")
                    end
                end)                           

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('tabac', 'billing'), true, true, true, function()

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
                                                TriggerServerEvent('tabac:sendBilling', token, "Facture Tabac & Co", i, "tabac", GetPlayerServerId(player), false, nil)
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
    for k,v in pairs(cfg_tabac.blip) do
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

RegisterNetEvent("tabac:sendLeaderboard")
AddEventHandler("tabac:sendLeaderboard", function(data)
    bestTabacSeller = data
end)