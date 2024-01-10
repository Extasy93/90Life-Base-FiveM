ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()

    CoffreData.WeaponData = ESX.GetWeaponList()

	for i = 1, #CoffreData.WeaponData, 1 do
		if CoffreData.WeaponData[i].name == 'WEAPON_UNARMED' then
			CoffreData.WeaponData[i] = nil
		else
			CoffreData.WeaponData[i].hash = GetHashKey(CoffreData.WeaponData[i].name)
		end
    end
    
end)

CoffreData = {
    WeaponData = {},
    sale = nil,
}

local arrayWeight = Coffre.localWeight

CoffreMenu = {
    inMenuCoffre = false,
    contenuDuCoffre = {},
    moneyBlack = {},
    BlackMoneyDuCoffre = 0,
}

--[[Citizen.CreateThread(function()
    while true do
        local interval = 1
        if not in_menu_coffre_vehicules then
            if IsControlJustPressed(1, 311) then --L
                local pPed = GetPlayerPed(-1)
                local pCoord = GetEntityCoords(pPed)
                local vCloset, vDistance = ESX.Game.GetClosestVehicle(pCoord, true)
                local vPlate = GetVehicleNumberPlateText(vCloset)
                local vClass = GetVehicleClass(vCloset)
                local dist = GetDistanceBetweenCoords(pPed, vDistance, true)
                if dist < 3 then 
                    openCoffre(vCloset, vPlate, vClass)
                    SetVehicleDoorOpen(vCloset, 5, false, false)
                else 
                    Extasy.ShowNotification("~g~Il n'y as pas de véhicule proche.")
                end
            end
        end
        Citizen.Wait(interval)
    end
end)--]]

openCoffre = function(veh, plate, class)
    local locked = GetVehicleDoorLockStatus(veh)

    ExecuteCommand("me Ouvre le coffre.")
  
    if locked == 1 or class == 15 or class == 16 or class == 14 then
        if plate ~= nil or plate ~= "" or plate ~= " " then
            CloseToVehicle = true
            OpenCoffreInventoryMenu(plate, Coffre.VehicleLimit[class])
        end
    else
        Extasy.ShowNotification('Ce coffre est ~r~fermé~s~.')
    end
end
  
getItemyWeight = function(item)
    local weight = 0
    local itemWeight = 0
    if item ~= nil then
         itemWeight = Coffre.DefaultWeight
         if arrayWeight[item] ~= nil then
              itemWeight = arrayWeight[item]
         end
      end
    return itemWeight
end
  
dump = function(o)
     if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
           if type(k) ~= 'number' then k = '"'..k..'"' end
           s = s .. '['..k..'] = ' .. dump(v) .. ','
        end
        return s .. '} '
     else
        return tostring(o)
     end
end

  
getAllItemCoffreVehicule = function(plate)
    ESX.TriggerServerCallback('esx_truck:getInventoryV', function(inventory)
      CoffreMenu.contenuDuCoffre = {}
      CoffreMenu.BlackMoneyDuCoffre = 0
  
      CoffreMenu.BlackMoneyDuCoffre = inventory.blackMoney
    
      for i=1, #inventory.items, 1 do
        local item = inventory.items[i]
        if item.count > 0 then
          table.insert(CoffreMenu.contenuDuCoffre, {label = item.label, right = ((getItemyWeight(item.name)*item.count)),  type = 'item_standard', item = item.name})
        end
      end
  
      --for i=1, #inventory.weapons, 1 do
      --  local weapon = inventory.weapons[i]
      --  table.insert(CoffreMenu.contenuDuCoffre, {label = ESX.GetWeaponLabel(weapon.name)..' avec '..weapon.ammo.." balle", right = (getItemyWeight(weapon.name)), type = 'item_weapon', item = weapon.name, ammo = weapon.ammo})
      --end
    end, plate)
end

local in_menu_coffre_vehicules = false
  
RMenu.Add("Extasy_menu_coffre_vehicules", "dynamicMenuCoffre_main", RageUI.CreateMenu("Coffre véhicule","Que souhaitez-vous faire ?"))
RMenu:Get("Extasy_menu_coffre_vehicules", 'dynamicMenuCoffre_main').Closed = function()
    in_menu_coffre_vehicules = false
    local pPed = GetPlayerPed(-1)
    local pCoord = GetEntityCoords(pPed)
    local vCloset, vDistance = ESX.Game.GetClosestVehicle(pCoord, true)
    SetVehicleDoorShut(vCloset, 5, false, false)
end

creatMenuCoffreVehicule = function(plate) -- Gestion menu et submenu
    RMenu.Add("Extasy_menu_coffre_vehicules", 'dynamicMenuCoffre_invPlayer', RageUI.CreateSubMenu(RMenu:Get("Extasy_menu_coffre_vehicules", 'dynamicMenuCoffre_main'), "Déposer", "Que souhaitez-vous faire ?"))
    RMenu:Get("Extasy_menu_coffre_vehicules", 'dynamicMenuCoffre_invPlayer').Closed = function()
        getAllItemCoffreVehicule(plate)
        RageUI.GoBack()
    end

    RMenu.Add("Extasy_menu_coffre_vehicules", 'dynamicMenuCoffre_invVehicule', RageUI.CreateSubMenu(RMenu:Get("Extasy_menu_coffre_vehicules", 'dynamicMenuCoffre_main'), "Prendre", "Que souhaitez-vous faire ?"))
    RMenu:Get("Extasy_menu_coffre_vehicules", 'dynamicMenuCoffre_invVehicule').Closed = function()
        getAllItemCoffreVehicule(plate)
        RageUI.GoBack()
    end
end
  
OpenCoffreInventoryMenu = function(plate, max)
    creatMenuCoffreVehicule(plate) -- Charge les menues et submenues
    getAllItemCoffreVehicule(plate)
    if not in_menu_coffre_vehicules then 
        in_menu_coffre_vehicules = true
		RageUI.Visible(RMenu:Get("Extasy_menu_coffre_vehicules",'dynamicMenuCoffre_main'), true)

		Citizen.CreateThread(function()
			while in_menu_coffre_vehicules do
				Citizen.Wait(1)
  
                RageUI.IsVisible(RMenu:Get("Extasy_menu_coffre_vehicules",'dynamicMenuCoffre_main'), true, true, true, function()
                    in_menu_coffre_vehicules = true
                    
                    RageUI.Separator("~r~Poid max du coffre : ~s~"..max.." kg")
                    --RageUI.Separator("~r~Poid restant : ~s~"..)
                    RageUI.Separator("")
                    RageUI.ButtonWithStyle("Déposer", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                    end, RMenu:Get("Extasy_menu_coffre_vehicules", 'dynamicMenuCoffre_invPlayer'))
                    RageUI.ButtonWithStyle("Prendre", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                    end, RMenu:Get("Extasy_menu_coffre_vehicules", 'dynamicMenuCoffre_invVehicule'))

                end, function()    
                end, 1)

                RageUI.IsVisible(RMenu:Get("Extasy_menu_coffre_vehicules",'dynamicMenuCoffre_invVehicule'), true, true, true, function()
                    in_menu_coffre_vehicules = true
                    
                    RageUI.Separator("~p~ Argent :")
                    RageUI.ButtonWithStyle("Argent sale :", nil, {RightLabel = "~r~"..CoffreMenu.BlackMoneyDuCoffre.."$"}, true, function(Hovered,Active,Selected)
                        if Selected then 
                            local post, quantity = CheckQuantity(KeyboardInputCoffre("Combien voulez-vous prendre ?", '', '', 100))
                            if post then
                                TriggerServerEvent('esx_truck:getItem', token, plate, "item_account_black", CoffreMenu.BlackMoneyDuCoffre, quantity, max)
                                ExecuteCommand("me prends l'argent sale dans le coffre.")
                            else
                                Extasy.ShowNotification("~r~Quantité invalide.")
                            end
                            getAllItemCoffreVehicule(plate)
                        end
                    end)
                    
                    RageUI.Separator("~p~ Objet et armes :")
                    for k,v in pairs(CoffreMenu.contenuDuCoffre) do 
                      RageUI.ButtonWithStyle(v.label, nil, {RightLabel = v.right}, true, function(Hovered,Active,Selected)
                        if Selected then 
                            if v.type == 'item_standard' then 
                                local post, quantity = CheckQuantity(KeyboardInputCoffre("Nombres d'items que vous voulez prendre", '', '', 100))
                                if post then
                                    TriggerServerEvent('esx_truck:getItem', token, plate, v.type, v.item, quantity, max)
                                    RageUI.GoBack()
                                    ExecuteCommand("me prends un object dans le coffre.")
                                else
                                    Extasy.ShowNotification("~r~Quantité invalide.")
                                end
                            elseif v.type == 'item_account' then 
                                local post, quantity = CheckQuantity(KeyboardInputCoffre("Montant que vous souhaiter prendre", '', '', 100))
                                if post then
                                    TriggerServerEvent('esx_truck:getItem', token, plate, v.type, v.item, quantity, max)
                                    RageUI.GoBack()
                                    ExecuteCommand("me prends un object dans le coffre.")
                                else
                                    Extasy.ShowNotification("~r~Quantité invalide.")
                                end
                            else
                                TriggerServerEvent('esx_truck:getItem', token, plate, v.type, v.item, v.ammo, max)
                                ExecuteCommand("me prends une arme dans le coffre.")
                            end
                            getAllItemCoffreVehicule(plate)
                        end
                      end)
                    end
                end, function()    
                end, 1)
                
                RageUI.IsVisible(RMenu:Get("Extasy_menu_coffre_vehicules",'dynamicMenuCoffre_invPlayer'), true, true, true, function()
                    in_menu_coffre_vehicules = true
                    ESX.PlayerData = ESX.GetPlayerData()
  
                    RageUI.Separator("~p~Argent :")
                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == 'black_money'  then
                            CoffreData.sale = RageUI.ButtonWithStyle('Votre argent sale :', nil, {RightLabel = "~r~"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money).."$ - ~p~Déposer~s~ →"}, true, function(Hovered, Active, Selected) 
                                if Selected then 
                                    local post, quantity = CheckQuantity(KeyboardInputCoffre("Nombres d'items que vous voulez déposer", '', '', 100))
                                    if post then
                                        TriggerServerEvent('esx_truck:putItem', token, plate, 'item_account_black', ESX.PlayerData.accounts[i].name, quantity, max)
                                        RageUI.GoBack()
                                    else
                                        Extasy.ShowNotification("~r~Quantité invalide.")
                                    end
                                    getAllItemCoffreVehicule(plate)
                                end
                            end)
                        end
                    end

                    RageUI.Separator("~p~Objets / Armes:")
                    for i = 1, #ESX.PlayerData.inventory do
                        if ESX.PlayerData.inventory[i].count > 0 then
                            RageUI.ButtonWithStyle("• "..ESX.PlayerData.inventory[i].label, "Quantité(s) : ~r~x"..ESX.PlayerData.inventory[i].count, {RightLabel = "~p~Déposer~s~ →"}, true, function(Hovered, Active, Selected)
                                if Selected then 
                                    local post, quantity = CheckQuantity(KeyboardInputCoffre("Nombres d'items que vous voulez déposer", '', '', 100))
                                    if post then
                                        TriggerServerEvent('esx_truck:putItem', token, plate, 'item_standard', ESX.PlayerData.inventory[i].name, quantity, max)
                                    else
                                        Extasy.ShowNotification("~r~Quantité invalide.")
                                    end
                                    getAllItemCoffreVehicule(plate)
                                end
                                
                            end)
                        end
                    end
                end, function()
				end)   
			end
		end)
	end
end

function KeyboardInputCoffre(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
  
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
  
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        return result
    else
        Citizen.Wait(500)
        return nil
    end
end

function RefreshMoney()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			societymoney = ESX.Math.GroupDigits(money)
		end, ESX.PlayerData.job.name)
	end
end

function RefreshMoney2()
	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			societymoney2 = ESX.Math.GroupDigits(money)
		end, ESX.PlayerData.job2.name)
	end
end

function playerMarker(player)
    local ped = GetPlayerPed(player)
    local pos = GetEntityCoords(ped)
    DrawMarker(2, pos.x, pos.y, pos.z+1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 170, 0, 1, 2, 0, nil, nil, 0)
end

function CheckQuantity(number)
    number = tonumber(number)
  
    if type(number) == 'number' then
        number = ESX.Math.Round(number)
        if number > 0 then
            return true, number
        end
    end
  
    return false, number
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function DrawAnim(ad)
    local ped = GetPlayerPed(-1)
    loadAnimDict(ad)
    RequestAnimDict(dict)
    TaskPlayAnim(ped, ad, "check_out_a", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "check_out_b", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "check_out_c", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "intro", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
    TaskPlayAnim(ped, ad, "outro", 8.0, 0.6, -1, 49, 0, 0, 0, 0 )
end

function setUniform(value, plyPed)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:getSkin', function(skina)
			if value == 'torso' then
				DrawAnim("clothingshirt")
				Citizen.Wait(1000)
				Player.handsup, Player.pointing = false, false
				ClearPedTasks(plyPed)

				if skin.torso_1 ~= skina.torso_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = skin.torso_1, ['torso_2'] = skin.torso_2, ['tshirt_1'] = skin.tshirt_1, ['tshirt_2'] = skin.tshirt_2, ['arms'] = skin.arms})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15})
				end
			elseif value == 'pants' then
				DrawAnim("clothingtrousers")
				Citizen.Wait(1000)
				Player.handsup, Player.pointing = false, false
				ClearPedTasks(plyPed)

				if skin.pants_1 ~= skina.pants_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = skin.pants_1, ['pants_2'] = skin.pants_2})
				else
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = 61, ['pants_2'] = 1})
					else
						TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = 15, ['pants_2'] = 0})
					end
				end
			elseif value == 'shoes' then
				DrawAnim("clothingshoes")
				Citizen.Wait(1000)
				Player.handsup, Player.pointing = false, false
				ClearPedTasks(plyPed)

				if skin.shoes_1 ~= skina.shoes_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = skin.shoes_1, ['shoes_2'] = skin.shoes_2})
				else
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = 34, ['shoes_2'] = 0})
					else
						TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = 35, ['shoes_2'] = 0})
					end
				end
			elseif value == 'bag' then
				DrawAnim("clothingshirt")
				Citizen.Wait(1000)
				Player.handsup, Player.pointing = false, false
				ClearPedTasks(plyPed)

				if skin.bags_1 ~= skina.bags_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['bags_1'] = skin.bags_1, ['bags_2'] = skin.bags_2})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['bags_1'] = 0, ['bags_2'] = 0})
				end
			elseif value == 'bproof' then
				DrawAnim("clothingtie")
				Citizen.Wait(1000)
				Player.handsup, Player.pointing = false, false
				ClearPedTasks(plyPed)

				Citizen.Wait(1000)
				Player.handsup, Player.pointing = false, false
				ClearPedTasks(plyPed)

				if skin.bproof_1 ~= skina.bproof_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['bproof_1'] = skin.bproof_1, ['bproof_2'] = skin.bproof_2})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['bproof_1'] = 0, ['bproof_2'] = 0})
				end
			end
		end)
	end)
end