local ESX = nil
local PlayerData = {}
local serverInteraction = false
local IsHandcuffed, DragStatus = false, {}
DragStatus.IsDragged = false

playerClothes               = {}
ORG                         = {}
ORG.colorIndex              = {}
ORG.garageWindowsTint       = false
ORG.defaultskin             = {}
ORG.defaultskincool         = false

myOrgData                   = {}
playerOrgWears              = {}
myOrgData.inventoryChecked  = false
myOrgData.inChest           = false
myOrgData.inGarage          = false
myOrgData.inWear            = false
myOrgData.inBoss            = false
myOrgData.inWait            = false
myOrgData.currentTi         = false
myOrgData.currentPerfs      = false
myOrgData.currentXenon      = false
myOrgData.currentInvIndex   = 1
weapon_org                  = {}

Citizen.CreateThread(function()
    TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

	while ESX == nil do Wait(1) end
    while ESX.GetPlayerData().job2 == nil do Wait(1) end

    ESX.PlayerData = ESX.GetPlayerData()

    weapon_org.WeaponData = ESX.GetWeaponList()

	for i = 1, #weapon_org.WeaponData, 1 do
		if weapon_org.WeaponData[i].name == 'WEAPON_UNARMED' then
			weapon_org.WeaponData[i] = nil
		else
			weapon_org.WeaponData[i].hash = GetHashKey(weapon_org.WeaponData[i].name)
		end
    end

    while ESX.GetPlayerData().job == nil do
        Wait(0)
    end

    while ESX.GetPlayerData() == nil do
        Wait(0)
    end

    while weapon_org.WeaponData == nil do
        Wait(0)
    end
end)

RefreshWeaponForOrg = function()
    weapon_org.WeaponData = ESX.GetWeaponList()

	for i = 1, #weapon_org.WeaponData, 1 do
		if weapon_org.WeaponData[i].name == 'WEAPON_UNARMED' then
			weapon_org.WeaponData[i] = nil
		else
			weapon_org.WeaponData[i].hash = GetHashKey(weapon_org.WeaponData[i].name)
		end
    end

    while ESX.GetPlayerData().job == nil do
        Wait(0)
    end

    while ESX.GetPlayerData() == nil do
        Wait(0)
    end

    while weapon_org.WeaponData == nil do
        Wait(0)
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
    PlayerData = xPlayer
    TriggerServerEvent("Org:getGangData", token, ESX.PlayerData.job2.name)
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	for i=1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
    TriggerServerEvent("Org:getGangData", token, ESX.PlayerData.job2.name)
end)

getPlayerInvGang = function(player)
    Items = {}
    Armes = {}
    ArgentSale = {}
    
    ESX.TriggerServerCallback('Org:getOtherPlayerData', function(data)
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'black_money',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })
    
                break
            end
        end

        for i=1, #data.weapons, 1 do
            table.insert(Armes, {
                label    = ESX.GetWeaponLabel(data.weapons[i].name),
                value    = data.weapons[i].name,
                right    = data.weapons[i].ammo,
                itemType = 'item_weapon',
                amount   = data.weapons[i].ammo
            })
        end
    
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end
    end, GetPlayerServerId(player))
end

function MenuGangs(gang)
    local MenuGang = RageUI.CreateMenu("Menu "..gang.Label, "Interactions")
    local MenuGangSub = RageUI.CreateSubMenu(MenuGang, "Menu "..gang.Label, "Interactions")
        RageUI.Visible(MenuGang, not RageUI.Visible(MenuGang))
            while MenuGang do
                Citizen.Wait(0)
                    RageUI.IsVisible(MenuGang, true, true, true, function()

            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            local target, distance = ESX.Game.GetClosestPlayer()
            playerheading = GetEntityHeading(GetPlayerPed(-1))
            playerlocation = GetEntityForwardVector(PlayerPedId())
            playerCoords = GetEntityCoords(GetPlayerPed(-1))
            local target_id = GetPlayerServerId(target)
            RageUI.ButtonWithStyle('Fouiller', nil, {RightLabel = "→"}, closestPlayer ~= -1 and closestDistance <= 3.0, function(_, a, s)
                if a then
                    MarquerJoueur()
                    if s then
                    getPlayerInvGang(closestPlayer)
                end
            end
            end, MenuGangSub)
            
        RageUI.ButtonWithStyle("Carte d'identité", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(GetPlayerPed(-1))
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(GetPlayerPed(-1))
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                    Extasy.ShowNotification("Recherche en cours...")
                    Citizen.Wait(2000)
                    carteidentite(closestPlayer)
                else
                    Extasy.ShowNotification('Aucun joueurs à proximité')
                end
            end
        end)
            
        RageUI.ButtonWithStyle("Menotter/démenotter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local target, distance = ESX.Game.GetClosestPlayer()
                playerheading = GetEntityHeading(GetPlayerPed(-1))
                playerlocation = GetEntityForwardVector(PlayerPedId())
                playerCoords = GetEntityCoords(GetPlayerPed(-1))
                local target_id = GetPlayerServerId(target)
                if closestPlayer ~= -1 and closestDistance <= 3.0 then   
                TriggerServerEvent('Org:handcuff', token, GetPlayerServerId(closestPlayer))
                else
                    Extasy.ShowNotification('Aucun joueurs à proximité')
                end
            end
        end)
            
            RageUI.ButtonWithStyle("Escorter", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(GetPlayerPed(-1))
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(GetPlayerPed(-1))
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                TriggerServerEvent('Org:drag', token, GetPlayerServerId(closestPlayer))
                else
                    Extasy.ShowNotification('Aucun joueurs à proximité')
                end
            end
        end)
            
            RageUI.ButtonWithStyle("Mettre dans un véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(GetPlayerPed(-1))
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(GetPlayerPed(-1))
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                        TriggerServerEvent('Org:putInVehicle', token, GetPlayerServerId(closestPlayer))
                    else
                        Extasy.ShowNotification('Aucun joueurs à proximité')
                    end
                end
            end)
            
            RageUI.ButtonWithStyle("Sortir du véhicule", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local target, distance = ESX.Game.GetClosestPlayer()
                    playerheading = GetEntityHeading(GetPlayerPed(-1))
                    playerlocation = GetEntityForwardVector(PlayerPedId())
                    playerCoords = GetEntityCoords(GetPlayerPed(-1))
                    local target_id = GetPlayerServerId(target)
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then  
                TriggerServerEvent('Org:OutVehicle', token, GetPlayerServerId(closestPlayer))
                else
                    Extasy.ShowNotification('Aucun joueurs à proximité')
                end
            end
        end)
        

        end, function()
        end)

        RageUI.IsVisible(MenuGangSub, true, true, true, function()
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
            RageUI.Separator("Vous Fouiller : " ..GetPlayerName(closestPlayer))

            RageUI.Separator("↓ ~r~Argent non déclaré ~s~↓")
            for k,v  in pairs(ArgentSale) do
                RageUI.ButtonWithStyle("Argent non déclaré :", nil, {RightLabel = "~g~"..v.label.."$"}, true, function(_, _, s)
                    if s then
                        local combien = Extasy.KeyboardInput("Combien ?", '' , '', 8)
                        if tonumber(combien) > v.amount then
                            RageUI.Popup({message = "~r~Quantité invalide"})
                        else
                            TriggerServerEvent('Org:confiscatePlayerItem', token, GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                        RageUI.GoBack()
                    end
                end)
            end
    
            RageUI.Separator("↓ ~g~Objets ~s~↓")

            for k,v  in pairs(Items) do
                RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~x"..v.right}, true, function(_, _, s)
                    if s then
                        local combien = Extasy.KeyboardInput("Combien ?", '' , '', 8)
                        if tonumber(combien) > v.amount then
                            RageUI.Popup({message = "~r~Quantité invalide"})
                        else
                            TriggerServerEvent('Org:confiscatePlayerItem', token, GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
                        end
                        RageUI.GoBack()
                    end
                end)
            end

            RageUI.Separator("↓ ~g~Armes ~s~↓")

			for k,v  in pairs(Armes) do
				RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "avec ~g~"..v.right.. " ~s~balle(s)"}, true, function(_, _, s)
					if s then
						local combien = Extasy.KeyboardInput("Combien ?", '' , '', 8)
						if tonumber(combien) > v.amount then
							RageUI.Popup({message = "~r~Quantité invalide"})
						else
							TriggerServerEvent('Org:confiscatePlayerItem', token, GetPlayerServerId(closestPlayer), v.itemType, v.value, tonumber(combien))
						end
						RageUI.GoBack()
					end
				end)
			end
    
            end, function() 
            end)

            if not RageUI.Visible(MenuGang) and not RageUI.Visible(MenuGangSub) then
                MenuGang = RMenu:DeleteType("Menu Fouille", true)
        end
    end
end

----- Garage

RMenu.Add('org_menu', 'garage_menu', RageUI.CreateMenu("Garage", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('org_menu', 'garage_menu_choose_new_vehicle', RageUI.CreateSubMenu(RMenu:Get('org_menu', 'garage_menu'), "Véhicules", "Choisissez le véhicule à ajouter"))
RMenu.Add('org_menu', 'garage_menu_buy_something', RageUI.CreateSubMenu(RMenu:Get('org_menu', 'garage_menu'), "Améliorations", "Choisissez l'amélioration de votre choix"))
RMenu.Add('org_menu', 'garage_menu_config_something', RageUI.CreateSubMenu(RMenu:Get('org_menu', 'garage_menu'), "Configurations", "Choisissez la configuration de votre choix"))
Citizen.CreateThread(function()
    for k,v in pairs(cfg_org.vehicles) do
        RMenu.Add('org_menu', v.value, RageUI.CreateSubMenu(RMenu:Get('org_menu', 'garage_menu_choose_new_vehicle'), "Véhicules", "Choisissez le véhicule à ajouter"))
    end
end)
RMenu:Get('org_menu', 'garage_menu').Closed = function()
    myOrgData.inGarage = false
end

myOrgOpenGarage = function()
    if myOrgData.inGarage then
        myOrgData.inGarage = false
        return
    else
        myOrgData.inGarage = true
        Citizen.CreateThread(function()
            while myOrgData.inGarage do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('org_menu', 'garage_menu'), true, true, true, function()

                    RageUI.Separator("Organisation: ~p~"..myOrgData.orgLabel)
                    RageUI.Separator("Place garage:~p~ "..Extasy.TableCount(myOrgData.orgVehicles).." / "..extasy_core_cfg["max_org_garage"].."~s~ véhicule(s)")

                    RageUI.Separator("")

                    RageUI.ButtonWithStyle("Configurations du véhicule", nil, {}, true, function(Hovered, Active, Selected) end, RMenu:Get('org_menu', 'garage_menu_buy_something'))
                    if playergroup ~= 'user' and playergroup ~= 'mod' then
                        if Extasy.TableCount(myOrgData.orgVehicles) < extasy_core_cfg["max_org_garage"] then
                            RageUI.ButtonWithStyle("Ajouter un véhicule", nil, {}, true, function(Hovered, Active, Selected) end, RMenu:Get('org_menu', 'garage_menu_choose_new_vehicle'))
                        end
                    else
                        if Extasy.TableCount(myOrgData.orgVehicles) < extasy_core_cfg["max_org_garage"] then
                            RageUI.ButtonWithStyle("Ajouter un véhicule", "Vous n'avez pas les permissions nécessaires pour faire cela", {RightBadge = RageUI.BadgeStyle.Lock}, false, function(Hovered, Active, Selected) end)
                        end
                    end

                    RageUI.Separator("")

                    for k,v in pairs(myOrgData.orgVehicles) do
                        if playergroup ~= 'user' and playergroup ~= 'mod' then
                            if ORG.colorIndex[k] == nil then ORG.colorIndex[k] = myOrgData.orgVehicles[k].color end
                            RageUI.List(v.name, cfg_org.colorsList, ORG.colorIndex[k], "Appuyez sur ~p~[SUPR]~s~ pour supprimer le véhicule\nAppuyez sur ~p~←→~s~ pour changer la couleur\nAppuyez sur ~p~[F]~s~ pour sauvegarder la couleur", {}, true, function(Hovered, Active, Selected, Index)
                                ORG.colorIndex[k] = Index
                                if Active then
                                    if IsControlJustPressed(1, 214) then
                                        table.remove(myOrgData.orgVehicles, k)
                                        TriggerServerEvent("Org:refreshVehicleFromOrg", token, myOrgData.orgName, myOrgData.orgVehicles)
                                    end

                                    if IsControlJustPressed(1, 145) then
                                        myOrgData.orgVehicles[k].color = ORG.colorIndex[k]
                                        TriggerServerEvent("Org:refreshVehicleFromOrg", token, myOrgData.orgName, myOrgData.orgVehicles)
                                    end
                                end
                                if Selected then
                                    local _color  = v.color
                                    local pos     = vector3(myOrgData.orgGSpawn.x, myOrgData.orgGSpawn.y, myOrgData.orgGSpawn.z)
        
                                    SpawnOrgVehicle(v.hash, pos, heading, _color, myOrgData.currentTi, myOrgData.currentPerfs, myOrgData.currentXenon)
                                end	
                            end)
                        else
                            RageUI.ButtonWithStyle(v.name, nil, {}, true, function(Hovered, Active, Selected) 
                                if Selected then
                                    local _color  = v.color
                                    local pos     = vector3(myOrgData.orgGSpawn.x, myOrgData.orgGSpawn.y, myOrgData.orgGSpawn.z)
        
                                    SpawnOrgVehicle(v.hash, pos, heading, _color, myOrgData.currentTi, myOrgData.currentPerfs, myOrgData.currentXenon)
                                end			
                            end)
                        end
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('org_menu', 'garage_menu_buy_something'), true, true, true, function()

                    if not myOrgData.currentTi then
                        RageUI.ButtonWithStyle("Vitres teintées", "L'amélioration s'appliquera à tous vos véhicules déjà installés", {RightLabel = extasy_core_cfg["windows_tint_buy"].."$"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                ESX.TriggerServerCallback('Org:CanBuy', function(CanBuy)
                                    if CanBuy then
                                        for k,v in pairs(myOrgData.orgVehicles) do
                                            if v.windowsTint == nil then v.windowsTint = false end
                                            v.windowsTint = true
                                        end
    
                                        TriggerServerEvent("Org:refreshVehicleFromOrg", token, myOrgData.orgName, myOrgData.orgVehicles)
                                        RageUI.GoBack()
                                    else
                                        Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent de source inconnue sur vous")
                                    end
                                end, extasy_core_cfg["windows_tint_buy"])
                            end
                        end)
                    else
                        RageUI.ButtonWithStyle("~c~Vitres teintées", "Votre organisation possède déjà cette amélioration", {RightBadge = RageUI.BadgeStyle.Cash}, true, function(Hovered, Active, Selected) end)
                    end

                    if not myOrgData.currentPerfs then
                        RageUI.ButtonWithStyle("Véhicule full custom", "L'amélioration s'appliquera à tous vos véhicules déjà installés\n\n- Puissance moteur MAX\n- Freinage MAX\n- Transmission MAX\n- Turbo MAX", {RightLabel = extasy_core_cfg["fullCustom"].."$"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                ESX.TriggerServerCallback('Org:CanBuy', function(CanBuy)
                                    if CanBuy then
                                        for k,v in pairs(myOrgData.orgVehicles) do
                                            if v.fullCustom == nil then v.fullCustom = false end
                                            v.fullCustom = true
                                        end
    
                                        TriggerServerEvent("Org:refreshVehicleFromOrg", token, myOrgData.orgName, myOrgData.orgVehicles)
                                        RageUI.GoBack()
                                    else
                                        Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent de source inconnue sur vous")
                                    end
                                end, extasy_core_cfg["fullCustom"])
                            end
                        end)
                    else
                        RageUI.ButtonWithStyle("~c~Véhicule full custom", "Votre organisation possède déjà cette amélioration", {RightBadge = RageUI.BadgeStyle.Cash}, true, function(Hovered, Active, Selected) end)
                    end

                    if not myOrgData.currentXenon then
                        RageUI.ButtonWithStyle("Phares xenon", "L'amélioration s'appliquera à tous vos véhicules déjà installés", {RightLabel = extasy_core_cfg["xenonlights_gang"].."$"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                ESX.TriggerServerCallback('Org:CanBuy', function(CanBuy)
                                    if CanBuy then
                                        for k,v in pairs(myOrgData.orgVehicles) do
                                            if v.xenonLights == nil then v.xenonLights = false end
                                            v.xenonLights = true
                                        end
    
                                        TriggerServerEvent("Org:refreshVehicleFromOrg", token, myOrgData.orgName, myOrgData.orgVehicles)
                                        RageUI.GoBack()
                                    else
                                        Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent de source inconnue sur vous")
                                    end
                                end, extasy_core_cfg["xenonlights_gang"])
                            end
                        end)
                    else
                        RageUI.ButtonWithStyle("~c~Phares xenon", "Votre organisation possède déjà cette amélioration", {RightBadge = RageUI.BadgeStyle.Cash}, true, function(Hovered, Active, Selected) end)
                    end
                
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('org_menu', 'garage_menu_choose_new_vehicle'), true, true, true, function()

                    for k,v in pairs(cfg_org.vehicles) do
                        RageUI.ButtonWithStyle(v.cat_name, nil, {}, true, function(Hovered, Active, Selected) end, RMenu:Get('org_menu', v.value))
                    end
                
                end, function()
                end)

                for k,v in pairs(cfg_org.vehicles) do
                    RageUI.IsVisible(RMenu:Get('org_menu', v.value), true, true, true, function()

                        for k,la in pairs(v.vehicles) do
                            if la.capacity ~= nil then
                                RageUI.ButtonWithStyle(la.name, nil, {RightLabel = "~c~"..la.capacity.."KG"}, true, function(h, a, s)
                                    if s then
                                        table.insert(myOrgData.orgVehicles, {
                                            name        = la.name,
                                            hash        = la.hash,
                                            windowsTint = myOrgData.currentTi,
                                            fullCustom  = myOrgData.currentPerfs,
                                            fullCustom  = myOrgData.currentPerfs,
                                            color       = 1,
                                        })
                                        TriggerServerEvent("Org:refreshVehicleFromOrg", token, myOrgData.orgName, myOrgData.orgVehicles)
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                    end
                                end)
                            else
                                RageUI.ButtonWithStyle(la.name, nil, {RightLabel = "~c~N/A.KG"}, true, function(h, a, s)
                                    if s then
                                        table.insert(myOrgData.orgVehicles, {
                                            name  = la.name,
                                            hash  = la.hash,
                                            windowsTint = myOrgData.currentTi,

                                            color = 1,
                                        })
                                        TriggerServerEvent("Org:refreshVehicleFromOrg", token, myOrgData.orgName, myOrgData.orgVehicles)
                                        RageUI.GoBack()
                                        RageUI.GoBack()
                                    end
                                end) 
                            end
                        end

                    end, function()
                    end)
                end
            end
        end)
    end
end

SpawnOrgVehicle = function(model, coords, heading, color, tint, custom, xenon)
    if coords then
        Extasy.SpawnVehicle(model, coords, heading, function (vehicle) 
            local _, wheelColor = GetVehicleExtraColours(vehicle)

            SetVehicleColours(vehicle, color, color)
            SetVehicleExtraColours(vehicle, 0, wheelColor)
            SetVehicleDirtLevel(vehicle, 0.0)

            local vProps = Extasy.GetVehicleProperties(vehicle)

            if tint then
                vProps.windowTint = 1
            end
            if custom then
                vProps.modEngine       = 3
                vProps.modBrakes       = 2
                vProps.modTransmission = 3
                vProps.modTurbo        = true
            end
            if xenon then
                vProps.modXenon        = true
            end

            Extasy.SetVehicleProperties(vehicle, vProps)

            TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            Extasy.ShowNotification("~g~Vous avez reçu les clés du véhicule '"..vProps.plate.."'")
            TriggerServerEvent('carlock:location', token, vProps.plate)
        end)
        RageUI.CloseAll()
        myOrgData.inGarage = false
    else
        Extasy.ShowNotification("~r~Aucune sortie de véhicule disponible")
    end
end

--- Coffre

RMenu.Add('org_menu', 'chest_menu', RageUI.CreateMenu("Coffre", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('org_menu', 'chest_menu_p_inv', RageUI.CreateSubMenu(RMenu:Get('org_menu', 'chest_menu'), "Coffre", "Que voulez-vous faire ?"))
RMenu.Add('org_menu', 'deposit_chest_menu', RageUI.CreateSubMenu(RMenu:Get('org_menu', 'chest_menu'), "Coffre", "Que souhaitez-vous faire ?"))
RMenu.Add('org_menu', 'chest_menu_add_stockage', RageUI.CreateSubMenu(RMenu:Get('org_menu', 'chest_menu'), "Coffre", "Combien voulez-vous ajouter de KG ?"))
RMenu:Get('org_menu', 'chest_menu').Closed = function()
    myOrgData.inChest = false
end

myOrgOpenChest = function()
    if myOrgData.inChest then
        myOrgData.inChest = false
        return
    else
        myOrgData.inChest = true
        serverInteraction = false
        Citizen.CreateThread(function()
            while myOrgData.inChest do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('org_menu', 'chest_menu'), true, true, true, function()

                RageUI.Separator("Organisation : ~r~"..myOrgData.orgLabel)

                if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
                    RageUI.ButtonWithStyle("🛒 Acheter du stockage", nil, {RightLabel = "→"}, true, function(h, a, s) end, RMenu:Get('org_menu', 'chest_menu_add_stockage'))
                end

                if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
                    RageUI.ButtonWithStyle("Webhook discord", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(h, a, s)
                        if s then
                            local i = nil

                            JSP.ENCORE("Indiquez le lien du webhook discord que vous avez créé", function(value)
                                i = value
                            end)
                            while i == nil do Wait(1) end
                            i = tostring(i)

                            if string.len(i) > 3 then
                                TriggerServerEvent("Org:updateWebhook", token, myOrgData.orgName, i)
                            end
                        end
                    end)
                    RageUI.Separator("")
                else
                    RageUI.ButtonWithStyle("~c~Webhook discord", nil, {RightBadge = RageUI.BadgeStyle.Lock}, false, function(h, a, s) end)
                    RageUI.Separator("")
                end

                RageUI.ButtonWithStyle("Déposer dans le coffre", nil, {RightLabel = "→"}, true, function(h, a, s) 
                    if s then
                        TriggerServerEvent("Org:getChestInventory", token, myOrgData.orgName) 
                        while myOrgData.orgInventory == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                        while myOrgData.orgMoney == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                    end
                end, RMenu:Get('org_menu', 'chest_menu_p_inv'))

                --RageUI.Separator(myOrgData.invWeight)

                RageUI.ButtonWithStyle("~c~Source inconnue", nil, {RightLabel = "~c~"..Extasy.Math.GroupDigits(myOrgData.orgMoney).."$"}, true, function(h, a, s)
                    if s then
                        a = Extasy.KeyboardInput("Combien ?", "", 20)
                        a = tonumber(a)
                        if a ~= nil then
                            if a > tonumber(myOrgData.orgMoney) then
                                Extasy.ShowNotification("~r~Quantité invalide")
                            else
                                if string.sub(a, 1, string.len("-")) == "-" then
                                    Extasy.ShowNotification("~r~Quantité invalide")
                                else
                                    TriggerServerEvent("Org:TransferMoneyFromChestToInv", token, myOrgData.orgName, a, myOrgData.orgMoney)
                                    -- TriggerServerEvent('Extasy:Log', token, "**"..GetPlayerName(PlayerId()).."** ["..GetPlayerServerId(PlayerId()).."] vient de prendre de l'argent sale d'un véhicule\n\n**Plaque:** "..myOrgData.orgName.."\n**Montant:** "..a.."$\n**Le véhicule contient désormais** "..vecDirtyMoney - a.."$ dans son coffre", "org")
                                    TriggerServerEvent("Org:getChestInventory", token, myOrgData.orgName)
                                    while myOrgData.orgInventory == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                    while myOrgData.orgMoney == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                end
                            end
                        else
                            Extasy.ShowNotification("~r~Quantité invalide")
                        end
                    end
                end)

                RageUI.Separator("")

                if Extasy.TableCount(myOrgData.orgInventory) < 1 then
                    RageUI.ButtonWithStyle("~r~Coffre vide", nil, {}, true, function() end)
                elseif Extasy.TableCount(myOrgData.orgInventory) > 0 then

                    if myOrgData.currentInvIndex == nil then myOrgData.currentInvIndex = 1 end

                    RageUI.ButtonWithStyle("Filtre d'objets", nil, {RightLabel = "← "..cfg_org.invCategories[myOrgData.currentInvIndex].." →"}, true, function(h, a, s)
                        if a then
                            if IsControlJustPressed(0, 174) then
                                if myOrgData.currentInvIndex - 1 < 1 then
                                    myOrgData.currentInvIndex = #cfg_org.invCategories
                                else
                                    myOrgData.currentInvIndex = myOrgData.currentInvIndex - 1
                                end

                                RageUI.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "NAV_LEFT_RIGHT")
                            end
                            if IsControlJustPressed(0, 175) then
                                if myOrgData.currentInvIndex + 1 > #cfg_org.invCategories then
                                    myOrgData.currentInvIndex = 1
                                else
                                    myOrgData.currentInvIndex = myOrgData.currentInvIndex + 1
                                end

                                RageUI.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "NAV_LEFT_RIGHT")
                            end
                        end
                    end)

                    for itemName, count in pairs(myOrgData.orgInventory) do
                        if orgInventorylabel[itemName] ~= nil then
                            if cfg_org.invCategories[myOrgData.currentInvIndex] == 'Nourriture' then
                                RageUI.ButtonWithStyle("[~p~x"..count.."~s~] "..orgInventorylabel[itemName], nil, {RightLabel = "→"}, not serverInteraction, function(h, a, s)
                                    if s then
                                        a = Extasy.KeyboardInput("Combien ?", "", 20)
                                        a = tonumber(a)
                                        if a ~= nil then
                                            if a > v.count or a < 1 then
                                                Extasy.ShowNotification("~r~Quantité invalide")
                                            else
                                                if string.sub(a, 1, string.len("-")) == "-" then
                                                    Extasy.ShowNotification("~r~Quantité invalide")
                                                else
                                                    serverInteraction = true
                                                    TriggerServerEvent("Org:TransferItemFromChestToInv", token, myOrgData.orgName, itemName, a, myOrgData.OrgChestCapacity) -- Oui
                                                    TriggerServerEvent("Org:getChestInventory", token, myOrgData.orgName)
                                                    while myOrgData.orgInventory == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                                    while myOrgData.orgMoney == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                                end
                                            end
                                        else
                                            Extasy.ShowNotification("~r~Quantité invalide")
                                        end
                                    end
                                end)
                            --[[elseif cfg_org.invCategories[myOrgData.currentInvIndex] == 'Armes' then -- Armes en items
                                if string.sub(itemName, 1, string.len("WEAPON_")) == "WEAPON_" then
                                    RageUI.ButtonWithStyle("[~p~x"..count.."~s~] "..orgInventorylabel[itemName], nil, {RightLabel = "→"}, not serverInteraction, function(h, a, s)
                                        if s then
                                            serverInteraction = true
                                            TriggerServerEvent("Org:TransferWeaponFromChestToInv", token, myOrgData.orgName, itemName, 1, myOrgData.OrgChestCapacity)
                                            TriggerServerEvent("Org:getChestInventory", token, myOrgData.orgName)
                                            while myOrgData.orgInventory == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                            while myOrgData.orgMoney == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                        end
                                    end)
                                end--]]
                            else
                                RageUI.ButtonWithStyle("[~p~x"..count.."~s~] "..orgInventorylabel[itemName], nil, {RightLabel = "→"}, not serverInteraction, function(h, a, s)
                                    if s then
                                        --if string.sub(itemName, 1, string.len("WEAPON_")) == "WEAPON_" then
                                        --    serverInteraction = true
                                        --    TriggerServerEvent("Org:TransferWeaponFromChestToInv", token, myOrgData.orgName, itemName, 1, myOrgData.OrgChestCapacity)
                                        --    TriggerServerEvent("Org:getChestInventory", token, myOrgData.orgName)
                                        --    while myOrgData.orgInventory == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                        --    while myOrgData.orgMoney == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                        --else
                                            a = Extasy.KeyboardInput("Combien ?", "", 20)
                                            a = tonumber(a)
                                            if a ~= nil then
                                                if a > count or a < 1 then
                                                    Extasy.ShowNotification("~r~Quantité invalide")
                                                else
                                                    if string.sub(a, 1, string.len("-")) == "-" then
                                                        Extasy.ShowNotification("~r~Quantité invalide")
                                                    else
                                                        serverInteraction = true
                                                        TriggerServerEvent("Org:TransferItemFromChestToInv", token, myOrgData.orgName, itemName, a, myOrgData.OrgChestCapacity)
                                                        TriggerServerEvent("Org:getChestInventory", token, myOrgData.orgName)
                                                        while myOrgData.orgInventory == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                                        while myOrgData.orgMoney == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                                    end
                                                end
                                            else
                                                Extasy.ShowNotification("~r~Quantité invalide")
                                            end
                                        --end
                                    end
                                end)
                            end
                        end
                    end
                end

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('org_menu', 'chest_menu_p_inv'), true, true, true, function()

                RageUI.Separator(myOrgData.invWeight)

                for i = 1, #ESX.PlayerData.accounts, 1 do
                    if ESX.PlayerData.accounts[i].name == 'black_money'  then
                        RageUI.ButtonWithStyle("~c~Source inconnue", nil, {RightLabel = "~c~"..Extasy.Math.GroupDigits(ESX.PlayerData.accounts[i].money).."$"}, true, function(h, a, s)
                            if s then
                                a = Extasy.KeyboardInput("Combien ?", "", 20)
                                a = tonumber(a)

                                if a ~= nil then
                                    if type(a) == 'number' then
                                        if a > ESX.PlayerData.accounts[i].money then
                                            Extasy.ShowNotification("~r~Quantité invalide")
                                        else
                                            if string.sub(a, 1, string.len("-")) == "-" then
                                                Extasy.ShowNotification("~r~Quantité invalide")
                                            else
                                                TriggerServerEvent("Org:TransferMoneyFromInvToChest", token, myOrgData.orgName, a, myOrgData.orgMoney)
                                                TriggerServerEvent("Org:getChestInventory", token, myOrgData.orgName)
                                                while myOrgData.orgInventory == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                                while myOrgData.orgMoney == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                                                RageUI.GoBack()
                                            end
                                        end
                                    else
                                        Extasy.ShowNotification("~r~Quantité invalide")
                                    end
                                else
                                    Extasy.ShowNotification("~r~Quantité invalide")
                                end
                            end
                        end)
                    end
                end

                RageUI.Separator("")

                if Extasy.TableCount(ESX.PlayerData.inventory) < 1 then
                    RageUI.ButtonWithStyle("Vide", nil, {}, true, function() end)
                elseif Extasy.TableCount(ESX.PlayerData.inventory) > 0 then
                    if myOrgData.currentInvIndex == nil then myOrgData.currentInvIndex = 1 end
                    RageUI.ButtonWithStyle("Filtre d'objets", nil, {RightLabel = "← "..cfg_org.invCategories[myOrgData.currentInvIndex].." →"}, true, function(h, a, s)
                        if a then
                            if IsControlJustPressed(0, 174) then
                                if myOrgData.currentInvIndex - 1 < 1 then
                                    myOrgData.currentInvIndex = #cfg_org.invCategories
                                else
                                    myOrgData.currentInvIndex = myOrgData.currentInvIndex - 1
                                end

                                RageUI.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "NAV_LEFT_RIGHT")
                            end
                            if IsControlJustPressed(0, 175) then
                                if myOrgData.currentInvIndex + 1 > #cfg_org.invCategories then
                                    myOrgData.currentInvIndex = 1
                                else
                                    myOrgData.currentInvIndex = myOrgData.currentInvIndex + 1
                                end

                                RageUI.PlaySound("HUD_FRONTEND_DEFAULT_SOUNDSET", "NAV_LEFT_RIGHT")
                            end
                        end
                    end)

                    if cfg_org.invCategories[myOrgData.currentInvIndex] == 'Nourriture / Object' then
                        for itemName, count in pairs(playerContent) do
                            if count > 0 then
                                RageUI.ButtonWithStyle("[~p~x"..count.."~s~] "..orgInventorylabel[itemName], nil, {RightLabel = "→"}, not serverInteraction, function(h, a, s)
                                    if s then
                                        a = Extasy.KeyboardInput("Combien ?", "", 20)
                                        a = tonumber(a)
                                        if type(a) == 'number' then
                                            if a > count or a < 1 then
                                                Extasy.ShowNotification("~r~Quantité invalide")
                                            else
                                                if string.sub(a, 1, string.len("-")) == "-" then
                                                    Extasy.ShowNotification("~r~Quantité invalide")
                                                else
                                                    TriggerServerEvent("Org:TransferItemFromInvToChest", token, myOrgData.orgName, itemName, a, myOrgData.OrgChestCapacity)
                                                    RageUI.GoBack()
                                                end
                                            end
                                        else
                                            Extasy.ShowNotification("~r~Quantité invalide")
                                        end
                                    end
                                end)
                            end
                        end
                    --[[elseif cfg_org.invCategories[myOrgData.currentInvIndex] == 'Armes' then -- Arme en items
                        for i = 1, #weapon_org.WeaponData, 1 do
                            if HasPedGotWeapon(GetPlayerPed(-1), weapon_org.WeaponData[i].hash, false) then
                                local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), weapon_org.WeaponData[i].hash)
                                RageUI.ButtonWithStyle(menu_perso.WeaponData[i].label.." ("..ammo..")", nil, {RightLabel = "→"}, true, function(h, a, s)
                                    if s then
                                        TriggerServerEvent("Org:TransferWeaponFromInvToChest", token, myOrgData.orgName, menu_perso.WeaponData[i].name, 1, myOrgData.OrgChestCapacity)
                                        RageUI.GoBack()
                                    end
                                end)
                            end
                        end--]]
                    else
                        for itemName, count in pairs(playerContent) do
                            if count > 0 then
                                RageUI.ButtonWithStyle("[~p~x"..count.."~s~] "..orgInventorylabel[itemName], nil, {RightLabel = "→"}, not serverInteraction, function(h, a, s)
                                    if s then
                                        a = Extasy.KeyboardInput("Combien ?", "", 20)
                                        a = tonumber(a)
                                        if type(a) == 'number' then
                                            if a > count or a < 1 then
                                                Extasy.ShowNotification("~r~Quantité invalide")
                                            else
                                                if string.sub(a, 1, string.len("-")) == "-" then
                                                    Extasy.ShowNotification("~r~Quantité invalide")
                                                else
                                                    TriggerServerEvent("Org:TransferItemFromInvToChest", token, myOrgData.orgName, itemName, a, myOrgData.OrgChestCapacity)
                                                    serverInteraction = true
                                                end
                                            end
                                        else
                                            Extasy.ShowNotification("~r~Quantité invalide")
                                        end
                                    end
                                end)
                            end
                        end

                        --[[for i = 1, #weapon_org.WeaponData, 1 do
                            if menu_perso.WeaponData[i].label == menu_perso.WeaponData[i].label then
                                if HasPedGotWeapon(GetPlayerPed(-1), weapon_org.WeaponData[i].hash, false) then
                                    local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), weapon_org.WeaponData[i].hash)
                                    RageUI.ButtonWithStyle(menu_perso.WeaponData[i].label.." ("..ammo..")", nil, {RightLabel = "→"}, not serverInteraction, function(h, a, s)
                                        if s then
                                            serverInteraction = true
                                            TriggerServerEvent("Org:TransferWeaponFromInvToChest", token, myOrgData.orgName, menu_perso.WeaponData[i].name, 1, myOrgData.OrgChestCapacity)
                                            ESX.PlayerData = ESX.GetPlayerData()
                                            RageUI.GoBack()
                                        end
                                    end)
                                end
                            end
                        end--]]
                    end
                end
            
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('org_menu', 'chest_menu_add_stockage'), true, true, true, function()

                RageUI.ButtonWithStyle("+25KG", nil, {RightLabel = 25 * extasy_core_cfg["chest_capacity_price"].."$"}, true, function(h, a, s)
                    if s then
                        a = Extasy.KeyboardInput("Confirmez en écrivant 'Oui'", "", 20)
                        a = tostring(a)

                        if a ~= nil then
                            --TriggerPay
                        else
                            Extasy.ShowNotification("~r~Achat annulé")
                        end
                    end
                end)
                RageUI.ButtonWithStyle("+50KG", nil, {RightLabel = 50 * extasy_core_cfg["chest_capacity_price"].."$"}, true, function(h, a, s)
                    if s then
                        a = Extasy.KeyboardInput("Confirmez en écrivant 'Oui'", "", 20)
                        a = tostring(a)

                        if a ~= nil then
                            --TriggerPay
                        else
                            Extasy.ShowNotification("~r~Achat annulé")
                        end
                    end
                end)
                RageUI.ButtonWithStyle("+100KG", nil, {RightLabel = 100 * extasy_core_cfg["chest_capacity_price"].."$"}, true, function(h, a, s)
                    if s then
                        a = Extasy.KeyboardInput("Confirmez en écrivant 'Oui'", "", 20)
                        a = tostring(a)

                        if a ~= nil then
                            --TriggerPay
                        else
                            Extasy.ShowNotification("~r~Achat annulé")
                        end
                    end
                end)

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('org_menu', 'deposit_chest_menu'), true, true, true, function()

                RageUI.Separator("Capacité de stockage : ~r~"..myOrgData.orgChestCapacity)

                for i=1, #myOrgData.orgMyInventory, 1 do
                    if myOrgData.orgMyInventory ~= nil then
                        local item = myOrgData.orgMyInventory[i]
                        if item.count > 0 then
                            RageUI.ButtonWithStyle("~p~→~s~ "..item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local cbDeposer = Extasy.KeyboardInput("Combien ?", '' , 15)
                                    TriggerServerEvent('Org:putStockItems', item.name, tonumber(cbDeposer), myOrgData.orgName)
                                    RageUI.GoBack()
                                end
                            end)
                        end
                    end
                end
            end, function()
            end)

            end
        end)
    end
end

-- Action Boss

RMenu.Add('org_menu', 'boss_menu', RageUI.CreateMenu("Action BOSS", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('org_menu', 'gestion_membres_boss_menu', RageUI.CreateSubMenu(RMenu:Get('org_menu', 'boss_menu'), "Gestion Membres", "Que souhaitez-vous faire ?"))
RMenu.Add('org_menu', 'gestion_action_membres_boss_menu', RageUI.CreateSubMenu(RMenu:Get('org_menu', 'boss_menu'), "Action Membres", "Que souhaitez-vous faire ?"))
RMenu:Get('org_menu', 'boss_menu').Closed = function()
    myOrgData.inBoss = false
end

myOrgOpenBoss = function()
    if myOrgData.inBoss then
        myOrgData.inBoss = false
        return
    else
        myOrgData.inBoss = true
        Citizen.CreateThread(function()
            while myOrgData.inBoss do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('org_menu', 'boss_menu'), true, true, true, function()

                    if myOrgData.orgGangMoney ~= nil then
                        RageUI.Separator("~p~Argent de l'organisation : ~s~$"..ESX.Math.GroupDigits(myOrgData.orgGangMoney))
                    end

                    RageUI.ButtonWithStyle("Retirer l'argent de l'organisation",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local Cbmoney = Extasy.KeyboardInput("Combien ?", '' , 15)
                            Cbmoney = tonumber(Cbmoney)
                            if Cbmoney == nil then
                                Extasy.ShowNotification("Montant invalide")
                            else
                                TriggerServerEvent('Org:withdrawMoney', token, "society_"..myOrgData.orgName, Cbmoney)
                                if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
                                    TriggerServerEvent("Org:getMyGangMoney", token, "society_"..ESX.PlayerData.job2.name)
                                    while myOrgData.orgGangMoney == nil do Wait(1) end
                                end
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Déposer de l'argent dans l'organisation",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local Cbmoneyy = Extasy.KeyboardInput("Montant", "", 10)
                            Cbmoneyy = tonumber(Cbmoneyy)
                            if Cbmoneyy == nil then
                                Extasy.ShowNotification("Montant invalide")
                            else
                                TriggerServerEvent('Org:depositMoney', token, "society_"..myOrgData.orgName, Cbmoneyy)
                                if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
                                    TriggerServerEvent("Org:getMyGangMoney", token, "society_"..ESX.PlayerData.job2.name)
                                    while myOrgData.orgGangMoney == nil do Wait(1) end
                                end
                            end
                        end
                    end)


                    RageUI.ButtonWithStyle("Gestion des membres", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                            TriggerServerEvent("Org:GetGangsMembres", token, myOrgData.orgName)
                            while myOrgData.orgGansMembres == nil do Wait(1) end
                        end
                    end, RMenu:Get('org_menu', 'gestion_membres_boss_menu'))

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('org_menu', 'gestion_membres_boss_menu'), true, true, true, function()
                    while myOrgData.orgGansMembres == nil do Wait(1) end

                    if #myOrgData.orgGansMembres == 0 then
                        RageUI.Separator("")
                        RageUI.Separator("~r~Aucun Membres")
                        RageUI.Separator("")
                    end

                    for k,v in pairs(myOrgData.orgGansMembres) do
                        RageUI.ButtonWithStyle(v.Name, false, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                Ply = v
                            end
                        end, RMenu:Get('org_menu', 'gestion_action_membres_boss_menu'))
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('org_menu', 'gestion_action_membres_boss_menu'), true, true, true, function()

                    RageUI.ButtonWithStyle("Exclure ~r~"..Ply.Name,nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('Org:Bossvirer', token, Ply.Info)
                            myOrgData.orgGansMembres = nil
                            TriggerServerEvent("Org:GetGangsMembres", token, myOrgData.orgName)
                            while myOrgData.orgGansMembres == nil do Wait(1) end
                            RageUI.GoBack()
                        end
                    end)
    
                    --[[RageUI.ButtonWithStyle("Promouvoir ~r~"..Ply.Name,nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('Org:Bosspromouvoir', token, Ply.Info)
                            myOrgData.orgGansMembres = nil
                            TriggerServerEvent("Org:GetGangsMembres", token, myOrgData.orgName)
                            while myOrgData.orgGansMembres == nil do Wait(1) end
                            RageUI.GoBack()
                        end
                    end)
    
                    RageUI.ButtonWithStyle("Destituer ~r~"..Ply.Name,nil, {RightLabel = "~p~→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent('Org:Bossdestituer', token, Ply.Info)
                            myOrgData.orgGansMembres = nil
                            TriggerServerEvent("Org:GetGangsMembres", token, myOrgData.orgName)
                            while myOrgData.orgGansMembres == nil do Wait(1) end
                            RageUI.GoBack()
                        end
                    end)--]]
    
                end, function()
                end)

            end
        end)
    end
end

----- Vestiaire

RMenu.Add('org_menu', 'wear_menu', RageUI.CreateMenu("Coffre", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('org_menu', 'wear_menu_add', RageUI.CreateSubMenu(RMenu:Get('org_menu', 'wear_menu'), "Vestiaire", "Quelle tenue souhaitez-vous ajouter ?"))
RMenu:Get('org_menu', 'wear_menu').Closed = function()
    myOrgData.inWear = false
    TriggerEvent("skinchanger:loadPlayerSkin", playerSkin)
end

myOrgOpenWear = function()
    if myOrgData.inWear then
        myOrgData.inWear = false
        return
    else
        myOrgData.inWear = true
        Citizen.CreateThread(function()
            while myOrgData.inWear do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('org_menu', 'wear_menu'), true, true, true, function()

                    RageUI.Separator("Organisation: ~p~"..myOrgData.orgLabel)

                    RageUI.Separator("")

                    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and ESX.PlayerData.job2.name == myOrgData.orgName then
                        RageUI.ButtonWithStyle("Ajouter une tenue", nil, {}, true, function(H, A, S) end, RMenu:Get('org_menu', 'wear_menu_add'))
                    end

                    RageUI.ButtonWithStyle("Tenue de civil", nil, {}, true, function(Hovered, Active, Selected) 
                        if Selected then
                            playerInService = false
                            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
								local isMale = skin.sex == 0
								TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
									ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
										TriggerEvent('skinchanger:loadSkin', skin)
                                        TriggerEvent('skinchanger:loadClothes', skin, ORG.defaultskin)
                                        playerSkin = ORG.defaultskin
                                        ORG.defaultskin = nil
                                        ORG.defaultskincool = false
									end)
								end)
							end)
                        end			
                    end)

                    if #playerOrgWears > 0 then
                        RageUI.Separator("")
                    else
                        RageUI.Separator("")
                        RageUI.Separator("~r~Aucune tenue")
                        RageUI.Separator("")
                    end

                    for i,l in pairs(playerOrgWears) do
                        if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and ESX.PlayerData.job2.name == myOrgData.orgName then
                            t = "Appuyez sur ← pour supprimer cette tenue"
                        else
                            t = nil
                        end

                        RageUI.ButtonWithStyle("Tenue #"..l.id.." '"..l.orgWearName.."'", t, {}, true, function(H, A, S) 
                            if H then
                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    local d = json.decode(l.orgClothes)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                end)
                            end

                            if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and ESX.PlayerData.job2.name == myOrgData.orgName then
                                if A then
                                    if IsControlJustPressed(1, 308) then
                                        TriggerServerEvent("Org:removeWearFromThisOrg", token, l.id, myOrgData.orgName)
                                        playerOrgWears = {}
                                        TriggerServerEvent("Org:getAllWearsFromThisOrg", token, myOrgData.orgName)
                                        while playerOrgWears == {} do Wait(1) end
                                    end
                                end
                            end

                            if S then
                                local d = json.decode(l.orgClothes)

                                if d.type ~= 'ped' then
                                    if not ORG.defaultskincool then
                                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                            local isMale = skin.sex == 0
                                            --TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                    local d = json.decode(l.orgClothes)
                                                    TriggerEvent('skinchanger:loadSkin', skin)
                                                    TriggerEvent('skinchanger:loadClothes', skin, d)
                                                end)
                                            --end)
                                        end)
                                        ORG.defaultskincool = true
                                    else
                                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                            local isMale = skin.sex == 0
                                            --TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                    local d = json.decode(l.orgClothes)
                                                    TriggerEvent('skinchanger:loadSkin', skin)
                                                    TriggerEvent('skinchanger:loadClothes', skin, d)
                                                end)
                                            --end)
                                        end)
                                    end
                                else
                                    if extasy_core_cfg["player_can_have_ped"] then
                                        Extasy.SpawnPed(d.name)
                                    else
                                        Extasy.ShowNotification("~r~Vous n'avez pas le grade nécessaire pour accéder cette fonctionnalité.~n~Vous devez être minimum:\n~y~GOLDEN")
                                    end
                                end

                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    playerSkin = skin
                                end)
                            end			
                        end)
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('org_menu', 'wear_menu_add'), true, true, true, function()

                    if playergroup ~= 'user' and playergroup ~= 'mod' then
                        for k,v in pairs(cfg_org.pedList) do
                            RageUI.ButtonWithStyle(v, nil, {}, true, function(h, a, s)
                                if s then
                                    local t = {
                                        type = 'ped',
                                        name = v,
                                    }
                                    TriggerServerEvent("Org:addNewWearFormThisOrg", token, myOrgData.orgName, json.encode(t), "[PED] "..v)
                                    TriggerServerEvent("Org:getAllWearsFromThisOrg", token, myOrgData.orgName)
                                    while playerOrgWears == {} do Wait(1) end
                                    RageUI.GoBack()
                                end
                            end)
                        end
                        RageUI.Separator("")
                    end

                    for k,v in pairs(playerClothes) do
                        RageUI.ButtonWithStyle("Tenue #"..k.." '"..v.label.."'", nil, {}, true, function(h, a, s)
                            if h then
                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    local d = json.decode(v.tenue)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                end)
                            end
                            if s then
                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    local d = json.decode(v.tenue)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                    TriggerServerEvent("Org:addNewWearFormThisOrg", token, myOrgData.orgName, v.tenue, v.label)
                                    TriggerServerEvent("Org:getAllWearsFromThisOrg", token, myOrgData.orgName)
                                    while playerOrgWears == {} do Wait(1) end
                                end)
                                RageUI.GoBack()
                            end
                        end)
                    end
                
                end, function()
                end)

            end
        end)
    end
end

OrgStartThings = function()
    if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == myOrgData.orgName then
        print("^6Données organisation chargé pour le joueur")

        local plyPos = GetEntityCoords(PlayerPedId())
        local orgBoss   = vector3(myOrgData.orgBoss.x, myOrgData.orgBoss.y, myOrgData.orgBoss.z)
        local orgChest = vector3(myOrgData.orgChest.x, myOrgData.orgChest.y, myOrgData.orgChest.z)
        local orgGarage = vector3(myOrgData.orgGarage.x, myOrgData.orgGarage.y, myOrgData.orgGarage.z)
        local orgWear   = vector3(myOrgData.orgWear.x, myOrgData.orgWear.y, myOrgData.orgWear.z)
        local orgGDelete   = vector3(myOrgData.orgGDelete.x, myOrgData.orgGDelete.y, myOrgData.orgGDelete.z)

        registerNewMarker({
            npcType         = 'drawmarker',
            pos             = orgWear,
            interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder au vestiaire",
            action          = function()
                if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == myOrgData.orgName then
                    ESX.TriggerServerCallback('ExtasyMenu:getUsergroup', function(group)
                        playergroup = group
                    end)
                    TriggerServerEvent("Extasy:GetTenues", token)
                    TriggerServerEvent("Org:getAllWearsFromThisOrg", token, myOrgData.orgName)
                    while playerOrgWears == {} do Wait(1) end
                    RageUI.Visible(RMenu:Get('org_menu', 'wear_menu'), true)
                    myOrgOpenWear()
                else
                    Extasy.ShowNotification("~r~Vous n'avez pas accès à cette fonctionalitée en tant que "..ESX.PlayerData.job2.name)
                end
            end,
            spawned         = false,
            entity          = nil,
            load_dst        = 50,
        
            blip_enable      = false,

            marker           = true,
            size             = 0.45,

            drawmarkerType   = 25,
            
            drawmarkerColorR = 100,
            drawmarkerColorG = 0,
            drawmarkerColorB = 200,
        })

        registerNewMarker({
            npcType         = 'drawmarker',
            pos             = orgGDelete,
            interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~r~ranger le véhicule",
            action          = function()
                if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == myOrgData.orgName then
                    local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                    if dist4 < 4 then
                        DeleteEntity(veh)
                    end
                else
                    Extasy.ShowNotification("~r~Vous n'avez pas accès à cette fonctionalitée en tant que "..ESX.PlayerData.job2.name)
                end
            end,
            spawned         = false,
            entity          = nil,
            load_dst        = 50,
        
            blip_enable      = false,

            marker           = true,
            size             = 0.45,

            drawmarkerType   = 25,
            
            drawmarkerColorR = 255,
            drawmarkerColorG = 0,
            drawmarkerColorB = 0,
        })

        registerNewMarker({
            npcType         = 'drawmarker',
            pos             = orgBoss,
            interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à l'action patron",
            action          = function()
                if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and ESX.PlayerData.job2.name == myOrgData.orgName then
                    TriggerServerEvent("Org:getMyGangMoney", token, "society_"..ESX.PlayerData.job2.name)
                    while myOrgData.orgGangMoney == nil do Wait(1) end
                    RageUI.Visible(RMenu:Get('org_menu', 'boss_menu'), true)
                    myOrgOpenBoss(myOrgData.orgLabel)
                else
                    Extasy.ShowNotification("~r~Vous n'avez pas accès à cette fonctionalitée en tant que "..ESX.PlayerData.job2.name)
                end
            end,
            spawned         = false,
            entity          = nil,
            load_dst        = 50,
        
            blip_enable      = false,

            marker           = true,
            size             = 0.45,

            drawmarkerType   = 25,
            
            drawmarkerColorR = 100,
            drawmarkerColorG = 0,
            drawmarkerColorB = 200,
        })

        registerNewMarker({
            npcType         = 'drawmarker',
            pos             = orgChest,
            interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder au coffre",
            action          = function()
                if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == myOrgData.orgName then
                    RefreshWeaponForOrg()
                    TriggerServerEvent("Org:getChestInventory", token, myOrgData.orgName)
                    while myOrgData.orgInventory == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                    while myOrgData.orgMoney == nil do Extasy.PopupTime("~c~Chargement du coffre", 100) Wait(1) end
                    RageUI.Visible(RMenu:Get('org_menu', 'chest_menu'), true)
                    myOrgOpenChest(myOrgData.orgLabel)
                else
                    Extasy.ShowNotification("~r~Vous n'avez pas accès à cette fonctionalitée en tant que "..ESX.PlayerData.job2.name)
                end
            end,
            spawned         = false,
            entity          = nil,
            load_dst        = 50,
        
            blip_enable      = false,

            marker           = true,
            size             = 0.45,

            drawmarkerType   = 25,
            
            drawmarkerColorR = 100,
            drawmarkerColorG = 0,
            drawmarkerColorB = 200,
        })

        registerNewMarker({
            npcType         = 'drawmarker',
            pos             = orgGarage,
            interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder au garage",
            action          = function()
                if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == myOrgData.orgName then
                    TriggerServerEvent("Org:getVehiclesFromThisOrg", token, myOrgData.orgName)
                    myOrgData.inWait = true
                    while myOrgData.inWait do Extasy.PopupTime("~c~Chargement des véhicules", 100) Wait(1) end
                    RageUI.Visible(RMenu:Get('org_menu', 'garage_menu'), true)
                    ESX.TriggerServerCallback('ExtasyMenu:getUsergroup', function(group)
                        playergroup = group
                    end)
                    myOrgOpenGarage(myOrgData.orgLabel)
                else
                    Extasy.ShowNotification("~r~Vous n'avez pas accès à cette fonctionalitée en tant que "..ESX.PlayerData.job2.name)
                end
            end,
            spawned         = false,
            entity          = nil,
            load_dst        = 50,
        
            blip_enable      = false,

            marker           = true,
            size             = 0.45,

            drawmarkerType   = 25,
            
            drawmarkerColorR = 100,
            drawmarkerColorG = 0,
            drawmarkerColorB = 200,
        })
    end
end

RegisterNetEvent("Org:serverCb")
AddEventHandler("Org:serverCb", function(message)
    serverInteraction = false
    if message ~= nil then Extasy.ShowNotification(message) end
end)

RegisterNetEvent("clothes:receveClothes") 
AddEventHandler("clothes:receveClothes", function(clothes)
    playerClothes = {}
    playerClothes = clothes
end)

RegisterNetEvent("Org:refreshVehiclesOrg")
AddEventHandler("Org:refreshVehiclesOrg", function(_vehicles)
    myOrgData.orgVehicles = {}
    myOrgData.orgVehicles  = json.decode(_vehicles)

    for k,v in pairs(myOrgData.orgVehicles) do
        if v.windowsTint == nil then v.windowsTint = false end
        if v.fullCustom == nil then v.fullCustom = false end
        if v.xenonLights == nil then v.xenonLights = false end
        
        if v.windowsTint then
            myOrgData.currentTi = true
        else
            myOrgData.currentTi = false
        end
        if v.fullCustom then
            myOrgData.currentPerfs = true
        else
            myOrgData.currentPerfs = false
        end
        if v.xenonLights then
            myOrgData.currentXenon = true
        else
            myOrgData.currentXenon = false
        end
    end

    myOrgData.inWait = false
end)

RegisterNetEvent("Org:refreshAllWearsFromThisOrg")
AddEventHandler("Org:refreshAllWearsFromThisOrg", function(_wear)
    playerOrgWears = _wear
end)

RegisterNetEvent("Org:refreshGangsMembres")
AddEventHandler("Org:refreshGangsMembres", function(_GansMembres)
    myOrgData.orgGansMembres   = _GansMembres
end)

RegisterNetEvent("Org:refreshChestTable")
AddEventHandler("Org:refreshChestTable", function(orgInventory)
    myOrgData.orgInventory      = orgInventory

    --myOrgData.invWeight         = Extasy.Math.Round(tonumber(myOrgData.orgInventory), 2).."/"..myOrgData.orgChestCapacity.."KG"
    --print(myOrgData.invWeight)
end)

RegisterNetEvent("Org:refreshPlayerContent")
AddEventHandler("Org:refreshPlayerContent", function(newContent)
    playerContent = newContent
end)

RegisterNetEvent("Org:refreshChest")
AddEventHandler("Org:refreshChest", function(orgInventory, orgChestCapacity, orgMoney, playerInventory)
    myOrgData.orgInventory      = json.decode(orgInventory)
    myOrgData.orgMoney          = tonumber(orgMoney)
    myOrgData.orgChestCapacity  = orgChestCapacity
    playerContent               = playerInventory
end)

RegisterNetEvent("Org:refreshGangMoney")
AddEventHandler("Org:refreshGangMoney", function(_money)
    myOrgData.orgGangMoney   = _money
end)

RegisterNetEvent("Org:refreshMyInventory")
AddEventHandler("Org:refreshMyInventory", function(_inventory)
    myOrgData.orgMyInventory   = _inventory
end)

RegisterNetEvent('Org:sendGangData')
AddEventHandler('Org:sendGangData', function(data, labelTable)
    myOrgData                  = data
    orgInventorylabel          = labelTable

    myOrgData.blipsList        = {}

    myOrgData.orgChest         = json.decode(myOrgData.orgChest)
    myOrgData.orgBoss          = json.decode(myOrgData.orgBoss)
    myOrgData.orgWear          = json.decode(myOrgData.orgWear)
    myOrgData.orgGarage        = json.decode(myOrgData.orgGarage)
    myOrgData.orgVehicles      = json.decode(myOrgData.orgVehicles)
    myOrgData.orgGSpawn        = json.decode(myOrgData.orgGSpawn)
    myOrgData.orgGDelete       = json.decode(myOrgData.orgGDelete)
    myOrgData.orgActivity      = json.decode(myOrgData.orgActivity)
    myOrgData.orgChestCapacity = tonumber(myOrgData.orgChestCapacity)

    if myOrgData.orgLabel ~= nil then
        myOrgData.blipsList        = {
            {
                name               = myOrgData.orgLabel.." | Coffre d'organisation",
                sprite             = 587,
                color              = 2,
                scale              = 0.65,
                coords             = vector3(myOrgData.orgChest.x, myOrgData.orgChest.y, myOrgData.orgChest.z),
            },
            {
                name               = myOrgData.orgLabel.." | Garage d'organisation",
                sprite             = 569,
                color              = 2,
                scale              = 0.65,
                coords             = vector3(myOrgData.orgGarage.x, myOrgData.orgGarage.y, myOrgData.orgGarage.z),
            },
            {
                name               = myOrgData.orgLabel.." | Garage (rangement) d'organisation",
                sprite             = 569,
                color              = 2,
                scale              = 0.65,
                coords             = vector3(myOrgData.orgGDelete.x, myOrgData.orgGDelete.y, myOrgData.orgGDelete.z),
            },
            {
                name               = myOrgData.orgLabel.." | Vestiaire d'organisation",
                sprite             = 366,
                color              = 2,
                scale              = 0.65,
                coords             = vector3(myOrgData.orgWear.x, myOrgData.orgWear.y, myOrgData.orgWear.z),
            },
            {
                name               = myOrgData.orgLabel.." | Action patron d'organisation",
                sprite             = 366,
                color              = 2,
                scale              = 0.65,
                coords             = vector3(myOrgData.orgBoss.x, myOrgData.orgBoss.y, myOrgData.orgBoss.z),
            },
        }

        if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name == myOrgData.orgName then
            for k,v in pairs(myOrgData.blipsList) do
                v.blip = AddBlipForCoord(v.coords)

                SetBlipSprite(v.blip, v.sprite)
                SetBlipDisplay(v.blip, 4)
                SetBlipScale(v.blip, v.scale)
                SetBlipColour(v.blip, v.color)
                SetBlipAsShortRange(v.blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.name)
                EndTextCommandSetBlipName(v.blip)
            end
        end
    end

    OrgStartThings()
end)