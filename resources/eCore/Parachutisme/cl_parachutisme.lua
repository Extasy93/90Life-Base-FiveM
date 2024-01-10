ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
    Wait(0)
  end
end)

parachutisme_openned = false
local para_index = 1
RMenu.Add('Extasy_parachutisme', 'main_menu', RageUI.CreateMenu("Vice City Parachutisme", "Que voulez-vous faire ?", 1, 100))
RMenu:Get('Extasy_parachutisme', 'main_menu').Closed = function()
    parachutisme_openned = false
end

function openParachutisme_m()
    if parachutisme_openned then
        parachutisme_openned = false
        return
    else
        parachutisme_openned = true
        Citizen.CreateThread(function()
            while parachutisme_openned do
                Wait(1)
                
                RageUI.IsVisible(RMenu:Get('Extasy_parachutisme', 'main_menu'), true, true, true, function()

                    RageUI.Separator("")

                    for k,v in pairs(cfg_basejump.list) do
                        if not v.check then
                            RageUI.Button(v.name, nil, {RightLabel = v.price.."$"}, true, function(h, a, s)
                                if s then
                                    v.check = true
                                end
                            end)
                        else
                            RageUI.Button(v.name, nil, {RightLabel = "Confirmez ("..v.price.."$)"}, true, function(h, a, s)
                                if s then
                                    if para_index == 1 then
                                        ESX.TriggerServerCallback('parachutisme:Takemoney', function (hasEnoughMoneyParachute)
                                            if hasEnoughMoneyParachute then
                                                Extasy.ShowNotification("Vous venez de dépenser (~r~"..v.price.."$~w~) dans un ~p~saut en parachute")

                                                Addbank_transac("Activité parachute", Extasy.Math.GroupDigits(v.price), "out")
            
                                                goPara(GetEntityCoords(GetPlayerPed(-1)))
                                                v.check = false
                                            else
                                                Extasy.ShowNotification('vous n\'avez pas assez d\'argent (Vous êtes toujours pauvre...)')
                                            end
                                        end)
                                    elseif para_index == 2 then
                                        ESX.TriggerServerCallback('parachutisme:Takemoney', function (hasEnoughMoneyParachute)
                                            if hasEnoughMoneyParachute then
                                                Extasy.ShowNotification("Vous venez de dépenser (~r~"..v.price.."$~w~) dans un ~p~saut en parachute")

                                                Addbank_transac("Activité parachute", Extasy.Math.GroupDigits(v.price), "out")
            
                                                goPara(GetEntityCoords(GetPlayerPed(-1)))
                                                v.check = false
                                            else
                                                Extasy.ShowNotification('vous n\'avez pas assez d\'argent (Vous êtes toujours pauvre...)')
                                            end
                                        end)
                                    elseif para_index == 3 then
                                        ESX.TriggerServerCallback('parachutisme:Takemoney', function (hasEnoughMoneyParachute)
                                            if hasEnoughMoneyParachute then
                                                Extasy.ShowNotification("Vous venez de dépenser (~r~"..v.price.."$~w~) dans un ~p~saut en parachute")

                                                Addbank_transac("Activité parachute", Extasy.Math.GroupDigits(v.price), "out")
            
                                                goPara(GetEntityCoords(GetPlayerPed(-1)))
                                                v.check = false
                                            else
                                                Extasy.ShowNotification('vous n\'avez pas assez d\'argent (Vous êtes toujours pauvre...)')
                                            end
                                        end)
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

function openParachutisme()
    RageUI.Visible(RMenu:Get('Extasy_parachutisme', 'main_menu'), true)
    openParachutisme_m()
end

function goPara(_coords)
    parachutisme_openned = false
    RageUI.CloseAll()
    DoScreenFadeOut(800)
                        
    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end

    local v = GetHashKey("maverick")
    local p = -573920724
    local cx = _coords.x + math.random(150.0, 350.0)
    RequestModel(v)
    while not HasModelLoaded(v) do Wait(10) end
    RequestModel(p)
    while not HasModelLoaded(p) do Wait(10) end
    local vehicle = CreateVehicle(v, cx, _coords.y, _coords.z + 1500.0, math.random(0.0, 180.0), true, 0)
    local ped =  CreatePed(4, p, _coords, 0.0, true, true)

    TaskWarpPedIntoVehicle(ped, vehicle, -1)
    SetVehicleEngineOn(vehicle, true, true, true)
    SetVehicleForwardSpeed(vehicle, 16)

    TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, 2)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("GADGET_PARACHUTE"), 150, true, true)

    DoScreenFadeIn(5000)

    Wait(5000)

    while IsPedInVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1)), false) do
        Wait(1)
    end
    Wait(15000)
    DeleteEntity(vehicle)
    DeleteEntity(ped)
end