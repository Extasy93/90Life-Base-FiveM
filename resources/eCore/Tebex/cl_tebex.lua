ESX 				 = nil
local playerVip      = ""
local firstSpawnAC   = true

RegisterNetEvent("Extasy:sendPlayerGrade")
AddEventHandler("Extasy:sendPlayerGrade", function(vip)
	playerVip = vip
	loadPlayerVip(vip)
	if vip ~= "AUCUN" then
        print("Vous avez le grade ^6'"..playerVip.."'^0, tous les privilèges de ce grade ont été ajoutés")
    end
end)

getPlayerVip = function()
    return playerVip
end

loadPlayerVip = function(data)
	if data == "GOLDEN" then
        extasy_core_cfg["max_vehicle_garage"] 						= 15
        extasy_core_cfg["max_clothes_save"]   						= 10
        extasy_core_cfg["reward_money_service_mult"] 				= 2
		extasy_core_cfg["vehicle_break_mult"] 						= 2
		extasy_core_cfg["player_can_have_ped"] 						= true

        Extasy.ShowNotification("~p~Vos privilèges du grade ~y~GOLDEN~p~ ont été ajoutés !\n~s~Merci pour votre soutien ! ❣️")
    elseif data == "PLATINUM" then
        extasy_core_cfg["max_vehicle_garage"] 						= 20
        extasy_core_cfg["max_clothes_save"]   						= 15
        extasy_core_cfg["reward_money_service_mult"] 				= 3
		extasy_core_cfg["vehicle_break_mult"] 						= 3
        extasy_core_cfg["player_can_have_ped"] 						= true

        Extasy.ShowNotification("~p~Vos privilèges du grade ~g~PLATINUM~p~ ont été ajoutés !\n~s~Merci pour votre soutien ! ❣️")
    elseif data == "DIAMOND" then
        extasy_core_cfg["max_vehicle_garage"] 						= 40
        extasy_core_cfg["max_clothes_save"]   						= 20
        extasy_core_cfg["reward_money_service_mult"] 				= 6
		extasy_core_cfg["vehicle_break_mult"] 						= 5
        extasy_core_cfg["player_can_have_ped"] 						= true

        Extasy.ShowNotification("~p~Vos privilèges du grade ~b~DIAMOND~p~ ont été ajoutés !\n~s~Merci pour votre soutien ! ❣️")
	end
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
	end
end)

--[[Citizen.CreateThread(function()
    while true do
		Extasy.RequestStreamedTextureDict("WEB_PATO_GRANDE26")
        Citizen.Wait(extasy_core_cfg["time_to_send_boutique_notification"]) --toutes les 30min
		Extasy.ShowAdvancedNotificationBoutique(nil, "~p~Nouvelle Boutique", '\nVenez d\'ores et déjà découvrir les nouveautés qui viennent arrivées sur ~p~shop.90Life.fr', "WEB_PATO_GRANDE26", 9)
    end
end)--]]

TriggerEvent('chat:addSuggestion', token, '/delcarplate', 'Supprimer un véhicule possédé par numéro de plaque', {
	{ name="plate", help="Numéro de plaque d'immatriculation du véhicule" }
})

RegisterNetEvent('ExtasyTebex:spawnVehicle')
AddEventHandler('ExtasyTebex:spawnVehicle', function(playerID, model, playerName, type)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local carExist  = false

	ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle)
		if DoesEntityExist(vehicle) then
			carExist = true
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			
			local newPlate     = GeneratePlate()
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
			TriggerServerEvent('ExtasyTebex:setVehicle', token, vehicleProps, playerID)
			ESX.Game.DeleteVehicle(vehicle)	
			if type ~= 'console' then
				Extasy.ShowNotification('le vehicles :' ..model.. 'avec la plaque' ..newPlate.. 'a ete donner a ' ..playerName)
			else
				local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..playerName)
				TriggerServerEvent('ExtasyTebex:printToConsole', token, msg)
			end				
		end		
	end)
	
	Wait(2000)
	if not carExist then
		if type ~= 'console' then
			Extasy.ShowNotification('Le vecicle : ' ..model.. 'est invalide')
		else
			TriggerServerEvent('ExtasyTebex:printToConsole', token, "ERREUR: "..model.." est un modèle de véhicule inconnu")
		end		
	end
end)

RegisterNetEvent('ExtasyTebex:spawnVehiclePlate')
AddEventHandler('ExtasyTebex:spawnVehiclePlate', function(playerID, model, plate, playerName, type)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local generatedPlate = string.upper(plate)
	local carExist  = false

	ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function (isPlateTaken)
		if not isPlateTaken then
			ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle)	
				if DoesEntityExist(vehicle) then
					carExist = true
					SetEntityVisible(vehicle, false, false)
					SetEntityCollision(vehicle, false)	
					
					local newPlate     = string.upper(plate)
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					TriggerServerEvent('ExtasyTebex:setVehicle', token, vehicleProps, playerID)
					ESX.Game.DeleteVehicle(vehicle)
					if type ~= 'console' then
						Extasy.ShowNotification('le vehicles :' ..model.. 'avec la plaque' ..newPlate.. 'a ete donner a ' ..playerName)
					else
						local msg = ('Voiture: ' ..model.. ', plaque: ' ..newPlate.. ', Au joueur: ' ..playerName)
						TriggerServerEvent('ExtasyTebex:printToConsole', token, msg)
					end				
				end
			end)
		else
			carExist = true
			if type ~= 'console' then
				Extasy.ShowNotification('La plaque est deja prise')
			else
				local msg = ('ERREUR: cette plaque est déjà utilisée sur un autre véhicule')
				TriggerServerEvent('ExtasyTebex:printToConsole', token, msg)
			end					
		end
	end, generatedPlate)
	
	Wait(2000)
	if not carExist then
		if type ~= 'console' then
			Extasy.ShowNotification('Le vecicle : ' ..model.. 'est invalide')
		else
			TriggerServerEvent('ExtasyTebex:printToConsole', token, "ERREUR: "..model.." est un modèle de véhicule inconnu")
		end		
	end	
end)

RegisterNetEvent('ExtasyTebex:spawnVehiclePlate2')
AddEventHandler('ExtasyTebex:spawnVehiclePlate2', function(playerID, model, plate, playerName, type)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local generatedPlate = string.upper(plate)
	local carExist  = false

	ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function (isPlateTaken)
		if not isPlateTaken then
			ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle)	
				if DoesEntityExist(vehicle) then
					carExist = true
					SetEntityVisible(vehicle, false, false)
					SetEntityCollision(vehicle, false)	
					
					local newPlate     = string.upper(plate)
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					TriggerServerEvent('ExtasyTebex:setVehicle2', token, vehicleProps, playerID)
					ESX.Game.DeleteVehicle(vehicle)
					if type ~= 'console' then
						Extasy.ShowNotification('le vehicles :' ..model.. 'avec la plaque' ..newPlate.. 'a ete donner a ' ..playerName)
					else
						--local msg = ('Voiture: ' ..model.. ', plaque: ' ..newPlate.. ', Au joueur: ' ..playerName)
						--TriggerServerEvent('ExtasyTebex:printToConsole', token, msg)
					end				
				end
			end)
		else
			carExist = true
			if type ~= 'console' then
				Extasy.ShowNotification('La plaque est deja prise')
			else
				local msg = ('ERREUR: cette plaque est déjà utilisée sur un autre véhicule')
				TriggerServerEvent('ExtasyTebex:printToConsole', token, msg)
			end					
		end
	end, generatedPlate)
	
	Wait(2000)
	if not carExist then
		if type ~= 'console' then
			Extasy.ShowNotification('Le vecicle : ' ..model.. 'est invalide')
		else
			TriggerServerEvent('ExtasyTebex:printToConsole', token, "ERREUR: "..model.." est un modèle de véhicule inconnu")
		end		
	end	
end)

RegisterCommand('grade', function(source, args)
	TriggerServerEvent("Extasy:getPlayerGrade", token)
	Wait(2000)
    print(playerVip)
end)

RegisterCommand('refreshmygrade', function(source, args)
	TriggerServerEvent("Extasy:getPlayerGrade", token)
end)