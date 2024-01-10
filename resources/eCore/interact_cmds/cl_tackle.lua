local isTackling				= false
local isGettingTackled			= false

local tackleLib					= 'missmic2ig_11'
local tackleAnim 				= 'mic_2_ig_11_intro_goon'
local tackleVictimAnim			= 'mic_2_ig_11_intro_p_one'

local lastTackleTime			= 0
local isRagdoll					= false

RegisterNetEvent('tackle:getTackled')
AddEventHandler('tackle:getTackled', function(target)
    print(target)
	isGettingTackled = true

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict(tackleLib)

	while not HasAnimDictLoaded(tackleLib) do
		Wait(10)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, 0.25, 0.5, 0.0, 0.5, 0.5, 180.0, false, false, false, false, 2, false)
	TaskPlayAnim(playerPed, tackleLib, tackleVictimAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)

	Wait(3000)
	DetachEntity(GetPlayerPed(-1), true, false)

    isRagdoll = true
    CreateThread(function()
        while isRagdoll do

            SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)

            Wait(0)
        end
    end)
	Wait(math.random(3000, 10000))
	isRagdoll = false

	isGettingTackled = false
end)

RegisterNetEvent('tackle:playTackle')
AddEventHandler('tackle:playTackle', function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict(tackleLib)

	while not HasAnimDictLoaded(tackleLib) do
		Wait(10)
	end

    TaskPlayAnim(playerPed, tackleLib, tackleAnim, 8.0, -8.0, 3000, 0, 0, false, false, false)

    Wait(3000)
    
    local time = GetGameTimer() + math.random(3000, 10000)
    CreateThread(function()
        while time > GetGameTimer() do

            SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)

            Wait(0)
        end
    end)

	isTackling = false
end)

GetClosestPlayerTackle = function()
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

CreateThread(function()
    while true do
        local need = false

        if playerJob == 'vcpd' then
            need = true
        end

		if playerTryToTackle and not isTackling then
			Wait(10)
			local closestPlayer, distance = GetClosestPlayerTackle()

			if distance ~= -1 and distance <= 1.75 and not isTackling and not isGettingTackled and not IsPedInAnyVehicle(GetPlayerPed(-1)) and not IsPedInAnyVehicle(GetPlayerPed(closestPlayer)) then
				isTackling = true
				lastTackleTime = GetGameTimer()

                TriggerServerEvent('tackle:tryTackle', token, GetPlayerServerId(closestPlayer))
			end
        end
        
        if need then
            Wait(0)
        else
            Wait(1000)
        end
	end
end)