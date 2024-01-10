local index = 1
local playersInArea = {}
local inAreaData = {}
local bestIceSeller = {}
local showLeaderboard = true

InitIce = function()    
    registerSocietyFarmZone({
        pos           = vector3(2386.44, 5623.87, 10.06),
        spawnPoint    = {
            {pos = vector3(2385.7, 5633.72, 10.05), heading = 279.0},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage du Ice Cream",
        garage        = {
            {name     = "Speedo", hash = "speedo"},
            {name     = "Camion de glaces", hash = "taco"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Ice Cream",
        size          = 2.5,
    })
    registerSocietyFarmZone({
        pos           = vector3(2385.7, 5633.72, 10.05),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Ice Cream",
        size          = 2.5,
    })

    registerSocietyFarmZone({
        pos      = vector3(2367.81, 5628.98, 10.23),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(2364.89, 5622.67, 14.02),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2363.39, 5634.75, 14.02),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Ice Cream",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(2367.81, 5628.98, 10.23)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Ice Cream")
    EndTextCommandSetBlipName(aBlip)

    --

    registerSocietyFarmZone({
        pos      = vector3(2334.596, 7055.974, 10.08617),
        type     = 1,
        item     = "Creme_glacee",
        count    = 1,
        size     = 5.0,
        time     = 6000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter de la crème glacée",
    })
    registerSocietyFarmZone({
        pos      = vector3(3273.436, 4949.783, 9.42063),
        type     = 2,
        item     = "Creme_glacee",
        item_g   = "Glace_vanille",
        size     = 5.0,
        time     = 6000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour traiter votre crème glacée",
    })
    registerSocietyFarmZone({
        pos      = vector3(2353.78, 5635.344, 11.98115),
        type     = 3,
        item     = "Glace_vanille",
        price    = extasy_core_cfg["private_society_sell_price"],
        society  = playerJob,
        size     = 5.0,
        time     = 5000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour vendre votre glace",
    })

    local b = {
        {pos = vector3(2334.596, 7055.974, 10.08617), sprite = 502, color = 48, scale = 0.60, title = "Ice Cream | Récolte crème"},
        {pos = vector3(3273.436, 4949.783, 9.42063), sprite = 503, color = 48, scale = 0.60, title = "Ice Cream | Transformation crème"},
        {pos = vector3(2353.78, 5635.344, 11.98115), sprite = 504, color = 48, scale = 0.60, title = "Ice Cream | Vente glace"},
        {pos = vector3(2386.44, 5623.87, 10.06), sprite = 557, color = 48, scale = 0.60, title = "Ice Cream | Garage"},
        {pos = vector3(2385.7, 5633.72, 10.05), sprite = 557, color = 59, scale = 0.60, title = "Ice Cream | Rangement véhicule"},
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
    
            for k,l in pairs(cfg_ice.leaderboard) do
                local dst = GetDistanceBetweenCoords(l.pos, GetEntityCoords(PlayerPedId()), false)
    
                if dst < 5.0 then
                    nearThing = true
    
                    if showLeaderboard then
                        Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + 2.39), "~s~[G] pour cacher le tableau", 0.75)
                        Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + 2.35), "~p~Tableau des employées~s~", 1.75)
    
                        local zOffset = 0
                        zOffset = 0.230*9
                        for k,v in pairs(bestIceSeller) do
                            if k == 1 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~y~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
                            elseif k == 2 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~r~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
                            elseif k == 3 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~w~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
                            elseif k == 4 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
                            elseif k == 5 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
                            elseif k == 6 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
                            elseif k == 7 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
                            elseif k == 8 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
                            elseif k == 9 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
                            elseif k == 10 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
                            elseif k == nil then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." glace(s) vendu ~s~", 1.0)
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
            for k,v in pairs(cfg_ice.leaderboard) do
                local dst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
    
                if dst < 5.0 then
                    if not askedData then
                        TriggerServerEvent("ice:getLeaderboard", token)
                    end
                end
            end
        end
    end)
end

ice_inmenu = false

RMenu.Add('Ice_menu', 'main_menu', RageUI.CreateMenu("Ice Cream", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('Ice_menu', 'main_artifices', RageUI.CreateSubMenu(RMenu:Get('Ice_menu', 'main_menu'), "Ice Cream", "Que souhaitez-vous faire ?"))
RMenu.Add('Ice_menu', 'main_blacklist', RageUI.CreateSubMenu(RMenu:Get('Ice_menu', 'main_menu'), "Ice Cream", "Que souhaitez-vous faire ?"))
RMenu.Add('Ice_menu', 'main_blacklist_choose', RageUI.CreateSubMenu(RMenu:Get('Ice_menu', 'main_blacklist'), "Ice Cream", "Qui souhaitez-vous blacklist ?"))
RMenu.Add('Ice_menu', 'main_blacklist_list', RageUI.CreateSubMenu(RMenu:Get('Ice_menu', 'main_blacklist'), "Ice Cream", "Que souhaitez-vous faire ?"))
RMenu.Add('Ice_menu', 'main_citizen_billing', RageUI.CreateSubMenu(RMenu:Get('Ice_menu', 'main_menu'), "Ice Cream", "Que souhaitez-vous faire ?"))
RMenu.Add('Ice_menu', 'main_jukebox', RageUI.CreateSubMenu(RMenu:Get('Ice_menu', 'main_menu'), "Ice Cream", "Que souhaitez-vous faire ?"))
RMenu:Get('Ice_menu', 'main_menu').Closed = function()
    ice_inmenu = false
end

openIce = function()
    if ice_inmenu then
        ice_inmenu = false
        return
    else
        ice_inmenu = true
        RageUI.Visible(RMenu:Get('Ice_menu', 'main_menu'), true)

        blacklistIndex = 1

        local buy = {}

        Citizen.CreateThread(function()
            while ice_inmenu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('Ice_menu', 'main_menu'), true, false, true, function()
                    if #(GetEntityCoords(GetPlayerPed(-1)) - vector3(2373.41, 5630.23, 10.23)) < 50.0 then
                        if buy.index == nil then buy.index = 1 end
                        RageUI.Button("Faire une glace", nil, {RightLabel = Extasy.Math.GroupDigits(cfg_ice.icePrice).." Crème glacée - ← "..buy.index.." →"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                buy.payIndex = buy.index*cfg_ice.icePrice
                                --buy.capacity = Extasy.GetPlayerCapacity()
                                
                                TriggerServerEvent("ice:buy", token, buy.payIndex)
    
                                TriggerEvent("eCore:AfficherBar", 4000, "⏳ Création de la glace en cours...")
                                
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
                        RageUI.Button("~c~Ice Cream", "Trop loin du siège de l'entreprise pour fabriquer de la glace", {RightBadge = RageUI.BadgeStyle.Lock, RightLabel = "~c~2 Crème glacée - ← 1 →"}, true, function(Hovered, Active, Selected) end)
                    end
    
                    RageUI.Separator("")
    

                    RageUI.Button("Annonce Ice Cream", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                        if s then
                            a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                            if a ~= nil then
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Ice Cream', 'Publicité', a, 'CHAR_ICE')
                                end
                            else
                                Extasy.ShowNotification("~r~Message invalide")
                            end
                        end
                    end)

                    RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('Ice_menu', 'main_citizen_billing'))
                    
                    RageUI.Button("Réinitialisation du tableau employer", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                        if s then
                            TriggerServerEvent("Jobs:resetLeaderboard", token, "icecream")
                            Wait(1000)
                            Extasy.ShowNotification("~g~Le tableau des employé a bien été réinitialisé")
                        end
                    end)  
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Ice_menu', 'main_citizen_billing'), true, false, true, function()

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
                                                    TriggerServerEvent('ice:sendBilling', token, "Facture Ice Cream", i, "icecream", GetPlayerServerId(player), false, nil)
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
    for k,v in pairs(cfg_ice.blip) do
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

RegisterNetEvent("ice:sendLeaderboard")
AddEventHandler("ice:sendLeaderboard", function(data)
    bestIceSeller = data
end)