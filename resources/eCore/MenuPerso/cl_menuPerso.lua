ESX                     = nil
playerGotBag            = false
local bagIndexInentaire = GetPedDrawableVariation(GetPlayerPed(-1), 5)
local soifF5            = 50
local faimF5            = 50
playerIdentity          = {}
playerMasksData         = {}
playerClothesData       = {}
local lastPlayersData    = {}
lastPlayersData.putMask  = false
lastPlayersData.putShirt = false
lastPlayersData.putPants = false
lastPlayersData.putAllCl = false
self = {
    windowVehIndex = 1,
    windowVehList = { "Ouvrir", "Fermer" },
    doorStatusIndex = 1,
    doorStatusList = { "Ouvrir", "Fermer" },
    doorOpenIndex = 1,
    doorOpenList = { "Avant Droit", "Avant Gauche", "Arrière Droit", "Arrière Gauche" },
    doorCloseIndex = 1,
    doorCloseList = { "Avant Droit", "Avant Gauche", "Arrière Droit", "Arrière Gauche" },
    hoodVehIndex = 1,
    hoodVehList = { "Ouvrir", "Fermer" },
    trunkVehIndex = 1,
    trunkVehList = { "Ouvrir", "Fermer" },
};

RegisterNetEvent("Extasy:sendMasksData")
AddEventHandler("Extasy:sendMasksData", function(MasksData)
    playerMasksData = {}
    playerMasksData = MasksData
end)

RegisterNetEvent("Extasy:sendClothesData")
AddEventHandler("Extasy:sendClothesData", function(ClothesData)
    playerClothesData = {}
    playerClothesData = ClothesData
end)

RegisterNetEvent("Extasy:sendIdentityData")
AddEventHandler("Extasy:sendIdentityData", function(identity)
    playerIdentity = identity
end)

RegisterNetEvent("Extasy:TienLeStatus")
AddEventHandler("Extasy:TienLeStatus", function(_soifF5, _faimF5)
    soifF5 = _soifF5
    faimF5 = _faimF5
end)

RegisterNetEvent("TattooShop:tatoesCallback")
AddEventHandler("TattooShop:tatoesCallback", function(ok)
    if ok ~= nil then
        playerTatoos = json.decode(ok)
        ClearPedDecorations(PlayerPedId())
        for _,t in pairs(playerTatoos) do
            ApplyPedOverlay(PlayerPedId(), t.cat, t.name) 
        end
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Wait(1)
    end

    RefreshMoney()

    menu_perso.WeaponData = ESX.GetWeaponList()

	for i = 1, #menu_perso.WeaponData, 1 do
		if menu_perso.WeaponData[i].name == 'WEAPON_UNARMED' then
			menu_perso.WeaponData[i] = nil
		else
			menu_perso.WeaponData[i].hash = GetHashKey(menu_perso.WeaponData[i].name)
		end
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(0)
    end

    while menu_perso.WeaponData == nil do
        Citizen.Wait(0)
    end

    Citizen.Wait(30000)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if not infos then
                if playerGotBag then
                    if Getmenu_persoentWeight() > 50 then
                        TriggerEvent("Extasy:ShowNotification", "~r~[Attention]~s~~n~Vous ne pouvez pas avoir plus de poids !")
                        DisableControlAction(0,21,true) -- disable sprint
                        DisableControlAction(0,24,true) -- disable attack
                        DisableControlAction(0,25,true) -- disable aim
                        DisableControlAction(0,47,true) -- disable weapon
                        DisableControlAction(0,58,true) -- disable weapon
                        DisableControlAction(0,263,true) -- disable melee
                        DisableControlAction(0,264,true) -- disable melee
                        DisableControlAction(0,257,true) -- disable melee
                        DisableControlAction(0,140,true) -- disable melee
                        DisableControlAction(0,141,true) -- disable melee
                        DisableControlAction(0,142,true) -- disable melee
                        DisableControlAction(0,143,true) -- disable melee
                        DisableControlAction(0,18,true) -- disable space
                        DisableControlAction(0,22,true) -- disable space
                        DisableControlAction(0,55,true) -- disable space
                    end
                else
                    if Getmenu_persoentWeight() > 30 then
                        TriggerEvent("Extasy:ShowNotification", "~r~[Attention]~s~~n~Vous ne pouvez pas avoir plus de poids !")
                        DisableControlAction(0,21,true) -- disable sprint
                        DisableControlAction(0,24,true) -- disable attack
                        DisableControlAction(0,25,true) -- disable aim
                        DisableControlAction(0,47,true) -- disable weapon
                        DisableControlAction(0,58,true) -- disable weapon
                        DisableControlAction(0,263,true) -- disable melee
                        DisableControlAction(0,264,true) -- disable melee
                        DisableControlAction(0,257,true) -- disable melee
                        DisableControlAction(0,140,true) -- disable melee
                        DisableControlAction(0,141,true) -- disable melee
                        DisableControlAction(0,142,true) -- disable melee
                        DisableControlAction(0,143,true) -- disable melee
                        DisableControlAction(0,18,true) -- disable space
                        DisableControlAction(0,22,true) -- disable space
                        DisableControlAction(0,55,true) -- disable space
                    end
                end
            end
        end
    end)

    local bagIndexInentaire = GetPedDrawableVariation(GetPlayerPed(-1), 5)

    if bagIndexInentaire == 26 or bagIndexInentaire == 27 or bagIndexInentaire == 28 or bagIndexInentaire == 22 or bagIndexInentaire == 12 or bagIndexInentaire == 10 or bagIndexInentaire == 11 then 
        playerGotBag = true
    else
        playerGotBag = false
    end
end)

-- Function
function GetPed() return GetPlayerPed(-1) end
function GetCar() return GetVehiclePedIsIn(GetPlayerPed(-1),false) end

F5_in_menu_perso = false

mask_anim = "missfbi4"
mask_anim_2 = "mp_masks@standard_car@ds@"
local faimVal = 0
local soifVal = 0
local PtfxNotif = false
local PtfxPrompt = false
local PtfxWait = 500
local PtfxNoProp = false
local PlayerLoaded   = false
local VeloDePoche = nil
local closestDistanceok = {RightBadge = RageUI.BadgeStyle.Lock}
local speeds_limit   = {
    "~p~Vitesse actuelle~s~",
    "~r~Désactiver~s~"
}
local speeds_limit_index = 1
local speed_limit_post = false

local inventory, weight, acc, firstspawn = {}, 0, {}, 0

local antispampai = true
Citizen.CreateThread(function()
  while true do
      antispampai = true
      Citizen.Wait(1000 * 10)
  end
end)

menu_perso = {
    ItemSelected = {},
    ItemSelected2 = {},
    WeaponData = {},
    menu_perso = false,
    Ped = GetPlayerPed(-1),
    money = nil,
    bank = nil,
    sale = nil,
    map = true,
    visual = false,
    visual2 = false,
    visual3 = false,
    visual5 = false,
    visual6 = false,
    visual7 = false,
    visual8 = false,
    demarches = {
		'Normal',
		'Femme',
		'Pouffiasse',
		'Dépressif',
		'Dépressive',
		'Musclor',
		'Hipster',
		'Business',
		'Intimide',
		'Bourrer',
		'Malheureux',
		'Triste',
		'Choc',
		'Sombre',
		'Fatiguer',
		'Presser',
		'Frimeur',
		'Fier',
		'Petite course',
		'Pupute',
		'Impertinente',
		'Arrogante',
		'Blesser',
		'Trop manger',
		'Casual',
		'Determiner',
		'Peureux',
		'Trop Swag',
		'Travailleur',
		'Brute',
		'Rando',
		'Gangstère',
		'Gangster'
    },
    list = 1,
    list2 = 1,
    Filtres = {'normal', 'améliorees', 'amplifiees', 'noir/blanc'},
}

menu_perso.got_neon = false
menu_perso.got_neon_c = false
menu_perso.index_item_give = 1
menu_perso.index_item_use = 1
menu_perso.index_item_drop = 1
menu_perso.hud = true
menu_perso.hud_car = true
menu_perso.cross_mode = true
kevlarNumb = nil
trash_search = false
menu_perso.shut_power = false

menu_perso.V = {
    VehPed = GetVehiclePedIsIn(GetPlayerPed(-1), false),
    Get = GetVehiclePedIsUsing(GetPlayerPed(-1)),
    agauche = false,
    argauche = false,
    adroite = false,
    ardroite = false,
    capot = false,
    test = false
}

menu_perso.leave_ok = false
menu_perso.demission_ok = false
menu_perso.maskData = {}
menu_perso.clothesData = {}
menu_perso.clothesData_ID = nil
menu_perso.maskConf = false
menu_perso.clothesConf = false
menu_perso.silenceTimeIndexSingle = 1

menu_perso.silenceTimeList = {
    "5 minutes",
    "10 minutes",
    "15 minutes",
    "20 minutes",
    "25 minutes",
    "30 minutes",
    "1 heure",
}
menu_perso.silenceTimeIndex = {
    5,
    10,
    15,
    20,
    25,
    30,
    60,
}

menu_perso.notifPosList = {
    "En bas à gauche",
    "En haut à gauche",
    "En bas à droite",
    "En haut à droite",
    "En bas au milieu",
    "En haut au milieu",
}
menu_perso.notifPosIndex = 1
menu_perso.notifPosListIndex = {
    "bottomleft",
    "topleft",
    "bottomright",
    "topright",
    "bottom",
    "top",
}

cartesim = {}
clevoiture = {}

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(money)
	  ESX.PlayerData.money = money
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RefreshMoney = function()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
			societymoney = ESX.Math.GroupDigits(money)
		end, ESX.PlayerData.job.name)
	end
    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
		ESX.TriggerServerCallback('esx_society:getSocietyMoney2', function(money)
			societymoney2 = ESX.Math.GroupDigits(money)
		end, ESX.PlayerData.job2.name)
	end
end

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    RMenu.Add('inventory', 'main', RageUI.CreateMenu("90's Life", "", 0,0))

    RMenu.Add('inventory', 'inventory', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Choix", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'inventaire', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Choix", "Que souhaitez-vous faire ?"))
    --RMenu.Add('inventory', 'weapon', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Inventaire", "Que souhaitez-vous faire ?"))
    --RMenu.Add('inventory', 'inventaire', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Inventaire", "Que souhaitez-vous faire ?"))
    --RMenu.Add('inventory', 'inventaire_use', RageUI.CreateSubMenu(RMenu:Get('inventory', 'inventaire'), "Inventaire", "Que souhaitez-vous faire ?"))
    --RMenu.Add('inventory', 'weapon_use', RageUI.CreateSubMenu(RMenu:Get('inventory', 'weapon'), "Inventaire", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'portefeuille', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Portefeuille", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'portefeuille_use', RageUI.CreateSubMenu(RMenu:Get('inventory', 'portefeuille'), "Portefeuille", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'portefeuille_money', RageUI.CreateSubMenu(RMenu:Get('inventory', 'portefeuille'), "Portefeuille", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'portefeuille_work', RageUI.CreateSubMenu(RMenu:Get('inventory', 'portefeuille'), "Emplois", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'portefeuille_work2', RageUI.CreateSubMenu(RMenu:Get('inventory', 'portefeuille'), "Emplois", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'portefeuille_papiers', RageUI.CreateSubMenu(RMenu:Get('inventory', 'portefeuille'), "Vos Papiers", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'divers', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Divers", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'divers_rockstar_editor', RageUI.CreateSubMenu(RMenu:Get('inventory', 'divers'), "Notifications", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'main_menu_settings_notifications', RageUI.CreateSubMenu(RMenu:Get('inventory', 'divers'), "Rockstar editor", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'animations', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Animations", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'visual', RageUI.CreateSubMenu(RMenu:Get('inventory', 'divers'), "Visuel", "Que souhaitez-vous faire ?"))
    --RMenu.Add('inventory', 'tserv', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Touches Serveur", "~p~Touches du serveur"))
    RMenu.Add('inventory', 'boss', RageUI.CreateSubMenu(RMenu:Get('inventory', 'portefeuille'), "Gestion d'entreprise", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'boss2', RageUI.CreateSubMenu(RMenu:Get('inventory', 'portefeuille'), "Gestion du gang", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'voiture', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Gestion Véhicule", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'animal', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Gestion Animales", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'vehicle_doors_menu', RageUI.CreateSubMenu(RMenu:Get('inventory', 'voiture'), "Véhicule", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'vehicle_limiter_menu', RageUI.CreateSubMenu(RMenu:Get('inventory', 'voiture'), "Véhicule", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'main_menu_clothes', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Vêtements", "Que voulez-vous faire ?"))
    RMenu.Add('inventory', 'main_menu_masks', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Masques", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'main_menu_masks_choose', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Masques", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'main_menu_clothes_choose', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Vêtements", "Que souhaitez-vous faire ?"))
    RMenu.Add('inventory', 'main_menu_list_valid_choose_player', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Inventaire", "À qui souhaitez-vous faire ceci ?"))

    RMenu.Add('inventory', 'pose', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Poses", "Liste des animations"))
    RMenu.Add('inventory', 'danse', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Danses", "Liste des animations"))
    RMenu.Add('inventory', 'actions', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Gestes", "Liste des animations"))
    RMenu.Add('inventory', 'autre', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Autres", "Liste des animations"))
    RMenu.Add('inventory', 'animationlist', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Animations", "Liste des animations"))

    RMenu:Get('inventory', 'main'):SetSubtitle("∑ Votre nom : ~p~".. GetPlayerName(PlayerId()) .. "~s~ - ID : ~p~".. GetPlayerServerId(PlayerId()) .. "")
    RMenu:Get('inventory', 'main').EnableMouse = false
    RMenu:Get('inventory', 'main').Closed = function()
        F5_in_menu_perso = false
    end

    RefreshMoney()

    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
        societymoney = ESX.Math.GroupDigits(money)
    end, society)
    while societymoney == nil do Wait(1) end

    menu_perso.WeaponData = ESX.GetWeaponList()

	for i = 1, #menu_perso.WeaponData, 1 do
		if menu_perso.WeaponData[i].name == 'WEAPON_UNARMED' then
			menu_perso.WeaponData[i] = nil
		else
			menu_perso.WeaponData[i].hash = GetHashKey(menu_perso.WeaponData[i].name)
		end
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(0)
    end

    while menu_perso.WeaponData == nil do
        Citizen.Wait(0)
    end
end)

giveCarKeys = function()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
        vehicle = GetVehiclePedIsIn(playerPed, false)			
    else
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
    end

	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)


	ESX.TriggerServerCallback('esx_givecarkeys:requestPlayerCars', function(isOwnedVehicle)
		if isOwnedVehicle then
		    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer == -1 or closestDistance > 3.0 then
                Extasy.ShowAdvancedNotification('CLES','~o~Hors de portée','Aucun joueur a proximité','CHAR_PEGASUS_DELIVERY',8)
            else
                Extasy.ShowAdvancedNotification('CLES','~g~Echange de clés','Vous donnez les clés du véhicule immatriculé ~g~'..vehicleProps.plate..'!','CHAR_PEGASUS_DELIVERY',8)
                TriggerServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId', token, GetPlayerServerId(closestPlayer), vehicleProps)
            end
		end
	end, GetVehicleNumberPlateText(vehicle))
end

RegisterNetEvent("esx_givecarkeys:keys")
AddEventHandler("esx_givecarkeys:keys", function()
	giveCarKeys()
end)

CheckQuantity = function(number)
  number = tonumber(number)

  if type(number) == 'number' then
    number = ESX.Math.Round(number)

    if number > 0 then
      return true, number
    end
  end

  return false, number
end

KeyboardInputF5 = function(one, two, max)
	playerIsOnKeyBoard = true
	local result = nil
    AddTextEntry("FMMC_KEY_TIP", one)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP", "", two, "", "", "", max)

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

	if UpdateOnscreenKeyboard() ~= 2 then
		playerIsOnKeyBoard = false
        result = GetOnscreenKeyboardResult()
        Citizen.Wait(1)
    else
        Citizen.Wait(1)
    end

    return result
end

RegisterNetEvent('Extasy:Weapon_addAmmoToPedC')
AddEventHandler('Extasy:Weapon_addAmmoToPedC', function(value, quantity)
  local weaponHash = GetHashKey(value)

    if HasPedGotWeapon(PlayerPed, weaponHash, false) and value ~= 'WEAPON_UNARMED' then
        AddAmmoToPed(PlayerPed, value, quantity)
    end
end)

plyPed = PlayerPedId()

openInvPlayer = function()
    if F5_in_menu_perso then
        F5_in_menu_perso = false
        return
    else
        while societymoney == nil do Wait(1) end

        Extasy.refreshMenu()
        TriggerServerEvent("Extasy:sendAllMasksFromPlayer", token)
        TriggerServerEvent("Extasy:sendAllClothesFromPlayer", token)
        Wait(1)
        if playerMasksData == nil then
            Extasy.ShowNotification("~b~Chargement de vos données...")
            return
        end

        F5_in_menu_perso = true
        RageUI.Visible(RMenu:Get('inventory', 'main'), true)

        Citizen.CreateThread(function()
            while F5_in_menu_perso do

                ----------------------------------------------------------------------------------

                RageUI.IsVisible(RMenu:Get('inventory', 'main'), true, true, true, function() 

                        --[[RageUI.ButtonWithStyle("Inventaire", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                            if Selected then
                                Extasy.refreshMenu()
                            end
                        end, RMenu:Get('inventory', 'inventaire'))--]]

                        RageUI.ButtonWithStyle("Portefeuille", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                        end, RMenu:Get('inventory', 'portefeuille'))

                        --[[RageUI.ButtonWithStyle("Gestion des Armes", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                        end, RMenu:Get('inventory', 'weapon'))--]]

                        RageUI.ButtonWithStyle("Animations", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                            if Selected then
                                OpenEmotesMenu()
                            end
                        end)

                        --RageUI.ButtonWithStyle("Carte-SIM", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                        --end, RMenu:Get('inventory', 'sim'))

                        --RageUI.ButtonWithStyle("Clé(s)", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                        --end, RMenu:Get('inventory', 'key'))

                        RageUI.Button("Mes vêtements", nil, {}, true, function(h, a, s)
                            if s then
                                TriggerServerEvent('TattooShop:requestPlayerTatoos', token)
                            end
                        end, RMenu:Get('inventory', 'main_menu_clothes'))

                        RageUI.ButtonWithStyle("Divers", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                        end, RMenu:Get('inventory', 'divers'))

                    if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                        RageUI.ButtonWithStyle("Gestion Véhicule", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                        end, RMenu:Get('inventory', 'voiture'))                       
                    else
                        RageUI.ButtonWithStyle('Gestion Véhicule', description, {RightBadge = RageUI.BadgeStyle.Lock }, false, function(Hovered, Active, Selected)
                            if (Selected) then
                            end 
                        end)
                    end

                    if HavePet ~= '' then
                        RageUI.ButtonWithStyle('Gestion Animal', nil, {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                openPetMenu()
                                F5_in_menu_perso = false
                            end 
                        end)                 
                    end

                    if not menu_perso.leave_ok then
                        RageUI.Button("~r~Sauvegarder et quitter", "Déconnectez-vous sans crainte, le serveur sauvegardera automatiquement vos données", {}, true, function(Hovered, Active, Selected) if Selected then menu_perso.leave_ok = true end end)
                    else
                        RageUI.Button("~r~Sauvegarder et quitter", "Déconnectez-vous sans crainte, le serveur sauvegardera automatiquement vos données", {RightLabel = "~r~Confirmez"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                --ESX.SavePlayer()
                                TriggerServerEvent("Extasy:KickPlayer", token, GetPlayerServerId(PlayerId()), "🍹 Merci d'être passé ! Vos données ont bien été sauvegardées, à bientôt sur 90's Life !")
                            end
                        end)
                    end

                    end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'main_menu_clothes'), true, true, true, function()
        
                    RageUI.Button("Enlever/mettre son chapeau/masque/casque", nil, {}, true, function(h, a, s)
                        if s then
                            if playerIsDead then
                                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
                            else
                                RequestAnimDict("missfbi4")
                                TaskPlayAnim(PlayerPedId(), "missfbi4", "takeoff_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                                Wait(400)
                                ClearPedSecondaryTask(PlayerPedId())
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    if not lastPlayersData.putMask then
                                        lastPlayersData.putMask = true
                                        local d = {
                                            ['mask_1'] = 0, ['mask_2'] = 0,
                                            ['helmet_1'] = -1, ['helmet_2'] = -1
                                        }
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    else
                                        lastPlayersData.putMask = false
                                        local d = {
                                            ['mask_1'] = skin.mask_1, ['mask_2'] = skin.mask_2,
                                            ['helmet_1'] = skin.helmet_1, ['helmet_2'] = skin.helmet_2
                                        }
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    end
                                end)
                            end
                        end
                    end)

                    RageUI.Button("Enlever/mettre son haut", nil, {}, true, function(h, a, s)
                        if s then
                            if playerIsDead then
                                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
                            else
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    if not lastPlayersData.putShirt then
                                        lastPlayersData.putShirt = true
                                        local d = {
                                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                                            ['torso_1'] = 15, ['torso_2'] = 0,
                                            ['arms'] = 15, ['arms_2'] = 0
                                        }
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    else
                                        lastPlayersData.putShirt = false
                                        local d = {
                                            ['tshirt_1'] = playerSkin.tshirt_1, ['tshirt_2'] = playerSkin.tshirt_2,
                                            ['torso_1'] = playerSkin.torso_1, ['torso_2'] = playerSkin.torso_2,
                                            ['arms'] = playerSkin.arms, ['arms_2'] = playerSkin.arms_2
                                        }
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    end
                                end)
                            end
                        end
                    end)

                    RageUI.Button("Enlever/mettre son bas", nil, {}, true, function(h, a, s)
                        if s then
                            if playerIsDead then
                                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
                            else
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    if not lastPlayersData.putPants then
                                        lastPlayersData.putPants = true
                                        local d = {
                                            ['pants_1'] = 14, ['pants_2'] = 0,
                                        }
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    else
                                        lastPlayersData.putPants = false
                                        local d = {
                                            ['pants_1'] = playerSkin.pants_1, ['pants_2'] = playerSkin.pants_2,
                                        }
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    end
                                end)
                            end
                        end
                    end)
                    RageUI.Button("Enlever/mettre ses chaussures", nil, {}, true, function(h, a, s)
                        if s then
                            if playerIsDead then
                                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
                            else
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    if not lastPlayersData.putPants then
                                        lastPlayersData.putPants = true
                                        local d = {}
                                        if playerIsMale then
                                            d = {
                                                ['shoes_1'] = 54, ['shoes_2'] = 0
                                            }
                                        else
                                            d = {
                                                ['shoes_1'] = 54, ['shoes_2'] = 0
                                            }
                                        end
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    else
                                        lastPlayersData.putPants = false
                                        local d = {
                                            ['shoes_1'] = playerSkin.shoes_1, ['shoes_2'] = playerSkin.shoes_2,
                                        }
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    end
                                end)
                            end
                        end
                    end)

                    RageUI.Button("Se déshabiller/rhabiller", nil, {}, true, function(h, a, s)
                        if s then
                            if playerIsDead then
                                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
                            else
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    if not lastPlayersData.putAllCl then
                                        lastPlayersData.putAllCl = true
                                        local d = {}
                                        if playerIsMale then
                                            d = {
                                                ['mask_1'] = 0, ['mask_2'] = 0,
                                                ['helmet_1'] = -1, ['helmet_2'] = -1,
                                                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                                                ['torso_1'] = 15, ['torso_2'] = 0,
                                                ['arms'] = 15, ['arms_2'] = 0,
                                                ['pants_1'] = 14, ['pants_2'] = 0,
                                                ['shoes_1'] = 49, ['shoes_2'] = 0
                                            }
                                        else
                                            d = {
                                                ['mask_1'] = 0, ['mask_2'] = 0,
                                                ['helmet_1'] = -1, ['helmet_2'] = -1,
                                                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                                                ['torso_1'] = 15, ['torso_2'] = 0,
                                                ['arms'] = 15, ['arms_2'] = 0,
                                                ['pants_1'] = 15, ['pants_2'] = 0,
                                                ['shoes_1'] = 49, ['shoes_2'] = 0
                                            }
                                        end
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    else
                                        lastPlayersData.putAllCl = false
                                    
                                        TriggerEvent("skinchanger:loadPlayerSkin", playerSkin)
                                    end      
                                end)
                                --for i = 1, #playerTattoos, 1 do
                                    --ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(playerTattoos[i].collection), GetHashKey(cfg_tattoos.tattoosList[playerTattoos[i].collection][playerTattoos[i].texture].nameHash))
                                --end
                            end
                        end
                    end)
                
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'voiture'), true, true, true, function()local pPed = PlayerPedId()
                    local pVeh = GetVehiclePedIsUsing(pPed)
                    local vModel = GetEntityModel(pVeh)
                    local vName = GetDisplayNameFromVehicleModel(vModel)
                    local vPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(pPed), false)
                    GetSourcevehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    Vengine = GetVehicleEngineHealth(GetSourcevehicle)/10
                    local Vengine2 = math.floor(Vengine)

                    if IsPedSittingInAnyVehicle(pPed) then
                        RageUI.Separator("Nom du véhicule - ~p~"..vName)
                        RageUI.Separator("Plaque - ~p~"..vPlate)
                        RageUI.Separator("Etat du moteur - ~p~"..Vengine2.."%")
                    else
                        RageUI.GoBack()
                    end
                    
                    RageUI.Separator("")
                    RageUI.Checkbox("Arrêter / Démarrer le moteur", nil, checkbox,{},function(_,_,s,c)
                        if s then
                            checkbox = c
                            if c then
                                c = true
                                SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), 0), 0, 0, 1);
                                SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId(), 0), 1);
                            else
                                c = false
                                SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), 0), 1, 0, 1);
                                SetVehicleUndriveable(GetVehiclePedIsIn(PlayerPedId(), 0), 0);
                            end
                        end
                    end)
                    RageUI.ButtonWithStyle("Options du limitateur", nil, {RightLabel = "→"}, true, function(_,_,s)
                        if s then
                        end
                    end, RMenu:Get('inventory', 'vehicle_limiter_menu'))
                    RageUI.ButtonWithStyle("Portes du véhicule", nil, {RightLabel = "→"}, true, function(_,_,s)
                        if s then
                        end
                    end, RMenu:Get('inventory', 'vehicle_doors_menu'))
                    RageUI.List("Gestion vitres", self.windowVehList, self.windowVehIndex, nil, {}, true, function(_,a,s,index)
                        self.windowVehIndex = index;
                        if a then
                            if index == 1 then
                                if s then
                                    RollDownWindows(GetVehiclePedIsIn(PlayerPedId(), true));
                                end
                            else
                                if index == 2 then
                                    if s then
                                        for i = 0,7,1 do
                                            RollUpWindow(GetVehiclePedIsIn(PlayerPedId(), true), i);
                                            FixVehicleWindow(GetVehiclePedIsIn(PlayerPedId(), true), i);
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    if GetEntitySpeed(GetVehiclePedIsIn(PlayerPedId(), false))*3.6 < 1.0 then
                        RageUI.ButtonWithStyle("Sortir du véhicule moteur allumé", nil, {RightLabel = "→"}, true, function(_,_,s)
                            if s then
                                local pCoords = GetEntityCoords(PlayerPedId());
                                SetEntityCoords(PlayerPedId(), pCoords.x-0.7, pCoords.y-0.7, pCoords.z);
                                RageUI:GoBack();
                            end
                        end)
                    else
                        RageUI.ButtonWithStyle("Sortir du véhicule moteur allumé", nil, {RightLabel = "→"}, false, function()
                        end)
                    end

                    end,function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'voiture_porte'), true, true, true, function()

                    RageUI.ButtonWithStyle("Ouvrir/Fermer Avant Gauche", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                                SetVehicleDoorOpen(menu_perso.V.VehPed, 0, menu_perso.V.agauche)
                                    menu_perso.V.agauche = not menu_perso.V.agauche
                                end
                            end)

                    RageUI.ButtonWithStyle("Ouvrir/Fermer Avant Droite", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                            if not menu_perso.V.adroite then
                                menu_perso.V.adroite = true
                                SetVehicleDoorOpen(menu_perso.V.VehPed, 1, false, false)
                            elseif menu_perso.V.adroite then
                                menu_perso.V.adroite = false
                                SetVehicleDoorShut(menu_perso.V.VehPed, 1, false, false)
                                end
                            end
                        end)

                    RageUI.ButtonWithStyle("Ouvrir/Fermer Ariére Gauche", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                            if not menu_perso.V.argauche then
                                menu_perso.V.argauche = true
                                SetVehicleDoorOpen(menu_perso.V.VehPed, 2, false, false)
                            elseif menu_perso.V.argauche then
                                menu_perso.V.argauche = false
                                SetVehicleDoorShut(menu_perso.V.VehPed, 2, false, false)
                                end
                            end
                        end)

                    RageUI.ButtonWithStyle("Ouvrir/Fermer Ariére Droite", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                            if not menu_perso.V.ardroite then
                                menu_perso.V.ardroite = true
                                SetVehicleDoorOpen(menu_perso.V.VehPed, 3, false, false)
                            elseif menu_perso.V.ardroite then
                                menu_perso.V.ardroite = false
                                SetVehicleDoorShut(menu_perso.V.VehPed, 3, false, false)
                                end
                            end
                        end)

                        RageUI.ButtonWithStyle("Ouvrir/Fermer Capot", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected) 
                            if Selected then
                                if not menu_perso.V.capot then
                                    menu_perso.V.capot = true
                                    SetVehicleDoorOpen(menu_perso.V.VehPed, 4, false, false)
                                elseif menu_perso.V.capot then
                                    menu_perso.V.capot = false
                                    SetVehicleDoorShut(menu_perso.V.VehPed, 4, false, false)
                                    end
                                end
                            end)
                    end,function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'vehicle_limiter_menu'), true, true, true, function()
                    RageUI.Separator("~p~← Actions limitateur →")
                    RageUI.ButtonWithStyle("Vitesse -~b~ Par défaut", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 1000.0/3.6);
                        end
                    end)
                    RageUI.ButtonWithStyle("Vitesse -~g~ 30 km/h", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 29.9/3.6);
                        end
                    end)
                    RageUI.ButtonWithStyle("Vitesse -~g~ 50 km/h", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 49.9/3.6);
                        end
                    end)
                    RageUI.ButtonWithStyle("Vitesse -~g~ 80 km/h", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 79.9/3.6);
                        end
                    end)
                    RageUI.ButtonWithStyle("Vitesse -~g~ 120 km/h", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 119.9/3.6);
                        end
                    end)
                    RageUI.ButtonWithStyle("Vitesse -~g~ 150 km/h", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 149.9/3.6);
                        end
                    end)
                    RageUI.ButtonWithStyle("Vitesse -~g~ 180 km/h", nil, {RightBadge = RageUI.BadgeStyle.Car}, true, function(_,_,s)
                        if s then
                            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 179.9/3.6);
                        end
                    end)
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'vehicle_doors_menu'), true, true, true, function()
                    RageUI.List("Actions sur toutes les portes", self.doorStatusList, self.doorStatusIndex, nil, {RightLabel = nil}, true, function(_,_,s,i)
                        self.doorStatusIndex = i;
                        if s then
                            if i == 1 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 0, 0, 0);
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 1, 0, 0);
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 2, 0, 0);
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 3, 0, 0);
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 4, 0, 0);
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 5, 0, 0);
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 6, 0, 0);
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 7, 0, 0);
                            elseif i == 2 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 0, 0, 0);
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 1, 0, 0);
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 2, 0, 0);
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 3, 0, 0);
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 4, 0, 0);
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 5, 0, 0);
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 6, 0, 0);
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 7, 0, 0);
                            end
                        end
                    end)
                    RageUI.List("Ouverture des portes", self.doorOpenList, self.doorOpenIndex, nil, {RightLabel = nil}, true, function(_,a,s,i)
                        self.doorOpenIndex = i;
                        if s then
                            if i == 1 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 1, 0, 0);
                            elseif i == 2 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 0, 0, 0);
                            elseif i == 3 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 3, 0, 0);
                            elseif i == 4 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 2, 0, 0);
                            end
                        end
                    end)
                    RageUI.List("Fermeture des portes", self.doorCloseList, self.doorCloseIndex, nil, {RightLabel = nil}, true, function(_,_,s,i)
                        self.doorCloseIndex = i;
                        if s then
                            if i == 1 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 1, 0, 0);
                            elseif i == 2 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 0, 0, 0);
                            elseif i == 3 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 3, 0, 0);
                            elseif i == 4 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 2, 0, 0);
                            end
                        end
                    end)
                    RageUI.List("Capot", self.hoodVehList, self.hoodVehIndex, nil, {RightLabel = nil}, true, function(_,_,s,i)
                        self.hoodVehIndex = i;
                        if s then
                            if i == 1 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 4, 0, 0);
                            elseif i == 2 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 4, 0, 0);
                            end
                        end
                    end)
                    RageUI.List("Coffre du véhicule", self.trunkVehList, self.trunkVehIndex, nil, {RightLabel = nil}, true, function(_,_,s,i)
                        self.trunkVehIndex = i;
                        if s then
                            if i == 1 then
                                SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), 0), 5, 0, 0);
                            elseif i == 2 then
                                SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), 0), 5, 0, 0);
                            end
                        end
                    end)
                end)

                ----------------------------------------------------------------------------------

                --[[RageUI.IsVisible(RMenu:Get('inventory', 'inventaire'), true, true, true, function()

                    RageUI.SliderProgress2("Nutrition", faimF5, 100, nil, {
                        ProgressColor = { R = 255, G = 187, B = 51, A = 255 },
                        ProgressBackgroundColor = { R = 214, G = 143, B = 0, A = 255 },
                    }, true, {})
                    RageUI.SliderProgress2("Hydratation", soifF5, 100, nil, {
                        ProgressColor = { R = 51, G = 190, B = 255, A = 255 },
                        ProgressBackgroundColor = { R = 0, G = 145, B = 213, A = 255 },
                    }, true, {})

                    local bagIndexInentaire = GetPedDrawableVariation(GetPlayerPed(-1), 5)

                    if bagIndexInentaire == 26 or bagIndexInentaire == 27 or bagIndexInentaire == 28 or bagIndexInentaire == 22 or bagIndexInentaire == 12 or bagIndexInentaire == 10 or bagIndexInentaire == 11 then 
                        playerGotBag = true
                    else
                        playerGotBag = false
                    end

                    if playerGotBag then
                        RageUI.Separator("~p~Votre Inventaire~s~ ".. Getmenu_persoentWeight().." / 50 KG (sac à dos)")
                    else
                        RageUI.Separator("~p~Votre Inventaire~s~ ".. Getmenu_persoentWeight().." / 30 KG")
                    end

                    for k,v in pairs(playerMasksData) do
                        if #playerMasksData > 0 then
                            RageUI.Button("Masque "..v.label.."", nil, {}, true, function(h, a, s)
                                if s then
                                    menu_perso.maskData.ma_1  = tonumber(v.data.mask_1)
                                    menu_perso.maskData.ma_2  = tonumber(v.data.mask_2)
                                    menu_perso.maskData.ma_3  = tonumber(v.data.mask_3)
                                    menu_perso.maskData.ma_ID = tonumber(v.id)
                                end
                            end, RMenu:Get('inventory', 'main_menu_masks_choose'))
                        end
                    end

                    for k,v in pairs(playerClothesData) do
                        if #playerClothesData > 0 then
                            RageUI.Button("Tenue "..v.label.."", nil, {}, true, function(h, a, s)
                                if s then
                                    menu_perso.clothesData  = v.data
                                    menu_perso.clothesData_ID = tonumber(v.id)
                                end
                            end, RMenu:Get('inventory', 'main_menu_clothes_choose'))
                        end
                    end

                    ESX.PlayerData = ESX.GetPlayerData()
                    for i = 1, #ESX.PlayerData.inventory do
                        if ESX.PlayerData.inventory[i].count > 0 then
                            RageUI.ButtonWithStyle(ESX.PlayerData.inventory[i].label.." ("..ESX.PlayerData.inventory[i].count..")", nil, {RightLabel = "→"}, true, function(h, a, s) 
                                if s then 
                                    menu_perso.ItemSelected = ESX.PlayerData.inventory[i]
                                    end 
                                end, RMenu:Get('inventory', 'inventaire_use'))
                            end
                        end
                    end)

                ----------------------------------------------------------------------------------

                RageUI.IsVisible(RMenu:Get('inventory', 'weapon'), true, true, true, function() 
                    ESX.PlayerData = ESX.GetPlayerData()
                    ESX.PlayerData.loadout = ESX.GetWeaponList()
                    --menu_perso.WeaponData = ESX.GetWeaponList()
                    for i = 1, #menu_perso.WeaponData, 1 do
                        if HasPedGotWeapon(GetPlayerPed(-1), menu_perso.WeaponData[i].hash, false) then
                            local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), menu_perso.WeaponData[i].hash)
            
                            RageUI.ButtonWithStyle('[' ..ammo.. '] - ~s~' ..menu_perso.WeaponData[i].label, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    menu_perso.ItemSelected = menu_perso.WeaponData[i]
                                end
                            end,RMenu:Get('inventory', 'weapon_use'))
                        end
                    end
                end)

                ----------------------------------------------------------------------------------

                RageUI.IsVisible(RMenu:Get('inventory', 'weapon_use'), true, true, true, function() 
                    RageUI.ButtonWithStyle('Donner des munitions', nil, {RightBadge = RageUI.BadgeStyle.Ammo}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local post, quantity = CheckQuantity(KeyboardInputF5('Nombre de munitions', '180'), '', 8)
    
                            if post then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    local pPed = GetPlayerPed(-1)
                                    local coords = GetEntityCoords(pPed)
                                    local x,y,z = table.unpack(coords)
                                    DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
    
                                    if IsPedOnFoot(closestPed) then
                                        local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), menu_perso.ItemSelected.hash)
    
                                        if ammo > 0 then
                                            if quantity <= ammo and quantity >= 0 then
                                                local finalAmmo = math.floor(ammo - quantity)
                                                SetPedAmmo(GetPlayerPed(-1), menu_perso.ItemSelected.name, finalAmmo)
    
                                                TriggerServerEvent('Extasy:Weapon_addAmmoToPedS', GetPlayerServerId(closestPlayer), menu_perso.ItemSelected.name, quantity)
                                                Extasy.ShowNotification('Vous avez donné x%s munitions à %s', quantity, GetPlayerName(closestPlayer))
                                                --RageUI.CloseAll()
                                            else
                                                Extasy.ShowNotification('Vous ne possédez pas autant de munitions')
                                            end
                                        else
                                            Extasy.ShowNotification("Vous n'avez pas de munition")
                                        end
                                    else
                                        Extasy.ShowNotification('Vous ne pouvez pas donner des munitions dans un ~~r~véhicule~s~', menu_perso.ItemSelected.label)
                                    end
                                else
                                    Extasy.ShowNotification('Aucun joueur ~r~proche~s~ !')
                                end
                            else
                                Extasy.ShowNotification('Nombre de munition ~r~invalid')
                            end
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Jeter l'arme", nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, function(Hovered, Active, Selected)
                        if Selected then
                            if IsPedOnFoot(GetPlayerPed(-1)) then
                                TriggerServerEvent('esx:removeInventoryItem', 'item_weapon', menu_perso.ItemSelected.name)
                                --RageUI.CloseAll()
                            else
                                Extasy.ShowNotification("~r~Impossible~s~ de jeter l'armes dans un véhicule", menu_perso.ItemSelected.label)
                            end
                        end
                    end)

                    if HasPedGotWeapon(GetPlayerPed(-1), menu_perso.ItemSelected.hash, false) then
                        RageUI.ButtonWithStyle("Donner l'arme", nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                            if closestDistance ~= -1 and closestDistance <= 3 then
                                local closestPed = GetPlayerPed(closestPlayer)
                                local pPed = GetPlayerPed(-1)
                                local coords = GetEntityCoords(pPed)
                                local x,y,z = table.unpack(coords)
                                DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
    
                                if IsPedOnFoot(closestPed) then
                                    local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), menu_perso.ItemSelected.hash)
                                    TriggerServerEvent('esx:donneItem', GetPlayerServerId(closestPlayer), 'item_weapon', menu_perso.ItemSelected.name, ammo)
                                    ExecuteCommand("me donne une arme ("..menu_perso.ItemSelected.label..")")
                                    ExecuteCommand("e keyfob")
                                    --seAll()
                                else
                                    Extasy.ShowNotification('~r~Impossible~s~ de donner une arme dans un véhicule', menu_perso.ItemSelected.label)
                                end
                            else
                                Extasy.ShowNotification('Aucun joueur ~r~proche !')
                            end
                        end
                    end)
                end

                    end,function()
                end)--]]


                ----------------------------------------------------------------------------------

                RageUI.IsVisible(RMenu:Get('inventory', 'main_menu_list_valid_choose_player'), true, true, true, function()
        
                    for _, player in ipairs(GetActivePlayers()) do
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                        local coords = GetEntityCoords(GetPlayerPed(player))
                        local name = replaceTextF5(player)
                        local sta = Extasy.IsMyId(player)
                        -- sta = 'lol'
        
                        if dst < 3.0 then
                            if sta ~= "me" then
                                RageUI.Button("#".._.." "..name, nil, {}, true, function(h, a, s)
                                    if a then
                                        DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                    end
                                    if s then
                                        if menu_perso.type == 'identity_show' then
                                            TriggerServerEvent("identity:showToPlayer", token, GetPlayerServerId(player), playerIdentity)
                                            RageUI.GoBack()
                                        elseif menu_perso.type == 'car_licence_show' then
                                            TriggerServerEvent("car_licence:showToPlayer", token, GetPlayerServerId(player), playerIdentity)
                                            RageUI.GoBack()
                                        elseif menu_perso.type == 'bike_licence_show' then
                                            TriggerServerEvent("bike_licence:showToPlayer", token, GetPlayerServerId(player), playerIdentity)
                                            RageUI.GoBack()
                                        elseif menu_perso.type == 'truck_licence_show' then
                                            TriggerServerEvent("truck_licence:showToPlayer", token, GetPlayerServerId(player), playerIdentity)
                                            RageUI.GoBack()
                                        elseif menu_perso.type == 'boat_licence_show' then
                                            TriggerServerEvent("boat_licence:showToPlayer", token, GetPlayerServerId(player), playerIdentity)
                                            RageUI.GoBack()
                                        elseif menu_perso.type == 'ppa_show' then
                                            TriggerServerEvent("license_ppa:showToPlayer", token, GetPlayerServerId(player), playerIdentity)
                                            RageUI.GoBack()
                                        elseif menu_perso.type == 'badge_show' then
                                            Citizen.CreateThread(function()
                                                Extasy.StartBadgeAnim()
                                            end)
                                            local playersInArea = Extasy.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 30.0)
                                            local inAreaData = {}

                                            for i=1, #playersInArea, 1 do
                                                table.insert(inAreaData, GetPlayerServerId(playersInArea[i]))
                                            end

                                            --if playerJob ~= "weazelnews" then
                                                --TriggerServerEvent("eCore:setupMeTxt", token, " montre son matricule", inAreaData)
                                            --else
                                                --TriggerServerEvent("eCore:setupMeTxt", token, " montre son badge", inAreaData)
                                            --end
                                            Wait(2500)
                                            --TriggerServerEvent("badge:showToPlayer", token, GetPlayerServerId(player), {prenom=menu_perso.args.prenom, nom=menu_perso.args.nom}, menu_perso.args.matricule, string.upper(playerJob))
                                            RageUI.GoBack()
                                        else
                                            local playersInArea = Extasy.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 30.0)
                                            local inAreaData = {}

                                            for i=1, #playersInArea, 1 do
                                                table.insert(inAreaData, GetPlayerServerId(playersInArea[i]))
                                            end

                                            TriggerServerEvent("core:setupMeTxt", token, " vient de donner quelque chose", inAreaData)

                                            if menu_perso.name == 'Masque' or menu_perso.name == 'Tenue' then
                                                Extasy.CheckThisWearItem(menu_perso.args)
                                            end

                                            --TriggerServerEvent("rF:TransferItemIfTargetCanHoldIt", token, GetPlayerServerId(player), menu_perso.name, menu_perso.index_item_give, menu_perso.label, menu_perso.count, menu_perso.args, menu_perso.itemId)
                                            menu_perso.index_item_give = 1
                                            RageUI.GoBack()
                                        end
                                    end
                                end)  
                            end
                        end
                    end
                
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'inventaire_use'), true, true, true, function()

                    if menu_perso.ItemSelected.name == "CarteID" then
                        RageUI.Button("Voir", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                Extasy.ShowAdvancedNotification("Carte d'identité", "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Âge: ~s~"..playerIdentity.age.."\n~p~Taille: ~s~"..playerIdentity.taille.."\n~p~Sexe: ~s~"..playerIdentity.sexe, "CHAR_PREF")
                                RageUI.GoBack()
                            end
                        end)
                        RageUI.Button("Montrer à quelqu'un", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                menu_perso.type = "identity_show"
                                RageUI.CloseAll()
                                F5_in_menu_perso = false
                                Wait(1)
                                RageUI.Visible(RMenu:Get('inventory', 'main_menu_list_valid_choose_player'), true)
                            end
                        end)
                    elseif menu_perso.ItemSelected.name == "Permis_voiture" then
                        RageUI.Button("Voir", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                Extasy.ShowAdvancedNotification("Permis de conduire (voiture)", "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Âge: ~s~"..playerIdentity.age.."\n~p~Taille: ~s~"..playerIdentity.taille.."\n~p~Sexe: ~s~"..playerIdentity.sexe, "CHAR_PREF")
                                RageUI.GoBack()
                            end
                        end)
                        RageUI.Button("Montrer à quelqu'un", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                menu_perso.type = "car_licence_show"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('inventory', 'main_menu_list_valid_choose_player'), true)
                            end
                        end)
                    elseif menu_perso.ItemSelected.name == "Permis_moto" then
                        RageUI.Button("Voir", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                Extasy.ShowAdvancedNotification("Permis de conduire (moto)", "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Âge: ~s~"..playerIdentity.age.."\n~p~Taille: ~s~"..playerIdentity.taille.."\n~p~Sexe: ~s~"..playerIdentity.sexe, "CHAR_PREF")
                                RageUI.GoBack()
                            end
                        end)
                        RageUI.Button("Montrer à quelqu'un", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                menu_perso.type = "bike_licence_show"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('inventory', 'main_menu_list_valid_choose_player'), true)
                            end
                        end)
                    elseif menu_perso.ItemSelected.name == "Permis_arme" then
                        RageUI.Button("Voir", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                Extasy.ShowAdvancedNotification("Permis port d'arme", "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Âge: ~s~"..playerIdentity.age, "CHAR_PREF")
                                RageUI.GoBack()
                            end
                        end)
                        RageUI.Button("Montrer à quelqu'un", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                menu_perso.type = "ppa_show"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('inventory', 'main_menu_list_valid_choose_player'), true)
                            end
                        end)
                    elseif menu_perso.ItemSelected.name == "Permis_bateau" then
                        RageUI.Button("Voir", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                Extasy.ShowAdvancedNotification("Permis Bateau", "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Âge: ~s~"..playerIdentity.age, "CHAR_PREF")
                                RageUI.GoBack()
                            end
                        end)
                        RageUI.Button("Montrer à quelqu'un", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                menu_perso.type = "boat_licence_show"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('inventory', 'main_menu_list_valid_choose_player'), true)
                            end
                        end)
                    elseif menu_perso.ItemSelected.name == "Badge" then
                        RageUI.Button("Voir", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                Extasy.ShowAdvancedNotification("Badge "..string.upper(playerJob), "Préfecture", "~p~Prénom: ~s~"..menu_perso.args.prenom.."\n~p~Nom: ~s~"..menu_perso.args.nom.."\n~p~Matricule: ~s~"..menu_perso.args.matricule, "CHAR_PREF")
                                RageUI.GoBack()
                            end
                        end)
                        RageUI.Button("Montrer à quelqu'un", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                menu_perso.type = "badge_show"
                                RageUI.CloseAll()
                                Wait(1)
                                RageUI.Visible(RMenu:Get('inventory', 'main_menu_list_valid_choose_player'), true)
                            end
                        end)
                    else
                        if string.sub(menu_perso.ItemSelected.name, 1, string.len("Balle")) == "Balle" then
                            RageUI.List("Équiper", invCount, menu_perso.index_item_use, nil, {}, true, function(h, a, s, Index)
                                menu_perso.index_item_use = Index
                                if s then
                                    for i = 1, menu_perso.index_item_use, 1 do
                                        TriggerEvent("ammunation:useMunition", menu_perso.ItemSelected.name, menu_perso.ItemSelected.name)
                                        RageUI.GoBack()
                                    end
                                end
                            end, function(Index, menu_persoentItems)
                            end)
                        else
                            RageUI.ButtonWithStyle("Utiliser", nil, {RightBadge = RageUI.BadgeStyle.Heart}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    if menu_perso.ItemSelected.usable then
                                        TriggerServerEvent('esx:useItem', menu_perso.ItemSelected.name)
                                        RageUI.GoBack()
                                    else
                                        Extasy.ShowNotification('l\'items n\'est pas utilisable', menu_perso.ItemSelected.label)
                                    end
                                end
                            end) 
    
                            RageUI.ButtonWithStyle("Jeter", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    if menu_perso.ItemSelected.canRemove then
                                        local post,quantity = CheckQuantity(KeyboardInputF5("Nombres d'items que vous souhaitez jeter", '', '', 100))
                                        if post then
                                            if not IsPedSittingInAnyVehicle(PlayerPed) then
                                                TriggerServerEvent('esx:removeInventoryItem', 'item_standard', menu_perso.ItemSelected.name, quantity)
                                                ExecuteCommand("me dépose un objet au sol.")
                                                ExecuteCommand("e pickup")
                                            end
                                        end
                                    end
                                end
                            end)
    
                            RageUI.ButtonWithStyle("Donner", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    local sonner,quantity = CheckQuantity(KeyboardInputF5("Nombres d'items que vous souhaitez donner", '', '', 100))
                                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                    local pPed = GetPlayerPed(-1)
                                    local coords = GetEntityCoords(pPed)
                                    local x,y,z = table.unpack(coords)
                                    DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
                
                                    if sonner then
                                        if closestDistance ~= -1 and closestDistance <= 3 then
                                            local closestPed = GetPlayerPed(closestPlayer)
                
                                            if IsPedOnFoot(closestPed) then
                                                TriggerServerEvent('esx:donneItem', GetPlayerServerId(closestPlayer), 'item_standard', menu_perso.ItemSelected.name, quantity)
                                                ExecuteCommand("e keyfob")
                                                ExecuteCommand("me lui donne quelque chose...")
                                            else
                                                Extasy.ShowNotification("~∑~ Nombres d'items invalid !")
                                            end
                                        else
                                            Extasy.ShowNotification("∑ Aucun joueur ~r~Proche~n~ !")
                                        end
                                    end
                                end
                            end)
                        end
                    end

                    end,function()
                    end)
                ----------------------------------------------------------------------------------

                RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille'), true, true, true, function()
                    ESX.PlayerData = ESX.GetPlayerData()
                    ESX.GetPlayerData()

                    RageUI.ButtonWithStyle("Votre emplois:", nil, {RightLabel = "~b~"..ESX.PlayerData.job.label .."~s~ →"}, true, function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end, RMenu:Get('inventory', 'portefeuille_work'))

                    RageUI.ButtonWithStyle("Votre gang:", nil, {RightLabel = "~r~"..ESX.PlayerData.job2.label .."~s~ →"}, true, function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end, RMenu:Get('inventory', 'portefeuille_work2'))

                    RageUI.ButtonWithStyle('Crée une facture:', nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            cl_openFactureMenu()
                            F5_in_menu_perso = false
                        end
                    end)

                    --[[RageUI.ButtonWithStyle("Vos papiers:", description, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            end
                        end, RMenu:Get('inventory', 'portefeuille_papiers'))--]]

                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == 'money'  then
                            RageUI.ButtonWithStyle('Argents liquide:', description, {RightLabel = "~g~$"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money.."~s~ →")}, true, function(Hovered, Active, Selected)
                                if (Selected) then 
                                end 
                            end, RMenu:Get('inventory', 'portefeuille_money'))
                        end
                    end

                   
            
                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == 'bank'  then
                            RageUI.ButtonWithStyle('Banque:', description, {RightLabel = "~b~$"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money.."~s~")}, true, function(Hovered, Active, Selected) 
                                if (Selected) then 
                                end 
                            end)

                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == 'black_money'  then
                            RageUI.ButtonWithStyle('Source inconnu:', description, {RightLabel = "~c~$"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money.."~s~ →")}, true, function(Hovered, Active, Selected) 
                                if (Selected) then 
                                        end 
                                    end, RMenu:Get('inventory', 'portefeuille_use'))
                                end
                            end
                        end
                    end
                end)
                ----------------------------------------------------------------------------------


                RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille_use'), true, true, true, function() 

                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == 'black_money' then
                            RageUI.Button("Donner de l'argent ~r~non-déclaré", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                                if Selected then
                                    local black, quantity = CheckQuantity(KeyboardInputF5('Somme d\'argent que vous souhaitez donner', '0', 5))
                                        if black then
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                                        if closestDistance ~= -1 and closestDistance <= 3 then
                                        local closestPed = GetPlayerPed(closestPlayer)
    
                                        if not IsPedSittingInAnyVehicle(closestPed) then
                                            TriggerServerEvent('esx:donneItem', GetPlayerServerId(closestPlayer), 'item_account', ESX.PlayerData.accounts[i].name, quantity)
                                            ExecuteCommand("e keyfob")
                                            ExecuteCommand("me Lui donne des billets")
                                        else
                                           Extasy.ShowNotification('Vous ne pouvez pas donner de l\'argent dans un véhicles')
                                        end
                                    else
                                       Extasy.ShowNotification('Aucun joueur proche !')
                                    end
                                else
                                   Extasy.ShowNotification('Somme invalid')
                                end
                            end
                        end)
    
                        RageUI.Button("Jeter de l'argent ~r~non declaré", nil, {RightBadge = RageUI.BadgeStyle.lock}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local black, quantity = CheckQuantity(KeyboardInputF5('Somme d\'argent que vous souhaitez jeter', '0', 5))
                                if black then
                                    if not IsPedSittingInAnyVehicle(PlayerPed) then
                                        TriggerServerEvent('esx:removeInventoryItem', 'item_account', ESX.PlayerData.accounts[i].name, quantity)
                                        ExecuteCommand("e pickup")
                                        ExecuteCommand("me dépose des billets au sol.")
                                            else
                                               Extasy.ShowNotification('Vous pouvez pas jeter', 'de l\'argent')
                                                end
                                            else
                                               Extasy.ShowNotification('Somme Invalid')
                                            end
                                        end
                                    end)
                                end
                            end
                        end)
                ----------------------------------------------------------------------------------


                    RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille_work'), true, true, true, function()
                        RageUI.ButtonWithStyle("Votre grade dans l'entreprise:", nil, {RightLabel = "~p~"..ESX.PlayerData.job.grade_label .."~s~"}, true, function(Hovered, Active, Selected)
                            if Selected then
                            end
                        end)

                        if not menu_perso.demission_ok then
                            RageUI.Button("~r~Démisionner de son métier", "Démisionner sans crainte, Votre patron sera prévenu", {}, true, function(Hovered, Active, Selected) if Selected then menu_perso.demission_ok = true end end)
                        else
                            RageUI.Button("~r~Démisionner de son métier", "Démisionner sans crainte, Votre patron sera prévenu", {RightLabel = "~r~Confirmez"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    Extasy.ShowAdvancedNotification('Métier','~g~Patron','Vous venez de démissioner avec ~g~succes !','CHAR_PEGASUS_DELIVERY',8)
                                    TriggerServerEvent("job:set", token, "unemployed")
                                    RageUI.CloseAll()
                                    F5_in_menu_perso = false
                                end
                            end)
                        end

                        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then

                        RageUI.ButtonWithStyle("Gérer mon entreprise", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                        end
                    end, RMenu:Get('inventory', 'boss'))
                else
                    RageUI.ButtonWithStyle("Gestion d'entreprise", nil, {RightBadge = RageUI.BadgeStyle.Lock}, false, function(Hovered, Active, Selected)
                            if Selected then
                                end
                            end)
                        end 
                    end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille_work2'), true, true, true, function()
                    RageUI.ButtonWithStyle("Votre grade dans le gang:", nil, {RightLabel = "~r~"..ESX.PlayerData.job2.grade_label .."~s~"}, true, function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end)

                    if not menu_perso.demission_ok then
                        RageUI.Button("~r~Quitter son GANG", "Quitter son GANG est un action iratrapable !", {}, true, function(Hovered, Active, Selected) if Selected then menu_perso.demission_ok = true end end)
                    else
                        RageUI.Button("~r~Quitter son GANG", "Quitter son GANG est un action iratrapable !", {RightLabel = "~r~Confirmez"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                Extasy.ShowAdvancedNotification('GANG','~g~OG','Vous venez de démissioner avec ~g~succes !','CHAR_PEGASUS_DELIVERY',8)
                                TriggerServerEvent("job2:set", token, "unemployed2")
                                RageUI.CloseAll()
                                F5_in_menu_perso = false
                            end
                        end)
                    end

                    if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then

                    RageUI.ButtonWithStyle("Gérer mon gang", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                    end
                end, RMenu:Get('inventory', 'boss2'))
            else
                RageUI.ButtonWithStyle("Gestion du gang", nil, {RightBadge = RageUI.BadgeStyle.Lock}, false, function(Hovered, Active, Selected)
                        if Selected then
                            end
                        end)
                    end 
                end, function()
            end)

                

                -- ----------------------------------------------------------------------------------

                 RageUI.IsVisible(RMenu:Get('inventory', 'boss'), true, true, true, function()

                     if societymoney ~= nil then
                         RageUI.Separator("[ Societé ~p~"..ESX.PlayerData.job.label.."~s~ ] - [ Argent ~g~"..societymoney.."$~s~ ]")
                     end

                 RageUI.ButtonWithStyle('Recruter une personne', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                     if (Selected) then
                         if ESX.PlayerData.job.grade_name == 'boss' then
                             local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        
                             if closestPlayer == -1 or closestDistance > 3.0 then
                                 Extasy.ShowNotification('Aucun joueur proche')
                             else
                                 TriggerServerEvent('Extasy:Boss_recruterplayer', token, GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name, 1)
                             end
                         else
                             Extasy.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                         end
                     end
                 end)
        
                 RageUI.ButtonWithStyle('Virer une personne', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                     if (Selected) then
                         if ESX.PlayerData.job.grade_name == 'boss' then
                             local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        
                             if closestPlayer == -1 or closestDistance > 3.0 then
                                 Extasy.ShowNotification('Aucun joueur proche')
                             else
                                 TriggerServerEvent('Extasy:Boss_virerplayer', token, GetPlayerServerId(closestPlayer))
                             end
                         else
                             Extasy.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                         end
                     end
                 end)
        
                 RageUI.ButtonWithStyle('Promouvoir une personne', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                         if ESX.PlayerData.job.grade_name == 'boss' then
                             local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        
                             if closestPlayer == -1 or closestDistance > 3.0 then
                                 Extasy.ShowNotification('Aucun joueur proche')
                             else
                                 TriggerServerEvent('Extasy:Boss_promouvoirplayer', token, GetPlayerServerId(closestPlayer))
                         end
                         else
                             Extasy.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                         end
                     end
                 end)
        
                 RageUI.ButtonWithStyle('Destituer une personne', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                     if (Selected) then
                         if ESX.PlayerData.job.grade_name == 'boss' then
                             local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        
                             if closestPlayer == -1 or closestDistance > 3.0 then
                                     Extasy.ShowNotification('Aucun joueur proche')
                                 else
                                TriggerServerEvent('Extasy:Boss_destituerplayer', token, GetPlayerServerId(closestPlayer))
                                     end
                                 else
                                     Extasy.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                                 end
                             end
                         end)
                     end, function()
                 end)

                 RageUI.IsVisible(RMenu:Get('inventory', 'boss2'), true, true, true, function()

                    if societymoney2 ~= nil then
                        RageUI.Separator("[ Gang ~p~"..ESX.PlayerData.job2.label.."~s~ ] - [ Argent ~r~"..societymoney2.."$~s~ ]")
                    end

                RageUI.ButtonWithStyle('Recruter une personne', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if ESX.PlayerData.job2.grade_name == 'boss' then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
       
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                Extasy.ShowNotification('Aucun joueur proche')
                            else
                                TriggerServerEvent('Extasy:Boss_recruterplayer2', token, GetPlayerServerId(closestPlayer), ESX.PlayerData.job2.name, 1)
                            end
                        else
                            Extasy.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                        end
                    end
                end)
       
                RageUI.ButtonWithStyle('Virer une personne', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if ESX.PlayerData.job2.grade_name == 'boss' then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
       
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                Extasy.ShowNotification('Aucun joueur proche')
                            else
                                TriggerServerEvent('Extasy:Boss_virerplayer2', token, GetPlayerServerId(closestPlayer))
                            end
                        else
                            Extasy.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                        end
                    end
                end)
       
                RageUI.ButtonWithStyle('Promouvoir une personne', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                   if (Selected) then
                        if ESX.PlayerData.job2.grade_name == 'boss' then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
       
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                Extasy.ShowNotification('Aucun joueur proche')
                            else
                                TriggerServerEvent('Extasy:Boss_promouvoirplayer', token, GetPlayerServerId(closestPlayer))
                        end
                        else
                            Extasy.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                        end
                    end
                end)
       
                RageUI.ButtonWithStyle('Destituer une personne', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        if ESX.PlayerData.job2.grade_name == 'boss' then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
       
                            if closestPlayer == -1 or closestDistance > 3.0 then
                                    Extasy.ShowNotification('Aucun joueur proche')
                                else
                               TriggerServerEvent('Extasy:Boss_destituerplayer', token, GetPlayerServerId(closestPlayer))
                                    end
                                else
                                    Extasy.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                                end
                            end
                        end)
                    end, function()
                end)
                ----------------------------------------------------------------------------------

                RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille_money'), true, true, true, function()

                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == 'money' then

                            RageUI.Button("Donner de l'argent ~g~liquide", nil, {RightLabel = "→→"}, true, function(Hovered,Active,Selected)
                                if Selected then
                                    local black, quantity = CheckQuantity(KeyboardInputF5('Somme d\'argent que vous souhaitez donner', '0', 6))
                                        if black then
                                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                                    if closestDistance ~= -1 and closestDistance <= 3 then
                                        local closestPed = GetPlayerPed(closestPlayer)
    
                                        if not IsPedSittingInAnyVehicle(closestPed) then
                                            TriggerServerEvent('esx:donneItem', GetPlayerServerId(closestPlayer), 'item_account', ESX.PlayerData.accounts[i].name, quantity)
                                            ExecuteCommand("e keyfob")
                                            ExecuteCommand("me Lui donne un object") 
                                        else
                                           Extasy.ShowNotification('Vous ne pouvez pas donner de l\'argent dans un véhicles')
                                        end
                                    else
                                       Extasy.ShowNotification('Aucun joueur proche !')
                                    end
                                else
                                   Extasy.ShowNotification('Somme invalid')
                                end
                            end
                        end)
    
                        RageUI.Button("Jeter de l'argent ~g~liquide", nil, {RightBadge = RageUI.BadgeStyle.lock}, true, function(Hovered, Active, Selected)
                            if Selected then
                                local black, quantity = CheckQuantity(KeyboardInputF5('Somme d\'argent que vous souhaitez jeter', '0', 6))
                                if black then
                                    if not IsPedSittingInAnyVehicle(PlayerPed) then
                                        TriggerServerEvent('esx:removeInventoryItem', 'item_account', ESX.PlayerData.accounts[i].name, quantity)
                                        ExecuteCommand("e pickup")
                                        ExecuteCommand("me dépose des billets au sol.")
                                            else
                                               Extasy.ShowNotification('Vous pouvez pas jeter', 'de l\'argent')
                                                end
                                            else
                                               Extasy.ShowNotification('Somme Invalid')
                                            end
                                        end
                                    end)
                                end
                            end
                        end)          

                ----------------------------------------------------------------------------------
                RageUI.IsVisible(RMenu:Get('inventory', 'main_menu_settings_notifications'), true, true, true, function()

                    RageUI.List("Ne pas recevoir de notifications", menu_perso.silenceTimeList, menu_perso.silenceTimeIndexSingle, nil, {}, true, function(Hovered, Active, Selected, index)
                        menu_perso.silenceTimeIndexSingle = index
                        if Selected then
                            Extasy.ShowNotification("~g~Vous ne recevrez plus de notifications pendant "..menu_perso.silenceTimeList[menu_perso.silenceTimeIndexSingle])
                            Extasy.MuteNotification(menu_perso.silenceTimeIndex[menu_perso.silenceTimeIndexSingle])
                        end
                    end)

                    if playerInSilence then
                        RageUI.Button("Réactiver les notifications", nil, {}, true, function(Hovered, Active, Selected)
                            if Selected then
                                playerInSilence = false
		                        Extasy.ShowNotification("~r~Les notifications seront désormais affichées de nouveau")
                            end
                        end)
                    end

                    RageUI.List("Position des nofitications", menu_perso.notifPosList, menu_perso.notifPosIndex, nil, {}, true, function(Hovered, Active, Selected, index)
                        menu_perso.notifPosIndex = index
                        if Selected then
                            TriggerEvent("bulletin:savePosition", menu_perso.notifPosListIndex[menu_perso.notifPosIndex])
                            Extasy.ShowNotification("~g~Position des nofitications '"..menu_perso.notifPosList[menu_perso.notifPosIndex].."' sauvegardée avec succès")
                        end
                    end)
                
                end, function()
                end)


                RageUI.IsVisible(RMenu:Get('inventory', 'divers'), true, true, true, function()

                    RageUI.Separator("ID: "..GetPlayerServerId(PlayerId()))

                    RageUI.Checkbox("Desactiver les coups de crosses", nil, menu_perso.cross_mode, {}, function(Hovered, Active, Selected, Car)
                        if Selected then
                            extasy_core_cfg["anti-cross"] = menu_perso.cross_mode
                        end
                    end)

                    RageUI.Button("Notifications", nil, {}, true, function(_, _, Active)
                    end, RMenu:Get('inventory', 'main_menu_settings_notifications'))

                    --[[RageUI.Checkbox("Afficher le compteur", nil, menu_perso.hud_car, {}, function(Hovered, Active, Selected, Car)
                        if (Selected) then
                            menu_perso.hud_car = Checked
                            menu_perso.hud_car2 = not menu_perso.hud_car2
                            if Checked then
                                TriggerEvent("letsgoHUD", token, menu_perso.hud_car2)
                            else
                                TriggerEvent("letsgoHUD", token, not menu_perso.hud_car2)
                            end
                        end
                    end)--]]

                    RageUI.ButtonWithStyle("Debug son personnage", description, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            DoScreenFadeOut(1000)
                            Citizen.Wait(2000) 
                            PlaySoundFrontend(-1, "CHARACTER_SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
                            Citizen.Wait(500)
                            DoScreenFadeIn(1000)
                            Extasy.ShowNotification("~p~[Debug] ~s~- Personnage débug dans 2 sec...")

                            TriggerMusicEvent("AH3A_STOP")

                            TriggerEvent('eStatus:setDisplay', token, 0)
                            TriggerEvent('eStatus:setDisplay', token, 1)

                            SetWeatherTypeNow("EXTRASUNNY")

                            ClearPedTasks(GetPlayerPed(-1))
                            DestroyAllProps()
                            FreezeEntityPosition(GetPlayerPed(-1), false)
                            EnableAllControlActions(0)

                            TriggerEvent('skinchanger:getSkin', function(skin)
                                LastSkin = skin
                            end)
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                            end)

                            near_npc = true
                            animation_handsup = false
                            mp_pointing = false
                            crouched = false
                            openned = false
                            IsHandcuffed = false
                            AppelPris = false
                            AppelDejaPris = false
                            AppelEnAttente = false 
                            AppelCoords = nil
                            ambulance_in_menu_garage = false
                            ambulance_in_menu_garage_helico = false
                            openPharmacy = false
                            ambulance_in_menu = false
                            ambulance_tenue_menu = false
                            Avocat_in_menu_boss = false
                            Mecano_in_menu_boss = false
                            Mecano_in_menu_garage = false
                            mechanic_in_menu = false
                            menu_recolte_Piece_Bennys = false
                            recolte_Piece_Bennys = false
                            transormation_kit = false
                            menu_transormation_kit = false
                            coffre_bennys = false
                            blanchiment_in_menu = false
                            bodyMenu = nil
                            InWork = nil
                            Gouv_in_menu_garage = false
                            FarmJobs_in_menu = false
                            MenuFarmJobsMine = false
                            Gouv_in_menu_boss = false
                            Joblisting_in_menu = false
                            label_in_menu = false
                            coffre_label = false
                            menu_boss_label = false
                            North_Mecano_in_menu_boss = false
                            North_Mecano_in_menu_garage = false
                            north_meca_in_menu = false
                            menu_recolte_Piece_North_Mecano = false
	                        recolte_Piece_North_Mecano = false
                            menu_transormation_kit = false
                            transormation_kit = false
                            coffre_north_mecano = false
                            Mecano_in_menu_vestiaire = false
                            Lspd_in_menu_boss = false
                            Lspd_in_menu_coffre = false
                            Lspd_in_menu_garage = false
                            lspd_inmenu = false
                            Lspd_in_menu_vestiaire = false
                            dansmenu = false
	                        rum_farm_boison_in_menu = false
                            Sheriff_in_menu_boss = false
                            Sheriff_in_menu_coffre = false
                            Sheriff_in_menu_garage = false
                            bcsd_inmenu = false
                            Sheriff_in_menu_vestiaire = false
                            Taxi_in_menu_garage = false
                            TaxiMenu = false
                            TaxiVestaire = false
                            Unicorn_in_menu_boss = false
                            Unicorn_in_menu_coffre = false
                            unicorn_in_menu = false
                            Vendeur_in_menu_garage = false
                            Vendeur_in_menu_coffre = false
                            Vendeur_in_menu_theorie = false
                            vendeur_in_menu = false
                            Vendeur_in_menu_craft = false
                            boss_in_menu = false
                            Vendeur_in_menu_recolte = false
                            Vendeur_in_menu_recolte2 = false
                            Vendeur_in_menu_recolte3 = false
                            Vendeur_in_menu_recolte4 = false
                            vigneron_in_menu = false
                            Vendeur_in_menu_garage = false
                            coffre_vigneron = false
                            Vendeur_in_menu_boss = false
                            menu_recolte_raisin_vigneron = false
	                        recolte_raisin_vigneron = false
                            menu_traitement_vin_vigneron = false
	                        traitement_vin_vigneron = false
                            vente_possible = false
                            menu_vente_vin_vigneron = false
                            cooldown = false
                            weed_in_menu = false
                            WeedShop_in_menu_garage = false
                            WeedShop_in_menu_coffre = false
                            apprendre_craft_weedshop = false
                            craft_weedshop = false
                            menu_boss_weedshop = false
                            menu_recolte_weed_weedshop = false
	                        recolte_weed_weedshop = false
                            menu_recolte_feuille_weedshop = false
	                        recolte_feuille_weedshop = false
                            menu_recolte_filtre_weedshop = false
	                        recolte_filtre_weedshop = false
                            Yellowjack_in_menu_boss = false
                            Yellowjack_in_menu_coffre = false
                            yellowjack_in_menu = false

                            RageUI.CloseAll()
                            F5_in_menu_perso = false
                            Wait(1000)
                            Extasy.ShowNotification("~p~[Débug] ~s~- Personnage complétement débug !")
                            PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

                        end
                    end)

                    RageUI.Checkbox("Afficher / Désactiver la carte", description, menu_perso.map,{},function(Hovered,Ative,Selected,Checked)
                        if Selected then
                            menu_perso.map = Checked
                            menu_perso.ui = not menu_perso.ui
                            if Checked then
                                DisplayRadar(true)
                            else
                                DisplayRadar(false)
                            end
                        end
                    end)

                    --[[RageUI.Checkbox('Interface Cinématique', description, menu_perso.cinema, {}, function(Hovered, Active, Selected)
                        if (Selected) then
                            menu_perso.cinema = not menu_perso.cinema
                            SendNUIMessage({openCinema = menu_perso.cinema})
                        end
                    end)--]]

                    --[[local ragdolling = false
                    RageUI.ButtonWithStyle('Dormir / Se Reveiller', description, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
                        if (Selected) then
                            ragdolling = not ragdolling
                            while ragdolling do
                             Wait(0)
                            local myPed = GetPlayerPed(-1)
                            SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
                            ResetPedRagdollTimer(myPed)
                            AddTextEntry(Getmenu_persoentResourceName(), ('Appuyez sur ~INPUT_JUMP~ pour vous ~p~Réveillé'))
                            DisplayHelpTextThisFrame(Getmenu_persoentResourceName(), false)
                            ResetPedRagdollTimer(myPed)
                            if IsControlJustPressed(0, 22) then 
                            break
                        end
                    end
                end
            end)

            if VeloDePoche == nil then
                RageUI.ButtonWithStyle("Sortir son vélo de poche (x1)", description, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local ped = PlayerPedId()
                        local co = GetEntityCoords(Ped)
                        SetPedCoordsKeepVehicle(co, x, y , z)
                        TriggerEvent('esx:spawnVehicles', token, "bmx")
                        VeloDePoche = VehToNet(veh)
                        ExecuteCommand("me sort son vélo de poche")
                    end
                end)
            else
                RageUI.ButtonWithStyle("Ranger son vélo de poche", description, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerEvent('esx:deleteVehicles', token, VeloDePoche)
                        local entity = NetworkGetEntityFromNetworkId(list)
                        Citizen.InvokeNative(`DELETE_ENTITY` & 0xFFFFFFFF, entity)
                        VeloDePoche = nil
                        ExecuteCommand("me range son vélo de poche")
                    end
                end)
            end--]]

            RageUI.Button("Props", nil, {RightLabel = "→"}, true, function(Hovered, Active,Selected)
                if (Selected) then
                    if getPlayerVip() ~= "AUCUN" then
                        RageUI.Visible(RMenu:Get('props', 'main_menu'), true)
                        openProps()
                        playerPropsMenu = not playerPropsMenu
                    else
                        Extasy.ShowNotification("~r~Vous n'avez pas le grade nécessaire pour accéder cette fonctionnalité.~n~Vous devez être minimum:\n~y~GOLDEN")
                    end
                end
            end)

            --RageUI.ButtonWithStyle('Touches Serveur', description, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
            --    if (Selected) then 
            --        end 
            --    end, RMenu:Get('inventory', 'tserv'))

            RageUI.ButtonWithStyle("Menu Filtres", nil, {RightLabel = "→"}, true, function(Hovered, Active,Selected)
                if Selected then
                     end
                end, RMenu:Get('inventory', 'visual'))
            RageUI.ButtonWithStyle("Rockstar Editor", nil, {RightLabel = "→"}, true, function(Hovered, Active,Selected)
                if Selected then
                    end
                end, RMenu:Get('inventory', 'divers_rockstar_editor'))
            end)

                --RageUI.ButtonWithStyle("Rejoindre le ~p~Discord", description, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
                    --if (Selected) then 
                        --ExecuteCommand("discord")
                    --end 
                --end)
            ----------------------------------------------------------------------
            RageUI.IsVisible(RMenu:Get('inventory', 'divers_rockstar_editor'), true, true, true, function()
                RageUI.Button("Stop/save record", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        StopRecordingAndSaveClip()
                    end
                end)

                RageUI.Button("Stop/Annuler record", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        StopRecordingAndDiscardClip()
                    end
                end)

                RageUI.Button("Start record", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        StartRecording(1)
                    end
                end)

                RageUI.Button("Open editor", nil, {}, true, function(Hovered, Active, Selected)
                    if Selected then
                        NetworkSessionLeaveSinglePlayer()
                        ActivateRockstarEditor()
                    end
                end)
            end, function()
            end)

                RageUI.IsVisible(RMenu:Get('inventory', 'visual'), true, true, true, function()

                    RageUI.Checkbox("Vue & lumières améliorées", description, menu_perso.visual, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            menu_perso.visual = Checked
                            if Checked then
                                SetTimecycleModifier('tunnel')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    RageUI.Checkbox("Vue lumineux", description, menu_perso.visual7, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            menu_perso.visual7 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_vignette_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)
        
                    RageUI.Checkbox("Couleurs amplifiées", description, menu_perso.visual2, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            menu_perso.visual2 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_saturation')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)
        
                    RageUI.Checkbox("Noir & blancs", description, menu_perso.visual3, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            menu_perso.visual3 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_saturation_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    RageUI.Checkbox("Visual 1", description, menu_perso.visual5, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            menu_perso.visual5 = Checked
                            if Checked then
                                SetTimecycleModifier('yell_tunnel_nodirect')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    RageUI.Checkbox("Blanc", description, menu_perso.visual6, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            menu_perso.visual6 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_contrast_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    RageUI.Checkbox("Dégats", description, menu_perso.visual8, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            menu_perso.visual8 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_vignette')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    end,function()
                    end)

----------------------------------------------------------------------------------------------------



    RageUI.IsVisible(RMenu:Get('inventory', 'sim'), true, true, true, function()

        for sim = 1, #cartesim, 1 do
        RageUI.ButtonWithStyle(" "..cartesim[sim].label, nil, {RightLabel = ""}, true, function(Hovered, Active,Selected)
        end, RMenu:Get('inventory', 'simg'))
        end

    end,function()
    end)

----------------------------------------------------------------------------------------------------

    RageUI.IsVisible(RMenu:Get('inventory', 'key'), true, true, true, function()

        for key = 1, #clevoiture, 1 do
        RageUI.ButtonWithStyle("~p~Clé : ~s~"..clevoiture[key].value, nil, {RightLabel = ""}, true, function(Hovered, Active,Selected)
        end, RMenu:Get('inventory', 'simg'))
        end

    end,function()
    end)

RageUI.IsVisible(RMenu:Get('inventory', 'main_menu_masks_choose'), true, true, true, function()

    if not menu_perso.maskData.gotOn then
        RageUI.Button("Porter", nil, {}, true, function(h, a, s)
            if s then
                menu_perso.maskData.gotOn = true
                local pPed   = GetPlayerPed(-1)
                local ma_1   = menu_perso.maskData.ma_1
                local ma_2   = menu_perso.maskData.ma_2
                local ma_3   = menu_perso.maskData.ma_3

                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local isMale = skin.sex == 0
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)

                        Extasy.RequestAnimDict(mask_anim)

                        TaskPlayAnim(PlayerPedId(), mask_anim, "takeoff_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                        Wait(200)
                        ClearPedSecondaryTask(PlayerPedId())
                        SetPedComponentVariation(pPed, ma_1, ma_2, ma_3, 2)
                        playerGotMaskOrHat = true

                        TriggerEvent("skinchanger:change", 'mask_1', ma_2)
                        TriggerEvent("skinchanger:change", 'mask_2', ma_3)
                        --TriggerEvent("rF:SaveSkin", token)
                    end)
                end)
            end
        end)
    else
        RageUI.Button("Retirer", nil, {}, true, function(h, a, s)
            if s then
                menu_perso.maskData.gotOn = false
                local pPed         = GetPlayerPed(-1)

                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local isMale = skin.sex == 0
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)

                        Extasy.RequestAnimDict(mask_anim)

                        TaskPlayAnim(PlayerPedId(), mask_anim, "takeoff_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                        Wait(200)
                        ClearPedSecondaryTask(PlayerPedId())
                        SetPedComponentVariation(pPed, 1, 0, 0, 2)

                        TriggerEvent("skinchanger:change", 'mask_1', 0)
                        TriggerEvent("skinchanger:change", 'mask_2', 0)
                        --TriggerEvent("rF:SaveSkin", token)
                    end)
                end)
            end
        end)
    end
    RageUI.Button("Renommer", nil, {}, true, function(h, a, s)
        if s then
            local a = Extasy.KeyboardInput("Quel nom souhaitez-vous lui donner ?", "", 500)
            if a ~= nil then
                TriggerServerEvent("Extasy:updateNameForThisMask", token, menu_perso.maskData.ma_ID, a)
                Extasy.refreshMenu()
                Wait(50)
                RageUI.GoBack()
            else
                Extasy.ShowNotification("~r~Nom invalide")
            end
        end
    end)
    if not menu_perso.maskConf then
        RageUI.Button("~r~Abandonner", nil, {}, true, function(h, a, s)
            if s then
                menu_perso.maskConf = true
            end
        end)
    else
        RageUI.Button("~r~Abandonner", nil, {RightLabel = "~r~Confirmez"}, true, function(h, a, s)
            if s then
                TriggerServerEvent("Extasy:deleteThisMask", token, menu_perso.maskData.ma_ID)
                Extasy.refreshMenu()
                Wait(50)
                RageUI.GoBack()
                menu_perso.maskConf = false
            end
        end)
    end

end, function()
end)

RageUI.IsVisible(RMenu:Get('inventory', 'main_menu_clothes_choose'), true, true, true, function()

    if not menu_perso.clothesData.gotOn then
        RageUI.Button("Porter", nil, {}, true, function(h, a, s)
            if s then
                menu_perso.maskData.gotOn = false
                TriggerEvent("eCore:AfficherBar", 4000, "📦 Changement de tenue en cours...")
                Wait(4000)
                ClearPedSecondaryTask(PlayerPedId())
                TriggerEvent("skinchanger:getSkin", function(skin)
                    TriggerEvent('skinchanger:loadClothes', skin, json.decode(menu_perso.clothesData))
                        TriggerEvent('esx_skin:setLastSkin', skin)
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            TriggerServerEvent('esx_skin:save', skin)
                        end)
                    RageUI.GoBack()
                end)
                ExecuteCommand('e tryclothes2')
                Wait(2000)
                ClearPedSecondaryTask(PlayerPedId())
            end
        end)
    else
        RageUI.Button("Retirer", nil, {}, true, function(h, a, s)
            if s then
                menu_perso.maskData.gotOn = false
                local pPed         = GetPlayerPed(-1)

                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    local isMale = skin.sex == 0
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)

                        Extasy.RequestAnimDict(mask_anim)

                        TaskPlayAnim(PlayerPedId(), mask_anim, "takeoff_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                        Wait(200)
                        ClearPedSecondaryTask(PlayerPedId())
                        SetPedComponentVariation(pPed, 1, 0, 0, 2)

                        TriggerEvent("skinchanger:change", 'mask_1', 0)
                        TriggerEvent("skinchanger:change", 'mask_2', 0)
                        --TriggerEvent("Extasy:SaveSkin", token)
                    end)
                end)
            end
        end)
    end
    RageUI.Button("Renommer", nil, {}, true, function(h, a, s)
        if s then
            i = Extasy.KeyboardInput("Définissez le nouveau nom de votre tenue", "", 30)
            i = tostring(i)
            if i ~= nil then
                TriggerServerEvent("Extasy:RenameTenue", token, menu_perso.maskData_ID, a)
                Wait(50)
                TriggerServerEvent("Extasy:GetTenues", token)
                RageUI.GoBack()
            else
                Extasy.ShowNotification("~r~Nom de tenue incorrect")
            end
        end
    end)

end, function()
end)

RageUI.IsVisible(RMenu:Get('inventory', 'main_menu_perso_clothes'), true, true, true, function()
    RageUI.ButtonWithStyle("Enlever t-shirt", nil, {}, not tshirt, function(h, a, s)
        if s then
            if not IsPedInVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), false) then
                TriggerEvent("skinchanger:getSkin", function(skin)
                    local d = {
                        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                        ['torso_1'] = 15, ['torso_2'] = 0,
                        ['arms'] = 15, ['arms_2'] = 0
                    }
                TriggerEvent("skinchanger:loadClothes", skin, d)
                TriggerEvent("skinchanger:loadClothes", skin, d)
                tshirt = true
            end)
                --for i = 1, #playerTatoos, 1 do
                    --ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(playerTatoos[i].collection), GetHashKey(cfg_tattoos.tattoosList[playerTatoos[i].collection][playerTatoos[i].texture].nameHash))
                --end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci dans un véhicule")
                tshirt = false
            end
        end
    end)

    RageUI.ButtonWithStyle("Enlever pantalon", nil, {}, not pantalon, function(h, a, s)
        if s then
            if not IsPedInVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), false) then
                TriggerEvent("skinchanger:getSkin", function(skin)
                    local d = {
                        ['pants_1'] = 21, ['pants_2'] = 0,
                    }
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    pantalon = true
                end)
                --for i = 1, #playerTatoos, 1 do
                    --ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(playerTatoos[i].collection), GetHashKey(cfg_tattoos.tattoosList[playerTatoos[i].collection][playerTatoos[i].texture].nameHash))
                --end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci dans un véhicule")
                pantalon = false
            end
        end
    end)
    RageUI.ButtonWithStyle("Enlever chaussures", nil, {}, not chaussures, function(h, a, s)
        if s then
            if not IsPedInVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), false) then
                    TriggerEvent("skinchanger:getSkin", function(skin)
                        local d = {}
                        if playerIsMale then
                            d = {
                                ['shoes_1'] = 34, ['shoes_2'] = 0
                            }
                        else
                            d = {
                                ['shoes_1'] = 35, ['shoes_2'] = 0
                            }
                        end
                        TriggerEvent("skinchanger:loadClothes", skin, d)
                        TriggerEvent("skinchanger:loadClothes", skin, d)
                        chaussures = true
                    end)
                    --for i = 1, #playerTatoos, 1 do
                        --ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(playerTatoos[i].collection), GetHashKey(cfg_tattoos.tattoosList[playerTatoos[i].collection][playerTatoos[i].texture].nameHash))
                    --end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci dans un véhicule")
                chaussures = false
            end
        end
    end)
    RageUI.ButtonWithStyle("Enlever sac", nil, {}, not sac, function(h, a, s)
        if s then
            if not IsPedInVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), false) then
                TriggerEvent("skinchanger:getSkin", function(skin)
                    local d = {
                        ['bags_1'] = 0, ['bags_2'] = 0
                    }
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    sac = true
                end)
                --for i = 1, #playerTatoos, 1 do
                    --ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(playerTatoos[i].collection), GetHashKey(cfg_tattoos.tattoosList[playerTatoos[i].collection][playerTatoos[i].texture].nameHash))
                --end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci dans un véhicule")
                sac = false
            end
        end
    end)
    if playerHaveKevlar then
        RageUI.ButtonWithStyle("Enlever kevlar", nil, {}, not kevlar, function(h, a, s)
            if s then
                playerHaveKevlar = false
                playerLastDamageKev = GetPedArmour(GetPlayerPed(-1))
                SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 0, 2)
                SetPedArmour(GetPlayerPed(-1), 0)
                kevlar = true
            end
        end)
    end
    RageUI.ButtonWithStyle("Se rhabiller", nil, {}, true, function(h, a, s)
        if s then
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                if not IsPedInVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), false) then
                    TriggerEvent('skinchanger:loadSkin', skin)
                    tshirt = false
                    pantalon = false
                    chaussures = false
                    sac = false
                    kevlar = false
                else
                    Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci dans un véhicule")
                    tshirt = true
                    pantalon = true
                    chaussures = true
                    sac = true
                    kevlar = true
                end
            end)
        end
    end)

end,function()
end)

RageUI.IsVisible(RMenu:Get('inventory', 'main_menu_perso_masks'), true, true, true, function()

    RageUI.ButtonWithStyle("Enlever masque", nil, {}, true, function(h, a, s)
        if s then
            local pPed         = GetPlayerPed(-1)

            local dict = 'missfbi4'
            local myPed = PlayerPedId()
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(0)
            end
            TaskPlayAnim(GetPlayerPed(-1), 'missfbi4', "takeoff_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            Wait(400)
            ClearPedSecondaryTask(GetPlayerPed(-1))
            SetPedComponentVariation(pPed, 1, 0, 0, 2)

            TriggerEvent("skinchanger:change", 'mask_1', 0)
            TriggerEvent("skinchanger:change", 'mask_2', 0)
        end
    end)
    RageUI.Separator("")
end, function()
end)

RageUI.IsVisible(RMenu:Get('inventory', 'main_menu_perso_masks_choose'), true, true, true, function()
 
    if not menu_perso.maskData.gotOn then
        RageUI.Button("Porter", nil, {}, true, function(h, a, s)
            if s then
                menu_perso.maskData.gotOn = true
                local pPed   = GetPlayerPed(-1)
                local ma_1   = menu_perso.maskData.ma_1
                local ma_2   = menu_perso.maskData.ma_2
                local ma_3   = menu_perso.maskData.ma_3

                RequestAnimSetF5(mask_anim)

                TaskPlayAnim(PlayerPedId(), mask_anim, "takeoff_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                Wait(200)
                ClearPedSecondaryTask(PlayerPedId())
                SetPedComponentVariation(pPed, ma_1, ma_2, ma_3, 2)
                playerGotMaskOrHat = true

                TriggerEvent("skinchanger:change", 'mask_1', ma_2)
                TriggerEvent("skinchanger:change", 'mask_2', ma_3)
            end
        end)
    else
        RageUI.Button("Retirer", nil, {}, true, function(h, a, s)
            if s then
                menu_perso.maskData.gotOn = false
                local pPed         = GetPlayerPed(-1)

                RequestAnimSetF5(mask_anim)

                TaskPlayAnim(PlayerPedId(), mask_anim, "takeoff_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
                Wait(200)
                ClearPedSecondaryTask(PlayerPedId())
                SetPedComponentVariation(pPed, 1, 0, 0, 2)

                TriggerEvent("skinchanger:change", 'mask_1', 0)
                TriggerEvent("skinchanger:change", 'mask_2', 0)
            end
        end)
    end
    RageUI.Button("Renommer", nil, {}, true, function(h, a, s)
        if s then
            local a = KeyboardInputF5('Que souhaitez-vous donner comme nom ?', 'Chapeux Bleu', 10)
            if a ~= nil then
                TriggerServerEvent("mask:updateNameForThisMask", token, menu_perso.maskData.ma_ID, a)
                RageUI.GoBack()
            else
                Extasy.ShowNotification("~r~Nom invalide")
            end
        end
    end)
    if not menu_perso.maskConf then
        RageUI.Button("~r~Abandonner", nil, {}, true, function(h, a, s)
            if s then
                menu_perso.maskConf = true
            end
        end)
    else
        RageUI.Button("~r~Abandonner", nil, {RightLabel = "~r~Confirmez"}, true, function(h, a, s)
            if s then
                TriggerServerEvent("mask:deleteThisMask", token, menu_perso.maskData.ma_ID)
                RageUI.GoBack()
            end
        end)
    end

end, function()
end)

----------------------------------------------------------------------------------------------------

RageUI.IsVisible(RMenu:Get('inventory', 'tserv'), true, true, true, function()
    players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(players, player)
    end

    RageUI.ButtonWithStyle("Afficher son HUD (Argents, métiers, gang...) :", description, {RightLabel = "~p~F1"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Sortir son téléphone :", description, {RightLabel = "~p~F2"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Ouvrir/Fermer Radio :", description, {RightLabel = "~p~F3"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Menu personnel, Inventaire, Papiers... :", description, {RightLabel = "~p~F5"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Menu d'interaction métiers (LSPD, EMS...) :", description, {RightLabel = "~p~F6"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Menu d'interaction gang (Ballas, Vagos, Bloods...) :", description, {RightLabel = "~p~F9"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Ouvrir le chat :", description, {RightLabel = "~p~T"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Ouvrir / fermer vehicule :", description, {RightLabel = "~p~U"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Pointer du doigt :", description, {RightLabel = "~p~B"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Ouvrir un coffre :", description, {RightLabel = "~p~L"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Levez les mains :", description, {RightLabel = "~p~²"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("S'accroupire :", description, {RightLabel = "~p~CTRL"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.ButtonWithStyle("Changer de place en voiture :", description, {RightLabel = "~p~SHIFT +1,+2,+3,+4"}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
        end 
    end)

    RageUI.Separator("[ ~p~Commandes utiles :~s~ ]")

    RageUI.ButtonWithStyle("~p~/porter ~s~- Porter une personne.", description, {RightLabel = ""}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
            ExecuteCommand("porter")
        end 
    end)

    RageUI.ButtonWithStyle("~p~/carkill ~s~- En cas de carkill.", description, {RightLabel = ""}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
            ExecuteCommand("carkill")
        end 
    end)

    RageUI.ButtonWithStyle("~p~/help ~s~- Pour voir plus de commandes.", description, {RightLabel = ""}, true, function(Hovered, Active, Selected) 
        if (Selected) then 
            ExecuteCommand("help")
        end 
    end)

        end,function()
        end)
                  
                Wait(0)
            end
        end)
    end
end



angle = function(veh)
    if not veh then return false end
    local vx,vy,vz = table.unpack(GetEntityVelocity(veh))
    local modV = math.sqrt(vx*vx + vy*vy)
    local rx,ry,rz = table.unpack(GetEntityRotation(veh,0))
    local sn,cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))

    if GetEntitySpeed(veh)* 3.6 < 5 or GetVehiclemenu_persoentGear(veh) == 0 then return 0,modV end --speed over 30 km/h
    
    local cosX = (sn*vx + cs*vy)/modV
    if cosX > 0.966 or cosX < 0 then return 0,modV end
    return math.deg(math.acos(cosX))*0.5, modV
end

Getmenu_persoentWeight = function()
	local menu_persoentWeight = 0
    local maxWeight = 30
        if menu_persoentWeight <= maxWeight then
            for i = 1, #ESX.PlayerData.inventory, 1 do
             if ESX.PlayerData.inventory[i].count > 0 then
                    menu_persoentWeight = menu_persoentWeight + (ESX.PlayerData.inventory[i].weight * ESX.PlayerData.inventory[i].count)
                end
            end
        end
	return menu_persoentWeight
end

replaceTextF5 = function(py)
    menu_perso.n  = GetPlayerName(py)
    menu_perso.n2 = ""
    for i = 1, string.len(menu_perso.n), 1 do
        menu_perso.n2 = menu_perso.n2.."•"
    end

    return menu_perso.n2
end

StoreNearbyVehicle = function(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else
		Extasy.ShowNotification('Il a ete ranger')
		return
	end

	ESX.TriggerServerCallback('esx_ambulancejob:storeNearbyVehicle', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			IsBusy = true

			Citizen.CreateThread(function()
				while IsBusy do
					Citizen.Wait(0)
					drawLoadingText('Le vehicle a ete ranger', 255, 255, 255, 255)
				end
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k,v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end

			IsBusy = false
			Extasy.ShowNotification('Il est bien dans le garage')
		else
			Extasy.ShowNotification('Il n\'est pas dans le garage')
		end
	end, vehiclePlates)
end

local isDead = false
local inAnim = false

AddEventHandler('esx:onPlayerDeath', function(data) isDead = true end)
AddEventHandler('playerSpawned', function(spawn) isDead = false end)

startAttitude = function(lib, anim)
	ESX.Streaming.RequestAnimSet(lib, function()
		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end

startAnim = function(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
	end)
end

startScenario = function(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

EmoteCancel = function()

    if ChosenDict == "MaleScenario" then
      ClearPedTasksImmediately(PlayerPedId())
      DebugPrint("Forced scenario exit")
    elseif ChosenDict == "Scenario" then
      ClearPedTasksImmediately(PlayerPedId())
      DebugPrint("Forced scenario exit")
    end
  
    PtfxNotif = false
    PtfxPrompt = false
  
    --PtfxStop()
    ClearPedTasks(GetPlayerPed(-1))
    ClearPedTasksImmediately(PlayerPedId())
    DestroyAllProps()
  end

PtfxStop = function()
    for a,b in pairs(PlayerParticles) do
        DebugPrint("Stopped PTFX: "..b)
        StopParticleFxLooped(b, false)
        table.remove(PlayerParticles, a)
    end
end