driving_school_m_openned = false
local currently_school = false
local currently_record = false
local current_test = nil
local current_test_type = nil
local current_check = 1
local current_blip = nil
local drive_errors = 0
local last_check = -1
local isAboveLimit = false
local lastVecHealth = nil
local curr_ty = nil
local curr_vehicle = nil
local nextCheckPoint = nil
local curr_item = nil
local curr_item_l = nil
local want_buy = false
local index = 1

goDrive = function()
    if currently_school then
        currently_school = false
        return
    else
        currently_school = true
        Citizen.CreateThread(function()
            while currently_school do
                Wait(0)

                if current_test == 'drive' then
                    local playerPed      = PlayerPedId()
                    local coords         = GetEntityCoords(playerPed)
                    nextCheckPoint = current_check + 1
                    
                    if cfg_drivingschool.drivings_car[nextCheckPoint] == nil then
                        if DoesBlipExist(current_blip) then
                            RemoveBlip(current_blip)
                        end

                        current_test = nil

                        if drive_errors < cfg_drivingschool.max_errors then
                            TriggerServerEvent("drivingschool:finish", token, curr_item)
                        else
                            Extasy.ShowNotification("~r~Vous avez échoué le test de conduite !")
                        end

                        DeleteVehicle(curr_vehicle)
                        SetEntityCoords(playerPed, 3779.69, 6086.57, 12.30)
                        currently_school = false
                        currently_record = false
                    else
                        if current_check ~= last_check then
                            if DoesBlipExist(current_blip) then
                                RemoveBlip(current_blip)
                            end

                            current_blip = AddBlipForCoord(cfg_drivingschool.drivings_car[nextCheckPoint].pos)
                            SetBlipRoute(current_blip, 1)
                            SetBlipRouteColour(current_blip, 7)
                            SetBlipColour(current_blip, 7)

                            last_check = current_check
                        end

                        local distance = GetDistanceBetweenCoords(coords, cfg_drivingschool.drivings_car[nextCheckPoint].pos, true)

                        if distance <= 100.0 then
                            DrawMarker(1, cfg_drivingschool.drivings_car[nextCheckPoint].pos, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.0, 5.0, 5.0, 72, 0, 255, 125, false, true, 2, false, false, false, false)
                        end

                        if distance <= 3.0 then
                            cfg_drivingschool.drivings_car[nextCheckPoint].action()
                            current_check = current_check + 1
                        end
                    end
                end
            end
        end)
    end
end

recordDamage = function()
    currently_record = true
    Citizen.CreateThread(function()
        while currently_record do
            Wait(10)

            local playerPed = PlayerPedId()
            
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * 3.6
                local tooMuchSpeed = false
                
                if cfg_drivingschool.drivings_car[current_check + 1] ~= nil then
                    if speed > cfg_drivingschool.drivings_car[current_check + 1].limit then
                        tooMuchSpeed = true

                        if not isAboveLimit then
                            drive_errors = drive_errors + 1
                            isAboveLimit = true

                            Extasy.ShowNotification("~r~Vous roulez à une vitesse non autorisée !")
                            Extasy.ShowNotification("~r~Erreur(s): "..drive_errors.."/"..cfg_drivingschool.max_errors)
                        end
                    end
                end

                -- if not tooMuchSpeed then
                --     isAboveLimit = false
                -- end

                local health = GetEntityHealth(vehicle)
				if health < lastVecHealth then

					drive_errors = drive_errors + 1

                    Extasy.ShowNotification("~r~Vous venez de faire un accident !")
                    Extasy.ShowNotification("~r~Erreur(s): "..drive_errors.."/"..cfg_drivingschool.max_errors)

					lastVecHealth = health
					Wait(1500)
				end
            end
        end
    end)
end

startDriveTest = function(type)
	Extasy.SpawnVehicle(cfg_drivingschool.cars_model[type].model, cfg_drivingschool.cars_model[type].spawnPoint, cfg_drivingschool.cars_model[type].heading, function(vehicle)
		current_test      = 'drive'
		current_test_type = type
		current_check = 0
		last_check    = -1
		drive_errors       = 0
		isAboveLimit = false
        lastVecHealth = GetEntityHealth(vehicle)
        curr_vehicle = vehicle

		local playerPed = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleFuelLevel(vehicle, 100.0)
	end)
end

openDrivingMenu = function()
    RMenu.Add('driving_school', 'main_menu', RageUI.CreateMenu("Auto-école", "Que souhaitez-vous faire ?", 1, 100))
    RMenu:Get('driving_school', 'main_menu').Closed = function()
        driving_school_m_openned = false

        RMenu:Delete('driving_school', 'main_menu')
    end

    if driving_school_m_openned then
        driving_school_m_openned = false
        return
    else
        driving_school_m_openned = true
        RageUI.Visible(RMenu:Get('driving_school', 'main_menu'), true)

        Citizen.CreateThread(function()
            while driving_school_m_openned do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('driving_school', 'main_menu'), true, true, true, function()

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index = Index
                    end)

                    RageUI.Separator("")

                    for k,v in pairs(cfg_drivingschool.list_licenses) do
                        if not v.want_buy then
                            RageUI.Button(v.name, nil, {RightLabel = Extasy.Math.GroupDigits(v.price).."$"}, true, function(h, a, s)
                                if s then
                                    v.want_buy = true
                                end
                            end)
                        else
                            RageUI.Button(v.name, nil, {RightLabel = "Appuyez pour confirmer ("..Extasy.Math.GroupDigits(v.price).."$"..")"}, true, function(h, a, s)
                                if s then
                                    TriggerServerEvent("drivingschool:pay", token, v.price, index, v.method, v.value, k, v.item, v.label, v.name)
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

RegisterNetEvent("drivingschool:payResult")
AddEventHandler("drivingschool:payResult", function(price, method, value, k, item, label, name)
    current_test = value
    startDriveTest(k)
    curr_ty = k
    curr_item = item
    curr_item_l = label
    Wait(10)
    goDrive()
    recordDamage()

    Addbank_transac(name, Extasy.Math.GroupDigits(price), "out")

    RageUI.CloseAll()
    driving_school_m_openned = false
end)