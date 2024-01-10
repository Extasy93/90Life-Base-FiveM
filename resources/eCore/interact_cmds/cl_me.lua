local defaultScale   = 0.5
local color          = {r = 230, g = 230, b = 230, a = 200}
local font           = 0
local displayTime    = 5000
local distToDraw     = 250
local pedDisplaying  = {}

local function DrawMe3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    local scale = 200 / (GetGameplayCamFov() * dist)

	if text == "*la personne x *" or text == "*la personne  x *" then
		return
	else
		SetTextColour(color.r, color.g, color.b, color.a)
        SetTextScale(0.0, defaultScale * scale)
        SetTextFont(font)
		SetTextDropshadow(0, 0, 0, 0, 55)
		SetTextDropShadow()
		SetTextCentre(true)

		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringPlayerName(text)
		SetDrawOrigin(coords, 0)
		EndTextCommandDisplayText(0.0, 0.0)
		ClearDrawOrigin()
	end
end

local function Display(ped, text, idBase)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

	if pedCoords ~= playerCoords or idBase == GetPlayerServerId(PlayerId()) then
        if dist <= distToDraw then

			pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

			local display = true

			Citizen.CreateThread(function()
				Wait(displayTime)
				display = false
			end)

			local offset = 0.8 + pedDisplaying[ped] * 0.1
			while display do
				if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
					local x, y, z = table.unpack(GetEntityCoords(ped))
					z = z + offset
					DrawMe3D(vector3(x, y, z), text)
				end
				Wait(0)
			end

			pedDisplaying[ped] = pedDisplaying[ped] - 1
		end
	end
end

RegisterNetEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, serverId)
    local ped = GetPlayerPed(GetPlayerFromServerId(serverId))
    Display(ped, text, serverId)
end)