Utils = Utils or {}

Player = {}
Player.Vehicle = 0
Player.Ped = 0
Player.InVehicle = false
Player.Dead = false
Player.KO = false
Player.Pos = vector3(0.0, 0.0, 0.0)
Player.Heading = 0.0
Player.Zone = ""
Player.Invincible = false
Player.IsCuffed = false
Player.Health = 0
Player.Armor = 0
Player.Visible = true
Player.Freeze = false
Player.IsAdmin = false
Player.IsArmed = false
Player.IsShooting = false
Player.ZoneGlobal = "LS"
Player.CountPlayers = 0
Player.Job = "unemployed"
Player.Grade = 0

Player.Stress = 0
Player.Health = 0
Player.Armor = 0
Player.Water = 0
Player.Hunger = 0
Player.Drunk = 0

Player.stamina = 0
Player.shooting = 0
Player.strength = 0
Player.stealth = 0
Player.flying = 0
Player.driving = 0
Player.lung = 0
Player.mental = 0

Player.Orga = {}
Player.Orga.Name = nil
Player.Orga.Data = {}

Player.Service = false
Player.InInstance = false
Player.Name = "Prénom"
Player.LastName = "Nom"

Player.CopsConnected = 0 
Player.EmsConnected = 0 
Player.HayesConnected = 0

function GetPlayer()
    return Player
end

Citizen.CreateThread(function()
    while true do
        Player.Ped = PlayerPedId()
        Player.InVehicle = IsPedInAnyVehicle(Player.Ped)
        Player.GetVehicle = GetVehiclePedIsIn(Player.Ped, false)
        Player.IsDriver = GetPedInVehicleSeat(GetVehiclePedIsIn(Player.Ped, false), -1) == Player.Ped
        Player.Zone = GetNameOfZone(Player.Pos)
        Player.IsArmed = IsPedArmed(Player.Ped, 5)
        Player.IsCuffed = IsPedCuffed(Player.Ped)
        Player.ZoneGlobal = GetZonesFromPlayer(Player)

        Player.Service  = Player.Service 
        Player.Health = GetEntityHealth(Player.Ped)
        Player.Armor = GetPedArmour(Player.Ped)

        --StatSetInt(GetHashKey("MP0_PLAYER_MENTAL_STATE"), round(Player.Stress), true)
        Citizen.Wait(1000)
    end
end)

-- Cache du joueur
function SetFieldValueFromNameEncode(stringName, data) -- Save dans le cache
	SetResourceKvp(stringName, json.encode(data))
end

function GetFieldValueFromName(stringName) -- Get dans le cache
	local data = GetResourceKvpString(stringName)
	return data and json.decode(data) or {}
end

function GetFieldValueFromNameEncoded(stringName) -- Get dans le cache
	local data = GetResourceKvpString(stringName)
	return data or {}
end


-- Téléportations
function TeleportTopCoords(pos, ent, trustPos) -- TP Un joueur (Sans bug de collision)
	if not pos or not pos.x or not pos.y or not pos.z or (ent and not DoesEntityExist(ent)) then return true end
	local x, y, z = pos.x, pos.y, pos.z + 1.0
	ent = ent or GetPlayerPed(-1)

	RequestCollisionAtCoord(x, y, z)
	NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)

	local tempTimer = GetGameTimer()
	while not IsNewLoadSceneLoaded() do
		if GetGameTimer() - tempTimer > 3000 then
			break
		end

		Citizen.Wait(0)
	end

	SetEntityCoordsNoOffset(ent, x, y, z)

	tempTimer = GetGameTimer()
	while not HasCollisionLoadedAroundEntity(ent) do
		if GetGameTimer() - tempTimer > 3000 then
			break
		end

		Citizen.Wait(0)
	end

	local foundNewZ, newZ
	if not trustPos then
		foundNewZ, newZ = GetGroundZCoordWithOffsets(x, y, z)
		tempTimer = GetGameTimer()
		while not foundNewZ do
			z = z + 10.0
			foundNewZ, newZ = GetGroundZCoordWithOffsets(x, y, z)
			Wait(0)

			if GetGameTimer() - tempTimer > 2000 then
				break
			end
		end
	end

	Utils.LastCoords = vector3(x, y, foundNewZ and newZ or z)
	SetEntityCoordsNoOffset(ent, x, y, foundNewZ and newZ or z)
	NewLoadSceneStop()

	if type(pos) ~= "vector3" and pos.a then SetEntityHeading(ent, pos.a) end
	return true
end

local done
function GoPlayerToPos(pos, ent) -- TP Un joueur (Sans bug de collision) avec Cinématique
	Utils.LastCoords = pos
	done = true
	DoScreenFadeOut(100)
	Citizen.Wait(100)
	done = TeleportTopCoords(pos, ent)
	while not done do
		Citizen.Wait(0)
	end
	DoScreenFadeIn(100)
end


-- Player infos
function IsPedMale(ped) -- Si le joueur est un Homme
    return IsPedModel(ped or PlayerPedId(), GetHashKey("mp_m_freemode_01"))
end

function IsPedPeds(ped) -- Si le joueur est un Homme
    local pPed = ped or PlayerPedId()
    if IsPedModel(pPed, GetHashKey("mp_m_freemode_01")) then 
        return true 
    elseif IsPedModel(pPed, GetHashKey("mp_f_freemode_01")) then 
        return false 
    else
        return "ped"
    end
end

function IsBehindPed(ped) -- Si le joueur est devant toi (si tu est derrière celui-ci)
    return not HasEntityClearLosToEntityInFront(ped, GetPlayer().Ped)
end

function RandPickupAnim() -- Anim Inv (Bras)
	local pPed = PlayerPedId()
	RequestAndWaitDict('pickup_object')
    TaskPlayAnim(pPed, 'pickup_object', 'putdown_low', 5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
    Wait(1000)
    ClearPedSecondaryTask(pPed)
end

RegisterNetEvent('rCore:RandPickupAnim')
AddEventHandler('rCore:RandPickupAnim', function()
    RandPickupAnim()
end)


-- Server Player
TriggerPlayerEvent = function(name, source, r, a, b, c, d) -- Trigger Player Event
    Rsv("rCore:PlayerEvent", name, source, r, a, b, c, d)
end

function Rsv(name, ...)
	TriggerServerEvent(name, ...)
end


-- Get Des entités
local GetActivePlayers = GetActivePlayers
local GetPlayerPed = GetPlayerPed
local GetEntityCoords = GetEntityCoords
local GetEntityForwardVector = GetEntityForwardVector
local IsEntityVisible = IsEntityVisible
local HasAnimDictLoaded = HasAnimDictLoaded

function GetPlayers() -- Get Les joueurs
	local players = {}

	for _,player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)

		if DoesEntityExist(ped) then
			table.insert(players, player)
		end
	end

	return players
end

function GetVehicles() -- Get tous les véhicules
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

local max = 1.5
function GetClosestPly(distance, addVector) -- Get un joueur proche suivant la distance demandé
	local pPed, closestPlayer = GetPlayerPed(-1)
	local pPos, playerForward = GetEntityCoords(pPed), GetEntityForwardVector(pPed)
	pPos = pPos + (addVector or playerForward * 0.5)

	for _,v in pairs(GetPlayers()) do
		local otherPed = GetPlayerPed(v)
		local otherPedPos = otherPed ~= ped and IsEntityVisible(otherPed) and GetEntityCoords(otherPed)

		if otherPedPos and GetDistanceBetweenCoords(otherPedPos, pPos) <= (distance or max) and (not closestPlayer or GetDistanceBetweenCoords(otherPedPos, pPos)) then
			closestPlayer = v
		end
	end

	return closestPlayer
end

function GetClosestVehicle2(vector, radius, modelHash, testFunction) -- Get un véhicule par radius
	if not vector or not radius then return end
	local handle, veh = FindFirstVehicle()
	local success, theVeh
	repeat
		local firstDist = GetDistanceBetweenCoords(GetEntityCoords(veh), vector.x, vector.y, vector.z, true)
		if firstDist < radius and (not modelHash or modelHash == GetEntityModel(veh)) and (not theVeh or firstDist < GetDistanceBetweenCoords(GetEntityCoords(theVeh), GetEntityCoords(veh), true)) and (not testFunction or testFunction(veh)) then
			theVeh = veh
		end
		success, veh = FindNextVehicle(handle)
	until not success
		EndFindVehicle(handle)
	return theVeh
end

function GetClosestObject(vector, radius, modelHash, testFunction) -- Get un objet par radius
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

function GetClosestPlayerPed(coords) -- Get Un Peds (player)
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local coords = coords
	local usePlayerPed = false
	local playerPed = PlayerPedId()
	local playerId = PlayerId()

	if coords == nil then
		usePlayerPed = true
		coords = GetEntityCoords(playerPed)
	end

	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
			local targetCoords = GetEntityCoords(target)
			local distance = GetDistanceBetweenCoords(targetCoords, coords.x, coords.y, coords.z, true)

			if closestDistance == -1 or closestDistance > distance then
				closestPlayer = players[i]
				closestDistance = distance
			end
		end
	end

	return closestPlayer, closestDistance
end

local max = 1.5
function GetClosestPlayer(istance, addVector) -- Get Closest palyer
	local ped, closestPlayer = GetPlayerPed(-1)
    local id = -1
    local cPed = nil
	local playerPos, playerForward = GetEntityCoords(ped), GetEntityForwardVector(ped)
	playerPos = playerPos + (addVector or playerForward * 0.5)

	for _,v in pairs(GetPlayers()) do
		local otherPed = GetPlayerPed(v)
		local otherPedPos = otherPed ~= ped and IsEntityVisible(otherPed) and GetEntityCoords(otherPed)

		if otherPedPos and GetDistanceBetweenCoords(otherPedPos, playerPos) <= (distance or max) and (not closestPlayer or GetDistanceBetweenCoords(otherPedPos, playerPos)) then
			closestPlayer = v
            cPed = GetPlayerPed(v)
		end
	end

	return closestPlayer, cPed
end

function GetNearbyPlayers(distance) -- Get des joueurs dans la zone
	local ped = GetPlayerPed(-1)
	local playerPos = GetEntityCoords(ped)
	local nearbyPlayers = {}

	for _,v in pairs(GetPlayers()) do
		local otherPed = GetPlayerPed(v)
		local otherPedPos = otherPed ~= ped and IsEntityVisible(otherPed) and GetEntityCoords(otherPed)

		if otherPedPos and GetDistanceBetweenCoords(otherPedPos, playerPos) <= (distance or max) then
			nearbyPlayers[#nearbyPlayers + 1] = v
		end
	end
	return nearbyPlayers
end

local cWait = false;
local xWait = false

function GetNearbyPlayer(solo, other) -- Sélectionner un joueur si plusieurs sont collé à vous
    
    if cWait then
        xWait = true
        while cWait do
            Citizen.Wait(5)
        end
    end

    xWait = false
    local cTimer = GetGameTimer() + 10000;
    local oPlayer = GetNearbyPlayers(2)

    if solo then
        oPlayer[#oPlayer + 1] = PlayerId()
    end

    if #oPlayer == 0 then
        InventoryShowNotification("~r~Action Impossible~s~Personne autour de vous..")
        return false
    end

    if #oPlayer == 1 and other then
        return oPlayer[1]
    end

    TriggerEvent("esx_inventoryhud:closeinventory")

    InventoryShowNotification("Appuyer sur ~g~E~s~ pour valider~n~Appuyer sur ~b~A~s~ pour changer de cible~n~Appuyer sur ~r~X~s~ pour annuler")
    Citizen.Wait(100)
    local cBase = 1
    cWait = true
    while GetGameTimer() <= cTimer and not xWait do
        Citizen.Wait(0)
        DisableControlAction(0, 38, true)
        DisableControlAction(0, 73, true)
        DisableControlAction(0, 44, true)
        if IsDisabledControlJustPressed(0, 38) then
            cWait = false
            return oPlayer[cBase]
        elseif IsDisabledControlJustPressed(0, 73) then
            InventoryShowNotification("Vous avez ~r~annulé~s~ cette ~r~action~s~")
            break
        elseif IsDisabledControlJustPressed(0, 44) then
            cBase = (cBase == #oPlayer) and 1 or (cBase + 1)
        end
        local cPed = GetPlayerPed(oPlayer[cBase])
        local cCoords = GetEntityCoords(cPed)
        DrawMarker(0, cCoords.x, cCoords.y, cCoords.z + 1.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.1, 0.1, 0.1, 0, 180, 10, 30, 1, 1, 0, 0, 0, 0, 0)
    end
    cWait = false
    return false
end

function GetClosestPed2(vector, radius, modelHash, testFunction) -- Get un ped par radius
	if not vector or not radius then return end
	local handle, myped, veh = FindFirstPed(), GetPlayerPed(-1)
	local success, theVeh
	repeat
		local firstDist = GetDistanceBetweenCoords(GetEntityCoords(veh), vector.x, vector.y, vector.z)
		if firstDist < radius and veh ~= myped and (not modelHash or modelHash == GetEntityModel(veh)) and (not theVeh or firstDist < GetDistanceBetweenCoords(GetEntityCoords(theVeh), GetEntityCoords(veh))) and (not testFunction or testFunction(veh)) then
			theVeh = veh
		end
		success, veh = FindNextPed(handle)
	until not success
		EndFindPed(handle)
	return theVeh
end

-- Table
function TableGetValue(tbl, value, k) -- Si une table a une value précise
	if not tbl or not value or type(tbl) ~= "table" then return end
	for _,v in pairs(tbl) do
		if k and v[k] == value or v == value then return true, _ end
	end
end


-- Request
function RequestAndWaitModel(modelName) -- Request un modèle de véhicule
	if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
		RequestModel(modelName)
		while not HasModelLoaded(modelName) do Citizen.Wait(100) end
	end
end
function RequestAndWaitDict(dictName) -- Request une animation (dict)
	if dictName and DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
		RequestAnimDict(dictName)
		while not HasAnimDictLoaded(dictName) do Citizen.Wait(100) end
	end
end
function RequestAndWaitSet(setName) -- Request une démarche
	if setName and not HasAnimSetLoaded(setName) then
		RequestAnimSet(setName)
		while not HasAnimSetLoaded(setName) do Citizen.Wait(100) end
	end
end

-- Animations
function TaskAnim(animName, time, flag, ped, customPos) -- Faire jouer une anim a un ped (joueur)
	if type(animName) ~= "table" then animName = {animName} end
	ped, flag = ped or GetPlayerPed(-1), flag and tonumber(flag) or false

	if not animName or not animName[1] or string.len(animName[1]) < 1 then return end
    if IsEntityPlayingAnim(ped, animName[1], animName[2], 3) or IsPedActiveInScenario(ped) then ClearPedTasks(ped) 
        return end

	Citizen.CreateThread(function()
		TaskAnimForce(animName, flag, { ped = ped, time = time, pos = customPos })
	end)
end

function TaskSynchronizedTasks(ped, animData, clearTasks)
	for _,v in pairs(animData) do
		if not HasAnimDictLoaded(v.anim[1]) then
			RequestAnimDict(v.anim[1])
			while not HasAnimDictLoaded(v.anim[1]) do Citizen.Wait(0) end
		end
	end

	local _, sequence = OpenSequenceTask(0)
	for _,v in pairs(animData) do
		TaskPlayAnim(0, v.anim[1], v.anim[2], 2.0, -2.0, math.floor(v.time or -1), v.flag or 48, 0, 0, 0, 0)
	end

	CloseSequenceTask(sequence)
	if clearTasks then ClearPedTasks(ped) end
	TaskPerformSequence(ped, sequence)
	ClearSequenceTask(sequence)

	for _,v in pairs(animData) do
		RemoveAnimDict(v.anim[1])
	end

	return sequence
end

local AnimBlacklist = {"WORLD_HUMAN_MUSICIAN", "WORLD_HUMAN_CLIPBOARD"}
local AnimFemale = {
	["WORLD_HUMAN_BUM_WASH"] = {"amb@world_human_bum_wash@male@high@idle_a", "idle_a"},
	["WORLD_HUMAN_SIT_UPS"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a"},
	["WORLD_HUMAN_PUSH_UPS"] = {"amb@world_human_push_ups@male@base", "base"},
	["WORLD_HUMAN_BUM_FREEWAY"] = {"amb@world_human_bum_freeway@male@base", "base"},
	["WORLD_HUMAN_CLIPBOARD"] = {"amb@world_human_clipboard@male@base", "base"},
	["WORLD_HUMAN_VEHICLE_MECHANIC"] = {"amb@world_human_vehicle_mechanic@male@base", "base"},
}

function TaskAnimForce(animName, flag, args) -- Faire forcer une anim a un ped (joueur)
	flag, args = flag and tonumber(flag) or false, args or {}
	local ped, time, clearTasks, animPos, animRot, animTime = args.ped or GetPlayerPed(-1), args.time, args.clearTasks, args.pos, args.ang

	if IsPedInAnyVehicle(ped) and (not flag or flag < 40) then return end

	if not clearTasks then ClearPedTasks(ped) end

	if not animName[2] and AnimFemale[animName[1]] and GetEntityModel(ped) == -1667301416 then
		animName = AnimFemale[animName[1]]
	end

	if animName[2] and not HasAnimDictLoaded(animName[1]) then
		if not DoesAnimDictExist(animName[1]) then return end
		RequestAnimDict(animName[1])
		while not HasAnimDictLoaded(animName[1]) do
			Citizen.Wait(10)
		end
	end

	if not animName[2] then
		ClearAreaOfObjects(GetEntityCoords(ped), 1.0)
		TaskStartScenarioInPlace(ped, animName[1], -1, not TableGetValue(AnimBlacklist, animName[1]))
	else
        if not animPos then
            TaskPlayAnim(ped, animName[1], animName[2], 8.0, -8.0, -1, flag or 44, 1, 0, 0, 0, 0)
		else
			TaskPlayAnimAdvanced(ped, animName[1], animName[2], animPos.x, animPos.y, animPos.z, animRot.x, animRot.y, animRot.z, 8.0, -8.0, -1, 1, 1, 0, 0, 0)
		end
	end

	if time and type(time) == "number" then
		Citizen.Wait(time)
		ClearPedTasks(ped)
	end

	if not args.dict then RemoveAnimDict(animName[1]) end
end

-- Objects player
function AttachObjectToHandsPeds(ped, hash, timer, rot, bone, dynamic) -- Attach un props sur la main d'un ped
    if props and DoesEntityExist(props)then 
        DeleteEntity(props)
    end
    props = CreateObject(GetHashKey(hash), GetEntityCoords(ped), not dynamic)
    AttachEntityToEntity(props, ped, GetPedBoneIndex(ped, bone and 60309 or 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, not rot)
    if timer then 
        Citizen.Wait(timer)
        if props and DoesEntityExist(props)then 
            DeleteEntity(props)
        end
    	ClearPedTasks(ped)
    end
    return props
end

-- Focus + Key

function RegisterControlKey(strKeyName, strDescription, strKey, cbPress, cbRelease) -- Bind une touche pour une action
    RegisterKeyMapping("+" .. strKeyName, strDescription, "keyboard", strKey)

	RegisterCommand("+" .. strKeyName, function()
		if not cbPress or UpdateOnscreenKeyboard() == 0 then 
			return 
		end
        cbPress()
    end, false)

    RegisterCommand("-" .. strKeyName, function()
		if not cbRelease or UpdateOnscreenKeyboard() == 0 then 
			return 
		end
        cbRelease()
    end, false)
end

local KeepFocus = false
local Thread = false
local ControlDisable = {1, 2, 3, 4, 5, 6, 18, 24, 25, 37, 68, 69, 70, 91, 92, 142, 182, 199, 200, 245, 257}

function SetKeepInputMode(bool) -- Pouvoir marcher dans un focus
	if SetNuiFocusKeepInput then
		SetNuiFocusKeepInput(bool)
	end

	KeepFocus = bool

	if not Thread and bool then
		Thread = true

		Citizen.CreateThread(function()
			while KeepFocus do
				Wait(0)

				for _,v in pairs(ControlDisable) do
					DisableControlAction(0, v, true)
				end
			end

			Thread = false
		end)
	end
end

-- Progres bars

local HaveProgress
function ProgressBarExists() -- Si une barre de progression existe
    return HaveProgress 
end

local petitpoint = {".","..","...",""}
function ProgressBar(Text, r, g, b, a, Timing, NoTiming) -- Créer une progress bar
    if not Timing then 
        return 
    end
    RemoveProgressBar()
    HaveProgress = true
    Citizen.CreateThread(function()
        local Timing1, Timing2 = .0, GetGameTimer() + Timing
        local E, Timing3 = ""
        while HaveProgress and (not NoTiming and Timing1 < 1) do
            Citizen.Wait(0)
            if not NoTiming or Timing1 < 1 then 
                Timing1 = 1-((Timing2 - GetGameTimer())/Timing)
            end
            if not Timing3 or GetGameTimer() >= Timing3 then
                Timing3 = GetGameTimer()+500;
                E = petitpoint[string.len(E)+1] or ""
            end;
            DrawRect(.5,.875,.15,.03,0,0,0,100)
            local y, endroit=.15-.0025,.03-.005;
            local chance = math.max(0,math.min(y,y*Timing1))
            DrawRect((.5-y/2)+chance/2,.875,chance,endroit,r,g,b,a) -- 0,155,255,125
            DrawTextScreen(.5,.875-.0125,.3,(Text or"Action en cours")..E,0,0,false)
        end;
        RemoveProgressBar()
    end)
end

function RemoveProgressBar() -- Delete les progress bar
    HaveProgress = nil 
end


-- Effects
function CreateEffect(style, default, time) -- Créer un effet
    Citizen.CreateThread(function()
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        SetTimecycleModifier(style or "spectator3")
        if default then 
            SetCamEffect(2)
        end
        DoScreenFadeIn(1000)
        Citizen.Wait(time or 20000)
        local pPed = GetPlayerPed(-1)
        DoScreenFadeOut(1000)
        Citizen.Wait(1000)
        DoScreenFadeIn(1000)
        ClearTimecycleModifier()
        ResetScenarioTypesEnabled()
        SetPedIsDrunk(pPed,false)
		SetCamEffect(0)
    end)
end

-- Scalforms
function SetScaleformParams(scaleform, data) -- Set des éléments dans un scalform
	data = data or {}
	for k,v in pairs(data) do
		PushScaleformMovieFunction(scaleform, v.name)
		if v.param then
			for _,par in pairs(v.param) do
				if math.type(par) == "integer" then
					PushScaleformMovieFunctionParameterInt(par)
				elseif type(par) == "boolean" then
					PushScaleformMovieFunctionParameterBool(par)
				elseif math.type(par) == "float" then
					PushScaleformMovieFunctionParameterFloat(par)
				elseif type(par) == "string" then
					PushScaleformMovieFunctionParameterString(par)
				end
			end
		end
		if v.func then v.func() end
		PopScaleformMovieFunctionVoid()
	end
end
function CreateScaleform(name, data) -- Créer un scalform
	if not name or string.len(name) <= 0 then return end
	local scaleform = RequestScaleformMovie(name)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end

	SetScaleformParams(scaleform, data)
	return scaleform
end
function Instructions(instructions, cam) -- Mettre une instruction (scalform)
    local scaleform = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
    while not HasScaleformMovieLoaded(scaleform) do Citizen.Wait(1) end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

	local counter = 0
    for _, instruction in pairs(instructions) do
		PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
		PushScaleformMovieFunctionParameterInt(counter)
        PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(2, instruction.key, true))
        BeginTextCommandScaleformString("STRING")
        AddTextComponentScaleform(instruction.message)
        EndTextCommandScaleformString()
		PopScaleformMovieFunctionVoid()
		counter = counter + 1
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

Scalform = Scalform or {}
function Scalform:CreateVehicleStatsScaleformLsCustoms(cars)
    local VehicleModel = GetEntityModel(cars)
    local VehicleSpeed = GetVehicleEstimatedMaxSpeed(cars) * 1.25
    local VehicleAcceleration = GetVehicleAcceleration(cars) * 200
    local VehicleBraking = GetVehicleMaxBraking(cars) * 100
    local VehicleTraction = GetVehicleMaxTraction(cars) * 25
    local VehicleHealth = GetVehicleHealth(cars)
    return CreateScaleform("mp_car_stats_01", {{
        name = "SET_VEHICLE_INFOR_AND_STATS",
        param = {GetLabelText(GetDisplayNameFromVehicleModel(VehicleModel)), "État du véhicule: "..VehicleHealth.."%", "MPCarHUD","Annis", "Vitesse max", "Accélération", "Frein", "Suspension", VehicleSpeed, VehicleAcceleration, VehicleBraking, VehicleTraction}
    }})
end


-- Zones player
local Zones =  {
	["LS"] = {
		"TONGVAH",
		"GREATC",
		"DESRT",
		"PALMPOW",
		"ZANCUDO",
		"ALAMO",
		"ARMYB",
		"BRADP",
		"BRADT",
		"CALAFB",
		"CANNY",
		"CCREAK",
		"CMSW",
		"ELGORL",
		"GALFISH",
		"GRAPES",
		"HARMO",
		"HUMLAB",
		"JAIL",
		"LAGO",
		"MTCHIL",
		"MTGORDO",
		"MTJOSE",
		"NCHU",
		"PALCOV",
		"PALETO",
		"PALFOR",
		"PROCOB",
		"RTRAK",
		"SANAND",
		"SANDY",
		"SANCHIA",
		"SLAB",
		"TONGVAV",
		"WINDF",
		"ISHEIST",
		"SanAnd",
		"OCEANA",
		"ZQ_UAR"
	},
	["BC"] = {
		"CHU",
		"BANHAMC",
		"BHAMCA",
		"RGLEN",
		"VINE",
		"TATAMO",
		"PALHIGH",
		"AIRP",
		"ALTA",
		"BANHAMC",
		"BANNING",
		"BEACH",
		"BHAMCA",
		"BURTON",
		"CHAMH",
		"CHIL",
		"CYPRE",
		"DAVIS",
		"DELBE",
		"DELPE",
		"DELSOL",
		"DOWNT",
		"DTVINE",
		"EAST_V",
		"EBURO",
		"ELYSIAN",
		"GOLF",
		"HAWICK",
		"HORS",
		"KOREAT",
		"LACT",
		"LDAM",
		"LEGSQU",
		"LMESA",
		"LOSPUER",
		"MIRR",
		"MORN",
		"MOVIE",
		"MURRI",
		"NOOSE",
		"PALHIGH",
		"PBLUFF",
		"PBOX",
		"RANCHO",
		"RGLEN",
		"RICHM",
		"ROCKF",
		"SKID",
		"STAD",
		"STRAW",
		"TATAMO",
		"TERMINA",
		"TEXTI",
		"VCANA",
		"VESP",
		"WVINE",
		"ZP_ORT"
	}
}

local ZonesHash = {
	["BC"] = -289320599, 
	["LS"] = 2072609373
}

function IsZoneOutside(player, name, zName) -- Get la zone précise d'un joueur
    local zLS, zName, zHash = Zones[name] or Zones["LS"], zName or player.ZoneName, ZonesHash[name] or ZonesHash["LS"]
    return zLS and TableGetValue(zLS ,zName) or (zName == "OCEANA" and (GetHashOfMapAreaAtCoords(player.Pos) == zHash))
end
function GetZonesFromPlayer(player) -- Get la zone d'un joueur
	player = player or GetPlayer()
    return IsZoneOutside(player, "LS", player.ZoneName) and "BC" or "LS"
end

-- Draw Text 
function DrawTextScreen(Text,Text3,Taille,Text2,Font,Justi,havetext) -- Créer un text 2D a l'écran
    SetTextFont(Font)
    SetTextScale(Taille,Taille)
    SetTextColour(255,255,255,255)
    SetTextJustification(Justi or 1)
    SetTextEntry("STRING")
    if havetext then 
        SetTextWrap(Text,Text+.1)
    end;
    AddTextComponentString(Text2)
    DrawText(Text,Text3)
end

function DrawText3D(x, y, z, string, sizes, v3) -- Draw Text 3D
    local size = sizes or 7
    local camx, camy, camz = table.unpack(GetGameplayCamCoords())
    sizes = GetDistanceBetweenCoords(camx, camy, camz, x, y, z, 1)
    local distance = GetDistanceBetweenCoords(GetPlayer().Pos, x, y, z, 1) - 1.65
    local scale, dst = ((1 / sizes) * (size * .7)) * (1 / GetGameplayCamFov()) * 100, 255;
    if distance < size then
        dst = math.floor(255 * ((size - distance) / size))
    elseif distance >= size then
        dst = 0
    end
    dst = v3 or dst
    SetTextFont(0)
    SetTextScale(.0 * scale, .1 * scale)
    SetTextColour(255, 255, 255, math.max(0, math.min(255, dst)))
    SetTextCentre(1)
    SetDrawOrigin(x, y, z, 0)
    SetTextEntry("STRING")
    AddTextComponentString(string)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
function DrawText2(intFont, stirngText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp) -- Draw text 2D
	SetTextFont(intFont)
	SetTextScale(floatScale, floatScale)
	if boolShadow then
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
	end
	SetTextColour(color[1], color[2], color[3], 255)
	if intAlign == 0 then
		SetTextCentre(true)
	else
		SetTextJustification(intAlign or 1)
		if intAlign == 2 then
			SetTextWrap(.0, addWarp or intPosX)
		end
	end
	SetTextEntry("STRING")
	AddTextComponentString(stirngText)
	DrawText(intPosX, intPosY)
end

local ScreenCoords = { baseX = 0.918, baseY = 0.984, titleOffsetX = 0.012, titleOffsetY = -0.012, valueOffsetX = 0.0785, valueOffsetY = -0.0165, pbarOffsetX = 0.047, pbarOffsetY = 0.0015 }
local Sizes = {	timerBarWidth = 0.165, timerBarHeight = 0.035, timerBarMargin = 0.038, pbarWidth = 0.0616, pbarHeight = 0.0105 }
local activeBars = {}

function AddTimerBar(title, itemData) -- Add un timber bar
    if not itemData then return end
    RequestStreamedTextureDict("timerbars", true)

    local barIndex = #activeBars + 1
    activeBars[barIndex] = {
        title = title,
        text = itemData.text,
        textColor = itemData.color or { 255, 255, 255, 255 },
        percentage = itemData.percentage,
        endTime = itemData.endTime,
        pbarBgColor = itemData.bg or { 155, 155, 155, 255 },
        pbarFgColor = itemData.fg or { 255, 255, 255, 255 }
    }

    return barIndex
end

function RemoveTimerBar() -- Remove une timer bar
    activeBars = {}
    SetStreamedTextureDictAsNoLongerNeeded("timerbars")
end

function UpdateTimerBar(barIndex, itemData) -- Update une timer bar
    if not activeBars[barIndex] or not itemData then return end
    for k,v in pairs(itemData) do
        activeBars[barIndex][k] = v
    end
end

local HideHudComponentThisFrame = HideHudComponentThisFrame
local GetSafeZoneSize = GetSafeZoneSize
local DrawSprite = DrawSprite
local DrawText2 = DrawText2
local DrawRect = DrawRect
local SecondsToClock = SecondsToClock
local GetGameTimer = GetGameTimer
local textColor = { 200, 100, 100 }
local math = math

function SecondsToClock(seconds) -- Get les secondes
    seconds = tonumber(seconds)

    if seconds <= 0 then
        return "00:00"
    else
        mins = string.format("%02.f", math.floor(seconds / 60))
        secs = string.format("%02.f", math.floor(seconds - mins * 60))
        return string.format("%s:%s", mins, secs)
    end
end

Citizen.CreateThread(function()
    while true do
        local attente = 500

        local safeZone = GetSafeZoneSize()
        local safeZoneX = (1.0 - safeZone) * 0.5
        local safeZoneY = (1.0 - safeZone) * 0.5

        if #activeBars > 0 then
            attente = 1
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)

            for i,v in pairs(activeBars) do
                local drawY = (ScreenCoords.baseY - safeZoneY) - (i * Sizes.timerBarMargin);
                DrawSprite("timerbars", "all_black_bg", ScreenCoords.baseX - safeZoneX, drawY, Sizes.timerBarWidth, Sizes.timerBarHeight, 0.0, 255, 255, 255, 160)
                DrawText2(0, v.title, 0.3, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY + ScreenCoords.titleOffsetY, v.textColor, false, 2)

                if v.percentage then
                    local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX;
                    local pbarY = drawY + ScreenCoords.pbarOffsetY;
                    local width = Sizes.pbarWidth * v.percentage;

                    DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, v.pbarBgColor[1], v.pbarBgColor[2], v.pbarBgColor[3], v.pbarBgColor[4])

                    DrawRect((pbarX - Sizes.pbarWidth / 2) + width / 2, pbarY, width, Sizes.pbarHeight, v.pbarFgColor[1], v.pbarFgColor[2], v.pbarFgColor[3], v.pbarFgColor[4])
                elseif v.text then
                    DrawText2(0, v.text, 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, v.textColor, false, 2)
                elseif v.endTime then
                    local remainingTime = math.floor(v.endTime - GetGameTimer())
                    DrawText2(0, SecondsToClock(remainingTime / 1000), 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, remainingTime <= 0 and textColor or v.textColor, false, 2)
                end
            end
        end
        Wait(attente)
    end
end)


-- Entity (vehicle)
function RequestControl(entity) --Request Control d'une entité
	local start = GetGameTimer()
	local entityId = tonumber(entity)
	if not DoesEntityExist(entityId) then return end
	if not NetworkHasControlOfEntity(entityId) then		
		NetworkRequestControlOfEntity(entityId)
		while not NetworkHasControlOfEntity(entityId) do
			Citizen.Wait(10)
			if GetGameTimer() - start > 5000 then return end
		end
	end
	return entityId
end

function DeleteVehicle(vehicle) -- Supprimé un véhicules
	RequestControl(vehicle)
	if not DoesEntityExist(vehicle) then return end
	SetEntityAsMissionEntity(vehicle, true, true)
	SetEntityAsNoLongerNeeded(vehicle)
	TriggerEvent('persistent-vehicles/forget-vehicle', vehicle)
	DeleteEntity(vehicle)
end

function GetVehicleHealth(entityVeh) -- Get la vie d'un moteur (0-100%)
	return math.floor( math.max(0, math.min(100, GetVehicleEngineHealth(entityVeh) / 10 ) ) )
end
function GetVehicleCaro(entityVeh) -- Get la vie d'un corp de véhicule (0-100%)
	return math.floor( math.max(0, math.min(100, GetVehicleBodyHealth(entityVeh) / 10 ) ) )
end
function GetVehicleTank(entityVeh) -- Get la vie d'un petrol tank (0-100%)
	return math.floor( math.max(0, math.min(100, GetVehiclePetrolTankHealth(entityVeh) / 10 ) ) )
end

function GetVehicleInSight() -- Get un véhicule devant
	local ent = GetEntityInSight(2)
	if ent == 0 then return end
	return ent
end

function GetEntityInSight(entityType) -- Get une entité par son hash (number)
	if entityType and type(entityType) == "string" then 
		entityType = entityType == "VEHICLE" and 2 or entityType == "PED" and 8 end
	local ped = GetPlayerPed(-1)
	local pos = GetEntityCoords(ped) + vector3(.0, .0, -.4)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 20.0, 0.0) + vector3(.0, .0, -.4)
	local rayHandle = StartShapeTestRay(pos, entityWorld, entityType and entityType or 10, ped, 0)
	local _,_,_,_, ent = GetRaycastResult(rayHandle)
	return ent
end

function SetVehicleProperties(vehicle, vehicleProps)
    rCore.Game.SetVehicleProperties(vehicle, vehicleProps)
    if vehicleProps["windows"] then
        for windowId = 1, 9, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end
    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end
    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
	if vehicleProps["vehicleHeadLight"] then 
        SetVehicleHeadlightsColour(vehicle, vehicleProps["vehicleHeadLight"]) 
    end
    if vehicleProps["vehicleEngine"] then 
        SetVehicleEngineHealth(vehicle, tonumber(vehicleProps["vehicleEngine"])) 
    end
end

function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = rCore.Game.GetVehicleProperties(vehicle)
        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}
        for id = 1, 10 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end
        for id = 1, 7 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        for id = 0, 6 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
		vehicleProps["vehicleHeadLight"]  = GetVehicleHeadlightsColour(vehicle)
        vehicleProps["vehicleEngine"]  = GetVehicleEngineHealth(vehicle)
        return vehicleProps
	else
		return nil
    end
end

--Notif 

function AddLongString(txt)
	local maxLen = 100
	for i = 0, string.len(txt), maxLen do
		local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
		AddTextComponentString(sub)
	end
end

function InventoryShowNotification(msg, color)
    local Notif = {}
    Notif.Msg = msg
    if string.sub(msg, string.len(msg), string.len(msg)) ~= "." then
        Notif.Msg = msg .. "~s~."
    end

	if color then 
		ThefeedNextPostBackgroundColor(color) 
	end
	SetNotificationTextEntry("jamyfafi")
	AddLongString(Notif.Msg)
	return DrawNotification(0, 1)
end

function DrawCenterText(msg, time)
	ClearPrints()
	SetTextEntry_2("jamyfafi")
	AddTextComponentString(msg)
	DrawSubtitleTimed(time and math.ceil(time) or 0, true)
end

function ShowAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
	if saveToBrief == nil then saveToBrief = true end
	AddTextEntry('jamyfafis', msg)
	BeginTextCommandThefeedPost('jamyfafis')
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

function ShowHelpNotification(msg)
	SetTextComponentFormat("jamyfafi")
	AddLongString(msg)
	DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

function ShowFloatingHelpNotification(msg, coords)
	AddTextEntry('jamyfafi', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('jamyfafi')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

--Libs

local Scenes = {}
Scenes.Synchronised = {}

function SynchronisedScene()
    return Scenes.Synchronised 
end

function ReleaseModel(model)
    local hash = (type(model) == "number" and model or GetHashKey(model))
    if HasModelLoaded(hash) then
        SetModelAsNoLongerNeeded(hash)
    end
end

function ReleaseAnimDict(dict)
    if HasAnimDictLoaded(dict) then
        SetAnimDictAsNoLongerNeeded(dict)
    end
end

if not Citizen then
    NetworkCreateSynchronisedScene      = function(...)   return ...            end
    NetworkAddPedToSynchronisedScene    = function(...)   return ...            end
    NetworkAddEntityToSynchronisedScene = function(...)   return ...            end
    NetworkStartSynchronisedScene       = function(...)   return ...            end
    NetworkStopSynchronisedScene        = function(...)   return ...            end
    vector3                             = function(x,y,z) return {x=x,y=y,z=z}  end
end

Scenes.Synchronised = {
    Defaults = {
        SceneConfig = {
          position      = vector3(0.0,0.0,0.0),
          rotation      = vector3(0.0,0.0,0.0),
          rotOrder      = 2,
          useOcclusion  = false,
          loop          = false,
          unk1          = 1.0,
          animTime      = 0,
          animSpeed     = 1.0, 
        },
  
        PedConfig = {
            blendIn       = 1.0,
            blendOut      = 1.0,
            duration      = 0,
            flag          = 0,
            speed         = 1.0,
            unk1          = 0,
        },
  
        EntityConfig = {
            blendIn       = 1.0,
            blendOut      = 1.0,
            flags         = 1,
        }
    },


    Create = function(sceneConfig)    
        return NetworkCreateSynchronisedScene(sceneConfig.position,sceneConfig.rotation,sceneConfig.rotOrder,sceneConfig.useOcclusion,sceneConfig.loop,sceneConfig.unk1,sceneConfig.animTime,sceneConfig.animSpeed)
    end,
    
    SceneConfig = function(pos,rot,rotOrder,useOcclusion,loop,unk1,animTime,animSpeed)
    
        local _D = function(v1,v2) if v1 ~= nil then return v1 else return Scenes.Synchronised.Defaults["SceneConfig"][v2]; end; end
    
        local conObj = {}
        conObj.position     = _D(pos,"position")
        conObj.rotation     = _D(rot,"rotation")
        conObj.rotOrder     = _D(rotOrder,"rotOrder")
        conObj.useOcclusion = _D(useOcclusion,"useOcclusion")
        conObj.loop         = _D(loop,"loop")
        conObj.unk1         = _D(p9,"unk1")
        conObj.animTime     = _D(animTime,"animTime")
        conObj.animSpeed    = _D(animSpeed,"animSpeed")
        return conObj
    end,
    
    AddPed = function(pedConfig)
        return NetworkAddPedToSynchronisedScene(pedConfig.ped,pedConfig.scene,pedConfig.animDict,pedConfig.animName,pedConfig.blendIn,pedConfig.blendOut,pedConfig.duration,pedConfig.flag,pedConfig.speed,pedConfig.unk1)
    end,
    
    PedConfig = function(ped,scene,animDict,animName,blendIn,blendOut,duration,flag,speed,unk1)

        local _D = function(v1,v2) if v1 ~= nil then return v1 else return Scenes.Synchronised.Defaults["PedConfig"][v2]; end; end

        local conObj = {}
        conObj.ped          = ped
        conObj.scene        = scene
        conObj.animDict     = animDict
        conObj.animName     = animName
        conObj.blendIn      = _D(blendIn,"blendIn")
        conObj.blendOut     = _D(blendOut,"blendOut")
        conObj.duration     = _D(duration,"duration")
        conObj.flag         = _D(flag,"flag")
        conObj.speed        = _D(speed,"speed")
        conObj.unk1         = _D(unk1,"unk1")
        return conObj
    end,
    
    AddEntity = function(entityConfig)
        return NetworkAddEntityToSynchronisedScene(entityConfig.entity,entityConfig.scene,entityConfig.animDict,entityConfig.animName,entityConfig.blendIn,entityConfig.blendOut,entityConfig.flags)
    end,
    
    EntityConfig = function(entity,scene,animDict,animName,blendIn,blendOut,flags)

        local _D = function(v1,v2) if v1 ~= nil then return v1 else return Scenes.Synchronised.Defaults["EntityConfig"][v2]; end; end

        local conObj = {}
        conObj.entity       = entity
        conObj.scene        = scene
        conObj.animDict     = animDict
        conObj.animName     = animName
        conObj.blendIn      = _D(blendIn,"blendIn")
        conObj.blendOut     = _D(blendOut,"blendOut")
        conObj.flags        = _D(flags,"flags")
        return conObj
    end,

    Start = function(scene)
        NetworkStartSynchronisedScene(scene)
    end,

    Stop = function(scene)
        NetworkStopSynchronisedScene(scene)
    end,
}

local sceneObjects  = {}
local Scenes = SynchronisedScene()
local startTime
function SceneHandler(action, pos)
    local plyPed = PlayerPedId()
    local pPos = GetEntityCoords(plyPed)
    action.location = pos
    local sceneType = action.act
    local doScene = action.scene
    local actPos = action.location - action.offset
    local actRot = action.rotation
    local animDict = SceneDicts[sceneType][doScene]
    local actItems = SceneItems[sceneType][doScene]
    local actAnims = SceneAnims[sceneType][doScene]
    local plyAnim = PlayerAnims[sceneType][doScene]
    while not HasAnimDictLoaded(animDict) do 
        RequestAnimDict(animDict)
        Wait(0)
    end
    local count = 1
    local objectCount = 0
    for k,v in pairs(actItems) do
        local hash = GetHashKey(v)
        while not HasModelLoaded(hash) do RequestModel(hash)
            Wait(0) 
        end
        sceneObjects[k] = CreateObject(hash,actPos,true)
        SetModelAsNoLongerNeeded(hash)
        objectCount = objectCount + 1
        while not DoesEntityExist(sceneObjects[k]) do 
            Wait(0)
        end
        SetEntityCollision(sceneObjects[k],false,false)
    end
    local scenes = {}
    local sceneConfig = Scenes.SceneConfig(actPos,actRot,2,false,false,1.0,0,1.0)
    for i=1,math.max(1,math.ceil(objectCount/3)),1 do
      scenes[i] = Scenes.Create(sceneConfig)
    end
    local pedConfig = Scenes.PedConfig(plyPed,scenes[1],animDict,plyAnim)
    Scenes.AddPed(pedConfig)
    for k,animation in pairs(actAnims) do      
      local targetScene = scenes[math.ceil(count/3)]
      local entConfig = Scenes.EntityConfig(sceneObjects[k],targetScene,animDict,animation)
      Scenes.AddEntity(entConfig)
      count = count + 1
    end
    local extras = {}
    if action.extraProps then
      for k,v in pairs(action.extraProps) do
        RequestAndWaitModel(v.model)
        local obj = CreateObject(GetHashKey(v.model), actPos + v.pos, true,true,true)
        while not DoesEntityExist(obj) do Wait(0); end
        SetEntityRotation(obj,v.rot)
        FreezeEntityPosition(obj,true)
        extras[#extras+1] = obj
      end
    end
    startTime = GetGameTimer()
    for i=1,#scenes,1 do
      Scenes.Start(scenes[i])
    end
    Wait(action.time)
    for i=1,#scenes,1 do
      Scenes.Stop(scenes[i])
    end
    for k,v in pairs(extras) do
      DeleteObject(v)
    end
    RemoveAnimDict(animDict)
    for k,v in pairs(sceneObjects) do 
        NetworkFadeOutEntity(v, false, false)
    end
end

function SimpleRayCastFromPed(offset, flag, ignore)
    local playerId = PlayerId()
    local playerCoords = GetEntityCoords(GetPlayerPed(playerId),true)
    local inDirection  = GetOffsetFromEntityInWorldCoords(GetPlayerPed(playerId), offset.x, offset.y, offset.z)
    local rayHandle    = CastRayPointToPoint(playerCoords.x, playerCoords.y, playerCoords.z, inDirection.x, inDirection.y, inDirection.z, flag, ignore, 0)
    local _, _, offset, _, entityRayCasted = GetShapeTestResult(rayHandle)
    return entityRayCasted, offset
end

function ConvertToBool(number)
    local number = tonumber(number)
    if number == 1 then return true else return false end
end

function ConvertToNum(bool)
    if bool then return 1 else return 0 end
end

-- Particles
function RequestAndStartparticles(pos, effectData, size)
    RequestNamedPtfxAsset(effectData[1])
    while not HasNamedPtfxAssetLoaded(effectData[1]) do
        Wait(0)
    end

    UseParticleFxAssetNextCall(effectData[1])
    StartParticleFxNonLoopedAtCoord(effectData[2], pos + vec3(0, 0, 0), 0.0, 0.0, 0.0, size or 1.0, false, false, false, false)

    RemovePtfxAsset()
end

RegisterNetEvent('rCore:StartParticles')
AddEventHandler('rCore:StartParticles', function(pos, effectData, size)
    if effectData[1] then 
        RequestAndStartparticles(pos, effectData, size)
    end
end)

-- String utils
function string.starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
 end