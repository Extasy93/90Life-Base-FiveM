local index = 1
local callback = nil

openPedalo = function(number)
    RMenu.Add('pedalo_menu', 'main_menu', RageUI.CreateMenu("Activité pédalo", "Que souhaitez-vous faire ?", 1, 100))
    RMenu:Get('pedalo_menu', "main_menu").Closed = function()
        pedalo_open = false
        RMenu:Delete('pedalo_menu', 'main_menu')
    end

    if pedalo_open then
        pedalo_open = false
        return
    else
        RageUI.CloseAll()

        pedalo_open = true
        RageUI.Visible(RMenu:Get('pedalo_menu', 'main_menu'), true)
    end

    Citizen.CreateThread(function()
        while pedalo_open do
            Wait(1)

            RageUI.IsVisible(RMenu:Get('pedalo_menu', 'main_menu'), true, true, true, function()

                RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                    index = Index
                end)

                RageUI.Separator("")

                RageUI.Button("Louer un pédalo", nil, {RightLabel = Extasy.Math.GroupDigits(cfg_pedalo.rentPrice).."$"}, true, function(Hovered, Active, Selected)
                    if Selected then
                        TriggerServerEvent("pedalo:rent", token, index)
                        while callback == nil do Wait(100) end
                        if callback then
                            spawnPedaloVehicle(number)
                            
                            spawnPedaloVehicle = nil
                            index    = 1
                            callback = nil

                            RageUI.CloseAll()
                            pedalo_open = false
                        end
                    end
                end)
                
            end, function()
            end)
        end
    end)
end

spawnPedaloVehicle = function(number)
    local found, pos, heading = Extasy.LookingForMissionPlace(cfg_pedalo.points[number].list)

    Extasy.LoadModel('rowerwodny')

    vehicleEntity = CreateVehicle(GetHashKey('rowerwodny'), pos, heading, true, false)
    SetVehicleFuelLevel(vehicleEntity, 1000.0)
    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicleEntity, -1)
    SetEntityHeading(vehicleEntity, heading)

    Citizen.CreateThread(function()
        local dst = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(vehicleEntity), false)
        while dst < 75 do

            dst = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(vehicleEntity), false)

            Citizen.Wait(500)
        end
        DeleteEntity(vehicleEntity)
    end)
end

RegisterNetEvent("pedalo:cb")
AddEventHandler("pedalo:cb", function(cb)
    callback = cb
end)