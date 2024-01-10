local OwnedProperties, Blips, CurrentActionData = {}, {}, {}
local CurrentProperty, CurrentPropertyOwner, LastProperty, LastPart, CurrentAction, CurrentActionMsg
local firstSpawn, hasChest, hasAlreadyEnteredMarker = true, false, false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.TriggerServerCallback('esx_property:getProperties', function(properties)
		cfg_prorerty.Properties = properties
		CreateBlips()
	end)

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(result)
		for k,v in ipairs(result) do
			SetPropertyOwned(v.name, true, v.rented)
		end
	end)
end)

-- only used when script is restarting mid-session
RegisterNetEvent('esx_property:sendProperties')
AddEventHandler('esx_property:sendProperties', function(properties)
	cfg_prorerty.Properties = properties
	CreateBlips()

	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(result)
		for k,v in ipairs(result) do
			SetPropertyOwned(v.name, true, v.rented)
		end
	end)
end)

function DrawSub(text, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandPrint(time, 1)
end

function CreateBlips()
	for i=1, #cfg_prorerty.Properties, 1 do
		local property = cfg_prorerty.Properties[i]

		if property.entering then
			Blips[property.name] = AddBlipForCoord(property.entering.x, property.entering.y, property.entering.z)

			SetBlipSprite (Blips[property.name], 369)
			SetBlipDisplay(Blips[property.name], 4)
			SetBlipScale  (Blips[property.name], 0.4)
			SetBlipAsShortRange(Blips[property.name], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName('Proprétée libre')
			EndTextCommandSetBlipName(Blips[property.name])
		end
	end
end

function GetProperties()
	return cfg_prorerty.Properties
end

function GetProperty(name)
	for i=1, #cfg_prorerty.Properties, 1 do
		if cfg_prorerty.Properties[i].name == name then
			return cfg_prorerty.Properties[i]
		end
	end
end

function GetGateway(property)
	for i=1, #cfg_prorerty.Properties, 1 do
		local property2 = cfg_prorerty.Properties[i]

		if property2.isGateway and property2.name == property.gateway then
			return property2
		end
	end
end

function GetGatewayProperties(property)
	local properties = {}

	for i=1, #cfg_prorerty.Properties, 1 do
		if cfg_prorerty.Properties[i].gateway == property.name then
			table.insert(properties, cfg_prorerty.Properties[i])
		end
	end

	return properties
end

function EnterProperty(name, owner)
	local property       = GetProperty(name)
	local playerPed      = PlayerPedId()
	CurrentProperty      = property
	CurrentPropertyOwner = owner

	for i=1, #cfg_prorerty.Properties, 1 do
		if cfg_prorerty.Properties[i].name ~= name then
			cfg_prorerty.Properties[i].disabled = true
		end
	end

	TriggerServerEvent('esx_property:saveLastProperty', name)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		for i=1, #property.ipls, 1 do
			RequestIpl(property.ipls[i])

			while not IsIplActive(property.ipls[i]) do
				Citizen.Wait(0)
			end
		end

		SetEntityCoords(playerPed, property.inside.x, property.inside.y, property.inside.z)
		DoScreenFadeIn(800)
		DrawSub(property.label, 5000)
	end)

end

function ExitProperty(name)
	local property  = GetProperty(name)
	local playerPed = PlayerPedId()
	local outside   = nil
	CurrentProperty = nil

	if property.isSingle then
		outside = property.outside
	else
		outside = GetGateway(property).outside
	end

	TriggerServerEvent('esx_property:deleteLastProperty')

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		SetEntityCoords(playerPed, outside.x, outside.y, outside.z)

		for i=1, #property.ipls, 1 do
			RemoveIpl(property.ipls[i])
		end

		for i=1, #cfg_prorerty.Properties, 1 do
			cfg_prorerty.Properties[i].disabled = false
		end

		DoScreenFadeIn(800)
	end)
end

function SetPropertyOwned(name, owned, rented)
	local property     = GetProperty(name)
	local entering     = nil
	local enteringName = nil

 	if property.isSingle then
		entering     = property.entering
		enteringName = property.name
	else
		local gateway = GetGateway(property)
		entering      = gateway.entering
		enteringName  = gateway.name
	end

	if owned then
		OwnedProperties[name] = rented
		RemoveBlip(Blips[enteringName])

		Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
		SetBlipSprite(Blips[enteringName], 357)
		SetBlipAsShortRange(Blips[enteringName], true)
		SetBlipScale  (Blips[enteringName], 0.4)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName('property')
		EndTextCommandSetBlipName(Blips[enteringName])
	else
		OwnedProperties[name] = nil
		local found = false

		for k,v in pairs(OwnedProperties) do
			local _property = GetProperty(k)
			local _gateway  = GetGateway(_property)

			if _gateway then
				if _gateway.name == enteringName then
					found = true
					break
				end
			end
		end

		if not found then
			RemoveBlip(Blips[enteringName])

			Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
			SetBlipSprite(Blips[enteringName], 369)
			SetBlipAsShortRange(Blips[enteringName], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentSubstringPlayerName('Libre')
			EndTextCommandSetBlipName(Blips[enteringName])
		end
	end
end

	
function PropertyIsOwned(property)
	return OwnedProperties[property.name] ~= nil
end

local acheter = false
local louer = false
local pproperty = false
	RMenu.Add('property', 'main', RageUI.CreateMenu("Appartement", "Mon appartement"))
    RMenu:Get('property', 'main'):SetSubtitle("Mon appartement")
    RMenu:Get('property', 'main').EnableMouse = false
	RMenu:Get('property', 'main').Closed = function()
		pproperty = false
	end
	function OpenPropertyMenu(property)
		if pproperty then
			pproperty = false
		else
			pproperty = true
			RageUI.Visible(RMenu:Get('property', 'main'), true)
	
			Citizen.CreateThread(function()
				while pproperty do
					RageUI.IsVisible(RMenu:Get('property', 'main'), true, true, true, function()
								--[[local pricebg = ESX.Math.GroupDigits(property.price)
								if not cfg_prorerty.EnablePlayerManagement and acheter == false then
								RageUI.ButtonWithStyle("Acheter l'appartement pour ~r~"..ESX.Math.GroupDigits(property.price).. "$", nil, { RightLabel = "→→" },true, function(_,_,Selected)
									if (Selected) then
									TriggerServerEvent('esx_property:buyProperty', property.name)
									RageUI.CloseAll()
									acheter = true
								   end
							   end)
							end
								if not cfg_prorerty.EnablePlayerManagement and louer == false then
								local rent = ESX.Math.Round(property.price / cfg_prorerty.RentModifier)
								RageUI.ButtonWithStyle("Louer l'appartement pour ~r~"..ESX.Math.GroupDigits(rent).. "$", nil, { RightLabel = "→→" },true, function(_,_,Selected)
									if (Selected) then
										TriggerServerEvent('esx_property:rentProperty', property.name)
										Wait(150)
										RageUI.CloseAll()
										louer = true
									end
								end)
							end
									if acheter == true then
									RageUI.ButtonWithStyle("~m~Acheter l'appartement pour "..ESX.Math.GroupDigits(property.price).. "$", nil, { haveRightBadge = RageUI.BadgeStyle.Lock },true, function(_,_,Selected)
										if (Selected) then
										TriggerEvent('esx:showAdvancedNotification', 'Agence Immobilière', 'Logement', '~r~Vous ou une personne est déjà prioritaire de cet appartement', 'CHAR_BRYONY', 1)
									end
								end)
							end

							if louer == true then
								RageUI.ButtonWithStyle("~m~Louer l'appartement pour "..ESX.Math.GroupDigits(property.price).. "$", nil, { haveRightBadge = RageUI.BadgeStyle.Lock },true, function(_,_,Selected)
									if (Selected) then
									TriggerEvent('esx:showAdvancedNotification', 'Agence Immobilière', 'Logement', '~r~Vous ou une personne est déjà prioritaire de cet appartement', 'CHAR_BRYONY', 1)
								end
							end)
						         ]]

						if PropertyIsOwned(property) then
							RageUI.ButtonWithStyle("Entrer dans l'appartement", nil, { RightLabel = "→→" },true, function(_,_,Selected)
								if (Selected) then
									TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
									Wait(150)
									RageUI.CloseAll()
								end
							end)

							RageUI.ButtonWithStyle("Revendre sa propriété", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
								if (Selected) then
									TriggerServerEvent('OsirisProperty:removeOwnedProperty', token, property.name)
								end
							end)
						else
							if not cfg_prorerty.EnablePlayerManagement then		
								
								RageUI.ButtonWithStyle("Acheter l'appartement pour "..ESX.Math.GroupDigits(property.price).. "$", nil, {RightLabel = "→→"},true, function(Hovered, Active, Selected)
									if (Selected) then
										TriggerServerEvent('OsirisProperty:buyProperty',token, property.name)
										Wait(150)
										RageUI.CloseAll()
										acheter = true
									end
								end)
								RageUI.ButtonWithStyle("Louer l'appartement", nil, { RightLabel = "→→" },true, function(_,_,Selected)
									if (Selected) then
										TriggerServerEvent('esx_property:rentProperty', property.name)
										Wait(150)
										RageUI.CloseAll()
										louer = true
									end
								end)
								if louer == true then
									RageUI.ButtonWithStyle("Louer l'appartement pour "..ESX.Math.GroupDigits(property.price).. "$", nil, { haveRightBadge = RageUI.BadgeStyle.Lock },true, function(_,_,Selected)
										if (Selected) then
											TriggerEvent('esx:showAdvancedNotification', 'Agence Immobilière', 'Logement', '~r~Vous ou une personne est déjà prioritaire de cet appartement', 'CHAR_BRYONY', 1)
										end
									end)
								end
								if acheter == true then
									RageUI.ButtonWithStyle("~m~Acheter l'appartement pour "..ESX.Math.GroupDigits(property.price).. "$", nil, { haveRightBadge = RageUI.BadgeStyle.Lock },true, function(_,_,Selected)
										if (Selected) then
										TriggerEvent('esx:showAdvancedNotification', 'Agence Immobilière', 'Logement', '~r~Vous ou une personne est déjà prioritaire de cet appartement', 'CHAR_BRYONY', 1)
										end
									end)
								end
							RageUI.ButtonWithStyle("Visiter la propriété", nil, {RightLabel = ""},true, function(Hovered, Active, Selected)
								if (Selected) then
									TriggerEvent('instance:create', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
								end
							end)
						end
					end

				    end)
				Wait(0)
			end
		end)
	end
end

function CreateMain()
	local coords = GetEntityCoords(PlayerPedId())
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, coords.x-1.75, coords.y, coords.z)
    SetCamFov(cam, 50.0)
    PointCamAtCoord(cam, coords.x, coords.y, coords.z)
    SetCamShakeAmplitude(cam, 13.0)
    RenderScriptCams(1, 1, 1500, 1, 1)
end

function Tourner()
    local back = GetEntityHeading(PlayerPedId())
    SetEntityHeading(PlayerPedId(), back+180)
end

function Angle()
    AddTextEntry(GetCurrentResourceName(), ('Appuyez sur ~INPUT_JUMP~ pour changer de Côté'))
    DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
end

local propertyy = false
local TenueTable = {}


	RMenu.Add('propertyy', 'main', RageUI.CreateMenu("Appartement", "Mon appartement"))
	RMenu.Add('propertyy', 'dressing', RageUI.CreateSubMenu(RMenu:Get('propertyy', 'main'), "Mon dressing", "Mon appartement →"))
	RMenu.Add('propertyy', 'odeposer', RageUI.CreateSubMenu(RMenu:Get('propertyy', 'main'), "Mon Coffre", "Mon appartement →"))
	RMenu.Add('propertyy', 'oprendre', RageUI.CreateSubMenu(RMenu:Get('propertyy', 'main'), "Mon Coffre", "Mon appartement →"))
    RMenu.Add('propertyy', 'invite', RageUI.CreateSubMenu(RMenu:Get('propertyy', 'main'), "Inviter vos amis", "Mon appartement →"))
	RMenu.Add('propertyy', 'listetenu', RageUI.CreateSubMenu(RMenu:Get('propertyy', 'main'), "Vetement", "Mon appartement →"))
    RMenu:Get('propertyy', 'main'):SetSubtitle("Mon appartement")
    RMenu:Get('propertyy', 'main').EnableMouse = false
	RMenu:Get('propertyy', 'main').Closed = function()
		propertyy = false
	end

	local watodo = {
		indexwatodo = 1,
		listwatodo = {'Equiper', 'Supprimer'},
	}
	
	function OpenRoomMenu(property, owner)
		local entering = nil
		if propertyy then
			propertyy = false
		else
			propertyy = true
			RageUI.Visible(RMenu:Get('propertyy', 'main'), true)
	
			Citizen.CreateThread(function()
				while propertyy do
					RageUI.IsVisible(RMenu:Get('propertyy', 'main'), true, true, true, function()
		
						RageUI.ButtonWithStyle("Inviter vos amis", nil, { RightLabel = "→→" }, true, function()
						end, RMenu:Get('propertyy', 'invite'))

						RageUI.ButtonWithStyle("Mon Dressing", nil, { RightLabel = "→→" },true, function(h,a,s)
							if s then
								openClothesSaveMenu()
							end
						end)

						RageUI.ButtonWithStyle("Déposer des Objet(s)", nil, { RightLabel = "→→" }, true, function(h,a,s)
							if s then
							invItems = {}
							Itemsss = {}
							ESX.TriggerServerCallback('property:getPlayerInventory', function(inventory)
								for i=1, #inventory.items, 1 do
									local item = inventory.items[i]
									--local weightitem = item.weight
									--local weight = weightitem * item.weight
									if item.count > 0 then
										table.insert(invItems, {label = '~s~[~g~' .. item.count ..'~s~] | '.. item.label..''  , type = 'item_standard', value = item.name})
									end
								end                                  
							end)
						end
						end, RMenu:Get('propertyy', 'odeposer'))


						RageUI.ButtonWithStyle("Prendre des Objet(s)", nil, { RightLabel = "→→" }, true, function(h,a,s)
							if s then
								Items = {}
								ESX.TriggerServerCallback('property:getStockItems', function(inventory)
									for i=1, #inventory.items, 1 do
				
										local item = inventory.items[i]
				
										if item.count > 0 then
											table.insert(Items, {label = '~s~[~g~' .. item.count ..'~s~] | '.. item.label..''  , type = 'item_standard', value = item.name})
										end
									end
									for i=1, #inventory.weapons, 1 do
										local weapon = inventory.weapons[i]				
										table.insert(Items, { label = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. ']', type  = 'item_weapon', value = weapon.name, index = i })
									end
								end)
							end
						end, RMenu:Get('propertyy', 'oprendre'))
					end)

					RageUI.IsVisible(RMenu:Get('propertyy', 'invite'), true, true, true, function()
						if property.isSingle then
							entering = property.entering
						else
							entering = GetGateway(property).entering
						end

						local playersInArea = ESX.Game.GetPlayersInArea(entering, 10.0)
						local elements      = {}
			
						for i=1, #playersInArea, 1 do
							if playersInArea[i] ~= PlayerId() then
								table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
							end
						end
						for k,v in pairs(GetActivePlayers()) do 
						RageUI.ButtonWithStyle("Inviter : "..GetPlayerName(v).."", nil, { RightLabel = "→→" },true, function(_,_,Selected)
							if (Selected) then
							TriggerEvent('instance:invite', 'property',GetPlayerServerId(v), {property = property.name, owner = owner})
							Extasy.ShowNotification('tu a inviter'.. GetPlayerName(v))
							end
						end)
					end
				end)

					RageUI.IsVisible(RMenu:Get('propertyy', 'odeposer'), true, true, true, function(property, owner)
						RageUI.Separator("↓ ~g~Inventaire ~s~↓")					
							for k,v in pairs(invItems) do
								RageUI.ButtonWithStyle(v.label  , nil, {RightLabel = count}, true, function(Hovered, Active, Selected)
									if Selected then
				
										local itemName = v.value
										local result = tonumber(KeyboardInputProperty("Quantité:", "", "", 6))
										if not result then
											Extasy.ShowNotification('Quantité invalide')							
										else
											TriggerServerEvent('property:putStockItems', token, v.type , itemName, result)
											RageUI.GoBack()
										end
									end
								end)
							end
						end)

						RageUI.IsVisible(RMenu:Get('propertyy', 'oprendre'), true, true, true, function(property, owner)
							RageUI.Separator("↓ ~g~Contenu du coffre~s~ ↓")
							for k,v in pairs(Items) do
								RageUI.ButtonWithStyle(v.label  , nil, {RightLabel = count}, true, function(Hovered, Active, Selected)
									if Selected then
										local itemName = v.value
										local result = tonumber(KeyboardInputProperty("Quantité:", "", "", 6))
										if not result then
											Extasy.ShowNotification('Quantité invalide')							
										else
											TriggerServerEvent('property:getStockItem', token, v.type , itemName, result)
											RageUI.GoBack()
										end
									end
								end)
							end
						end)

						RageUI.IsVisible(RMenu:Get('Osiris_property_menu', 'listetenu'), true, true, true, function() 

							ESX.TriggerServerCallback('Osiris:GetTenuesProperty', function(skin)
								TenueTableProperty = skin
							end)
							if #TenueTableProperty == 0 then
								RageUI.Button("Aucune tenues enregistée.", nil, { RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)
									if (Selected) then
									end
								end)
							end
							for i = 1, #TenueTableProperty,1 do
								RageUI.List(TenueTableProperty[i].label, ListChoixProperty.listListChoixProperty, ListChoixProperty.indexListChoixProperty, nil, { RightBadge = RageUI.BadgeStyle.Clothes }, true, function(Hovered, Active, Selected, Index)
									if (Selected) then
										clothes = TenueTableProperty[i]
				
										for k,Index in pairs(clothes) do
											if k == "tenue" then
											clothes = Index
											break
											end
										end
				
										if Index == 1 then
											TriggerEvent('skinchanger:getSkin', function(skin)
				
												TriggerEvent('skinchanger:loadClothes', skin, json.decode(clothes))
							  
												TriggerEvent('skinchanger:getSkin', function(skin)
												  TriggerServerEvent('esx_skin:save', skin)
												  RageUI.GoBack()
												  ESX.TriggerServerCallback('Osiris:GetTenues', function(skin)
													TenueTableProperty = skin
												  end)
												end)
											end)
										end
									end
									ListChoixProperty.indexListChoixProperty = Index
								end)
							end
						end, function()
						end, 1)
				Wait(0)
			end
		end)
	end
end

AddEventHandler('instance:loaded', function()
	TriggerEvent('instance:registerType', 'property', function(instance)
		EnterProperty(instance.data.property, instance.data.owner)
	end, function(instance)
		ExitProperty(instance.data.property)
	end)
end)

AddEventHandler('playerSpawned', function()
	if firstSpawn then
		Citizen.CreateThread(function()
			while not ESX.IsPlayerLoaded() do
				Citizen.Wait(0)
			end

			ESX.TriggerServerCallback('esx_property:getLastProperty', function(propertyName)
				if propertyName then
					if propertyName ~= '' then
						local property = GetProperty(propertyName)

						for i=1, #property.ipls, 1 do
							RequestIpl(property.ipls[i])

							while not IsIplActive(property.ipls[i]) do
								Citizen.Wait(0)
							end
						end

						TriggerEvent('instance:create', 'property', {property = propertyName, owner = ESX.GetPlayerData().identifier})
					end
				end
			end)
		end)

		firstSpawn = false
	end
end)

AddEventHandler('esx_property:getProperties', function(cb)
	cb(GetProperties())
end)

AddEventHandler('esx_property:getProperty', function(name, cb)
	cb(GetProperty(name))
end)

AddEventHandler('esx_property:getGateway', function(property, cb)
	cb(GetGateway(property))
end)

RegisterNetEvent('esx_property:setPropertyOwned')
AddEventHandler('esx_property:setPropertyOwned', function(name, owned, rented)
	SetPropertyOwned(name, owned, rented)
end)

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'property' then
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
	if instance.type == 'property' then
		local property = GetProperty(instance.data.property)
		local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
		local isOwned  = false

		if PropertyIsOwned(property) == true then
			isOwned = true
		end

		if isOwned or not isHost then
			hasChest = true
		else
			hasChest = false
		end
	end
end)

RegisterNetEvent('instance:onPlayerLeft')
AddEventHandler('instance:onPlayerLeft', function(instance, player)
	if player == instance.host then
		TriggerEvent('instance:leave')
	end
end)

AddEventHandler('esx_property:hasEnteredMarker', function(name, part)
	local property = GetProperty(name)

	if part == 'entering' then
		if property.isSingle then
			CurrentAction     = 'property_menu'
			CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour entrer dans la propriéter'
			CurrentActionData = {property = property}
		else
			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour entrer dans la propriéter 2'
			CurrentActionData = {property = property}
		end
	elseif part == 'exit' then
		CurrentAction     = 'room_exit'
		CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour sortir de la propriéter'
		CurrentActionData = {propertyName = name}
	elseif part == 'roomMenu' then
		CurrentAction     = 'room_menu'
		CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour le coffre'
		CurrentActionData = {property = property, owner = CurrentPropertyOwner}
	elseif part == 'garage' then
	    CurrentAction     = 'garage'
	    CurrentActionMsg  = 'Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage'
	    CurrentActionData = {property = property,  owner = CurrentPropertyOwner}
	end
end)

AddEventHandler('esx_property:hasExitedMarker', function(name, part)
	RageUI.CloseAll()
	CurrentAction = nil
end)

-- Enter / Exit marker events & Draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep = false, true
		local currentProperty, currentPart

		for i=1, #cfg_prorerty.Properties, 1 do
			local property = cfg_prorerty.Properties[i]

			-- Entering
			if property.entering and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.entering.x, property.entering.y, property.entering.z, true)

				if distance < cfg_prorerty.DrawDistance then
					DrawMarker(22, property.entering.x, property.entering.y, property.entering.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 1, nil, nil, 0) 
					letSleep = false
				end

				if distance < cfg_prorerty.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'entering'
				end
			end

			-- Exit
			if property.exit and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.exit.x, property.exit.y, property.exit.z, true)

				if distance < cfg_prorerty.DrawDistance then
					DrawMarker(22, property.exit.x, property.exit.y, property.exit.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 1, nil, nil, 0) 
					letSleep = false
				end

				if distance < cfg_prorerty.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'exit'
				end
			end

			-- Room menu
			if property.roomMenu and hasChest and not property.disabled then
				local distance = GetDistanceBetweenCoords(coords, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, true)

				if distance < cfg_prorerty.DrawDistance then
					DrawMarker(22, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z+1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 0, 0, 255, 0, 1, 2, 1, nil, nil, 0) 
					letSleep = false
				end

				if distance < cfg_prorerty.MarkerSize.x then
					isInMarker      = true
					currentProperty = property.name
					currentPart     = 'roomMenu'
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker or (isInMarker and (LastProperty ~= currentProperty or LastPart ~= currentPart) ) then
			hasAlreadyEnteredMarker = true
			LastProperty            = currentProperty
			LastPart                = currentPart

			TriggerEvent('esx_property:hasEnteredMarker', currentProperty, currentPart)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_property:hasExitedMarker', LastProperty, LastPart)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'property_menu' then
					OpenPropertyMenu(CurrentActionData.property)
				elseif CurrentAction == 'gateway_menu' then
					if cfg_prorerty.EnablePlayerManagement then
						OpenGatewayOwnedPropertiesMenu(CurrentActionData.property)
					else
						OpenGatewayMenu(CurrentActionData.property)
					end
				elseif CurrentAction == 'room_menu' then
					OpenRoomMenu(CurrentActionData.property, CurrentActionData.owner)
				elseif CurrentAction == 'room_exit' then
					TriggerEvent('instance:leave')
				elseif CurrentAction == 'garage' then
		            OpenGarageProperty(CurrentActionData.property, CurrentActionData.owner)
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function KeyboardInputProperty(entryTitle, textEntry, inputText, maxLenght)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLenght)
	blockinput = true

    while (UpdateOnscreenKeyboard() ~= 1) and (UpdateOnscreenKeyboard() ~= 2) do
        DisableAllControlActions(0)
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		return GetOnscreenKeyboardResult()
	else
		return nil
	end
end













































ESX = nil
local preview_possible = false

local propr = {
	index = 1,
	list = {"Petite", "Centre Ville", "Moderne", "Haute", "Luxe", "Motel", "Entrepot grand", "Entrepot moyen", "Entrepot petit" , "Sous marin" , "Bureau d'avocat" , "Bunker luxieux" , "Maison 3 étages" , "Retour"},
}

function RoundNumber(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
	end

	RMenu.Add('menu', 'main', RageUI.CreateMenu("Agence Immobilière", "~b~Agence Immobilière"))
	RMenu.Add('menu', 'editlogements', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Éditeur de logements", "~b~Éditeur de logements"))
	RMenu.Add('menu', 'gestionlogements', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Éditeur de logements", "~b~Éditeur de logements"))
	RMenu.Add('menu', 'modelprop', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Modèle Intérieur", "~b~Visite Intérieur"))
	RMenu.Add('menu', 'listelogements', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Éditeur de logements", "~b~Éditeur de logements"))
	RMenu.Add('menu', 'listelogementsnehco', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Éditeur de logements", "~b~Éditeur de logements"))
	RMenu.Add('menu', 'gestionlogementsnehco', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Éditeur de logements", "~b~Éditeur de logements"))
	RMenu.Add('menu', 'visiterprop', RageUI.CreateSubMenu(RMenu:Get('menu', 'main'), "Visiter Intérieur", "~b~Visite Intérieur"))
	RMenu:Get('menu', 'main').Closed = function()
		A.Menu = false
    end
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
end)

A = {
    Menu = false,
}

local name = ''
local exit = ''
local label = ''
local inside = ''
local outside = ''
local ipl = ''
local isRoom = ''
local roommenu = ''
local price = ''
local entering = ''
local entrer = ''
local isSingle = ''
local garage = ''
local price = 0 

local debug = false -- debug mode


local zones = { 
	['AIRP'] = "Los Santos International Airport",
	['ALAMO'] = "Alamo Sea", 
	['ALTA'] = "Alta", 
	['ARMYB'] = "Fort Zancudo", 
	['BANHAMC'] = "Banham Canyon Dr", 
	['BANNING'] = "Banning", 
	['BEACH'] = "Vespucci Beach", 
	['BHAMCA'] = "Banham Canyon", 
	['BRADP'] = "Braddock Pass", 
	['BRADT'] = "Braddock Tunnel", 
	['BURTON'] = "Burton", 
	['CALAFB'] = "Calafia Bridge", 
	['CANNY'] = "Raton Canyon", 
	['CCREAK'] = "Cassidy Creek", 
	['CHAMH'] = "Chamberlain Hills", 
	['CHIL'] = "Vinewood Hills", 
	['CHU'] = "Chumash", 
	['CMSW'] = "Chiliad Mountain State Wilderness", 
	['CYPRE'] = "Cypress Flats", 
	['DAVIS'] = "Davis", 
	['DELBE'] = "Del Perro Beach", 
	['DELPE'] = "Del Perro", 
	['DELSOL'] = "La Puerta", 
	['DESRT'] = "Grand Senora Desert", 
	['DOWNT'] = "Downtown", 
	['DTVINE'] = "Downtown Vinewood", 
	['EAST_V'] = "East Vinewood", 
	['EBURO'] = "El Burro Heights", 
	['ELGORL'] = "El Gordo Lighthouse", 
	['ELYSIAN'] = "Elysian Island", 
	['GALFISH'] = "Galilee", 
	['GOLF'] = "GWC and Golfing Society", 
	['GRAPES'] = "Grapeseed", 
	['GREATC'] = "Great Chaparral", 
	['HARMO'] = "Harmony", 
	['HAWICK'] = "Hawick", 
	['HORS'] = "Vinewood Racetrack", 
	['HUMLAB'] = "Humane Labs and Research", 
	['JAIL'] = "Bolingbroke Penitentiary", 
	['KOREAT'] = "Little Seoul", 
	['LACT'] = "Land Act Reservoir", 
	['LAGO'] = "Lago Zancudo", 
	['LDAM'] = "Land Act Dam", 
	['LEGSQU'] = "Legion Square", 
	['LMESA'] = "La Mesa", 
	['LOSPUER'] = "La Puerta", 
	['MIRR'] = "Mirror Park", 
	['MORN'] = "Morningwood", 
	['MOVIE'] = "Richards Majestic", 
	['MTCHIL'] = "Mount Chiliad", 
	['MTGORDO'] = "Mount Gordo", 
	['MTJOSE'] = "Mount Josiah", 
	['MURRI'] = "Murrieta Heights", 
	['NCHU'] = "North Chumash", 
	['NOOSE'] = "N.O.O.S.E", 
	['OCEANA'] = "Pacific Ocean", 
	['PALCOV'] = "Paleto Cove", 
	['PALETO'] = "Paleto Bay", 
	['PALFOR'] = "Paleto Forest", 
	['PALHIGH'] = "Palomino Highlands", 
	['PALMPOW'] = "Palmer-Taylor Power Station", 
	['PBLUFF'] = "Pacific Bluffs", 
	['PBOX'] = "Pillbox Hill", 
	['PROCOB'] = "Procopio Beach", 
	['RANCHO'] = "Rancho", 
	['RGLEN'] = "Richman Glen", 
	['RICHM'] = "Richman", 
	['ROCKF'] = "Rockford Hills", 
	['RTRAK'] = "Redwood Lights Track", 
	['SANAND'] = "San Andreas", 
	['SANCHIA'] = "San Chianski Mountain Range", 
	['SANDY'] = "Sandy Shores", 
	['SKID'] = "Mission Row", 
	['SLAB'] = "Stab City", 
	['STAD'] = "Maze Bank Arena", 
	['STRAW'] = "Strawberry", 
	['TATAMO'] = "Tataviam Mountains", 
	['TERMINA'] = "Terminal", 
	['TEXTI'] = "Textile City", 
	['TONGVAH'] = "Tongva Hills", 
	['TONGVAV'] = "Tongva Valley", 
	['VCANA'] = "Vespucci Canals", 
	['VESP'] = "Vespucci", 
	['VINE'] = "Vinewood",
	['WINDF'] = "Ron Alternates Wind Farm", 
	['WVINE'] = "West Vinewood",
	['ZANCUDO'] = "Zancudo River",
	['ZP_ORT'] = "Port of South Los Santos", 
	['ZQ_UAR'] = "Davis Quartz" 
	}

	
local Menuannonce = {
    list = 1,
    annonce = { "Ouverture", "Fermeture"},
    listannonce = 1,
}


local function noSpace(str)
	local normalisedString = string.gsub(str, "%s+", "")
	return normalisedString
 end
 
 function OpenKeyboard(type, labelText)
	 AddTextEntry('FMMC_KEY_TIP1', labelText)
	 DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", "", "", "", "", 25)
	 blockinput = true
 
	 while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		 Citizen.Wait(0)
	 end
		 
	 if UpdateOnscreenKeyboard() ~= 2 then
		 local result = GetOnscreenKeyboardResult() 
		 Citizen.Wait(500) 
		 blockinput = false 
		 if type == "name" then 
			 Extasy.ShowNotification("Nom assigné : ~b~"..noSpace(result))
			 return noSpace(result) 
		 elseif type == "label" then 
			 Extasy.ShowNotification("Label assigné : ~b~"..result)
			 return result
		 else 
			 if tonumber(result) == nil then 
				Extasy.ShowNotification("Vous devez entré un ~r~prix")
				return
			 end	
			 Extasy.ShowNotification("Prix assigné : ~b~"..tonumber(result).."~w~ $")
			 return tonumber(result)
		 end
	 else
		 Citizen.Wait(500)
		 blockinput = false 
		 return nil
	 end
 end

properties = {}

local function getprop()
		ESX.TriggerServerCallback('nehco:getproperties', function(properties)
		proplister = properties
	end)
end

propertiesnehco = {}

local function getproplist()
		ESX.TriggerServerCallback('nehco:propertiesnehco', function(propertiesnehco)
		plistnehco = propertiesnehco
	end)
end


function openPropertiesMenu()
    if A.Menu then
        A.Menu = false
    else
        A.Menu = true
        RageUI.Visible(RMenu:Get('menu', 'main'), true)

        Citizen.CreateThread(function()
			while A.Menu do
				RageUI.IsVisible(RMenu:Get('menu', 'main'), true, true, true, function()

					RageUI.List('Annonce : ', Menuannonce.annonce, Menuannonce.listannonce, nil, {}, true, function(Hovered, Active, Selected, Index)
						if Selected then
							if Index == 1 then
								TriggerServerEvent('AgenceImmo:Ouverte')
							elseif Index == 2 then
								TriggerServerEvent('AgenceImmo:Fermer')
								if (GetOnscreenKeyboardResult()) then
									local result = GetOnscreenKeyboardResult()
									TriggerServerEvent('AgenceImmo:Annonce', result)
								end                              
							end
		
						end
						Menuannonce.listannonce = Index;
					end)

					RageUI.ButtonWithStyle("Éditeur de logements", nil, { RightLabel = "→→" },true, function()
					end, RMenu:Get('menu', 'editlogements'))

					RageUI.ButtonWithStyle("Gestion des logements", nil, { RightLabel = "→→" },true, function(h,a,s)
						if s then
							getprop()
							proplister = properties
						end
					end, RMenu:Get('menu', 'gestionlogements'))

					RageUI.ButtonWithStyle("Liste des logements Vendus", nil, { RightLabel = "→→" },true, function(h,a,s)
						getproplist()
						plistnehco = propertiesnehco
					end, RMenu:Get('menu', 'gestionlogementsnehco'))

				end)

				RageUI.IsVisible(RMenu:Get('menu', 'gestionlogements'), true, true, true, function()
				for listprop = 1, #proplister, 1 do
                    RageUI.ButtonWithStyle( "Nom du logement : [~y~"..proplister[listprop].type.. "~s~]", nil, {RightLabel = "→→~b~Intéragir"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            typeprop = proplister[listprop].id
                            nomprop = proplister[listprop].type
                            prix = proplister[listprop].price
                            supprimer = proplister[listprop].nid
                            nomjoueur = proplister[listprop].playernehco
                        end
                    end, RMenu:Get('menu', 'listelogements'))
                end
            end)

            RageUI.IsVisible(RMenu:Get('menu', 'listelogements'), true, true, true, function()
                    RageUI.Separator('↓ ~y~Informations ~s~↓')
                    RageUI.ButtonWithStyle("Type de logement~s~ : ~y~"..typeprop, nil, {}, true, function(Hovered, Active, Selected)
                    end) 
                    RageUI.ButtonWithStyle("Nom de logement~s~ : ~g~"..nomprop, nil, {}, true, function(Hovered, Active, Selected)
                    end) 
                    RageUI.ButtonWithStyle("Prix du logement : ~b~"..prix.. " ~s~$", nil, {}, true, function(Hovered, Active, Selected)
                    end) 
                    RageUI.ButtonWithStyle("Logement Créer par : ~b~"..nomjoueur, nil, {}, true, function(Hovered, Active, Selected)
                    end) 

                    RageUI.Separator('↓ ~b~Intéractions ~s~↓')

                    RageUI.ButtonWithStyle("~r~Supprimer ~s~le logement", nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                        TriggerServerEvent('nehco:supprimerprop', supprimer)
                        Extasy.ShowNotification("Le Bien : ~y~".. nomprop.. " ~s~a bien été supprimé.")
                        RageUI.GoBack()
                        end
                    end) 
				end)
				
				RageUI.IsVisible(RMenu:Get('menu', 'gestionlogementsnehco'), true, true, true, function()
					for listprop = 1, #plistnehco, 1 do
						RageUI.ButtonWithStyle( "Nom du logement : [~y~"..plistnehco[listprop].id.. "~s~]", nil, {RightLabel = "→→~b~Intéragir"}, true, function(Hovered, Active, Selected)
							if (Selected) then
								nomp = plistnehco[listprop].id
								prix = plistnehco[listprop].price
								supprimer = plistnehco[listprop].nid
								nomj = plistnehco[listprop].player
							end
						end, RMenu:Get('menu', 'listelogementsnehco'))
					end
				end)

				RageUI.IsVisible(RMenu:Get('menu', 'listelogementsnehco'), true, true, true, function()

					RageUI.Separator('↓ ~y~Informations du logement Vendus ~s~↓')
					
                    RageUI.ButtonWithStyle("Nom de logement~s~ : ~g~"..nomp, nil, {}, true, function(Hovered, Active, Selected)
                    end) 
                    RageUI.ButtonWithStyle("Acheter : ~b~"..prix.. " ~s~$", nil, {}, true, function(Hovered, Active, Selected)
                    end) 
                --    RageUI.ButtonWithStyle("Acheter par : ~b~" ..nomj, nil, {}, true, function(Hovered, Active, Selected)
                  --  end) 

                    RageUI.Separator('↓ ~b~Intéraction ~s~↓')

                    RageUI.ButtonWithStyle("~r~Déstituer ~s~le logement ~o~"..nomp, "~r~ACTION IRREVERSIBLE !", {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                        TriggerServerEvent('nehco:supprimerprop2', supprimer)
                        Extasy.ShowNotification("~g~Le logement à bien été déstituer")
                        RageUI.GoBack()
                        end
                    end) 
				end)
				
				RageUI.IsVisible(RMenu:Get('menu', 'editlogements'), true, true, true, function()

					local playernehco = GetPlayerName(PlayerId())

					RageUI.ButtonWithStyle("Définir le nom de la propriété", nil, { RightLabel = name },true, function(_,_,Selected)
						if (Selected) then
							name  =  OpenKeyboard('name', 'Entrer un nom sans éspace !')
						end
					end)
					RageUI.ButtonWithStyle("Définir le label de la propriété", nil, { RightLabel = label },true, function(_,_,Selected)
						if (Selected) then
							label = OpenKeyboard('label', 'Entrer un label !')
						end
					end)
					RageUI.Separator()
					
					RageUI.ButtonWithStyle("Définir point d'entrée (exterieur)", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							local pos = GetEntityCoords(PlayerPedId())
							local var1, var2 = GetStreetNameAtCoord(pos.x, pos.y, pos.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
	        				--local current_zone = zones[GetNameOfZone(pos.x, pos.y, pos.z)]
							local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}
							
							entering = json.encode(PlayerCoord)

							PedPosition = pos
							DrawMarker(22, pos.x, pos.y, pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.5, 2.0, 255, 0, 0, 100, false, true, 2, false, false, false, false)  
							--Extasy.ShowNotification('position de la porte d\'~g~entrée~s~ : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z.. '~w~, Adresse : ~b~'..current_zone.. '')
                            Extasy.ShowNotification('position de la porte d\'~g~entrée~s~ : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z.. '~w~')
						end
					end)

					RageUI.ButtonWithStyle("Définir point de sortie (extérieur)", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							local pos = GetEntityCoords(PlayerPedId())
							local PlayerCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)}
							local Out = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z+2, 4)}
							outside  = json.encode(Out)
							Extasy.ShowNotification('position de la ~r~sortie~s~ : ~b~'..PlayerCoord.x..' , '..PlayerCoord.y..' , '..PlayerCoord.z..'')
						end
					end)

					

					RageUI.List('~b~Voici la liste des propriétés', propr.list, propr.index, nil, {}, true, function(Hovered, Active, Selected, Index)
						if (Active) then 
							propr.index = Index
						end
						if (Selected) then
								if Index == 1 then
									SetEntityCoords(PlayerPedId(), 265.6031, -1002.9244, -99.0086)
									ipl = '[]'
									inside = '{"x":265.307,"y":-1002.802,"z":-101.008}'
									exit = '{"x":266.0773,"y":-1007.3900,"z":-101.008}'
									isSingle = 1
									isRoom = 1
									isGateway = 0    
								elseif Index == 2 then
									SetEntityCoords(PlayerPedId(), -616.8566, 59.3575, 98.2000)
									ipl = '[]'
									inside = '{"x":265.307,"y":-1002.802,"z":-101.008}'
									exit = '{"x":266.0773,"y":-1007.3900,"z":-101.008}'
									isSingle = 1
									isRoom = 1
									isGateway = 0     
								elseif Index == 3 then
									SetEntityCoords(PlayerPedId(), -788.3881, 320.2430, 187.3132)
									ipl = '["apa_v_mp_h_01_a"]'
									inside = '{"x":-785.13,"y":315.79,"z":187.91}'
									exit = '{"x":-786.87,"y":315.7497,"z":186.91}'
									isSingle = 1
									isRoom = 1
									isGateway = 0        
								elseif Index == 4 then
									SetEntityCoords(PlayerPedId(), -1459.1700, -520.5855, 56.9247)  
									ipl = '[]'
									inside = '{"x":-1459.17,"y":-520.58,"z":54.929}'
									exit = '{"x":-1451.6394,"y":-523.5562,"z":55.9290}'
									isSingle = 1
									isRoom = 1
									isGateway = 0      
								elseif Index == 5 then
									SetEntityCoords(PlayerPedId(), -674.4503, 595.6156, 145.3796)
									ipl = '[]'
									inside = '{"x":-680.6088,"y":590.5321,"z":145.39}'
									exit = '{"x":-681.6273,"y":591.9663,"z":144.3930}'				
									isSingle = 1
									isRoom = 1
									isGateway = 0        
								elseif Index == 6 then
									SetEntityCoords(PlayerPedId(), 151.0994, -1007.8073, -98.9999)
									ipl = '["hei_hw1_blimp_interior_v_motel_mp_milo_"]'
									inside = '{"x":151.45,"y":-1007.57,"z":-98.9999}'
									exit = '{"x":151.3258,"y":-1007.7642,"z":-100.0000}'
									isSingle = 1
									isRoom = 1
									isGateway = 0        
								elseif Index == 7 then
									SetEntityCoords(PlayerPedId(), 1026.8707, -3099.8710, -38.9998)
									ipl = '[]'
									inside = '{"x":1026.5056,"y":-3099.8320,"z":-38.9998}'
									exit   = '{"x":998.1795"y":-3091.9169,"z":-39.9999}'
									isSingle = 1
									isRoom = 1
									isGateway = 0        
								elseif Index == 8 then
									SetEntityCoords(PlayerPedId(), 1072.8447, -3100.0390, -38.9999)
									ipl = '[]'
									inside = '{"x":1048.5067,"y":-3097.0817,"z":-38.9999}'
									exit   = '{"x":1072.5505,"y":-3102.5522,"z":-39.9999}'
									isSingle = 1
									isRoom = 1
									isGateway = 0        
								elseif Index == 9 then
									SetEntityCoords(PlayerPedId(), 1104.7231, -3100.0690, -38.9999)
									ipl = '[]'
									inside = '{"x":1088.1834,"y":-3099.3547,"z":-38.9999}'
									exit   = '{"x":1104.6102,"y":-3099.4333,"z":-39.9999}'
									isSingle = 1
									isRoom = 1
									isGateway = 0
								elseif Index == 10 then
									SetEntityCoords(PlayerPedId(), 514.33, 4886.18, -62.59)
									ipl = '[]'
									inside = '{"x":514.3687,"y":4885.9448,"z":-62.590}'
									exit = '{"x":514.292,"y":4887.785,"z":-62.590}'				
									isSingle = 1
									isRoom = 1
									isGateway = 0
								elseif Index == 11 then
									SetEntityCoords(PlayerPedId(), -1902.603, -573.016, 19.09)
									ipl = '[]'
									inside = '{"x":-1902.603,"y":-573.016,"z":19.09}'
									exit = '{"x":-1902.236,"y":-572.634,"z":19.09}'				
									isSingle = 1
									isRoom = 1
									isGateway = 0
								elseif Index == 12 then
									SetEntityCoords(PlayerPedId(), -1520.95, -3002.184, -82.207)
									ipl = '[]'
									inside = '{"x":-1520.95,"y":-3002.184,"z":-82.207}'
									exit = '{"x":-1520.808,"y":-2978.501,"z":-80.453}'				
									isSingle = 1
									isRoom = 1
									isGateway = 0
								elseif Index == 13 then
									SetEntityCoords(PlayerPedId(), -174.284, 497.640, 137.663)
									ipl = '[]'
									inside = '{"x":-173.977,"y":496.7333,"z":137.666}'
									exit = '{"x":-174.284,"y":497.640,"z":137.663}'				
									isSingle = 1
									isRoom = 1
									isGateway = 0
								elseif Index == 14 then
									SetEntityCoords(PlayerPedId(), -718.76, 262.12, 83.1)
									print('Agence Immo')
								end
						end
					end)

					RageUI.ButtonWithStyle("Définir point coffre (intérieur)", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							local pos = GetEntityCoords(PlayerPedId())
							local CoffreCoord = {x = ESX.Math.Round(pos.x, 4), y = ESX.Math.Round(pos.y, 4), z = ESX.Math.Round(pos.z-1, 4)} 
							roommenu = json.encode(CoffreCoord)
							Extasy.ShowNotification('position du coffre :~b~'..CoffreCoord.x..' , '..CoffreCoord.y..' , '..CoffreCoord.z.. '')
							inventoryVector = GetEntityCoords(PlayerPedId())
							--previewMarkers["dressingVector"] = {vector = dressingVector, color = {r = 0, g = 0, b = 255}}
						end
					end)
					RageUI.Separator("")
					
					RageUI.ButtonWithStyle("Définir le prix :", nil, {RightLabel = "~b~" ..price}, true, function(Hovered, Active, Selected)
						if (Selected) then 
							price = OpenKeyboard('price', 'Entrer un prix')
							end
				    	end)

					RageUI.ButtonWithStyle("~r~Annuler", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							if PedPosition ~= nil then
								SetEntityCoords(PlayerPedId(), PedPosition.x, PedPosition.y, PedPosition.z)
							end  
			 
							Citizen.Wait(50)
							RageUI.CloseAll()
							Extasy.ShowNotification('~b~Éditeur de logements\n~s~Création annulée.')
						end
					end)

					RageUI.ButtonWithStyle("~g~Valider", nil, { RightLabel = "" },true, function(_,_,Selected)
						if (Selected) then
							if tonumber(price) == nil or tonumber(price) == 0 then
								Extasy.ShowNotification('~r~Vous n\'avez aucun prix assigné !')
							else 
								if name == '' then 
									Extasy.ShowNotification('~r~Vous n\'avez aucun nom assigné !')
								else 	
									print(playernehco)
								   TriggerServerEvent('realStateAgency:Save', name, label, entering, exit, inside, outside, ipl, isSingle, isRoom, isGateway, roommenu, playernehco, price)
							   
								   Citizen.Wait(15)
								   SetEntityCoords(PlayerPedId(), PedPosition.x, PedPosition.y, PedPosition.z)
								end
							end   
						end
					end)
					
				end)
				Wait(0)
			end
		end)
	end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'AgentImmo' then
            if IsControlJustPressed(1,167) then 
            openPropertiesMenu()
            end
        end
    end
end)