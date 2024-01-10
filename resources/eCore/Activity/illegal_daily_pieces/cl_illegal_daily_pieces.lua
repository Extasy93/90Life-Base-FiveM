IDP                       = {}
IDP.inHour                = false
IDP.spawned               = false
IDP.tableOpenned          = false
IDP.objNetID              = nil
IDP.randomZone            = nil
IDP.blip                  = nil
IDP.clicked               = false
cfg_craft_job             = {}

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()
    IDP.WeaponData = ESX.GetWeaponList()

    for i = 1, #IDP.WeaponData, 1 do
		if IDP.WeaponData[i].name == 'WEAPON_UNARMED' then
			IDP.WeaponData[i] = nil
		else
			IDP.WeaponData[i].hash = GetHashKey(IDP.WeaponData[i].name)
		end
    end

    while IDP.WeaponData == nil do
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(3000)

        if extasy_core_cfg["daily_pieces_activity"] then

            local _, _, _, hour, min, second = GetLocalTime()
            --print(hour, min)
            --print(IDP.inHour)

            if hour == 23 and min < 30 then
                if not IDP.inHour then
                    TriggerServerEvent("illegal_daily_pieces:startHerePlease", token)
                end
            elseif hour == 04 and min < 30 then
                if not IDP.inHour then
                    TriggerServerEvent("illegal_daily_pieces:startHerePlease", token)
                end
            elseif hour == 15 and min < 30 then
                if not IDP.inHour then
                    TriggerServerEvent("illegal_daily_pieces:startHerePlease", token)
                end
            else
                if IDP.inHour then
                    TriggerServerEvent("illegal_daily_pieces:keepThisBlocked", token)
                    IDP.inHour = false
                    IDP.spawned = false
                    --IDP.notInHourFunction()
                end
            end
        end
    end
end)

IDP.notInHourFunction = function()
    while not IDP.inHour do
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
        local dst = GetDistanceBetweenCoords(pCoords, cfg_illegal_daily_pieces.coords, true)

        if dst < cfg_illegal_daily_pieces.radius then
            AddTextEntry("SHOW_IDP_INFO_TIME", "Une activité illégale se passe ici de (16h00-16h30 / 23h00-23h30")
            Extasy.ShowFloatingHelp("SHOW_IDP_INFO_TIME", vector3(pCoords.x, pCoords.y, pCoords.z + 0.5))
        end
        Wait(1)
    end
end

RMenu.Add('IDP_objects_buyer', 'main_menu', RageUI.CreateMenu("Table de craft", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('IDP_objects_buyer', 'main_menu_craft', RageUI.CreateSubMenu(RMenu:Get('IDP_objects_buyer', 'main_menu'), "Table de craft", "Que souhaitez-vous craft ?"))
RMenu.Add('IDP_objects_buyer', 'main_menu_destroy', RageUI.CreateSubMenu(RMenu:Get('IDP_objects_buyer', 'main_menu'), "Table de craft", "Que souhaitez-vous détruire ?"))
RMenu:Get('IDP_objects_buyer', 'main_menu').Closed = function()
    IDP.tableOpenned     = false
    FreezeEntityPosition(GetPlayerPed(-1), false)
end

IDP.openIllegalTable = function()
    if IDP.tableOpenned then
        IDP.tableOpenned = false
        return
    else
        FreezeEntityPosition(GetPlayerPed(-1), true)
        IDP.tableOpenned = true
        local wFounded, pCount = false, 0

        --[[ESX.PlayerData = ESX.GetPlayerData()
        IDP.WeaponData = ESX.GetWeaponList()

        for i = 1, #IDP.WeaponData, 1 do
            for i,l in pairs(cfg_illegal_daily_pieces.uncraft) do
                if HasPedGotWeapon(GetPlayerPed(-1), IDP.WeaponData[i].hash, false) then
                    --print(l.item)
                    print(IDP.WeaponData[i].name)
                    --print(IDP.WeaponData[i].hash)
                    --print(IDP.WeaponData[i].label)
                    if l.item == IDP.WeaponData[i].name then
                        wFounded = true
                        print(IDP.WeaponData[i].hash)
                        print(l.item)
                        print("C'est bon MEC !!!")
                    end
                end
            end
        end--]]

        ESX.PlayerData = ESX.GetPlayerData()

        for v = 1, #ESX.PlayerData.inventory, 1 do
            if ESX.PlayerData.inventory[v].name == "Piece_arme" then
                pCount = ESX.PlayerData.inventory[v].count
            end
        end

        Citizen.CreateThread(function()
            while IDP.tableOpenned do
                Wait(1)

                RageUI.IsVisible(RMenu:Get('IDP_objects_buyer', 'main_menu'), true, true, true, function()
                    RageUI.Separator('~r~x'..pCount.."~s~ Pièces d'armes")

                    RageUI.Button("Craft des armes", nil, {}, true, function(Hovered, Active, Selected) end, RMenu:Get('IDP_objects_buyer', 'main_menu_craft'))
                    if wFounded then
                        RageUI.Button("Détruire mes armes", "Obtenez des pièces d'armes grâce à la destruction des vôtres", {}, true, function(Hovered, Active, Selected) end, RMenu:Get('IDP_objects_buyer', 'main_menu_destroy'))
                    end
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('IDP_objects_buyer', 'main_menu_destroy'), true, true, true, function()
                    for v = 1, #ESX.PlayerData.inventory, 1 do
                        if string.sub(v.name, 1, string.len("WEAPON_")) == "WEAPON_" then
                            for i,l in pairs(cfg_illegal_daily_pieces.uncraft) do
                                if l.item == v.name then
                                    RageUI.Button(v.label, nil, {RightLabel = l.price.." pièces"}, true, function(Hovered, Active, Selected)
                                        if Selected then
                                            --exports["m93_tools"]:M93_TriggerServerCallback("illegal_daily_pieces:checkInventoryForDestroy", function(i)
                                                if i < 1 then
                                                    Extasy.ShowNotification("~r~Vous n'avez pas l'arme nécessaire sur vous")
                                                else
                                                    TriggerServerEvent("illegal_daily_pieces:processExchangeWeaponToPieces", token, v.olabel, 1, "Piece_arme", l.price, v.itemId)
                                                    PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
                                                    RageUI.CloseAll()
                                                    IDP.tableOpenned = false
                                                end
                                            --end, token, v.name)
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('IDP_objects_buyer', 'main_menu_craft'), true, true, true, function()
                    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == "sinaloa" then
                        cfg_craft_job = cfg_illegal_daily_pieces.craftUzi
                    elseif ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == "ballas" or ESX.PlayerData.job2.name == "vagos" or ESX.PlayerData.job2.name == "families" or ESX.PlayerData.job2.name == "marabunta" then
                        cfg_craft_job = cfg_illegal_daily_pieces.craftGang
                    elseif ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == "milice" then
                        cfg_craft_job = cfg_illegal_daily_pieces.craftMilice
                    elseif ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == "albanais" then
                        cfg_craft_job = cfg_illegal_daily_pieces.craftMafia
                    elseif ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == "bratva" then
                        cfg_craft_job = cfg_illegal_daily_pieces.craftMafia
                    else
                        cfg_craft_job = cfg_illegal_daily_pieces.NoCraft
                    end

                    for k,v in pairs(cfg_craft_job) do
                        local canBuy = false

                        if pCount >= v.price then
                            RageUI.Button(v.name, nil, {RightLabel = Extasy.Math.GroupDigits(v.price).." pièces"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    FreezeEntityPosition(GetPlayerPed(-1), true)
                                    TriggerEvent("eCore:AfficherBar", token, 15000, " Création de l'armes en cours...")
                                    ExecuteCommand("e mechanic")
                                    Citizen.Wait(15000)
                                    ClearPedTasks(GetPlayerPed(-1))
                                    FreezeEntityPosition(GetPlayerPed(-1), false)

                                    if v.price > pCount then
                                        Extasy.ShowNotification("~r~Vous n'avez pas assez de pièces sur vous")
                                    else
                                        TriggerServerEvent("illegal_daily_pieces:processExchangePiecesToWeapon", token, v.price, v.item)
                                        PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
                                        RageUI.CloseAll()
                                        IDP.tableOpenned = false
                                    end
                                end
                            end)
                        else
                            RageUI.Button("~c~"..v.name, nil, {RightLabel = "~c~"..Extasy.Math.GroupDigits(v.price).." pièces", RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
                        end
                    end
                end, function()
                end)
            end
        end)
    end
end

IDP.initIllegalTable = function()
    --if IDP.inHour then
        --[[settings.color[1] = GetResourceKvpInt("menuR")
        settings.color[2] = GetResourceKvpInt("menuG")
        settings.color[3] = GetResourceKvpInt("menuB")

        if not settings.color[1] or not settings.color[2] or not settings.color[3] then
            for name, menu in pairs(RMenu['IDP_objects_buyer']) do
                RMenu:Get('IDP_objects_buyer', name):SetRectangleBanner(72, 0, 255, 100)
            end
        else
            for name, menu in pairs(RMenu['IDP_objects_buyer']) do
                RMenu:Get('IDP_objects_buyer', name):SetRectangleBanner(settings.color[1], settings.color[2], settings.color[3], 100)
            end
        end--]]

        RageUI.Visible(RMenu:Get('IDP_objects_buyer', 'main_menu'), true)
        IDP.openIllegalTable()
    --else
        --Extasy.ShowNotification("~r~Hum, Cette table de craft semble faire quelque chose... Revien vers :\n~s~(16h00-16h30 / 23h00-23h30)")
    --end
end

IDP.inHourFunction = function()
    IDP.spawned = false
    local aCount   = 0
    local aRandX   = math.random(-5, 6)
    local aRandY   = math.random(-5, 6)
    local aRandZ   = math.random(3, 10)

    IDP.inHour = true
    Citizen.CreateThread(function()
        while IDP.inHour do
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            local dst = GetDistanceBetweenCoords(pCoords, cfg_illegal_daily_pieces.coords, true)

            while dst > 150 do
                Wait(100)
                pPed = GetPlayerPed(-1)
                pCoords = GetEntityCoords(pPed)
                dst = GetDistanceBetweenCoords(pCoords, cfg_illegal_daily_pieces.coords, true)
            end

            while IDP.inHour do
                Wait(1)
                local cDST = GetDistanceBetweenCoords(pCoords, cfg_illegal_daily_pieces.coords, 0)

                pPed = GetPlayerPed(-1)
                pCoords = GetEntityCoords(pPed)
                cDST = GetDistanceBetweenCoords(pCoords, cfg_illegal_daily_pieces.coords, true)

                while cDST < cfg_illegal_daily_pieces.radius do
                    Wait(500)

                    if not IDP.spawned then
                        if aCount == 0 then
                            RequestModel(GetHashKey("prop_box_ammo06a"))
                            while not HasModelLoaded(GetHashKey("prop_box_ammo06a")) do Wait(10) end
                            local cX, cY, cZ = cfg_illegal_daily_pieces.coords.x + math.random(-4.0, 4.0), cfg_illegal_daily_pieces.coords.y + math.random(-4.0, 4.0), cfg_illegal_daily_pieces.coords.z
                            IDP.randomZone   = vector3(cX, cY, cZ)
                            o = CreateObject(GetHashKey("prop_box_ammo06a"), IDP.randomZone, 0, 0, 0)
                            IDP.objNetID     = o
                            PlaceObjectOnGroundProperly(o)
                            FreezeEntityPosition(o, 1)
                            IDP.spawned      = true
                            aCount = aCount + 1
                        end
                    end

                    while IDP.spawned do
                        pPed = GetPlayerPed(-1)
                        pCoords = GetEntityCoords(pPed)
                        aCoords = GetEntityCoords(IDP.objNetID)
                        aDST = GetDistanceBetweenCoords(pCoords, aCoords, true)

                        if aDST < 3.0 then
                            if IsControlPressed(0, 38) then
                                if not IDP.clicked then
                                    IDP.clicked = true
                                    Extasy.StartInteractAnimation(1000)
                                    Citizen.Wait(1000)
                                    local idpNumber  = math.random(1, 3)

                                    for i = 1, 10, 1 do
                                        idpNumber    = math.random(1, 3)
                                    end
                                    SetAudioFlag("LoadMPData", true)
                                    local RandomHunt = math.random(1,5)
                                    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    TriggerServerEvent("illegal_daily_pieces:processPickup", token, idpNumber)

                                    local entity = IDP.objNetID
                                    SetEntityAsMissionEntity(entity, true, true)
                                    local timeout = 2000
                                    while timeout > 0 and not IsEntityAMissionEntity(entity) do
                                        Wait(100)
                                        timeout = timeout - 100
                                    end
                                
                                    Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
                                
                                    if (DoesEntityExist(entity)) then 
                                        DeleteEntity(entity)
                                    end 

                                    IDP.objNetID   = nil
                                    --IDP.inHour     = false
                                    IDP.clicked    = false
                                    IDP.randomZone = nil
                                    Wait(100)
                                    CheckSuccesIDP() --Oublie pas sa mec
                                    IDP.inHourFunction()
                                end
                            end
                        end
                        Wait(1)
                    end
                end
            end
        end
    end)

    Citizen.CreateThread(function()
        while IDP.inHour do
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            local dst = GetDistanceBetweenCoords(pCoords, cfg_illegal_daily_pieces.coords, true)

            DrawMarker(28, cfg_illegal_daily_pieces.coords.x, cfg_illegal_daily_pieces.coords.y, cfg_illegal_daily_pieces.coords.z, nil, nil, nil, nil, nil, nil, cfg_illegal_daily_pieces.radius, cfg_illegal_daily_pieces.radius, cfg_illegal_daily_pieces.radius, 0, 95, 0, 5, false, false) -- Test a 255 initialement à 25

            if dst < cfg_illegal_daily_pieces.radius then
                if IDP.randomZone ~= nil then
                    AddTextEntry("SHOW_IDP_TAKE_ITEM", "Appuyez sur [E] pour ramasser des pièces d'armes")
                    Extasy.ShowFloatingHelp("SHOW_IDP_TAKE_ITEM", vector3(IDP.randomZone.x, IDP.randomZone.y, IDP.randomZone.z + -0.50))
                end
            end
            Wait(1)
        end
    end)
end

RegisterNetEvent("illegal_daily_pieces:startClientFishing")
AddEventHandler("illegal_daily_pieces:startClientFishing", function()
    IDP.inHour = true
    IDP.inHourFunction()
    PlaySoundFrontend(-1, 'Event_Start_Text', 'GTAO_FM_Events_Soundset', 0)
end)

RegisterNetEvent("illegal_daily_pieces:stopAllThing")
AddEventHandler("illegal_daily_pieces:stopAllThing", function()
    IDP.inHour = false
    if DoesBlipExist(IDP.blip) then
        RemoveBlip(IDP.blip)
    end
end)

Piece_arme = 0

Citizen.CreateThread(function()
    Piece_arme = GetResourceKvpInt("PiecesArme")
    if Piece_arme == nil then
        Piece_arme = 0
    end
end)

local succesPiecesArmes = {
    [1] = {
        texte = "Première pièce rammasser!"
    },
    [10] = {
        texte = "Néophyte de l'illégal !"
    },
    [40] = {
        texte = "40 Pièces ramasser"
    },
    [60] = {
        texte = "60 Pièces ramasser"
    },
    [80] = {
        texte = "80 Pièces ramasser"
    },
    [100] = {
        texte = "Rammasseur aguerri!"
    },
    [120] = {
        texte = "120 Pièces ramasser"
    },
    [140] = {
        texte = "140 Pièces ramasser"
    },
    [160] = {
        texte = "160 Pièces ramasser"
    },
    [180] = {
        texte = "180 Pièces ramasser"
    },
    [200] = {
        texte = "Pro dans l'événement des pièces d'armes",
        suplementaire = "Tu as maintenant accès à ~g~+2 Pièces d'armes~~ par ramassages",
    },
}

Citizen.CreateThread(function()
    local Last10 = 100
    for i = 100, 1000 do
        if i == Last10 + 10 then
            succesPiecesArmes[Last10] = {texte = Last10.." Pièces ramasser"}
            Last10 = Last10 + 10
        end
    end
end)

CheckSuccesIDP = function()
    Piece_arme = Piece_arme + 1
    if succesPiecesArmes[Piece_arme] ~= nil then
        --PlayUrl("SUCCES", "https://www.youtube.com/watch?v=VulNgFlC1u4", 0.4, false)
        TriggerEvent("Ambiance:PlayUrl", token, "SUCCES", "https://www.youtube.com/watch?v=VulNgFlC1u4", 0.4, false )
        Wait(1000)
        SendNUIMessage({ 
            succes = true
        })
        Extasy.ShowNotification("~y~[SUCCES]\n\n~w~"..succesPiecesArmes[Piece_arme].texte)
        if succesPiecesArmes[Piece_arme].suplementaire ~= nil then
            Extasy.ShowNotification("~y~[SUCCES]\n\n~w~"..succesPiecesArmes[Piece_arme].suplementaire)
        end
    end
    SetResourceKvpInt("PiecesArme", Piece_arme)
end