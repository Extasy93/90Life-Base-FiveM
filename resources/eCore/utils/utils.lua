ESX	= nil

CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

-- Disable regen
SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)

Extasy = {}
Extasy.Math = {}

Extasy.Math.GroupDigits = function(value)
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')

	return left..(num:reverse():gsub('(%d%d%d)','%1' .. ","):reverse())
end

Extasy.ShowHelpNotification = function(msg)
	AddTextEntry("HELPNOTIFICATION_TEXT", msg)
	BeginTextCommandDisplayHelp("HELPNOTIFICATION_TEXT")
	EndTextCommandDisplayHelp(0, false, true, -1)
end

Extasy.IsMyId = function(player)
	if GetPlayerServerId(PlayerId()) == GetPlayerServerId(player) then
        return "me"
    else
        return ""
    end
end

Extasy.ReplaceText = function(py)
    local one  = GetPlayerName(py)
    local two = ""
    for i = 1, string.len(one), 1 do
        two = two.."•"
    end

    return two
end

Extasy.GetPlayerCapacity = function()
	local base = 25.0

	if playerGotBag then
		base = base + 20.0
	end

	return base
end

Extasy.GetObjects = function()
	local objects = {}

	for object in EnumerateObjects() do
		table.insert(objects, object)
	end

	return objects
end

Extasy.GetClosestObject = function(vector, radius, modelHash, testFunction)
    if not vector or not radius then return end
    local handle, veh = FindFirstObject()
    local success, theVeh
    repeat
        local firstDist = GetDistanceBetweenCoords(GetEntityCoords(veh), vector.x, vector.y, vector.z, true)
        if firstDist < radius and (not modelHash or modelHash == GetEntityModel(veh)) and (not theVeh or firstDist < GetDistanceBetweenCoords(GetEntityCoords(theVeh), GetEntityCoords(veh), true)) and (not testFunction or testFunction(veh)) then
            theVeh = veh
        end
        success, veh = FindNextObject(handle)
    until not success
        EndFindObject(handle)
    return theVeh
end

Extasy.IsPatron = function(_job, _grade)
	if _job == 'boss' then
		return true
	else
		return false
	end
end

Extasy.PlayAnim = function(dict, anim, flag, blendin, blendout, playbackRate, duration)
	if blendin == nil then blendin = 1.0 end
	if blendout == nil then blendout = 1.0 end
	if playbackRate == nil then playbackRate = 1.0 end
	if duration == nil then duration = -1 end
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Wait(1) print("Waiting for "..dict) end
	TaskPlayAnim(GetPlayerPed(-1), dict, anim, blendin, blendout, duration, flag, playbackRate, 0, 0, 0)
	RemoveAnimDict(dict)
end	

--[[Extasy.GetClosestObject = function(filter, coords)
	local objects         = Extasy.GetObjects()
	local closestDistance = -1
	local closestObject   = -1
	local filter          = filter
	local coords          = coords

	if type(filter) == 'string' then
		if filter ~= '' then
			filter = {filter}
		end
	end

	if coords == nil then
		local playerPed   = PlayerPedId()
		coords            = GetEntityCoords(playerPed)
	end

	for i=1, #objects, 1 do
		local foundObject = false

		if filter == nil or (type(filter) == 'table' and #filter == 0) then
			foundObject = true
		else
			local objectModel = GetEntityModel(objects[i])

			for j=1, #filter, 1 do
				if objectModel == GetHashKey(filter[j]) then
					foundObject = true
				end
			end
		end

		if foundObject then
			local objectCoords = GetEntityCoords(objects[i])
			local distance     = GetDistanceBetweenCoords(objectCoords, coords.x, coords.y, coords.z, true)

			if closestDistance == -1 or closestDistance > distance then
				closestObject   = objects[i]
				closestDistance = distance
			end
		end
	end

	return closestObject, closestDistance
end--]]

Extasy.isMessageGood = function(i)
	local good = true

	if i == '!escaped' then Extasy.ShowNotification("~r~Annonce invalide") good = false return end
    if i == nil then Extasy.ShowNotification("~r~Annonce invalide") good = false return end
	if string.len(i) < 5 then Extasy.ShowNotification("~r~Annonce trop courte") good = false return end
	
	return good
end

Extasy.KeyboardInput = function(one, two, max)
	playerIsOnKeyBoard = true
	local result = nil
    AddTextEntry("FMMC_KEY_TIP", one)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP", "", two, "", "", "", max)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

	if UpdateOnscreenKeyboard() ~= 2 then
		playerIsOnKeyBoard = false
        result = GetOnscreenKeyboardResult()
        Wait(1)
    else
        Wait(1)
    end

    return result
end

Extasy.GetVehicleInDirection = function()
	local playerPed    = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local inDirection  = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	local rayHandle    = StartShapeTestRay(playerCoords, inDirection, 10, playerPed, 0)
	local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

	if hit == 1 and GetEntityType(entityHit) == 2 then
		return entityHit
	end

	return nil
end

Extasy.LookingForPlace = function(_table)
	local found   = false
    local pos     = nil
	local heading = nil

	for k,v in pairs(_table) do
        if Extasy.IsSpawnPointClear(v.pos, 3.0) then
            found   = true
            pos     = v.pos
            heading = v.heading
        end
	end
	
    if not found then
        return false
    else
        return pos, heading
    end
end

Extasy.HideHUDThisFrame = function()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

Extasy.GetPlayers = function()
	local maxPlayers = 255
	local players    = {}

	for i=0, maxPlayers, 1 do
		local ped = GetPlayerPed(i)

		if DoesEntityExist(ped) then
			table.insert(players, i)
		end
	end

	return players
end

Extasy.GetClosestPlayer = function(coords)
	local players         = Extasy.GetPlayers()
	local closestDistance = -1
	local closestPlayer   = -1
	local coords          = coords
	local usePlayerPed    = false
	local playerPed       = PlayerPedId()
	local playerId        = PlayerId()

	if coords == nil then
		usePlayerPed = true
		coords       = GetEntityCoords(playerPed)
	end

	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
			local targetCoords = GetEntityCoords(target)
			local distance     = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)

			if closestDistance == -1 or closestDistance > distance then
				closestPlayer   = players[i]
				closestDistance = distance
			end
		end
	end

	return closestPlayer, closestDistance
end

Extasy.SetVehicleProperties = function(vehicle, props)
	SetVehicleModKit(vehicle, 0)

	if props.plate ~= nil then
		SetVehicleNumberPlateText(vehicle, props.plate)
	end

	if props.plateIndex ~= nil then
		SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
	end

	if props.health ~= nil then
		SetEntityHealth(vehicle, props.health)
	end

	if props.dirtLevel ~= nil then
		SetVehicleDirtLevel(vehicle, props.dirtLevel)
	end

	if props.color1 ~= nil then
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, props.color1, color2)
	end

	if props.color2 ~= nil then
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, color1, props.color2)
	end

	if props.pearlescentColor ~= nil then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
	end

	if props.wheelColor ~= nil then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
	end

	if props.wheels ~= nil then
		SetVehicleWheelType(vehicle, props.wheels)
	end

	if props.windowTint ~= nil then
		SetVehicleWindowTint(vehicle, props.windowTint)
	end

	if props.neonEnabled ~= nil then
		SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
		SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
		SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
		SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
	end

	if props.extras ~= nil then
		for id,enabled in pairs(props.extras) do
			if enabled then
				SetVehicleExtra(vehicle, tonumber(id), 0)
			else
				SetVehicleExtra(vehicle, tonumber(id), 1)
			end
		end
	end

	if props.neonColor ~= nil then
		SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
	end

	if props.modSmokeEnabled ~= nil then
		ToggleVehicleMod(vehicle, 20, true)
	end

	if props.tyreSmokeColor ~= nil then
		SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
	end

	if props.modSpoilers ~= nil then
		SetVehicleMod(vehicle, 0, props.modSpoilers, false)
	end

	if props.modFrontBumper ~= nil then
		SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
	end

	if props.modRearBumper ~= nil then
		SetVehicleMod(vehicle, 2, props.modRearBumper, false)
	end

	if props.modSideSkirt ~= nil then
		SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
	end

	if props.modExhaust ~= nil then
		SetVehicleMod(vehicle, 4, props.modExhaust, false)
	end

	if props.modFrame ~= nil then
		SetVehicleMod(vehicle, 5, props.modFrame, false)
	end

	if props.modGrille ~= nil then
		SetVehicleMod(vehicle, 6, props.modGrille, false)
	end

	if props.modHood ~= nil then
		SetVehicleMod(vehicle, 7, props.modHood, false)
	end

	if props.modFender ~= nil then
		SetVehicleMod(vehicle, 8, props.modFender, false)
	end

	if props.modRightFender ~= nil then
		SetVehicleMod(vehicle, 9, props.modRightFender, false)
	end

	if props.modRoof ~= nil then
		SetVehicleMod(vehicle, 10, props.modRoof, false)
	end

	if props.modEngine ~= nil then
		SetVehicleMod(vehicle, 11, props.modEngine, false)
	end

	if props.modBrakes ~= nil then
		SetVehicleMod(vehicle, 12, props.modBrakes, false)
	end

	if props.modTransmission ~= nil then
		SetVehicleMod(vehicle, 13, props.modTransmission, false)
	end

	if props.modHorns ~= nil then
		SetVehicleMod(vehicle, 14, props.modHorns, false)
	end

	if props.modSuspension ~= nil then
		SetVehicleMod(vehicle, 15, props.modSuspension, false)
	end

	if props.modArmor ~= nil then
		SetVehicleMod(vehicle, 16, props.modArmor, false)
	end

	if props.modTurbo ~= nil then
		ToggleVehicleMod(vehicle,  18, props.modTurbo)
	end

	if props.modXenon ~= nil then
		ToggleVehicleMod(vehicle,  22, props.modXenon)
	end

	if props.xenonColour ~= nil then
		SetVehicleHeadlightsColour(vehicle, props.xenonColour)
	end

	if props.modFrontWheels ~= nil then
		SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
	end

	if props.modBackWheels ~= nil then
		SetVehicleMod(vehicle, 24, props.modBackWheels, false)
	end

	if props.modPlateHolder ~= nil then
		SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
	end

	if props.modVanityPlate ~= nil then
		SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
	end

	if props.modTrimA ~= nil then
		SetVehicleMod(vehicle, 27, props.modTrimA, false)
	end

	if props.modOrnaments ~= nil then
		SetVehicleMod(vehicle, 28, props.modOrnaments, false)
	end

	if props.modDashboard ~= nil then
		SetVehicleMod(vehicle, 29, props.modDashboard, false)
	end

	if props.modDial ~= nil then
		SetVehicleMod(vehicle, 30, props.modDial, false)
	end

	if props.modDoorSpeaker ~= nil then
		SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
	end

	if props.modSeats ~= nil then
		SetVehicleMod(vehicle, 32, props.modSeats, false)
	end

	if props.modSteeringWheel ~= nil then
		SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
	end

	if props.modShifterLeavers ~= nil then
		SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
	end

	if props.modAPlate ~= nil then
		SetVehicleMod(vehicle, 35, props.modAPlate, false)
	end

	if props.modSpeakers ~= nil then
		SetVehicleMod(vehicle, 36, props.modSpeakers, false)
	end

	if props.modTrunk ~= nil then
		SetVehicleMod(vehicle, 37, props.modTrunk, false)
	end

	if props.modHydrolic ~= nil then
		SetVehicleMod(vehicle, 38, props.modHydrolic, false)
	end

	if props.modEngineBlock ~= nil then
		SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
	end

	if props.modAirFilter ~= nil then
		SetVehicleMod(vehicle, 40, props.modAirFilter, false)
	end

	if props.modStruts ~= nil then
		SetVehicleMod(vehicle, 41, props.modStruts, false)
	end

	if props.modArchCover ~= nil then
		SetVehicleMod(vehicle, 42, props.modArchCover, false)
	end

	if props.modAerials ~= nil then
		SetVehicleMod(vehicle, 43, props.modAerials, false)
	end

	if props.modTrimB ~= nil then
		SetVehicleMod(vehicle, 44, props.modTrimB, false)
	end

	if props.modTank ~= nil then
		SetVehicleMod(vehicle, 45, props.modTank, false)
	end

	if props.modWindows ~= nil then
		SetVehicleMod(vehicle, 46, props.modWindows, false)
	end

	if props.modLivery ~= nil then
		SetVehicleMod(vehicle, 48, props.modLivery, false)
		SetVehicleLivery(vehicle, props.modLivery)
	end

	if props.fuelLevel ~= nil then
		SetVehicleFuelLevel(vehicle, props.fuelLevel)
		props.fuelLevel = nil
	end
end

Extasy.GetClosestVehicle = function(coords)
	local vehicles        = Extasy.GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end

Extasy.SpawnVehicle = function(modelName, coords, heading, cb)
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

	CreateThread(function()
		Extasy.RequestModel(model)

		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
		local id      = NetworkGetNetworkIdFromEntity(vehicle)

		SetNetworkIdCanMigrate(id, true)
		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetModelAsNoLongerNeeded(model)

		RequestCollisionAtCoord(coords.x, coords.y, coords.z)

		while not HasCollisionLoadedAroundEntity(vehicle) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Wait(0)
		end

		SetVehRadioStation(vehicle, 'OFF')

		if cb ~= nil then
			cb(vehicle)
		end
	end)
end

Extasy.displayCommonBlip = function(blipConfig, blipPos)
	local blip = AddBlipForCoord(blipPos)	

	SetBlipHighDetail(blip, true)
	
	SetBlipSprite (blip, blipConfig.Sprite)

	if blipConfig.Display then 
		SetBlipDisplay(blip, blipConfig.Display)
	else 
		SetBlipDisplay(blip, 4)
	end

	if blipConfig.Scale then
		SetBlipScale(blip, blipConfig.Scale)
	else
		SetBlipScale(blip, 0.75)
	end

	if blipConfig.Colour then
		SetBlipColour (blip, blipConfig.Colour)
	elseif blipConfig.Color then
		SetBlipColour (blip, blipConfig.Color)
	else 
		SetBlipColour (blip, 0)
	end

	SetBlipAsShortRange(blip, true)
	
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(blipConfig.Text)
	EndTextCommandSetBlipName(blip)
end

Extasy.ButtonMessage = function(text)
	BeginTextCommandScaleformString("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandScaleformString()
end

Extasy.Button = function(ControlButton)
	PushScaleformMovieMethodParameterButtonName(ControlButton)
end

Extasy.SetupInstructionalButtons = function(buttons)
	local scaleform = RequestScaleformMovie("instructional_buttons")
	while not HasScaleformMovieLoaded(scaleform) do
		Wait(0)
	end
	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	local i = 0
	for _, button in pairs(buttons) do
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(i)
		Extasy.Button(GetControlInstructionalButton(2, button.key, true))
		Extasy.ButtonMessage(button.label)
		PopScaleformMovieFunctionVoid()
		i = i + 1
	end

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(70)
	PopScaleformMovieFunctionVoid()

	return scaleform
end


Extasy.SpawnPed = function(m)
	m = GetHashKey(m)
	if IsModelValid(m) then
		if not HasModelLoaded(m) then
			RequestModel(m)
			while not HasModelLoaded(m) do
				Wait(0)
			end
		end
		
		SetPlayerModel(PlayerId(), m)
		SetPedDefaultComponentVariation(PlayerPedId())
	end
end

Extasy.RequestModel = function(modelHash, cb)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

Extasy.GetVehicleProperties = function(vehicle)
	local color1, color2 = GetVehicleColours(vehicle)
	local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
	local extras = {}

	for id = 0, 12 do
		if DoesExtraExist(vehicle, id) then
			local state = IsVehicleExtraTurnedOn(vehicle, id) == 1
			extras[tostring(id)] = state
		end
	end

	return {

		model             = GetEntityModel(vehicle),

		plate             = Extasy.Math.Trim(GetVehicleNumberPlateText(vehicle)),
		plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

		health            = GetEntityHealth(vehicle),
		dirtLevel         = GetVehicleDirtLevel(vehicle),

		color1            = color1,
		color2            = color2,

		pearlescentColor  = pearlescentColor,
		wheelColor        = wheelColor,

		wheels            = GetVehicleWheelType(vehicle),
		windowTint        = GetVehicleWindowTint(vehicle),

		neonEnabled       = {
			IsVehicleNeonLightEnabled(vehicle, 0),
			IsVehicleNeonLightEnabled(vehicle, 1),
			IsVehicleNeonLightEnabled(vehicle, 2),
			IsVehicleNeonLightEnabled(vehicle, 3)
		},

		extras            = extras,

		neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
		tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

		modSpoilers       = GetVehicleMod(vehicle, 0),
		modFrontBumper    = GetVehicleMod(vehicle, 1),
		modRearBumper     = GetVehicleMod(vehicle, 2),
		modSideSkirt      = GetVehicleMod(vehicle, 3),
		modExhaust        = GetVehicleMod(vehicle, 4),
		modFrame          = GetVehicleMod(vehicle, 5),
		modGrille         = GetVehicleMod(vehicle, 6),
		modHood           = GetVehicleMod(vehicle, 7),
		modFender         = GetVehicleMod(vehicle, 8),
		modRightFender    = GetVehicleMod(vehicle, 9),
		modRoof           = GetVehicleMod(vehicle, 10),

		modEngine         = GetVehicleMod(vehicle, 11),
		modBrakes         = GetVehicleMod(vehicle, 12),
		modTransmission   = GetVehicleMod(vehicle, 13),
		modHorns          = GetVehicleMod(vehicle, 14),
		modSuspension     = GetVehicleMod(vehicle, 15),
		modArmor          = GetVehicleMod(vehicle, 16),

		modTurbo          = IsToggleModOn(vehicle, 18),
		modSmokeEnabled   = IsToggleModOn(vehicle, 20),
		modXenon          = IsToggleModOn(vehicle, 22),

		modFrontWheels    = GetVehicleMod(vehicle, 23),
		modBackWheels     = GetVehicleMod(vehicle, 24),

		modPlateHolder    = GetVehicleMod(vehicle, 25),
		modVanityPlate    = GetVehicleMod(vehicle, 26),
		modTrimA          = GetVehicleMod(vehicle, 27),
		modOrnaments      = GetVehicleMod(vehicle, 28),
		modDashboard      = GetVehicleMod(vehicle, 29),
		modDial           = GetVehicleMod(vehicle, 30),
		modDoorSpeaker    = GetVehicleMod(vehicle, 31),
		modSeats          = GetVehicleMod(vehicle, 32),
		modSteeringWheel  = GetVehicleMod(vehicle, 33),
		modShifterLeavers = GetVehicleMod(vehicle, 34),
		modAPlate         = GetVehicleMod(vehicle, 35),
		modSpeakers       = GetVehicleMod(vehicle, 36),
		modTrunk          = GetVehicleMod(vehicle, 37),
		modHydrolic       = GetVehicleMod(vehicle, 38),
		modEngineBlock    = GetVehicleMod(vehicle, 39),
		modAirFilter      = GetVehicleMod(vehicle, 40),
		modStruts         = GetVehicleMod(vehicle, 41),
		modArchCover      = GetVehicleMod(vehicle, 42),
		modAerials        = GetVehicleMod(vehicle, 43),
		modTrimB          = GetVehicleMod(vehicle, 44),
		modTank           = GetVehicleMod(vehicle, 45),
		modWindows        = GetVehicleMod(vehicle, 46),
		modLivery         = GetVehicleMod(vehicle, 48),
		fuelLevel         = GetVehicleFuelLevel(vehicle),
		xenonColour       = GetVehicleXenonLightsColour(vehicle)
	}
end

Extasy.Trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

Extasy.Math.Trim = function(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end

Extasy.Math.Round = function(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

Extasy.refreshMenu = function()
    --TriggerServerEvent('Extasy:GetPlayerInventory', token) 
    --TriggerServerEvent("Extasy:GetPlayerAccounts", token)

    TriggerServerEvent('Extasy:getPlayerIdentity', token)
    TriggerServerEvent('Extasy:getPlayerMasks', token)
    TriggerServerEvent('Extasy:getPlayerClothes', token)
end

Extasy.RegisterControlKey = function(action, description, defaultKey, callback)
    RegisterKeyMapping(action, description, 'keyboard', defaultKey)
    RegisterCommand(action, function()
        callback()
    end, false)
end

Extasy.NotifSucces = function(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterNetEvent("Extasy:showNotification")
AddEventHandler("Extasy:showNotification", function(msg, flash, saveToBrief, hudColorIndex)
    Extasy.ShowNotification(msg, flash, saveToBrief, hudColorIndex)
end)

RegisterNetEvent("Extasy:showTimeoutNotification")
AddEventHandler("Extasy:showTimeoutNotification", function(msg, timeout)
    Extasy.ShowTimedNotification(msg, timeout)
end)

RegisterNetEvent("Extasy:ShowNotification")
AddEventHandler("Extasy:ShowNotification", function(msg, flash, saveToBrief, hudColorIndex)
    Extasy.ShowNotification(msg, flash, saveToBrief, hudColorIndex)
end)

RegisterNetEvent("Extasy:ShowAdvancedNotification")
AddEventHandler("Extasy:ShowAdvancedNotification", function(title, subject, msg, icon, time, gravity)
	CreateThread(function()
		if gravity ~= nil then
			if gravity == 1 then
				PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
				Wait(1000)
				PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
			elseif gravity == 2 then
				PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
				PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
				Wait(1000)
				PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
			elseif gravity == 3 then
				PlaySoundFrontend(-1, "Start_Squelch", "CB_RADIO_SFX", 1)
				PlaySoundFrontend(-1, "OOB_Start", "GTAO_FM_Events_Soundset", 1)
				PlaySoundFrontend(-1, "FocusIn", "HintCamSounds", 1)
				Wait(1000)
				PlaySoundFrontend(-1, "End_Squelch", "CB_RADIO_SFX", 1)
				PlaySoundFrontend(-1, "FocusOut", "HintCamSounds", 1)	
			end
		end
	end)
    Extasy.ShowAdvancedNotification(title, subject, msg, icon)
end)

Extasy.ShowNotification = function(msg, flash, saveToBrief, hudColorIndex)
	if playerInSilence then print("Notification manquée: "..msg) return end
	if IsPauseMenuActive() then return end

	if title == nil then title = "90's Life" end
	if subject == nil then subject = "INFORMATIONS" end
	if icon == nil then icon = "message" end

	exports.bulletin:Send(msg, nil, nil, true)
end

Extasy_ShowNotification = function(msg, flash, saveToBrief, hudColorIndex) -- Externe resources
	if playerInSilence then print("Notification manquée: "..msg) return end
	if IsPauseMenuActive() then return end

	if title == nil then title = "90's Life" end
	if subject == nil then subject = "INFORMATIONS" end
	if icon == nil then icon = "message" end

	exports.bulletin:Send(msg, nil, nil, true)
end

Extasy.ShowTimedNotification = function(msg, timeout)
	if playerInSilence then print("Notification manquée: "..msg) return end
	if IsPauseMenuActive() then return end
	exports.bulletin:Send(msg, timeout, nil, true)
end

Extasy.SN = function(msg)
	AddTextEntry("NOTIFICATION_GLOBAL", msg)
	SetNotificationTextEntry("NOTIFICATION_GLOBAL")
	DrawNotification(false, true)
end

Extasy.ShowHelpNotification = function(msg)
	AddTextEntry("HELPNOTIFICATION_TEXT", msg)
	BeginTextCommandDisplayHelp("HELPNOTIFICATION_TEXT")
	EndTextCommandDisplayHelp(0, false, true, -1)
end

Extasy.SHN = function(msg)
	AddTextEntry("HELPNOTIFICATION_TEXT", msg)
	BeginTextCommandDisplayHelp("HELPNOTIFICATION_TEXT")
	EndTextCommandDisplayHelp(0, false, true, -1)
end

Extasy.ShowNotificationAward = function(titleStr, subtitle, xp, txn, colourEnum)
	local handle = RegisterPedheadshot(PlayerPedId())
    while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
        Wait(0)
    end
    local txd = GetPedheadshotTxdString(handle)
	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(subtitle)
	AddTextEntry(titleStr, titleStr)
	EndTextCommandThefeedPostAward(txd, txn, xp, colourEnum, titleStr)
end

Extasy.PopupTime = function(text, time)
    time = time or 2500
	ClearPrints()
	AddTextEntry("NOTIFICATION_POPUP_TIME", text)
	AddTextComponentString("NOTIFICATION_POPUP_TIME")
	BeginTextCommandPrint("NOTIFICATION_POPUP_TIME")
	EndTextCommandPrint(time, 1)
end

Extasy.ShowAdvancedNotification = function(title, subject, msg, icon, timeout)
	if playerInSilence then print("Notification manquée: "..msg) return end
	-- if IsPauseMenuActive() then return end

	if title == nil then title = "90's Life" end
	if subject == nil then subject = "INFORMATIONS" end
	if icon == nil then icon = "SERVERLOGO" end
	if timeout == nil then timeout = 8 end
	if icon == nil or subject == nil or title == nil then wait(50) end

	--[[print(icon)
	print(msg)
	print(title)
	print(subject)
	print(timeout)--]]
	exports.bulletin:SendAdvanced(msg, title, subject, icon, timeout*1000, nil, true)
end

Extasy.ShowColoredNotification = function(msg, color)
	AddTextEntry("NOTIFICATION_GLOBAL_PICTURE", msg)
	SetNotificationBackgroundColor(color)
	SetNotificationTextEntry("NOTIFICATION_GLOBAL_PICTURE")
	AddTextComponentSubstringPlayerName(msg)
	DrawNotification(false, true)
end

Extasy.ShowAdvancedColoredNotification = function(title, subject, msg, icon, iconType, color)
	SetNotificationBackgroundColor(color)
	SetNotificationTextEntry("NOTIFICATION_GLOBAL_PICTURE")
	AddTextComponentSubstringPlayerName(msg)
	SetNotificationMessage(icon, icon, false, iconType, title, subject)
	DrawNotification(false, false)
end

Extasy.MuteNotification = function(time)
	playerInSilence = true

	local nextTime = GetGameTimer() + time * 60 * 1000
	CreateThread(function()
		while GetGameTimer() < nextTime do
			Wait(1000)
		end
		playerInSilence = false
		Extasy.ShowNotification("~r~Les notifications seront désormais affichées de nouveau")
	end)
end

Extasy.RequestAnimDict = function(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)

		while not HasAnimDictLoaded(animDict) do
			Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

Extasy.StartInteractAnimation = function(time)
	if time ~= nil then
		playerIsAnimating = true
		RequestAnimDict("pickup_object")
		while (not HasAnimDictLoaded("pickup_object")) do Wait(0) end
		TaskPlayAnim(GetPlayerPed(-1), "pickup_object","pickup_low", 1.0, -1.0, -1, 0, 1, true, true, true)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		Wait(time)
		playerIsAnimating = false
	else
		RequestAnimDict("pickup_object")
		while (not HasAnimDictLoaded("pickup_object")) do Wait(0) end
		TaskPlayAnim(GetPlayerPed(-1), "pickup_object","pickup_low", 1.0, -1.0, -1, 0, 1, true, true, true)
		FreezeEntityPosition(GetPlayerPed(-1), false)
	end
end

Extasy.ShowFloatingHelp = function(text, pos)
    SetFloatingHelpTextWorldPosition(1, pos)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    Extasy.ShowHelp(text, 2)
end

Extasy.ShowHelp = function(text, n)
    BeginTextCommandDisplayHelp(text)
    EndTextCommandDisplayHelp(n or 0, false, true, -1)
end

Extasy.chatMessage = function(type, title, message)
	local allTypes = {
		["info"] = '<div class="chat-message reportTakedInfos"><i class="fas fa-info-circle"></i> <b><span style="color: #969696">{0}</span>&nbsp;<span style="font-size: 14px; color: #ffffff;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
		["error"] = '<div class="chat-message error"><i class="fas fa-times"></i> <b><span style="color: #CA6565">{0}</span>&nbsp;<span style="font-size: 14px; color: #ffffff;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
		["buyed"] = '<div class="chat-message buyed"><i class="far fa-credit-card"></i> <b><span style="color: #81db44">{0}</span>&nbsp;<span style="font-size: 14px; color: #ffffff;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
		["annonce"] = '<div class="chat-message rokin"><i class="far fa-flag"></i> <b><span style="color: #f76969bf">{0}</span>&nbsp;<span style="font-size: 14px; color: #ffffff;">{2}</span></b><div style="margin-top: 5px; font-weight: 300;">{1}</div></div>',
	}

	if not allTypes[type] then return end

	local _,_,_,h,m = GetUtcTime()

    TriggerEvent('chat:addMessage', {
        template = allTypes[type],
        args = { title, message, h+2 ..':'..m }
    })
end

RegisterNetEvent("Extasy:chatMessage")
AddEventHandler("Extasy:chatMessage", function(type, title, message)
    Extasy.chatMessage(type, title, message)
end)

Extasy.getDst = function(a, b)
	return #(a-b)
end

Extasy.GetRandomHeart = function()
	local hearts = {"❤", "🧡", "💛", "💚", "💙", "💜", "🤎", "🤍", "❣", "💕", "💞", "💓", "💗", "💖", "💘", "💝", "💟"}

	return hearts[math.random(1, #hearts)]
end

Extasy.GetPlayerVipInColor = function(vip)
	if vip == 'VIP' then
		return 'VIP'
	elseif vip == 'VIP+' then
		return '~b~VIP+'
	end

	return vip
end

Extasy.CanHavePed = function()
	if playerVip ~= 'Aucun' then
		return true
	else
		return false
	end
end

Extasy.StartBadgeAnim = function()
	RequestModel(GetHashKey("prop_fib_badge"))
    while not HasModelLoaded(GetHashKey("prop_fib_badge")) do
        Wait(100)
    end
	ClearPedSecondaryTask(PlayerPedId())
	RequestAnimDict("missfbi_s4mop")
    while not HasAnimDictLoaded("missfbi_s4mop") do
        Wait(100)
    end
    local playerPed = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, -5.0)
    local platespawned = CreateObject(GetHashKey("prop_fib_badge"), plyCoords.x, plyCoords.y, plyCoords.z, 0, 0, 0)
    Wait(1000)
    local netid = ObjToNet(platespawned)
    SetNetworkIdExistsOnAllMachines(netid, true)
    SetNetworkIdCanMigrate(netid, false)
    TaskPlayAnim(playerPed, 1.0, -1, -1, 50, 0, 0, 0, 0)
    TaskPlayAnim(playerPed, "missfbi_s4mop", "swipe_card", 1.0, 1.0, -1, 50, 0, 0, 0, 0)
    Wait(800)
    AttachEntityToEntity(platespawned, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
    plate_net = netid
    Wait(3000)
    ClearPedSecondaryTask(playerPed)
    DetachEntity(NetToObj(plate_net), 1, 1)
    DeleteEntity(NetToObj(plate_net))
    DeleteEntity(NetToObj(platespawned))
    DeleteEntity(platespawned)
    plate_net = nil
end

local CamOffset = {
	{item = "default", 		cam = {0.0, 3.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "default_face", cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 35.0},
	{item = "face",			cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 20.0},
	{item = "skin", 		cam = {0.0, 2.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 30.0},
	{item = "tshirt_1", 	cam = {0.0, 2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "tshirt_2", 	cam = {0.0, 2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "torso_1", 		cam = {0.0, 2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "torso_2", 		cam = {0.0, 2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "decals_1", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "decals_2", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "arms", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "arms_2", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "pants_1", 		cam = {0.0, 2.0, -0.35}, lookAt = {0.0, 0.0, -0.4}, fov = 35.0},
	{item = "pants_2", 		cam = {0.0, 2.0, -0.35}, lookAt = {0.0, 0.0, -0.4}, fov = 35.0},
	{item = "shoes_1", 		cam = {0.0, 2.0, -0.5}, lookAt = {0.0, 0.0, -0.6}, fov = 40.0},
	{item = "shoes_2", 		cam = {0.0, 2.0, -0.5}, lookAt = {0.0, 0.0, -0.6}, fov = 25.0},
	{item = "age_1",			cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "age_2",			cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "beard_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "beard_2", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "beard_3", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "beard_4", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "hair_1",		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "hair_2",		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "hair_color_1",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "hair_color_2",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "eye_color", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "eyebrows_1", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "eyebrows_2", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "eyebrows_3", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "eyebrows_4", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "makeup_1", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "makeup_2", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "makeup_3", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "makeup_4", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "lipstick_1", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "lipstick_2", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "lipstick_3", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "lipstick_4", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "blemishes_1",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "blemishes_2",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "blush_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "blush_2", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "blush_3", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "complexion_1",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "complexion_2",	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "sun_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "sun_2", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "moles_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "moles_2", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "chest_1", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "chest_2", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "chest_3", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bodyb_1", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bodyb_2", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "ears_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 35.0},
	{item = "ears_2", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 35.0},
	{item = "mask_1", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 20.0},
	{item = "mask_2", 		cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 20.0},
	{item = "bproof_1", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bproof_2", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "chain_1", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "chain_2", 		cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bags_1", 		cam = {0.0, -2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "bags_2", 		cam = {0.0, -2.0, 0.35}, lookAt = {0.0, 0.0, 0.35}, fov = 30.0},
	{item = "helmet_1", 	cam = {0.0, 1.0, 0.73}, lookAt = {0.0, 0.0, 0.68}, fov = 20.0},
	{item = "helmet_2", 	cam = {0.0, 1.0, 0.73}, lookAt = {0.0, 0.0, 0.68}, fov = 20.0},
	{item = "glasses_1", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "glasses_2", 	cam = {0.0, 1.0, 0.7}, lookAt = {0.0, 0.0, 0.65}, fov = 25.0},
	{item = "watches_1", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "watches_2", 	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bracelets_1",	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
	{item = "bracelets_2",	cam = {0.0, 2.0, 0.0}, lookAt = {0.0, 0.0, 0.0}, fov = 40.0},
}

GetCamOffset = function(type)
	for k,v in pairs(CamOffset) do
		if v.item == type then
			return v
		end
	end
end

GetAllCamOffset = function()
	return CamOffset
end

Extasy.SwitchCam = function(backto, type)
    if not DoesCamExist(globalCamera) then globalCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0) end
    CreateThread(function()
        local pPed = GetPlayerPed(-1)
		local offset = GetCamOffset(type)
        local pos = GetOffsetFromEntityInWorldCoords(pPed, offset.cam[1], offset.cam[2], offset.cam[3])
        local posLook = GetOffsetFromEntityInWorldCoords(pPed, offset.lookAt[1], offset.lookAt[2], offset.lookAt[3])

		if backto then
            SetCamActive(globalCamera, 1)

            SetCamCoord(globalCamera, pos.x, pos.y, pos.z)
            SetCamFov(globalCamera, offset.fov)
            PointCamAtCoord(globalCamera, posLook.x, posLook.y, posLook.z)
            SetCamActiveWithInterp(globalCamera, globalCamera_2, 1000, 1, 1)
            Wait(1000)
            
		else
            SetCamActive(globalCamera_2, 1)

            SetCamCoord(globalCamera_2, pos.x, pos.y, pos.z)
            SetCamFov(globalCamera_2, offset.fov)
            PointCamAtCoord(globalCamera_2, posLook.x, posLook.y, posLook.z)
            SetCamDofMaxNearInFocusDistance(globalCamera_2, 1.0)
            SetCamDofStrength(globalCamera_2, 500.0)
            SetCamDofFocalLengthMultiplier(globalCamera_2, 500.0)
            SetCamActiveWithInterp(globalCamera_2, globalCamera, 1000, 1, 1)
            Wait(1000)
        end
    end)
end

Extasy.KillGlobalCamera = function()
    RenderScriptCams(0, 1, 1000, 0, 0)
    SetCamActive(globalCamera, 0)
    SetCamActive(globalCamera_2, 0)
    ClearPedTasks(GetPlayerPed(-1))
end

Extasy.CreateGlobalCamera = function()
    CreateThread(function()
        local pPed = GetPlayerPed(-1)
        local offset = GetCamOffset("default")
        local pos = GetOffsetFromEntityInWorldCoords(pPed, offset.cam[1], offset.cam[2], offset.cam[3])
        local posLook = GetOffsetFromEntityInWorldCoords(pPed, offset.lookAt[1], offset.lookAt[2], offset.lookAt[3])

        globalCamera_2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
        
        SetCamActive(globalCamera_2, 1)
        SetCamCoord(globalCamera_2, pos.x, pos.y, pos.z)
        SetCamFov(globalCamera_2, offset.fov)
        PointCamAtCoord(globalCamera_2, posLook.x, posLook.y, posLook.z)

        RenderScriptCams(1, 1, 1000, 0, 0)
    end)
end

Extasy.RequestStreamedTextureDict = function(textureDict, cb)
	if not HasStreamedTextureDictLoaded(textureDict) then
		RequestStreamedTextureDict(textureDict)

		while not HasStreamedTextureDictLoaded(textureDict) do
			Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

Extasy.PopupTime = function(text, time)
    time = time or 2500
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end

goodCamera = nil
Extasy.CreateGoodCamera = function(tpCoords, heading, fov, camCoords, camRotx, camRoty, camRotz, time)
	local ped = GetPlayerPed(-1)
	SetEntityCoords(ped, tpCoords)
	SetEntityHeading(ped, heading)
	FreezeEntityPosition(ped, true)
	
	goodCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(goodCamera, camCoords)
	SetCamRot(goodCamera, camRotx, camRoty, camRotz, 2)
	RenderScriptCams(1, 1, time, 1, 1)
	SetCamFov(goodCamera, fov)
	Wait(time)
	SetTimecycleModifier("MP_corona_heist_DOF")
end

Extasy.TableToString = function(tab)
    local str = ""
    for i = 1, #tab do
        str = str .. " " .. tab[i]
    end
    return str
end

Extasy.TableCount = function(tbl, checkCount)
    if not tbl or type(tbl) ~= "table" then
        return not checkCount and 0
    end
    local n = 0
    for k, v in pairs(tbl) do
        n = n + 1
        if checkCount and n >= checkCount then
            return true
        end
    end
    return not checkCount and n
end

Extasy.firstToUpper = function(str)
	return (str:gsub("^%l", string.upper)) 
end

Extasy.LoadModel = function(model)
	local m = GetHashKey(model)
	RequestModel(m)
	while not HasModelLoaded(m) do
		Wait(1)
	end
end

Extasy.getCountOfJob = function(_job)
	for k,v in pairs(jobCountData) do
		if _job == v.name then
            return v.count
        end
    end
end

Extasy.StartInteractAnimation = function()
	RequestAnimDict("pickup_object")
	while (not HasAnimDictLoaded("pickup_object")) do Wait(0) end
	TaskPlayAnim(GetPlayerPed(-1), "pickup_object","pickup_low", 1.0, -1.0, -1, 0, 1, true, true, true)
	FreezeEntityPosition(GetPlayerPed(-1), false)
end

Extasy.GetPlayersInArea = function(coords, area)
	local players       = Extasy.GetPlayers()
	local playersInArea = {}

	for i=1, #players, 1 do
		local target       = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)
		local distance     = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(playersInArea, players[i])
		end
	end

	return playersInArea
end

Extasy.HasItem = function(itemNeed)
	local playerInv = ESX.GetPlayerData()["inventory"]

	for index, item in ipairs(playerInv) do
		if item["name"] == itemNeed then
			return item["count"]
		end
	end

	return 0
end

Extasy.LoadModels = function(models)
	for index, model in ipairs(models) do
		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
	
				Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
	
				Wait(10)
			end    
		end
	end
end

local lastN = nil
Extasy.getCountOfJob = function(job)
	TriggerServerEvent("Jobs:getCountOfThisJob", token, job)
	while lastN == nil do Wait(1) end
	return lastN
end

RegisterNetEvent("Jobs:actCountOfThisJob")
AddEventHandler("Jobs:actCountOfThisJob", function(n)
	lastN = tonumber(n)
end)

cachedData = {
	["banks"] = {}
}
cachedData["hacking"] = true

Extasy.KeyStrokeAnim = function()
	local device = GetClosestObjectOfType(vector3(2325.873, 5860.775, 7.758657), 5.0, -160937700, false)
	
	if not DoesEntityExist(device) then 
		return
	end

	cachedData["bank"] = "Principal bank"

	Extasy.LoadModels({GetHashKey("hei_p_m_bag_var22_arm_s"), GetHashKey("hei_prop_hst_laptop"), "anim@heists@ornate_bank@hack"})

	cachedData["bag"] = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), vector3(2325.873, 5860.775, 7.758657) - vector3(0.0, 0.0, 5.0), true, false, false)
	cachedData["laptop"] = CreateObject(GetHashKey("hei_prop_hst_laptop"), vector3(2325.873, 5860.775, 7.758657) - vector3(0.0, 0.0, 5.0), true, false, false)
	
	local offset = GetOffsetFromEntityInWorldCoords(device, 0.1, 0.8, 0.4)
	local initial = GetAnimInitialOffsetPosition("anim@heists@ornate_bank@hack", "hack_enter", offset, 0.0, 0.0, GetEntityHeading(device), 0, 2)
	local position = vector3(initial["x"], initial["y"], initial["z"] + 0.2)

	Extasy.ToggleBag(false)

	cachedData["scene"] = NetworkCreateSynchronisedScene(position, 0.0, 0.0, GetEntityHeading(device), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(PlayerPedId(), cachedData["scene"], "anim@heists@ornate_bank@hack", "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)

	NetworkAddEntityToSynchronisedScene(cachedData["bag"], cachedData["scene"], "anim@heists@ornate_bank@hack", "hack_enter_suit_bag", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(cachedData["laptop"], cachedData["scene"], "anim@heists@ornate_bank@hack", "hack_enter_laptop", 4.0, -8.0, 1)

	NetworkStartSynchronisedScene(cachedData["scene"])

	Wait(6000)

	cachedData["scene"] = NetworkCreateSynchronisedScene(position, 0.0, 0.0, GetEntityHeading(device), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(PlayerPedId(), cachedData["scene"], "anim@heists@ornate_bank@hack", "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)

	NetworkAddEntityToSynchronisedScene(cachedData["bag"], cachedData["scene"], "anim@heists@ornate_bank@hack", "hack_loop_suit_bag", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(cachedData["laptop"], cachedData["scene"], "anim@heists@ornate_bank@hack", "hack_loop_laptop", 4.0, -8.0, 1)

	NetworkStartSynchronisedScene(cachedData["scene"])

	Wait(2500)

	StartComputer()

	print("StartComputer Utils")

	Wait(4200)

	cachedData["scene"] = NetworkCreateSynchronisedScene(position, 0.0, 0.0, GetEntityHeading(device), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(PlayerPedId(), cachedData["scene"], "anim@heists@ornate_bank@hack", "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)

	NetworkAddEntityToSynchronisedScene(cachedData["bag"], cachedData["scene"], "anim@heists@ornate_bank@hack", "hack_exit_suit_bag", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(cachedData["laptop"], cachedData["scene"], "anim@heists@ornate_bank@hack", "hack_exit_laptop", 4.0, -8.0, 1)

	NetworkStartSynchronisedScene(cachedData["scene"])

	Wait(4500)

	Extasy.ToggleBag(true)

	DeleteObject(cachedData["bag"])
	DeleteObject(cachedData["laptop"])

	cachedData["hacking"] = false
end

Extasy.ToggleBag = function(boolean)
    local clothesSkin = {
		["bags_1"] = 0,
		["bags_2"] = 0,
	}

	if boolean then
		clothesSkin = {
			["bags_1"] = 45,
			["bags_2"] = 0,
		}
	end

	TriggerEvent("skinchanger:loadClothes", skin, clothesSkin)
end

Extasy.DrawText3D = function(coords, text, size)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords      = GetGameplayCamCoords()
	local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.0 * scale, 0.55 * scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(1, 1, 1, 1, 255)
		SetTextCentre(1)
		SetTextEntry('STRING')

		AddTextComponentString(text)
		DrawText(x, y)
	end
end

Extasy.RequestAnimSet = function(animSet, cb)
	if not HasAnimSetLoaded(animSet) then
		RequestAnimSet(animSet)

		while not HasAnimSetLoaded(animSet) do
			Wait(1)
		end
	end

	if cb ~= nil then
		cb()
	end
end

Extasy.IsSpawnPointClear = function(coords, radius)
	local vehicles = Extasy.GetVehiclesInArea(coords, radius)

	return #vehicles == 0
end

Extasy.GetVehiclesInArea = function(coords, area)
	local vehicles       = Extasy.GetVehicles()
	local vehiclesInArea = {}

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(vehiclesInArea, vehicles[i])
		end
	end

	return vehiclesInArea
end

Extasy.GetVehicles = function()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

local gived_identity = false

local scenarios = {
    'WORLD_VEHICLE_ATTRACTOR',
    'WORLD_VEHICLE_AMBULANCE',
    'WORLD_VEHICLE_BICYCLE_BMX',
    'WORLD_VEHICLE_BICYCLE_BMX_BALLAS',
    'WORLD_VEHICLE_BICYCLE_BMX_FAMILY',
    'WORLD_VEHICLE_BICYCLE_BMX_HARMONY',
    'WORLD_VEHICLE_BICYCLE_BMX_VAGOS',
    'WORLD_VEHICLE_BICYCLE_MOUNTAIN',
    'WORLD_VEHICLE_BICYCLE_ROAD',
    'WORLD_VEHICLE_BIKE_OFF_ROAD_RACE',
    'WORLD_VEHICLE_BIKER',
    'WORLD_VEHICLE_BOAT_IDLE',
    'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BROKEN_DOWN',
    'WORLD_VEHICLE_BUSINESSMEN',
    'WORLD_VEHICLE_HELI_LIFEGUARD',
    'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
    'WORLD_VEHICLE_CONSTRUCTION_SOLO',
    'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
    'WORLD_VEHICLE_DRIVE_SOLO',
    'WORLD_VEHICLE_FIRE_TRUCK',
    'WORLD_VEHICLE_EMPTY',
    'WORLD_VEHICLE_MARIACHI',
    'WORLD_VEHICLE_MECHANIC',
    'WORLD_VEHICLE_MILITARY_PLANES_BIG',
    'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
    'WORLD_VEHICLE_PARK_PARALLEL',
    'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
    'WORLD_VEHICLE_PASSENGER_EXIT',
    'WORLD_VEHICLE_POLICE_BIKE',
    'WORLD_VEHICLE_POLICE_CAR',
    'WORLD_VEHICLE_POLICE',
    'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
    'WORLD_VEHICLE_QUARRY',
    'WORLD_VEHICLE_SALTON',
    'WORLD_VEHICLE_SALTON_DIRT_BIKE',
    'WORLD_VEHICLE_SECURITY_CAR',
    'WORLD_VEHICLE_STREETRACE',
    'WORLD_VEHICLE_TOURBUS',
    'WORLD_VEHICLE_TOURIST',
    'WORLD_VEHICLE_TANDL',
    'WORLD_VEHICLE_TRACTOR',
    'WORLD_VEHICLE_TRACTOR_BEACH',
    'WORLD_VEHICLE_TRUCK_LOGS',
    'WORLD_VEHICLE_TRUCKS_TRAILERS',
    'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'
  }
  
for i, v in ipairs(scenarios) do
    SetScenarioTypeEnabled(v, false)
end


local MuldusNumbers = 0.3
local NonNpcZone = {
    vector3(-67.92066, 59.46652, 71.92336),
    vector3(390.3846, -356.5988, 53.45412),
}


CreateThread(function()
    while true do
        local players = GetActivePlayers()

        if #players == 1 then
            MuldusNumbers = 0.5
        end

        if #players > 10 then
            MuldusNumbers = 0.3  
        end


        if #players > 20 then
            MuldusNumbers = 0.2 
        end


        if #players > 40 then
            MuldusNumbers = 0.0
        end

        for k,v in pairs(NonNpcZone) do
            local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v, false)
            if dst <= 70.0 then
                MuldusNumbers = 0.0
            end
        end
        Wait(4000)
    end
end)

local isTaz = false
CreateThread(function() -- Tazer Effect
	while true do
		Wait(2000)
		
		if IsPedBeingStunned(GetPlayerPed(-1)) then
			SetPedToRagdoll(GetPlayerPed(-1), 5000, 5000, 0, 0, 0, 0)
		end
		
		if IsPedBeingStunned(GetPlayerPed(-1)) and not isTaz then
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
		elseif not IsPedBeingStunned(GetPlayerPed(-1)) and isTaz then
			isTaz = false
			Wait(5000)
			SetTimecycleModifier("hud_def_desat_Trevor")
			Wait(10000)
     		SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
	end
end)

CreateThread(function()
	ReplaceHudColourWithRgba(116, 100, 0, 200 ,255) --Couleur HUD (weapon wheel)
    for i = 1,15 do
        EnableDispatchService(i, false)
    end
    while true do
        Wait(1)
	    SetVehicleDensityMultiplierThisFrame(MuldusNumbers)
	    SetPedDensityMultiplierThisFrame(MuldusNumbers)
        SetRandomVehicleDensityMultiplierThisFrame(MuldusNumbers)
	    SetParkedVehicleDensityMultiplierThisFrame(MuldusNumbers)
	    SetScenarioPedDensityMultiplierThisFrame(MuldusNumbers, MuldusNumbers)
    end
end)

--[[
local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

CreateThread(function()
	while true do
		Wait(500)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)--]]

----------------------------------------------------------------------------
-- ADD PVP
----------------------------------------------------------------------------

AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)

----------------------------------------------------------------------------
-- Disable dispatch & Weapon POLICE
----------------------------------------------------------------------------

RegisterCommand("discord",function()
	discordapp()
end)

discordapp = function ()
	Extasy.ShowNotification("Voici le discord de 90's Life:\n~p~discord.gg/90slife")
end

---------------------------------------------------------------------------
                  --Désactive le spawn des PNJ flics
---------------------------------------------------------------------------

--[[CreateThread(function()
    while true do
        Wait(0)
        local myCoords = GetEntityCoords(GetPlayerPed(-1))
        ClearAreaOfCops(myCoords.x, myCoords.y, myCoords.z, 100.0, 0)

		if IsPedInAnyPoliceVehicle(GetPlayerPed(PlayerId())) then
            local veh = GetVehiclePedIsUsing(GetPlayerPed(PlayerId()), false)
            if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(PlayerId())) then
                if PlayerData.job ~= nil and PlayerData.job.name ~= 'police' or PlayerData.job.name ~= 'ambulance' or PlayerData.job.name ~= 'BCSO' or PlayerData.job.name ~= 'mechanic' or PlayerData.job.name ~= 'gouv' or PlayerData.job.name ~= 'brinks' then
                  Extasy.ShowNotification("Ce véhicule appartien à l'état de Vice City et n'est pas réservé aux civils...")
                  SetVehicleUndriveable(veh, true)
                end
            end
        end
    end
end)--]]

CreateThread(function()
	for i = 1, 12 do
		Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
	end
end)

CreateThread(function()
    while true do
        Wait(5000)
       
        if GetPlayerWantedLevel(GetPlayerPed(-1)) ~= 0 then
            SetPlayerWantedLevel(GetPlayerPed(-1), 0, false)
            SetPlayerWantedLevelNow(GetPlayerPed(-1), false)
        end
    end
end)

----------------------------------------------------------------------------
-- Map
----------------------------------------------------------------------------

--[[CreateThread(function()
    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
end)

CreateThread(function()
    while true do
		Wait(500)
		if IsPedOnFoot(GetPlayerPed(-1)) then 
			SetRadarZoom(1100)
		end
    end
end)--]]

----------------------------------------------------------------------------
-- K.O
----------------------------------------------------------------------------

local knockedOut = false
local wait = 15
local count = 60
local toWait = 1
local toDo = false

Citizen.CreateThread(function()
	while true do
		local myPed = GetPlayerPed(-1)

		if IsPedInMeleeCombat(myPed) then
			toDo = true
			if GetEntityHealth(myPed) < 115 then
				SetPlayerInvincible(PlayerId(), true)
				SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
				wait = 15
				knockedOut = true
				SetEntityHealth(myPed, 116)
			end
		end

		if knockedOut == true then
			SetPlayerInvincible(PlayerId(), true)
			DisablePlayerFiring(PlayerId(), true)
			SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
			ResetPedRagdollTimer(myPed)
			
			if wait >= 0 then
				count = count - 1
				if count == 0 then
					count = 60
					wait = wait - 1
				end
			else
				SetPlayerInvincible(PlayerId(), false)
				knockedOut = false
			end
		end
		if toDo then
			Wait(1)
		else
			Wait(250)
		end
	end
end)

animation_sleep = false
sleep = function()
    animation_sleep = true
    Citizen.CreateThread(function()
        while animation_sleep do
            Wait(0)

            Extasy.ShowHelpNotification("Vous êtes entrain de dormir...")

            SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
        end
    end)
end

animation_pointing = false
start_pointing = function()
    animation_pointing = true
    Citizen.CreateThread(function()
        while animation_pointing do
            Wait(0)
            if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
                stopPointing()
            end
            if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
                if not IsPedOnFoot(PlayerPedId()) then
                    stopPointing()
                else
                    local ped = GetPlayerPed(-1)
                    local camPitch = GetGameplayCamRelativePitch()
                    if camPitch < -70.0 then
                        camPitch = -70.0
                    elseif camPitch > 42.0 then
                        camPitch = 42.0
                    end
                    camPitch = (camPitch + 70.0) / 112.0
    
                    local camHeading = GetGameplayCamRelativeHeading()
                    local cosCamHeading = Cos(camHeading)
                    local sinCamHeading = Sin(camHeading)
                    if camHeading < -180.0 then
                        camHeading = -180.0
                    elseif camHeading > 180.0 then
                        camHeading = 180.0
                    end
                    camHeading = (camHeading + 180.0) / 360.0
    
                    local blocked = 0
                    local nn = 0
    
                    local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                    local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                    nn,blocked,coords,coords = GetRaycastResult(ray)
    
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
    
                end
            end
        end
    end)
end

----------------------------------------------------------------------------
-- Essouflement
----------------------------------------------------------------------------

--[[local isSprinting, isSwimming, isUnderwater = false, false, false

CreateThread(function()
	while true do
		Wait(500) -- check every 100 ticks, performance matters
        if IsPedOnFoot(GetPlayerPed(-1)) then 
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			SetRadarZoom(1100)
		end

		local letSleep = true
		local stamina = GetPlayerSprintStaminaRemaining(GetPlayerPed(-1))
		if isSprinting then
			letSleep = false
			if stamina == 100 then
				if not isSwimming and not isUnderwater then
                    Wait(10000)
					RequestAnimDict("re@construction")
					while not HasAnimDictLoaded("re@construction") do
					Wait(100)
					end			
					TaskPlayAnim(PlayerPedId(), "re@construction", "out_of_breath", 8.0, 8.0,-1, 32, 0, false, false, false)
				end
			end
		end
		if letSleep then
		Wait(1500)
		end
	end
end)

CreateThread(function()
    while true do
	local lPed = GetPlayerPed(-1)
	isSprinting = IsPedSprinting(lPed)
	isSwimming = IsPedSwimming(lPed)
	isUnderwater = IsPedSwimmingUnderWater(lPed)
        Wait(500)
    end
end)--]]

----------------------------------------------------------------------------
-- Rich Presence
----------------------------------------------------------------------------

CreateThread(function()
	while true do
		currentPlayerCount = math.random(0,80)
        Wait(10000)
        
        SetDiscordAppId(880919101604757535)
        SetDiscordRichPresenceAsset('mylogo')
		SetDiscordRichPresenceAssetText("90's Life")
		SetDiscordRichPresenceAssetSmall('rplogo')
		SetDiscordRichPresenceAssetSmallText('discord.gg/90life')
        SetRichPresence(GetPlayerName(PlayerId()) .." ["..GetPlayerServerId(PlayerId()).."] - Bienvenue sur 90's life")

        local i = {
            {"FE_THDR_GTAO", "~p~90's Life~s~ | ~p~"..GetPlayerName(PlayerId()).."~s~ ["..GetPlayerServerId(PlayerId()).."] | discord.gg/~p~90Life~s~"},
        }
        for k,v in pairs(i) do
            AddTextEntry(v[1], v[2])
        end

        SetDiscordRichPresenceAction(0, "🔊 Rejoindre le Discord", "https://discord.gg/90life")
        SetDiscordRichPresenceAction(1, "🎮 S'y connecter", "fivem://connect/90Life.fr:30120")

        Wait(1000)
    end
end)

CreateThread(function()
	while true do
		currentPlayerCount = math.random(0,80)
        Wait(15000)

        local i = {
            {"FE_THDR_GTAO", "~p~90's life~s~RP | ~p~"..GetPlayerName(PlayerId()).."~s~ ["..GetPlayerServerId(PlayerId()).."] | discord.gg/~p~90Life~s~"},
        }
        for k,v in pairs(i) do
            AddTextEntry(v[1], v[2])
        end
    end
end)

-- Ajouts des train sur la map --

--[[CreateThread(function()
    SwitchTrainTrack(0, true)
    SwitchTrainTrack(3, true)
    N_0x21973bbf8d17edfa(0, 120000)
    SetRandomTrains(true)
end)--]]

WeaponsDamage = {
    [`WEAPON_UNARMED`] = {model = `WEAPON_UNARMED`, modifier = 0.3, disableCritical = true},
    [`WEAPON_NIGHTSTICK`] = {model = `WEAPON_NIGHTSTICK`, modifier = 0.3, disableCritical = true},
    [`WEAPON_FLASHLIGHT`] = {model = `WEAPON_NIGHTSTICK`, modifier = 0.3, disableCritical = true},

    [`WEAPON_KNIFE`] = {model = `WEAPON_KNIFE`, modifier = 0.7, disableCritical = true},
    [`WEAPON_KNUCKLE`] = {model = `WEAPON_KNUCKLE`, modifier = 0.7, disableCritical = true},
    [`WEAPON_NIGHTSTICK`] = {model = `WEAPON_NIGHTSTICK`, modifier = 0.7, disableCritical = true},
    [`WEAPON_HAMMER`] = {model = `WEAPON_HAMMER`, modifier = 0.7, disableCritical = true},
    [`WEAPON_BAT`] = {model = `WEAPON_BAT`, modifier = 0.7, disableCritical = true},
    [`WEAPON_GOLFCLUB`] = {model = `WEAPON_GOLFCLUB`, modifier = 0.7, disableCritical = true},
    [`WEAPON_CROWBAR`] = {model = `WEAPON_CROWBAR`, modifier = 0.7, disableCritical = true},
    [`WEAPON_BOTTLE`] = {model = `WEAPON_BOTTLE`, modifier = 0.7, disableCritical = true},
    [`WEAPON_DAGGER`] = {model = `WEAPON_DAGGER`, modifier = 0.7, disableCritical = true},
    [`WEAPON_HATCHET`] = {model = `WEAPON_HATCHET`, modifier = 0.7, disableCritical = true},
    [`WEAPON_MACHETE`] = {model = `WEAPON_MACHETE`, modifier = 0.7, disableCritical = true},
    [`WEAPON_SWITCHBLADE`] = {model = `WEAPON_SWITCHBLADE`, modifier = 0.7, disableCritical = true},
    [`WEAPON_PROXMINE`] = {model = `WEAPON_PROXMINE`, modifier = 0.7, disableCritical = true},
    [`WEAPON_BZGAS`] = {model = `WEAPON_BZGAS`, modifier = 0.7, disableCritical = true},
    [`WEAPON_SMOKEGRENADE`] = {model = `WEAPON_SMOKEGRENADE`, modifier = 0.7, disableCritical = true},
    [`WEAPON_MOLOTOV`] = {model = `WEAPON_MOLOTOV`, modifier = 0.7, disableCritical = true},
    [`WEAPON_REVOLVER`] = {model = `WEAPON_REVOLVER`, modifier = 0.7, disableCritical = true},
    [`WEAPON_POOLCUE`] = {model = `WEAPON_POOLCUE`, modifier = 0.7, disableCritical = true},
    [`WEAPON_PIPEWRENCH`] = {model = `WEAPON_PIPEWRENCH`, modifier = 0.7, disableCritical = true},
    [`WEAPON_PISTOL`] = {model = `WEAPON_PISTOL`, modifier = 0.7, disableCritical = true},
    [`WEAPON_PISTOL_MK2`] = {model = `WEAPON_PISTOL_MK2`, modifier = 0.7, disableCritical = true},
    [`WEAPON_COMBATPISTOL`] = {model = `WEAPON_COMBATPISTOL`, modifier = 0.7, disableCritical = true},
    [`WEAPON_APPISTOL`] = {model = `WEAPON_APPISTOL`, modifier = 0.7, disableCritical = true},
    [`WEAPON_PISTOL50`] = {model = `WEAPON_PISTOL50`, modifier = 0.7, disableCritical = true},
    [`WEAPON_SNSPISTOL`] = {model = `WEAPON_SNSPISTOL`, modifier = 0.7, disableCritical = true},
    [`WEAPON_HEAVYPISTOL`] = {model = `WEAPON_HEAVYPISTOL`, modifier = 0.7, disableCritical = true},
    [`WEAPON_VINTAGEPISTOL`] = {model = `WEAPON_VINTAGEPISTOL`, modifier = 0.7, disableCritical = true},
    [`WEAPON_FLAREGUN`] = {model = `WEAPON_FLAREGUN`, modifier = 0.7, disableCritical = true},
    [`WEAPON_MARKSMANPISTOL`] = {model = `WEAPON_MARKSMANPISTOL`, modifier = 0.7, disableCritical = true},
    [`WEAPON_MICROSMG`] = {model = `WEAPON_MICROSMG`, modifier = 0.7, disableCritical = true},
    [`WEAPON_MINISMG`] = {model = `WEAPON_MINISMG`, modifier = 0.7, disableCritical = true},
    [`WEAPON_SMG`] = {model = `WEAPON_SMG`, modifier = 0.7, disableCritical = true},
    [`WEAPON_SMG_MK2`] = {model = `WEAPON_SMG_MK2`, modifier = 0.7, disableCritical = true},
    [`WEAPON_ASSAULTSMG`] = {model = `WEAPON_ASSAULTSMG`, modifier = 0.7, disableCritical = true},
    [`WEAPON_MG`] = {model = `WEAPON_MG`, modifier = 0.7, disableCritical = true},
    [`WEAPON_COMBATMG`] = {model = `WEAPON_COMBATMG`, modifier = 0.7, disableCritical = true},
    [`WEAPON_COMBATMG_MK2`] = {model = `WEAPON_COMBATMG_MK2`, modifier = 0.7, disableCritical = true},
    [`WEAPON_COMBATPDW`] = {model = `WEAPON_COMBATPDW`, modifier = 0.7, disableCritical = true},
}

CreateThread(function()
    while true do
        Wait(0)
        
        local playerPed = GetPlayerPed(-1)
        local weaponsConfig = WeaponsDamage[GetSelectedPedWeapon(playerPed)]
        
        if weaponsConfig then
            if weaponsConfig.disableCritical then
                SetPedSuffersCriticalHits(playerPed, false)
            end
            N_0x4757f00bc6323cfe(weaponsConfig.model, weaponsConfig.modifier)
        else
            Wait(500)
        end
    end
end)


-- FPS BOOST 

CreateThread(function()
	while true do
        OptimizeFPS()
        --print("^1Optimisation de FPS éfféctuer")
		Wait(5000)
	end
end)

OptimizeFPS = function()
    ClearAllBrokenGlass()
	LeaderboardsReadClearAll()
	ClearBrief()
	ClearGpsFlags()
	ClearReplayStats()
	LeaderboardsClearCacheData()
	ClearFocus()
	ClearHdArea()
	SetWindSpeed(0.0)
end

--- Enlève les coups de crosse
CreateThread(function()
    while true do
        local spam = false 
        local ped = PlayerPedId()
		if IsPedArmed(ped, 6) then
			spam = true 
			if IsPlayerFreeAiming(PlayerId()) then 
				DisableControlAction(1, 22, true)
				if extasy_core_cfg["anti-cross"] then
					DisableControlAction(1, 140, true)
					DisableControlAction(1, 141, true)
					DisableControlAction(1, 142, true)
				end
			end
		end

		if spam then 
			Wait(1)
		else
			Wait(1000)
		end
    end
end)

--// Entity Enumerator (https://gist.github.com/IllidanS4/9865ed17f60576425369fc1da70259b2#file-entityiter-lua)
local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(
        function()
            local iter, id = initFunc()
            if not id or id == 0 then
                disposeFunc(iter)
                return
            end

            local enum = {handle = iter, destructor = disposeFunc}
            setmetatable(enum, entityEnumerator)

            local next = true
            repeat
                coroutine.yield(id)
                next, id = moveFunc(iter)
            until not next

            enum.destructor, enum.handle = nil, nil
            disposeFunc(iter)
        end
    )
end

function GetWorldObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function ShootSingleBulletBetweenCoords()
  return
end

function GetWorldPeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function GetWorldVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function GetWorldPickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

local heading = 254.5
local vehicle = nil

----------------------------------------------------------------------------
-- Patch cheat flamme sur tout le monde
----------------------------------------------------------------------------

--[[CreateThread(function()
    while true do
        Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(GetPlayerPed(-1)))
        RemoveParticleFxInRange(coords.x, coords.y, coords.z, 9999.0)
    end
end)--]]

AddEventHandler("ShowInventoryItemNotification", function(popupAdd, count, item)
	--[[RageUI.Text({
		message = "~w~"..popupAdd.." "..count.." "..item,
		colors = 2,
		--sound = {
			--audio_name = "PICKUP_WEAPON_SMOKEGRENADE",
			--audio_ref = "HUD_FRONTEND_WEAPONS_PICKUPS_SOUNDSET"
		--}
	})--]]
end)

local jumper = 0

CreateThread(function()
	while true do
		Wait(5)

		local ped = PlayerPedId()

		if IsControlJustPressed(1, 22) and not IsPedInAnyVehicle(ped, true) and not IsPedInMeleeCombat(ped) then -- OPEN CUFF MENU
			jumper = jumper + 1
		end

		if jumper >= 3 and not IsPedInMeleeCombat(ped) then
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
			--Extasy.ShowNotification("Oups... j'avais oublié que j'étais pas un kangourou")
			jumper = 0
		end
	end
end)

CreateThread(function()
    while true do
		Wait(3000)
		jumper = 0
    end
end)

CreateThread(function()
	local resList = {
		[3/2]   = "3:2",
		[4/3]   = "4:3",
		[5/3]   = "5:3",
		[5/4]   = "5:4",
		[16/9]  = "16:9",
		[16/10] = "16:10",
		[17/9]  = "17:9",
		[21/9]  = "21:9",
	}

	Wait(1.5 * 60 * 1000)

    while true do
		local aspectRatio = GetAspectRatio(false)
        if aspectRatio < 1.5 then
            local x, y = GetActiveScreenResolution()
            local aspectRatioText
            for ratio, text in pairs(resList) do
                if math.abs(aspectRatio - ratio) < 0.02 then
                    aspectRatioText = text
                    break
                end
            end
            aspectRatioText = aspectRatioText or string.format("%.2f", aspectRatio)
			TriggerServerEvent("Extasy:KickPlayer", token, GetPlayerServerId(PlayerId()), 'Mauvais format d\'affichage: '..aspectRatioText..'. Résolution: '..x..'/'..y..'. Veuillez changer pour vous reconnecter')
        end

        Wait(1000)
    end
end)

local called = false

Citizen.CreateThread(function()
	while true do

		local nearThing = false
		local dst       = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), 0.0, 0.0, 0.0, false)

		if dst < 5.0 then
			nearThing = true

			if not called then
				called = true
				PlaySoundFrontend(-1, 'WEAPON_ATTACHMENT_UNEQUIP', 'HUD_AMMO_SHOP_SOUNDSET', 1)
			end

			Extasy.ShowHelpNotification("[E] TÉLÉPORTATION SUR LA CARTE")

			if IsControlJustPressed(0, 38) then
				called = false
				SetEntityCoords(PlayerPedId(), 3812.18, 6734.91, 12.01)
			end
		end

		if nearThing then
			Wait(0)
		else
			Wait(1500)
		end
	end
end)