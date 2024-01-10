BIKESHOP = {}
bikeShop_sellDetails = {}
local bikeshop_in_menu = false

RMenu.Add('bikeshop', 'main_menu', RageUI.CreateMenu("Concessionnaire Moto", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('bikeshop', 'main_menu_vehicle_list', RageUI.CreateSubMenu(RMenu:Get('bikeshop', 'main_menu'), "Concessionnaire Moto", "Choisissez la catégorie du véhicule à vendre"))
RMenu.Add('bikeshop', 'main_menu_vehicle_give', RageUI.CreateSubMenu(RMenu:Get('bikeshop', 'main_menu_vehicle_list'), "Concessionnaire Moto", "À qui souhaitez-vous vendre cette Moto ?"))
RMenu:Get('bikeshop', "main_menu").Closed = function()
    bikeshop_in_menu = false
end

OpenBikeShopMenu = function()
    if bikeshop_in_menu then
        bikeshop_in_menu = false
        return
    else
        bikeshop_in_menu = true
        RageUI.Visible(RMenu:Get('bikeshop', 'main_menu'), true)
        Citizen.CreateThread(function()
            while bikeshop_in_menu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('bikeshop', 'main_menu'), true, false, true, function()

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

                            TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Concessionnaire Moto', 'Publicité', tostring(i), 'CONCESSIONNAIREMOTO')
                        end
                    end)

                    RageUI.Button("Vendre une Moto", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('bikeshop', 'main_menu_vehicle_list'))

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('bikeshop', 'main_menu_vehicle_list'), true, true, true, function()

                    for i,l in pairs(cfg_bikeshop.vehicles) do
                        for k,la in pairs(l.vehicles) do
                            RageUI.Button(la.name, nil, {RightLabel = Extasy.Math.GroupDigits(la.price).."$"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    bikeShop_sellDetails.name  = la.name
                                    bikeShop_sellDetails.hash  = la.hash
                                    bikeShop_sellDetails.price = la.price
                                end
                            end, RMenu:Get('bikeshop', 'main_menu_vehicle_give')) 
                        end
                    end
                    
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('bikeshop', 'main_menu_vehicle_give'), true, true, true, function()
                
                    for _, player in ipairs(GetActivePlayers()) do
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                        local coords = GetEntityCoords(GetPlayerPed(player))
                        local name = replaceBikeText(player)
                        local sta = Extasy.IsMyId(player)
        
                        if dst < 3.0 then
                            -- if sta ~= "me" then
                                RageUI.Button("#".._.." "..name, nil, {}, true, function(Hovered, Active, Selected)
                                    if Active then
                                        DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                    end

                                    if Selected then
                                        RageUI.CloseAll()
                                        bikeshop_in_menu = false
                                        
                                        TriggerServerEvent("bikeshop:setupBilling", token, "Achat de la moto:~b~ "..bikeShop_sellDetails.name, bikeShop_sellDetails.price, "Concessionnaire Moto", GetPlayerServerId(player), true, "bikeshop:processBilling", bikeShop_sellDetails.price, false, bikeShop_sellDetails.hash, bikeShop_sellDetails.name)
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

replaceBikeText = function(py)
    n2 = ""
    for i = 1, string.len(GetPlayerName(py)), 1 do
        n2 = n2.."•"
    end

    return n2
end

local inchest_menu = false

RMenu.Add('bikeshop', 'chest_menu', RageUI.CreateMenu("Coffre", "Que souhaitez-vous faire ?"))
RMenu.Add('bikeshop', 'take_chest', RageUI.CreateSubMenu(RMenu:Get('bikeshop', 'chest_menu'), "Prendre objet", "Que souhaitez-vous faire ?"))
RMenu.Add('bikeshop', 'deposit_chest', RageUI.CreateSubMenu(RMenu:Get('bikeshop', 'chest_menu'), "Déposer objet", "Que souhaitez-vous faire ?"))
RMenu:Get('bikeshop', 'chest_menu').Closed = function()
    inchest_menu = false
end

openChestBikeshop = function()
    ESX.TriggerServerCallback('bikeshop:getPlayerInventory', function(inventory)
       chestInventory = inventory.items
    end)

    ESX.TriggerServerCallback('bikeshop:getSharedInventory', function(items)
        allItems = items
    end, "bikeshop")

    if not inchest_menu then
        inchest_menu = true
        
    RageUI.Visible(RMenu:Get('bikeshop', 'chest_menu'), true)

    Citizen.CreateThread(function()
        while inchest_menu do
            Wait(1)
                RageUI.IsVisible(RMenu:Get('bikeshop', 'chest_menu'), true, true, true, function()

                    RageUI.ButtonWithStyle("Prendre objet", nil, {RightLabel = "→→→"},true, function()
                    end, RMenu:Get('bikeshop', 'take_chest'))
                    RageUI.ButtonWithStyle("Déposer objet", nil, {RightLabel = "→→→"},true, function()
                    end, RMenu:Get('bikeshop', 'deposit_chest'))

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('bikeshop', 'take_chest'), true, true, true, function()

                    for i=1, #allItems, 1 do
                        if allItems[i].count ~= 0 then
                            RageUI.ButtonWithStyle("x"..allItems[i].count.." "..allItems[i].label, "Pour prendre cet objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
                                if (Selected) then   
                                    local montant = KeyboardInput('Veuillez choisir le montant que vous voulez retirer de cet objet', '', 2)
                                    montant = tonumber(montant)
                                    if not montant then
                                        RageUI.Popup({message = "Quantité invalide"})
                                    else
                                        TriggerServerEvent('bikeshop:takeStockItem', token, allItems[i].name, montant, "bikeshop")
                                        RageUI.CloseAll()
                                        inchest_menu = false
                                    end
                                end
                            end)
                        end
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('bikeshop', 'deposit_chest'), true, true, true, function()

                    for i=1, #chestInventory, 1 do
                        if chestInventory[i].count > 0 then
                            RageUI.ButtonWithStyle("x"..chestInventory[i].count.." "..chestInventory[i].label, "Pour déposer cet objet.", {RightLabel = "→→→"},true, function(Hovered, Active, Selected)
                                if (Selected) then   
                                    local montant = KeyboardInput('Veuillez choisir le montant que vous voulez déposer de cet objet', '', 2)
                                    montant = tonumber(montant)
                                    if not montant then
                                        RageUI.Popup({message = "Quantité invalide"})
                                    else
                                        TriggerServerEvent('bikeshop:DepositStockItem', token, chestInventory[i].name, montant, "bikeshop")
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

BikeShopPreviewMenu = function(oldCoords)
    RMenu.Add('bikeshop', 'main_menu', RageUI.CreateMenu("Catalogue Motos", "Liste des motos disponibles", 1, 100))
    RMenu:Get('bikeshop', "main_menu").Closed = function()
        bikeshop_in_menu = false

        if BIKESHOP.inPreview then
            SetEntityCoords(PlayerPedId(), oldCoords)
            BIKESHOP.inPreview = false
        end

        SetEntityVisible(PlayerPedId(), true, 0)
        FreezeEntityPosition(PlayerPedId(), false)

        for k,v in pairs(BIKESHOP.previewVehicle) do
            DeleteEntity(v)
        end

        RMenu:Delete('bikeshop', 'main_menu')
    end

    if bikeshop_in_menu then
        bikeshop_in_menu = false
        return
    else
        RageUI.CloseAll()

        bikeshop_in_menu = true
        RageUI.Visible(RMenu:Get('bikeshop', 'main_menu'), true)
    end

    BIKESHOP.index          = 1
    BIKESHOP.previewList    = {}
    BIKESHOP.inPreview      = false
    BIKESHOP.previewVehicle = {}
    BIKESHOP.oldCoords      = GetEntityCoords(PlayerPedId())

    Citizen.CreateThread(function()
        while bikeshop_in_menu do
            Wait(1)

            RageUI.IsVisible(RMenu:Get('bikeshop', 'main_menu'), true, true, true, function()

                for k,v in pairs(cfg_bikeshop.vehicles) do
                    for i,l in pairs(v.vehicles) do
                        RageUI.Button(l.name, nil, {RightLabel = Extasy.Math.GroupDigits(l.price).."$"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if BIKESHOP.previewList[i] ~= i then
                                    BIKESHOP.previewList[i-1] = nil
                                    BIKESHOP.previewList[i+1] = nil
                                    BIKESHOP.inPreview = false
                                    
                                    Wait(0)
            
                                    if not BIKESHOP.inPreview then
                                        BIKESHOP.startPreview = function(hash)
                                            BIKESHOP.inPreview = true
                                            Citizen.CreateThread(function()
                                                SetEntityVisible(PlayerPedId(), false, 0)
                                                SetEntityCoords(PlayerPedId(), cfg_bikeshop.prevPoint)
            
                                                for k,v in pairs(BIKESHOP.previewVehicle) do
                                                    DeleteEntity(v)
                                                end
            
                                                ClearAreaOfVehicles(cfg_bikeshop.prevPoint, 8.5, false, false, false, false, false)
                                                RequestModel(hash) while not HasModelLoaded(hash) do DisableAllControlActions(0) Citizen.Wait(0) end
            
                                                BIKESHOP.tempVehicle = CreateVehicle(hash, cfg_bikeshop.prevPoint, cfg_bikeshop.prevPoint_heading or 0.0, false, false)
                                                table.insert(BIKESHOP.previewVehicle, BIKESHOP.tempVehicle)
            
                                                TaskWarpPedIntoVehicle(PlayerPedId(), BIKESHOP.tempVehicle, -1)
                                                FreezeEntityPosition(BIKESHOP.tempVehicle, true)
                                                SetVehicleDoorsLocked(BIKESHOP.tempVehicle, 4)
            
                                                cfg_bikeshop.prevPoint_heading = 0.0
                                                while BIKESHOP.inPreview do
            
                                                    cfg_bikeshop.prevPoint_heading = cfg_bikeshop.prevPoint_heading + 0.05
                                                    SetEntityHeading(BIKESHOP.tempVehicle, cfg_bikeshop.prevPoint_heading)
    
                                                    Wait(25)
                                                end
            
                                                SetEntityVisible(PlayerPedId(), true, 0)
                                                SetEntityCoords(PlayerPedId(), BIKESHOP.oldCoords)
            
                                                for k,v in pairs(BIKESHOP.previewVehicle) do
                                                    DeleteEntity(v)
                                                end
            
                                                BIKESHOP.tempVehicle = nil
                                            end)
                                        end
            
                                        BIKESHOP.startPreview(l.hash)
            
                                        BIKESHOP.startPreview = nil
                                    end
            
                                    BIKESHOP.previewList[i] = i
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

BIKESHOP.initData = function()
    aBlip = AddBlipForCoord(2439.482, 7528.861, 11.27316)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Concessionnaire Moto")
    EndTextCommandSetBlipName(aBlip)

    registerNewMarker({
        npcType          = 'drawmarker',
        interactMessage  = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu concessionnaire",
        pos              = cfg_bikeshop.pos,
        action           = function()
            if playerJob == 'bikeshop' then
                OpenBikeShopMenu()
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas un employé du Conssessionaire Moto")
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
    
    registerNewMarker({
        npcType          = 'drawmarker',
        interactMessage  = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
        pos              = vector3(0, 0, 0),
        action           = function()
            if playerJob == 'bikeshop' then
                openBossMenu('bikeshop')
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas un employé du Conssessionaire Moto")
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
    
    registerNewMarker({
        npcType          = 'drawmarker',
        interactMessage  = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre d'entreprise",
        pos              = vector3(0, 0, 0),
        action           = function()
            if playerJob == 'bikeshop' then
                openChestBikeshop()
            else
                Extasy.ShowNotification("~r~Vous n'êtes pas un employé du Conssessionaire Moto")
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

RegisterNetEvent("bikeshop:processBilling")
AddEventHandler("bikeshop:processBilling", function(sender, buyer, hash, name)
    --bikeShop_sellDetails.buyer = buyer

    local a = GetHashKey(hash)
    RequestModel(a)
    while not HasModelLoaded(a) do
        RequestModel(a)
        Wait(0)
    end
    local c = CreateVehicle(a, cfg_bikeshop.spawnPoint, cfg_bikeshop.heading, true, false)
    vehicle_to_know = c
    bikeShop_sellDetails.properties = Extasy.GetVehicleProperties(c)	
    bikeShop_sellDetails.model = a
    bikeShop_sellDetails.plate = GeneratePlate()
    SetVehicleNumberPlateText(vehicle_to_know, bikeShop_sellDetails.plate)

    TriggerServerEvent("bikeshop:processVehicle", token, buyer, bikeShop_sellDetails.plate, bikeShop_sellDetails.properties, name)
	Extasy.ShowNotification('Vous venez d\'acheté le véhicule: ~g~'..name..'')

    Wait(10)
    TaskWarpPedIntoVehicle(PlayerPedId(buyer), c, -1)
    Wait(10)
    --SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId()), Color1, Color2, Color3)
    --SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId()), Color1, Color2, Color3)

    SetVehicleFuelLevel(GetVehiclePedIsIn(PlayerPedId(buyer), false), 1000.0)
end)

Citizen.CreateThread(function()
    for k,v in pairs(cfg_bikeshop.blip) do
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