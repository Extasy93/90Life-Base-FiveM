ESX = nil
local CurrentCheckPoint     = 0
local DriveErrors 		    = 0
local LastCheckPoint        = -1
local CurrentBlip           = nil
local CurrentZoneType       = nil
local IsAboveSpeedLimit     = false
local VehicleHealth     	= nil
local success               = false
local pieton                = false
local startedconduite 		= false
local drivetest 			= nil
local CurrentTest           = nil
local CurrentTestType       = nil
local index    				= 1
permisencours 				= ""

local CheckPointsBoat = {

	{
		Pos = {x = 2856.7612304688, y = 5038.9750976563, z = 0.44443547725677},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)

		end
	},

	{
		Pos = {x = 2932.7512207031, y = 5256.0830078125, z = 0.4950744628906},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)

		end
	},

	{
		Pos = {x = 3097.5815429688, y = 5404.5405273438, z = 0.4792991399765},
		Action = function(playerPed, setCurrentZoneType)
			Citizen.CreateThread(function()
				DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)
	
			end)
		end
	},

	{
		Pos = {x = 3415.6665039063, y = 5575.5014648438, z = 0.4088196396827698},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)

		end
	},

	{
		Pos = {x = 3542.8444824219, y = 5753.802734375, z = 0.4296852588654},
        Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)

		end
	},

	{
		Pos = {x = 3645.8874511719, y = 6221.65625, z = 0.40474200248718},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)

		end
	},

	{
		Pos = {x = 3436.6520996094, y = 6581.7094726563, z = 0.4421151638031},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)

		end
	},

	{
		Pos = {x = 3124.6240234375, y = 6554.6328125, z = 0.426651173830032},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)

		end
	},

	{
		Pos = {x = 2795.7744140625, y = 6236.8037109375, z = 0.45124573707581},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)

		end
	}, 

	{
		Pos = {x = 2500.849609375, y = 5717.8110351563, z = 0.486462289094925},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)

		end
	},

	{
		Pos = {x = 2619.7619628906, y = 5280.98046875, z = 0.42627763748169},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au dernier point de passage', 5000)

		end
	},

	{
		Pos = {x = 2843.7807617188, y = 4845.4487304688, z = 0.49660266637802},
		Action = function(playerPed, setCurrentZoneType)
			startedconduite = false
			if DriveErrors < 5 then
				StopDriveTestBoat(true)
			else
				StopDriveTestBoat(false)
			end
		end
	},
}

local CheckPoints = {

	{
		Pos = {x = 3748.2739257813, y = 6226.6665039063, z = 9.5426454544067},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage! Vitesse limite: ~y~80~s~ km/h', 5000)
			goBackVehicle = 0
		end
	},

	{
		Pos = {x = 3692.7048339844, y = 6442.8012695313, z = 10.0411195755},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3598.2407226563, y = 6447.7387695313, z = 9.593768119812},
		Action = function(playerPed, setCurrentZoneType)
			Citizen.CreateThread(function()
				DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)
				goBackVehicle = 1
			end)
		end
	},

	{
		Pos = {x = 3629.9462890625, y = 6860.5903320313, z = 9.6614713668823},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~g~Bien !~s~ prenez à ~y~gauche~s~ et suivez la route', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3562.0258789063, y = 7060.189453125, z = 9.5396842956543},
        Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Tournez à droite pour rejoindre le prochain point !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3659.255859375, y = 6886.2573242188, z = 9.8705434799194},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3713.4528808594, y = 6702.1875, z = 10.112914085388},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3676.7165527344, y = 6453.8193359375, z = 10.26465511322},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez à gauche et rendez vous vers le prochain passage !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3743.2631835938, y = 6310.896484375, z = 9.3659191131592},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au dernier point de passage !', 5000)
			goBackVehicle = 1
		end
	},	

	{
		Pos = {x = 3781.3017578125, y = 6102.1411132813, z = 9.2000093460083},
		Action = function(playerPed, setCurrentZoneType)
			startedconduite = false
			if DriveErrors < 5 then
				StopDriveTest(true)
			else
				StopDriveTest(false)
			end
		end
	},
}

local CheckPointsCamion = {

	{
		Pos = {x = 3748.2739257813, y = 6226.6665039063, z = 9.5426454544067},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage! Vitesse limite: ~y~80~s~ km/h', 5000)
			goBackVehicle = 0
		end
	},

	{
		Pos = {x = 3692.7048339844, y = 6442.8012695313, z = 10.0411195755},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3598.2407226563, y = 6447.7387695313, z = 9.593768119812},
		Action = function(playerPed, setCurrentZoneType)
			Citizen.CreateThread(function()
				DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)
				goBackVehicle = 1
			end)
		end
	},

	{
		Pos = {x = 3629.9462890625, y = 6860.5903320313, z = 9.6614713668823},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~g~Bien !~s~ prenez à ~y~gauche~s~ et suivez la route', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3562.0258789063, y = 7060.189453125, z = 9.5396842956543},
        Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Tournez à droite pour rejoindre le prochain point !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3659.255859375, y = 6886.2573242188, z = 9.8705434799194},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3713.4528808594, y = 6702.1875, z = 10.112914085388},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3676.7165527344, y = 6453.8193359375, z = 10.26465511322},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez à gauche et rendez vous vers le prochain passage !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3743.2631835938, y = 6310.896484375, z = 9.3659191131592},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au dernier point de passage !', 5000)
			goBackVehicle = 1
		end
	},	

	{
		Pos = {x = 3781.3017578125, y = 6102.1411132813, z = 9.2000093460083},
		Action = function(playerPed, setCurrentZoneType)
			startedconduite = false
			if DriveErrors < 5 then
				StopDriveTest(true)
			else
				StopDriveTest(false)
			end
		end
	},
}

local CheckPointsMoto = {

	{
		Pos = {x = 3748.2739257813, y = 6226.6665039063, z = 9.5426454544067},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage! Vitesse limite: ~y~80~s~ km/h', 5000)
			goBackVehicle = 0
		end
	},

	{
		Pos = {x = 3692.7048339844, y = 6442.8012695313, z = 10.0411195755},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3598.2407226563, y = 6447.7387695313, z = 9.593768119812},
		Action = function(playerPed, setCurrentZoneType)
			Citizen.CreateThread(function()
				DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)
				goBackVehicle = 1
			end)
		end
	},

	{
		Pos = {x = 3629.9462890625, y = 6860.5903320313, z = 9.6614713668823},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~g~Bien !~s~ prenez à ~y~gauche~s~ et suivez la route', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3562.0258789063, y = 7060.189453125, z = 9.5396842956543},
        Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Tournez à droite pour rejoindre le prochain point !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3659.255859375, y = 6886.2573242188, z = 9.8705434799194},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au prochain point de passage', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3713.4528808594, y = 6702.1875, z = 10.112914085388},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez vers le prochain passage !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3676.7165527344, y = 6453.8193359375, z = 10.26465511322},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez à gauche et rendez vous vers le prochain passage !', 5000)
			goBackVehicle = 1
		end
	},

	{
		Pos = {x = 3743.2631835938, y = 6310.896484375, z = 9.3659191131592},
		Action = function(playerPed, setCurrentZoneType)
			DrawMissionText('~r~Moniteur : ~s~Allez au dernier point de passage !', 5000)
			goBackVehicle = 1
		end
	},	

	{
		Pos = {x = 3781.3017578125, y = 6102.1411132813, z = 9.2000093460083},
		Action = function(playerPed, setCurrentZoneType)
			startedconduite = false
			if DriveErrors < 5 then
				StopDriveTest(true)
			else
				StopDriveTest(false)
			end
		end
	},
}

local AutoEcole_in_menu = false
local AutoEcoleBoat_in_menu = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Wait(0)
	end
end)

RMenu.Add("ecole_boat", "ecole_boat_main", RageUI.CreateMenu("Auto-école Vice City", "Que souhaitez-vous faire ?"))
RMenu:Get('ecole_boat', 'ecole_boat_main').Closed = function()
	AutoEcole_in_menu = false
end

openAutoEcole = function()  
    if not AutoEcole_in_menu then 
        AutoEcole_in_menu = true
		RageUI.Visible(RMenu:Get('ecole_boat', 'ecole_boat_main'), true)

		Citizen.CreateThread(function()
			while AutoEcole_in_menu do
				Wait(1)
				RageUI.IsVisible(RMenu:Get("ecole_boat",'ecole_boat_main'),true,false,true,function()
					
					RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index = Index
                    end)

					RageUI.Separator("~p~← Permis disponibles →")

					RageUI.ButtonWithStyle("Passer le permis moto", nil, { RightLabel = extasy_core_cfg["permis_price_moto"].."$" }, true, function(_, _, Selected)
						if Selected then
							TriggerServerEvent("Extasy:payPermis", token, index, extasy_core_cfg["permis_price_moto"], 1, "Permis_moto")
							Addbank_transac("Permis de conduire (moto)", Extasy.Math.GroupDigits(1000), "out")
							AutoEcole_in_menu = false
							RageUI.CloseAll()
						end
					end)

					RageUI.ButtonWithStyle("Passer le permis voiture", nil, { RightLabel = extasy_core_cfg["permis_price_voiture"].."$" }, true, function(_, _, Selected)
						if Selected then
							TriggerServerEvent("Extasy:payPermis", token, index, extasy_core_cfg["permis_price_voiture"], 2, "Permis_voiture")
							Addbank_transac("Permis de conduire (voiture)", Extasy.Math.GroupDigits(1200), "out")
							AutoEcole_in_menu = false
							RageUI.CloseAll()
						end
					end)

					RageUI.ButtonWithStyle("Passer le permis camion", nil, { RightLabel = extasy_core_cfg["permis_price_camion"].."$" }, true, function(_, _, Selected)
						if Selected then
							TriggerServerEvent("Extasy:payPermis", token, index, extasy_core_cfg["permis_price_camion"], 3, "Permis_camion")
							Addbank_transac("Permis de conduire (camion)", Extasy.Math.GroupDigits(1500), "out")
							AutoEcole_in_menu = false
							RageUI.CloseAll()
						end
					end)
				end, function()
				end)   
			end
		end)
	end
end

RMenu.Add("auto_ecole_boat", "main", RageUI.CreateMenu("Permis","Bienvenue à l'Auto Ecole"))
RMenu:Get('auto_ecole_boat', 'main').Closed = function()
	AutoEcoleBoat_in_menu = false
end

openAutoEcoleBoat = function()  
    if not AutoEcoleBoat_in_menu then 
        AutoEcoleBoat_in_menu = true
		RageUI.Visible(RMenu:Get('auto_ecole_boat', 'main'), true)

		Citizen.CreateThread(function()
			while AutoEcoleBoat_in_menu do
				Wait(1)
				RageUI.IsVisible(RMenu:Get("auto_ecole_boat",'main'),true,false,true,function()

					RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index = Index
                    end)

					RageUI.Separator("~p~← Permis disponibles →")

					RageUI.Button("Passer le permis bateau", nil, {RightLabel = extasy_core_cfg["permis_price_bateau"].."$"}, true, function(_, _, Selected)
						if Selected then
							TriggerServerEvent("Extasy:payPermis", token, index, extasy_core_cfg["permis_price_bateau"], 4, "Permis_bateau")
							Addbank_transac("Permis de conduire (Bateau)", Extasy.Math.GroupDigits(2000), "out")
							AutoEcoleBoat_in_menu = false
							RageUI.CloseAll()
						end
					end)

				end, function()
				end)   
			end
		end)
	end
end

StopDriveTest = function(success)
	if success then
		if permisencours == "Voiture" then
			TriggerServerEvent('Extasy:addItemPermis', token, "Permis_voiture")
		elseif permisencours == "Moto" then
			TriggerServerEvent('Extasy:addItemPermis', token, "Permis_moto")
		elseif permisencours == "Camion" then 
			TriggerServerEvent('Extasy:addItemPermis', token, "Permis_camion")
		end
			
		RemoveBlip(CurrentBlip)

		Extasy.ShowAdvancedNotification('Safia', '~g~Bravo', 'Vous avez reçu votre permis !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')

		if DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), false)) then
			DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
			SetVehicleAsNoLongerNeeded(GetVehiclePedIsIn(PlayerPedId(), false))
		end

		if DoesEntityExist(pedssss) then
			DeleteEntity(pedssss)
		end
	else
		if DoesEntityExist(pedssss) then
			DeleteEntity(pedssss)
		end

		Extasy.ShowAdvancedNotification('Safia', '~r~Malheureusement', 'Vous avez raté le test !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')	

		if DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), false)) then
			DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
			SetVehicleAsNoLongerNeeded(GetVehiclePedIsIn(PlayerPedId(), false))
		end
	end

	SetEntityCoords(pietonped, 3779.785, 6085.504, 12.2967, false, false, false, true)
	SetEntityHeading(pietonped, 357.62)

	CurrentTest     = nil
	CurrentTestType = nil
end

StopDriveTestBoat = function(success)
	if success then
		if permisencours == "Bateau" then
			TriggerServerEvent('Extasy:addItemPermis', token, "Permis_bateau")
		end
			
		RemoveBlip(CurrentBlip)
		Extasy.ShowAdvancedNotification('Ivan', '~g~Bravo', 'Vous avez reçu votre permis !', 'CHAR_BOATSITE2', 'CHAR_BOATSITE2')
		if DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), false)) then
			DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
			SetVehicleAsNoLongerNeeded(GetVehiclePedIsIn(PlayerPedId(), false))
			SetEntityCoords(PlayerPedId(), 2854.82, 4844.021, 7.074506, false, false, false, true)
			SetEntityHeading(PlayerPedId(), 90.1131820678711)
		end
		if DoesEntityExist(pedssss) then
			DeleteEntity(pedssss)
		end
	else
		if DoesEntityExist(pedssss) then
			DeleteEntity(pedssss)
		end
		Extasy.ShowAdvancedNotification('Ivan', '~r~Malheureusement', 'Vous avez raté le test !', 'CHAR_BOATSITE2', 'CHAR_BOATSITE2')			
		if DoesEntityExist(GetVehiclePedIsIn(PlayerPedId(), false)) then
			DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
			SetVehicleAsNoLongerNeeded(GetVehiclePedIsIn(PlayerPedId(), false))
			SetEntityCoords(PlayerPedId(), 2854.82, 4844.021, 7.074506, false, false, false, true)
			SetEntityHeading(PlayerPedId(), 90.1131820678711)
		end
	end
	CurrentTest     = nil
	CurrentTestType = nil
end

StartConduite = function()
	startedconduite = true
	Extasy.ShowAdvancedNotification('Safia', 'Me voilà !', 'Tenez votre voiture, bonne route et bonne chance !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
	while startedconduite do
		Wait(0)

		if CurrentTest == 'drive' then

			local nextCheckPoint = CurrentCheckPoint + 1

			if CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				while not IsPedheadshotReady(RegisterPedheadshot(PlayerPedId())) or not IsPedheadshotValid(RegisterPedheadshot(PlayerPedId())) do
					Wait(100)
				end
		
				BeginTextCommandThefeedPost("PS_UPDATE")
				AddTextComponentInteger(50)
			
				EndTextCommandThefeedPostStats("PSF_DRIVING", 14, 50, 25, false, GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())), GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())))
			
				EndTextCommandThefeedPostTicker(false, true)
				
				UnregisterPedheadshot(RegisterPedheadshot(PlayerPedId()))

			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 90.0 then
					DrawMarker(6, CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					CheckPoints[nextCheckPoint].Action(PlayerPedId(), SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end

			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then

				local vehicle      = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				local speed        = GetEntitySpeed(vehicle) * 3.6
				local tooMuchSpeed = false
				local GetSpeed = math.floor(GetEntitySpeed(vehicle) * 3.6)
				local speed_limit_residence = 80.0
				local speed_limit_ville = 80.0
				local speed_limit_otoroute = 120.0

				local DamageControl = 0

				if goBackVehicle == 0 and GetSpeed >= speed_limit_residence then
					tooMuchSpeed 	  = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_residence.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000) -- evite bug
				end

				if goBackVehicle == 1 and GetSpeed >= speed_limit_ville then
					tooMuchSpeed = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_ville.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if goBackVehicle == 2 and GetSpeed >= speed_limit_otoroute then
					tooMuchSpeed = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_otoroute.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if HasEntityCollidedWithAnything(vehicle) and DamageControl == 0 then
					DriveErrors       = DriveErrors + 1
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Votre vehicule s\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				if GetEntityHealth(vehicle) < GetEntityHealth(vehicle) then

					DriveErrors = DriveErrors + 1

					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Votre vehicule s\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					
					VehicleHealth = GetEntityHealth(vehicle)
					Wait(2000)
				end
				if DriveErrors >= 5 then
					CurrentCheckPoint = 10
					RemoveBlip(CurrentBlip)
					SetNewWaypoint(204.82, 377.133)
					DrawMarker(36, 204.82, 377.133, 107.24, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
					local dist = Vdist2(GetEntityCoords(PlayerPedId()), 204.82, 377.133, 107.24)
					if dist <= 2.5 then
						Extasy.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour rendre le véhicule.")
						if IsControlJustPressed(0, 51) then
							StopDriveTest(false)
							DriveErrors = 0
							CurrentCheckPoint = 0
							RemoveBlip(CurrentBlip)
						end
					end
				end
			end
		else
			Wait(500)
		end
	end
end

StartConduiteCamion = function()
	startedconduite = true
	Extasy.ShowAdvancedNotification('Safia', 'Me voilà !', 'Tenez votre camion, bonne route et bonne chance !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
	while startedconduite do
		Wait(0)

		if CurrentTest == 'camion' then

			local nextCheckPoint = CurrentCheckPoint + 1

			if CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				while not IsPedheadshotReady(RegisterPedheadshot(PlayerPedId())) or not IsPedheadshotValid(RegisterPedheadshot(PlayerPedId())) do
					Wait(100)
				end
		
				BeginTextCommandThefeedPost("PS_UPDATE")
				AddTextComponentInteger(50)
			
				EndTextCommandThefeedPostStats("PSF_DRIVING", 14, 50, 25, false, GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())), GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())))
			
				EndTextCommandThefeedPostTicker(false, true)
				
				UnregisterPedheadshot(RegisterPedheadshot(PlayerPedId()))

			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(CheckPointsCamion[nextCheckPoint].Pos.x, CheckPointsCamion[nextCheckPoint].Pos.y, CheckPointsCamion[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 90.0 then
					DrawMarker(6, CheckPointsCamion[nextCheckPoint].Pos.x, CheckPointsCamion[nextCheckPoint].Pos.y, CheckPointsCamion[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					CheckPointsCamion[nextCheckPoint].Action(PlayerPedId(), SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end

			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then

				local vehicle      = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				local speed        = GetEntitySpeed(vehicle) * 3.6
				local tooMuchSpeed = false
				local GetSpeed = math.floor(GetEntitySpeed(vehicle) * 3.6)
				local speed_limit_residence = 60.0
				local speed_limit_ville = 80.0
				local speed_limit_otoroute = 120.0

				local DamageControl = 0

				if goBackVehicle == 0 and GetSpeed >= speed_limit_residence then
					tooMuchSpeed 	  = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_residence.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000) -- evite bug
				end

				if goBackVehicle == 1 and GetSpeed >= speed_limit_ville then
					tooMuchSpeed = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_ville.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if goBackVehicle == 2 and GetSpeed >= speed_limit_otoroute then
					tooMuchSpeed = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_otoroute.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if HasEntityCollidedWithAnything(vehicle) and DamageControl == 0 then
					DriveErrors       = DriveErrors + 1
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Votre vehicule s\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				if GetEntityHealth(vehicle) < GetEntityHealth(vehicle) then

					DriveErrors = DriveErrors + 1

					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Votre vehicule s\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					
					VehicleHealth = GetEntityHealth(vehicle)
					Wait(2000)
				end
				if DriveErrors >= 5 then
					CurrentCheckPoint = 10
					RemoveBlip(CurrentBlip)
					SetNewWaypoint(204.82, 377.133)
					DrawMarker(36, 204.82, 377.133, 107.24, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
					local dist = Vdist2(GetEntityCoords(PlayerPedId()), 204.82, 377.133, 107.24)
					if dist <= 2.5 then
						Extasy.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour rendre le véhicule.")
						if IsControlJustPressed(0, 51) then
							StopDriveTest(false)
							DriveErrors = 0
							CurrentCheckPoint = 0
							RemoveBlip(CurrentBlip)
						end
					end
				end
			end
		else
			Wait(500)
		end
	end
end

StartConduiteMoto = function()
	startedconduite = true
	Extasy.ShowAdvancedNotification('Safia', 'Me voilà !', 'Tenez votre moto, bonne route et bonne chance !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
	while startedconduite do
		Wait(0)

		if CurrentTest == 'moto' then

			local nextCheckPoint = CurrentCheckPoint + 1

			if CheckPointsMoto[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				while not IsPedheadshotReady(RegisterPedheadshot(PlayerPedId())) or not IsPedheadshotValid(RegisterPedheadshot(PlayerPedId())) do
					Wait(100)
				end
		
				BeginTextCommandThefeedPost("PS_UPDATE")
				AddTextComponentInteger(50)
			
				EndTextCommandThefeedPostStats("PSF_DRIVING", 14, 50, 25, false, GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())), GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())))
			
				EndTextCommandThefeedPostTicker(false, true)
				
				UnregisterPedheadshot(RegisterPedheadshot(PlayerPedId()))

			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(CheckPointsMoto[nextCheckPoint].Pos.x, CheckPointsMoto[nextCheckPoint].Pos.y, CheckPointsMoto[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 90.0 then
					DrawMarker(6, CheckPointsMoto[nextCheckPoint].Pos.x, CheckPointsMoto[nextCheckPoint].Pos.y, CheckPointsMoto[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					CheckPointsMoto[nextCheckPoint].Action(PlayerPedId(), SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end

			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then

				local vehicle      = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				local speed        = GetEntitySpeed(vehicle) * 3.6
				local tooMuchSpeed = false
				local GetSpeed = math.floor(GetEntitySpeed(vehicle) * 3.6)
				local speed_limit_residence = 60.0
				local speed_limit_ville = 80.0
				local speed_limit_otoroute = 120.0

				local DamageControl = 0

				if goBackVehicle == 0 and GetSpeed >= speed_limit_residence then
					tooMuchSpeed 	  = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_residence.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000) -- evite bug
				end

				if goBackVehicle == 1 and GetSpeed >= speed_limit_ville then
					tooMuchSpeed = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_ville.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if goBackVehicle == 2 and GetSpeed >= speed_limit_otoroute then
					tooMuchSpeed = true
					DriveErrors       = DriveErrors + 1
					IsAboveSpeedLimit = true
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Vous roulez trop vite, vitesse limite : " ..speed_limit_otoroute.. " km/h~w~!\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if HasEntityCollidedWithAnything(vehicle) and DamageControl == 0 then
					DriveErrors       = DriveErrors + 1
					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Votre vehicule s\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					Wait(2000)
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				if GetEntityHealth(vehicle) < GetEntityHealth(vehicle) then

					DriveErrors = DriveErrors + 1

					Extasy.ShowAdvancedNotification('Safia', '~r~Vous avez fait une erreur', "Votre vehicule s\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')
					
					VehicleHealth = GetEntityHealth(vehicle)
					Wait(2000)
				end
				if DriveErrors >= 5 then
					CurrentCheckPoint = 10
					RemoveBlip(CurrentBlip)
					SetNewWaypoint(204.82, 377.133)
					DrawMarker(36, 204.82, 377.133, 107.24, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
					local dist = Vdist2(GetEntityCoords(PlayerPedId()), 204.82, 377.133, 107.24)
					if dist <= 2.5 then
						Extasy.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour rendre le véhicule.")
						if IsControlJustPressed(0, 51) then
							StopDriveTest(false)
							DriveErrors = 0
							CurrentCheckPoint = 0
							RemoveBlip(CurrentBlip)
						end
					end
				end
			end
		else
			Wait(500)
		end
	end
end

StartConduiteBoat = function()
	startedconduite = true
	while startedconduite do
		Wait(0)

		if CurrentTest == 'boat' then

			local nextCheckPoint = CurrentCheckPoint + 1

			if CheckPointsBoat[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				while not IsPedheadshotReady(RegisterPedheadshot(PlayerPedId())) or not IsPedheadshotValid(RegisterPedheadshot(PlayerPedId())) do
					Wait(100)
				end
		
				BeginTextCommandThefeedPost("PS_UPDATE")
				AddTextComponentInteger(50)
			
				EndTextCommandThefeedPostStats("PSF_DRIVING", 14, 50, 25, false, GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())), GetPedheadshotTxdString(RegisterPedheadshot(PlayerPedId())))
			
				EndTextCommandThefeedPostTicker(false, true)
				
				UnregisterPedheadshot(RegisterPedheadshot(PlayerPedId()))

			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(CheckPointsBoat[nextCheckPoint].Pos.x, CheckPointsBoat[nextCheckPoint].Pos.y, CheckPointsBoat[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), CheckPointsBoat[nextCheckPoint].Pos.x, CheckPointsBoat[nextCheckPoint].Pos.y, CheckPointsBoat[nextCheckPoint].Pos.z, true)

				if distance <= 90.0 then
					DrawMarker(35, CheckPointsBoat[nextCheckPoint].Pos.x, CheckPointsBoat[nextCheckPoint].Pos.y, CheckPointsBoat[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 5.5, 5.5, 5.5, 152, 195, 230, 255, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					CheckPointsBoat[nextCheckPoint].Action(PlayerPedId(), SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end

			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then

				local vehicle      = GetVehiclePedIsIn(GetPlayerPed(-1), false)
				local DamageControl = 0

				if HasEntityCollidedWithAnything(vehicle) and DamageControl == 0 then
					--DriveErrors       = DriveErrors + 1
					--Extasy.ShowAdvancedNotification('Ivan', '~r~Vous avez fait une erreur', "Votre vehicule s\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_BOATSITE2', 'CHAR_BOATSITE2')
					Wait(2000)
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				if GetEntityHealth(vehicle) < GetEntityHealth(vehicle) then

					--DriveErrors = DriveErrors + 1

					--Extasy.ShowAdvancedNotification('Ivan', '~r~Vous avez fait une erreur', "Votre vehicule s\'est pris des dégats\n~r~Nombre d'erreurs " ..DriveErrors.. "/5", 'CHAR_BOATSITE2', 'CHAR_BOATSITE2')
					
					VehicleHealth = GetEntityHealth(vehicle)
					Wait(2000)
				end
				if DriveErrors >= 5 then
					CurrentCheckPoint = 11
					RemoveBlip(CurrentBlip)
					SetNewWaypoint(2842.408, 4844.193)
					DrawMarker(36, 2842.408, 4844.193, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
					local dist = Vdist2(GetEntityCoords(PlayerPedId()), 2842.408, 4844.193, 0.0)
					if dist <= 2.5 then
						Extasy.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour rendre le véhicule.")
						if IsControlJustPressed(0, 51) then
							StopDriveTest(false)
							DriveErrors = 0
							CurrentCheckPoint = 0
							RemoveBlip(CurrentBlip)
						end
					end
				end
			end
		else
			Wait(500)
		end
	end
end

RegisterNetEvent('StartDriveVoiture')
AddEventHandler('StartDriveVoiture', function()
	CurrentTest       = 'drive'
	CurrentTestType   = type
	startedconduite	  = true
    permisencours     = "Voiture"
	drivetest         = "voiture"

	RequestModel(GetHashKey("issi3"))

	while not HasModelLoaded(GetHashKey("issi3")) do
        Wait(100)
    end

	local veh = CreateVehicle(GetHashKey("issi3"), 3784.45, 6107.64, 9.36, 72.42, 1, 0)
	TaskEnterVehicle(GetPlayerPed(-1), veh, 20000, -1, 2.0, 3, 0)

	RequestModel(0x242C34A7)
    while not HasModelLoaded(0x242C34A7) do
        Wait(100)
	end
	
	pedssss = CreatePedInsideVehicle(veh, 5, 0x242C34A7, 0, true, false)
	SetEntityAsMissionEntity(pedssss, 0, 0)
	Wait(2000)
	Extasy.ShowAdvancedNotification('Safia', 'Me voilà !', 'Tenez votre voiture, bonne route et bonne chance !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')

	StartConduite()
end)

RegisterNetEvent('StartDriveMoto')
AddEventHandler('StartDriveMoto', function()
	CurrentTest 	= 'moto'
	startedconduite = true
	permisencours   = "Moto"
	drivetest       = "moto"

	RequestModel(GetHashKey("bati"))

	while not HasModelLoaded(GetHashKey("bati")) do
        Wait(100)
	end
	
    local veh = CreateVehicle(GetHashKey("bati"), 3789.35, 6120.91, 8.63, 97.52, 1, 0)
	TaskEnterVehicle(GetPlayerPed(-1), veh, 20000, -1, 2.0, 3, 0)

	RequestModel(0x242C34A7)
    while not HasModelLoaded(0x242C34A7) do
        Wait(100)
	end
	pedssss = CreatePedInsideVehicle(veh, 5, 0x242C34A7, 0, true, false)
	SetEntityAsMissionEntity(pedssss, 0, 0)
	Wait(3000)

	StartConduiteMoto()
end)

RegisterNetEvent('StartDriveCamion')
AddEventHandler('StartDriveCamion', function()
	CurrentTest = 'camion'
	permisencours = "Camion"
	drivetest = "camion"

	startedconduite = true

	RequestModel(GetHashKey("mule"))

	while not HasModelLoaded(GetHashKey("mule")) do
        Wait(100)
	end
	
    local veh = CreateVehicle(GetHashKey("mule"), 3781.5378417969, 6109.5029296875, 9.440544128418, 79.13917541503906, 1, 0)
	TaskEnterVehicle(GetPlayerPed(-1), veh, 20000, -1, 2.0, 3, 0)

	RequestModel(0x242C34A7)
    while not HasModelLoaded(0x242C34A7) do
        Wait(100)
	end
	pedssss = CreatePedInsideVehicle(veh, 5, 0x242C34A7, 0, true, false)
	SetEntityAsMissionEntity(pedssss, 0, 0)
	Wait(2000)
	Extasy.ShowAdvancedNotification('Safia', 'Me voilà !', 'Tenez votre camion, bonne route et bonne chance !', 'CHAR_HITCHER_GIRL', 'CHAR_HITCHER_GIRL')

	StartConduiteCamion()
end)

RegisterNetEvent('StartDriveBateau')
AddEventHandler('StartDriveBateau', function()
	CurrentTest       = 'boat'
	CurrentTestType   = type
	startedconduite = true
    permisencours = "Bateau"
	drivetest = "bateau"

	RequestModel(GetHashKey("suntrap"))

	while not HasModelLoaded(GetHashKey("suntrap")) do
        Wait(100)
    end

	local veh = CreateVehicle(GetHashKey("suntrap"), 2842.408, 4844.193, 0.0, 0.15571838617324, 1, 0)
	TaskEnterVehicle(GetPlayerPed(-1), veh, 20000, -1, 2.0, 3, 0)

	RequestModel(0xC85F0A88)
    while not HasModelLoaded(0xC85F0A88) do
        Wait(100)
	end
	
	pedssss = CreatePedInsideVehicle(veh, 5, 0xC85F0A88, 0, true, false)
	SetEntityAsMissionEntity(pedssss, 0, 0)
	Wait(2000)
	Extasy.ShowAdvancedNotification('Ivan', '~o~Me voilà !', 'Tenez votre bateau, bonne navigation et bonne chance !', 'CHAR_BOATSITE2', 'CHAR_BOATSITE2')

	StartConduiteBoat()
end)

SetCurrentZoneType = function(type)
    CurrentZoneType = type
end