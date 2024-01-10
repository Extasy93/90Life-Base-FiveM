local location_open = false
local index    = 1
loca           = {}
LastVehicles   = {}

RMenu.Add('Extasy_location', 'main_menu', RageUI.CreateMenu("Location", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('Extasy_location', 'main_menu').Closed = function()
    location_open = false
end

function openLocationMenu()
    if location_open then
        location_open = false
        return
    else
        location_open = true
        Citizen.CreateThread(function()
            while location_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('Extasy_location', 'main_menu'), true, true, true, function()

                    if loca.num == 3 or loca.num == 4 then
                        RageUI.Separator("↓ ~p~Liste des bateaux disponibles~s~ ↓")
                    else
                        RageUI.Separator("↓ ~p~Liste des véhicules disponibles~s~ ↓")
                    end
        
                    for k,v in pairs(cfg_location.list) do
                        if v.num == loca.num then
                            for k,l in pairs(v.vehicles) do
                                RageUI.Button(l.name, nil, {RightLabel = Extasy.Math.GroupDigits(l.price).."$"}, true, function(h, a, s) 
                                    if s then
                                        local pos, heading = lookingforPlace()

                                        ESX.TriggerServerCallback('Extasy:BuyLocationCar', function (hasEnoughMoneyForLocation)
                                            if hasEnoughMoneyForLocation then
                                                spawnVehicleLocation(l.hash, pos, heading)
                                                Addbank_transac("Location '"..l.name.."'", Extasy.Math.GroupDigits(l.price), "out")
                                                RageUI.CloseAll()
                                                location_open = false
                                            else
                                                Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent sur vous")
                                            end
                                        end, l.price)
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

openLocation = function(num)
    loca.num = num
    RageUI.Visible(RMenu:Get('Extasy_location', 'main_menu'), true)
    openLocationMenu()
end

spawnVehicleLocation = function(model, coords, heading)
    if coords then
        Extasy.SpawnVehicle(model, coords, heading, function (vehicle) 
            local vProps = Extasy.GetVehicleProperties(vehicle)
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            SetVehicleFuelLevel(vehicle, 100.0)
            TriggerServerEvent('carlock:location', token, vProps.plate)
            PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
            Extasy.ShowNotification("~g~Vous avez reçu les clés du véhicule '"..vProps.plate.."'")
            CheckSuccesLocation()
        end)
    else
        Extasy.ShowNotification("~r~Aucune sortie de véhicule disponible")
    end
end

lookingforPlace = function()
    local found = false
    local pos = nil
    local heading = nil
    for k,v in pairs(cfg_location.list) do
        if v.num == loca.num then
            for k,z in pairs(v.coords) do
                if Extasy.IsSpawnPointClear(z.pos, 3.0) then
                    found = true
                    pos = z.pos
                    heading = z.heading
                end
            end
        end
    end
    if not found then
        return false
    else
        return pos, heading
    end
end


LocationCount = 0

Citizen.CreateThread(function()
    LocationCount = GetResourceKvpInt("Location")
    if LocationCount == nil then
        LocationCount = 0
    end
end)

local succesLocation = {
    [1] = {
        texte = "Première location !"
    },
    [10] = {
        texte = "Fainéant ! (10 location)"
    },
    [50] = {
        texte = "Pro de la location (50 Location)",
        suplementaire = "Tu as maintenant accès au 2 voitures de luxes",
    },
}

function CheckSuccesLocation()
    LocationCount = LocationCount + 1
    if succesLocation[LocationCount] ~= nil then
        --PlayUrl("SUCCES", "https://www.youtube.com/watch?v=VpwqsYA44JI", 0.4, false)
        TriggerEvent("Ambiance:PlayUrl", "SUCCES", "https://www.youtube.com/watch?v=VpwqsYA44JI", 0.4, false )
        Wait(1000)
        SendNUIMessage({ 
            succes = true
        })
        Extasy.NotifSucces("~y~SUCCES!\n~w~"..succesLocation[LocationCount].texte)
        if succesLocation[LocationCount].suplementaire ~= nil then
            Extasy.NotifSucces("~y~SUCCES!\n~w~"..succesLocation[LocationCount].suplementaire)
        end
    end
    SetResourceKvpInt("Location", LocationCount)
end