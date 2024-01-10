local RouletteWords = {
    "90LifeRP",
    "Extabite",
    "]wG?8mS3",
    "Z6~mJ5b_",
    "b%c-U4U9",
    "8VhY.9f)",
    ">Aru4U:7",
}

cachedScaleform = nil

ScaleformLabel = function(label)
    BeginTextCommandScaleformString(label)
    EndTextCommandScaleformString()
end

local lives = 3
local ClickReturn
local SorF = false
local Hacking = false
local UsingComputer = false

StartComputer = function()
    Citizen.CreateThread(function()
        InitializeBruteForce = function(scaleform)
            local scaleform = RequestScaleformMovieInteractive(scaleform)
            while not HasScaleformMovieLoaded(scaleform) do
                Wait(0)
            end
            
            local CAT = 'hack'
            local CurrentSlot = 0
            while HasAdditionalTextLoaded(CurrentSlot) and not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
                Wait(0)
                CurrentSlot = CurrentSlot + 1
            end
            
            if not HasThisAdditionalTextLoaded(CAT, CurrentSlot) then
                ClearAdditionalText(CurrentSlot, true)
                RequestAdditionalText(CAT, CurrentSlot)
                while not HasThisAdditionalTextLoaded(CAT, CurrentSlot) do
                    Wait(0)
                end
            end

            PushScaleformMovieFunction(scaleform, "SET_LABELS")
            ScaleformLabel("H_ICON_1")
            ScaleformLabel("H_ICON_2")
            ScaleformLabel("H_ICON_3")
            ScaleformLabel("H_ICON_4")
            ScaleformLabel("H_ICON_5")
            ScaleformLabel("H_ICON_6")
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_BACKGROUND")
            PushScaleformMovieFunctionParameterInt(1)
            PopScaleformMovieFunctionVoid()
            
            PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
            PushScaleformMovieFunctionParameterFloat(1.0)
            PushScaleformMovieFunctionParameterFloat(4.0)
            PushScaleformMovieFunctionParameterString("My Computer")
            PopScaleformMovieFunctionVoid()
            
            PushScaleformMovieFunction(scaleform, "ADD_PROGRAM")
            PushScaleformMovieFunctionParameterFloat(6.0)
            PushScaleformMovieFunctionParameterFloat(6.0)
            PushScaleformMovieFunctionParameterString("Power Off")
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_LIVES")
            PushScaleformMovieFunctionParameterInt(lives)
            PushScaleformMovieFunctionParameterInt(5)
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_LIVES")
            PushScaleformMovieFunctionParameterInt(lives)
            PushScaleformMovieFunctionParameterInt(5)
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(0)
            PushScaleformMovieFunctionParameterInt(math.random(220,240))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(1)
            PushScaleformMovieFunctionParameterInt(math.random(220,240))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(2)
            PushScaleformMovieFunctionParameterInt(math.random(220,240))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(3)
            PushScaleformMovieFunctionParameterInt(math.random(220,240))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(4)
            PushScaleformMovieFunctionParameterInt(math.random(220,240))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(5)
            PushScaleformMovieFunctionParameterInt(math.random(220,240))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(6)
            PushScaleformMovieFunctionParameterInt(math.random(220,240))
            PopScaleformMovieFunctionVoid()

            PushScaleformMovieFunction(scaleform, "SET_COLUMN_SPEED")
            PushScaleformMovieFunctionParameterInt(7)
            PushScaleformMovieFunctionParameterInt(math.random(220,240))
            PopScaleformMovieFunctionVoid()
            
            return scaleform
        end

        cachedScaleform = InitializeBruteForce("HACKING_PC")

        UsingComputer = true

        while UsingComputer do
            Wait(0)

            DisableControlAction(0, 1, true) -- Disable pan
            DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 31, true) -- S (fault in Keys table!)
            DisableControlAction(0, 30, true) -- D (fault in Keys table!)
            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle
            DisableControlAction(0, 47, true)  -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
            
            if UsingComputer then
                DrawScaleformMovieFullscreen(cachedScaleform, 255, 255, 255, 255, 0)
                PushScaleformMovieFunction(cachedScaleform, "SET_CURSOR")
                PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
                PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
                PopScaleformMovieFunctionVoid()
                if IsDisabledControlJustPressed(0,24) and not SorF then
                    PushScaleformMovieFunction(cachedScaleform, "SET_INPUT_EVENT_SELECT")
                    ClickReturn = PopScaleformMovieFunction()
                    PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
                elseif IsDisabledControlJustPressed(0, 25) and not Hacking and not SorF then
                    PushScaleformMovieFunction(cachedScaleform, "SET_INPUT_EVENT_BACK")
                    PopScaleformMovieFunctionVoid()
                    PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
                end
            end
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        local sleepThread = 500

        if HasScaleformMovieLoaded(cachedScaleform) and UsingComputer then
            sleepThread = 5

            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            if GetScaleformMovieFunctionReturnBool(ClickReturn) then
                ProgramID = GetScaleformMovieFunctionReturnInt(ClickReturn)

                if ProgramID == 83 and not Hacking then
                    lives = 3
                    
                    PushScaleformMovieFunction(cachedScaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(lives)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()
        
                    PushScaleformMovieFunction(cachedScaleform, "OPEN_APP")
                    PushScaleformMovieFunctionParameterFloat(1.0)
                    PopScaleformMovieFunctionVoid()
                    
                    PushScaleformMovieFunction(cachedScaleform, "SET_ROULETTE_WORD")
                    PushScaleformMovieFunctionParameterString(RouletteWords[math.random(#RouletteWords)])
                    PopScaleformMovieFunctionVoid()
        
                    Hacking = true
                elseif Hacking and ProgramID == 87 then
                    lives = lives - 1
                    PushScaleformMovieFunction(cachedScaleform, "SET_LIVES")
                    PushScaleformMovieFunctionParameterInt(lives)
                    PushScaleformMovieFunctionParameterInt(5)
                    PopScaleformMovieFunctionVoid()
                    PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
                elseif Hacking and ProgramID == 92 then
                    PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
                elseif Hacking and ProgramID == 86 then
                    SorF = true
                    PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
                    PushScaleformMovieFunction(cachedScaleform, "SET_ROULETTE_OUTCOME")
                    PushScaleformMovieFunctionParameterBool(true)
                    ScaleformLabel("WINBRUTE")
                    PopScaleformMovieFunctionVoid()
                    Wait(5000)
                    PushScaleformMovieFunction(cachedScaleform, "CLOSE_APP")
                    PopScaleformMovieFunctionVoid()
                    SetScaleformMovieAsNoLongerNeeded(cachedScaleform)
                    UsingComputer = false
                    Hacking = false
                    SorF = false    

                    HackingCompleted(true)

                    DisableControlAction(0, 24, false)
                    DisableControlAction(0, 25, false)
                elseif ProgramID == 6 then
                    UsingComputer = false
                    SetScaleformMovieAsNoLongerNeeded(cachedScaleform)

                    HackingCompleted(false)

                    DisableControlAction(0, 24, false)
                    DisableControlAction(0, 25, false)
                end
                
                if Hacking then
                    PushScaleformMovieFunction(cachedScaleform, "SHOW_LIVES")
                    PushScaleformMovieFunctionParameterBool(true)
                    PopScaleformMovieFunctionVoid()
        
                    if lives <= 0 then
                        SorF = true
                        PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
                        PushScaleformMovieFunction(cachedScaleform, "SET_ROULETTE_OUTCOME")
                        PushScaleformMovieFunctionParameterBool(false)
                        ScaleformLabel("LOSEBRUTE")
                        PopScaleformMovieFunctionVoid()
                        Wait(5000)
                        PushScaleformMovieFunction(cachedScaleform, "CLOSE_APP")
                        PopScaleformMovieFunctionVoid()
                        SetScaleformMovieAsNoLongerNeeded(cachedScaleform)
                        Hacking = false
                        SorF = false
                        UsingComputer = false

                        HackingCompleted(false)

                        DisableControlAction(0, 24, false)
                        DisableControlAction(0, 25, false)
                    end
                end
            end
        end

        Wait(sleepThread)
    end
end)

OpenDoor = function()
	RequestScriptAudioBank("vault_door", false)

	while not HasAnimDictLoaded("anim@heists@fleeca_bank@bank_vault_door") do
		Wait(0)
		RequestAnimDict("anim@heists@fleeca_bank@bank_vault_door")
	end

	local doorEntity = GetClosestObjectOfType(vector3(2327.291, 5864.658, 7.978503), 5.0, 961976194, false)

	if not DoesEntityExist(doorEntity) then
		return
	end

	PlaySoundFromCoord(-1, "vault_unlock", vector3(2327.291, 5864.658, 7.978503), "dlc_heist_fleeca_bank_door_sounds", 0, 0, 0)
	PlayEntityAnim(doorEntity, "bank_vault_door_opens", "anim@heists@fleeca_bank@bank_vault_door", 4.0, false, 1, 0, 0.0, 8)
	ForceEntityAiAndAnimationUpdate(doorEntity)

	Wait(5000)

	DeleteEntity(doorEntity)

	if IsEntityPlayingAnim(doorEntity, "anim@heists@fleeca_bank@bank_vault_door", "bank_vault_door_opens", 3) then

		if GetEntityAnimCurrentTime(doorEntity, "anim@heists@fleeca_bank@bank_vault_door", "bank_vault_door_opens") >= 1.0 then
			FreezeEntityPosition(doorEntity, true)

			StopEntityAnim(doorEntity, "bank_vault_door_opens", "anim@heists@fleeca_bank@bank_vault_door", -1000.0)
			SetEntityRotation(doorEntity, 0, 0, -160.0, 2, 1)

			ForceEntityAiAndAnimationUpdate(doorEntity)

			RemoveAnimDict("anim@heists@fleeca_bank@bank_vault_door")
		end
	end
end

HackingCompleted = function(success)
	if success then
		local trolleys = SpawnTrolleys()
		GlobalFunction("start_robbery", {["bank"] = cachedData["bank"], ["trolleys"] = trolleys, ["save"] = true})
	else
        Extasy.ShowNotification("~r~Vous n'avez pas réussi à craquer le terminal")
        ClearPedTasks(PlayerPedId())
	end
end

SpawnTrolleys = function()
	local bankTrolleys = cfg_simpleRobberys.trolleys["pos"]
	local trolleyInfo = cfg_simpleRobberys.trolleys

	local trolleyData = {}

	for trolley, values in pairs(bankTrolleys) do
		if not HasModelLoaded(trolleyInfo["model"]) then
			Extasy.LoadModels({trolleyInfo["model"]})
		end

		local trolleyObject = CreateObject(trolleyInfo["model"], values["pos"], true)
		SetEntityRotation(trolleyObject, 0.0, 0.0, values["heading"])

		PlaceObjectOnGroundProperly(trolleyObject)
		SetEntityAsMissionEntity(trolleyObject, true, true)

		trolleyData[trolley] = {["net"] = ObjToNet(trolleyObject), ["money"] = cfg_simpleRobberys.trolleys["cash"]}

		SetModelAsNoLongerNeeded(trolleyInfo["model"])
	end
	
	return trolleyData
end

RobberyThread = function(eventData)
	CreateThread(function()
		cachedData["banks"] = eventData["trolleys"]
		OpenDoor()

		local doorEntity = GetClosestObjectOfType(vector3(254.12199291992, 225.50576782227, 101.87346405029), 5.0, 961976194, false)

		while cachedData["banks"] do
			local sleepThread = 500
			
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local dstCheck = GetDistanceBetweenCoords(pedCoords, vector3(2325.85, 5860.77, 7.79), true)

			if dstCheck <= 25.0 then
				sleepThread = 5

				if not DoesEntityExist(doorEntity) then
					doorEntity = GetClosestObjectOfType(vector3(254.12199291992, 225.50576782227, 101.87346405029), 5.0, 961976194, false)
				end

				if math.floor(GetEntityRotation(doorEntity)["z"]) ~= 50 then
					SetEntityRotation(doorEntity, 0, 0, 50.0, 2, 1)
				end

				for trolley, trolleyData in pairs(eventData["trolleys"]) do
					if NetworkDoesEntityExistWithNetworkId(trolleyData["net"]) then
						local dstCheck = #(pedCoords - GetEntityCoords(NetToObj(trolleyData["net"])))
						if dstCheck <= 1.5 then
							Extasy.ShowHelpNotification("~INPUT_DETONATE~ Pour récupérer l'argent sur les chariots !")
							if IsControlJustPressed(0, 47) then
								GrabCash(trolleyData)
							end
						end
					end
				end
			end

			Wait(sleepThread)
		end
	end)
end

GrabCash = function(trolleyData)
	local ped = PlayerPedId()

	local CashAppear = function()
		local pedCoords = GetEntityCoords(ped)
		local cashModel = GetHashKey("hei_prop_heist_cash_pile")
	
		Extasy.LoadModels({cashModel})
	
		local cashPile = CreateObject(cashModel, pedCoords, true)
	
		FreezeEntityPosition(cashPile, true)
		SetEntityInvincible(cashPile, true)
		SetEntityNoCollisionEntity(cashPile, ped)
		SetEntityVisible(cashPile, false, false)
		AttachEntityToEntity(cashPile, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	
		local startedGrabbing = GetGameTimer()
	
		Citizen.CreateThread(function()
			while GetGameTimer() - startedGrabbing < 37000 do
				Wait(0)
	
				DisableControlAction(0, 73, true)

				if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
					if not IsEntityVisible(cashPile) then
						SetEntityVisible(cashPile, true, false)
					end
				end
		
				if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
					if IsEntityVisible(cashPile) then
						SetEntityVisible(cashPile, false, false)
	
						TriggerServerEvent("bankrobberies:takeMoney")
					end
				end
			end
		
			DeleteObject(cashPile)
		end)
	end

	local trolleyObject = NetToObj(trolleyData["net"])

	if IsEntityPlayingAnim(trolleyObject, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
		return Extasy.ShowNotification("Une personne prend deja l'argent")
	end

	Extasy.LoadModels({GetHashKey("hei_p_m_bag_var22_arm_s"), "anim@heists@ornate_bank@grab_cash", GetHashKey("hei_prop_hei_cash_trolly_03")})
	
	while not NetworkHasControlOfEntity(trolleyObject) do
		Wait(0)
		NetworkRequestControlOfEntity(trolleyObject)
	end

	cachedData["bag"] = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)

	--Extasy.ToggleBag(false)

	cachedData["scene"] = NetworkCreateSynchronisedScene(GetEntityCoords(trolleyObject), GetEntityRotation(trolleyObject), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, cachedData["scene"], "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(cachedData["bag"], cachedData["scene"], "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(cachedData["scene"])

	Wait(1500)

	CashAppear()

	cachedData["scene"] = NetworkCreateSynchronisedScene(GetEntityCoords(trolleyObject), GetEntityRotation(trolleyObject), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, cachedData["scene"], "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(cachedData["bag"], cachedData["scene"], "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(trolleyObject, cachedData["scene"], "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)

	NetworkStartSynchronisedScene(cachedData["scene"])

	Wait(37000)

	cachedData["scene"] = NetworkCreateSynchronisedScene(GetEntityCoords(trolleyObject), GetEntityRotation(trolleyObject), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, cachedData["scene"], "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(cachedData["bag"], cachedData["scene"], "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)

	NetworkStartSynchronisedScene(cachedData["scene"])
	
	local newTrolley = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_03"), GetEntityCoords(trolleyObject) + vector3(0.0, 0.0, - 0.985), true)
	SetEntityRotation(newTrolley, GetEntityRotation(trolleyObject))
	
	while not NetworkHasControlOfEntity(trolleyObject) do
		Wait(0)
		NetworkRequestControlOfEntity(trolleyObject)
	end

	DeleteObject(trolleyObject)
	PlaceObjectOnGroundProperly(newTrolley)
	
	Wait(1900)

	DeleteObject(cachedData["bag"])
	Extasy.ToggleBag(true)
	
	RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
	SetModelAsNoLongerNeeded(GetHashKey("hei_prop_hei_cash_trolly_03"))
	SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
end

RegisterNetEvent("bankrobberies:eventHandler")
AddEventHandler("bankrobberies:eventHandler", function(event, eventData)
	if event == "start_robbery" then
		RobberyThread(eventData)
	elseif event == "alarm_police" then
		if ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "police" then
			SetAudioFlag("LoadMPData", true)
			PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")

			Extasy.ShowNotification("Un bracage de Banque a lieu " .. eventData .. " Regarder sur votre gps")

			local bankValues = cfg_bracoPacific.Bank[eventData]

			SetNewWaypoint(bankValues["start"]["pos"]["x"], bankValues["start"]["pos"]["y"])

			local blipRobbery = AddBlipForCoord(bankValues["start"]["pos"])

			SetBlipSprite(blipRobbery, 161)
			SetBlipScale(blipRobbery, 2.0)
			SetBlipColour(blipRobbery, 8)

			Citizen.CreateThread(function()
				local startedBlip = GetGameTimer()

				while GetGameTimer() - startedBlip < 60000 * 5 do
					Wait(0)
				end

				RemoveBlip(blipRobbery)
			end)
		end
	end
end)