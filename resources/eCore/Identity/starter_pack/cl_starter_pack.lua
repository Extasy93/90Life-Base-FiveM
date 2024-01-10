starter_pack_openned = false
local index3 = 15000
local index2 = 35000
local index1 = 50000

RMenu.Add('starter_pack', 'main_menu', RageUI.CreateMenu("Starter pack", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('starter_pack', 'main_menu').Closable = false
RMenu:Get('starter_pack', 'main_menu').Closed = function()
    starter_pack_openned = false
end

openSP_m = function()
    if starter_pack_openned then
        starter_pack_openned = false
        return
    else
        starter_pack_openned = true
        Citizen.CreateThread(function()
            while starter_pack_openned do
                Wait(1)

                RageUI.IsVisible(RMenu:Get('starter_pack', 'main_menu'), true, false, true, function()

                    RageUI.Button("~g~Starter légal", "- Vous obtenez ~g~50,000$~s~\n- Vous obtenez un véhicule (Faggio Sport)\n- Vous obtenez un job mieux rémunéré", {}, true, function(h, a, s)
                        if s then
                            TriggerServerEvent("starterpack:ProcessLegal", token, index1)

                            RageUI.CloseAll()
                            starter_pack_openned = false
                        end
                    end)

                    RageUI.Button("~r~Starter illégal", "- Vous obtenez ~g~35,000$~s~ et ~r~15,000$~s~\n- Vous obtenez une arme (Batte de baseball)\n- Vous obtenez 15 pieces d'armes", {}, true, function(h, a, s)
                        if s then
                            TriggerServerEvent("starterpack:ProcessIllegal", token, index2, index3)

                            RageUI.CloseAll()
                            starter_pack_openned = false
                        end
                    end)

                end, function()
                end)
            end
        end)
    end
end

openSP = function()
    RageUI.CloseAll()
    RageUI.Visible(RMenu:Get('starter_pack', 'main_menu'), true)
    openSP_m()
end

RegisterNetEvent('ExtasyStarterPack:GiveCar')
AddEventHandler('ExtasyStarterPack:GiveCar', function()
    dataReceved = true
    local a = GetHashKey("faggio")
    RequestModel(a)
    while not HasModelLoaded(a) do
        RequestModel(a)
        Wait(0)
    end
    local c = CreateVehicle(a, vector3(-207.91, -1936.78, 27.62), 204, true, false)
    vehicle_to_know = c
    local newPlate     = GeneratePlate()
    local vehicleProps = Extasy.GetVehicleProperties(c)	
    vehicleProps.model = a
    vehicleProps.plate = newPlate
    vehicle_to_know_plate = newPlate
    SetVehicleNumberPlateText(vehicle_to_know, newPlate)

    TriggerServerEvent('Extasy_vehicleshop:setVehicleOwned93LA6T', token, vehicleProps, "Faggio de départ")

    TaskWarpPedIntoVehicle(GetPlayerPed(-1), c, -1)
end)