-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------
----------------------------		  Base développer par Extasy#0093		    ---------------------------
----------------------------	    Pour 90Life PS: (L'anti-Cheat n'est pas	---------------------------
----------------------------		  la. Cherche encore negros🔎😁)		   ---------------------------
-----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------


if ConfigGlobalMenu.UseESX then
	Citizen.CreateThread(function()
		while not ESX do
			TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

			Citizen.Wait(500)
		end
	end)
end

DrawText3DJerry = function(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Display = function(mePlayer, text, offset)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(time)
        displaying = false
    end)
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
            local coords = GetEntityCoords(GetPlayerPed(mePlayer), false)
            DrawText3D(coords['x'], coords['y'], coords['z']+offset, text)
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

local isNearPump = false
local isFueling = false
local currentFuel = 0.0
local currentCost = 0.0
local currentCash = 1000
local fuelSynced = false
local inBlacklisted = false


ManageFuelUsage = function(vehicle)
	if not DecorExistOn(vehicle, ConfigGlobalMenu.FuelDecor) then
		SetFuel(vehicle, math.random(200, 800) / 10)
	elseif not fuelSynced then
		SetFuel(vehicle, GetFuel(vehicle))

		fuelSynced = true
	end

	if IsVehicleEngineOn(vehicle) then
		SetFuel(vehicle, GetVehicleFuelLevel(vehicle) - ConfigGlobalMenu.FuelUsage[Round(GetVehicleCurrentRpm(vehicle), 1)] * (ConfigGlobalMenu.Classes[GetVehicleClass(vehicle)] or 1.0) / 10)
	end
end

Citizen.CreateThread(function()
	DecorRegister(ConfigGlobalMenu.FuelDecor, 1)

	for i = 1, #ConfigGlobalMenu.Blacklist do
		if type(ConfigGlobalMenu.Blacklist[i]) == 'string' then
			ConfigGlobalMenu.Blacklist[GetHashKey(ConfigGlobalMenu.Blacklist[i])] = true
		else
			ConfigGlobalMenu.Blacklist[ConfigGlobalMenu.Blacklist[i]] = true
		end
	end

	for i = #ConfigGlobalMenu.Blacklist, 1, -1 do
		table.remove(ConfigGlobalMenu.Blacklist, i)
	end

	while true do
		Citizen.Wait(1000)

		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)

			if ConfigGlobalMenu.Blacklist[GetEntityModel(vehicle)] then
				inBlacklisted = true
			else
				inBlacklisted = false
			end

			if not inBlacklisted and GetPedInVehicleSeat(vehicle, -1) == ped then
				ManageFuelUsage(vehicle)
			end
		else
			if fuelSynced then
				fuelSynced = false
			end

			if inBlacklisted then
				inBlacklisted = false
			end
		end
	end
end)

FindNearestFuelPump = function()
	local coords = GetEntityCoords(PlayerPedId())
	local fuelPumps = {}
	local handle, object = FindFirstObject()
	local success

	repeat
		if ConfigGlobalMenu.PumpModels[GetEntityModel(object)] then
			table.insert(fuelPumps, object)
		end

		success, object = FindNextObject(handle, object)
	until not success

	EndFindObject(handle)

	local pumpObject = 0
	local pumpDistance = 1000

	for k,v in pairs(fuelPumps) do
		local dstcheck = GetDistanceBetweenCoords(coords, GetEntityCoords(v))

		if dstcheck < pumpDistance then
			pumpDistance = dstcheck
			pumpObject = v
		end
	end

	return pumpObject, pumpDistance
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(250)

		local pumpObject, pumpDistance = FindNearestFuelPump()

		if pumpDistance < 2.5 then
			attente = 1
			isNearPump = pumpObject

			if ConfigGlobalMenu.UseESX then
				currentCash = ESX.GetPlayerData().money
			end
		else
			isNearPump = false

			Citizen.Wait(math.ceil(pumpDistance * 20))
		end
	end
end)

LoadAnimDict = function(dict)
	if not HasAnimDictLoaded(dict) then
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end
	end
end

AddEventHandler('fuel:startFuelUpTick', function(pumpObject, ped, vehicle)
	currentFuel = GetVehicleFuelLevel(vehicle)

	while isFueling do
		Citizen.Wait(500)

		local oldFuel = DecorGetFloat(vehicle, ConfigGlobalMenu.FuelDecor)
		local fuelToAdd = math.random(10, 20) / 10.0
		local extraCost = fuelToAdd / 1.5

		if not pumpObject then
			if GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100 >= 0 then
				currentFuel = oldFuel + fuelToAdd

				SetPedAmmo(ped, 883325847, math.floor(GetAmmoInPedWeapon(ped, 883325847) - fuelToAdd * 100))
			else
				isFueling = false
			end
		else
			currentFuel = oldFuel + fuelToAdd
		end

		if currentFuel > 100.0 then
			currentFuel = 100.0
			isFueling = false
			PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", true)
		end

		currentCost = currentCost + extraCost

		if currentCash >= currentCost then
			SetFuel(vehicle, currentFuel)
		else
			isFueling = false
		end
	end

	if pumpObject then
		TriggerServerEvent('fuel:pay', token, currentCost)
	end

	currentCost = 0.0
end)

Round = function(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)

	return math.floor(num * mult + 0.5) / mult
end

AddEventHandler('fuel:refuelFromPump', function(pumpObject, ped, vehicle)
	TaskTurnPedToFaceEntity(ped, vehicle, 1000)
	Citizen.Wait(1000)
	SetCurrentPedWeapon(ped, -1569615261, true)
	LoadAnimDict("timetable@gardener@filling_can")
	TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)

	TriggerEvent('fuel:startFuelUpTick', pumpObject, ped, vehicle)

	while isFueling do
		Citizen.Wait(1)

		for k,v in pairs(ConfigGlobalMenu.DisableKeys) do
			DisableControlAction(0, v)
		end

		local vehicleCoords = GetEntityCoords(vehicle)

		if pumpObject then
			local stringCoords = GetEntityCoords(pumpObject)
			local extraString = ""

			if ConfigGlobalMenu.UseESX then
				extraString = "%\n~w~" .. ConfigGlobalMenu.Strings.TotalCost .. ": ~g~$" .. Round(currentCost, 1)
				extraEssence = "\n~w~Niveau d\'essence: ~g~" .. Round(currentFuel, 1) 
			end

			Extasy.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour annuler le plein." .. extraEssence .. extraString)
		else
			Extasy.ShowHelpNotification(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z + 0.5, ConfigGlobalMenu.Strings.CancelFuelingJerryCan .. "\nGas can: ~g~" .. Round(GetAmmoInPedWeapon(ped, 883325847) / 4500 * 100, 1) .. "% | Vehicle: " .. Round(currentFuel, 1) .. "%")
		end
		
		if not IsEntityPlayingAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 3) then
			TaskPlayAnim(ped, "timetable@gardener@filling_can", "gar_ig_5_filling_can", 2.0, 8.0, -1, 50, 0, 0, 0, 0)
		end

		if IsControlJustReleased(0, 38) or DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) or (isNearPump and GetEntityHealth(pumpObject) <= 0) then
			isFueling = false
		end
	end

	ClearPedTasks(ped)
	RemoveAnimDict("timetable@gardener@filling_can")
end)

Citizen.CreateThread(function(source)
	while true do
		attente = 5
		local ped = PlayerPedId()

		if not isFueling and ((isNearPump and GetEntityHealth(isNearPump) > 0) or (GetSelectedPedWeapon(ped) == 883325847 and not isNearPump)) then
			if IsPedInAnyVehicle(ped) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped), -1) == ped then
				local pumpCoords = GetEntityCoords(isNearPump)
				attente = 1
				Extasy.ShowHelpNotification('Quittez votre véhicule pour mettre le plein.')

			else
				local vehicle = GetPlayersLastVehicle()
				local vehicleCoords = GetEntityCoords(vehicle)

				if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(ped), vehicleCoords) < 2.5 then
					attente = 1
					if not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then
						local stringCoords = GetEntityCoords(isNearPump)
						local canFuel = true

						if GetSelectedPedWeapon(ped) == 883325847 then
							stringCoords = vehicleCoords

							if GetAmmoInPedWeapon(ped, 883325847) < 100 then
								canFuel = false
							end
						end

						if GetVehicleFuelLevel(vehicle) < 95 and canFuel then
							if currentCash > 0 then
								Extasy.ShowHelpNotification('Appuyez sur ~INPUT_TALK~ pour commencer le plein d\'essence.')

								if IsControlJustReleased(0, 38) then
									isFueling = true

									TriggerEvent('fuel:refuelFromPump', isNearPump, ped, vehicle)
									LoadAnimDict("timetable@gardener@filling_can")
								end
							else
								Extasy.ShowHelpNotification('Vous n\avez pas assez d\argent.')
							end
						else
							Extasy.ShowHelpNotification('Vous avez terminé de mettre le plein d\'essence.')
						end
					end
				elseif isNearPump then
					local stringCoords = GetEntityCoords(isNearPump)

					if currentCash >= ConfigGlobalMenu.JerryCanCost then
						if not HasPedGotWeapon(ped, 883325847) then
							DrawText3DJerry(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, ConfigGlobalMenu.Strings.PurchaseJerryCan)
							if IsControlJustReleased(0, 38) then
								TriggerServerEvent('fuel:pay', token, ConfigGlobalMenu.JerryCanCost)
								currentCash = ESX.GetPlayerData().money
							end
						else
							if ConfigGlobalMenu.UseESX then
								local refillCost = Round(ConfigGlobalMenu.RefillCost * (1 - GetAmmoInPedWeapon(ped, 883325847) / 4500))

								if refillCost > 0 then
									if currentCash >= refillCost then
										DrawText3DJerry(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, ConfigGlobalMenu.Strings.RefillJerryCan .. refillCost)

										if IsControlJustReleased(0, 38) then
											TriggerServerEvent('fuel:pay', token, refillCost)

											SetPedAmmo(ped, 883325847, 4500)
										end
									else
										DrawText3DJerry(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, ConfigGlobalMenu.Strings.NotEnoughCashJerryCan)
									end
								else
									DrawText3DJerry(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, ConfigGlobalMenu.Strings.JerryCanFull)
								end
							else
								DrawText3DJerry(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, ConfigGlobalMenu.Strings.RefillJerryCan)

								if IsControlJustReleased(0, 38) then
									SetPedAmmo(ped, 883325847, 4500)
								end
							end
						end
					else
						DrawText3DJerry(stringCoords.x, stringCoords.y, stringCoords.z + 1.2, ConfigGlobalMenu.Strings.NotEnoughCash)
					end
				else
					Citizen.Wait(250)
				end
			end
		else
			attente = 250
		end
		Citizen.Wait(attente)
	end
end)

CreateBlip = function(coords)
	local blip = AddBlipForCoord(coords)

	SetBlipSprite(blip, 361)
	SetBlipScale(blip, 0.6)
	SetBlipColour(blip, 1)
	SetBlipDisplay(blip, 4)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Station Essence")
	EndTextCommandSetBlipName(blip)

	return blip
end

if ConfigGlobalMenu.ShowNearestGasStationOnly then
	Citizen.CreateThread(function()
		local currentGasBlip = 0

		while true do
			Citizen.Wait(10000)

			local coords = GetEntityCoords(PlayerPedId())
			local closest = 1000
			local closestCoords

			for k,v in pairs(ConfigGlobalMenu.GasStations) do
				local dstcheck = GetDistanceBetweenCoords(coords, v)

				if dstcheck < closest then
					closest = dstcheck
					closestCoords = v
				end
			end

			if DoesBlipExist(currentGasBlip) then
				RemoveBlip(currentGasBlip)
			end

			currentGasBlip = CreateBlip(closestCoords)
		end
	end)
elseif ConfigGlobalMenu.ShowAllGasStations then
	Citizen.CreateThread(function()
		for k,v in pairs(ConfigGlobalMenu.GasStations) do
			CreateBlip(v)
		end
	end)
end

GetFuel = function(vehicle)
	return DecorGetFloat(vehicle, ConfigGlobalMenu.FuelDecor)
end

SetFuel = function(vehicle, fuel)
	if type(fuel) == 'number' and fuel >= 0 and fuel <= 100 then
		SetVehicleFuelLevel(vehicle, fuel + 0.0)
		DecorSetFloat(vehicle, ConfigGlobalMenu.FuelDecor, GetVehicleFuelLevel(vehicle))
	end
end





