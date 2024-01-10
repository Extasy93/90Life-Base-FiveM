local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0
local bait = "none"
			
CreateThread(function()
	while true do
		Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

CreateThread(function()
	while true do
		Wait(5)
		local stz = false
		if fishing then
			stz = true
			if IsControlJustReleased(0, 38) then
				input = 1
			end
			
			if IsControlJustReleased(0, Keys['X']) then
				fishing = false
				Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~o~Vous arrêtez de pêcher.','CHAR_BOATSITE')
			end

			if fishing then
				playerPed = GetPlayerPed(-1)
				local pos = GetEntityCoords(GetPlayerPed(-1))
				if pos.y >= 6700 or pos.x >= 4300 or IsPedInAnyVehicle(GetPlayerPed(-1)) then
					
				else
					fishing = false
					Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~o~Vous arrêtez de pêcher.','CHAR_BOATSITE')
				end

				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~o~Vous arrêtez de pêcher.','CHAR_BOATSITE')
				end
			end
			
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerServerEvent('fishing:catch', token, bait)
				else
					Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~o~Le poisson s\'est libéré.','CHAR_BOATSITE')
				end
			end
		end

		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fishing.SellFish.x, Fishing.SellFish.y, Fishing.SellFish.z, true) <= 3 then
			TriggerServerEvent('fishing:startSelling', token, "fish")
			stz = true
			Wait(4000)
		end

		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fishing.SellShark.x, Fishing.SellShark.y, Fishing.SellShark.z, true) <= 3 then
			TriggerServerEvent('fishing:startSelling', token, "shark")
			stz = true
			Wait(4000)
		end

		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Fishing.SellTurtle.x, Fishing.SellTurtle.y, Fishing.SellTurtle.z, true) <= 3 then
			TriggerServerEvent('fishing:startSelling', token, "turtle")
			stz = true
			Wait(4000)
		end
		
		if not stz then
			Wait(1000)
		end
	end
end)

CreateThread(function()
	while true do
		local wait = math.random(Fishing.FishTime.a , Fishing.FishTime.b)
		Wait(wait)
		if fishing then
			pause = true
			correct = math.random(1,8)
			if correct == 1 then
				Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~g~Il a mordu l\'hamecon! \n ~h~Touche ~s~1 ~g~ pour l\'attraper','CHAR_BOATSITE')
			else
				Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~g~Il a mordu l\'hamecon! \n ~h~Touche ~s~' .. correct .. '~g~ pour l\'attraper','CHAR_BOATSITE')
			end
			input = 0
			pausetimer = 0
		end
			
	end
end)

RegisterNetEvent('fishing:message')
AddEventHandler('fishing:message', function(message)
	Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche',message,'CHAR_BOATSITE')
end)

RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
	fishing = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('fishing:spawnPed')
AddEventHandler('fishing:spawnPed', function()
	
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
		while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
			Wait( 1 )
		end
	local pos = GetEntityCoords(GetPlayerPed(-1))
	
	local ped = CreatePed_(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('fishing:setbait')
AddEventHandler('fishing:setbait', function(bool)
	bait = bool
end)

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()
	playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	if IsPedInAnyVehicle(playerPed) then
		Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~o~Vous ne pouvez pas pêcher au volant, cong !','CHAR_BOATSITE')
	else
		if pos.y >= 7500 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 then
			Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~g~Vous lancez la partie de pêche.','CHAR_BOATSITE')
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishing = true
		elseif pos.x >= -2951.96 and pos.y >= 5615.68 then
			if pos.x <= -1067.0 and pos.y <= 7742.0 then
				Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~g~Vous lancez la partie de pêche.','CHAR_BOATSITE')
				TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
				fishing = true
			else
				Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~g~Vous n\'êtes pas en zone de pêche.','CHAR_BOATSITE')
			end
		else
			Extasy.ShowAdvancedNotification('Activité Pêche','~y~Partie de pêche','~o~Vous devez vous éloigner de la côte.','CHAR_BOATSITE')
		end
	end
end, false)