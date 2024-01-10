-- Config

local maxActions

-- Coords
local prisonCoords = {x = 1643.38, y = 2529.35, z = 45.5}
local stuckCoords = {x = 223.7026, y = -790.25, z = 30.72}
local prisonRadius = 12.0

-- Translation
local endMessage = "~g~Vous avez terminé, ~s~bienvenue dans le monde réel, mais restez tranquille cette fois."
local doingPrefix = "Allez-y, continuez !\n~p~"
local doingSuffix = " ~s~et vous êtes prêt à partir!"

-- Actions
local prisonActionCoords =
{
	{ label = "Poids",			duration = 10000, scenario = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS", x = 1642.7225341796,	y = 2524.0556640625,	z = 44.56489944458,		h = 230.86309},
	{ label = "Poids",			duration = 10000, scenario = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS", x = 1646.622680664,		y = 2535.8493652344,	z = 44.564876556396,	h = 50.930492},
	{ label = "Faire des pompes",			duration = 10000, scenario = "WORLD_HUMAN_PUSH_UPS",			x = 1636.439819336,		y = 2528.7370605468,	z = 44.56489944458,		h = 53.6525192},
	{ label = "Faire des pompes",			duration = 10000, scenario = "WORLD_HUMAN_PUSH_UPS",			x = 1638.8117675782,	y = 2531.6665039062,	z = 44.56489944458,		h = 48.541206},
	{ label = "Faire des pompes",			duration = 10000, scenario = "WORLD_HUMAN_PUSH_UPS",			x = 1641.2742919922,	y = 2534.4873046875,	z = 44.56489944458,		h = 52.171966},
	{ label = "Faire des abdos",		duration = 10000, scenario = "WORLD_HUMAN_SIT_UPS",				x = 1638.9910888672,	y = 2521.1713867188,	z = 44.56489944458,		h = 47.997913},
	{ label = "Faire des abdos",		duration = 10000, scenario = "WORLD_HUMAN_SIT_UPS",				x = 1641.4490966796,	y = 2519.3046875,		z = 44.56489944458,		h = 231.47094726},
	{ label = "Faire des abdos",		duration = 10000, scenario = "WORLD_HUMAN_SIT_UPS",				x = 1642.8138427734,	y = 2520.8374023438,	z = 44.56489944458,		h = 237.37298},
	{ label = "Faire des abdos",		duration = 10000, scenario = "WORLD_HUMAN_SIT_UPS",				x = 1638.5084228516,	y = 2524.1552734375,	z = 44.56489944458,		h = 147.60180},
	{ label = "Yoga",				duration = 10000, scenario = "WORLD_HUMAN_YOGA",				x = 1649.8255615234,	y = 2532.7043457032,	z = 44.564865112304,	h = 230.25950622},
	{ label = "Yoga",				duration = 10000, scenario = "WORLD_HUMAN_YOGA",				x = 1648.7510986328,	y = 2531.3874511718,	z = 44.564865112304,	h = 234.14630126},
	{ label = "Yoga",				duration = 10000, scenario = "WORLD_HUMAN_YOGA",				x = 1647.7794189454,	y = 2530.0014648438,	z = 44.564865112304,	h = 231.44407653},
	{ label = "Yoga",				duration = 10000, scenario = "WORLD_HUMAN_YOGA",				x = 1646.579711914,		y = 2531.8999023438,	z = 44.564865112304,	h = 58.9713706970},
	{ label = "Courrir ",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1648.0295410156,	y = 2526.6865234375,	z = 44.564865112304,	h = 232.7815246582},
	{ label = "Courrir ",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1647.1231689454,	y = 2525.3095703125,	z = 44.564865112304,	h = 232.14538574218},
	{ label = "Courrir ",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1646.1625976562,	y = 2523.9912109375,	z = 44.564865112304,	h = 229.96112060546},
	{ label = "Courrir ",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1644.8634033204,	y = 2527.0524902344,	z = 44.564865112304,	h = 50.926918029786},
	{ label = "Courrir ",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1646.2060546875,	y = 2528.70703125,		z = 44.564865112304,	h = 54.375495910644},
	{ label = "Courrir ",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1647.3669433594,	y = 2530.5427246094,	z = 44.564865112304,	h = 53.448127746582},
	{ label = "Balayez le sol",	duration = 10000, scenario = "WORLD_HUMAN_JANITOR",				x = 1641.8232421875,	y = 2529.7856445312,	z = 44.564865112304,	h = 143.40534973144},
	{ label = "Balayez le sol",	duration = 10000, scenario = "WORLD_HUMAN_JANITOR",				x = 1639.9923095704,	y = 2526.69140625,		z = 44.564865112304,	h = 141.42027282714},
	{ label = "Balayez le sol",	duration = 10000, scenario = "WORLD_HUMAN_JANITOR",				x = 1634.2058105468,	y = 2525.2036132812,	z = 44.564865112304,	h = 53.950496673584},
}


-- Variables 
local isInprison = false
local currentAction = 0
local isDoingAction = false
nActionNeeded = 0 -- Ajout anti-bug
local nActionLeft = nActionNeeded
local initialCoords = nil


-- Functions
local function DrawText3Djail(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
	scale = scale * 1.0
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function newNotif(message, duration)
	Citizen.CreateThread(function()
		SetNotificationTextEntry("STRING")
		AddTextComponentSubstringPlayerName(message)
		if duration then 
		local Notification = DrawNotification(true, true)
		Citizen.Wait(duration)
		RemoveNotification(Notification)
		else DrawNotification(false, false) end
	end)
end

function Exitprison()
	currentAction = 0
	isInprison = false
	isDoingAction = false
	nActionLeft = nActionNeeded

	local distanceFromprison = GetDistanceBetweenCoords(prisonCoords.x, prisonCoords.y, prisonCoords.z, initialCoords.x, initialCoords.y, initialCoords.z, true)
	if distanceFromprison < 50.0 then
		initialCoords = stuckCoords
	end

	SetEntityCoords(GetPlayerPed(-1), initialCoords.x, initialCoords.y, initialCoords.z, 0, 0, 0, 0)
	newNotif(endMessage, 6000)
	SetEntityInvincible(GetPlayerPed(-1), false)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		local isMale = skin.sex == 0
		TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		end)
	end)
end

function SortieDePrison()
	ClearPedTasks(GetPlayerPed(-1))
	DestroyAllProps()
	nActionLeft = nActionLeft - 1
	Exitprison()
end


function SetPedInprison()
	SetEntityInvincible(GetPlayerPed(-1), true)
	local newCoords = {x = prisonCoords.x + (math.random(1, 5) * 1.0), y = prisonCoords.y + (math.random(1, 5) * 1.0), z = prisonCoords.z}
	SetEntityCoords(GetPlayerPed(-1), newCoords.x, newCoords.y, newCoords.z, 0, 0, 0, 0)
	print('Essaye de sortir. Mais n\'y arrive pas')
	newNotif('~r~Vous n\'avez pas le droit de sortir d\'ici ! \nIl vous reste: ~p~' .. nActionLeft .. "/" .. nActionNeeded, 4000)
end

function IsPedOutOfprison(currentPos)
	local distanceFromprison = GetDistanceBetweenCoords(prisonCoords.x, prisonCoords.y, prisonCoords.z, currentPos.x, currentPos.y, currentPos.z, true)
	if distanceFromprison > prisonRadius then
		return true
	else
		return false
	end
end

function IsPedNearAction(currentPos)
	local distanceFromCurrentAction = GetDistanceBetweenCoords(prisonActionCoords[currentAction].x, prisonActionCoords[currentAction].y, prisonActionCoords[currentAction].z, currentPos.x, currentPos.y, currentPos.z, true)
	if distanceFromCurrentAction < 2.0 then
		return true
	else
		return false
	end
end

function SetNewAction()
	local randomNewAction = math.random(1, #prisonActionCoords)
	if currentAction ~= 0 then
		local distBetweenOldAndNewActions = GetDistanceBetweenCoords(prisonActionCoords[currentAction].x, prisonActionCoords[currentAction].y, prisonActionCoords[currentAction].z, prisonActionCoords[randomNewAction].x, prisonActionCoords[randomNewAction].y, prisonActionCoords[randomNewAction].z, true)
		while distBetweenOldAndNewActions < 5.0 do
			randomNewAction = math.random(1, #prisonActionCoords)
			distBetweenOldAndNewActions = GetDistanceBetweenCoords(prisonActionCoords[currentAction].x, prisonActionCoords[currentAction].y, prisonActionCoords[currentAction].z, prisonActionCoords[randomNewAction].x, prisonActionCoords[randomNewAction].y, prisonActionCoords[randomNewAction].z, true)
		end
	end

	newNotif(doingPrefix .. nActionLeft .. "/" .. nActionNeeded .. doingSuffix, 7000)
	currentAction = randomNewAction
end

function OnActionEnd()
	ClearPedTasks(GetPlayerPed(-1))
	DestroyAllProps()
	nActionLeft = nActionLeft - 1
	if nActionLeft <= 0 then
		Exitprison()
	else
		SetNewAction()
	end
end

local PlayerProps = {}
local PlayerHasProp = false

function DestroyAllProps()
	for _,v in pairs(PlayerProps) do
	  DeleteEntity(v)
	end
	PlayerHasProp = false
end

Citizen.CreateThread(function()
	Citizen.Wait(3000)

    while true do
        Citizen.Wait(0)

        if isInprison then
			local currentPos = GetEntityCoords(GetPlayerPed(-1))

			if IsPedNearAction(currentPos) then
				isDoingAction = true
				TaskStartScenarioInPlace(GetPlayerPed(-1), prisonActionCoords[currentAction].scenario, 0, true)
				Citizen.Wait(prisonActionCoords[currentAction].duration)
				OnActionEnd()
				isDoingAction = false
			end
			
			if IsPedOutOfprison(currentPos) then
				SetPedInprison()
			end

			Citizen.Wait(0)
        else
			local currentPos = GetEntityCoords(GetPlayerPed(-1))
			if not IsPedOutOfprison(currentPos) then
				TriggerEvent("Extasy:setInprison", token, maxActions)
			end

            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function ()
	while true do
		if currentAction > 0 and not isDoingAction then
			DrawText3Djail(prisonActionCoords[currentAction].x, prisonActionCoords[currentAction].y, prisonActionCoords[currentAction].z + 1.0, "[~p~Action~w~] ~w~" .. prisonActionCoords[currentAction].label .. "~w~", 255, 255, 255)
			Citizen.Wait(0)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent("Extasy:setInprison")
AddEventHandler("Extasy:setInprison", function(lNewNeeded)
	nActionNeeded = lNewNeeded
	nActionLeft = nActionNeeded

	initialCoords = GetEntityCoords(GetPlayerPed(-1))

	isInprison = true
	SetPedInprison()
	SetNewAction()
	local model = GetEntityModel(GetPlayerPed(-1))
	TriggerEvent('skinchanger:getSkin', function(skin)
	if model == GetHashKey("mp_m_freemode_01") then
		clothesSkin = {
			['bags_1'] = 0, ['bags_2'] = 0,
			['tshirt_1'] = 15, ['tshirt_2'] = 0,
			['torso_1'] = 65, ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 35, ['pants_2'] = 0,
			['shoes_1'] = 6, ['shoes_2'] = 0,
			['mask_1'] = 0, ['mask_2'] = 0,
			['bproof_1'] = 0, ['bproof_2'] = 0,
			['helmet_1'] = -1, ['helmet_2'] = 0
		}
	else
		clothesSkin = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 64,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 41,   ['pants_2'] = 0,
			['shoes_1'] = 4,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = -1,    ['chain_2'] = 0,
			['mask_1'] = -1,  	['mask_2'] = 0,
			['bproof_1'] = 0,  	['bproof_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['bags_1'] = 0,    ['bags_2'] = 0,
			['glasses_1'] = 5,    ['glasses_2'] = 0
		}
	end
	TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
end)
end)

RegisterNetEvent("Extasy:SortieDePrison")
AddEventHandler("Extasy:SortieDePrison", function()
	SortieDePrison()
	isInprison = false
end)

RegisterNetEvent("Extasy:notify")
AddEventHandler("Extasy:notify", function(message, duration)
	newNotif(message, duration)
end)