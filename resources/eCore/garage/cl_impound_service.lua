impound_open = false
local impound_data = {}

RMenu.Add('impound_menu', 'main_menu', RageUI.CreateMenu("Fourrière", "Que voulez-vous faire ?", 1, 100))
RMenu.Add('impound_menu', 'main_menu_choose', RageUI.CreateSubMenu(RMenu:Get('impound_menu', 'main_menu'), "Fourrière", "Que voulez-vous faire ?"))
RMenu:Get('impound_menu', 'main_menu').Closed = function()
    impound_open = false
end

function openimpound_menu_m()
    if impound_open then
        impound_open = false
        return
    else
        impound_open = true
        Citizen.CreateThread(function()
            while impound_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('impound_menu', 'main_menu'), true, true, true, function()
        
                    for k,v in pairs(playerGarage) do
                        if not v.state then
                            if v.type == impound_data.type then
                                RageUI.Button(v.vehicleName, "Ce véhicule a parcourut 0km", {RightLabel = v.plate}, true, function(h, a, s) 
                                    if s then
                                        impound_data.plate = v.plate
                                        impound_data.state = v.state
                                        impound_data.props = v.vehicle
                                    end
                                end, RMenu:Get('impound_menu', 'main_menu_choose'))
                            end
                        end
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('impound_menu', 'main_menu_choose'), true, true, true, function()
        
                    RageUI.Button("Payer pour sortir le véhicule", nil, {RightLabel = extasy_core_cfg["impound_service_price"].."$"}, true, function(h, a, s) 
                        if s then
                            ESX.TriggerServerCallback('Extasy:PayImpound', function(CanGo)
                                if CanGo then
                                    TriggerServerEvent("garage:setVehicleState", token, impound_data.plate, true)

                                    DeleteEntity(GetLastDrivenVehicle())

                                    if impound_data.num == 1 then
                                        tryToSpawnRN(impound_data.props, cfg_impound_service.spawnPoints[1])
                                    elseif impound_data.num == 2 then
                                        tryToSpawnRN(impound_data.props, cfg_impound_service.spawnPoints[2])
                                    elseif impound_data.num == 3 then
                                        tryToSpawnRN(impound_data.props, cfg_impound_service.spawnPoints[3])
                                    elseif impound_data.num == 4 then
                                        tryToSpawnRN(impound_data.props, cfg_impound_service.spawnPoints[4])
                                    elseif impound_data.num == 5 then
                                        tryToSpawnRN(impound_data.props, cfg_impound_service.spawnPoints[5])
                                    end
                                    RageUI.CloseAll()
                                    impound_open = false
                                else
                                    Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent")
                                end
                            end, extasy_core_cfg["impound_service_price"])
                        end
                    end)
                end, function()
                end)
            end
        end)
    end
end

openimpound_menu = function(num, type)
    TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)
    Wait(150)
    impound_data.num = num
    impound_data.type = type
    
    RageUI.Visible(RMenu:Get('impound_menu', 'main_menu'), true)
    openimpound_menu_m()
end