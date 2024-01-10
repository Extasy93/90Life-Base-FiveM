InitVCMS = function()    
    registerSocietyFarmZone({
        pos           = vector3(3109.98, 5228.49, 9.45),
        spawnPoint    = {
            {pos = vector3(3114.935, 5224.303, 9.453135), heading = 195.5424957275391},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage des VCMS",
        garage        = {
            {name     = "Ambulance", hash = "ambulance"},
            {name     = "Ambulance Rapide", hash = "ambulance22"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage VCMS",
        size          = 2.5,
    })
    registerSocietyFarmZone({
        pos           = vector3(3114.935, 5224.303, 9.453135),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage VCMS",
        size          = 2.5,
    })

    registerSocietyFarmZone({
        pos      = vector3(3107.147, 5218.997, 9.420014),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(3085.727, 5234.209, 9.420118),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(3105.376, 5216.337, 9.419728),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "VCMS",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(3107.147, 5218.997, 9.420014)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise VCMS")
    EndTextCommandSetBlipName(aBlip)

    local b = {
        {pos = vector3(3710.22, 6158.06, 9.02), sprite = 557, color = 48, scale = 0.60, title = "VCMS | Garage"},
        {pos = vector3(3709.23, 6169.82, 9.25), sprite = 557, color = 59, scale = 0.60, title = "VCMS | Rangement véhicule"},
    }
    
    for _, info in pairs(b) do
        info.blip = AddBlipForCoord(info.pos.x, info.pos.y, info.pos.z)
        SetBlipSprite(info.blip, info.sprite)
        SetBlipDisplay(info.blip, 4)
        SetBlipColour(info.blip, info.color)
        SetBlipScale(info.blip, info.scale)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end

local firstSpawn, PlayerLoaded = true, false

isDead = false
ESX = nil
Nombreinter = 0
ReaFaite = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)



--
--
--      Rework appel ems ici 
--
--


local AppelPris = false
local AppelDejaPris = false
local AppelEnAttente = false 
local AppelCoords = nil




-- Prise de coords des appels
RegisterNetEvent("AppelemsGetCoords")
AddEventHandler("AppelemsGetCoords", function()
	ped = GetPlayerPed(-1)
	coords = GetEntityCoords(ped, true)
	ESX.TriggerServerCallback('EMS:GetID', function(idJoueur)
		TriggerServerEvent("Server:emsAppel", coords, idJoueur)
	end)

end)



-- Register de l'appel
RegisterNetEvent("AppelemsTropBien")
AddEventHandler("AppelemsTropBien", function(coords, id)
	AppelEnAttente = true
	AppelCoords = coords
	AppelID = id
	Extasy.ShowAdvancedNotification("LSMC", "~b~Demande de VCMS", "Quelqu'un à besoin d'un vcms !\n~g~Y~w~ pour prendre l'appel\n~r~X~w~ pour refuser", "CHAR_CALL911", 8)
end)



Citizen.CreateThread(function()
     while true do
		Citizen.Wait(1)
		-- Un IF en plus pour éviter la surcharge du script
		if AppelEnAttente then
			if IsControlJustPressed(1, 246) and AppelEnAttente then
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
					TriggerServerEvent('EMS:PriseAppelServeur')
					TriggerServerEvent("EMS:AjoutAppelTotalServeur")
					TriggerEvent('emsAppelPris', AppelID, AppelCoords)
				end 
			elseif IsControlJustPressed(1, 73) and AppelEnAttente then
				Extasy.ShowAdvancedNotification("VCMS", "~b~Demande de VCMS", "Vous avez refusé l'appel.", "CHAR_CALL911", 8)
				AppelEnAttente = false
				attente = false
				AppelDejaPris = false
			end
		end
		
		if IsControlJustPressed(1, 246) and AppelDejaPris == true then
			Extasy.ShowAdvancedNotification("VCMS", "~b~Demande de VCMS", "L'appel à déja été pris, désolé.", "CHAR_CALL911", 8)
		end
     end
end)


RegisterNetEvent("EMS:AppelDejaPris")
AddEventHandler("EMS:AppelDejaPris", function(name)
	AppelEnAttente = false
	AppelDejaPris = true
	TriggerEvent("EMS:DernierAppel", name)
	Citizen.Wait(10000)
	AppelDejaPris = false
end)


-- Prise d'appel ems
RegisterNetEvent("emsAppelPris")
AddEventHandler("emsAppelPris", function(Xid, XAppelCoords)
	Extasy.ShowAdvancedNotification("VCMS", "~b~Demande de VCMS", "Vous avez pris l'appel, suivez la route GPS.", "CHAR_CALL911", 8)   
     afficherTextVolant(XAppelCoords, Xid)
end)


function afficherTextVolant(XAcoords, XAid)

     local emsBlip = AddBlipForCoord(XAcoords)
	SetBlipSprite(emsBlip, 353)
	SetBlipColour(emsBlip, 43)
	SetBlipShrink(emsBlip, true)
     SetBlipScale(emsBlip, 1.2)
     SetBlipPriority(emsBlio, 50)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("~b~Appel VCMS")
	EndTextCommandSetBlipName(emsBlip)

	-- Ajout du deuxième blip plus animer

	local emsBlip2 = AddBlipForCoord(XAcoords)
	SetBlipSprite(emsBlip2, 42)
	SetBlipColour(emsBlip2, 5)
	SetBlipShrink(emsBlip2, true)
	SetBlipScale(emsBlip2, 1.2)
	SetBlipAlpha(emsBlip2, 120)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName("~b~Appel VCMS")
	EndTextCommandSetBlipName(emsBlip2)
	-- Ajout de la route
     SetBlipRoute(emsBlip, true)
     SetThisScriptCanRemoveBlipsCreatedByAnyScript(true)
     local rea = true

     while rea do
          if GetDistanceBetweenCoords(XAcoords, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
               DrawMarker(32, XAcoords, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 66, 245, 87, 255, false, false, 2, true, false, false, false)
               Draw3DText(XAcoords.x, XAcoords.y, XAcoords.z, "~g~Une personne à besoin d'une réanimation ici ...\n~b~[E]~w~Pour la réanimer.", 4, 0.1, 0.1)

               if IsControlJustReleased(0, 38) then
                    local playerPed = PlayerPedId()
				Extasy.ShowNotification('Vous etes en train de le réanimer')
				local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
				for i=1, 15, 1 do
					Citizen.Wait(900)
				
					ESX.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
					end)
				end
				TriggerServerEvent('esx_ambulance:removeItem', 'medikit')
				TriggerServerEvent('esx_ambulance:reviveExtasyyy', XAid)
				RemoveAnimDict('mini@cpr@char_a@cpr_str')
                    RemoveAnimDict('cpr_pumpchest')
                    rea = false
                    RemoveBlip(emsBlip)
                    RemoveBlip(emsBlip2)
               end
          end

          Wait(5)
     end


end


function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
     local px,py,pz=table.unpack(GetGameplayCamCoords())
     local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
     local scale = (1/dist)*20
     local fov = (1/GetGameplayCamFov())*100
     local scale = scale*fov   
     SetTextScale(scaleX*scale, scaleY*scale)
     SetTextFont(fontId)
     SetTextProportional(1)
     SetTextColour(250, 250, 250, 255)		-- You can change the text color here
     SetTextDropshadow(1, 1, 1, 1, 255)
     SetTextEdge(2, 0, 0, 0, 150)
     SetTextDropShadow()
     SetTextOutline()
     SetTextEntry("STRING")
     SetTextCentre(1)
     AddTextComponentString(textInput)
     SetDrawOrigin(x,y,z+2, 0)
     DrawText(0.0, 0.0)
     ClearDrawOrigin()
end





local AppelTotal = 0
local NomAppel = "~r~personne"
local enService = false

RegisterNetEvent("EMS:AjoutUnAppel")
AddEventHandler("EMS:AjoutUnAppel", function(Appel)
	AppelTotal = Appel
end)


RegisterNetEvent("EMS:PriseDeService")
AddEventHandler("EMS:PriseDeService", function(service)
	enService = service
end)

RegisterNetEvent("EMS:DernierAppel")
AddEventHandler("EMS:DernierAppel", function(Appel)
	NomAppel = Appel
end)

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end


Citizen.CreateThread( function()	
	while true do
		Wait(0)
		if enService then
			DrawRect(0.888, 0.254, 0.196, 0.116, 0, 0, 0, 50)
			DrawAdvancedText(0.984, 0.214, 0.008, 0.0028, 0.4, "Dernière prise d'appel:", 0, 191, 255, 255, 6, 0)
			DrawAdvancedText(0.988, 0.236, 0.005, 0.0028, 0.4, "~b~"..NomAppel.." ~w~à pris le dernier appel VCMS", 255, 255, 255, 255, 6, 0)
			DrawAdvancedText(0.984, 0.274, 0.008, 0.0028, 0.4, "Total d'appel prise en compte", 0, 191, 255, 255, 6, 0)
			DrawAdvancedText(0.988, 0.294, 0.005, 0.0028, 0.4, AppelTotal, 255, 255, 255, 255, 6, 0)

		end
	end
end)

AddEventHandler("onClientMapStart", function()
	exports.spawnmanager:spawnPlayer()
	Citizen.Wait(5000)
	exports.spawnmanager:setAutoSpawn(false)
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Normal()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
	while true do
		Citizen.Wait(0)

		if isDead then
			DisableAllControlActions(0)
			EnableControlAction(0, 47, true)
			EnableControlAction(0, 245, true)
			EnableControlAction(0, 38, true)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx:onPlayerSpawn', function()
	isDead = false

	if firstSpawn then
		firstSpawn = false

		if cfg_ambulance.AntiCombatLog then
			while not PlayerLoaded do
				Citizen.Wait(1000)
			end

			ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(shouldDie)
				if shouldDie then
					Extasy.ShowNotification('Vous avez été réanimé de force car vous avez quitté le serveur.')
					RemoveItemsAfterRPDeath()
				end
			end)
		end
	end
end)


AddEventHandler('esx:onPlayerSpawnstaff', function()
	isDead = false

	if firstSpawn then
		firstSpawn = false

		if cfg_ambulance.AntiCombatLog then
			while not PlayerLoaded do
				Citizen.Wait(1000)
			end

			ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(shouldDie)
				if shouldDie then
					--
				end
			end)
		end
	end
end)


-- Disable most inputs when dead
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isDead then
			DisableAllControlActions(0)
			EnableControlAction(0, 47, true)
			EnableControlAction(0, 245, true)
			EnableControlAction(0, 38, true)
		else
			Citizen.Wait(500)
		end
	end
end)

function OnPlayerDeath()
	isDead = true
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', token, true)

	StartDeathTimer()
	StartDistressSignal()

	StartScreenEffect('DeathFailOut', 0, false)
end

RegisterNetEvent('esx_ambulancejob:useItem')
AddEventHandler('esx_ambulancejob:useItem', function(itemName)
	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', token, 'big', true)
			Extasy.ShowNotification('Vous avez utilisé 1x kit de soin')
		end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', token, 'small', true)
			Extasy.ShowNotification('Vous avez utilisé 1x bandage')
		end)

	elseif itemName == 'doliprane' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('esx_ambulancejob:heal', token, 'small', true)
			Extasy.ShowNotification('Vous avez utilisé 1x doliprane')
		end)
	end
end)

function StartDistressSignal()
	Citizen.CreateThread(function()
		local timer = cfg_ambulance.BleedoutTimer

		while timer > 0 and isDead do
			Citizen.Wait(0)
			timer = timer - 30

			SetTextFont(4)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName('Appuyez sur [~p~G~s~] pour envoyer un signal de détresse')
			EndTextCommandDisplayText(0.175, 0.805)

			if IsControlJustReleased(0, 47) then
				SendDistressSignal()
				break
			end
		end
	end)
end

function SendDistressSignal()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	Extasy.ShowNotification('Un signal a été envoyé à toutes les unités disponibles!')
	TriggerEvent("AppelemsGetCoords")
	TriggerServerEvent('esx_ambulancejob:onPlayerDistress', token)
end

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format('%02.f', math.floor(seconds / 3600))
		local mins = string.format('%02.f', math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format('%02.f', math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end

function StartDeathTimer()
	local canPayFine = false

	if cfg_ambulance.EarlyRespawnFine then
		ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(canPay)
			canPayFine = canPay
		end)
	end

	local earlySpawnTimer = ESX.Math.Round(cfg_ambulance.EarlyRespawnTimer / 1000)
	local bleedoutTimer = ESX.Math.Round(cfg_ambulance.BleedoutTimer / 1000)

	Citizen.CreateThread(function()
		-- early respawn timer
		while earlySpawnTimer > 0 and isDead do
			Citizen.Wait(1000)

			if earlySpawnTimer > 0 then
				earlySpawnTimer = earlySpawnTimer - 1
			end
		end

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		local text, timeHeld

		-- early respawn timer
		while earlySpawnTimer > 0 and isDead do
			Citizen.Wait(0)
			text = "Réanimation possible dans ~p~"..secondsToClock(earlySpawnTimer).." minutes "

			DrawGenericTextThisFrame()

			SetTextEntry('STRING')
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		-- bleedout timer
		while bleedoutTimer > 0 and isDead do
			Citizen.Wait(0)
			text = 'vous allez souffrir d\'une hémorragie dans ~p~'..secondsToClock(bleedoutTimer)..' minutes~s~\n'

			if not cfg_ambulance.EarlyRespawnFine then
				text = text .. 'maintenez [~p~E~s~] pour être réanimé'

				if IsControlPressed(0, 38) and timeHeld > 60 then
					RemoveItemsAfterRPDeath()
					break
				end
			elseif cfg_ambulance.EarlyRespawnFine and canPayFine then
				text = text .. 'maintenez [~p~E~s~] pour être réanimé pour ~g~$'..ESX.Math.GroupDigits(cfg_ambulance.EarlyRespawnFineAmount)..'~s~'

				if IsControlPressed(0, 38) and timeHeld > 60 then
					TriggerServerEvent('esx_ambulancejob:payFine', token)
					RemoveItemsAfterRPDeath()
					break
				end
			end

			if IsControlPressed(0, 38) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			SetTextEntry('STRING')
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end

		if bleedoutTimer < 1 and isDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end

function RemoveItemsAfterRPDeath()
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', token, false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			local formattedCoords = {
				x = cfg_ambulance.RespawnPoint.coords.x,
				y = cfg_ambulance.RespawnPoint.coords.y,
				z = cfg_ambulance.RespawnPoint.coords.z
			}

			ESX.SetPlayerData('loadout', {})
			RespawnPed(PlayerPedId(), formattedCoords, cfg_ambulance.RespawnPoint.heading)

			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
		end)
	end)
end

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)

	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawn')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
end

function RespawnPedStaff(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)

	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('esx:onPlayerSpawnstaff')
	TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon
end

function DebugEMSRespawn(coords)
	Wait(1000)
	local ped = GetPlayerPed(-1)
	SetEntityHealth(ped, 150)
	ESX.Game.Teleport(ped, coords, cb)
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(50)
			while IsDead do
				SetPedToRagdoll(ped, 5000, 5000, 0, 0, 0, 0)
				Wait(500)
			end
			ResetPedRagdollTimer(ped)
			return
		end
	end)
end

-- Effets quand le joueur est réanimé par l'unité X

function Normal()
	--Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		SetPedMotionBlur(playerPed, false)
	--end)
end

RegisterNetEvent('esx_ambulancejob:notif')
AddEventHandler('esx_ambulancejob:notif', function()
	Nombreinter = Nombreinter - 1
	if Nombreinter < 0 then
		Nombreinter = 0
	end
	ReaFaite = true
	Extasy.ShowAdvancedNotification('VCMS INFO', 'VCMS CENTRAL', 'Réanimation effectué.\n~g~50$~w~ Ajouté au coffre entreprise.\n~g~'..Nombreinter..' intervention en cours.', 'CHAR_MP_MORS_MUTUAL', 3)
end)

-- Réanimation par l'unité X

function RemoveItemsAfterRPDeath()
	--Nombreinter = Nombreinter - 1
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', token, false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', token, formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
		Citizen.Wait(10)
		ClearPedTasksImmediately(playerPed)
		SetTimecycleModifier("spectator5") -- Je sait pas se que ça fait lel
		SetPedMotionBlur(playerPed, true)
		RequestAnimSet("move_injured_generic")
			while not HasAnimSetLoaded("move_injured_generic") do
				Citizen.Wait(0)
			end
		SetPedMovementClipset(playerPed, "move_injured_generic", true)
		PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
		PlaySoundFrontend(-1, "1st_Person_Transition", "PLAYER_SWITCH_CUSTOM_SOUNDSET", 0)
		Extasy.ShowAdvancedNotification('REANIMATION X', 'Unité X réanimation', 'Vous avez été réanimé par l\'unité X.', 'CHAR_CALL911', 1)
		local ped = GetPlayerPed(PlayerId())
		local coords = GetEntityCoords(ped, false)
		local name = GetPlayerName(PlayerId())
		local x, y, z = table.unpack(GetEntityCoords(ped, true))
		TriggerServerEvent('esx_ambulance:NotificationBlipsX', token, x, y, z, name)
		Citizen.Wait(60*1000) -- Effets de la réanmation pendant 1 minute ( 60 seconde )
		Normal()

	end)
end

function RespawnPed(ped, coords, heading)

	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)
end

RegisterNetEvent('esx_ambulancejob:NotificationBlipsX2')
AddEventHandler('esx_ambulancejob:NotificationBlipsX2', function(blipId, x, y, z)
	Nombreinter = Nombreinter - 1
	if Nombreinter < 0 then
		Nombreinter = 0
	end
	Extasy.ShowAdvancedNotification('VCMS INFO', 'Unité X information', 'Une personne à été réanimer par l\'unité X.\n~g~Il reste '..Nombreinter..' intervention en cours.', 'CHAR_CALL911', 1)

	PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 0)
	--print(x, y, z)
	local TimerUniteX = 1500
	local BlipsUniteX = AddBlipForCoord(x, y, z)


	SetBlipSprite(BlipsUniteX, 515)
	SetBlipScale(BlipsUniteX, 0.6)
	SetBlipColour(BlipsUniteX, 2)
	SetBlipAlpha(BlipsUniteX, alpha)
	SetBlipAsShortRange(BlipsUniteX, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Réanimation par unité X')
	EndTextCommandSetBlipName(BlipsUniteX)


	while TimerUniteX ~= 0 do
		Citizen.Wait(10)
		TimerUniteX = TimerUniteX - 1
		--print('Blips du timer unité x : '..TimerUniteX) --( Juste un débug )
		SetBlipAlpha(BlipsUniteX, TimerUniteX)

		if TimerUniteX == 0 then
			RemoveBlip(BlipsUniteX)
			PlaySoundFrontend(-1, "DELETE", "HUD_DEATHMATCH_SOUNDSET", 0)
			return
		end
	end
end)


AddEventHandler('esx:onPlayerDeath', function(data)
	OnPlayerDeath()
end)

RegisterNetEvent('esx_ambulance:reviveExtasyyy')
AddEventHandler('esx_ambulance:reviveExtasyyy', function()
	Nombreinter = Nombreinter - 1
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulance:setDeathStatus', token, false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', token, formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)

		isDead = false
		
	end)
end)

RegisterNetEvent('staff:RevivePlayer')
AddEventHandler('staff:RevivePlayer', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_ambulance:setDeathStatus', token, false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', token, formattedCoords)

		RespawnPedStaff(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
		TriggerServerEvent('eAmbulance:revivestaff', token)

		Extasy.ShowAdvancedNotification("90's Life", "~r~MODERATION", 'Tu as été réanimé par un modérateur.', 'CHAR_DEVIN')
		
	end)
end)

local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy, deadPlayers, deadPlayerBlips, isOnDuty = false, {}, {}, false
isInShopMenu = false

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		Extasy.ShowNotification('Vous venez d\'être soigné.')
	end
end)

RegisterNetEvent('staff:HealPlayer')
AddEventHandler('staff:HealPlayer', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	SetEntityHealth(playerPed, maxHealth)

	Extasy.ShowNotification('~g~Vous avez été soigné par un staff')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if isOnDuty and job ~= 'ambulance' then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		isOnDuty = false
	end
end)

RegisterNetEvent('esx_ambulancejob:setDeadPlayers')
AddEventHandler('esx_ambulancejob:setDeadPlayers', function(_deadPlayers)
	deadPlayers = _deadPlayers

	if isOnDuty then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		for playerId,status in pairs(deadPlayers) do
			if status == 'distress' then
				local player = GetPlayerFromServerId(playerId)
				local playerPed = GetPlayerPed(player)
				local blip = AddBlipForEntity(playerPed)

				SetBlipSprite(blip, 303)
				SetBlipColour(blip, 1)
				SetBlipFlashes(blip, true)
				SetBlipCategory(blip, 7)

				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName('Personne inconscient')
				EndTextCommandSetBlipName(blip)

				deadPlayerBlips[playerId] = blip
			end
		end
	end
end)


openPharmacy = false

RMenu.Add('Extasy_ambulance_pharmacy', 'main', RageUI.CreateMenu("Pharmacie", ""))
RMenu:Get('Extasy_ambulance_pharmacy', 'main'):SetSubtitle("~p~Voici l'équipement")
RMenu:Get('Extasy_ambulance_pharmacy', 'main').EnableMouse = false
RMenu:Get('Extasy_ambulance_pharmacy', 'main').Closed = function()
	openPharmacy = false
end

function openAmbulancePharmacie()
	if not openPharmacy then
		openPharmacy = true
		RageUI.Visible(RMenu:Get('Extasy_ambulance_pharmacy', 'main'), true)
	Citizen.CreateThread(function()
		while openPharmacy do
			Citizen.Wait(1)
				RageUI.IsVisible(RMenu:Get('Extasy_ambulance_pharmacy', 'main'), true, true, true, function()
					RageUI.ButtonWithStyle("Meditkits", "Grosses blessures et réanimations - ~p~5 maximum", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							TriggerServerEvent('Pharmacy:giveItem', token, 'medikit', 5)
						end 
					end)
					RageUI.ButtonWithStyle("Bandages", "Petites blessures - ~p~20 maximum", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							TriggerServerEvent('Pharmacy:giveItem', token, 'bandage', 20)
						end 
					end)
				end)
			end
		end)
	end
end

--- F6

local ambulance_in_menu = false
    
RMenu.Add('Extasy_ambulance_menu_F6', 'main', RageUI.CreateMenu("VCMS", ""))
RMenu.Add('Extasy_ambulance_menu_F6', 'let', RageUI.CreateSubMenu(RMenu:Get('Extasy_ambulance_menu_F6', 'main'), "Interactions", "Interactions joueurs"))
RMenu.Add('Extasy_ambulance_menu_F6', 'info', RageUI.CreateSubMenu(RMenu:Get('Extasy_ambulance_menu_F6', 'main'), "Informations", "Informations"))
RMenu:Get('Extasy_ambulance_menu_F6', 'main'):SetSubtitle("Menu Interactions")
RMenu:Get('Extasy_ambulance_menu_F6', 'main').EnableMouse = false
RMenu:Get('Extasy_ambulance_menu_F6', 'main').Closed = function()
    ambulance_in_menu = false
end

local Menu = {
    check = false,
    checkbox = 1,
}

function openAmbulanceMenuF6()
        if not ambulance_in_menu then
            ambulance_in_menu = true
            RageUI.Visible(RMenu:Get('Extasy_ambulance_menu_F6', 'main'), true)
            Citizen.CreateThread(function()
                while ambulance_in_menu do
					Citizen.Wait(1)
					RageUI.IsVisible(RMenu:Get('Extasy_ambulance_menu_F6', 'main'), true, true, true, function()
						RageUI.Separator("~p~"..GetPlayerName(PlayerId()).. "~w~ - ~p~" ..ESX.PlayerData.job.grade_label.. "")
                        RageUI.ButtonWithStyle("Interactions", "Interactions avec les joueurs.", {RightLabel = "→→"}, true, function(Hovered, Active, Selected) 
                            if (Selected) then 
                            end 
                        end, RMenu:Get('Extasy_ambulance_menu_F6', 'let'))
						RageUI.Button("Annonces VCMS", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
							if s then
								local a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
								if a ~= nil then
									if string.sub(a, 1, string.len("-")) == "-" then
										Extasy.ShowNotification("~r~Quantité invalide")
									else
										if string.len(a) > 5 then
											TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'VCMS', '~o~Publicité~s~', a, 'CHAR_VCMS', 2, "VCMS")
										end
									end
								else
									Extasy.ShowNotification("~r~Heure invalide")
								end
							end
						end)
					end, function()
					end)   
                RageUI.IsVisible(RMenu:Get('Extasy_ambulance_menu_F6', 'let'), true, true, true, function()
					RageUI.ButtonWithStyle("Réanimation", "Pour personne qui est inconsciente.", {RightLabel = nil }, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							revivePlayer(closestPlayer) 
						end 
					end)
					RageUI.ButtonWithStyle("Soigner une petite blessure", nil, { RightBadge = nil },true, function(Hovered, Active, Selected)
						if (Selected) then 
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer == -1 or closestDistance > 3.0 then
								Extasy.ShowNotification('Aucune Personne à Proximité')
							else
								ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
									if quantity > 0 then
										local closestPlayerPed = GetPlayerPed(closestPlayer)
										local health = GetEntityHealth(closestPlayerPed)
		
										if health > 0 then
											local playerPed = PlayerPedId()
		
											IsBusy = true
											Extasy.ShowNotification('vous soignez...')
											TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
											Citizen.Wait(10000)
											ClearPedTasks(playerPed)
		
											TriggerServerEvent('esx_ambulancejob:removeItem', token, 'bandage')
											TriggerServerEvent('esx_ambulancejob:heal', token, GetPlayerServerId(closestPlayer), 'small')
											Extasy.ShowNotification('Vie complète', token, GetPlayerName(closestPlayer))
											IsBusy = false
										else
											Extasy.ShowNotification('Le joueur n est pas inconscient')
										end
									else
										Extasy.ShowNotification('vous n\'avez pas de ~b~bandage~s~.')
									end
								end, 'bandage')
							end
						end
					end)
					RageUI.ButtonWithStyle("Soigner une plus grande blessure", nil, { RightBadge = nil },true, function(Hovered, Active, Selected)
						if (Selected) then 
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							if closestPlayer == -1 or closestDistance > 3.0 then
								Extasy.ShowNotification('Aucune Personne à Proximité')
							else
								ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
									if quantity > 0 then
										local closestPlayerPed = GetPlayerPed(closestPlayer)
										local health = GetEntityHealth(closestPlayerPed)
		
										if health > 0 then
											local playerPed = PlayerPedId()
		
											IsBusy = true
											Extasy.ShowNotification('Guérissons en progession')
											TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
											Citizen.Wait(10000)
											ClearPedTasks(playerPed)
		
											TriggerServerEvent('esx_ambulancejob:removeItem', token, 'medikit')
											TriggerServerEvent('esx_ambulancejob:heal', token, GetPlayerServerId(closestPlayer), 'big')
											Extasy.ShowNotification('Vie complète', token, GetPlayerName(closestPlayer))
											IsBusy = false
										else
											Extasy.ShowNotification('Cette personne est inconsciente!')
										end
									else
										Extasy.ShowNotification('vous n\'avez pas de ~b~kit de soin~s~.')
									end
								end, 'medikit')
							end
						end
					end)
					RageUI.ButtonWithStyle("Mettre dans le véhicule", "Mettre la personne la plus proche de vous dans un véhicule.", {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
						if (Selected) then 
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							TriggerServerEvent('esx_ambulancejob:putInVehicle', token, GetPlayerServerId(closestPlayer))
						end 
					end)
				end, function()
                end)  
            end
        end)
    end
end

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local playerPed = PlayerPedId(target)
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

revivePlayer = function(closestPlayer)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 3.0 then
	  Extasy.ShowNotification('Pas de joueur a proximité')
	else
	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
	if qtty > 0 then
	local closestPlayerPed = GetPlayerPed(closestPlayer)
	local health = GetEntityHealth(closestPlayerPed)
	if health == 0 then
	local playerPed = GetPlayerPed(-1)
	Citizen.CreateThread(function()
	Extasy.ShowNotification('Réanimation en cours')
	TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
	Wait(10000)
	ClearPedTasks(playerPed)
	if GetEntityHealth(closestPlayerPed) == 0 then
	TriggerServerEvent('esx_ambulancejob:removeItem', token, 'medikit')
	TriggerServerEvent('esx_ambulance:reviveExtasyyy', token, GetPlayerServerId(closestPlayer))
	else
	Extasy.ShowNotification('La personne est morte')
	end
   end)
	else
		Extasy.ShowNotification('La personne n\'est pas inconciente')
	end
	 else
	Extasy.ShowNotification('vous n\'avez pas de ~b~kit de soin~s~.')
	end
   end, 'medikit')
end
end
