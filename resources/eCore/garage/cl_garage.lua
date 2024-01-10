RegisterNetEvent("garage:sendGarageInfo") 
AddEventHandler("garage:sendGarageInfo", function(garage)
    playerGarage = garage
end)

RegisterNetEvent("garage:recevePlayerUUID")
AddEventHandler("garage:recevePlayerUUID", function(uuid)
    playerUUID = uuid
end)

local garage_openned = false
local garage_data  	 = {}
garage_data.spawnP   = {}
garage_data.count    = 0

RMenu.Add('Extasy_garage', 'main_menu', RageUI.CreateMenu("Garage", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('Extasy_garage', 'sub_garage', RageUI.CreateSubMenu(RMenu:Get('Extasy_garage', 'main_menu'), "Garage", "Que souhaitez-vous faire ?"))
RMenu.Add('Extasy_garage', 'sub_garage_options', RageUI.CreateSubMenu(RMenu:Get('Extasy_garage', 'main_menu'), "Garage", "Que souhaitez-vous faire ?"))
RMenu.Add('Extasy_garage', 'sub_give_vehicle', RageUI.CreateSubMenu(RMenu:Get('Extasy_garage', 'sub_garage'), "Garage", "À qui souhaitez-vous donner votre véhicule ?"))
RMenu.Add('Extasy_garage', 'sub_share_vehicle', RageUI.CreateSubMenu(RMenu:Get('Extasy_garage', 'sub_garage'), "Garage", "Avec qui souhaitez-vous partager votre véhicule ?"))
RMenu.Add('Extasy_garage', 'sub_pay_vehicle', RageUI.CreateSubMenu(RMenu:Get('Extasy_garage', 'sub_garage'), "Garage", "Que souhaitez-vous faire ?"))
RMenu.Add('Extasy_garage', 'sub_garage_settings', RageUI.CreateSubMenu(RMenu:Get('Extasy_garage', 'main_menu'), "Garage", "Que souhaitez-vous faire ?"))
RMenu:Get('Extasy_garage', 'main_menu').Closed = function()
    garage_openned = false
end

local mileage = 3

openGarage_m = function()
    if garage_openned then
        garage_openned = false
        return
    else
		TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
        garage_openned = true
        Citizen.CreateThread(function()
            while garage_openned do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('Extasy_garage', 'main_menu'), true, true, true, function()

                    RageUI.Separator(#playerGarage.."/"..extasy_core_cfg["max_vehicle_garage"].." véhicules", nil, {}, true, function(Hovered, Active, Selected) end)
                
                    for k,v in pairs(playerGarage) do
                        if garage_data.type == 'air' then
                            if v.type == 'helicopter' or v.type == 'plane' then
                                local vColor = nil
                                if v.isShared ~= 'no' then
                                    vColor = ' - ~b~[Partagé]~s~'
                                else
                                    vColor = ''
                                end

                                if mileage ~= nil then
                                    if not v.state then
                                        RageUI.Button("~p~[" ..v.plate.. "] ~s~- " ..v.vehicleName.." "..vColor.." ~r~[Fourrière]~s~", "~p~→~s~ "..mileage.."km au compteur", {RightBadge = RageUI.BadgeStyle.Car}, true, function(h, a, s) 
                                            if s then
                                                garage_data.plate = v.plate
                                                garage_data.props = v.vehicle
                                                garage_data.isBuyed = v.isBuyed
                                                garage_data.state = v.state
                                                garage_data.isShared = v.isShared
                                                garage_data.owner_base = v.owner
                                            end
                                        end, RMenu:Get('Extasy_garage', 'sub_garage'))
                                    else
                                        RageUI.Button("~p~[" ..v.plate.. "] ~s~- " ..v.vehicleName..""..vColor, "~p~→~s~ "..mileage.."km au compteur", {RightBadge = RageUI.BadgeStyle.Car}, true, function(h, a, s) 
                                            if s then
                                                garage_data.plate = v.plate
                                                garage_data.props = v.vehicle
                                                garage_data.isBuyed = v.isBuyed
                                                garage_data.state = v.state
                                                garage_data.isShared = v.isShared
                                                garage_data.owner_base = v.owner
                                            end
                                        end, RMenu:Get('Extasy_garage', 'sub_garage'))
                                    end
                                else
                                    if v.vehicleName ~= nil then
                                        if not v.state then
                                            RageUI.Button("~p~[" ..v.plate.. "] ~s~- " ..v.vehicleName..""..vColor.." ~r~[Fourrière]~s~", "~p~→~s~ 0km au compteur", {RightBadge = RageUI.BadgeStyle.Car}, true, function(h, a, s) 
                                                if s then
                                                    garage_data.plate = v.plate
                                                    garage_data.props = v.vehicle
                                                    garage_data.isBuyed = v.isBuyed
                                                    garage_data.state = v.state
                                                    garage_data.isShared = v.isShared
                                                    garage_data.owner_base = v.owner
                                                end
                                            end, RMenu:Get('Extasy_garage', 'sub_garage'))
                                        else
                                            RageUI.Button("~p~[" ..v.plate.. "] ~s~- " ..v.vehicleName..vColor, "~p~→~s~ 0km au compteur", {RightBadge = RageUI.BadgeStyle.Car}, true, function(h, a, s) 
                                                if s then
                                                    garage_data.plate = v.plate
                                                    garage_data.props = v.vehicle
                                                    garage_data.isBuyed = v.isBuyed
                                                    garage_data.state = v.state
                                                    garage_data.isShared = v.isShared
                                                    garage_data.owner_base = v.owner
                                                end
                                            end, RMenu:Get('Extasy_garage', 'sub_garage'))
                                        end
                                    end
                                end
                            end
                        else
                            if v.type == garage_data.type then
                                local vColor = nil
                                if v.isShared ~= 'no' then
                                    vColor = ' - ~b~[Partagé]~s~'
                                else
                                    vColor = ''
                                end
                                if mileage ~= nil then
                                    if not v.state then
                                        RageUI.Button("~p~[" ..v.plate.. "] ~s~- " ..v.vehicleName.. " ~r~[Fourrière]~s~"..vColor, "~p~→~s~ "..mileage.."km au compteur", {RightBadge = RageUI.BadgeStyle.Car}, true, function(h, a, s) 
                                            if s then
                                                garage_data.plate = v.plate
                                                garage_data.props = v.vehicle
                                                garage_data.isBuyed = v.isBuyed
                                                garage_data.state = v.state
                                                garage_data.isShared = v.isShared
                                                garage_data.owner_base = v.owner
                                            end
                                        end, RMenu:Get('Extasy_garage', 'sub_garage'))
                                    else
                                        RageUI.Button("~p~[" ..v.plate.. "] ~s~- " ..v.vehicleName..""..vColor, "~p~→~s~ "..mileage.."km au compteur", {RightBadge = RageUI.BadgeStyle.Car}, true, function(h, a, s) 
                                            if s then
                                                garage_data.plate = v.plate
                                                garage_data.props = v.vehicle
                                                garage_data.isBuyed = v.isBuyed
                                                garage_data.state = v.state
                                                garage_data.isShared = v.isShared
                                                garage_data.owner_base = v.owner
                                            end
                                        end, RMenu:Get('Extasy_garage', 'sub_garage'))
                                    end
                                else
                                    if v.vehicleName ~= nil then
                                        if not v.state then
                                            RageUI.Button("~p~[" ..v.plate.. "] ~s~- " ..v.vehicleName..""..vColor.." ~r~[Fourrière]~s~", "~p~→~s~ 0km au compteur", {RightBadge = RageUI.BadgeStyle.Car}, true, function(h, a, s) 
                                                if s then
                                                    garage_data.plate = v.plate
                                                    garage_data.props = v.vehicle
                                                    garage_data.isBuyed = v.isBuyed
                                                    garage_data.state = v.state
                                                    garage_data.isShared = v.isShared
                                                    garage_data.owner_base = v.owner
                                                end
                                            end, RMenu:Get('Extasy_garage', 'sub_garage'))
                                        else
                                            RageUI.Button("~p~[" ..v.plate.. "] ~s~- " ..v.vehicleName..vColor, "~p~→~s~ 0km au compteur", {RightBadge = RageUI.BadgeStyle.Car}, true, function(h, a, s) 
                                                if s then
                                                    garage_data.plate = v.plate
                                                    garage_data.props = v.vehicle
                                                    garage_data.isBuyed = v.isBuyed
                                                    garage_data.state = v.state
                                                    garage_data.isShared = v.isShared
                                                    garage_data.owner_base = v.owner
                                                end
                                            end, RMenu:Get('Extasy_garage', 'sub_garage'))
                                        end
                                    end
                                end
                            end
                        end
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Extasy_garage', 'sub_garage'), true, true, true, function()

                    RageUI.Button("Sortir", nil, {RightLabel = "→→"}, true, function(h, a, s)
                        if s then
                            if #playerGarage < extasy_core_cfg["max_vehicle_garage"] then
                                if not garage_data.state then
                                    Extasy.ShowNotification("~r~Ce véhicule est à la fourrière, veuillez vous diriger vers une fourrière pour le sortir")
                                else
                                    tryToSpawnRN(garage_data.props, garage_data.spawnP)
                                    garage_openned = false
                                    RageUI.CloseAll()
                                end
                            else
                                Extasy.ShowNotification("~r~Vous possédez trop de véhicules, vous ne pouvez pas sortir de véhicule ("..#playerGarage.."/"..extasy_core_cfg["max_vehicle_garage"]..")")
                            end
                        end
                    end)

                    if garage_data.isShared ~= 'no' then
                        if garage_data.owner_base == playerUUID then 
                            RageUI.Button("Donner", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('Extasy_garage', 'sub_give_vehicle'))
                            RageUI.Button("Renommer", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    i = Extasy.KeyboardInput("Quel nom souhaitez-vous mettre ?", "", 35)
                                    i = tostring(i)
                                    if i ~= nil then
                                        TriggerServerEvent("garage:changeName", token, garage_data.plate, i)
                                        Wait(150)
                                        TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
                                    end
                                end
                            end)
                            RageUI.Button("Ne plus partager", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    i = Extasy.KeyboardInput("Écrivez 'Oui' pour confirmer", "", 35)
                                    i = tostring(i)
                                    if i == "oui" or i == "Oui" or i == "OUI" then
                                        TriggerServerEvent("garage:notSharingThisPlateAnymore", token, garage_data.plate)
                                        Wait(150)
                                        RageUI.GoBack()
                                        TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
                                        Extasy.ShowNotification("~g~Véhicule '"..garage_data.plate.."' n'est plus partagé")
                                    else
                                        Extasy.ShowNotification("~r~Requête annulée")
                                    end
                                end
                            end)  
                            RageUI.Button("~r~Abandonner~s~", nil, {RightLabel = "~r~→→→"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    i = Extasy.KeyboardInput("Écrivez 'Oui' pour confirmer l'abandon de '"..garage_data.plate.."'", "", 35)
                                    i = tostring(i)
                                    if i == "oui" or i == "Oui" or i == "OUI" then
                                        TriggerServerEvent("garage:delete", token, garage_data.plate)
                                        Wait(150)
                                        RageUI.GoBack()
                                        TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
                                        Extasy.ShowNotification("~g~Véhicule '"..garage_data.plate.."' abandonné")
                                    else
                                        Extasy.ShowNotification("~r~Abandon annulé")
                                    end
                                end
                            end)
                        end 
                    else
                        RageUI.Button("Donner", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('Extasy_garage', 'sub_give_vehicle'))
                        RageUI.Button("Renommer", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                i = Extasy.KeyboardInput("Quel nom souhaitez-vous mettre ?", "", 35)
                                i = tostring(i)
                                if i ~= nil then
                                    TriggerServerEvent("garage:changeName", token, garage_data.plate, i)
                                    Wait(150)
                                    TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
                                    RageUI.GoBack()
                                end
                            end
                        end)
                        RageUI.Button("Partager", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('Extasy_garage', 'sub_share_vehicle'))  
                        RageUI.Button("~r~Abandonner~s~", nil, {RightLabel = "~r~→→→"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                i = Extasy.KeyboardInput("Écrivez 'Oui' pour confirmer l'abandon de '"..garage_data.plate.."'", "", 35)
                                i = tostring(i)
                                if i == "oui" or i == "Oui" or i == "OUI" then
                                    TriggerServerEvent("garage:delete", token, garage_data.plate)
                                    RageUI.GoBack()
                                    Wait(150)
                                    TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
                                    Extasy.ShowNotification("~g~Véhicule '"..garage_data.plate.."' abandonné")
                                else
                                    Extasy.ShowNotification("~r~Abandon annulé")
                                end
                            end
                        end)
                    end                   
                
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Extasy_garage', 'sub_give_vehicle'), true, true, true, function()

                    for _, player in ipairs(GetActivePlayers()) do
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                        local coords = GetEntityCoords(GetPlayerPed(player))
                        local name = Extasy.ReplaceText(player)
                        local sta = Extasy.IsMyId(player)

                        if dst < 3.0 then
                            if sta ~= "me" then
                                RageUI.Button("#".._.." "..name, nil, {}, true, function(Hovered, Active, Selected)
                                    if Active then
                                        DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100,0,200, 100, true, true)
                                    end
                                    if Selected then
                                        i = Extasy.KeyboardInput("Écrivez 'Oui' pour confirmer", "", 3)
                                        i = tostring(i)
                                        if i == "oui" or i == "Oui" or i == "OUI" then
                                            if garage_data.isBuyed == 1 then
                                                TriggerServerEvent("garage:changeOwnerForThisPlate", token, garage_data.plate, GetPlayerServerId(player))
                                                garage_openned = false
                                                RageUI.CloseAll()
                                                Wait(150)
                                                TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
                                                Extasy.ShowNotification("~g~Véhicule '"..garage_data.plate.."' donné avec succès")
                                            else
                                                Extasy.ShowNotification("~r~Vous ne pouvez pas donner ce véhicule")
                                            end
                                        else
                                            Extasy.ShowNotification("~r~Requête annulée")
                                        end
                                    end
                                end)
                            end
                        end
                    end
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Extasy_garage', 'sub_share_vehicle'), true, true, true, function()

                    for _, player in ipairs(GetActivePlayers()) do
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                        local coords = GetEntityCoords(GetPlayerPed(player))
                        local name = Extasy.ReplaceText(player)
                        local sta = Extasy.IsMyId(player)
        
                        if dst < 3.0 then
                            if sta ~= "me" then
                                RageUI.Button("#".._.." "..name, nil, {}, true, function(Hovered, Active, Selected)
                                    if Active then
                                        DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100,0,200, 100, true, true)
                                    end
                                    if Selected then
                                        i = Extasy.KeyboardInput("Écrivez 'Oui' pour confirmer", "", 3)
                                        i = tostring(i)
                                        --if i == "oui" or i == "Oui" or i == "OUI" then
                                            if i == "oui" or i == "Oui" or i == "OUI" then
                                                TriggerServerEvent("garage:addNewCoOwnerToThisPlate", token, garage_data.plate, GetPlayerServerId(player))
                                                Wait(150)
                                                RageUI.CloseAll()
                                                garage_openned = falseopuqidqoi
                                                TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
                                                Extasy.ShowNotification("~g~Vous venez de partager le véhicule "..garage_data.plate)
                                            else
                                                Extasy.ShowNotification("~r~Vous ne pouvez pas partager ce véhicule")
                                            end
                                        --else
                                        --    Extasy.ShowNotification("~r~Requête annulée")
                                        --end
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

openGarage = function()
    TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
    Wait(1)
    if playerGarage == nil then
        Extasy.ShowNotification("~b~Chargement de vos données...")
        return
    end
    RageUI.Visible(RMenu:Get('Extasy_garage', 'main_menu'), true)
    openGarage_m()
end

tryToSpawnRN = function(vehicleProps, spawnPoints)
    if vehicleProps["model"] ~= 0 then
        local spawnpoint, heading = Extasy.LookingForPlace(spawnPoints)
        local joueur = GetPlayerName(PlayerId(-1))
        local plate = vehicleProps.plate
        local gameVehicles = Extasy.GetVehicles()

        for i = 1, #gameVehicles do
            local vehicle = gameVehicles[i]

            if DoesEntityExist(vehicle) then
                if Extasy.Trim(GetVehicleNumberPlateText(vehicle)) == Extasy.Trim(vehicleProps.plate) then
                    Extasy.ShowNotification("~r~Ce véhicule est déjà sorti")
                    return
                end
            end
        end

        if vehicleProps['fuelLevel'] == nil then vehicleProps['fuelLevel'] = 100.0 end

        if tonumber(vehicleProps['fuelLevel']) < 1.0 then
            Extasy.SpawnVehicle(vehicleProps["model"], spawnpoint, heading, function(vehicle)
            Extasy.SetVehicleProperties(vehicle, vehicleProps)
            NetworkFadeInEntity(vehicle, true, true)
            SetModelAsNoLongerNeeded(vehicleProps["model"])
            SetEntityAsMissionEntity(vehicle, true, true)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            SetVehicleFuelLevel(vehicle, 10.0)
            SetVehicleNumberPlateText(vehicle, vehicleProps['plate'])

            if GetVehicleClass(vehicle) == 15 then
                for i = 1, 10, 1 do
                    SetVehicleExtra(vehicle, i, 0)
                end
            end
        end)
        else
            Extasy.SpawnVehicle(vehicleProps["model"], spawnpoint, heading, function(vehicle)
                Extasy.SetVehicleProperties(vehicle, vehicleProps)
                NetworkFadeInEntity(vehicle, true, true)
                SetModelAsNoLongerNeeded(vehicleProps["model"])
                SetEntityAsMissionEntity(vehicle, true, true)
                TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                SetVehicleNumberPlateText(vehicle, vehicleProps['plate'])

                if GetVehicleClass(vehicle) == 15 then
                    for i = 1, 10, 1 do
                        SetVehicleExtra(vehicle, i, 0)
                    end
                end
            end)
        end

        if vehicleProps ~= nil then
            TriggerServerEvent('garage:setVehicleState', token, vehicleProps.plate, false)
        else
            print("^1Debug garage: Les données de ce véhicules semblent corrompues, veuillez poster une capture d'écran dans le channel #report-bug sur discord")
        end
    else
        print("^1Debug garage: Les données de ce véhicules semblent corrompues, veuillez contacter un membre du staff capable de vous redonner un véhicule conforme")
    end
end

Citizen.CreateThread(function()
    while cfg_garage == nil do Wait(10) end
    while true do
        local near_garage  = false
        local ped       = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)

        for k,v in pairs(cfg_garage.list) do
            local dst    = GetDistanceBetweenCoords(pedCoords, v.garagePos, true)
            local dstDel = GetDistanceBetweenCoords(pedCoords, v.deletePos, true)
            if dst <= 3.0 then
                near_garage = true
                Extasy.ShowHelpNotification("Appuyez sur ~p~~INPUT_TALK~~s~ pour ~p~ouvrir le garage")
                DrawMarker(6, v.garagePos.x, v.garagePos.y, v.garagePos.z - 1.0, nil, nil, nil, -90, nil, nil, 1.4, 1.4, 1.4, 89, 3, 154, 100, false, false)
                if IsControlJustReleased(1, 38) then
                    if not garage_openned then
                        TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
                        Wait(150)
                        garage_data.type = v.type
                        openGarage()
                        garage_data.spawnP = v.spawnPoints
                        garage_data.props = nil
                    else
                        garage_openned = false
                        RageUI.CloseAll()
                    end
                end
            end
            if dstDel <= 5.0 then
                near_garage = true
                Extasy.ShowHelpNotification("Appuyez sur ~p~~INPUT_TALK~~s~ pour ~r~ranger votre véhicule")
                DrawMarker(6, v.deletePos.x, v.deletePos.y, v.deletePos.z - 1.0, nil, nil, nil, -90, nil, nil, 2.0, 2.0, 2.0, 255, 0, 0, 100, false, false)
                if IsControlJustReleased(1, 38) then
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    local vProps  = Extasy.GetVehicleProperties(vehicle)

                    vProps.model  = vProps.model
                    vProps.plate  = vProps.plate

                    if IsPedInAnyVehicle(playerPed,  false) then
                        local playerPed = GetPlayerPed(-1)
                        local coords = GetEntityCoords(playerPed)
                        local vehicle = GetVehiclePedIsIn(playerPed, false)
                        local vehicleProps = Extasy.GetVehicleProperties(vehicle)
                        local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
                        local engineHealth = GetVehicleEngineHealth(current)
                        local plate = vehicleProps.plate

                        ESX.TriggerServerCallback('garage:savePropsShare', function(valid)
                            if valid then
                                if engineHealth < 990 then
                                    local apprasial = math.floor((1000 - engineHealth)/1000*80)
                                    TriggerServerEvent('garage:PayHealth', token, apprasial)
                                    vehicleProps.bodyHealth = 1000.0
                                    vehicleProps.engineHealth = 1000

                                    TaskLeaveVehicle(PlayerPedId(), vehicle)
                                    Wait(2500)
                                    NetworkFadeOutEntity(vehicle, true, false)
                                    Wait(2000)
                                    DeleteVehicle(vehicle)

                                    TriggerServerEvent('garage:setVehicleState', token, vehicleProps.plate, true)
                                    Extasy.ShowNotification('~g~Votre véhicule a été entreposé dans le garage.')
                                else
                                    TaskLeaveVehicle(PlayerPedId(), vehicle)
                                    Wait(2500)
                                    NetworkFadeOutEntity(vehicle, true, false)
                                    Wait(2000)
                                    DeleteVehicle(vehicle)

                                    TriggerServerEvent('garage:setVehicleState', token, vehicleProps.plate, true)
                                    Extasy.ShowNotification('~g~Votre véhicule a été entreposé dans le garage.')
                                end	
                            else
                                ESX.TriggerServerCallback('garage:saveProps', function(valid2)
                                    if valid2 then
                                        if engineHealth < 990 then
                                            local apprasial = math.floor((1000 - engineHealth)/1000*80)
                                            TriggerServerEvent('garage:PayHealth', token, apprasial)
                                            vehicleProps.bodyHealth = 1000.0
                                            vehicleProps.engineHealth = 1000

                                            TaskLeaveVehicle(PlayerPedId(), vehicle)
                                            Wait(2500)
                                            NetworkFadeOutEntity(vehicle, true, false)
                                            Wait(2000)
                                            DeleteVehicle(vehicle)

                                            TriggerServerEvent('garage:setVehicleState', token, vehicleProps.plate, true)
                                            Extasy.ShowNotification('~g~Votre véhicule a été entreposé dans le garage.')
                                        else
                                            TaskLeaveVehicle(PlayerPedId(), vehicle)
                                            Wait(2500)
                                            NetworkFadeOutEntity(vehicle, true, false)
                                            Wait(2000)
                                            DeleteVehicle(vehicle)
                                            
                                            TriggerServerEvent('garage:setVehicleState', token, vehicleProps.plate, true)
                                            Extasy.ShowNotification('~g~Votre véhicule a été entreposé dans le garage.')
                                        end	
                                    else
                                        Extasy.ShowNotification('Vous ne pouvez pas stocker ce véhicule!')
                                    end
                                end, vehicleProps)
                            end
                        end, vehicleProps)
                    end
                end
            end
        end

        if near_garage then
            Wait(1)
        else
            Wait(500)
            garage_openned = false
        end
    end
end)

Citizen.CreateThread(function()
    while cfg_garage == nil do Wait(1) end
    for k, blipsG in pairs(cfg_garage.list) do
      blipsGarage = AddBlipForCoord(blipsG.garagePos)
      SetBlipSprite(blipsGarage, 357)
      SetBlipDisplay(blipsGarage, 4)
      SetBlipScale(blipsGarage, 0.60)
      SetBlipColour(blipsGarage, 38)
      SetBlipAsShortRange(blipsGarage, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString("Garage")
      EndTextCommandSetBlipName(blipsGarage)
    end
end)

RegisterNetEvent("garage:sendAddToCache")
AddEventHandler("garage:sendAddToCache", function(plate, vehicleProps, vehicleName, vecType)
    TriggerServerEvent("garage:addToGarageCache", token, plate, vehicleProps, vehicleName, vecType)
end)