ESX = nil

local LastSkin, PlayerLoaded, cam, isCameraActive
local FirstSpawn, zoomOffset, camOffset, heading = true, 0.0, 0.0, 349.0
local LoadSkin		= nil

function GetActuallyParticul(assetName)
    RequestNamedPtfxAsset(assetName)
    if not (HasNamedPtfxAssetLoaded(assetName)) then
        while not HasNamedPtfxAssetLoaded(assetName) do
            Wait(10)
        end
        return assetName;
    else
        return assetName;
    end
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

function CreateSkinCamSkinChanger()

	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end

	SetCamActive(cam, true)
	RenderScriptCams(true, true, 500, true, true)

	isCameraActive = true
	SetCamRot(cam, 0.0, 0.0, 270.0, true)
	SetEntityHeading(playerPed, 345.0)
end



function DeleteSkinCamSkinChanger()
	isCameraActive = false
	local object = UIInstructionalButton.__constructor()
			
	object:Delete("Tourner la caméra à droite", 34)
	object:Delete("Tourner la caméra à gauche", 35)
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
end

Citizen.CreateThread(function()
	while true do
		Wait(0)

		if isCameraActive then
			DisableAllControlActions(0)
			EnableControlAction(0, 174, true)
			EnableControlAction(0, 175, true)
			EnableControlAction(0, 173, true)
			EnableControlAction(0, 172, true)
			--EnableControlAction(0, 30, true)
			--EnableControlAction(0, 44, true)

			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			local angle = heading * math.pi / 180.0
			local theta = {
				x = math.cos(angle),
				y = math.sin(angle)
			}

			local pos = {
				x = coords.x + (zoomOffset * theta.x),
				y = coords.y + (zoomOffset * theta.y),
			}

			local angleToLook = heading - 140.0
			if angleToLook > 360 then
				angleToLook = angleToLook - 360
			elseif angleToLook < 0 then
				angleToLook = angleToLook + 360
			end

			angleToLook = angleToLook * math.pi / 180.0
			local thetaToLook = {
				x = math.cos(angleToLook),
				y = math.sin(angleToLook)
			}

			local posToLook = {
				x = coords.x + (zoomOffset * thetaToLook.x),
				y = coords.y + (zoomOffset * thetaToLook.y),
			}

			SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
			PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)
		end
	end
end)

AddEventHandler('playerSpawned', function()
	CreateThread(function()

		while not PlayerLoaded do
			Wait(100)
		end

		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('skinchanger:loadSkin', {sex = 0})
				else
					LoadSkin = skin
					TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)
			FirstSpawn = false
		end
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
end)

AddEventHandler('esx_skin:getLastSkin', function(cb)
	cb(LastSkin)
end)

AddEventHandler('esx_skin:setLastSkin', function(skin)
	LastSkin = skin
end)

RegisterNetEvent('esx_skin:requestSaveSkin')
AddEventHandler('esx_skin:requestSaveSkin', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:responseSaveSkinn', skin)
	end)
end)

RegisterNetEvent("skinchanger:LoadForTheFirsTime")
AddEventHandler("skinchanger:LoadForTheFirsTime", function(skin)
	while not NetworkIsSessionStarted() do Wait(1000) end
	SetPlayerModel(GetPlayerIndex(), GetHashKey(skin['sex']))
	while not GetEntityModel(GetPlayerPed(-1)) == GetHashKey(skin['sex']) do Wait(300) SetPlayerModel(GetPlayerIndex(), GetHashKey(skin['sex'])) end
	SetPedDefaultComponentVariation(GetPlayerPed(-1))
	SetModelAsNoLongerNeeded(GetPlayerPed(-1))
	print(LoadSkin)
	LoadSkin = skin
	if skin['sex'] == 0 or skin['sex'] == 1 then
		print("Loading skin")
		ApplySkin(skin)
	end
end)