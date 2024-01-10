ESX = nil
local cross_open = false
local crosspop = false
local index = 1
cross = {}

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RMenu.Add('Extasy_cross', 'main_menu', RageUI.CreateMenu("Terrain de Cross", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('Extasy_cross', 'main_menu').Closed = function()
    cross_open = false
end

opencrossMenu = function()
    if cross_open then
        cross_open = false
        return
    else
        cross_open = true
        Citizen.CreateThread(function()
            while cross_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('Extasy_cross', 'main_menu'), true, true, true, function()

                    if cross.num == 1 or cross.num == 0 then
                        --
                    else
                        --
                    end

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index = Index
                    end)

                    if not crosspop then
                        RageUI.Separator("↓     ~p~Motos     ~s~↓")

                        for k, v in pairs(cfg_cross.Cross) do
                            RageUI.Button(v.Label, nil, {RightLabel = "~r~"..v.Price.."$"}, true, function(h, a, s) 
                                if s then
                                    TriggerServerEvent('Cross:rentBike', token, v.Label, v.Value, v.Price, index)
                                    crosspop = true
                                    RageUI.CloseAll()
                                end
                            end)
                        end
                    else
                        RageUI.Button("Rendre la Moto", nil, {RightLabel = "~y~→"}, true, function(h, a, s) 
                            if s then
                                local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
    
                                if dist4 < 4 then
                                    DeleteEntity(veh)
                                    Extasy.ShowAdvancedNotification("Terrain de cross", "~o~Moto", "Le véhicule a bien été ~o~rentrer~s~. Merci à vous !", "CHAR_DOM", 1)
                                    RageUI.CloseAll()
                                    crosspop = false
                                end
                            end
                        end)
                    end
                end, function()
                end)
            end
        end)
    end
end

opencross = function(num)
    cross.num = num
    RageUI.Visible(RMenu:Get('Extasy_cross', 'main_menu'), true)
    opencrossMenu()
end

Citizen.CreateThread(function()
    while true do
        local pos

        if cross.num == 1 then
            pos = vector3(4046.03, 7003.07, 15.86)
        else
            pos = vector3(2774.35, 7650.77, 14.42)
        end

        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos.x, pos.y, pos.z)

        if dist >= 150.0 and crosspop then
            local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
            DeleteEntity(veh)
            crosspop = false
            Extasy.ShowAdvancedNotification("Terrain de cross", "~o~Moto", "Votre ~o~véhicule ~s~à été rendu ! ~r~(Vous êtes aller trop loin) ~s~!", "CHAR_DOM", 1)
        end
        Wait(2050)
	end
end)

RegisterNetEvent('Cross:sendBike')
AddEventHandler('Cross:sendBike', function(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local vehicle

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    if cross.num == 1 then
        vehicle = CreateVehicle(car, 3916.07, 7015.57, 11.13, 70.36, true, false)
    else
        vehicle = CreateVehicle(car, 2824.40, 7615.76, 9.32, 70.36, true, false)
    end

    while vehicle == nil do Wait(1) end

    SetEntityAsMissionEntity(vehicle, true, true)
    Wait(10)
    SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
    SetVehicleFuelLevel(vehicle, 100.0)

    PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)

    Extasy.ShowAdvancedNotification("Terrain de cross", "~o~Moto", "Votre ~o~véhicule ~s~à bien été sortie ! ~o~Bonne course ~s~!", "CHAR_DOM")
    CheckSuccescross()
end)

crossCount = 0

Citizen.CreateThread(function()
    crossCount = GetResourceKvpInt("cross")
    if crossCount == nil then
        crossCount = 0
    end
end)

local succescross = {
    [1] = {
        texte = "Première fois au cross !"
    },
    [10] = {
        texte = "Vétérant du cross ! (Loué 10 cross)"
    },
    [50] = {
        texte = "Pro du cross (50 cross)",
        suplementaire = "Tu as maintenant accès aux 2 nouveaux cross",
    },
}

CheckSuccescross = function()
    crossCount = crossCount + 1
    if succescross[crossCount] ~= nil then
        --PlayUrl("SUCCES", "https://www.youtube.com/watch?v=VpwqsYA44JI", 0.4, false)
        TriggerEvent("Ambiance:PlayUrl", token, "SUCCES", "https://www.youtube.com/watch?v=VpwqsYA44JI", 0.4, false )
        Wait(1000)
        SendNUIMessage({ 
            succes = true
        })
        Extasy.NotifSucces("~y~SUCCES!\n~w~"..succescross[crossCount].texte)
        if succescross[crossCount].suplementaire ~= nil then
            Extasy.NotifSucces("~y~SUCCES!\n~w~"..succescross[crossCount].suplementaire)
        end
    end
    SetResourceKvpInt("cross", crossCount)
end