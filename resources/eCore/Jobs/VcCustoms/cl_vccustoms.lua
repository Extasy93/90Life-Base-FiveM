ESX = nil
local Blips = {}
local CurrentlyTowedVehicle = nil
local isBusy = false
local VcCustoms_in_menu_garage = false
local VcCustoms_in_menu_vestiaire = false
local VcCustoms_in_menu = false
local VcCustoms_in_menu_chest = false
local menu_transormation_kit = false
local transormation_kit = false
local menu_recolte_Piece_vccustoms = false
local recolte_Piece_vccustoms = false

--local rgbArray = {}
local Vehicles = {}
local PlayerData = {}
local lsMenuIsShowed = false
local isInLSMarker = false
local myCar = {}
local vehicleClass = nil
local vehiclePrice = 50000

local shopProfitValue = 0
local shopProfit = 10
local shopCart = {}
local totalCartValue = 0
local canClose = false
local society = ""
local stop = false
local deleting = false

local mainMenu = nil 
local bodyMenu = nil
local payMenu = nil
local extrasMenu = nil
local colorMenu = nil
local neonMenu = nil
local upgradeMenu = nil
local cartMenu = nil

local tempBodyParts = nil
local tempExtras = nil
local tempColorParts = nil
local tempNeons = nil
local tempUpgrades = nil

local bodyPartIndex = {
	[1] = { modSpoilers = 1 },
	[2] = { modFrontBumper = 1 },
	[3] = { modRearBumper = 1 },
	[4] = { modSideSkirt = 1 },
	[5] = { modExhaust = 1 },
	[6] = { modGrille = 1 },
	[7] = { modHood = 1 },
	[8] = { modFender = 1 },
	[9] = { modRightFender = 1 },
	[10] = { modRoof = 1 },
	[11] = { modArmor = 1 },
	[12] = { wheels = 1 },
	[13] = { modFrontWheels = 1 },
}

local extrasIndex = {
	[1] = { modPlateHolder = 1 },
	[2] = { modVanityPlate = 1 },
	[3] = { modTrimA = 1 },
	[4] = { modOrnaments = 1 },
	[5] = { modDashboard = 1 },
	[6] = { modDial = 1 },
	[7] = { modDoorSpeaker = 1 },
	[8] = { modSeats = 1 },
	[9] = { modSteeringWheel = 1 },
	[10] = { modShifterLeavers = 1 },
	[11] = { modAPlate = 1 },
	[12] = { modSpeakers = 1 },
	[13] = { modTrunk = 1 },
	[14] = { modHydrolic = 1 },
	[15] = { modEngineBlock = 1 },
	[16] = { modAirFilter = 1 },
	[17] = { modStruts = 1 },
	[18] = { modArchCover = 1 },
	[19] = { modAerials = 1 },
	[20] = { modTrimB = 1 },
	[21] = { modTank = 1 },
	[22] = { modWindows = 1 },
	[23] = { modLivery = 1 },
	[24] = { modHorns = 1 },
}

local windowTintIndex = 1
local colorPartIndex = 1 
local colorTypeIndex = {
	[1] = 1,
	[2] = 1,
	[3] = 1
}
local primaryColorIndex = 1
local secondaryColorIndex = 1
local pearlColorIndex = 1
local primaryCustomColorIndex = { 
	[1] = { label = 'R', index = 0 }, 
	[2] = { label = 'G', index = 0 }, 
	[3] = { label = 'B', index = 0 }
}
local secondaryCustomColorIndex = { 
	[1] = { label = 'R', index = 0 }, 
	[2] = { label = 'G', index = 0 }, 
	[3] = { label = 'B', index = 0 }
}
local primaryPaintFinishIndex = 1
local secondaryPaintFinishIndex = 1
local wheelColorIndex = 1
local tyreSmokeActive = false
local smokeColorIndex = {
	[1] = { label = 'R', index = 0 }, 
	[2] = { label = 'G', index = 0 }, 
	[3] = { label = 'B', index = 0 }
}
local xenonActive = false
local xenonColorIndex = 1

--[[local neonIndex = {
	[1] = { leftNeon = false },
	[2] = { frontNeon = false },
	[3] = { rightNeon = false },
	[4] = { backNeon = false },
	[5] = { r = 0, g = 0, b = 0 },
}--]]

local neonIndex = { 
	[1] = { label = 'R', index = 0 }, 
	[2] = { label = 'G', index = 0 }, 
	[3] = { label = 'B', index = 0 }
}

local neon1 = false
local neon2 = false
local neon3 = false
local neon4 = false

local upgradeIndex = {
	[1] = { modArmor = 1 },
	[2] = { modEngine = 1 },
	[3] = { modTransmission = 1 },
	[4] = { modBrakes = 1 },
	[5] = { modSuspension = 1 },
	[6] = { modTurbo = false },
}

local vehPedIsIn = nil
local vehModsOld = nil
local vehModsNew = nil
local partsCart = {}
VcCustoms_sellDetails = {}

InitVcCustoms = function()
    registerSocietyFarmZone({ 
        pos           = vector3(2389.33, 6480.43, 10.25),
        spawnPoint    = {
            {pos = vector3(cfg_VcCustoms.pos.spawnvoiture.position.x, cfg_VcCustoms.pos.spawnvoiture.position.y, cfg_VcCustoms.pos.spawnvoiture.position.z), heading = cfg_VcCustoms.pos.spawnvoiture.position.h},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage Vice City Customs",
        garage        = {
            {name     = "Plateau 3", hash = "flatbed"},
			{name     = "Dépaneuse", hash = "towtruck2"},
			{name     = "Speedo", 	 hash = "speedo"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Vice City Customs",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(2389.42, 6466.22, 8.30),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Vice City Customs",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos      = vector3(2366.76, 6485.09, 16.40),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(2359.75, 6493.48, 10.25),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2360.39, 6487.47, 10.23),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Vice City Customs",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(2366.76, 6485.09, 16.40)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Vice City Customs")
    EndTextCommandSetBlipName(aBlip)
    
    registerSocietyFarmZone({
        pos      = vector3(1959.08, 6230.17, 10.34),
        type     = 1,
        item     = "Piece_mechanic",
        count    = 1,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter des pièces méchanic",
    })

    registerSocietyFarmZone({
        pos      = vector3(2414.95, 4722.88, 10.82),
        type     = 2,
        item     = "Piece_mechanic",
        item_g   = "Kit_de_reparation",
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour transformer vos pièces méchanic",
    })
    
    registerSocietyFarmZone({
        pos      = vector3(2499.26, 7410.12, 10.04),
        type     = 3,
        item     = "Kit_de_reparation",
        price    = extasy_core_cfg["private_society_sell_price"],
        society  = playerJob,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour vendre vos kit de réparation",
    })

    local b = {
        {pos = vector3(1959.08, 6230.17, 10.34), sprite = 502, color = 17, scale = 0.60, title = "Vice City Customs | Récolte de pièces méchanic"},
        {pos = vector3(2414.95, 4722.88, 10.82), sprite = 503, color = 17, scale = 0.60, title = "Vice City Customs | Traitement de pièces méchanic"},
        {pos = vector3(2499.26, 7410.12, 10.04), sprite = 504, color = 17, scale = 0.60, title = "Vice City Customs | Vente de kit de réparation"},

        {pos = vector3(2359.75, 6493.48, 10.25), sprite = 557, color = 2,  scale = 0.60, title = "Vice City Customs | Coffre d'entreprise"},
        {pos = vector3(2360.39, 6487.47, 10.23), sprite = 557, color = 3,  scale = 0.60, title = "Vice City Customs | Vestaire"},
        {pos = vector3(2389.33, 6480.43, 10.25), sprite = 557, color = 17, scale = 0.60, title = "Vice City Customs | Garage"},
        {pos = vector3(2389.42, 6466.22, 8.30), sprite = 557, color = 59, scale = 0.60, title = "Vice City Customs | Rangement véhicule"},
    }
    
    for _, info in pairs(b) do
        info.blip = AddBlipForCoord(info.pos.x, info.pos.y, info.pos.z)
        SetBlipSprite(info.blip, info.sprite)
        SetBlipDisplay(info.blip, 4)
        SetBlipColour(info.blip, info.color)
        SetBlipScale(info.blip, info.scale)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end

	InitCustomsMenu()
end

RMenu.Add('vccustoms_menu', 'main', RageUI.CreateMenu("Vice City Intéraction", "Que souhaitez-vous faire ?"))
RMenu.Add('vccustoms_menu', 'main_menu_vehicle_give', RageUI.CreateSubMenu(RMenu:Get('vccustoms_menu', 'main'), "Vice City Customs", "À qui souhaitez-vous facturer ?"))
RMenu:Get('vccustoms_menu', 'main').Closed = function()
	VcCustoms_in_menu = false
end

openVcCustomsMenuF6 = function()
	if not VcCustoms_in_menu then 
		VcCustoms_in_menu = true
		RageUI.Visible(RMenu:Get('vccustoms_menu', 'main'), true)
	
		Citizen.CreateThread(function()
			while VcCustoms_in_menu do
			Wait(1)
			RageUI.IsVisible(RMenu:Get('vccustoms_menu', 'main'), true, true, true, function()

				RageUI.Button("Annonce aux citoyens", nil, {RightLabel = "→→→"}, true, function(h, a, s)
					if s then
						local i = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 200)
						i = tostring(i)
						if i ~= nil and string.len(i) > 5 then
							TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Vice City Customs', '~o~Publicité', i, 'CHAR_VICECUSTOMS')
						end
					end
				end)	

				RageUI.Button("Réparer le véhicule", nil, {RightLabel = ">"}, true, function(h, a, s)
					if s then
						TriggerServerEvent('VcCustoms:fixKit', token)
						VcCustoms_in_menu = false
					end
				end)

				RageUI.Button("Nettoyer le véhicule", nil, {RightLabel = ">"}, true, function(h, a, s)
					if s then
						local vehicle   = ESX.Game.GetVehicleInDirection()
						local coords    = GetEntityCoords(PlayerPedId())
			
						if IsPedSittingInAnyVehicle(PlayerPedId()) then
							Extasy.ShowNotification('~r~Vous ne pouvez pas effectuer cette action depuis un véhicule')
							return
						end
			
						if DoesEntityExist(vehicle) then
							isBusy = true
							TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_MAID_CLEAN', 0, true)
							Citizen.CreateThread(function()
								Wait(10000)
			
								SetVehicleDirtLevel(vehicle, 0)
								ClearPedTasksImmediately(PlayerPedId())
			
								Extasy.ShowNotification('~g~véhicule nettoyé')
								isBusy = false
								VcCustoms_in_menu = false
							end)
						else
							Extasy.ShowNotification('~r~Aucun véhicule à proximité')
						end

					end
				end)

				RageUI.Button("Crocheter le véhicule", nil, {RightLabel = ">"}, true, function(h, a, s)
					if s then
						local vehicle = ESX.Game.GetVehicleInDirection()
						local coords = GetEntityCoords(PlayerPedId())
			
						if IsPedSittingInAnyVehicle(PlayerPedId()) then
							Extasy.ShowNotification("~r~Vous ne pouvez pas effectuer cette action depuis un véhicule")
							return
						end
			
						if DoesEntityExist(vehicle) then
							isBusy = true
							TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_WELDING', 0, true)
							Citizen.CreateThread(function()
								Wait(10000)
			
								SetVehicleDoorsLocked(vehicle, 1)
								SetVehicleDoorsLockedForAllPlayers(vehicle, false)
								ClearPedTasksImmediately(PlayerPedId())
			
								Extasy.ShowNotification('~g~Véhicule déverrouillé')
								isBusy = false
								VcCustoms_in_menu = false
							end)
						else
							Extasy.ShowNotification('~~rAucun véhicule à proximité')
						end
					end
				end)

				RageUI.Button("Placer le véhicule sur la remorque",nil, {RightLabel = ">"}, true, function(h, a, s)
					if s then
						local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
						local towmodel = GetHashKey('flatbed')
						local isVehicleTow = IsVehicleModel(vehicle, towmodel)
	
						if isVehicleTow then
							local targetVehicle = ESX.Game.GetVehicleInDirection()
			
							if CurrentlyTowedVehicle == nil then
								if targetVehicle ~= 0 then
									if not IsPedInAnyVehicle(PlayerPedId(), true) then
										if vehicle ~= targetVehicle then
											AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
											CurrentlyTowedVehicle = targetVehicle
											Extasy.ShowNotification('Vehicule ~b~attaché~s~ avec succès!')
											VcCustoms_in_menu = false
										else
											Extasy.ShowNotification('~r~Impossible~s~ d\'attacher votre propre dépanneuse')
										end
									end
								else
									Extasy.ShowNotification('~r~il n\'y a pas de véhicule à attacher')
								end
							else
								AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
								DetachEntity(CurrentlyTowedVehicle, true, true)
								CurrentlyTowedVehicle = nil
							end
						end
					end
				end)

			end, function()
			end)
			
			end
		end)
	end
end

RegisterNetEvent('VcCustoms:useKit')
AddEventHandler('VcCustoms:useKit', function()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(PlayerPedId())

	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		Extasy.ShowNotification("~r~Vous ne pouvez pas effectuer cette action depuis un véhicule")
		return
	end
	
	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_BUM_BIN', 0, true)

		Citizen.CreateThread(function()
		Wait(20000)

		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleUndriveable(vehicle, false)
		SetVehicleEngineOn(vehicle, true, true)
		ClearPedTasksImmediately(PlayerPedId())

		Extasy.ShowNotification("~g~Véhicule réparé")
		isBusy = false
		VcCustoms_in_menu = false
		end)
	else
		Extasy.ShowNotification("~r~Aucun véhicule à proximité")
	end
end)


















































resetMenu = function()
	if playerJob == 'vccustoms' then
		mainMenu = RageUI.CreateMenu("Vice City Customs", "Que souhaitez-vous faire ?", 5, 250)
		mainMenu.closable = false
		society = 'society_vccustoms'
	end

	if not bodyMenu and mainMenu ~= nil then
		bodyMenu = RageUI.CreateSubMenu(mainMenu)
		bodyMenu.EnableMouse = false
		bodyMenu.Closed = function()
		end
	end
	if not payMenu and mainMenu ~= nil then
		payMenu = RageUI.CreateSubMenu(mainMenu)
		payMenu.EnableMouse = false
		payMenu.Closed = function()
		end
	end
	if not extrasMenu and mainMenu ~= nil then
		extrasMenu = RageUI.CreateSubMenu(mainMenu)
		extrasMenu.EnableMouse = false
		extrasMenu.Closed = function()
			SetVehicleDoorsShut(vehPedIsIn, false)
		end
	end
	if not colorMenu and mainMenu ~= nil then
		colorMenu = RageUI.CreateSubMenu(mainMenu)
		colorMenu.EnableMouse = false
		colorMenu.Closed = function()
		end
	end
	if not neonMenu and mainMenu ~= nil then
		neonMenu = RageUI.CreateSubMenu(mainMenu)
		neonMenu.EnableMouse = false
		neonMenu.Closed = function()
		end
	end
	if not upgradeMenu and mainMenu ~= nil then
		upgradeMenu = RageUI.CreateSubMenu(mainMenu)
		upgradeMenu.EnableMouse = false
		upgradeMenu.Closed = function()
		end
	end
	if not cartMenu and mainMenu ~= nil then
		cartMenu = RageUI.CreateSubMenu(mainMenu)
		cartMenu.EnableMouse = false
		cartMenu.Closable = false
		cartMenu.Closed = function()
		end
	end

	if not mainMenu then
		print("ERROR CREATING JOB MENU!!")
	else
		mainMenu.EnableMouse = false
		mainMenu.Closable = false
		mainMenu.Closed = function()
			lsMenuIsShowed = false
			SetVehicleDoorsShut(vehPedIsIn, false)
			if not canClose then
				TriggerEvent('VcCustoms:resetVehicle', token, vehModsOld)
			end
		end
	end
end

--COLOR ARRAY
--[[function buildrgbArray()
	for i = 1, 256, 1 do
		--table.insert(rgbArray, i - 1)
		rgbArray[i] = i - 1
	end
end

buildrgbArray()
--]]

getCarPrice = function()
	if vehPedIsIn then
		for i = 1, #Vehicles, 1 do
			if GetEntityModel(vehPedIsIn) == GetHashKey(Vehicles[i].model) then
				vehiclePrice = Vehicles[i].price
				break
			end
		end
	end
end

--REFRESH INDEXES
RefreshBodyPartIndex = function()
	for k, v in pairs(vehModsOld) do
		--print("k: " .. k)
		for i = 1, #tempBodyParts, 1 do
			if k == tempBodyParts[i]['mod'] then
				--print("cfg_VcCustoms: " .. tempBodyParts[i]['mod'])
				bodyPartIndex[i][k] = v + (tempBodyParts[i]['mod'] ~= 'wheels' and 2 or 1)
				break
			end
		end
	end
end

RefreshExtrasIndex = function()
	for k, v in pairs(vehModsOld) do
		for i = 1, #tempExtras, 1 do
			if k == tempExtras[i]['mod'] then
				extrasIndex[i][k] = v + 2
				break
			end
		end
	end
end

RefreshPaintIndex = function()
	windowTintIndex = vehModsOld['windowTint'] + 2
	--colorPartIndex = 1 
	for i = 1, #cfg_VcCustoms.colorPalette - 2, 1 do
		for k, v in pairs(cfg_VcCustoms.colorPalette[i]) do
			for x = 1, #v, 1 do
				if vehModsOld['color1'] == v[x] then
					colorTypeIndex[1] = vehModsOld['hasCustomColorPrimary'] == 1 and 7 or i
					primaryPaintFinishIndex = i
					primaryColorIndex = x
				end
				if vehModsOld['color2'] == v[x] then
					colorTypeIndex[2] = vehModsOld['hasCustomColorSecondary'] == 1 and 7 or i
					secondaryPaintFinishIndex = i
					secondaryColorIndex = x
				end
				if vehModsOld['pearlescentColor'] == v[x] then
					colorTypeIndex[3] = i
					pearlColorIndex = x
				end
				if vehModsOld['wheelColor'] == v[x] then
					wheelColorIndex = x
				end
			end
		end
	end
	if vehModsOld['hasCustomColorPrimary'] == 1 then
		primaryCustomColorIndex[1]['index'] = vehModsOld['customColorPrimary'][1]
		primaryCustomColorIndex[2]['index'] = vehModsOld['customColorPrimary'][2]
		primaryCustomColorIndex[3]['index'] = vehModsOld['customColorPrimary'][3]
	end
	if vehModsOld['hasCustomColorSecondary'] == 1 then
		secondaryCustomColorIndex[1]['index'] = vehModsOld['customColorSecondary'][1]
		secondaryCustomColorIndex[2]['index'] = vehModsOld['customColorSecondary'][2]
		secondaryCustomColorIndex[3]['index'] = vehModsOld['customColorSecondary'][3]
	end
	tyreSmokeActive = vehModsOld['modSmokeEnabled'] and true or false
	if tyreSmokeActive then
		smokeColorIndex[1]['index'] = vehModsOld['tyreSmokeColor'][1]
		smokeColorIndex[2]['index'] = vehModsOld['tyreSmokeColor'][2]
		smokeColorIndex[3]['index'] = vehModsOld['tyreSmokeColor'][3]
	end
	xenonActive = vehModsOld['modXenon'] and true or false
	if xenonActive then
		xenonColorIndex = vehModsOld['xenonColor'] + 2
	end
end

RefreshNeonIndex = function()
	--[[
		0 = Left
		2 = Front
		1 = Right
		3 = Back
	--]]
	neon1 = vehModsOld['neonEnabled'][1] and true or false
	neon2 = vehModsOld['neonEnabled'][2] and true or false
	neon3 = vehModsOld['neonEnabled'][3] and true or false
	neon4 = vehModsOld['neonEnabled'][4] and true or false
	neonIndex[1]['index'] = vehModsOld['neonColor'][1]
	neonIndex[2]['index'] = vehModsOld['neonColor'][2]
	neonIndex[3]['index'] = vehModsOld['neonColor'][3]
end

RefreshUpgradeIndex = function()
	for k, v in pairs(vehModsOld) do 
		for i = 1, #tempUpgrades, 1 do
			if k == tempUpgrades[i]['mod'] and tempUpgrades[i]['modType'] ~= 18 then
				upgradeIndex[i][k] = v + 2
				break
			elseif k == tempUpgrades[i]['mod'] and tempUpgrades[i]['modType'] == 18 then
				upgradeIndex[i][k] = v and true or false
				break
			end
		end
	end
end

--RESET ITEM LISTS
ResetBodyPartItems = function()
	if tempBodyParts then
		for i = 1, #tempBodyParts, 1 do
			if i ~= 12 then
				for x = 1, #tempBodyParts[i]['items']['label'] do
				    tempBodyParts[i]['items']['label'][x] = nil
				end
			end
		end
	end
end

ResetWheelItems = function()
	if tempBodyParts then
		for x = 1, #tempBodyParts[13]['items']['label'] do
		    tempBodyParts[13]['items']['label'][x] = nil
		end
	end
end

ResetExtraItems = function()
	if tempExtras then
		for i = 1, #tempExtras, 1 do
			for x = 1, #tempExtras[i]['items']['label'] do
			    tempExtras[i]['items']['label'][x] = nil
			end
		end
	end
end

ResetPaintItems = function()
	windowTintIndex = 1
	colorPartIndex = 1 
	colorTypeIndex[1] = 1
	colorTypeIndex[2] = 1
	colorTypeIndex[3] = 1
	primaryColorIndex = 1
	secondaryColorIndex = 1
	primaryCustomColorIndex[1]['index'] = 0
	primaryCustomColorIndex[2]['index'] = 0
	primaryCustomColorIndex[3]['index'] = 0
	secondaryCustomColorIndex[1]['index'] = 0
	secondaryCustomColorIndex[2]['index'] = 0
	secondaryCustomColorIndex[3]['index'] = 0
	primaryPaintFinishIndex = 1
	secondaryPaintFinishIndex = 1
	pearlColorIndex = 1
	wheelColorIndex = 1
	tyreSmokeActive = false
	smokeColorIndex[1]['index'] = 0
	smokeColorIndex[2]['index'] = 0
	smokeColorIndex[3]['index'] = 0
	xenonActive = false
	xenonColorIndex = 1
end

ResetNeonItems = function()
	neon1 = false
	neon2 = false
	neon3 = false
	neon4 = false
	neonIndex[1]['index'] = 0
	neonIndex[2]['index'] = 0
	neonIndex[3]['index'] = 0
end

ResetUpgradeItems = function()
	if tempUpgrades then
		for i = 1, #tempUpgrades, 1 do
			for x = 1, #tempUpgrades[i]['items']['label'] do
			    tempUpgrades[i]['items']['label'][x] = nil
			end
		end
	end
end

--BUILD ITEM LISTS
BuildBodyPartsLabel = function()
	local modCount = 0
	local modName = ""
	local label = ""
	for i = 1, #tempBodyParts, 1 do
		modCount = GetNumVehicleMods(vehPedIsIn, tempBodyParts[i]['modType'])
		if modCount > 0 and i < 12 then
			for x = 1, modCount, 1 do
				--[[modName = GetModTextLabel(vehPedIsIn, tempBodyParts[i]['modType'], x)
				label = GetLabelText(modName)
				if label == "NULL" then
					label = "Custom " .. tempBodyParts[i]['label']
				end
				if #label > 10 then
					label = label:sub(1, 10)
					print("label cut: " .. label)
				end--]]
				if x == 1 then
					--table.insert(tempBodyParts[i]['items']['label'], "Stock " .. label .. " [" .. x .. "/" .. modCount + 1 .. "]")
					table.insert(tempBodyParts[i]['items']['label'], "[" .. x .. "/" .. modCount + 1 .. "]")
				end
				--label = label .. " [" .. x + 1 .. "/" .. modCount + 1 .. "]"
				label = "[" .. x + 1 .. "/" .. modCount + 1 .. "]"
				table.insert(tempBodyParts[i]['items']['label'], label)
			end
		end
	end
end

BuildWheelsLabel = function()
	local modCount = GetNumVehicleMods(vehPedIsIn, tempBodyParts[13]['modType'])
	if modCount > 0 then
		for x = 1, modCount, 1 do
			if x == 1 then
				table.insert(tempBodyParts[13]['items']['label'], "[" .. x .. "/" .. modCount + 1 .. "]")
			end
			label = "[" .. x + 1 .. "/" .. modCount + 1 .. "]"
			table.insert(tempBodyParts[13]['items']['label'], label)
		end
	end
end

BuildExtrasLabel = function()
	local modCount = 0
	local modName = ""
	local label = ""
	for i = 1, #tempExtras, 1 do
		modCount = GetNumVehicleMods(vehPedIsIn, tempExtras[i]['modType'])
		if modCount > 0 then
			for x = 1, modCount, 1 do
				--[[modName = GetModTextLabel(vehPedIsIn, tempExtras[i]['modType'], x)
				label = GetLabelText(modName)
				if label == "NULL" then
					label = "Custom " .. tempExtras[i]['label']
				end--]]
				if x == 1 then
					--table.insert(tempExtras[i]['items']['label'], "Stock " .. label .. " [" .. x .. "/" .. modCount + 1 .. "]")
					table.insert(tempExtras[i]['items']['label'], "[" .. x .. "/" .. modCount + 1 .. "]")
				end
				--label = label .. " [" .. x + 1 .. "/" .. modCount + 1 .. "]"
				label = "[" .. x + 1 .. "/" .. modCount + 1 .. "]"
				table.insert(tempExtras[i]['items']['label'], label)
			end
		end
	end
end

BuildUpgradesLabel = function()
	local modCount = 0
	local modName = ""
	local label = ""
	for i = 1, #tempUpgrades, 1 do
		modCount = GetNumVehicleMods(vehPedIsIn, tempUpgrades[i]['modType'])
		if modCount > 0 then
			for x = 1, modCount, 1 do
				--[[modName = GetModTextLabel(vehPedIsIn, tempUpgrades[i]['modType'], x)
				label = GetLabelText(modName)--]]
				--[[if label == "NULL" then
					label = "Custom " .. tempUpgrades[i]['label']
				end--]]
				if x == 1 then
					--local label1 = tempUpgrades[i]['label']
					--table.insert(tempUpgrades[i]['items']['label'], "Stock " .. label1 .. " [" .. x .. "/" .. modCount + 1 .. "]")
					table.insert(tempUpgrades[i]['items']['label'], "[" .. x .. "/" .. modCount + 1 .. "]")
				end
				--label = label .. " [" .. x + 1 .. "/" .. modCount + 1 .. "]"
				label = "[" .. x + 1 .. "/" .. modCount + 1 .. "]"
				table.insert(tempUpgrades[i]['items']['label'], label)
			end
		end
	end
end

addToCart = function(label, mod, modType, index, price)
	local item = findKey(shopCart, mod)
	if item then
		shopCart[mod]['label'] = label
		shopCart[mod]['modType'] = modType
		shopCart[mod]['index'] = index
		shopCart[mod]['price'] = price
	else
		item = { label = label, modType = modType, index = index, price = price }
		shopCart[mod] = item
	end
	calcCartValue()
end

removeFromCart = function(mod)
	local item = findKey(shopCart, mod)
	if item then
		shopCart[mod] = nil
		calcCartValue()
	end
end

calcCartValue = function()
	shopProfitValue = 0
	totalCartValue = 0
	for k, v in pairs(shopCart) do
		--print("k: " .. k)
		--print("v['price']: " .. v['price'])
		local c = v['price'] * (shopProfit / 100)
		shopProfitValue = math.round(shopProfitValue + c)
		totalCartValue = math.round(totalCartValue + v['price'] + c)
	end
end

terminatePurchase = function()
	for k, v in pairs(shopCart) do
		shopCart[k] = nil
	end
	if lsMenuIsShowed then
		RageUI.CloseAll()
	end
	lsMenuIsShowed = false
	stop = false
	vehModsOld = nil
end

compareMods = function(label, mod, modType, index, price)
	local vehModsNew = ESX.Game.GetVehicleProperties(vehPedIsIn)
	if (mod ~= 'neonColor' and mod ~= 'tyreSmokeColor' and mod ~= 'customColorPrimary' and mod ~= 'customColorSecondary' and vehModsOld[mod] ~= vehModsNew[mod]) or 
		--apenas ligar neons
		(mod == 'leftNeon' and not vehModsOld['neonEnabled'][1] and vehModsNew['neonEnabled'][1]) or 
		(mod == 'rightNeon' and not vehModsOld['neonEnabled'][2] and vehModsNew['neonEnabled'][2]) or 
		(mod == 'frontNeon' and not vehModsOld['neonEnabled'][3] and vehModsNew['neonEnabled'][3]) or 
		(mod == 'backNeon' and not vehModsOld['neonEnabled'][4] and vehModsNew['neonEnabled'][4]) or
		--mudar cor da neon
		(mod == 'neonColor' and (vehModsOld['neonColor'][1] ~= vehModsNew['neonColor'][1] or vehModsOld['neonColor'][2] ~= vehModsNew['neonColor'][2] or vehModsOld['neonColor'][3] ~= vehModsNew['neonColor'][3])) or
		(mod == 'tyreSmokeColor' and (vehModsOld['tyreSmokeColor'][1] ~= vehModsNew['tyreSmokeColor'][1] or vehModsOld['tyreSmokeColor'][2] ~= vehModsNew['tyreSmokeColor'][2] or vehModsOld['tyreSmokeColor'][3] ~= vehModsNew['tyreSmokeColor'][3])) or
		(mod == 'xenonColor' and vehModsOld['xenonColor'] ~= vehModsNew['xenonColor']) or
		(mod == 'customColorPrimary' and (vehModsOld['customColorPrimary'][1] ~= vehModsNew['customColorPrimary'][1] or vehModsOld['customColorPrimary'][2] ~= vehModsNew['customColorPrimary'][2] or vehModsOld['customColorPrimary'][3] ~= vehModsNew['customColorPrimary'][3])) or 
		(mod == 'customColorSecondary' and (vehModsOld['customColorSecondary'][1] ~= vehModsNew['customColorSecondary'][1] or vehModsOld['customColorSecondary'][2] ~= vehModsNew['customColorSecondary'][2] or vehModsOld['customColorSecondary'][3] ~= vehModsNew['customColorSecondary'][3])) then

		addToCart(label, mod, modType, index, price)
		if mod == 'customColorPrimary' then
			removeFromCart('color1')
		elseif mod == 'customColorSecondary' then
			removeFromCart('color2')
		elseif mod == 'color1' then
			removeFromCart('customColorPrimary')
		elseif mod == 'color2' then
			removeFromCart('customColorSecondary')
		end
	else
		if (mod == 'leftNeon' and not vehModsNew['neonEnabled'][1]) and 
			(mod == 'rightNeon' and not vehModsNew['neonEnabled'][2]) and 
			(mod == 'frontNeon' and not vehModsNew['neonEnabled'][3]) and 
			(mod == 'backNeon' and not vehModsNew['neonEnabled'][4]) then

			removeFromCart('neonColor')
		elseif mod == 'modSmokeEnabled' then
			removeFromCart('tyreSmokeColor')
		elseif mod == 'modXenon' then
			removeFromCart('xenonColor')
		end
		removeFromCart(mod)
	end
end

calcModPrice = function(parcel)
	local val = 0
	val = math.round(vehiclePrice * (parcel / 100))
	return val
end

DeleteFromCart = function(k, modType)
	local vehModsNew = ESX.Game.GetVehicleProperties(vehPedIsIn)
	if modType == -1 then
		if k == 'customColorPrimary' then
			if vehModsOld['hasCustomColorPrimary'] == 1 then
				SetVehicleCustomPrimaryColour(vehicle, vehModsOld['customColorPrimary'][1], vehModsOld['customColorPrimary'][2], vehModsOld['customColorPrimary'][3])
			else
				ClearVehicleCustomPrimaryColour(vehPedIsIn)
			end
		elseif k == 'customColorSecondary' then
			if vehModsOld['hasCustomColorSecondary'] == 1 then
				SetVehicleCustomSecondaryColour(vehicle, vehModsOld['customColorSecondary'][1], vehModsOld['customColorSecondary'][2], vehModsOld['customColorSecondary'][3])
			else
				ClearVehicleCustomSecondaryColour(vehPedIsIn)
			end
		elseif k == 'primaryPaintFinish' then
			SetVehicleColours(vehPedIsIn, vehModsOld['color1'], vehModsNew['color2'])
		elseif k == 'secondaryPaintFinish' then 
			SetVehicleColours(vehPedIsIn, vehModsNew['color1'], vehModsOld['color2'])
		elseif k == 'color1' then
			SetVehicleColours(vehPedIsIn, vehModsOld['color1'], vehModsNew['color2'])
		elseif k == 'color2' then 
			SetVehicleColours(vehPedIsIn, vehModsNew['color1'], vehModsOld['color2'])
		elseif k == 'pearlescentColor' then
			SetVehicleExtraColours(vehPedIsIn, vehModsOld['pearlescentColor'], vehModsNew['wheelColor'])
		elseif k == 'wheelColor' then
			SetVehicleExtraColours(vehPedIsIn, vehModsNew['pearlescentColor'], vehModsOld['wheelColor'])
		elseif k == 'windowTint' then
			SetVehicleWindowTint(vehPedIsIn, vehModsOld['windowTint'])
		elseif k == 'tyreSmokeColor' then
			SetVehicleTyreSmokeColor(vehPedIsIn, vehModsOld['tyreSmokeColor'][1], vehModsOld['tyreSmokeColor'][2], vehModsOld['tyreSmokeColor'][3])
		elseif k == 'xenonColor' then
			SetVehicleXenonLightsColour(vehPedIsIn, vehModsOld['xenonColor'])
		elseif k == 'neonColor' then
			SetVehicleNeonLightsColour(vehPedIsIn, vehModsOld['neonColor'][1], vehModsOld['neonColor'][2], vehModsOld['neonColor'][3])
		elseif k == 'leftNeon' then
			SetVehicleNeonLightEnabled(vehPedIsIn, 0, vehModsOld['neonEnabled'][1])
		elseif k == 'rightNeon' then
			SetVehicleNeonLightEnabled(vehPedIsIn, 1, vehModsOld['neonEnabled'][2])
		elseif k == 'frontNeon' then
			SetVehicleNeonLightEnabled(vehPedIsIn, 2, vehModsOld['neonEnabled'][3])
		elseif k == 'backNeon' then
			SetVehicleNeonLightEnabled(vehPedIsIn, 3, vehModsOld['neonEnabled'][4])
		end
	else
		--[[if k == 'modTurbo' or k == 'modSmokeEnabled' or k == 'modXenon' then
			if vehModsOld[k] or vehModsOld[k] == 1 then
				ToggleVehicleMod(vehPedIsIn, modType, true)
			elseif not vehModsOld[k] or vehModsOld[k] == 0 then
				ToggleVehicleMod(vehPedIsIn, modType, false)
			end--]]
		if k == 'modTurbo' or k == 'modSmokeEnabled' or k == 'modXenon' then
			if vehModsOld[k] or vehModsOld[k] == 1 then
				ToggleVehicleMod(vehPedIsIn, modType, true)
			elseif not vehModsOld[k] or vehModsOld[k] == 0 then
				ToggleVehicleMod(vehPedIsIn, modType, false)
			end
			removeFromCart('modTurbo')
			removeFromCart('modSmokeEnabled')
			removeFromCart('modXenon')
		elseif k == 'modLivery' then
			SetVehicleMod(vehPedIsIn, modType, vehModsOld['modLivery'], false)
			SetVehicleLivery(vehPedIsIn, vehModsOld['modLivery'])
		elseif k == 'wheels' or k == 'modFrontWheels' then
			SetVehicleWheelType(vehPedIsIn, vehModsOld['wheels'])
            SetVehicleMod(vehPedIsIn, 23, vehModsOld['modFrontWheels'], false)
		else
			SetVehicleMod(vehPedIsIn, modType, vehModsOld[k], false)
		end
	end
	removeFromCart(k)
	--refresh indexes
	RefreshBodyPartIndex()
	RefreshExtrasIndex()
	RefreshPaintIndex()
	RefreshNeonIndex()
	RefreshUpgradeIndex()
	deleting = false
end

-- Activate menu when player is inside marker
InitCustomsMenu = function()
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then
				if not vehPedIsIn and isInLSMarker then
					vehPedIsIn = GetVehiclePedIsIn(playerPed, false)
					vehModsOld = ESX.Game.GetVehicleProperties(vehPedIsIn)
					TriggerServerEvent('VcCustoms:checkVehicle', token, vehModsOld['plate'])
				end
				local coords = GetEntityCoords(PlayerPedId())
				local currentZone, zone, lastZone
				if playerJob == 'vccustoms' and not lsMenuIsShowed then
					if GetDistanceBetweenCoords(coords, cfg_VcCustoms.Zones[1]['Pos']['x'], cfg_VcCustoms.Zones[1]['Pos']['y'], cfg_VcCustoms.Zones[1]['Pos']['z'], true) < cfg_VcCustoms.Zones[1]['Size']['x'] then
						isInLSMarker  = true
						Extasy.ShowHelpNotification(cfg_VcCustoms.Zones[1]['Hint'])
					else
						isInLSMarker  = false
					end
				end

				if lsMenuIsShowed and not isInLSMarker then
					--FreezeEntityPosition(vehPedIsIn, false)
					RageUI.CloseAll()
					lsMenuIsShowed = false
					SetVehicleDoorsShut(vehPedIsIn, false)
					if not canClose then
						TriggerEvent('VcCustoms:resetVehicle', token, vehModsOld)
					end
				end

				if IsControlJustReleased(0, 38) and not lsMenuIsShowed and isInLSMarker then
					if playerJob == 'vccustoms' then
						--vehPedIsIn = GetVehiclePedIsIn(playerPed, false)
						terminatePurchase()
						getCarPrice()
						vehicleClass = GetVehicleClass(vehPedIsIn)
						if (vehicleClass ~= 8 or not cfg_VcCustoms.IsMotorCycleBikerOnly) and playerJob == 'vccustoms' then

							--RageUI.CloseAll()
							vehModsOld = ESX.Game.GetVehicleProperties(vehPedIsIn)
							SetVehicleModKit(vehPedIsIn, 0)
							TriggerServerEvent('VcCustoms:saveVehicle', token, vehModsOld)

							--resetItems
							ResetBodyPartItems()
							ResetWheelItems()
							ResetExtraItems()
							ResetPaintItems()
							ResetNeonItems()
							ResetUpgradeItems()
							
							if not tempBodyParts then tempBodyParts = cfg_VcCustoms.bodyParts end
							if not tempExtras then tempExtras = cfg_VcCustoms.extras end
							if not tempColorParts then tempColorParts = cfg_VcCustoms.colorParts end
							if not tempNeons then tempNeons = cfg_VcCustoms.neons end
							if not tempUpgrades then tempUpgrades = cfg_VcCustoms.upgrades end
							
							if vehicleClass == 8 and #tempBodyParts[12]['wheelType'] < 8 then
								table.insert(tempBodyParts[12]['items'], 'Moto')
								table.insert(tempBodyParts[12]['wheelType'], 6)
							elseif vehicleClass ~= 8 and #tempBodyParts[12]['wheelType'] == 8 then
								table.remove(tempBodyParts[12]['items'])
								table.remove(tempBodyParts[12]['wheelType'])
							end

							--refresh indexes
							RefreshBodyPartIndex()
							RefreshExtrasIndex()
							RefreshPaintIndex()
							RefreshNeonIndex()
							RefreshUpgradeIndex()
							--refresh item names
							BuildBodyPartsLabel()
							BuildWheelsLabel()
							BuildExtrasLabel()
							BuildUpgradesLabel()

							lsMenuIsShowed = true
							--SetVehicleDoorsLocked(vehPedIsIn, 4)
							--FreezeEntityPosition(vehPedIsIn, true)
							resetMenu()

							while mainMenu == nil do Wait(0) end

							myCar = vehModsOld

							shopProfit = cfg_VcCustoms.shopProfit

							Wait(10)

							RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))
						end
					end
				end

				RageUI.IsVisible(mainMenu, true, true, true, function()
					RageUI.Button('Cosmetiques' , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					end, bodyMenu)  
					RageUI.Button("Extras" , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if Selected then
							SetVehicleDoorOpen(vehPedIsIn, 0, false)
							SetVehicleDoorOpen(vehPedIsIn, 1, false)
							SetVehicleDoorOpen(vehPedIsIn, 2, false)
							SetVehicleDoorOpen(vehPedIsIn, 3, false)
							SetVehicleDoorOpen(vehPedIsIn, 4, false)
							SetVehicleDoorOpen(vehPedIsIn, 5, false)
						end
					end, extrasMenu)
					RageUI.Button('Peintures' , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					end, colorMenu)
					RageUI.Button('Néons' , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					end, neonMenu)  
					RageUI.Button('Ameliorations' , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					end, upgradeMenu) 
					RageUI.CenterButton('Panier' , nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					end, cartMenu) 
				end, function()
				end)

				RageUI.IsVisible(payMenu, true, true, true, function()
					for _, player in ipairs(GetActivePlayers()) do
						local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
						local coords = GetEntityCoords(GetPlayerPed(player))
						local name = replaceBoatText(player)
						local sta = Extasy.IsMyId(player)
		
						if dst < 3.0 then
							RageUI.Button("#".._.." "..name, nil, {}, true, function(Hovered, Active, Selected)
								if Active then
									DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
								end
	
								if Selected then
									RageUI.CloseAll()
									VcCustoms_in_menu = false

									local vehModsNew = ESX.Game.GetVehicleProperties(vehPedIsIn)
									TriggerServerEvent('Extasy_customs:finishPurchase', token, "vccustoms", VcCustoms_sellDetails.vehModsNew, VcCustoms_sellDetails.shopCart, GetPlayerServerId(player), VcCustoms_sellDetails.shopProfit)
									
									print(VcCustoms_sellDetails.price)
									print(GetPlayerServerId(player))
									print(VcCustoms_sellDetails.vehModsNew)
									print(VcCustoms_sellDetails.shopCart)
									print(VcCustoms_sellDetails.shopProfit)
									print("-------------------")
									TriggerServerEvent("VcCustoms:setupBilling", token, "Achat d'une customisation", VcCustoms_sellDetails.price, "vccustoms", GetPlayerServerId(player), true, "VcCustoms:processBilling", VcCustoms_sellDetails.price, false, VcCustoms_sellDetails.vehModsNew, VcCustoms_sellDetails.name, VcCustoms_sellDetails.shopCart, VcCustoms_sellDetails.shopProfit)
								end
							end)  
						end
					end
				end, function()
				end)
				
				RageUI.IsVisible(bodyMenu, true, true, true, function()
					local menuItemCount = 0
						for i = 1, #tempBodyParts, 1 do
							local modCount = GetNumVehicleMods(vehPedIsIn, tempBodyParts[i]['modType'])
							--print(tempBodyParts[i]['mod'] .. ' modCount: ' .. modCount)
							local bodyIndex = 1
							bodyIndex = bodyPartIndex[i][tempBodyParts[i]['mod']]
							if modCount > 0 then
								if vehicleClass ~= 8 or (tempBodyParts[i]['mod'] ~= 'wheels' and vehicleClass == 8) then
									local itemLabel = tempBodyParts[i]['label']
									if tempBodyParts[i]['mod'] ~= 'wheels' then
										itemLabel = itemLabel .. " (" .. (calcModPrice(tempBodyParts[i]['items']['price']) .. "$" or "---") .. ")" 
									end
									RageUI.List(itemLabel, (tempBodyParts[i]['mod'] ~= 'wheels') and tempBodyParts[i]['items']['label'] or tempBodyParts[i]['items'], bodyIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
										if bodyPartIndex[i][tempBodyParts[i]['mod']] ~= Index and Index <= modCount + 1 then -- +1 para contar com o index da peça STOCK
											bodyPartIndex[i][tempBodyParts[i]['mod']] = Index
											if Selected then
												
											end
										end
									end,
									function(Index, CurrentItems)
										local itemIndex = Index - (tempBodyParts[i]['mod'] ~= 'wheels' and 2 or 1)
										if tempBodyParts[i]['mod'] ~= 'wheels' then
											SetVehicleMod(vehPedIsIn, tempBodyParts[i]['modType'], itemIndex, false)
											compareMods(tempBodyParts[i]['label'], tempBodyParts[i]['mod'], tempBodyParts[i]['modType'], itemIndex, calcModPrice(tempBodyParts[i]['items']['price']))
										elseif tempBodyParts[i]['mod'] == 'wheels' then
											bodyPartIndex[13][tempBodyParts[13]['mod']] = 1
											SetVehicleWheelType(vehPedIsIn, tempBodyParts[i]['wheelType'][Index])
											SetVehicleMod(vehPedIsIn, 23, -1, false)
											compareMods(tempBodyParts[13]['label'], tempBodyParts[13]['mod'], tempBodyParts[13]['modType'], 1, 0)
											ResetWheelItems()
											BuildWheelsLabel()
										elseif tempBodyParts[i]['mod'] == 'modFrontWheels' then
											SetVehicleMod(vehPedIsIn, 23, Index - 2, false)
											if vehicleClass == 8 then
												SetVehicleMod(vehPedIsIn, 24, Index - 2, false)
											end
											compareMods(tempBodyParts[i]['label'], tempBodyParts[i]['mod'], tempBodyParts[i]['modType'], itemIndex, calcModPrice(tempBodyParts[i]['items']['price']))
										end
									end)
									menuItemCount = menuItemCount + 1
								end
							end
						end
						if menuItemCount == 0 then
							RageUI.Button('pas de stock' , 'Il n\'y a pas de stock !!', {RightLabel = "retour"}, true, function(Hovered, Active, Selected)	
							end, mainMenu)
						end
					end, function()
					end)
				RageUI.IsVisible(extrasMenu, true, true, true, function()
						local menuItemCount = 0
						for i = 1, #tempExtras, 1 do
							local modCount = GetNumVehicleMods(vehPedIsIn, tempExtras[i]['modType'])
							--print(tempExtras[i]['mod'] .. ' modCount: ' .. modCount)
							local extraIndex = 1
							extraIndex = extrasIndex[i][tempExtras[i]['mod']]
							if modCount > 0 then
								local itemLabel = tempExtras[i]['label'] .. " (" .. (calcModPrice(tempExtras[i]['items']['price']) .. "$" or "---") .. ")"
								RageUI.List(itemLabel, tempExtras[i]['items']['label'], extraIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
										if extrasIndex[i][tempExtras[i]['mod']] ~= Index and Index <= modCount + 1 then -- +1 para contar com o index da peça STOCK
											extrasIndex[i][tempExtras[i]['mod']] = Index
											if Selected then
											end
										end
									end,
									function(Index, CurrentItems)
										local itemIndex = Index - 2
										SetVehicleMod(vehPedIsIn, tempExtras[i]['modType'], itemIndex, false)
										if tempExtras[i]['mod'] == 'modLivery' then
											SetVehicleLivery(vehPedIsIn, itemIndex)
										end
										compareMods(tempExtras[i]['label'], tempExtras[i]['mod'], tempExtras[i]['modType'], itemIndex, calcModPrice(tempExtras[i]['items']['price']))
									end)
								menuItemCount = menuItemCount + 1
							end
						end
						if menuItemCount == 0 then
							RageUI.Button('pas de stock' , 'Il n\'y a pas de stock !!', {LeftBadge = nil, RightBadge = nil, RightLabel = "Retour"}, true, function(Hovered, Active, Selected)
							end, mainMenu)
						end
					end, function()
					end
				)
				RageUI.IsVisible(colorMenu, true, true, true, function()
						if bodyPartIndex[13]['modFrontWheels'] ~= 1 then
							local item = findItem(tempColorParts['label'], 'roue')
							local itemPos = item and item or 0
							if itemPos == 0 then
								table.insert(tempColorParts['label'], 'roue')
								table.insert(tempColorParts['mod'], 'wheels')
							end
						else
							local item = findItem(tempColorParts['label'], 'roue')
							local itemPos = item and item or 0
							if itemPos > 1 then
								tempColorParts['label'][itemPos] = nil
								tempColorParts['mod'][itemPos] = nil
								colorPartIndex = 1
							end
						end
						RageUI.Checkbox(cfg_VcCustoms.tireSmoke['label'] .. " (" .. (calcModPrice(cfg_VcCustoms.tireSmoke['price']) .. "$" or "---") .. ")", 
							nil, 
							tyreSmokeActive, 
							{ Style = RageUI.CheckboxStyle.Tick }, 
							function(Hovered, Selected, Active, Checked)
								if Active then
									tyreSmokeActive = Checked and true or false
									if tyreSmokeActive then
										local item = findItem(tempColorParts['label'], 'Fumée des pneus')
										local itemPos = item and item or 0
										if itemPos == 0 then
											table.insert(tempColorParts['label'], 'Fumée des pneus')
											table.insert(tempColorParts['mod'], 'tireSmoke')
										end
									else
										local item = findItem(tempColorParts['label'], 'Fumée des pneus')
										local itemPos = item and item or 0
										if itemPos > 1 then
											tempColorParts['label'][itemPos] = nil
											tempColorParts['mod'][itemPos] = nil
											colorPartIndex = 1
										end
									end
									ToggleVehicleMod(vehPedIsIn, 20, tyreSmokeActive)
									compareMods(cfg_VcCustoms.tireSmoke['label'], cfg_VcCustoms.tireSmoke['mod'], 20, tyreSmokeActive, ((tyreSmokeActive and vehModsOld['modSmokeEnabled']) or (not tyreSmokeActive and vehModsOld['modSmokeEnabled'])) and 0 or calcModPrice(cfg_VcCustoms.tireSmoke['price']))
								end
							end
						)
						RageUI.Checkbox(cfg_VcCustoms.xenon['label'] .. " (" .. (calcModPrice(cfg_VcCustoms.xenon['price']) .. "$" or "---") .. ")", nil, xenonActive, { Style = RageUI.CheckboxStyle.Tick }, 
							function(Hovered, Selected, Active, Checked)
								if Active then
									xenonActive = Checked and true or false
									if xenonActive then
										local item = findItem(tempColorParts['label'], 'Phares')
										local itemPos = item and item or 0
										if itemPos == 0 then
											table.insert(tempColorParts['label'], 'Phares')
											table.insert(tempColorParts['mod'], 'headlights')
										end
									else
										local item = findItem(tempColorParts['label'], 'Phares')
										local itemPos = item and item or 0
										if itemPos > 1 then
											tempColorParts['label'][itemPos] = nil
											tempColorParts['mod'][itemPos] = nil
											colorPartIndex = 1
										end
									end
									ToggleVehicleMod(vehPedIsIn, 22, xenonActive)
									compareMods(cfg_VcCustoms.xenon['label'], cfg_VcCustoms.xenon['mod'], 22, xenonActive, ((xenonActive and vehModsOld['modXenon']) or (not xenonActive and vehModsOld['modXenon'])) and 0 or calcModPrice(cfg_VcCustoms.xenon['price']))
								end
							end
						)
						RageUI.List('Partie à peindre', tempColorParts['label'], colorPartIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
							end,
							function(Index, CurrentItems)
								colorPartIndex = Index
							end
						)
						if colorPartIndex <= 3 then
							RageUI.List('Type de peinture',
								cfg_VcCustoms.resprayTypes[colorPartIndex]['label'], 
								colorTypeIndex[colorPartIndex],
								nil, 
								{}, 
								true, 
								function(Hovered, Active, Selected, Index)
								end,
								function(Index, CurrentItems)
									colorTypeIndex[colorPartIndex] = Index
									if tempColorParts['mod'][colorPartIndex] == 'primary' then
										primaryColorIndex = 1
										ClearVehicleCustomPrimaryColour(vehPedIsIn)
									elseif tempColorParts['mod'][colorPartIndex] == 'secondary' then
										secondaryColorIndex = 1
										ClearVehicleCustomSecondaryColour(vehPedIsIn)
									elseif tempColorParts['mod'][colorPartIndex] == 'pearlescent' then
										pearlColorIndex = 1
									end
								end
							)
							if tempColorParts['mod'][colorPartIndex] == 'primary' then
								if cfg_VcCustoms.resprayTypes[1]['mod'][colorTypeIndex[1]] == "personalize" then
									RageUI.Slider(primaryCustomColorIndex[1]['label'] .. " [" .. primaryCustomColorIndex[1]['index'] .. "]", primaryCustomColorIndex[1]['index'], 255, nil, false, {}, true,
										function(Hovered, Selected, Active, Index)
											if (primaryCustomColorIndex[1]['index'] == 255 and Index == 1) or 
												(primaryCustomColorIndex[1]['index'] == 1 and Index == 255) then
												Index = 0
											end
											if primaryCustomColorIndex[1]['index'] ~= Index then
												primaryCustomColorIndex[1]['index'] = Index
												SetVehicleCustomPrimaryColour(vehPedIsIn, primaryCustomColorIndex[1]['index'], primaryCustomColorIndex[2]['index'], primaryCustomColorIndex[3]['index'])
												compareMods('couleur personalier', 'customColorPrimary', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['customPrimaryColorPrice']))
											end
										end)
									RageUI.Slider(primaryCustomColorIndex[2]['label'] .. " [" .. primaryCustomColorIndex[2]['index'] .. "]", primaryCustomColorIndex[2]['index'], 255, nil, false, {}, true, function(Hovered, Selected, Active, Index)
										if (primaryCustomColorIndex[2]['index'] == 255 and Index == 1) or 
											(primaryCustomColorIndex[2]['index'] == 1 and Index == 255) then
											Index = 0
										end
										if primaryCustomColorIndex[2]['index'] ~= Index then
											primaryCustomColorIndex[2]['index'] = Index
											SetVehicleCustomPrimaryColour(vehPedIsIn, primaryCustomColorIndex[1]['index'], primaryCustomColorIndex[2]['index'], primaryCustomColorIndex[3]['index'])
											compareMods('couleur personalier', 'customColorPrimary', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['customPrimaryColorPrice']))
										end
									end)
									RageUI.Slider(primaryCustomColorIndex[3]['label'] .. " [" .. primaryCustomColorIndex[3]['index'] .. "]", primaryCustomColorIndex[3]['index'], 255, nil, false, {}, true,function(Hovered, Selected, Active, Index)
										if (primaryCustomColorIndex[3]['index'] == 255 and Index == 1) or 
											(primaryCustomColorIndex[3]['index'] == 1 and Index == 255) then
											Index = 0
										end
										if primaryCustomColorIndex[3]['index'] ~= Index then
											primaryCustomColorIndex[3]['index'] = Index
											SetVehicleCustomPrimaryColour(vehPedIsIn, primaryCustomColorIndex[1]['index'], primaryCustomColorIndex[2]['index'], primaryCustomColorIndex[3]['index'])
											compareMods('couleur personalier', 'customColorPrimary', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['customPrimaryColorPrice']))
										end
									end)	
									RageUI.Slider('Finition primaire' .. " [" .. primaryPaintFinishIndex .. "]", primaryPaintFinishIndex, #cfg_VcCustoms.paintFinish, "", false, {}, true,
										function(Hovered, Selected, Active, Index)
											if primaryPaintFinishIndex ~= Index then
												primaryPaintFinishIndex = Index
												SetVehicleColours(vehPedIsIn, cfg_VcCustoms.paintFinish[primaryPaintFinishIndex], cfg_VcCustoms.paintFinish[secondaryPaintFinishIndex])
												compareMods('Finition primaire', 'primaryPaintFinish', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['primaryPaintFinishPrice']))
											end
										end
									)
								else
									RageUI.Slider('primaire' .. " [" .. primaryColorIndex .. "]", primaryColorIndex, #cfg_VcCustoms.colorPalette[colorTypeIndex[1]][cfg_VcCustoms.resprayTypes[1]['mod'][colorTypeIndex[1]]], "", false, {}, true, function(Hovered, Selected, Active, Index)
										if primaryColorIndex ~= Index then
											primaryColorIndex = Index
											SetVehicleColours(vehPedIsIn, cfg_VcCustoms.colorPalette[colorTypeIndex[1]][cfg_VcCustoms.resprayTypes[1]['mod'][colorTypeIndex[1]]][primaryColorIndex], cfg_VcCustoms.colorPalette[colorTypeIndex[2]][cfg_VcCustoms.resprayTypes[2]['mod'][colorTypeIndex[2]]][secondaryColorIndex])
											compareMods('primaire', 'color1', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['primaryColorPrice']))
										end
									end)
								end
							elseif tempColorParts['mod'][colorPartIndex] == 'secondary' then
								--ClearVehicleCustomSecondaryColour
								if cfg_VcCustoms.resprayTypes[2]['mod'][colorTypeIndex[2]] == "personalize" then
									RageUI.Slider(secondaryCustomColorIndex[1]['label'] .. " [" .. secondaryCustomColorIndex[1]['index'] .. "]", secondaryCustomColorIndex[1]['index'], 255, nil, false, {}, true,
										function(Hovered, Selected, Active, Index)
											if (secondaryCustomColorIndex[1]['index'] == 255 and Index == 1) or 
												(secondaryCustomColorIndex[1]['index'] == 1 and Index == 255) then
												Index = 0
											end
											if secondaryCustomColorIndex[1]['index'] ~= Index then
												secondaryCustomColorIndex[1]['index'] = Index
												SetVehicleCustomSecondaryColour(vehPedIsIn, secondaryCustomColorIndex[1]['index'], secondaryCustomColorIndex[2]['index'], secondaryCustomColorIndex[3]['index'])
												compareMods('Finition secondaire', 'customColorSecondary', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['customSecondaryColorPrice']))
											end
										end
									)
									RageUI.Slider(secondaryCustomColorIndex[2]['label'] .. " [" .. secondaryCustomColorIndex[2]['index'] .. "]", secondaryCustomColorIndex[2]['index'], 255, nil, false, {}, true,
										function(Hovered, Selected, Active, Index)
											if (secondaryCustomColorIndex[2]['index'] == 255 and Index == 1) or 
												(secondaryCustomColorIndex[2]['index'] == 1 and Index == 255) then
												Index = 0
											end
											if secondaryCustomColorIndex[2]['index'] ~= Index then
												secondaryCustomColorIndex[2]['index'] = Index
												SetVehicleCustomSecondaryColour(vehPedIsIn, secondaryCustomColorIndex[1]['index'], secondaryCustomColorIndex[2]['index'], secondaryCustomColorIndex[3]['index'])
												compareMods('Finition secondaire', 'customColorSecondary', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['customSecondaryColorPrice']))
											end
										end
									)
									RageUI.Slider(secondaryCustomColorIndex[3]['label'] .. " [" .. secondaryCustomColorIndex[3]['index'] .. "]", secondaryCustomColorIndex[3]['index'], 255, nil, false, {}, true,
										function(Hovered, Selected, Active, Index)
											if (secondaryCustomColorIndex[3]['index'] == 255 and Index == 1) or 
												(secondaryCustomColorIndex[3]['index'] == 1 and Index == 255) then
												Index = 0
											end
											secondaryCustomColorIndex[3]['index'] = Index
											SetVehicleCustomSecondaryColour(vehPedIsIn, secondaryCustomColorIndex[1]['index'], secondaryCustomColorIndex[2]['index'], secondaryCustomColorIndex[3]['index'])
											compareMods('Finition secondaire', 'customColorSecondary', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['customSecondaryColorPrice']))
										end
									)	
									RageUI.Slider('Finition secondaire' .. " [" .. secondaryPaintFinishIndex .. "]", secondaryPaintFinishIndex, #cfg_VcCustoms.paintFinish, "", false, {}, true,
										function(Hovered, Selected, Active, Index)
											secondaryPaintFinishIndex = Index
											if secondaryPaintFinishIndex ~= Index then
												SetVehicleColours(vehPedIsIn, cfg_VcCustoms.paintFinish[primaryPaintFinishIndex], cfg_VcCustoms.paintFinish[secondaryPaintFinishIndex])
												compareMods('Finition secondaire', 'secondaryPaintFinish', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['secondaryPaintFinishPrice']))
											end
										end
									)
								else
									RageUI.Slider('Peinture secondaire' .. " [" .. secondaryColorIndex .. "]", secondaryColorIndex, #cfg_VcCustoms.colorPalette[colorTypeIndex[2]][cfg_VcCustoms.resprayTypes[2]['mod'][colorTypeIndex[2]]], "", false, {}, true,
										function(Hovered, Selected, Active, Index)
											if secondaryColorIndex ~= Index then
												secondaryColorIndex = Index
												SetVehicleColours(vehPedIsIn, cfg_VcCustoms.colorPalette[colorTypeIndex[1]][cfg_VcCustoms.resprayTypes[1]['mod'][colorTypeIndex[1]]][primaryColorIndex], cfg_VcCustoms.colorPalette[colorTypeIndex[2]][cfg_VcCustoms.resprayTypes[2]['mod'][colorTypeIndex[2]]][secondaryColorIndex])
												compareMods('Peinture secondaire', 'color2', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['secondaryColorPrice']))
											end
										end
									)
								end
							elseif tempColorParts['mod'][colorPartIndex] == 'pearlescent' then
								RageUI.Slider('Nacré' .. " [" .. pearlColorIndex .. "]", pearlColorIndex, #cfg_VcCustoms.colorPalette[colorTypeIndex[3]][cfg_VcCustoms.resprayTypes[3]['mod'][colorTypeIndex[3]]], "", false, {}, true,
									function(Hovered, Selected, Active, Index)
										if pearlColorIndex ~= Index then
											pearlColorIndex = Index
											SetVehicleExtraColours(vehPedIsIn, cfg_VcCustoms.colorPalette[colorTypeIndex[3]][cfg_VcCustoms.resprayTypes[3]['mod'][colorTypeIndex[3]]][pearlColorIndex], cfg_VcCustoms.colorPalette[1]['metallic'][wheelColorIndex])
											compareMods('Nacré', 'pearlescentColor', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['pearlescentColorPrice']))
										end
									end
								)
							end
						elseif colorPartIndex == 4 then
							RageUI.List('fenêtres',
								cfg_VcCustoms.resprayTypes[colorPartIndex]['label'], 
								windowTintIndex,
								nil, 
								{}, 
								true, 
								function(Hovered, Active, Selected, Index)
								end,
								function(Index, CurrentItems)
									local itemIndex = windowTintIndex - 2
									windowTintIndex = Index
									compareMods(cfg_VcCustoms.windowTints['label'], cfg_VcCustoms.windowTints['mod'], -1, itemIndex, calcModPrice(cfg_VcCustoms.windowTints['price']))
									SetVehicleWindowTint(vehPedIsIn, windowTintIndex - 2)
								end
							)
						elseif tempColorParts['mod'][colorPartIndex] == 'wheels' then
							RageUI.Slider('Couleur de la roue' .. " (" .. (cfg_VcCustoms.colorPalette[8]['wheelPrice'] .. "$" or "---") .. ")",
								wheelColorIndex, #cfg_VcCustoms.colorPalette[1]['metallic'], nil, false, {}, true,
								function(Hovered, Selected, Active, Index)
									if wheelColorIndex ~= Index then
										wheelColorIndex = Index
										SetVehicleExtraColours(vehPedIsIn, cfg_VcCustoms.colorPalette[colorTypeIndex[3]][cfg_VcCustoms.resprayTypes[3]['mod'][colorTypeIndex[3]]][pearlColorIndex], cfg_VcCustoms.colorPalette[1]['metallic'][wheelColorIndex])
										compareMods('Couleur de la roue', 'wheelColor', -1, Index, calcModPrice(cfg_VcCustoms.colorParts['wheelColorPrice']))
									end
								end
							)
						elseif tempColorParts['mod'][colorPartIndex] == 'tireSmoke' then 
							RageUI.Slider(smokeColorIndex[1]['label'] .. " [" .. smokeColorIndex[1]['index'] .. "]", smokeColorIndex[1]['index'], 255, nil, false, {}, true,
								function(Hovered, Selected, Active, Index)
									if (smokeColorIndex[1]['index'] == 255 and Index == 1) or 
										(smokeColorIndex[1]['index'] == 1 and Index == 255) then
										Index = 0
									end
									smokeColorIndex[1]['index'] = Index
									if vehModsOld['modSmokeEnabled'] then
										SetVehicleTyreSmokeColor(vehPedIsIn, smokeColorIndex[1]['index'], smokeColorIndex[2]['index'], smokeColorIndex[3]['index'])
										compareMods(cfg_VcCustoms.tireSmoke['label1'], cfg_VcCustoms.tireSmoke['mod1'], -1, Index, calcModPrice(cfg_VcCustoms.tireSmoke['price']))
									end
								end
							)
							RageUI.Slider(smokeColorIndex[2]['label'] .. " [" .. smokeColorIndex[2]['index'] .. "]", smokeColorIndex[2]['index'], 255, nil, false, {}, true,
								function(Hovered, Selected, Active, Index)
									if (smokeColorIndex[2]['index'] == 255 and Index == 1) or 
										(smokeColorIndex[2]['index'] == 1 and Index == 255) then
										Index = 0
									end
									smokeColorIndex[2]['index']= Index
									if vehModsOld['modSmokeEnabled'] then
										SetVehicleTyreSmokeColor(vehPedIsIn, smokeColorIndex[1]['index'], smokeColorIndex[2]['index'], smokeColorIndex[3]['index'])
										compareMods(cfg_VcCustoms.tireSmoke['label1'], cfg_VcCustoms.tireSmoke['mod1'], -1, Index, calcModPrice(cfg_VcCustoms.tireSmoke['price']))
									end
								end
							)
							RageUI.Slider(smokeColorIndex[3]['label'] .. " [" .. smokeColorIndex[3]['index'] .. "]", smokeColorIndex[3]['index'], 255, nil, false, {}, true,
								function(Hovered, Selected, Active, Index)
									if (smokeColorIndex[3]['index'] == 255 and Index == 1) or 
										(smokeColorIndex[3]['index'] == 1 and Index == 255) then
										Index = 0
									end
									smokeColorIndex[3]['index'] = Index
									if vehModsOld['modSmokeEnabled'] then
										SetVehicleTyreSmokeColor(vehPedIsIn, smokeColorIndex[1]['index'], smokeColorIndex[2]['index'], smokeColorIndex[3]['index'])
										compareMods(cfg_VcCustoms.tireSmoke['label1'], cfg_VcCustoms.tireSmoke['mod1'], -1, Index, calcModPrice(cfg_VcCustoms.tireSmoke['price']))
									end
								end
							)
						--[[elseif tempColorParts['mod'][colorPartIndex] == 'headlights' then
							RageUI.Slider('Phares',
								xenonColorIndex, #cfg_VcCustoms.xenon['items']['color'], nil, false, {}, true,
								function(Hovered, Selected, Active, Index)
									xenonColorIndex = Index
									if vehModsOld['modXenon'] then
										SetVehicleXenonLightsColour(vehPedIsIn, cfg_VcCustoms.xenon['items']['color'][xenonColorIndex])
										compareMods(cfg_VcCustoms.xenon['label1'], cfg_VcCustoms.xenon['mod1'], -1, Index, calcModPrice(cfg_VcCustoms.xenon['price']))
									end
								end
							)--]]
						end
					end, function()
						---Panels
					end
				)
				RageUI.IsVisible(neonMenu, true, true, true, function()
						RageUI.Checkbox(tempNeons[1]['label'] .. " (" .. (calcModPrice(tempNeons[1]['price']) .. "$" or "---") .. ")", 
							nil, 
							neon1, 
							{ Style = RageUI.CheckboxStyle.Tick }, 
							function(Hovered, Selected, Active, Checked)
								if Active then
									neon1 = Checked and true or false
									SetVehicleNeonLightEnabled(vehPedIsIn, 0, neon1)
									compareMods(cfg_VcCustoms.neons[1]['label'], cfg_VcCustoms.neons[1]['mod'], -1, neon1, ((neon1 and vehModsOld['neonEnabled'][1]) or (not neon1 and vehModsOld['neonEnabled'][1])) and 0 or calcModPrice(tempNeons[1]['price']))
								end
							end
						)
						RageUI.Checkbox(tempNeons[2]['label'] .. " (" .. (calcModPrice(tempNeons[2]['price']) .. "$" or "---") .. ")", 
							nil, 
							neon2, 
							{ Style = RageUI.CheckboxStyle.Tick }, 
							function(Hovered, Selected, Active, Checked)
								if Active then
									neon2 = Checked and true or false
									SetVehicleNeonLightEnabled(vehPedIsIn, 1, neon2)
									compareMods(cfg_VcCustoms.neons[2]['label'], cfg_VcCustoms.neons[2]['mod'], -1, neon2, ((neon2 and vehModsOld['neonEnabled'][3]) or (not neon2 and vehModsOld['neonEnabled'][3])) and 0 or calcModPrice(tempNeons[2]['price']))
								end
							end
						)
						RageUI.Checkbox(tempNeons[3]['label'] .. " (" .. (calcModPrice(tempNeons[3]['price']) .. "$" or "---") .. ")", 
							nil, 
							neon3, 
							{ Style = RageUI.CheckboxStyle.Tick }, 
							function(Hovered, Selected, Active, Checked)
								if Active then
									neon3 = Checked and true or false
									SetVehicleNeonLightEnabled(vehPedIsIn, 2, neon3)
									compareMods(cfg_VcCustoms.neons[3]['label'], cfg_VcCustoms.neons[3]['mod'], -1, neon3, ((neon3 and vehModsOld['neonEnabled'][2]) or (not neon3 and vehModsOld['neonEnabled'][2])) and 0 or calcModPrice(tempNeons[3]['price']))
								end
							end
						)
						RageUI.Checkbox(tempNeons[4]['label'] .. " (" .. (calcModPrice(tempNeons[4]['price']) .. "$" or "---") .. ")", 
							nil, 
							neon4, 
							{ Style = RageUI.CheckboxStyle.Tick }, 
							function(Hovered, Selected, Active, Checked)
								if Active then
									neon4 = Checked and true or false
									SetVehicleNeonLightEnabled(vehPedIsIn, 3, neon4)
									compareMods(cfg_VcCustoms.neons[4]['label'], cfg_VcCustoms.neons[4]['mod'], -1, neon4, ((neon4 and vehModsOld['neonEnabled'][4]) or (not neon4 and vehModsOld['neonEnabled'][4])) and 0 or calcModPrice(tempNeons[4]['price']))
								end
							end)

						if neon1 or neon2 or neon3 or neon4 then
							RageUI.Slider(neonIndex[1]['label'] .. " [" .. neonIndex[1]['index'] .. "]", neonIndex[1]['index'], 255, nil, false, {}, true,
								function(Hovered, Selected, Active, Index)
									if (neonIndex[1]['index'] == 255 and Index == 1) or 
										(neonIndex[1]['index'] == 1 and Index == 255) then
										Index = 0
									end
									if neonIndex[1]['index'] ~= Index then
										neonIndex[1]['index'] = Index
										SetVehicleNeonLightsColour(vehPedIsIn, neonIndex[1]['index'], neonIndex[2]['index'], neonIndex[3]['index'])
										if vehModsOld['neonEnabled'][1] or vehModsOld['neonEnabled'][2] or vehModsOld['neonEnabled'][3] or vehModsOld['neonEnabled'][4] then
											compareMods(cfg_VcCustoms.neons[5]['label'], cfg_VcCustoms.neons[5]['mod'], -1, Index, calcModPrice(cfg_VcCustoms.neons[5]['price']))
										end
									end
								end)
							RageUI.Slider(neonIndex[2]['label'] .. " [" .. neonIndex[2]['index'] .. "]", neonIndex[2]['index'], 255, nil, false, {}, true,
								function(Hovered, Selected, Active, Index)
									if (neonIndex[2]['index'] == 255 and Index == 1) or 
										(neonIndex[2]['index'] == 1 and Index == 255) then
										Index = 0
									end
									if neonIndex[2]['index'] ~= Index then
										neonIndex[2]['index']= Index
										SetVehicleNeonLightsColour(vehPedIsIn, neonIndex[1]['index'], neonIndex[2]['index'], neonIndex[3]['index'])
										if vehModsOld['neonEnabled'][1] or vehModsOld['neonEnabled'][2] or vehModsOld['neonEnabled'][3] or vehModsOld['neonEnabled'][4] then
											compareMods(cfg_VcCustoms.neons[5]['label'], cfg_VcCustoms.neons[5]['mod'], -1, Index, calcModPrice(cfg_VcCustoms.neons[5]['price']))
										end
									end
								end)
							RageUI.Slider(neonIndex[3]['label'] .. " [" .. neonIndex[3]['index'] .. "]", neonIndex[3]['index'], 255, nil, false, {}, true, function(Hovered, Selected, Active, Index)
								if (neonIndex[3]['index'] == 255 and Index == 1) or 
									(neonIndex[3]['index'] == 1 and Index == 255) then
									Index = 0
								end
								if neonIndex[3]['index'] ~= Index then
									neonIndex[3]['index'] = Index
									SetVehicleNeonLightsColour(vehPedIsIn, neonIndex[1]['index'], neonIndex[2]['index'], neonIndex[3]['index'])
									if vehModsOld['neonEnabled'][1] or vehModsOld['neonEnabled'][2] or vehModsOld['neonEnabled'][3] or vehModsOld['neonEnabled'][4] then
										compareMods(cfg_VcCustoms.neons[5]['label'], cfg_VcCustoms.neons[5]['mod'], -1, Index, calcModPrice(cfg_VcCustoms.neons[5]['price']))
									end
								end
							end)
						end
					end, function()
					end)
				RageUI.IsVisible(upgradeMenu, true, true, true, function()
						local menuItemCount = 0
						for i = 1, #tempUpgrades, 1 do
							local modCount = GetNumVehicleMods(vehPedIsIn, tempUpgrades[i]['modType'])
							--print(tempUpgrades[i]['mod'] .. ' modCount: ' .. modCount)
							local upgIndex = 1
							if tempUpgrades[i]['mod'] == 'modTurbo' then
								upgIndex = upgradeIndex[i][tempUpgrades[i]['mod']] and true or false
								local itemLabel = tempUpgrades[i]['label'] .. " (" .. (not upgIndex and (calcModPrice(tempUpgrades[i]['items']['price'][2]) or 0) .. "$" or "0$") .. ")"
								RageUI.Checkbox(itemLabel, 
									nil, 
									upgIndex, 
									{ Style = RageUI.CheckboxStyle.Tick }, 
									function(Hovered, Selected, Active, Checked)
										if Active then
											upgradeIndex[i][tempUpgrades[i]['mod']] = Checked and true or false
											ToggleVehicleMod(vehPedIsIn, tempUpgrades[i]['modType'], upgradeIndex[i][tempUpgrades[i]['mod']])
											compareMods(tempUpgrades[i]['label'], tempUpgrades[i]['mod'], tempUpgrades[i]['modType'], upgradeIndex[i][tempUpgrades[i]['mod']], Checked and calcModPrice(tempUpgrades[i]['items']['price'][2]) or 0)
										end
									end)
								menuItemCount = menuItemCount + 1
							elseif modCount > 0 then
								upgIndex = upgradeIndex[i][tempUpgrades[i]['mod']]
								local itemLabel = tempUpgrades[i]['label'] .. " (" .. (calcModPrice(tempUpgrades[i]['items']['price'][upgIndex]) .. "$" or "---") .. ")"
								RageUI.List(itemLabel,tempUpgrades[i]['items']['label'], upgIndex,nil, {}, true, function(Hovered, Active, Selected, Index)
									if upgradeIndex[i][tempUpgrades[i]['mod']] ~= Index and Index <= modCount + 1 then -- +1 para contar com o index da peça STOCK
										upgradeIndex[i][tempUpgrades[i]['mod']] = Index
										if Selected then
									
										end
									end
								end, function(Index, CurrentItems)
									local itemIndex = Index - 2
									SetVehicleMod(vehPedIsIn, tempUpgrades[i]['modType'], Index - 2, false)
									compareMods(tempUpgrades[i]['label'], tempUpgrades[i]['mod'], tempUpgrades[i]['modType'], itemIndex, calcModPrice(tempUpgrades[i]['items']['price'][Index]))
								end)
								menuItemCount = menuItemCount + 1
							end
						end
						if menuItemCount == 0 then
							RageUI.Button('pas de stock' , 'Il n\'y a pas de stock !!', {RightLabel = "Retour"}, true, function(Hovered, Active, Selected)	
							end, mainMenu)
						end
					end, function()
					end)

					RageUI.IsVisible(cartMenu, true, true, true, function()
						local menuItemCount = 0
						for k, v in pairs(shopCart) do 
							RageUI.Button(shopCart[k]['label'], "", {RightLabel = shopCart[k]['price'] .. " $"}, not deleting, function(Hovered, Active, Selected)
								if Active then
									if IsControlJustReleased(0, 22) then
										if deleting then
											return
										end
										deleting = true
										DeleteFromCart(k, shopCart[k]['modType'])
									end
								end
							end)
							menuItemCount = menuItemCount + 1
						end

						RageUI.Separator('↓ ~p~Paramètre du payment~w~ ↓')

						if menuItemCount == 0 then
							RageUI.Button('Aucune modification éfféctuée' , 'Vous n\'avez séléctionné aucun articles.', {RightLabel = "~o~Retour"}, true, function(Hovered, Active, Selected)
							end, mainMenu)
						else
							RageUI.Slider('Bénéfice pour l\'entreprise:' .. " ~y~(" .. shopProfit .. "%)~w~", shopProfit, 100, "", false, {}, true, function(Hovered, Selected, Active, Index)
								if (shopProfit == 100 and Index == 1) or 
									(shopProfit == 1 and Index == 100) then
									Index = 0
								end
								if Index ~= shopProfit then
									shopProfit = Index
									calcCartValue()
								end
							end)
							RageUI.Button('Montant total du bénéfice:' , 'Montant à retirer du compte d\'entreprise:', {RightLabel = "~g~ +"..shopProfitValue.." $" }, true, function(Hovered, Active, Selected) end)
							RageUI.Button('Coût pour l\'entreprise:' , 'Montant à retirer de la société:', {RightLabel = "~r~ -"..math.round(totalCartValue - shopProfitValue) .. " $"}, true, function(Hovered, Active, Selected) end)
							RageUI.Button('Montant à payer (Client):' , 'Montant payable par le client:', {RightLabel = "~o~"..totalCartValue .. " $"}, true, function(Hovered, Active, Selected) end)

							RageUI.CenterButton('~p~Envoyer la facture ~w~→', nil, {RightLabel = Extasy.Math.GroupDigits(totalCartValue).."$"}, true, function(Hovered, Active, Selected)
								if Selected then
									if stop then
										return
									end

									local vehModsNew = Extasy.GetVehicleProperties(vehPedIsIn)

									print("Sended Billing")

									VcCustoms_sellDetails.vehModsNew  	= vehModsNew
									VcCustoms_sellDetails.price 		= totalCartValue
									VcCustoms_sellDetails.shopProfit 	= shopProfit
									VcCustoms_sellDetails.shopCart		= shopCart

									stop = true
								end
							end, payMenu) 
						end
					end, function()
				end)
			else
				vehPedIsIn = nil
				terminatePurchase()
			end
		end
	end)
end

-- Prevent Free Tunning Bug
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if lsMenuIsShowed then
			DisableControlAction(2, 288, true)
			DisableControlAction(2, 289, true)
			DisableControlAction(2, 170, true)
			DisableControlAction(2, 167, true)
			DisableControlAction(2, 168, true)
			DisableControlAction(2, 23, true)
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Wait(1000)
		end
	end
end)

RegisterNetEvent("open:CustomMenu")
AddEventHandler("open:CustomMenu", function()
    openCustomMenu()
end)

RegisterNetEvent('VcCustoms:cantBill')
AddEventHandler('VcCustoms:cantBill', function(amount, targetId)
	--TriggerServerEvent('eBilling:sendBillExtasyyy', targetId, society, '~y~Mécano : Customisation', amount)
	terminatePurchase()
end)

RegisterNetEvent('VcCustoms:canBill')
AddEventHandler('VcCustoms:canBill', function(amount, targetId)
	--TriggerServerEvent('eBilling:sendBillExtasyyy', targetId, society, '~y~Mécano : Customisation', amount)
	terminatePurchase()
end)

RegisterNetEvent('VcCustoms:resetVehicle')
AddEventHandler('VcCustoms:resetVehicle', function(vehProps)
	ClearVehicleCustomPrimaryColour(vehPedIsIn)
	ClearVehicleCustomSecondaryColour(vehPedIsIn)
	ESX.Game.SetVehicleProperties(vehPedIsIn, vehProps)
	terminatePurchase()
end)

RegisterNetEvent('VcCustoms:getVehicle')
AddEventHandler('VcCustoms:getVehicle', function()
	TriggerServerEvent('VcCustoms:refreshOwnedVehicle', ESX.Game.GetVehicleProperties(vehPedIsIn))
end)

findItem = function(arr, itemToFind)
	local foundIt = false
	local index = nil
	for i = 1, #arr, 1 do
		if arr[i] == itemToFind then
			foundIt = true
			index = i
			break
		end
	end
	if not foundIt then
		return foundIt
	else
		return index
	end
end

findKey = function(obj, keyToFind)
	local foundIt = false
	local key = nil
	for k, v in pairs(obj) do
		if k == keyToFind then
			foundIt = true
			key = k
			break
		end
	end
	if not foundIt then
		return foundIt
	else
		return key
	end
end

calcFinalPrice = function(shopCart, shopProfit)
	local shopCostValue = 0
	local totalCartValue = 0
	for k, v in pairs(shopCart) do
		--print("k: " .. k)
		--print("v['price']: " .. v['price'])
		local c = v['price'] * (shopProfit / 100)
		shopCostValue = shopCostValue + v['price']
		totalCartValue = totalCartValue + v['price'] + c
	end
	return shopCostValue, totalCartValue
end

RegisterNetEvent("VcCustoms:processBilling")
AddEventHandler("VcCustoms:processBilling", function(sender, buyer, hash, name, shopCart, shopProfit)
	local society = playerJob
	local vehModsNew = hash
	local buyer = buyer

	print("Id buyer : "..buyer)
	print("Id shopCart : "..shopCart)
	print("Id shopProfit : "..shopProfit)
	
	TriggerServerEvent('Extasy_customs:finishPurchase', token, society, vehModsNew, shopCart, buyer, shopProfit)
end)