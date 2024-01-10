local OxygenLevel = 100.0
local AttachedProp = 0
local AttachedProp2 = 0
local OxygenGearEquipped = false
local LastExternalUseOxygen = 0 -- Use oxygen from another script. Used to not regenerate oxygen when it's being consumed

RemoveAttachedEntity = function(entity)
	DeleteEntity(entity)
	entity = 0
end

AttachEntity = function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	local attachModel = GetHashKey(attachModelSent)
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	local attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
	return attachedProp
end

RegisterNetEvent('Extasy:toggleOxygenGear')
AddEventHandler('Extasy:toggleOxygenGear', function()
	OxygenGearEquipped = not OxygenGearEquipped
	if OxygenGearEquipped then
		AttachedProp  = AttachEntity("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
		AttachedProp2 = AttachEntity("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
	else
		RemoveAttachedEntity(AttachedProp)
		RemoveAttachedEntity(AttachedProp2)
	end
end)

AddEventHandler('Extasy:useOxygen', function(value)
	LastExternalUseOxygen = GetGameTimer()
	OxygenLevel = OxygenLevel - value
end)

AddEventHandler('Extasy:getCurrentOxygenLevel', function(cb)
	cb(OxygenLevel)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local playerPed = PlayerPedId()
		if OxygenLevel > 0.0 and IsPedSwimmingUnderWater(playerPed) then
			SetPedDiesInWater(playerPed, false)
			if OxygenGearEquipped then 
				OxygenLevel = OxygenLevel - 0.1
			else 
				OxygenLevel = OxygenLevel - 1.0
			end
		else
			if IsPedSwimmingUnderWater(playerPed) then
				OxygenLevel = OxygenLevel - 1.0
				SetPedDiesInWater(playerPed, true)
			end
		end

		if not IsPedSwimmingUnderWater(playerPed) and OxygenLevel < 100.0 and GetGameTimer() > LastExternalUseOxygen + 10000 then
			OxygenLevel = OxygenLevel + 5.0
			if OxygenLevel > 100.0 then
				OxygenLevel = 100.0
			end
		end
	end
end)