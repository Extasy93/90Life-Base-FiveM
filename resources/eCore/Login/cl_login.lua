local Pourcent = 0.0
local Spawning    = true
local JoueurCharge  = false
local infos = false
local infoss = false
local login_openned = false
local isinintroduction = false
local introstep = 0
local timer = 0
local inputgroups = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31} 

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    DoScreenFadeOut(1000)
    Citizen.Wait(2000)
    DoScreenFadeIn(1000)
    JoueurCharge = true
end)

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not JoueurCharge do
			Citizen.Wait(0)
		end
		if Spawning then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				if skin == nil then
                    TriggerEvent('Trisoxx:firstspawn', token)
				else
					TriggerEvent('skinchanger:loadSkin', skin)
					Camera()
				end
			end)
			Spawning = false
		end
	end)
end)

RMenu.Add("Extasy_connexion", "serveur_connexion", RageUI.CreateMenu("90\'s Life", "Initialisation...", 650, 350))
RMenu:Get("Extasy_connexion", 'serveur_connexion'):SetRectangleBanner(100, 0, 200, 255)
RMenu:Get("Extasy_connexion", "serveur_connexion").Closable = false

openLogin_m = function()
    if login_openned then
        login_openned = false
        return
    else
        login_openned = true
        Citizen.CreateThread(function()
            while login_openned do
                Wait(1)
                RageUI.IsVisible(RMenu:Get("Extasy_connexion", 'serveur_connexion'), true, true, true, function()

                if connect == 1 then
                    RageUI.Button("Connecté en tant que : ~p~" ..GetPlayerName(PlayerId()), nil, {}, true, function(h, a, s)
                    end)
    
                    RageUI.PercentagePanel(Pourcent or 0.0, "Connexion en cours... [" .. math.floor(Pourcent*100) .. "%]", "", "",  function(h, a, s)
                        if Pourcent < 1.0 then
                            if playerGroup ~= "user" then
                                Pourcent = Pourcent + 0.1
                            else
                                Pourcent = Pourcent + 0.005
                            end
                        else
                            RageUI.CloseAll()
                            Pourcent = 0.0
                            connect = 0
                            progress = 0
                            infos = true
                            infoss = true
                        end
                    end)
                end
                    
                end, function()
                end)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        local playerPed = PlayerPedId()
        if infos then 
            DrawMissionText("Appuyez sur ~p~[ESPACE] ~s~pour apparaître", 800)
            if IsControlJustPressed(1, 22) then 
            DoScreenFadeOut(2000)
            Citizen.Wait(2000)
            DoScreenFadeIn(2000)
            Wait(1)
            infos = false
            SetFocusEntity(GetPlayerPed(PlayerId()))
            Citizen.Wait(10)
            introstep = 0
            timer = 0
            introstep = 0
            FreezeEntityPosition(playerPed, true) --- Freeze The Player There
            SetEntityVisible(playerPed, true, 0) --- set visable
            FreezeEntityPosition(playerPed, false) -- unfreeze
            DestroyCam(createdCamera, 0)
            createdCamera = 0
            RenderScriptCams(false,  false,  0,  true,  true) -- Pas sa
            TriggerEvent("playerSpawned", token)
            DisplayRadar(true)
            TriggerMusicEvent("ASS1_LOST")
            local playerPed = PlayerPedId()
	        SetEntityHealth(playerPed, GetEntityMaxHealth(playerPed))
            local coords = GetEntityCoords(GetPlayerPed(-1))
            SetEntityCoords(PlayerPedId(), ESX.PlayerData.coords.x, ESX.PlayerData.coords.y, ESX.PlayerData.coords.z, 0, 0, 0, 0)
            SetFocusEntity(GetPlayerPed(PlayerId()))
            TriggerEvent('eStatus:setDisplay', token, 1.0)
            Citizen.Wait(1000)
            SetFocusEntity(GetPlayerPed(PlayerId()))
            SetEntityCoords(PlayerPedId(), ESX.PlayerData.coords.x, ESX.PlayerData.coords.y, ESX.PlayerData.coords.z, 0, 0, 0, 0)
            infos = false
            Citizen.Wait(4000)
            SetFocusEntity(GetPlayerPed(PlayerId()))
            Citizen.Wait(5000)
            TriggerServerEvent('Extasy:notifTicket', token)
            infoss = false
            end
        end
    end
end)

DrawMissionText = function(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

Camera = function()
    connect = 1
    RageUI.Visible(RMenu:Get("Extasy_connexion", 'serveur_connexion'), true)
    openLogin_m()
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityVisible(GetPlayerPed(-1), false, 0)
    SetEntityCoords(PlayerPedId(), 3593.715, 4709.868, 41.76679)
    DisplayRadar(false)
    TriggerEvent('eStatus:setDisplay', token, 0.0)

    Wait(1)
        local introcam
        TriggerEvent('chat:clear', token)  --- Clear current chat
        SetEntityVisible(playerPed, false, 0) --- Make Player Invisible
        PrepareMusicEvent("FM_INTRO_START")
        Wait(1)
        SetOverrideWeather("EXTRASUNNY")
        NetworkOverrideClockTime(19, 0, 0)
        BeginSrl()
        introstep = 1
        isinintroduction = true
        Wait(1)
        DoScreenFadeIn(500)

        Wait(0)

    if introstep == 1 then
        SetOverrideWeather("EXTRASUNNY")
        PrepareMusicEvent("FM_INTRO_START")
        TriggerMusicEvent("FM_INTRO_START")

        introcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(introcam, true)
        SetFocusArea(3593.715, 4709.868, 41.76679, 0.0, 0.0, 0.0)
        SetCamParams(introcam, 3593.715, 4709.868, 41.76679, -5.0682, 0.0572, 70.7306, 40.033, 0, 1, 1, 2)
        SetCamParams(introcam, 3760.595, 5136.266, 50.47707, -5.3097, 0.0572, 80.7306, 40.033, 7000, 0, 0, 2)
        SetCamParams(introcam, 3920.791, 5526.383, 62.35437, -2.3097, 0.0572, 110.7306, 40.033, 25000, 0, 0, 2)
        ShakeCam(introcam, "HAND_SHAKE", 0.15)
        RenderScriptCams(true, false, 3000, 1, 1)
        timer = GetNetworkTime() + 18100
    end

    if introstep == 1 then
        Wait(800)
        while GetNetworkTime() < timer do
            Wait(0)
        end
        SetOverrideWeather("EXTRASUNNY")
        DoScreenFadeOut(800)
        Wait(800)
        SetFocusArea(3695.7, 6538.244, 76.85899, 0.0, 0.0, 0.0)
        NetworkOverrideClockTime(19, 0, 0)
        Wait(320)
        DoScreenFadeIn(800)
        SetCamParams(introcam, 3695.7, 6538.244, 76.85899, 1.6106, 0.5186, 78.37860107421875, 44.2442, 0, 1, 1, 2)
        SetCamParams(introcam, 3631.19, 7190.458, 68.51826, 1.6106, 0.5186, 78.37860107421875, 54.62008285522461, 19600, 0, 0, 2)
        timer = GetNetworkTime() + 14100
    end

    if introstep == 1 then
        Wait(800)
        while GetNetworkTime() < timer do
            Wait(0)
        end
        SetOverrideWeather("EXTRASUNNY")
        DoScreenFadeOut(800)
        Wait(800)
        SetFocusArea(3101.149, 7467.626, 143.0363, 0.0, 0.0, 0.0)
        NetworkOverrideClockTime(19, 0, 0)
        Wait(320)
        DoScreenFadeIn(800)
        SetCamParams(introcam, 3101.149, 7467.626, 143.0363, 1.6106, 0.5186, 78.37860107421875, 45.0069, 0, 1, 1, 2)
        SetCamParams(introcam, 3073.187, 6702.986, 168.5944, 1.8529, 0.5186, 100.82620239257812, 45.0069, 18000, 0, 0, 2)
        timer = GetNetworkTime() + 10900
    end
end

KeyboardInput = function(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. '')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

RegisterCommand("login", function()
	Camera()
end)