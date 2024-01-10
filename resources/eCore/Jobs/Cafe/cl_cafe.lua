local index = 1
local playersInArea = {}
local inAreaData = {}

InitFront = function()    
    registerSocietyFarmZone({
        pos           = vector3(3466.35, 4974.22, 9.87),
        spawnPoint    = {
            {pos = vector3(3453.78, 4976.03, 9.56), heading = 169.96},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage du Front Page Café",
        garage        = {
            {name     = "Speedo", hash = "speedo"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Front Page Café",
        size          = 2.5,
    })
    registerSocietyFarmZone({
        pos           = vector3(3453.78, 4976.03, 9.56),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Front Page Café",
        size          = 2.5,
    })

    registerSocietyFarmZone({
        pos      = vector3(3468.67, 4974.87, 13.44),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(3480.96, 4970.75, 13.44),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(3478.79, 4970.939, 13.44972),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Front Page",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(3468.67, 4974.87, 13.44)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Front Page Café")
    EndTextCommandSetBlipName(aBlip)

    --

    registerSocietyFarmZone({
        pos      = vector3(2055.892, 5906.394, 10.31625),
        type     = 1,
        item     = "Grain_cafe",
        count    = 1,
        size     = 5.0,
        time     = 6000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter des grains de café",
    })
    registerSocietyFarmZone({
        pos      = vector3(3277.881, 7115.447, 9.912816),
        type     = 2,
        item     = "Grain_cafe",
        item_g   = "Cafe_moulu",
        size     = 5.0,
        time     = 6000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour moudre votre café",
    })
    registerSocietyFarmZone({
        pos      = vector3(3541.11, 7209.941, 12.43631),
        type     = 3,
        item     = "Cafe_moulu",
        price    = extasy_core_cfg["private_society_sell_price"],
        society  = playerJob,
        size     = 5.0,
        time     = 5000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour vendre votre café",
    })

    local b = {
        {pos = vector3(2055.892, 5906.394, 10.31625), sprite = 502, color = 48, scale = 0.60, title = "Front Page Café | Récolte café"},
        {pos = vector3(3277.881, 7115.447, 9.912816), sprite = 503, color = 48, scale = 0.60, title = "Front Page Café | Transformation Café"},
        {pos = vector3(3541.11, 7209.941, 12.43631), sprite = 504, color = 48, scale = 0.60, title = "Front Page Café | Vente Café"},
        {pos = vector3(3466.35, 4974.22, 9.87), sprite = 557, color = 48, scale = 0.60, title = "Front Page Café | Garage"},
        {pos = vector3(3453.78, 4976.03, 9.56), sprite = 557, color = 59, scale = 0.60, title = "Front Page Café | Rangement véhicule"},
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

front_inmenu = false

RMenu.Add('Front_menu', 'main_menu', RageUI.CreateMenu("Front Page", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('Front_menu', 'main_artifices', RageUI.CreateSubMenu(RMenu:Get('Front_menu', 'main_menu'), "Front Page", "Que souhaitez-vous faire ?"))
RMenu.Add('Front_menu', 'main_blacklist', RageUI.CreateSubMenu(RMenu:Get('Front_menu', 'main_menu'), "Front Page", "Que souhaitez-vous faire ?"))
RMenu.Add('Front_menu', 'main_blacklist_choose', RageUI.CreateSubMenu(RMenu:Get('Front_menu', 'main_blacklist'), "Front Page", "Qui souhaitez-vous blacklist ?"))
RMenu.Add('Front_menu', 'main_blacklist_list', RageUI.CreateSubMenu(RMenu:Get('Front_menu', 'main_blacklist'), "Front Page", "Que souhaitez-vous faire ?"))
RMenu.Add('Front_menu', 'main_citizen_billing', RageUI.CreateSubMenu(RMenu:Get('Front_menu', 'main_menu'), "Front Page", "Que souhaitez-vous faire ?"))
RMenu.Add('Front_menu', 'main_jukebox', RageUI.CreateSubMenu(RMenu:Get('Front_menu', 'main_menu'), "Front Page", "Que souhaitez-vous faire ?"))
RMenu:Get('Front_menu', 'main_menu').Closed = function()
    front_inmenu = false
end

openFront = function()
    if front_inmenu then
        front_inmenu = false
        return
    else
        front_inmenu = true
        RageUI.Visible(RMenu:Get('Front_menu', 'main_menu'), true)

        blacklistIndex = 1

        local buy = {}

        Citizen.CreateThread(function()
            while front_inmenu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('Front_menu', 'main_menu'), true, false, true, function()
                    if #(GetEntityCoords(GetPlayerPed(-1)) - vector3(3475.589, 4971.75, 13.44973)) < 50.0 then
                        if buy.index == nil then buy.index = 1 end
                        RageUI.Button("Faire un café", nil, {RightLabel = Extasy.Math.GroupDigits(cfg_cafe.cafePrice).." Café moulu - ← "..buy.index.." →"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                buy.payIndex = buy.index*cfg_cafe.cafePrice
                                --buy.capacity = Extasy.GetPlayerCapacity()
                                
                                TriggerServerEvent("front:buy", token, buy.payIndex)
    
                                TriggerEvent("eCore:AfficherBar", 4000, "⏳ Création du café en cours...")
                                
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
                        RageUI.Button("~c~Front Page", "Trop loin du siège de l'entreprise pour fabriquer du café", {RightBadge = RageUI.BadgeStyle.Lock, RightLabel = "~c~2 Café moulu - ← 1 →"}, true, function(Hovered, Active, Selected) end)
                    end
    
                    RageUI.Separator("")
    

                    RageUI.Button("Annonce Front Page", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                        if s then
                            a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                            if a ~= nil then
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Front Page Café', 'Publicité', a, 'CHAR_FRONT')
                                end
                            else
                                Extasy.ShowNotification("~r~Message invalide")
                            end
                        end
                    end)
                    RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('Front_menu', 'main_citizen_billing'))                           
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Front_menu', 'main_citizen_billing'), true, false, true, function()

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
                                                    TriggerServerEvent('front:sendBilling', token, "Facture Front Page Café", i, "frontpage", GetPlayerServerId(player), false, nil)
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
    for k,v in pairs(cfg_cafe.blip) do
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