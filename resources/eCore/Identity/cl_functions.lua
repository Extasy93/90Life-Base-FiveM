whenActive, FirstSpawn = false, true
cam, cam2, cam3, camSkin, camSpawn, camSpawn2, isCameraActive = nil, nil, nil, nil, nil, nil, nil
lastCam = 'body'
local Camera = {
	face = {x = -235.2, y = -2001.38, z = 25.67, fov = 22.00},
	body = {x = -235.2, y = -2001.38, z = 24.90, fov = 60.00},
}

PlayAnim = function(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 1, 1, false, false, false)
    RemoveAnimDict(animDict)
end

AnimCamRegister = function()
    SetWeatherTypeNow("EXTRASUNNY")
	TriggerEvent('eStatus:setDisplay', token, 0)

    DestroyAllCams(true)

    SetEntityCoords(GetPlayerPed(-1), -243.82, -2006.51, 23.68, 0.0, 0.0, 0.0, true)
    SetEntityHeading(GetPlayerPed(-1), 256.65)

    local sexcam = nil
    sexcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    SetCamCoord(sexcam, -235.06, -2001.01, 25.30)
    SetCamActive(sexcam, true)
    RenderScriptCams(true, true, 2000, true, false)
    PointCamAtEntity(sexcam, PlayerPedId())
    SetCamParams(sexcam, -234.99, -2000.91, 25.30, 4.0, 0.0, 0.415, 50.2442, 0, 1, 1, 2)

    Wait(1500)

    TaskPedSlideToCoord(PlayerPedId(), -241.32, -2006.94, 24.68, 307.90, 1.0)
    Wait(2000)
    TaskPedSlideToCoord(PlayerPedId(), -239.54, -2001.87, 24.68, 180.27, 1.0)
	Wait(4000)
    TaskPedSlideToCoord(PlayerPedId(),  -235.48, -2003.06, 24.68, 349.54, 1.0)
    Wait(5000)
    SetEntityCoords(GetPlayerPed(-1), -235.48, -2003.06, 23.68, 180.0, 0.0, 0.0, 0.0, true)
    SetEntityHeading(GetPlayerPed(-1), 349.54)

    FreezeEntityPosition(GetPlayerPed(-1), true)
    TriggerServerEvent("Extasy:setPlayerToBucket", token, GetPlayerServerId(PlayerId()))
    whenActive = true

    OpenIdentityRegisterMenu()
end

RegisterNetEvent('Trisoxx:firstspawn')
AddEventHandler('Trisoxx:firstspawn', function()
	DisplayRadar(false)
    TriggerEvent("pma-voice:toggleMutePlayer", token, GetPlayerServerId(PlayerId()))
	AnimCamRegister()
end)

RegisterSpawnFunction = function()
    DisplayRadar(false)
    TriggerEvent("pma-voice:toggleMutePlayer", token, GetPlayerServerId(PlayerId()))
	AnimCamRegister()
end

AttachObjectToHandsPeds = function(ped, hash, timer, rot, bone, dynamic) -- Attach un props sur la main d'un ped
    if props and DoesEntityExist(props)then 
        DeleteEntity(props)
    end
    props = CreateObject(GetHashKey(hash), GetEntityCoords(ped), not dynamic)
    AttachEntityToEntity(props, ped, GetPedBoneIndex(ped, bone and 60309 or 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, not rot)
    if timer then 
        Wait(timer)
        if props and DoesEntityExist(props)then 
            DeleteEntity(props)
        end
    	ClearPedTasks(ped)
    end
    return props
end

RespawnPedSpawn = function(ped)
	SetEntityCoordsNoOffset(ped, 1836.06, 5377.13, 13.82, false, false, false, true)
	NetworkResurrectLocalPlayer(1836.06, 5377.13, 13.82, 44, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)

	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawnstaff')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
end

EndCharCreator = function()
    RageUI.CloseAll()
    MenuSpawningOpened = false
	local playerPed = GetPlayerPed(-1)

	DoScreenFadeOut(1000)
    Wait(3000)
    Wait(500)
    DoScreenFadeIn(2000)

	SetCamActive(camSkin,  false)
	RenderScriptCams(false,  false,  0,  true,  true)
    SetFocusEntity(GetPlayerPed(PlayerId()))
	enable = false

	EnableAllControlActions(0)
    FreezeEntityPosition(GetPlayerPed(-1), false)

	--AnimCam0() -- Animation de caméra avion désactivé pour ViceCity

    SetEntityCoords(PlayerPedId(), 1891.45, 5247.06, 18.97)
    SetEntityHeading(PlayerPedId(), 0.04)

    ExecuteCommand("e brief3")

    local coords = GetEntityCoords(GetPlayerPed(PlayerId()))
    FreezeEntityPosition(GetPlayerPed(-1), true)
    DisplayRadar(false)
    DoScreenFadeIn(5500)
    TriggerEvent("Ambiance:PlayUrl", "SPAWN", "https://www.youtube.com/watch?v=Bnh6nmcrsLk", 0.7, false) -- 60 Secondes
    Wait(1000)
    PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
    ClearPedTasks(GetPlayerPed(-1))
    FreezeEntityPosition(GetPlayerPed(-1), false)
    TaskPedSlideToCoord(PlayerPedId(), 1889.75, 5268.76, 19.85, 11.88, 1.0)
    Wait(13000)
    SetEntityCoords(PlayerPedId(), 1888.56, 5271.97, 19.85)
    SetEntityHeading(PlayerPedId(), 0.04)
    TaskPedSlideToCoord(PlayerPedId(), 1857.08, 5324.73, 19.85, 32.72, 1.0)
    Wait(34200)
    TaskPedSlideToCoord(PlayerPedId(), 1825.50, 5326.48, 19.85, 62.53, 1.0)
    Wait(18100)
    TaskPedSlideToCoord(PlayerPedId(), 1825.25, 5329.55, 19.86, 331.34, 1.0)
    Wait(2150)
    TaskPedSlideToCoord(PlayerPedId(), 1839.28, 5333.59, 13.83, 339.81, 1.0)
    Wait(7500)
    TaskPedSlideToCoord(PlayerPedId(), 1842.1920166016, 5370.958984375, 13.83224105835, 339.81, 1.0)
    Wait(22000)

    -- Passage des bagages dans le portique 

    SetEntityCoords(PlayerPedId(), 1842.34, 5371.84, 13.83) 
    SetEntityHeading(PlayerPedId(), 18.57)
    Wait(1000)
    ClearPedTasks(GetPlayerPed(-1))
    ExecuteCommand("e mechanic")
    Wait(1000)
    SetAudioFlag("LoadMPData", true)
    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    ClearPedTasks(GetPlayerPed(-1))

    local o = nil

    RequestModel(GetHashKey("prop_ld_case_01"))
    while not HasModelLoaded(GetHashKey("prop_ld_case_01")) do Wait(10) end
    o = CreateObject(GetHashKey("prop_ld_case_01"), vector3(1842.093, 5372.796, 14.62491), 0, 0, 0)
    objNetID     = o
    PlaceObjectOnGroundProperly(o)
    FreezeEntityPosition(o, 1)

    TaskPedSlideToCoord(PlayerPedId(), 1839.55, 5373.54, 13.83, 318.09, 1.0)
    Wait(3000)

    spawned      = true
    local entity = objNetID
    SetEntityAsMissionEntity(entity, true, true)
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    while entity == nil do Wait(1) end
    --InvokeNative(0xEA386986E786A54F, PointerValueIntInitialized(entity))

    if (DoesEntityExist(entity)) then 
        DeleteEntity(entity)
    end
    
    Wait(1000)

    local o = nil

    RequestModel(GetHashKey("prop_ld_case_01"))
    while not HasModelLoaded(GetHashKey("prop_ld_case_01")) do Wait(10) end
    o = CreateObject(GetHashKey("prop_ld_case_01"), vector3(1840.74, 5373.92, 14.62), 0, 0, 0)
    objNetID     = o
    PlaceObjectOnGroundProperly(o)
    FreezeEntityPosition(o, 1)

    ExecuteCommand("e mechanic")
    Wait(1000)
    SetAudioFlag("LoadMPData", true)
    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    ClearPedTasks(GetPlayerPed(-1))

    spawned      = true
    local entity = objNetID
    SetEntityAsMissionEntity(entity, true, true)
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    while entity == nil do Wait(1) end
    --InvokeNative(0xEA386986E786A54F, PointerValueIntInitialized(entity))

    if (DoesEntityExist(entity)) then 
        DeleteEntity(entity)
    end

    ExecuteCommand("e brief3")

    -- Passage des bagages dans le portique 

    TaskPedSlideToCoord(PlayerPedId(), 1836.06, 5377.13, 13.82, 44.84, 1.0)
    Wait(3000)

    DisplayRadar(true)
    EnableAllControlActions(0)
    SetEntityVisible(PlayerPedId(), true, 0)
    SetFocusEntity(GetPlayerPed(PlayerId()))
    RenderScriptCams(0, 0, 1, 1, 1)
    TriggerEvent('eStatus:setDisplay', token, 1)
    ClearTimecycleModifier()
    Wait(1000)
    PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
    Wait(2000)
    TriggerServerEvent("Extasy:setPlayerToNormalBucket", token)
    TriggerEvent("pma-voice:toggleMutePlayer", token, GetPlayerServerId(PlayerId()))
    Extasy.RequestStreamedTextureDict('WEB_JACKSONBBJ')
    EnableAllControlActions(0)
    Wait(100)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    TriggerEvent("Extasy:showAdvancedNotification", 'Johnny', '~p~Arrivée en ville !', 'Bienvenue en ville l\'ami, Je m\'appelle Johnny et je vais te guider toute au long de ton aventure ;)', 'WEB_JACKSONBBJ', 3)
    Wait(500)
    whenActive = false
    TriggerEvent("Extasy:SavePlayer", token, PlayerPedId())
    Wait(400)
    RespawnPedSpawn(PlayerPedId())
    Wait(1000)
    --openSP()
    PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
    Wait(14000)
    TriggerEvent("Extasy:showAdvancedNotification", 'Johnny', '~y~Location de départ', 'Une location t\'attend un peu plus loin sur ta droite.', 'WEB_JACKSONBBJ', 3)
    Wait(30000)
    TriggerEvent("Extasy:showAdvancedNotification", 'Johnny', '~b~Trouver un travaille', 'On m\'a dit que tu n\'avais pas encore de travail. Alors commence par te diriger vers le pôle-emplois pour te faire un peu d\'argent, je t\'ai mis le GPS.', 'WEB_JACKSONBBJ', 3)
    SetNewWaypoint(-927.1508, -2035.441168, 9.54)
    Wait(30000)
    TriggerEvent("Extasy:showAdvancedNotification", 'Johnny', '~o~Chambre d\'hotel', 'Je me suis dit que tu aurais aussi besoin d\'un endroit ou crécher...', 'WEB_JACKSONBBJ', 3)
    Wait(8000)

    TriggerEvent('skinchanger:getSkin', function(skin)               
        TriggerServerEvent('esx_skin:save', skin)               
    end)

    TriggerEvent("Extasy:SavePlayer", token, PlayerPedId())

    if submitCb ~= nil then
        submitCb(data, menu)
    end
end

SpawnNotif = function()
    Wait(2000)
    Extasy.ShowAdvancedNotification("Lamar", "~o~Salut !", "Moi c'est Lamar 😏", "CHAR_LAMAR2")
    Wait(47000)
    Extasy.ShowAdvancedNotification("Lamar", "~o~Chambre d'hotel", "Je t'ai donc pris une chambre d'hôtel dans le nord pour 7 jours. Tu vas recevoir une confirmation de la réservation dans 2 min.", "CHAR_LAMAR2")
    Wait(2000)
    TriggerServerEvent("hotel:rent", token, 7)
end

CreateThread(function()
    while true do
        Wait(1)
        if whenActive then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
        else
            EnableControlAction(0, 1, true) -- Enable pan
			EnableControlAction(0, 2, true) -- Enable tilt
			EnableControlAction(0, 24, true) -- Attack
			EnableControlAction(0, 257, true) -- Attack 2
			EnableControlAction(0, 25, true) -- Aim
			EnableControlAction(0, 263, true) -- Melee Attack 1
			EnableControlAction(0, 45, true) -- Reload
			EnableControlAction(0, 22, true) -- Jump
			EnableControlAction(0, 44, true) -- Cover
			EnableControlAction(0, 37, true) -- Select Weapon
			EnableControlAction(0, 23, true) -- Also 'enter'?
			EnableControlAction(0, 288,  true) -- Enable phone
			EnableControlAction(0, 289, true) -- Inventory
			EnableControlAction(0, 170, true) -- Animations
			EnableControlAction(0, 167, true) -- Job
			EnableControlAction(0, 0, true) -- Enable changing view
			EnableControlAction(0, 26, true) -- Enable looking behind
			EnableControlAction(0, 73, true) -- Enable clearing animation
			EnableControlAction(2, 199, true) -- Enable pause screen
			EnableControlAction(0, 59, true) -- Enable steering in vehicle
			EnableControlAction(0, 71, true) -- Enable driving forward in vehicle
			EnableControlAction(0, 72, true) -- Enable reversing in vehicle
			EnableControlAction(2, 36, true) -- Enable going stealth
			EnableControlAction(0, 47, true)  -- Enable weapon
			EnableControlAction(0, 264, true) -- Enable melee
			EnableControlAction(0, 257, true) -- Enable melee
			EnableControlAction(0, 140, true) -- Enable melee
			EnableControlAction(0, 141, true) -- Enable melee
			EnableControlAction(0, 142, true) -- Enable melee
			EnableControlAction(0, 143, true) -- Enable melee
			EnableControlAction(0, 75, true)  -- Enable exit vehicle
			EnableControlAction(27, 75, true) -- Enable exit vehicle
            Wait(500)
        end
    end
end)

RegisterCommand("register", function() 
    if getPlayerVip() ~= "AUCUN" then
        RageUI.CloseAll()
        RegisterSpawnFunction()
    else
        Extasy.ShowNotification("~r~Vous n'avez pas le grade nécessaire pour accéder cette fonctionnalité.~n~Vous devez être minimum ~y~GOLDEN.")
    end
end)

RegisterCommand("skin", function() 
    if getPlayerVip() ~= "AUCUN" then
        RageUI.CloseAll()
        OpenSkinMenu()
    else
        Extasy.ShowNotification("~r~Vous n'avez pas le grade nécessaire pour accéder cette fonctionnalité.~n~Vous devez être minimum ~y~GOLDEN.")
    end
end)