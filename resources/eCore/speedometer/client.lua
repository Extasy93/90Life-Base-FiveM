local ind = {l = false, r = false}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)
		local sleep = true
		local Ped = PlayerPedId()
		if(IsPedInAnyVehicle(Ped)) then
			sleep = false
			letsgo()
		else
			SendNUIMessage({
				showhud = false
			})
		end

		if sleep then
			Citizen.Wait(5000)
		end
	end
end)

function letsgo()
	local Ped = GetPlayerPed(-1)
	local PedCar = GetVehiclePedIsIn(Ped, false)

	if(IsPedInAnyVehicle(Ped)) then
		if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
			carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
			fuel = GetVehicleFuelLevel(PedCar)
			SendNUIMessage({
			showfuel = true,
				fuel = fuel
			})
		end
	end

	if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
		carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
		SendNUIMessage({
			showhud = true,
			speed = carSpeed,
			fuel = GetVehicleFuelLevel(PedCar),
		})
	end
end

function letsgo2()
	local Ped = PlayerPedId()
	local PedCar = GetVehiclePedIsIn(Ped, false)
	if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
		carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
		SendNUIMessage({
			showhud = false
		})
	end
end

function showHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

RegisterNetEvent('letsgoHUD')
AddEventHandler('letsgoHUD', function()
	letsgo()
end)

RegisterNetEvent('letsgoHUD2')
AddEventHandler('letsgoHUD2', function()
	letsgo2()
end)


