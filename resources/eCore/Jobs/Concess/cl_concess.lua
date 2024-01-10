ESX = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

in_concess_menu = false
local in_prev = false
local last_vvv = nil
local need_vehi = nil
local veh_heading = 0
local Color1 = nil
local Color2 = nil
local Color3 = nil
local isBuyedByMyself = false

RMenu.Add('Exatsy_concess', 'main_menu', RageUI.CreateMenu("Concessionnaire", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('Exatsy_concess', 'main_menu_vehicle_list', RageUI.CreateSubMenu(RMenu:Get('Exatsy_concess', 'main_menu'), "Concessionnaire", "Que souhaitez-vous faire ?"))

RMenu.Add('Exatsy_concess_prev', 'main_menu_prev', RageUI.CreateMenu("Concessionnaire", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('Exatsy_concess_prev', 'main_menu_vehicle_list_prev', RageUI.CreateSubMenu(RMenu:Get('Exatsy_concess_prev', 'main_menu_prev'), "Concessionnaire", "Que souhaitez-vous faire ?"))
RMenu:Get('Exatsy_concess_prev', 'main_menu_prev').Closed = function()
    print(last_vvv)
    print(need_vehi)
    if last_vvv then
        DeleteVehicle(last_vvv)
    end
    if need_vehi then
        DeleteVehicle(need_vehi)
    end
    SetEntityCoords(PlayerPedId(), 2233.98, 5342.88, 12.05)
    SetEntityVisible(PlayerPedId(), true, 0)
    in_prev = false
    in_concess_menu = false
end

RMenu:Get('Exatsy_concess_prev', 'main_menu_vehicle_list_prev').Closed = function()
    if last_vvv then
        DeleteVehicle(last_vvv)
    end
    if need_vehi then
        DeleteVehicle(need_vehi)
    end
    SetEntityCoords(PlayerPedId(), -785.48, -229.62, 37.08)
    SetEntityVisible(PlayerPedId(), true, 0)
    in_prev = false
end

RMenu.Add('Exatsy_concess', 'main_menu_vehicle_give', RageUI.CreateSubMenu(RMenu:Get('Exatsy_concess', 'main_menu'), "Concessionnaire", "Que souhaitez-vous faire ?"))
RMenu:Get('Exatsy_concess', 'main_menu_vehicle_give').Closed = function()
    in_prev = false
    DeleteVehicle(need_vehi)
end

RMenu:Get('Exatsy_concess', 'main_menu').Closed = function()
    in_prev = false
    in_concess_menu = false
    DeleteVehicle(need_vehi)
end

RMenu:Get('Exatsy_concess', 'main_menu_vehicle_list').Closed = function()
    DeleteVehicle(last_vvv)
    DeleteVehicle(need_vehi)
    SetEntityCoords(GetPlayerPed(-1), concess_data.curr_pos)
    SetEntityVisible(GetPlayerPed(-1), true, 0)
    in_prev = false
end

Citizen.CreateThread(function()
    while cfg_concess == nil do Wait(1) end
    for k,v in pairs(cfg_concess.vehicles) do
        RMenu.Add('Exatsy_concess', v.value, RageUI.CreateSubMenu(RMenu:Get('Exatsy_concess', 'main_menu_vehicle_list'), "Concessionnaire", "Que souhaitez-vous faire ?"))
    end

    for k,v in pairs(cfg_concess.vehicles) do
        RMenu.Add('Exatsy_concess_prev', v.value, RageUI.CreateSubMenu(RMenu:Get('Exatsy_concess_prev', 'main_menu_prev'), "Concessionnaire", "Que souhaitez-vous faire ?"))
        RMenu:Get('Exatsy_concess_prev', v.value).EnableMouse = true
    end
end)

CONCESS = false
concess_data = setmetatable({}, concess_data)
concess_data.color = {0, 0, 0}
concess_data.prev = false
concess_data.cursor = false
local vehicles_data = {}
local prev = {}
local curr_kg = nil
local hData = {}
local playerID = nil

local plate = nil

local index = {
    colored = { [1] = 1, [2] = 1 }
}

openConcess_m = function()
    in_concess_menu = true
    Citizen.CreateThread(function()
        while in_concess_menu do
            Wait(1)
            RageUI.IsVisible(RMenu:Get('Exatsy_concess', 'main_menu'), true, true, true, function()

                RageUI.Button("Commencer son service", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                    if s then
                        if not playerInService then
                            playerInService = true
                            startServiceLoop()
                        else
                            Extasy.ShowNotification("~r~Vous êtes déjà en service !")
                        end
                    end
                end)

                RageUI.Button("Terminer son service", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                    if s then
                        if not playerInService then
                            Extasy.ShowNotification("~r~Vous n'êtes pas en service !")
                        else
                            playerInService = false
                            playerInServiceLoop = false
                        end
                    end
                end)

                RageUI.Button("Annonce aux citoyens", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                    if s then
                        local i = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 200)
                        i = tostring(i)
                        if i ~= nil and string.len(i) > 5 then
                           -- Trigger Annonce
                        end
                    end
                end)

                RageUI.Button("Vendre un véhicule", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        RageUI.Visible(RMenu:Get('Exatsy_concess', 'main_menu'), false)
                        Wait(15)
                        RageUI.Visible(RMenu:Get('Exatsy_concess', 'main_menu_vehicle_list'), true)
                    end
                end)
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('Exatsy_concess', 'main_menu_vehicle_list'), true, true, true, function()

                RageUI.Checkbox("Prévisualisation des véhicules", nil, concess_data.prev, {}, function(Hovered, Active, Selected, Checked)
                    concess_data.prev = Checked
                end)

                RageUI.Separator("")

                for k,v in pairs(cfg_concess.vehicles) do
                    RageUI.Button(v.cat_name, nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                    end, RMenu:Get('Exatsy_concess', v.value))
                end

            end, function()
            end)

            for k,v in pairs(cfg_concess.vehicles) do
                RageUI.IsVisible(RMenu:Get('Exatsy_concess', v.value), true, true, true, function()

                    for k,la in pairs(v.vehicles) do
                        RageUI.Button(la.name, nil, {RightLabel = Extasy.Math.GroupDigits(la.price*extasy_core_cfg["cardealer_priceMult"]).."$"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                concess_data.name  = la.name
                                concess_data.hash  = la.hash
                                concess_data.price = la.price*extasy_core_cfg["cardealer_priceMult"]
                                curr_kg = la.capacity
                                if concess_data.prev then
                                    SpawnVehicleLocally(la.hash, cfg_concess.prevPoint, cfg_concess.prevPoint_heading)
                                else
                                    RageUI.Visible(RMenu:Get('Exatsy_concess', v.value), false)
                                    Wait(15)
                                    RageUI.Visible(RMenu:Get('Exatsy_concess', 'main_menu_vehicle_give'), true)                                    
                                end
                            end
                        end) 
                    end

                end, function()
                end)
            end

            RageUI.IsVisible(RMenu:Get('Exatsy_concess', 'main_menu_vehicle_give'), true, true, true, function()

                for _, player in ipairs(GetActivePlayers()) do
                    local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                    local coords = GetEntityCoords(GetPlayerPed(player))
                    local name = replaceText(player)
                    local sta = Extasy.IsMyId(player)

                    if dst < 3.0 then
                        if sta ~= "me" then
                            RageUI.Button("#".._.." "..name, nil, {}, true, function(Hovered, Active, Selected)
                                if (Active) then
                                    DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, concess_data.color[1], concess_data.color[2], concess_data.color[3], 100, true, true)
                                end
								
                                if (Selected) then
                                    Wait(500)
										ESX.TriggerServerCallback('Extasy_vehicleshop:buyVehicle', function(hasEnoughMoney)
											if hasEnoughMoney then
												receveVehicle()
												FreezeEntityPosition(playerPed, false)
												SetEntityVisible(playerPed, true)
											else
												Extasy.ShowNotification('vous n\'avez pas assez d\'argent')
											end
										end, concess_data.price*extasy_core_cfg["cardealer_priceMult"])
                                    dataReceved = false
                                    while not dataReceved do
                                        RageUI.CloseAll()
                                        Citizen.Wait(100)
                                    end
                                end
                            end)
                        end
                    end
                end

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('Exatsy_concess_prev', 'main_menu_prev'), true, true, true, function()

                for k,v in pairs(cfg_concess.vehicles) do
                    RageUI.Button(v.cat_name, nil, {RightLabel = ">>>"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RageUI.Visible(RMenu:Get('Exatsy_concess_prev', 'main_menu_prev'), false)
                            Wait(15)
                            RageUI.Visible(RMenu:Get('Exatsy_concess_prev', v.value), true)                         
                        end
                    end)
                end

            end, function()
            end)

            for k,v in pairs(cfg_concess.vehicles) do
                RageUI.IsVisible(RMenu:Get('Exatsy_concess_prev', v.value), true, true, true, function()

                    if in_prev then
                        RageUI.Checkbox("Preview couleur", nil, concess_data.cursor, {}, function(h, a, s, cursor)
                            concess_data.cursor = cursor
                            RMenu:Get('Exatsy_concess_prev', v.value).EnableMouse = cursor
                        end)
                        RageUI.Separator("")
                    end

                    for k,la in pairs(v.vehicles) do
                        RageUI.Button(la.name, nil, {RightLabel = Extasy.Math.GroupDigits(la.price*extasy_core_cfg["cardealer_priceMult"]).."$"}, true, function(Hovered, Active, Selected) 
                            if Active then
                                if hData[k] ~= k then
                                    hData[k-1] = nil
                                    hData[k+1] = nil
                                    SpawnVehicleLocally(la.hash, cfg_concess.prevPoint, cfg_concess.prevPoint_heading)
                                    hData[k] = k
                                end
                            end
                            if Selected then
                                if extasy_core_cfg["cardealer_automatic_buying"] then
                                    concess_data.name  = la.name
                                    concess_data.hash  = la.hash
                                    concess_data.price = la.price*extasy_core_cfg["cardealer_priceMult"]
                                    concess_data.capac = la.capacity
                                    curr_kg = la.capacity
                                    --local cCount = Extasy.getCountOfJob("concess")

                                    --if cCount < extasy_core_cfg["cardealer_needed_for_automatic_buying"] then
                                        RageUI.CloseAll()
                                        in_prev = false
                                        in_concess_menu = false
                                        DeleteVehicle(last_vvv)
                                        DeleteVehicle(need_vehi)
                                        SetEntityCoords(GetPlayerPed(-1), 2245.85, 5329.34, 11.84)
                                        SetEntityVisible(GetPlayerPed(-1), true, 0)
                                        concess_data.spawnPoint = vector3(2243.99, 5332.54, 11.84)
                                        concess_data.heading    = 133.5
                                        isBuyedByMyself         = true

										Wait(500)

										ESX.TriggerServerCallback('Extasy_vehicleshop:buyVehicle', function(hasEnoughMoney)
											if hasEnoughMoney then
												receveVehicle()
												FreezeEntityPosition(playerPed, false)
												SetEntityVisible(playerPed, true)
											else
												Extasy.ShowNotification('vous n\'avez pas assez d\'argent')
											end
										end, concess_data.price*extasy_core_cfg["cardealer_priceMult"])
                                    --else
                                        --Extasy.ShowNotification("~g~Veuillez passer par un concessionnaire ("..cCount..")")
                                    --end
                                end
                            end
                        end) 
                    end
    
                    if concess_data.cursor then
                        RageUI.ColourPanelConcess("Choisir la couleur", cfg_concess.colorPanel.car, index.colored[1], index.colored[2] + 1, function(Hovered, Active, MinimumIndex, CurrentIndex)
                            if Active then
                                index.colored[2] = CurrentIndex - 1
                                index.colored[1] = MinimumIndex
                                for k,v in pairs(cfg_concess.colorPanel.car) do
                                    if k == CurrentIndex then
										Color1 = v[1]
										Color2 = v[2]
										Color3 = v[3]
                                        SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId()), v[1], v[2], v[3])
                                        SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId()), v[1], v[2], v[3])
                                    end
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

receveVehicle = function()
    dataReceved = true
    local a = GetHashKey(concess_data.hash)
    RequestModel(a)
    while not HasModelLoaded(a) do
        RequestModel(a)
        Wait(0)
    end
    local c = CreateVehicle(a, concess_data.spawnPoint, concess_data.heading, true, false)
    vehicle_to_know = c
    local newPlate     = GeneratePlate()
    local vehicleProps = Extasy.GetVehicleProperties(c)	
    vehicleProps.model = a
    vehicleProps.plate = newPlate
    vehicle_to_know_plate = newPlate
    SetVehicleNumberPlateText(vehicle_to_know, newPlate)

	TriggerServerEvent('Extasy_vehicleshop:setVehicleOwned93LA6T', token, vehicleProps, concess_data.name)
	Extasy.ShowNotification('Vous venez d\'acheté le véhicule: ~g~'..concess_data.name..'')
	TriggerServerEvent('Extasy_vehicleshop:debit', token, concess_data.price*extasy_core_cfg["cardealer_priceMult"])

    if isBuyedByMyself then
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), c, -1)
		Wait(10)
		SetVehicleCustomPrimaryColour(GetVehiclePedIsUsing(PlayerPedId()), Color1, Color2, Color3)
		SetVehicleCustomSecondaryColour(GetVehiclePedIsUsing(PlayerPedId()), Color1, Color2, Color3)
    end
end

loadConcess = function()
    CONCESS = true
    vehicles_data = cfg_concess.vehicles
end

local vheading = 0
Citizen.CreateThread(function()
    while true do
        vheading = vheading + 0.1
        SetEntityHeading(need_vehi, vheading)

        if in_prev then
            Wait(1)
        else
            Wait(250)
        end
    end
end)

local lastv = {}
local vehicle_to_know = nil
local vehicle_to_know_plate = nil

SpawnVehicleLocally = function(modelName, coords, heading, cb)
    local model = GetHashKey(modelName)
    local ped       = GetPlayerPed(-1)
    Citizen.CreateThread(function()
        if model ~= last_vvv then
            SetEntityVisible(ped, false, 0)
            SetEntityCoords(ped, coords)
            ClearAreaOfVehicles(coords, 8.5, false, false, false, false, false) 
            if not HasModelLoaded(model) and IsModelInCdimage(model) then
                RequestModel(model)
                while not HasModelLoaded(model) do
                     Wait(0) 
                     RequestModel(model)
                end
            end
            local timeout = 0
            last_vvv = model
            DeleteVehicle(vehicle)
            vehicle = CreateVehicle(model, coords, heading, false, false)
            need_vehi = vehicle
            in_prev = true
            SetEntityAsMissionEntity(vehicle, true, false)
            SetVehicleHasBeenOwnedByPlayer(vehicle, true)
            SetVehicleNeedsToBeHotwired(vehicle, false)
            SetVehRadioStation(vehicle, 'OFF')
            SetModelAsNoLongerNeeded(last_vvv)
            TaskWarpPedIntoVehicle(ped, vehicle, -1)
            FreezeEntityPosition(vehicle, true)
            RequestCollisionAtCoord(coords.x, coords.y, coords.z)
            Wait(10)

            while not HasCollisionLoadedAroundEntity(vehicle) do
                Citizen.Wait(0)
            end
        end
    end)
end

openCatalogue = function()
    if not in_concess_menu then
        in_concess_menu = true
        openConcess_m()
        RageUI.Visible(RMenu:Get('Exatsy_concess_prev', 'main_menu_prev'), true)
    else
        in_concess_menu = false
        RageUI.CloseAll()
    end
end