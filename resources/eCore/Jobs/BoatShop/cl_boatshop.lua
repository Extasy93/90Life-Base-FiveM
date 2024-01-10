boatShop_sellDetails = {}
local boatshop_in_menu = false

RMenu.Add('boatshop', 'main_menu', RageUI.CreateMenu("Concessionnaire bateau", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('boatshop', 'main_menu_vehicle_list', RageUI.CreateSubMenu(RMenu:Get('boatshop', 'main_menu'), "Concessionnaire bateau", "Choisissez la catégorie du véhicule à vendre"))
RMenu.Add('boatshop', 'main_menu_vehicle_give', RageUI.CreateSubMenu(RMenu:Get('boatshop', 'main_menu_vehicle_list'), "Concessionnaire bateau", "À qui souhaitez-vous vendre ce bateau ?"))
RMenu:Get('boatshop', "main_menu").Closed = function()
    boatshop_in_menu = false
end

OpenBoatShopMenu = function()
    if boatshop_in_menu then
        boatshop_in_menu = false
        return
    else
        boatshop_in_menu = true
        RageUI.Visible(RMenu:Get('boatshop', 'main_menu'), true)
        Citizen.CreateThread(function()
            while boatshop_in_menu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('boatshop', 'main_menu'), true, false, true, function()

                    if playerInService then
                        RageUI.Button("État de service", nil, {RightLabel = "✅"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                playerInService = not playerInService

                                TriggerServerEvent("Jobs:removeService", token, playerJob)
                                startServiceLoop()
                            end
                        end)
                    else
                        RageUI.Button("État de service", nil, {RightLabel = "❌"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                playerInService = not playerInService

                                TriggerServerEvent("Jobs:addService", token, playerJob)
                                startServiceLoop()
                            end
                        end)
                    end

                    RageUI.Button("Annonce aux citoyens", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local i = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 200)
                            if not Extasy.isMessageGood(i) then return end

                            TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Concessionnaire bateau', 'Publicité', tostring(i), 'CONCESSIONNAIREBATEAU')
                        end
                    end)

                    RageUI.Button("Vendre un bateau", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('boatshop', 'main_menu_vehicle_list'))

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('boatshop', 'main_menu_vehicle_list'), true, true, true, function()

                    for i,l in pairs(cfg_boatshop.vehicles) do
                        for k,la in pairs(l.vehicles) do
                            RageUI.Button(la.name, nil, {RightLabel = Extasy.Math.GroupDigits(la.price).."$"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    boatShop_sellDetails.name  = la.name
                                    boatShop_sellDetails.hash  = la.hash
                                    boatShop_sellDetails.price = la.price
                                end
                            end, RMenu:Get('boatshop', 'main_menu_vehicle_give')) 
                        end
                    end
                    
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('boatshop', 'main_menu_vehicle_give'), true, true, true, function()
                
                    for _, player in ipairs(GetActivePlayers()) do
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                        local coords = GetEntityCoords(GetPlayerPed(player))
                        local name = replaceBoatText(player)
                        local sta = Extasy.IsMyId(player)
        
                        if dst < 3.0 then
                            -- if sta ~= "me" then
                                RageUI.Button("#".._.." "..name, nil, {}, true, function(Hovered, Active, Selected)
                                    if Active then
                                        DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                    end

                                    if Selected then
                                        RageUI.CloseAll()
                                        boatshop_in_menu = false
                                        
                                        TriggerServerEvent("boatshop:setupBilling", token, "Achat du bateau:~b~ "..boatShop_sellDetails.name, boatShop_sellDetails.price, "Concessionnaire bateau", GetPlayerServerId(player), true, "boatshop:processBilling", boatShop_sellDetails.price, false, boatShop_sellDetails.hash, boatShop_sellDetails.name)
                                    end
                                end)  
                            -- end
                        end
                    end
                end, function()
                end)
            end
        end)
    end
end

replaceBoatText = function(py)
    n2 = ""
    for i = 1, string.len(GetPlayerName(py)), 1 do
        n2 = n2.."•"
    end

    return n2
end

local inchest_menu = false

RMenu.Add('boatshop', 'chest_menu', RageUI.CreateMenu("Coffre", "Que souhaitez-vous faire ?"))
RMenu.Add('boatshop', 'take_chest', RageUI.CreateSubMenu(RMenu:Get('boatshop', 'chest_menu'), "Prendre objet", "Que souhaitez-vous faire ?"))
RMenu.Add('boatshop', 'deposit_chest', RageUI.CreateSubMenu(RMenu:Get('boatshop', 'chest_menu'), "Déposer objet", "Que souhaitez-vous faire ?"))
RMenu:Get('boatshop', 'chest_menu').Closed = function()
    inchest_menu = false
end

openChestBoatshop = function()
    ESX.TriggerServerCallback('Boatshop:getPlayerInventory', function(inventory)
       chestInventory = inventory.items
    end)

    ESX.TriggerServerCallback('Boatshop:getSharedInventory', function(items)
        allItems = items
    end, "boatshop")

    if not inchest_menu then
        inchest_menu = true
        
    RageUI.Visible(RMenu:Get('boatshop', 'chest_menu'), true)

    Citizen.CreateThread(function()
        while inchest_menu do
            Wait(1)
                RageUI.IsVisible(RMenu:Get('boatshop', 'chest_menu'), true, true, true, function()

                    RageUI.ButtonWithStyle("Prendre objet", nil, {RightLabel = "→→→"},true, function()
                    end, RMenu:Get('boatshop', 'take_chest'))
                    RageUI.ButtonWithStyle("Déposer objet", nil, {RightLabel = "→→→"},true, function()
                    end, RMenu:Get('boatshop', 'deposit_chest'))

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('boatshop', 'take_chest'), true, true, true, function()

                    for i=1, #allItems, 1 do
                        if allItems[i].count ~= 0 then
                            RageUI.ButtonWithStyle("x"..allItems[i].count.." "..allItems[i].label, "Pour prendre cet objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
                                if (Selected) then   
                                    local montant = KeyboardInput('Veuillez choisir le montant que vous voulez retirer de cet objet', '', 2)
                                    montant = tonumber(montant)
                                    if not montant then
                                        RageUI.Popup({message = "Quantité invalide"})
                                    else
                                        TriggerServerEvent('Boatshop:takeStockItem', token, allItems[i].name, montant, "boatshop")
                                        RageUI.CloseAll()
                                        inchest_menu = false
                                    end
                                end
                            end)
                        end
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('boatshop', 'deposit_chest'), true, true, true, function()

                    for i=1, #chestInventory, 1 do
                        if chestInventory[i].count > 0 then
                            RageUI.ButtonWithStyle("x"..chestInventory[i].count.." "..chestInventory[i].label, "Pour déposer cet objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
                                if (Selected) then   
                                    local montant = KeyboardInput('Veuillez choisir le montant que vous voulez déposer de cet objet', '', 2)
                                    montant = tonumber(montant)
                                    if not montant then
                                        RageUI.Popup({message = "Quantité invalide"})
                                    else
                                        TriggerServerEvent('Boatshop:DepositStockItem', token, chestInventory[i].name, montant, "boatshop")
                                        RageUI.CloseAll()
                                        inchest_menu = false
                                    end
                                end
                            end)
                        end
                    end

                end, function()
                end)   
            end
        end)
    end
end

BoatShopPreviewMenu = function(oldCoords)
    RMenu.Add('boatshop', 'main_menu', RageUI.CreateMenu("Catalogue bateaux", "Liste des bateaux disponibles", 1, 100))
    RMenu:Get('boatshop', "main_menu").Closed = function()
        boatshop_in_menu = false

        if boatshop_inPreview then
            SetEntityCoords(PlayerPedId(), oldCoords)
            boatshop_inPreview = false
        end

        SetEntityVisible(PlayerPedId(), true, 0)
        FreezeEntityPosition(PlayerPedId(), false)

        for k,v in pairs(boatshop_previewVehicle) do
            DeleteEntity(v)
        end

        RMenu:Delete('boatshop', 'main_menu')
    end

    if boatshop_in_menu then
        boatshop_in_menu = false
        return
    else
        RageUI.CloseAll()

        boatshop_in_menu = true
        RageUI.Visible(RMenu:Get('boatshop', 'main_menu'), true)
    end

    boatshop_index          = 1
    boatshop_previewList    = {}
    boatshop_inPreview      = false
    boatshop_previewVehicle = {}
    boatshop_oldCoords      = GetEntityCoords(PlayerPedId())

    Citizen.CreateThread(function()
        while boatshop_in_menu do
            Wait(1)

            RageUI.IsVisible(RMenu:Get('boatshop', 'main_menu'), true, true, true, function()

                for k,v in pairs(cfg_boatshop.vehicles) do
                    for i,l in pairs(v.vehicles) do
                        RageUI.Button(l.name, nil, {RightLabel = Extasy.Math.GroupDigits(l.price).."$"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if boatshop_previewList[i] ~= i then
                                    boatshop_previewList[i-1] = nil
                                    boatshop_previewList[i+1] = nil
                                    boatshop_inPreview = false
                                    
                                    Wait(0)
            
                                    if not boatshop_inPreview then
                                        boatshop_startPreview = function(hash)
                                            boatshop_inPreview = true
                                            Citizen.CreateThread(function()
                                                SetEntityVisible(PlayerPedId(), false, 0)
                                                SetEntityCoords(PlayerPedId(), cfg_boatshop.prevPoint)
            
                                                for k,v in pairs(boatshop_previewVehicle) do
                                                    DeleteEntity(v)
                                                end
            
                                                ClearAreaOfVehicles(cfg_boatshop.prevPoint, 8.5, false, false, false, false, false)
                                                RequestModel(hash) while not HasModelLoaded(hash) do DisableAllControlActions(0) Citizen.Wait(0) end
            
                                                boatshop_tempVehicle = CreateVehicle(hash, cfg_boatshop.prevPoint, cfg_boatshop.prevPoint_heading or 0.0, false, false)
                                                table.insert(boatshop_previewVehicle, boatshop_tempVehicle)
            
                                                TaskWarpPedIntoVehicle(PlayerPedId(), boatshop_tempVehicle, -1)
                                                FreezeEntityPosition(boatshop_tempVehicle, true)
                                                SetVehicleDoorsLocked(boatshop_tempVehicle, 4)
            
                                                cfg_boatshop.prevPoint_heading = 0.0
                                                while boatshop_inPreview do
            
                                                    cfg_boatshop.prevPoint_heading = cfg_boatshop.prevPoint_heading + 0.05
                                                    SetEntityHeading(boatshop_tempVehicle, cfg_boatshop.prevPoint_heading)
    
                                                    Wait(25)
                                                end
            
                                                SetEntityVisible(PlayerPedId(), true, 0)
                                                SetEntityCoords(PlayerPedId(), boatshop_oldCoords)
            
                                                for k,v in pairs(boatshop_previewVehicle) do
                                                    DeleteEntity(v)
                                                end
            
                                                boatshop_tempVehicle = nil
                                            end)
                                        end
            
                                        boatshop_startPreview(l.hash)
            
                                        boatshop_startPreview = nil
                                    end
            
                                    boatshop_previewList[i] = i
                                end
                            end
                        end)
                    end
                end

            end, function()
            end)
        end
    end)
end

InitBoatshop = function()
    registerSocietyFarmZone({ 
        pos      = vector3(3028.66, 4898.29, 8.07),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(3030.69, 4895.97, 8.07),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(3025.75, 4898.68, 8.07),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Concessionaire Bateaux",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(3029.01, 4896.08, 8.07)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Concessionaire Bateaux")
    EndTextCommandSetBlipName(aBlip)

    local b = {
        --{pos = vector3(2151.32, 4817.81, 10.85), sprite = 557, color = 17, scale = 0.60, title = "Concessionaire Bateaux | Garage"},
        --{pos = vector3(2141.66, 4827.56, 10.55), sprite = 557, color = 59, scale = 0.60, title = "Concessionaire Bateaux | Rangement véhicule"},
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

    registerNewMarker({
        npcType          = 'drawmarker',
        interactMessage  = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu concessionnaire",
        pos              = cfg_boatshop.pos,
        action           = function()
            if playerJob == 'boatshop' then
                OpenBoatShopMenu()
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas un employé du Conssessionaire Bateau")
            end
        end,
    
        spawned          = false,
        entity           = nil,
        load_dst         = 4,
    
        dst 			 = 1.5,
    
        blip_enable      = false,
    
        marker           = true,
        size             = 0.6,
    
        drawmarkerType   = 6,
        drawmarkerRotation = 270.0,
        
        drawmarkerColorR = 100,
        drawmarkerColorG = 0,
        drawmarkerColorB = 200,
    })
end

RegisterNetEvent("boatshop:processBilling")
AddEventHandler("boatshop:processBilling", function(sender, buyer, hash, name)
    --boatShop_sellDetails.buyer = buyer

    local a = GetHashKey(hash)
    RequestModel(a)
    while not HasModelLoaded(a) do
        RequestModel(a)
        Wait(0)
    end
    local c = CreateVehicle(a, cfg_boatshop.spawnPoint, cfg_boatshop.heading, true, false)
    vehicle_to_know = c
    boatShop_sellDetails.properties = Extasy.GetVehicleProperties(c)	
    boatShop_sellDetails.model = a
    boatShop_sellDetails.plate = GeneratePlate()
    SetVehicleNumberPlateText(vehicle_to_know, boatShop_sellDetails.plate)

    TriggerServerEvent("boatshop:processVehicle", token, buyer, boatShop_sellDetails.plate, boatShop_sellDetails.properties, name)
	Extasy.ShowNotification('Vous venez d\'acheté le véhicule: ~g~'..name..'')

    Wait(10)
    TaskWarpPedIntoVehicle(PlayerPedId(buyer), c, -1)
    Wait(10)
    --SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId()), Color1, Color2, Color3)
    --SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId()), Color1, Color2, Color3)

    SetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(buyer), false), 1000.0)
end)