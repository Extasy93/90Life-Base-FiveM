ESX = nil
local tour = {}
local load = false
local tb = {}
local isRolling = false
local roue, base, triangle, socle, veh, roueSpawn = nil,nil,nil,nil,false
local currentVehicleRewardModel = 'CITRUS2'

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
    end
end)

Citizen.CreateThread(function()
    Wait(3500)
    TriggerServerEvent('Extasy:createPlayer')
end)

RegisterNetEvent('Extasy:servertoclient')
AddEventHandler('Extasy:servertoclient', function(table)
    load = true
    tour = table
end)

startSpin = function()
    Citizen.CreateThread(function()
        local pos = 7
        SetEntityRotation(roue, 0, 0, -179.0, false, true);

        local deg = 0.0;
        local inc = 1;

        for i = 1,200 do
            SetEntityRotation(roue, 0, -deg, -179.0, false, true);
            deg = deg + inc;

            if inc < 4 then
                inc = inc + 0.2;
            end

            Citizen.Wait(5);
        end

        while math.ceil((deg - ((inc / 0.01) / 2) % 360 - pos) % 360) >= 5 do
            SetEntityRotation(roue, 0, -deg, 179.0, false, true);
            deg = deg + inc;
            Citizen.Wait(5);
        end
        
        isRolling = false;
    end)
end

deleteRoue = function()
    DeleteEntity(triangle)
    triangle = nil
    DeleteEntity(base)
    base = nil
    DeleteEntity(socle)
    socle = nil
    DeleteEntity(veh)
    veh = nil
    DeleteEntity(roue)
    roue = nil
    roueSpawn = false
end

GenerateRoue = function()
    -- Roue
    local model = GetHashKey('vw_prop_vw_luckywheel_02a')
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    roue = CreateObject(model, vector3(3790.34, 5967.2, 11.95), false, false)
    -- Base
    model = GetHashKey("vw_prop_vw_luckywheel_01a")
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    base = CreateObject(model, vector3(3790.34, 5967.2, 11.66), false, false)
    -- Trianglew
    model = GetHashKey("vw_prop_vw_jackpot_on")
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    triangle = CreateObject(model, vector3(3790.34, 5967.16, 14.42), false, false)
    -- Socle
    model = GetHashKey("vw_prop_vw_casino_podium_01a")
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    socle = CreateObject(model, vector3(3788.88, 5974.25, 11.66148), false, false)
    SetEntityRotation(roue, GetEntityPitch(roue), GetEntityRoll(roue), -179.0, 3, 1)
    SetEntityRotation(base, GetEntityPitch(base), GetEntityRoll(base), -179.0, 3, 1)
    SetEntityRotation(triangle, GetEntityPitch(triangle), GetEntityRoll(triangle), -179.0, 3, 1)
    -- Véhicule
    model = GetHashKey(currentVehicleRewardModel)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(1) end
    veh = CreateVehicle(model, vector3(3788.88, 5974.25, 11.66148), 90.0, false, false)
    FreezeEntityPosition(veh, true)
    SetVehicleDoorsLocked(veh, 2)
    SetEntityInvincible(veh, true)
    SetVehicleFixed(veh)
    SetVehicleDirtLevel(veh, 0.0)
    SetVehicleEngineOn(veh, true, true, true)
    SetVehicleLights(veh, 2)
    SetVehicleDashboardColor(veh, 1)
    SetVehicleInteriorColor(veh, 1)
    SetVehicleWindowTint(veh, 2)
    SetVehicleCustomPrimaryColour(veh, 150)
    SetVehicleCustomSecondaryColour(veh, 150)
    SetVehicleExtraColours(veh, 1, 1)

    SetVehicleModKit(veh, 0)
	SetVehicleMod(veh, 14, 0, true)
    ToggleVehicleMod(veh, 18, true)
    ToggleVehicleMod(veh, 22, true)
	--SetVehicleMod(veh, 23, 11, false)
	--SetVehicleMod(veh, 24, 11, false)
    ToggleVehicleMod(veh, 20, true)
    LowerConvertibleRoof(veh, true)
    SetVehicleIsStolen(veh, false)
    SetVehicleIsWanted(veh, false)
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetCanResprayVehicle(veh, true)
    SetPlayersLastVehicle(veh)
    SetVehicleFixed(veh)
    SetVehicleDeformationFixed(veh)
    SetVehicleTyresCanBurst(veh, false)
    --SetVehicleWheelsCanBreak(veh, false)
    SetVehicleCanBeTargetted(veh, false)
    SetVehicleExplodesOnHighExplosionDamage(veh, false)
    SetVehicleHasStrongAxles(veh, true)
    SetVehicleDirtLevel(veh, 0)
    SetVehicleCanBeVisiblyDamaged(veh, false)
    IsVehicleDriveable(veh, true)
    SetVehicleEngineOn(veh, true, true)
    SetVehicleStrong(veh, true)

    SetVehicleNeonLightEnabled(veh, 0, true)
    SetVehicleNeonLightEnabled(veh, 1, true)
    SetVehicleNeonLightEnabled(veh, 2, true)
    SetVehicleNeonLightEnabled(veh, 3, true)
    SetVehicleNeonLightsColour(veh, 255, 0, 0)
    for i = 0,14 do
        SetVehicleExtra(veh, i, 0)
    end
    SetVehicleModKit(veh, 0)
    for i = 0,49 do
        local custom = GetNumVehicleMods(veh, i)
        for j = 1,custom do
            SetVehicleMod(veh, i, math.random(1,j), 1)
        end
    end
    roueSpawn = true
end

Citizen.CreateThread(function()
    local rot = 1.0
    while true do
        local intervalRoue = 1
        if roueSpawn and socle ~= nil and veh ~= nil then
            rot = rot - 0.15
            SetEntityRotation(socle, GetEntityPitch(socle), GetEntityRoll(socle), rot, 3, 1)
            SetEntityHeading(veh, rot)
        else
            intervalRoue = 500
        end
        Wait(intervalRoue)
    end
end)

Citizen.CreateThread(function()
    while not load do Wait(0) end
    while true do
        local intervalRoue = 2000
        local pos = GetEntityCoords(GetPlayerPed(-1))
        local basePos = vector3(3791.52, 5968.01, 12.69)
        local distRoue = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), basePos, true)
        if roueSpawn then
            if distRoue > 150.0 then
                deleteRoue()
            else
                intervalRoue = 1
                if distRoue <= 2.0 and not isRolling then
                    if tour.roue >= 1 then
                        --Extasy.ShowHelpNotification('~w~Appuyez sur ~p~~INPUT_TALK~~w~ pour faire tourner ~y~la roue de la fortune !') 
                        Extasy.ShowHelpNotification('~r~La roue de la fortune est temporairement désactivée') 
                        --[[if IsControlJustPressed(0, 51) then
                            if not StartWheel then
                                TriggerServerEvent('Exatsy:loadingAnimation')
                                isRolling = true

                                local playerPed = GetPlayerPed(-1)
                                local _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
                                if IsPedMale(playerPed) then
                                    _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
                                end
                                local lib, anim = _lib, 'enter_right_to_baseidle'
                                ESX.Streaming.RequestAnimDict(lib, function()
                                    TaskGoStraightToCoord(playerPed, basePos.x, basePos.y, 12.69,  182.44,  -1,  -150.3,  0.0)
                                    local hasMoved = false
                                    while not hasMoved do
                                        local coords = GetEntityCoords(GetPlayerPed(-1))
                                        if coords.x >= (basePos.x - 0.01) and coords.x <= (basePos.x + 0.01) and coords.y >= (basePos.y - 0.01) and coords.y <= (basePos.y + 0.01) then
                                            hasMoved = true
                                        end
                                        Citizen.Wait(0)
                                    end
                                    TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
                                    TaskPlayAnim(playerPed, lib, 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
                                    startSpin()
                                    Wait(4000)
                                    TriggerServerEvent('Extasy:start', token)
                                end)
                            else
                                Extasy.ShowNotification("~r~Une personne est déjà entrain de tourner la roue.")
                            end
                        end--]]
                    else
                        Extasy.ShowHelpNotification("~r~Vous n\'avez plus aucun ticket...~w~ Si vous en voulez d\'autres attendez ~h~00H00~h~~w~ ou bien rendez-vous sur ~h~https://shop.90Life.fr")
                    end
                end
            end
        else
            if distRoue < 150.0 then
                GenerateRoue()
            end
        end
        Wait(intervalRoue)
    end
end)

RegisterNetEvent('Extasy:roueonoff')
AddEventHandler('Extasy:roueonoff', function(table)
    StartWheel = table
end)

-- CREATION PLAQUE

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

GeneratePlate = function()
	local generatedPlate
	local doBreak = false
    while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
        generatedPlate = string.upper(GetRandomNumber(2) .. GetRandomLetter(3) .. GetRandomNumber(3))

		ESX.TriggerServerCallback('Extasy:getPlate', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

IsPlateTaken = function(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('Extasy:getPlate', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

GetRandomNumber = function(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

GetRandomLetter = function(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

RegisterNetEvent('ExtasyWheel:WinTheCar')
AddEventHandler('ExtasyWheel:WinTheCar', function(model)
    ESX.Game.SpawnVehicle(model, vector3(-1210.79, -783.46, 17.08), nil, function(vehicle)
        TaskWarpPedIntoVehicle(GetPlayerPed(PlayerId()), vehicle, -1)
        local newPlate = GeneratePlate()
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
        vehicleProps.plate = newPlate
        SetVehicleNumberPlateText(vehicle, newPlate)
        TriggerServerEvent('esx_vehicleshop:setVehicleOwned93LA6T', vehicleProps, 'car')
    end)
end)