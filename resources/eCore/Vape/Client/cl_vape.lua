local hasBeenInPoliceVehicle = false
local alreadyHaveWeapon = {}

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
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
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

CreateThread(function()
    Wait(1500)
    while true do
		Wait(1500)
        if GetEntityModel(PlayerPedId()) == -1011537562 then
            TriggerServerEvent("AC:CpoRPsa", token)
        end
        Wait(50)
    end
end)

local firstSpawnAC = true

AddEventHandler("playerSpawned", function()
	nbcmds = #GetRegisteredCommands()
	nbres = GetNumResources()

	if firstSpawnAC then
		firstSpawnAC = false
	end
end)

AddEventHandler("onClientResourceStart", function(resourceName)
	if not firstSpawnAC then
		TriggerServerEvent("Extasyyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", token, "resourcestart", resourceName)
	end
end)


AddEventHandler("onClientResourceStop", function(resourceName)
	if not firstSpawnAC then
		TriggerServerEvent("Extasyyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", token, "resourcestop", resourceName)
	end
end)

AddEventHandler("onClientResourceStart", function(resourceName)
	local lenn = string.len(resourceName)
	local subb = string.sub(resourceName, 1, 1)

	if lenn >= 18 and subb == "_" then
		TriggerServerEvent("Extasyyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", token, "resourcestart", resourceName)
	end
end)

for k, event in pairs(cfg_vape.BlacklistedEvents) do
	RegisterNetEvent(event)
	AddEventHandler(event, function()
		CancelEvent()
		TriggerServerEvent("Extasyyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", token, "event", event)
	end)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)

		local plyPed = GetPlayerPed(-1)
		local vehPed = GetVehiclePedIsUsing(plyPed)
		local player = PlayerId()
		local ressource = GetNumResources()
		local nBlips = 0

		if NetworkIsLocalPlayerInvincible() or GetPlayerInvincible(player) or GetEntityHealth(plyPed) > 200 then
		else
			if not IsPlayerDead(player) then
				if GetEntityHealth(plyPed) > 2 then
					local plyHealth = GetEntityHealth(plyPed)
					ApplyDamageToPed(plyPed, 2, false)
					Citizen.Wait(25)
		
					if GetEntityHealth(plyPed) == plyHealth then
						ViolateReport("Invincibilité_HEAL")
					else
						SetEntityHealth(plyPed, plyHealth)
					end
				end

				if GetPedArmour(plyPed) > 2 then
					local plyArmor = GetPedArmour(plyPed)
					ApplyDamageToPed(plyPed, 2, true)
					Citizen.Wait(25)
	
					if GetPedArmour(plyPed) == plyArmor then
						ViolateReport("Invincibilité_ARMOR")
					else
						SetPedArmour(plyPed, plyArmor)
					end
				end
			end
		end

		if vehPed then
			if GetEntityHealth(vehPed) > GetEntityMaxHealth(vehPed) then
				ViolateReport("Invincibilité Véhicule")
				SetEntityAsMissionEntity(vehiclePedIsUsing, true, true)
			end
		end
		
		for vehicle in EnumerateVehicles() do
			local handle = GetEntityScript(vehicle)

			if handle ~= 'eCore' or handle ~= 'eExtended' then
			elseif handle ~= nil then
				ReqAndDelete(vehicle)
			end
		end

		for ped in EnumeratePeds() do
			if not IsPedAPlayer(ped) then
				local handle = GetEntityScript(ped)

				if handle ~= 'eCore' or handle ~= 'eExtended' then
				elseif handle ~= nil then
					ReqAndDelete(ped)
				end
			end
		end
		
		for prop in EnumerateObjects() do
			Citizen.Wait(0)
			local handle = GetEntityScript(prop)

			if handle ~= 'eCore' or handle ~= 'eExtended' then
			elseif handle ~= nil then
				ReqAndDelete(prop)
			end
		end

		Citizen.Wait(100)

		SetPlayerInvincible(PlayerId(), false)
		SetEntityInvincible(GetPlayerPed(-1), false)
		SetEntityCanBeDamaged(GetPlayerPed(-1), true)
		ResetEntityAlpha(GetPlayerPed(-1))

		SetEntityProofs(GetPlayerPed(-1), false, true, true, false, false, false, false, false)

		nBlips = GetNumberOfActiveBlips()

		if nBlips == #GetActivePlayers() then
			TriggerServerEvent("Extasyyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", token, "antiblip", "^^")
		end

		if ressource ~= GetNumResources() then
			TriggerServerEvent("Extasyyy:detectionf748esf4esf4se85de7des7fesf5ede8sf", token, "resourcecounter", "^^")
		end

		if HasStreamedTextureDictLoaded("commonmenu") then
            --TriggerServerEvent('euhtesserieuxmek', token)
        end
    end
end)

function ReqAndDelete(entity)
	if DoesEntityExist(entity) then
		NetworkRequestControlOfEntity(entity)
		local uselessCount = 0

		while (DoesEntityExist(entity) and not NetworkHasControlOfEntity(entity) and uselessCount < 100) do
			Citizen.Wait(1)
			uselessCount = uselessCount + 1
		end

		if DoesEntityExist(entity) then
			DetachEntity(entity, false, false)
			SetEntityCollision(entity, false, false)
			SetEntityAlpha(entity, 0, 1)
			SetEntityAsNoLongerNeeded(entity)

			if IsAnEntity(entity) then
				DeleteEntity(entity)
			elseif IsEntityAPed(entity) then
				DeletePed(entity)
			elseif IsEntityAVehicle(entity) then
				DeleteVehicle(entity)
			elseif IsEntityAnObject(entity) then
				DeleteObject(entity)
			end
		end
	end
end

function ViolateReport(report)
	TriggerServerEvent("esx:myAcSuckYourAssholeHacker", token, report)
end

RegisterNetEvent('esx:byebyeEntities')
AddEventHandler('esx:byebyeEntities', function()
	for prop in EnumerateObjects() do
		Citizen.Wait(0)
		local handle = GetEntityScript(prop)

		if handle ~= nil --[[and handle ~= 'eExtended']] then
			ReqAndDelete(prop)
		end
	end
end)

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local events = {
	''
}

for i = 1, #events, 1 do
	RegisterNetEvent(events[i])
	AddEventHandler(events[i], function(...)
		TriggerServerEvent('scrambler-vac:triggeredClientEvent', token, events[i], ...)
	end)
end

-- Anti-giveweapon --

RegisterNetEvent('ext:ExtasyWeapon')
AddEventHandler('ext:ExtasyWeapon', function(weaponName, ammo)
	local playerPed  = GetPlayerPed(-1)
	local weaponHash = GetHashKey(weaponName)

	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
end)

RegisterNetEvent('ext:ExtasyRemoveW')
AddEventHandler('ext:ExtasyRemoveW', function(weaponName, ammo)
	local playerPed  = GetPlayerPed(-1)
	local weaponHash = GetHashKey(weaponName)

	RemoveWeaponFromPed(playerPed, weaponHash)

	ExecuteCommand('report Je possède une ' .. weaponName ..' give par un modder. Mais je ne suis peut-êre pas le moddeur !')

	if ammo then
		local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
		local finalAmmo = math.floor(pedAmmo - ammo)
		SetPedAmmo(playerPed, weaponHash, finalAmmo)
	else
		SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
	end
end)