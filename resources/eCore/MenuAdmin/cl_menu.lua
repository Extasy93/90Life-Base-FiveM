ESX = nil
local playerMoney, playerBlackMoney, playerBankMoney, playerInv = nil, nil, nil, nil
orgs_data = {}
local Org = {
    Name = nil,
    Label = nil,
    orgGarage = nil,
    orgBoss = nil,
    orgChest = nil,
    orgGSpawnVeh = nil,
	orgVehicles = {},
}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
	end

	player_staff_menu.open = false

	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main', RageUI.CreateMenu("Menu Administration", "Que souhaitez-vous faire ?"))

	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_report', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "reports", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_report_take', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Report pris", "Que souhaitez-vous faire ?"))
	
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_options', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Actions possible", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_players_list', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Liste des joueurs", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_sanction', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Sanctions", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_action_perso', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Action personnage", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_gestion_vehicules', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Géstion véhuicule", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_funny', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Action FUN !", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_custom_colors', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Menu customisation", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_player_peds', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Menu peds funny", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_player_gestion', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'lister'), "Menu de gestion", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_manage_time', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Géstion du temps", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_tp', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Téléportation", "Que souhaitez-vous faire ?"))

	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_player_possible_action', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_players_list'), "Admin Menu", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_player_money', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_players_list'), "Admin Menu", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_player_sale', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_players_list'), "Admin Menu", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_player_bank', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_players_list'), "Admin Menu", "Que souhaitez-vous faire ?"))
	RMenu.Add('Extasy_player_staff_menu', 'staff_menu_main_player_inv', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_players_list'), "Admin Menu", "Que souhaitez-vous faire ?"))

	RMenu.Add('Extasy_player_staff_menu', 'main_menu_staff_list_org', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), "Admin Menu", "Que souhaitez-vous faire ?"))

	RMenu.Add('Extasy_player_staff_menu', 'main_menu_staff_create_org', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_list_org'), "Staff", "Création d'un gang"))
	RMenu.Add('Extasy_player_staff_menu', 'main_menu_staff_manage_org', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_list_org'), "Staff", "Gestion d'un gang"))

	RMenu.Add('Extasy_player_staff_menu', 'main_menu_staff_create_org_vehicles_list', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org'), "Staff", "Liste des véhicules"))
	RMenu.Add('Extasy_player_staff_menu', 'main_menu_staff_create_org_vehicles_list_choose', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org'), "Staff", "Choisissez le véhicule à ajouter"))
	RMenu.Add('Extasy_player_staff_menu', 'main_menu_staff_create_org_ranks_list', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org'), "Staff", "Liste des grades"))
	RMenu.Add('Extasy_player_staff_menu', 'main_menu_staff_create_org_activity_list', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org'), "Staff", "Liste des activités"))
	RMenu.Add('Extasy_player_staff_menu', 'main_menu_staff_create_org_activity_list_weapon_list', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org'), "Staff", "Liste des armes"))
	RMenu.Add('Extasy_player_staff_menu', 'main_menu_staff_create_org_activity_list_weapon_list_choose', RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org'), "Staff", "Liste des armes"))

	RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main').EnableMouse = false
	RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main').Closed = function()
		player_staff_menu.open = false
    end
end)

Citizen.CreateThread(function()
    while cfg_org == nil do Wait(1) end
    for k,v in pairs(cfg_org.vehicles) do
        RMenu.Add('Extasy_player_staff_menu', v.value, RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_players_list'), "Véhicules", "Que voulez-vous faire ?"))
        RMenu.Add('Extasy_player_staff_menu', v.value.."_org", RageUI.CreateSubMenu(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org_vehicles_list'), "Véhicules", "Choisissez le véhicule à ajouter"))
    end
end)

player_staff_menu = {
    open = false,
}

player_staff_menu.show_coords = false
player_staff_menu.spectating = false
player_staff_menu.oldCoords = nil
player_staff_menu.oldCoords = nil

local selected = {
    event = nil,
    name = nil,
    label = nil,
    count = nil,
    newLabel = nil,
}

local MainColor = {
	r = 100, 
	g = 0, 
	b = 200,
	a = 255
}

superadmin = nil
local player_staff_menu_check_bdd = false
local WarnType = {
    "Freekill",
    "ForceRP",
    "HRP-Vocal",
    "Conduite-HRP",
    "No Fear RP",
    "No Pain RP",
    "Troll",
    "Power Gaming",
    "Insultes",
    "Non respect du staff",
    "Meta Gaming",
    "Force RP",
    "Free Shoot",
    "Free Punch",
    "Tire en zone safe",
    "Non respect du mass RP",
    "Autre...(Entrer la raison)",
}
local outfitcolorByRank = {
	["owner"] = {color = 2, name = "~p~Fondateurs~s~"},
    ["superadmin"] = {color = 2, name = "~r~Administrateurs~s~"},
    ["admin"] = {color = 1, name = "~b~Modérateurs"},
	["mod"] = {color = 3, name = "~g~Helpers"},
}
local selectedColor = 1
local cVarLongC = { "~p~", "~r~", "~o~", "~y~", "~c~", "~g~", "~b~" }
local cVar1, cVar2 = "~y~", "~r~"
local cVarLong = function()
	return cVarLongC[selectedColor]
end
local gamerTags = {}
local voituregive = {}
local LeterFiltre = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "[", "(" }
local filter = 1
local alphaFilter = false
local invincible = false
local crossthemap = false
local affichername = false
local afficherblips = false
local Freeze = false
local superJump = false
local fastSprint = false
local infStamina = false
local Frigo = false
local Frigo2 = false
local godmode = true
local fastSwim = false
local blipsStatus = 0
local StaffMod = false
local invisible = false
local PlayerInZone = 0
local GetBlips = false
local pBlips = {}
local armor = 0
local spec = false
local InStaff = false
local staffModeBol = false
local open = false
local alreadyOpen = false
local doorActionIndex = 1
local engineActionIndex = 1
local engineCoolDown = false
local extraCooldown = false
local doorCoolDown = false
local extraIndex = 1
local extraStateIndex = 1
local convertibleCooldown = false
local beforeStaffOutfit = {}
local reportSQL = 0
local lastHouse = nil
local ownedProperties = {}
local allowed = false
local StaffMod = false
local NoClip = false
local NoClipSpeed = 2.0
local invisible = false
local PlayerInZone = 0
local armor = 0
local players = {}
local checkedgoto = false
local hideTakenReports = false
local selectedReport = nil
local staffmodactive = false
local localReportsTable = {}
local reportCount = 0
local take = 0

local function generateTakenBy(reportID)
    if localReportsTable[reportID].taken then
        return "~s~ | Pris par: ~o~" .. localReportsTable[reportID].takenBy
    else
        return ""
    end
end

local function getIsTakenDisplay(bool)
    if bool then
        return "~g~[DEJA PRIS]~s~ "
    else
        return "~r~[EN ATTENTE]~s~ "
    end
end

RegisterNetEvent("core:pList")
AddEventHandler("core:pList", function(list)
    players = list
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

Notify = function(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, true)
end

GetTargetedVehicle = function(pCoords, ply)
    for i = 1, 200 do
        coordB = GetOffsetFromEntityInWorldCoords(ply, 0.0, (6.281)/i, 0.0)
        targetedVehicle = GetVehicleInDirection(pCoords, coordB)
        if(targetedVehicle ~= nil and targetedVehicle ~= 0)then
            return targetedVehicle
        end
    end
    return
end

generateStaffOutfit = function(model)
    clothesSkin = {}

    local couleur = outfitcolorByRank[playerGroup].color        
    Extasy.ShowNotification("~o~[Staff] ~s~Tenue changée en: "..outfitcolorByRank[playerGroup].name)     
    if model == GetHashKey("mp_m_freemode_01") then
		tenuesuperadmin()   else 	tenuesuperadmin2() end       

    Wait(1000)
        Citizen.CreateThread(function()
        while staffmodactive do
            
            if GetPedTextureVariation(PlayerPedId(), 11) ~= couleur then
                for k,v in pairs(clothesSkin) do
                    TriggerEvent("skinchanger:change", k, v)
                end
                RageUI.Popup({message = "~r~Pourquoi tu essaies de changer de tenue alors que tu es en staff mode ?!"})
            end  
            Wait(2500)
        end
    end)
end

generateplayerOutfit = function(model)
    clothesSkin = {}
    local couleur = outfitcolorByRank[playerGroup].color

    Extasy.ShowNotification("~o~[Staff] ~s~Tenue changée en: ~o~CIVIL ")     

    TriggerEvent('skinchanger:getSkin', function(skin) 
		loadModel("mp_m_freemode_01")   
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)  
		Extasy.ShowAdvancedNotification('~b~90\'s Life~s~', '~r~Admin', 'Tu vien de mettre ta tenue Civil !', 'CHAR_STEVE_TREV_CONF')
	end)
end

GetVehicleInDirection = function(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

ShowMarker = function()
	local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
    local vCoords = GetEntityCoords(veh)
    DrawMarker(2, vCoords.x, vCoords.y, vCoords.z + 1.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 100, 0, 200, 170, 0, 1, 2, 0, nil, nil, 0)
end

startShowCoords = function()
    showCoords = true
    Citizen.CreateThread(function()
        while showCoords do
            local playerPos = GetEntityCoords(GetPlayerPed(-1))
            local playerHeading = GetEntityHeading(GetPlayerPed(-1))
            
			x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
            roundx=tonumber(string.format("%.2f",x))
            roundy=tonumber(string.format("%.2f",y))
            roundz=tonumber(string.format("%.2f",z))
            DrawTxtCoords("~p~X:~p~ "..roundx,0.05,0.00)
            DrawTxtCoords("     ~p~Y:~p~ "..roundy,0.11,0.00)
            DrawTxtCoords("        ~p~Z:~p~ "..roundz,0.17,0.00)
            DrawTxtCoords("             ~p~Angle:~p~ "..GetEntityHeading(PlayerPedId()),0.21,0.00)

            Wait(1)
        end
    end)
end

DrawTxtCoords = function(text,r,z)
    SetTextColour(MainColor.r, MainColor.g, MainColor.b, 255)
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0,0.4)
    SetTextDropshadow(1,0,0,0,255)
    SetTextEdge(1,0,0,0,255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(r,z)
end

RegisterNetEvent("admin:Freeze")
AddEventHandler("admin:Freeze",function()
    FreezeEntityPosition(GetPlayerPed(-1), not Freeze)
    Freeze = not Freeze
end)

RegisterNetEvent("admin:tp")
AddEventHandler("admin:tp",function(coords)
    SetEntityCoords(GetPlayerPed(-1),coords)
end)

DrawPlayerInfo = function(target)
    drawTarget = target
    drawInfo = true
end

StopDrawPlayerInfo = function()
    drawInfo = false
    drawTarget = 0
end

drawNotification = function(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent("CA")
AddEventHandler("CA", function()
	local pos = GetEntityCoords(GetPlayerPed(-1), true)
	ClearAreaOfObjects(pos.x, pos.y, pos.z, 50.0, 0)
end)

soufle = function()
    infStamina = not infStamina

	if infStamina then
		Extasy.ShowNotification("Endurance infini ~g~activé")
	else
		Extasy.ShowNotification("Endurance infini ~r~desactivé")
	end
end

Extasy.KeyboardInput = function(TextEntry, ExampleText, MaxStringLength)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Wait(500)
		blockinput = false
		return result
	else
		Wait(500)
		blockinput = false
		return nil
	end
end

superman = function()
	superJump = not superJump	  
end

RegisterNetEvent("Extasy:envoyer")
AddEventHandler("Extasy:envoyer", function(msg)
	TriggerEvent("Ambiance:PlayUrl", token, "SUCCES", "https://www.youtube.com/watch?v=AiMbf0ovXT4", 1.4, false)
	Wait(1500)
	local head = RegisterPedheadshot(PlayerPedId())
	while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
		Wait(1)
	end
	headshot = GetPedheadshotTxdString(head)
	Extasy.ShowAdvancedNotification('Message du Staff', '~r~Informations', '~r~Raison ~w~: ' ..msg, headshot, 3)
end)

function showNames(bool)
    isNameShown = bool
    if isNameShown then
        Citizen.CreateThread(function()
            while isNameShown do
                local plyPed = PlayerPedId()
                for _, player in pairs(GetActivePlayers()) do
                    local ped = GetPlayerPed(player)
                    if ped ~= plyPed then
                        if #(GetEntityCoords(plyPed, false) - GetEntityCoords(ped, false)) < 10000.0 then
                            gamerTags[player] = CreateFakeMpGamerTag(ped, ('[%s] %s'):format(GetPlayerServerId(player), GetPlayerName(player)), false, false, '', 0)
                            SetMpGamerTagAlpha(gamerTags[player], 0, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 2, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 4, 255)
                            SetMpGamerTagAlpha(gamerTags[player], 7, 255)
                            SetMpGamerTagVisibility(gamerTags[player], 0, true)
                            SetMpGamerTagVisibility(gamerTags[player], 2, true)
                            SetMpGamerTagVisibility(gamerTags[player], 4, NetworkIsPlayerTalking(player))
                            SetMpGamerTagVisibility(gamerTags[player], 7, DecorExistOn(ped, "staffl") and DecorGetInt(ped, "staffl") > 0)
                            SetMpGamerTagColour(gamerTags[player], 7, 55)
                            if NetworkIsPlayerTalking(player) then
                                SetMpGamerTagHealthBarColour(gamerTags[player], 900)
                                SetMpGamerTagColour(gamerTags[player], 4, 900)
                                SetMpGamerTagColour(gamerTags[player], 0, 900)
							else
								SetMpGamerTagHealthBarColour(gamerTags[player], 0)
								SetMpGamerTagColour(gamerTags[player], 4, 0)
								SetMpGamerTagColour(gamerTags[player], 0)
							end
                            if DecorExistOn(ped, "staffl") then
                                SetMpGamerTagWantedLevel(ped, DecorGetInt(ped, "staffl"))
                            end
                        else
                            RemoveMpGamerTag(gamerTags[player])
                            gamerTags[player] = nil
                        end
                    end
                end
                Wait(100)
            end
            for k,v in pairs(gamerTags) do
                RemoveMpGamerTag(v)
            end
            gamerTags = {}
        end)
    end
end

startStaff = function()
	TriggerServerEvent("ExtasyReportMenu:GetReport", token)
	TriggerServerEvent('core:pList', token)

    Citizen.CreateThread(function()
        while staffmodactive do
			for k,v in ipairs(players) do
            	RageUI.Text({message = "~p~Mode staff activé~n~~s~Ton grade: "..outfitcolorByRank[playerGroup].name.."~s~~n~~p~Nombre de joueur(s)~s~ : " ..#players,time_display = 1})
			end
            Wait(1)
        end
    end)

	Citizen.CreateThread(function()
        while staffmodactive do
            Wait(3000)
            TriggerServerEvent('core:pList', token)
        end
    end)
end

openStaffMenu = function()
    if player_staff_menu.open then
        player_staff_menu.open = false
		return
    else
		--while reportSQL == nil do Wait(1) end

		player_staff_menu.open = true
		RageUI.Visible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), true)

        Citizen.CreateThread(function()
			while player_staff_menu.open do
				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main'), true, true, true, function()
					RageUI.Separator("~p~".. GetPlayerName(PlayerId()) .. "∑ ~s~- ~s~Reports traités: ~p~" ..reportSQL.. "")

					RageUI.Checkbox("Activer le mode administration", "Le nombre de reports acctuel est de: ~r~"..reportCount, InStaff, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
						InStaff = Checked;
						if Selected then
							if Checked then
								notifdezub()
								InStaff = true
								StaffMod = true	
								staffmodactive = true	
								TriggerServerEvent("Extasy:StaffInServices", token, true)
							else
							if nombrecheck == 1 then 
								nombrecheck = nombrecheck - 1
								end
								InStaff = false
								StaffMod = false
								staffmodactive = false	
								FreezeEntityPosition(GetPlayerPed(-1), false)
								TriggerServerEvent("Extasy:StaffInServices", token, false)
				
								SetEntityVisible(GetPlayerPed(-1), 1, 0)
								NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 0)
								SetEntityCollision(GetPlayerPed(-1), 1, 1)
							end
						end
					end)

					RageUI.Separator("")

					if InStaff then
						RageUI.Button("Liste des reports [~r~" .. reportCount .. "~s~]", "Que souhaitez-vous faire ?", {RightLabel = "→"},true, function()
						end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_report'))
						RageUI.Button("Liste des joueurs", "Que souhaitez-vous faire ?", { RightLabel = "→" },true, function()
						end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_players_list'))
						RageUI.Button("Actions personnage", "Que souhaitez-vous faire ?", { RightLabel = "→" },true, function()
						end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_action_perso'))
						RageUI.Button("Actions véhicule", "Que souhaitez-vous faire ?", { RightLabel = "→" },true, function()
						end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_gestion_vehicules'))
						if playerGroup == 'owner' or playerGroup == 'superadmin' or playerGroup == 'admin' then
							RageUI.Button("Actions FUN !", "Que souhaitez-vous faire ?", { RightLabel = "→" },true, function()
							end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_funny'))
						else 
							RageUI.ButtonWithStyle("Actions FUN !", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
								if Selected then
								end
							end)
						end
						if playerGroup == 'owner' or playerGroup == 'superadmin' then
							RageUI.Button("Gestion des gangs", nil, {RightLabel = "🔪"}, true, function(Hovered, Active, Selected)
								if Selected then
									TriggerServerEvent("Org:getGangDataForManage", token)
									RageUI.CloseAll()
									Wait(1)
									while orgs_data == {} do Wait(1) end
									RageUI.Visible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_list_org'), true)
								end
							end)    
						else 
							RageUI.ButtonWithStyle("Gestion des gangs", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
								if Selected then
								end
							end) 
						end
					end
				end, function()
				end)
		
				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_report'), true, true, true, function()
					RageUI.Separator("↓ ~p~Paramètres ~s~↓")
					RageUI.Checkbox("Cacher les pris en charge", nil, hideTakenReports, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
						hideTakenReports = Checked;
					end, function()
					end, function()
					end)
					RageUI.Separator("↓ ~p~Reports ~s~↓")
					for sender, infos in pairs(localReportsTable) do
						if infos.taken then
							if hideTakenReports == false then
								RageUI.ButtonWithStyle("[~p~" .. infos.id .. "~s~] → ~s~" .. infos.name, "~n~~y~Description du report~s~ → " .. infos.reason .. "~n~~r~Créé il y a~s~ → "..infos.timeElapsed[1].."m"..infos.timeElapsed[2].."h~n~~b~ID Unique~s~ → #" .. infos.id .. "~n~~o~Pris en charge par~s~: " .. infos.takenBy, { RightLabel = getIsTakenDisplay(infos.taken) }, true, function(_, _, s)
									if s then
										selectedReport = sender
									end
								end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_report_take'))
							end
						else
							RageUI.ButtonWithStyle("[~p~" .. infos.id .. "~s~] → ~s~" .. infos.name, "~n~~y~Description du report~s~ → " .. infos.reason .. "~n~~r~Créé il y a~s~ → "..infos.timeElapsed[1].."m"..infos.timeElapsed[2].."h~n~~b~ID Unique~s~ → #" .. infos.id, { RightLabel = getIsTakenDisplay(infos.taken) }, true, function(_, _, s)
								if s then
									selectedReport = sender
								end
							end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_report_take'))
						end

					end
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_report_take'), true, true, true, function()
					if players[SelectedPlayer] then
						RageUI.Separator("")
						RageUI.Separator(cVar2 .. "Ce joueur n'est plus connecté !")
						RageUI.Separator("")
					else
						if localReportsTable[selectedReport] ~= nil then
							--RageUI.Separator("ID : ~p~["..SelectedPlayer.."]~s~ - Nom du joueurs : ~p~" ..GetPlayerName(GetPlayerFromServerId(SelectedPlayer)))
							RageUI.Separator("↓ ~p~Actions sur le report ~s~↓")
							local infos = localReportsTable[selectedReport]
							if not localReportsTable[selectedReport].taken then
								RageUI.ButtonWithStyle("→ ~s~Prendre en charge ce report", "~y~Description~s~: " .. infos.reason, { RightLabel = "→→" }, true, function(_, _, s)
									if s then
										TriggerServerEvent("Staff:takeReport", token, selectedReport)
									end
								end)
							end
							RageUI.ButtonWithStyle("→ ~s~Cloturer ce report", "~y~Description~s~: " .. infos.reason, { RightLabel = "→→" }, true, function(_, _, s)
								if s then
									TriggerServerEvent("Staff:closeReport", token, selectedReport)
								end
							end)

							RageUI.Separator("↓ ~g~Actions rapides ~s~↓ " ..GetPlayerName(GetPlayerFromServerId(selectedReport)).. " -  id : "..selectedReport)

							RageUI.Checkbox("Spectate", nil, spec,{},function(Hovered,Ative,Selected,Checked)
								if Selected then
									spec = Checked
									if Checked then
										local playerId = GetPlayerFromServerId(selectedReport)
										SpectatePlayer(GetPlayerPed(playerId),playerId)
									else
										local playerId = GetPlayerFromServerId(-1)
										SpectatePlayer(GetPlayerPed(playerId),playerId)
									end
								end
							end)

							RageUI.Button("Lui envoyé un message privé", "~y~Description~s~: " .. infos.reason, {RightLabel = nil}, true, function(Hovered, Active, Selected)
								if (Selected) then
									local msg = Extasy.KeyboardInput("Raison", "", 100)

									if msg ~= nil then
										msg = tostring(msg)
								
										if type(msg) == 'string' then
											TriggerServerEvent("Extasy:Message", token, selectedReport, msg)
										end
									end
									Extasy.ShowNotification("Vous venez d'envoyer le message à ~p~" .. GetPlayerName(GetPlayerFromServerId(selectedReport)))
								end
							end)

							RageUI.Button("Se téléporter à lui", "~y~Description~s~: " .. infos.reason, {}, true, function(Hovered, Active, Selected)
								if (Selected) then
									ExecuteCommand("go "..selectedReport)
									Extasy.ShowNotification('~p~Vous venez de vous Téléporter à~s~ '.. GetPlayerName(GetPlayerFromServerId(selectedReport)))
								end
							end)

							RageUI.Button("Téléporter sur moi", "~y~Description~s~: " .. infos.reason, {}, true, function(Hovered, Active, Selected, target)
								if (Selected) then
									ExecuteCommand("br "..selectedReport)
									Extasy.ShowNotification('~p~Vous venez de Téléporter ~s~ '.. GetPlayerName(GetPlayerFromServerId(selectedReport)) ..' ~p~à vous~s~ !')
								end
							end)

							RageUI.Checkbox("Le Freeze / DeFreeze", "~y~Description~s~: " .. infos.reason, Frigo,{},function(Hovered,Ative,Selected,Checked)
								if Selected then
									Frigo = Checked
									if Checked then
										Extasy.ShowNotification("~r~Joueur Freeze:~s~ "..GetPlayerName(GetPlayerFromServerId(selectedReport)))
										FreezeEntityPosition(GetPlayerPed(GetPlayerFromServerId(selectedReport)), true)
									else
										Extasy.ShowNotification("~r~Joueur Defreeze:~s~ "..GetPlayerName(GetPlayerFromServerId(selectedReport)))
										FreezeEntityPosition(GetPlayerPed(GetPlayerFromServerId(selectedReport)), false)
									end
								end
							end)

							if playerGroup == "superadmin" or playerGroup == "owner" then
								RageUI.Button("Lui Wipe son l'inventaire", "~y~Description~s~: " .. infos.reason, {RightLabel = nil}, true, function(Hovered, Active, Selected)
									if (Selected) then
										ExecuteCommand("clearinventory "..selectedReport)
										Extasy.ShowNotification("Vous venez d'enlever tout les items de ~p~".. GetPlayerName(GetPlayerFromServerId(selectedReport)) .."~s~ !")
									end
								end)
							else
								RageUI.Button("~c~Lui Wipe son l'inventaire", "~y~Description~s~: " .. infos.reason, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
							end

							if playerGroup == "superadmin" or playerGroup == "owner" then
								RageUI.Button("Lui Wipe ses armes", "~y~Description~s~: " .. infos.reason, {RightLabel = nil}, true, function(Hovered, Active, Selected)
									if (Selected) then
										ExecuteCommand("clearloadout "..selectedReport)
										Extasy.ShowNotification("Vous venez de enlever toutes les armes de ~p~".. GetPlayerName(GetPlayerFromServerId(selectedReport)) .."~s~ !")
									end
								end)
							else
								RageUI.Button("~c~Lui Wipe ses armes", "~y~Description~s~: " .. infos.reason, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
							end
			
							else
								RageUI.Separator("")
								RageUI.Separator(cVar2 .. "Ce report n'est plus valide")
								RageUI.Separator("")
							end
						end
				end, function()
				end, 1)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_list_org'), true, true, true, function()

                    RageUI.ButtonWithStyle("Créer un gang", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
							Wait(1)
							--RageUI.CloseAll()
                        end
                    end, RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org'), true)

                    RageUI.Separator("")

                    for k,v in pairs(orgs_data) do
						if v.orgLabel == nil then
							RageUI.ButtonWithStyle("Aucune Organisation", "", {}, false, function(Hovered, Active, Selected)
								if Selected then
								end
							end)
						else
							RageUI.ButtonWithStyle("Org : "..v.orgLabel, "", {}, true, function(Hovered, Active, Selected)
								if Selected then
									orgSelect = v
								end
							end, RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_manage_org'), true)
						end
                    end
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_manage_org'), true, true, true, function()

                    RageUI.ButtonWithStyle("Position du garage",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local plyPos = GetEntityCoords(PlayerPedId())
                            TriggerServerEvent('Org:editGang', token, 'orgGarage', plyPos - vector3(0.0, 0.0, 0.99), orgSelect.orgLabel)
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Position spawn véhicule",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local plyPos = GetEntityCoords(PlayerPedId())
                            TriggerServerEvent('Org:editGang', token, 'orgGSpawn', plyPos - vector3(0.0, 0.0, 0.99), orgSelect.orgLabel)
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Position suppréssion de véhicule",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local plyPos = GetEntityCoords(PlayerPedId())
                            TriggerServerEvent('Org:editGang', token, 'orgGDelete', plyPos - vector3(0.0, 0.0, 0.99), orgSelect.orgLabel)
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Position du menu boss",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local plyPos = GetEntityCoords(PlayerPedId())
                            TriggerServerEvent('Org:editGang', token, 'orgBoss', plyPos - vector3(0.0, 0.0, 0.99), orgSelect.orgLabel)
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Position du coffre",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local plyPos = GetEntityCoords(PlayerPedId())
                            TriggerServerEvent('Org:editGang', token, 'orgChest', plyPos - vector3(0.0, 0.0, 0.99), orgSelect.orgLabel)
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Position du vestiaire",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local plyPos = GetEntityCoords(PlayerPedId())
                            TriggerServerEvent('Org:editGang', token, 'orgWear', plyPos - vector3(0.0, 0.0, 0.99), orgSelect.orgLabel)
                        end
                    end)
					
					RageUI.Separator("")

					if playerGroup == "superadmin" or playerGroup == "owner" then
						RageUI.ButtonWithStyle("~r~Supprimer l'organisation",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
							if Selected then
								local plyPos = GetEntityCoords(PlayerPedId())
								TriggerServerEvent('org:DeleteThisOrg', token, orgSelect.orgLabel)
								Extasy.ShowNotification("~g~Le gang: "..orgSelect.orgLabel.." a bien été supprimé")
								TriggerServerEvent("Org:getGangDataForManage", token)
								RageUI.GoBack()
							end
						end)
					else
						RageUI.ButtonWithStyle("~r~Supprimer l'organisation",nil, {RightLabel = "→"}, false, function(Hovered, Active, Selected)
							if Selected then
							end
						end)
					end
                end, function()
                end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org'), true, true, true, function()
					while Org == nil do Wait(1) end

					RageUI.ButtonWithStyle("Nom de l'organisation (en minuscule)",nil, {RightLabel = Org.orgName}, true, function(Hovered, Active, Selected)
						if Selected then
							Org.orgName = Extasy.KeyboardInput("Nom de l'organisation (en minuscule)", "", 30)
						end
					end)
			
					RageUI.ButtonWithStyle("Nom complèt de l'organisation",nil, {RightLabel = Org.orgLabel}, true, function(Hovered, Active, Selected)
						if Selected then
							Org.orgLabel = Extasy.KeyboardInput("Nom complèt de l'organisation", "", 30)
						end
					end)
			
					RageUI.ButtonWithStyle("Position du garage",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if Active then
                            local pCoords = GetEntityCoords(GetPlayerPed(-1))
                            DrawMarker(6, pCoords.x, pCoords.y, pCoords.z - 0.95, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 100, 0, 200 , 100, false, false)
                        end
						if Selected then
							Org.orgGarage = GetEntityCoords(PlayerPedId()) - vector3(0.0, 0.0, 0.99)
							Extasy.ShowNotification("~g~Garage bien ajouter au coordonées: ~s~"..Org.orgGarage)
						end
					end)

					RageUI.Button("Véhicules dans le garage", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RageUI.CloseAll()
                            Wait(1)
                            RageUI.Visible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org_vehicles_list'), true)
                        end
                    end)
			
					RageUI.ButtonWithStyle("Position spawn véhicule",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if Active then
                            local pCoords = GetEntityCoords(GetPlayerPed(-1))
                            DrawMarker(6, pCoords.x, pCoords.y, pCoords.z - 0.95, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 100, 0, 200 , 100, false, false)
                        end
						if Selected then
							Org.orgGSpawn = GetEntityCoords(PlayerPedId()) - vector3(0.0, 0.0, 0.99)
							Extasy.ShowNotification("~g~Spawn Véhicule bien ajouter au coordonées: ~s~"..Org.orgGSpawn)
						end
					end)
			
					RageUI.ButtonWithStyle("Position de l'action boss",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if Active then
                            local pCoords = GetEntityCoords(GetPlayerPed(-1))
                            DrawMarker(6, pCoords.x, pCoords.y, pCoords.z - 0.95, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 100, 0, 200 , 100, false, false)
                        end
						if Selected then
							Org.orgBoss = GetEntityCoords(PlayerPedId()) - vector3(0.0, 0.0, 0.99)
							Extasy.ShowNotification("~g~Action Boss bien ajouter au coordonées: ~s~"..Org.orgBoss)
						end
					end)
			
					RageUI.ButtonWithStyle("Position du coffre",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if Active then
                            local pCoords = GetEntityCoords(GetPlayerPed(-1))
                            DrawMarker(6, pCoords.x, pCoords.y, pCoords.z - 0.95, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 100, 0, 200 , 100, false, false)
                        end
						if Selected then
							Org.orgChest = GetEntityCoords(PlayerPedId()) - vector3(0.0, 0.0, 0.99)
							Extasy.ShowNotification("~g~Coffre bien ajouter au coordonées: ~s~"..Org.orgChest)
						end
					end)

					RageUI.ButtonWithStyle("Position du vestiaire",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if Active then
                            local pCoords = GetEntityCoords(GetPlayerPed(-1))
                            DrawMarker(6, pCoords.x, pCoords.y, pCoords.z - 0.95, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 100, 0, 200 , 100, false, false)
                        end
						if Selected then
							Org.orgWear = GetEntityCoords(PlayerPedId()) - vector3(0.0, 0.0, 0.99)
							Extasy.ShowNotification("~g~Vestiaire bien ajouter au coordonées: ~s~"..Org.orgWear)
						end
					end)

					RageUI.ButtonWithStyle("Position du rangement véhicule",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if Active then
                            local pCoords = GetEntityCoords(GetPlayerPed(-1))
                            DrawMarker(6, pCoords.x, pCoords.y, pCoords.z - 0.95, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 100, 0, 200 , 100, false, false)
                        end
						if Selected then
							Org.orgGDelete = GetEntityCoords(PlayerPedId()) - vector3(0.0, 0.0, 0.99)
							Extasy.ShowNotification("~g~Rangement Véhicule bien ajouter au coordonées: ~s~"..Org.orgGDelete)
						end
					end)
			
					RageUI.Separator('~p~↓ Action Disponible ↓')

                    RageUI.Button("~g~Créer", nil, {RightLabel = "✅"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            if Org.orgName == nil or Org.orgLabel == nil or Org.orgGarage == nil or Org.orgChest == nil or Org.orgBoss == nil or Org.orgGSpawn == nil or Org.orgGDelete == nil or Org.orgWear == nil then
								Extasy.ShowNotification('~r~Un ou plusieurs champs n\'ont pas été défini !')
							else
								TriggerServerEvent('Org:createNewOrg', token, Org)
								Extasy.ShowNotification("~g~Gang créé avec succès\nAttribuez vous le rôle avec toutes les permissions et faites un déco/reco")
								Org.Name = nil
								Org.Label = nil
								Org.orgGarage = nil
								Org.orgVehicles = nil
								Org.orgBoss = nil
								Org.orgChest = nil
								Org.orgGSpawnVeh = nil
								TriggerServerEvent("Extasy:InitialiseBddForOrg")
							end
                        end
                    end)
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org_activity_list_weapon_list'), true, true, true, function()
                    
                    RageUI.Button("Ajouter des armes", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end, RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org_activity_list_weapon_list_choose'))

                    RageUI.Separator("")

                    for k,v in pairs(ORG.activity.weapons) do
                        RageUI.Button(GetPlayerName(GetPlayerFromServerId(v)), "Appuyez sur SUPR pour supprimer cette arme\nAppuyez sur ←→ pour changer le prix de l'arme", {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                            if Active then
                                if IsControlJustPressed(1, 214) then
                                    table.remove(ORG.activity.weapons, k)
                                end
                                if IsControlJustPressed(1, 307) then
                                    v.price = v.price + 5000
                                end
                                if IsControlJustPressed(1, 308) then
                                    v.price = v.price - 5000
                                end
                            end
                        end)
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org_activity_list_weapon_list_choose'), true, true, true, function()

                    for k,v in pairs(coreItems) do
                        if string.sub(GetPlayerName(GetPlayerFromServerId(v)), 1, string.len("WEAPON_")) == "WEAPON_" then 
                            RageUI.Button(v.label, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    table.insert(ORG.activity.weapons, {
                                        name  = v.label,
                                        item  = GetPlayerName(GetPlayerFromServerId(v)),
                                        price = 5000,
                                    })
                                    RageUI.GoBack()
                                end
                            end)
                        end
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org_activity_list'), true, true, true, function()
                    
                    RageUI.Button("Trafic d'armes", "En cliquant sur ce bouton, vous définissez la position de l'activité à votre position", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local pCoords = GetEntityCoords(GetPlayerPed(-1))

                            ORG.activity = {}
                            ORG.activity = {
                                activity = 'weapon_shop',
                                x = pCoords.x,
                                y = pCoords.y,
                                z = pCoords.z - 0.95,
                                weapons = {}
                            }
                        end
                    end)
                    RageUI.Button("Mécano illégal", "En cliquant sur ce bouton, vous définissez la position de l'activité à votre position", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local pCoords = GetEntityCoords(GetPlayerPed(-1))

                            ORG.activity = {}
                            ORG.activity = {
                                activity = 'mecano_illegal',
                                x = pCoords.x,
                                y = pCoords.y,
                                z = pCoords.z - 0.95
                            }
                        end
                    end)
                    RageUI.Button("Aucune", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            ORG.activity = {}
                            ORG.activity = {
                                activity = 'none'
                            }
                        end
                    end)

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org_ranks_list'), true, true, true, function()
                    
                    RageUI.Button("Ajouter un grade", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local result = Extasy.KeyboardInput("Comment voulez-vous l'appeler ?", "", 300)
                            if result ~= nil then
                                table.insert(ORG.ranks, {
                                    name  = result,
                                    num   = 0,
                                    boss  = false,
                                    chest = true,
                                    garage = true,
                                    putChest = true,
                                    takeChest = true,
                                    ranks = true,
                                    wear = true,
                                    allWear = true,
                                    activity = true,
                                })
                            end
                        end
                    end)
                    RageUI.Separator("")
                    for k,v in pairs(ORG.ranks) do
                        local t = {}
                        if v.boss then
                            t[k] = "Appuyez sur SUPR pour supprimer ce grade\nAppuyez sur ←→ changer le numéro de grade\nAppuyez sur F pour donner les permissions\n~r~Ce grade aura tous les droits"
                        else
                            t[k] = "Appuyez sur SUPR pour supprimer ce grade\nAppuyez sur ←→ changer le numéro de grade\nAppuyez sur F pour donner les permissions"
                        end

                        RageUI.Button(GetPlayerName(GetPlayerFromServerId(v)), t[k], {RightLabel = v.num}, true, function(Hovered, Active, Selected)
                            if Active then
                                if IsControlJustPressed(1, 214) then
                                    table.remove(ORG.ranks, k)
                                end
                                if IsControlJustPressed(1, 307) then
                                    v.num = v.num + 1
                                end
                                if IsControlJustPressed(1, 308) then
                                    v.num = v.num - 1
                                end
                                if IsControlJustPressed(1, 145) then
                                    v.boss = not v.boss
                                end
                            end
                        end)
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org_vehicles_list'), true, true, true, function()
                    
                    RageUI.Button("Ajouter un véhicule", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RageUI.CloseAll()
                            Wait(1)
                            RageUI.Visible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org_vehicles_list_choose'), true)
                        end
                    end)
                    RageUI.Separator("")
					for k,v in pairs(Org.orgVehicles) do
						RageUI.Button(v.name, "Appuyez sur ← pour supprimer ce véhicule", {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
							if Active then
								if IsControlJustPressed(1, 308) then
									table.remove(Org.orgVehicles, k)
								end
							end
						end)
					end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'main_menu_staff_create_org_vehicles_list_choose'), true, true, true, function()

                    for k,v in pairs(cfg_org.vehicles) do
                        RageUI.Button(v.cat_name, nil, {}, true, function(Hovered, Active, Selected) end, RMenu:Get('Extasy_player_staff_menu', v.value.."_org"))
                    end
                
                end, function()
                end)

                for k,v in pairs(cfg_org.vehicles) do
                    RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', v.value.."_org"), true, true, true, function()
        
                        for k,la in pairs(v.vehicles) do
                            if la.capacity ~= nil then
                                RageUI.Button(la.name, nil, {RightLabel = "~c~"..la.capacity.."KG"}, true, function(h, a, s)
                                    if s then
                                        table.insert(Org.orgVehicles, {
                                            name  = la.name,
                                            hash  = la.hash,
                                            color = 1,
                                        })
										Extasy.ShowNotification("~g~Véhicule: ~s~"..la.name.." ~g~ajouter avec succès")
                                    end
                                end)
                            else
                                RageUI.Button(la.name, nil, {RightLabel = "~c~N/A.KG"}, true, function(h, a, s)
                                    if s then
                                        table.insert(Org.orgVehicles, {
                                            name  = la.name,
                                            hash  = la.hash,
                                            color = 1,
                                        })
										Extasy.ShowNotification("~g~Véhicule: "..la.name.." ajouter avec succès")
                                    end
                                end) 
                            end
                        end
        
                    end, function()
                    end)
                end
				
				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_action_perso'), true, true, true, function()
					RageUI.Checkbox("NoClip", nil, playerIsNoclip, {}, function(Hovered, Active, Selected, clip)
                        playerIsNoclip = clip
                        if (Selected) then
                            if not playerIsNoclip then
                                local object = UIInstructionalButton.__constructor()

                                noclip = false
                                SetEntityVisible(GetPlayerPed(-1), 1, 0)
                                SetEntityInvincible(GetPlayerPed(-1), 0)

                                object:Delete("Ralentir", 62)
                                object:Delete("Turbo", 21)
                                object:Delete("Avancer", 129)
                                object:Delete("Reculer", 78)
                                object:Delete("Message de zone", 19)
                            else
                                setNoClip()
                            end
                        end
                    end)
					--[[RageUI.Checkbox("Super Sprint", description, fastSprint,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							fastSprint = Checked
							if Checked then
								SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
							else
								SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
							end
						end
					end)--]]

					RageUI.Checkbox("Afficher les Noms", description, affichername,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							affichername = Checked
							if Checked then
								showNames(true)
							else
								showNames(false)
							end
						end
					end)

					RageUI.Checkbox("Afficher/Cacher coordonnées [DEV]", nil, player_staff_menu.show_coords, {}, function(Hovered, Active, Selected, clip)
                        player_staff_menu.show_coords = clip
                        if (Selected) then
                            if not player_staff_menu.show_coords then
                                showCoords = false
                            else
                                startShowCoords()
                            end
                        end
                    end)

					RageUI.Button("Se téléporter sur un marqueur [F10]", nil, {}, true, function(_, _, Selected)
						if Selected then
							local playerPed = GetPlayerPed(-1)
							local WaypointHandle = GetFirstBlipInfoId(8)
							if DoesBlipExist(WaypointHandle) then
								local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
								SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, coord.z, false, false, false, true)
							end
						end
					end)

					RageUI.Button("S'octroyer du Blindage", description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							SetPedArmour(GetPlayerPed(-1), 200)
							Extasy.ShowNotification("~p~Vous venez de vous octroyer du Blindage~w~")
						end
					end)

					RageUI.Button("S'octroyer de ~g~l'argent cash", description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							GiveCash()
							Extasy.ShowNotification("~p~Vous venez de vous Give du ~g~cash~w~")
						end
					end)

					RageUI.Button("S'octroyer de ~b~l'argent banque", description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							GiveBanque()
							Extasy.ShowNotification("~p~Vous venez de vous Give de ~b~l'argent en banque~w~")
						end
					end)

					RageUI.Button("S'octroyer de ~r~l'argent sale", description, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							GiveND()
							Extasy.ShowNotification("~p~Vous venez de vous Give de ~r~l'argent sale~w~")
						end
					end)

					RageUI.Separator("↓ ~p~Autres Intéractions ~s~↓", nil, {}, true, function(Hovered, Active, Selected)
					end)

					RageUI.Button("Nettoyer le Chat", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                        ExecuteCommand("clearall")
						Extasy.ShowNotification("~p~Vous venez de Nettoyer le Chat~w~")
                        end
                    end)

					RageUI.Button("Nettoyer la rue (VOITURE)", nil, {RightLabel = "📎"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("dv 50")
							Extasy.ShowNotification("~p~Vous venez de Nettoyer la rue (LES VOITURE)~w~")
						end
					end)
	
					RageUI.Button("Nettoyer les props de la zone", nil, {RightLabel = "📎"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local props = {}
							for v in EnumerateObjects() do
								if NetworkGetEntityIsNetworked(v) then
									table.insert(props, ObjToNet(v))
								else
									DeleteEntity(v)
								end
							end
							TriggerServerEvent('DeleteEntityTable', token, props)
							Extasy.ShowNotification("~p~Vous venez de Nettoyer les props de la zone~w~")
						end
					end)
	
					RageUI.Button("Supprimer les PNJ de la zone", nil, {RightLabel = "📎"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local props = {}
							for v in EnumeratePeds() do
								if not IsPedAPlayer(v) then
									if NetworkGetEntityIsNetworked(v) then
										table.insert(props, ObjToNet(v))
										if IsPedInAnyVehicle(v, false) then
											table.insert(props, ObjToNet(GetVehiclePedIsIn(v, false)))
										end
									else
										DeleteEntity(v)
									end
								end
							end
							TriggerServerEvent('Extasy:ClearAreaFromObjects', token, props)
							Extasy.ShowNotification("~p~Vous venez de Supprimer les PNJ de la zone~w~")
						end
					end)
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_money'), true, true, true, function()

					if playerGroup == "superadmin" or playerGroup == "owner" then
						RageUI.ButtonWithStyle("Donner de l'argent (~g~liquide~s~)", nil, { RightLabel = "" }, true, function(_, _, s)
							if s then
								local i = Extasy.KeyboardInput("Quantité", "", 200, true)
								if i ~= nil then
									Extasy.ShowNotification("~g~Vous venez d'ajouter "..i.."$ à ce joueurs")
									TriggerServerEvent("Extasy:addMoney", token, IdSelected.id, i)
									RageUI.GoBack()
								end
							end
						end)
					else
						RageUI.Button("~c~Lui Wipe de l'argent (~g~liquide~s~)", "~y~Description~s~: " .. infos.reason, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
					end

					if playerGroup == "superadmin" or playerGroup == "owner" then
						RageUI.ButtonWithStyle("Retirer de l'argent (~g~liquide~s~)", nil, { RightLabel = "" }, true, function(_, _, s)
							if s then
								local i = Extasy.KeyboardInput("Quantité", "", 200, true)
								if i ~= nil then
									Extasy.ShowNotification("~g~Vous venez de retirer "..i.."$ à ce joueurs")
									TriggerServerEvent("Extasy:removeMoney", token, IdSelected.id, i)
									RageUI.GoBack()
								end
							end
						end)
					else
						RageUI.Button("~c~Lui Wipe de l'argent (~g~liquide~s~)", "~y~Description~s~: " .. infos.reason, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
					end

				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_sale'), true, true, true, function()

					if playerGroup == "superadmin" or playerGroup == "owner" then
						RageUI.ButtonWithStyle("Donner de l'argent (~s~sale~s~)", nil, { RightLabel = "" }, true, function(_, _, s)
							if s then
								local i = Extasy.KeyboardInput("Quantité", "", 200, true)
								if i ~= nil then
									Extasy.ShowNotification("~g~Vous venez d'ajouter "..i.."$ à ce joueurs")
									TriggerServerEvent("Extasy:addMoneysale", token, IdSelected.id, i)
									RageUI.GoBack()
								end
							end
						end)
					else
						RageUI.Button("~c~Lui Wipe de l'argent (~s~sale~s~)", "~y~Description~s~: " .. infos.reason, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
					end

					if playerGroup == "superadmin" or playerGroup == "owner" then
						RageUI.ButtonWithStyle("Retirer de l'argent (~s~sale~s~)", nil, { RightLabel = "" }, true, function(_, _, s)
							if s then
								local i = Extasy.KeyboardInput("Quantité", "", 200, true)
								if i ~= nil then
									Extasy.ShowNotification("~g~Vous venez de retirer "..i.."$ à ce joueurs")
									TriggerServerEvent("Extasy:removeMoneysale", token, IdSelected.id, i)
									RageUI.GoBack()
								end
							end
						end)
					else
						RageUI.Button("~c~Lui Wipe de l'argent (~s~sale~s~)", "~y~Description~s~: " .. infos.reason, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
					end


				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_bank'), true, true, true, function()

					if playerGroup == "superadmin" or playerGroup == "owner" then
						RageUI.ButtonWithStyle("Donner de l'argent (~b~bank~s~)", nil, { RightLabel = "" }, true, function(_, _, s)
							if s then
								local i = Extasy.KeyboardInput("Quantité", "", 200, true)
								if i ~= nil then
									Extasy.ShowNotification("~g~Vous venez d'ajouter "..i.."$ à ce joueurs")
									TriggerServerEvent("Extasy:addMoneybank", token, IdSelected.id, i)
									RageUI.GoBack()
								end
							end
						end)
					else
						RageUI.Button("~c~Lui Wipe de l'argent (~b~bank~s~)", "~y~Description~s~: " .. infos.reason, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
					end

					if playerGroup == "superadmin" or playerGroup == "owner" then
						RageUI.ButtonWithStyle("Retirer de l'argent (~s~bank~s~)", nil, { RightLabel = "" }, true, function(_, _, s)
							if s then
								local i = Extasy.KeyboardInput("Quantité", "", 200, true)
								if i ~= nil then
									Extasy.ShowNotification("~g~Vous venez de retirer "..i.."$ à ce joueurs")
									TriggerServerEvent("Extasy:removeMoneybank", token, IdSelected.id, i)
									RageUI.GoBack()
								end
							end
						end)
					else
						RageUI.Button("~c~Lui Wipe de l'argent (~b~bank~s~)", "~y~Description~s~: " .. infos.reason, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
					end

				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_inv'), true, true, true, function() -- A fainir (menu trisoxx)

					RageUI.Separator("↓ ~p~Objets ~s~↓")

					for k,v  in pairs(Items) do
						RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "~g~x"..v.right}, true, function(_, _, s)
							if s then
								local combien = Extasy.KeyboardInput("Combien ?", '' , '', 100)
								if tonumber(combien) > v.amount then
									Extasy.ShowNotification("~r~Quantité invalide")
								else
									TriggerServerEvent('admin:RemoveItemForPlayerInventory', token, IdSelected.id, v.itemType, v.value, tonumber(combien))
								end
								RageUI.GoBack()
							end
						end)
					end

					RageUI.Separator("↓ ~p~Armes ~s~↓")

					for k,v  in pairs(Armes) do
						RageUI.ButtonWithStyle(v.label, nil, {RightLabel = "avec ~g~"..v.right.. " ~s~balle(s)"}, true, function(_, _, s)
							if s then
								local combien = Extasy.KeyboardInput("Combien ?", '' , '', 100)
								if tonumber(combien) > v.amount then
									Extasy.ShowNotification("~r~Quantité invalide")
								else
									TriggerServerEvent('admin:RemoveItemForPlayerInventory', token, IdSelected.id, v.itemType, v.value, tonumber(combien))
								end
								RageUI.GoBack()
							end
						end)
					end

				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_players_list'), true, true, true, function()
					RageUI.Checkbox("Ma zone uniquement", "Afficher uniquement les joueurs de votre zone", showAreaPlayers, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
						showAreaPlayers = Checked;
					end, function()
					end, function()
					end)
					RageUI.Checkbox("🔎 Filtre alphabétique", nil, alphaFilter, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
						alphaFilter = Checked;
					end, function()
					end, function()
					end)
	
					if alphaFilter then
						RageUI.List("🔎 Filtre:", LeterFiltre, filter, nil, {}, true, function(_, _, _, i)
							filter = i
						end)
					end

					RageUI.Separator("↓ ~p~Joueurs ~s~↓")
					if not showAreaPlayers then
						for k, v in ipairs(players) do
							--if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then table.remove(players, k) end
							if alphaFilter then
								--[[if startsFiltre(v.name:lower()), LeterFiltre[filter]:lower() then		
									RageUI.Button("["..v.id.."] - "..v.name), nil, {}, true, function(Hovered, Active, Selected)
										if (Selected) then
											IdSelected = v
											TriggerServerEvent("Extasy:getAllInfoForIdSelected", token, IdSelected)
											while playerInv == nil do Wait(1) end
										end
									end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_possible_action'))
								end--]]
							else
								RageUI.Button("["..v.id.."] - "..v.name, nil, {RightLabel = ""}, true, function(_,_,s)
									if s then
										IdSelected = v
										TriggerServerEvent("Extasy:getAllInfoForIdSelected", token, IdSelected.id)
										while playerInv == nil do Wait(1) end
									end
								end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_possible_action'))
							end
						end
					else 
						for k, v in ipairs(players) do
							--if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then table.remove(players, k) end
							RageUI.Button("["..v.id.."] - "..v.name, nil, {RightLabel = ""}, true, function(_,_,s)
								if s then
									IdSelected = v
									TriggerServerEvent("Extasy:getAllInfoForIdSelected", token, IdSelected.id)
									while playerInv == nil do Wait(1) end
								end
							end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_possible_action'))
						end
					end
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_possible_action'), true, true, true, function()

					RageUI.Separator("~p~Nom~s~: "..IdSelected.name)

					RageUI.Separator("~p~Id~s~: "..IdSelected.id)

					RageUI.Button("Argent : ~g~"..playerMoney, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_money'))

					RageUI.Button("Argent sale : ~r~"..playerBlackMoney, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_sale'))

					RageUI.Button("Argent en bank : ~b~"..playerBankMoney, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
					end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_bank'))

					RageUI.Button("Inventaire : ", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
							playerId = GetPlayerFromServerId(IdSelected.id)
							getPlayerInv(playerId)
						end
					end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_inv'))

					RageUI.Separator("↓ ~p~Actions possible ~s~↓", nil, {}, true, function(Hovered, Active, Selected)
					end)

					RageUI.Checkbox("Spectate", nil, spec,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							spec = Checked
							if Checked then
								print(IdSelected.id)
								local playerId = GetPlayerFromServerId(IdSelected.id)
								SpectatePlayer(GetPlayerPed(playerId), playerId, IdSelected.name)
							else
								local playerId = GetPlayerFromServerId(-1)
								SpectatePlayer(GetPlayerPed(playerId), playerId, IdSelected.name)
							end
						end
					end)

					RageUI.Button("Lui envoyé un message privé", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
						if (Selected) then
							local msg = Extasy.KeyboardInput("Raison", "", 100)

							if msg ~= nil then
								msg = tostring(msg)
						
								if type(msg) == 'string' then
									TriggerServerEvent("ExtasyMessage", token, IdSelected.id, msg)
								end
							end
							Extasy.ShowNotification("Vous venez d'envoyer le message à ~b~" .. IdSelected.name)
						end
					end)

					RageUI.Button("Se téléporter à lui", nil, {}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("go "..IdSelected.id)
							Extasy.ShowNotification('~p~Vous venez de vous Téléporter à~s~ '.. IdSelected.name ..'')
						end
					end)

					RageUI.Button("Téléporter sur moi", nil, {}, true, function(Hovered, Active, Selected, target)
						if (Selected) then
							ExecuteCommand("br "..IdSelected.id)
							Extasy.ShowNotification('~p~Vous venez de Téléporter ~s~ '.. IdSelected.name ..' ~b~à vous~s~ !')
						end
					end)

					RageUI.Checkbox("Le Freeze / DeFreeze", description, Frigo,{},function(Hovered,Ative,Selected,Checked)
						if Selected then
							Frigo = Checked
							if Checked then
								Extasy.ShowNotification("~r~Joueur Freeze ("..IdSelected.name..")")
								FreezeEntityPosition(GetPlayerPed(GetPlayerFromServerId(IdSelected.id)), true)
							else
								Extasy.ShowNotification("~r~Joueur Defreeze ("..IdSelected.name..")")
								FreezeEntityPosition(GetPlayerPed(GetPlayerFromServerId(IdSelected.id)), false)
							end
						end
					end)

					if playerGroup == "superadmin" or playerGroup == "owner" then
						RageUI.Button("Lui Wipe son l'inventaire", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								ExecuteCommand("clearinventory "..IdSelected.id)
								Extasy.ShowNotification("Vous venez d'enlever tout les items de ~b~".. IdSelected.name .."~s~ !")
							end
						end)
					else
						RageUI.Button("~c~Lui Wipe son l'inventaire", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
					end

					if playerGroup == "superadmin" or playerGroup == "owner" then
						RageUI.Button("Lui Wipe ses armes", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
							if (Selected) then
								ExecuteCommand("clearloadout "..IdSelected.id)
								Extasy.ShowNotification("Vous venez de enlever toutes les armes de ~b~".. IdSelected.name .."~s~ !")
							end
						end)
					else
						RageUI.Button("~c~Lui Wipe ses armes", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
					end

				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'warn'), true, true, true, function()
					for k,v in ipairs(ServersIdSession) do
						if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then table.remove(ServersIdSession, k) end
						RageUI.Button("["..v.."] - "..GetPlayerName(GetPlayerFromServerId(v)), nil, {}, true, function(Hovered, Active, Selected)
							if (Selected) then
								IdSelected = v
							end
						end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_sanction'))
					end
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_sanction'), true, true, true, function()
					RageUI.Separator("ID : ["..IdSelected.id.."]", nil, {}, true, function(Hovered, Active, Selected)
					end)

					RageUI.Separator("Joueur : "..IdSelected.name, nil, {}, true, function(Hovered, Active, Selected)
					end)

					RageUI.Separator(" (3 Warn = Ban) ", nil, {}, true, function(Hovered, Active, Selected)
					end)

					RageUI.Separator(" ↓ ~r~Raison du warn ~s~↓ ", nil, {}, true, function(Hovered, Active, Selected)
					end)
		
					for k,v in pairs(WarnType) do
						RageUI.Button(""..v, nil, {}, true, function(Hovered, Active, Selected)
							if Selected then
								if v == "Autre...(Entrer la raison)" then
									AddTextEntry("Entrer la raison", "")
									DisplayOnscreenKeyboard(1, "Entrer la raison", '', "", '', '', '', 128)
								
									while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
										Wait(0)
									end
								
									if UpdateOnscreenKeyboard() ~= 2 then
										raison = GetOnscreenKeyboardResult()
										Wait(1)
									else
										Wait(1)
									end
									TriggerServerEvent("STAFFMOD:RegisterWarn", token, IdSelected.id, raison)
								else
									TriggerServerEvent("STAFFMOD:RegisterWarn", token, IdSelected.id, v)
								end
							end
						end)
					end
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_gestion_vehicules'), true, true, true, function()

					RageUI.Button("Réparer le véhicule", "Permet de réparer le véhicule le plus proche.", { RightBadge = RageUI.BadgeStyle.Car }, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							NetworkRequestControlOfEntity(veh)
							while not NetworkHasControlOfEntity(veh) do
								Wait(1)
							end
							SetVehicleFixed(veh)
							SetVehicleDeformationFixed(veh)
							SetVehicleDirtLevel(veh, 0.0)
							SetVehicleEngineHealth(veh, 1000.0)
							Extasy.ShowNotification("~g~Véhicule réparé")
						end   
					end) 

					RageUI.ButtonWithStyle("Mettre le véhicule en fourrière", "Permet de Mettre le véhicule le plus proche en fourrière.", { RightBadge = RageUI.BadgeStyle.Car }, true, function(_, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then
							ExecuteCommand("dv 5")
						end
					end)
					
					RageUI.ButtonWithStyle("Retourner le véhicule", "Permet de Retourner le véhicule le plus proche.", { RightBadge = RageUI.BadgeStyle.Car }, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local plyCoords = GetEntityCoords(plyPed)
							local newCoords = plyCoords + vector3(0.0, 2.0, 0.0)
							local closestVeh = GetClosestVehicle(plyCoords, 10.0, 0, 70)
				
							SetEntityCoords(closestVeh, newCoords)
						end   
					end) 
					
					RageUI.ButtonWithStyle("Custom au maximum", "Permet de customisé au max votre véhicule.", { RightBadge = RageUI.BadgeStyle.Car }, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							FullVehicleBoost()
						end   
					end) 

					RageUI.Button("Changer la plaque", "Changer la plaque de son véhicule.", { RightBadge = RageUI.BadgeStyle.Car }, true, function(_, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then
							if GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil) then
								local plaqueVehicule = Extasy.KeyboardInput("Plaque", "", 8)
								SetVehicleNumberPlateText(GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), false) , plaqueVehicule)
								Extasy.ShowNotification("La plaque du véhicule est désormais : ~g~"..plaqueVehicule)
							else
								Extasy.ShowNotification("~r~Erreur\n~s~Vous n'êtes pas dans un véhicule !")
							end
						end
					end)

					RageUI.Button("Crever un pneu aléatoire", nil, { RightBadge = RageUI.BadgeStyle.Car }, true, function(_, Active, Selected)
						if Active then
							ShowMarker()
						end
                        if Selected then
                            local pPed = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), false)
                            local pVeh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), false)

                            SetVehicleTyreBurst(pVeh, math.random(0, 7), true, 1000.0)
                        end
                    end)

					if superadmin then
						RageUI.Button("Se donner un véhicule (avec clé)", nil, { RightBadge = RageUI.BadgeStyle.Car }, true, function(_, _, Selected)
						if Selected then
			
							local ped = GetPlayerPed(tgt)
							local ModelName = Extasy.KeyboardInput("Véhicule", "", 100)
			
							if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
								RequestModel(ModelName)
								while not HasModelLoaded(ModelName) do
									Wait(0)
								end
									local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(GetPlayerPed(-1)), GetEntityHeading(GetPlayerPed(-1)), true, true)
									TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
									give_vehi(ModelName)
									Wait(50)
							else
								ShowNotification("Erreur !")
							end
						end
						end)
					else
						RageUI.Button("~c~Se donner un véhicule [avec clé]", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
					end
	
					if superadmin then
						RageUI.Button("Retirer un véhicule [Clés]", nil, { RightBadge = RageUI.BadgeStyle.Car }, true, function(_, _, Selected)
							if Selected then
				
								local plaque = Extasy.KeyboardInput("Plaque du véhicule", "", 100)
				
								ExecuteCommand("delcarplate "..plaque)
							end
						end)
					else
						RageUI.Button("~c~Retirer un véhicule [Clés]", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected) end)
					end

					RageUI.Button("Changer la couleur", nil, {RightLabel = "→"},true, function()
					end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_custom_colors'))

				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_custom_colors'), true, true, true, function()
					RageUI.Button("Bleu", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 0, 0, 255)
							SetVehicleCustomSecondaryColour(vehicle, 0, 0, 255)
						end      
					end)
					RageUI.Button("Rouge", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 110, 0, 0)
							SetVehicleCustomSecondaryColour(vehicle, 110, 0, 0)
						end      
					end)
					RageUI.Button("Vert", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then  
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 0, 255, 0)
							SetVehicleCustomSecondaryColour(vehicle, 0, 255, 0)
						end      
					end)
					RageUI.Button("Noir", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 0, 0, 0)
							SetVehicleCustomSecondaryColour(vehicle, 0, 0, 0)
						end      
					end)
					RageUI.Button("Rose Clair", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 100, 0, 60)
							SetVehicleCustomSecondaryColour(vehicle, 100, 0, 60)
						end      
					end)
					RageUI.Button("Blanc", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
							SetVehicleCustomSecondaryColour(vehicle, 255, 255, 255)
						end      
					end)
					RageUI.Button("Gris", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 96, 96, 96)
							SetVehicleCustomSecondaryColour(vehicle, 96, 96, 96)
						end      
					end)
					RageUI.Button("Marron", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 88, 41, 0)
							SetVehicleCustomSecondaryColour(vehicle, 88, 41, 0)
						end      
					end)
					RageUI.Button("Orange", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 237, 127, 16)
							SetVehicleCustomSecondaryColour(vehicle, 237, 127, 16)
						end      
					end)
					RageUI.Button("Violet", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 102, 0, 153)
							SetVehicleCustomSecondaryColour(vehicle, 102, 0, 153)
						end      
					end)
					RageUI.Button("Jaune", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 255, 255, 0)
							SetVehicleCustomSecondaryColour(vehicle, 255, 255, 0)
						end      
					end)
					RageUI.Button("Rose", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							local vehicle = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
							SetVehicleCustomPrimaryColour(vehicle, 253, 108, 158)
							SetVehicleCustomSecondaryColour(vehicle, 253, 108, 158)
						end      
					end)
				 
			   end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_peds'), true, true, true, function()
					RageUI.Button("Reprendre son personnage", nil, {RightLabel = "👔"}, true, function(Hovered, Active, Selected)
						if Active then
							ShowMarker()
						end
						if Selected then   
							ExecuteCommand("e me")
							TriggerEvent("eCore:AfficherBar", 1400, "⏳ Changement en cours...")
							Wait(1400)
							TriggerEvent("skinchanger:getSkin", function(skin)
								TriggerEvent("skinchanger:LoadForTheFirsTime", skin)
							end)
						end
					end)

					RageUI.Button("Entrer un ped custom", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then   
						local j1 = PlayerId()
						local newped = Extasy.KeyboardInput('Entrer le nom de votre Ped', '', 45)
						local p1 = GetHashKey(newped)

						RequestModel(p1)

						while not HasModelLoaded(p1) do
						  	Wait(100)
						end
						 	SetPlayerModel(j1, p1)
						 	SetModelAsNoLongerNeeded(p1)
						end      
					end)

					RageUI.Separator("↓ ~p~Peds Customs ~s~↓")

					for k,v in pairs(cfg_menustaff.AvailablePeds) do
						RageUI.Button(v.name, "Appuyé sur ~g~ENTRÉE~s~ pour valider le choix de ~g~"..v.name.."", {RightLabel = "→"}, true, function(h, a, s)
							if s then   
								Extasy.ShowAdvancedNotification("Informations 90's Life", "Personnage", "Vous avez appliqué le ped "..v.name.." sur vous !", "CHAR_SERVER")
								local j1 = PlayerId()
								local p1 = GetHashKey(v.model)
								RequestModel(p1)
								while not HasModelLoaded(p1) do
									Wait(100)
								end
								SetPlayerModel(j1, p1)
								SetModelAsNoLongerNeeded(p1)
							end      
						end)
					end

					RageUI.Separator("↓ ~p~Sélection rapide ~s~↓")

					for k,v in pairs(cfg_org.pedList) do
						RageUI.Button(v, nil, {}, true, function(h, a, s)
							if s then   
								local j1 = PlayerId()
								local p1 = GetHashKey(v)
								RequestModel(p1)
								while not HasModelLoaded(p1) do
									Wait(100)
								end
								SetPlayerModel(j1, p1)
								SetModelAsNoLongerNeeded(p1)
							end      
						end)
					end

				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_funny'), true, true, true, function()
					RageUI.Button("Gestion de la météo", "Que souhaitez-vous faire ?", { RightLabel = "→" },true, function()
					end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_manage_time'))
					RageUI.Button("Téléportation", "Que souhaitez-vous faire ?", { RightLabel = "→" },true, function()
					end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_tp'))
					RageUI.Button("Menu peds funny", "Que souhaitez-vous faire ?", { RightLabel = "→" },true, function()
					end, RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_player_peds'))
					RageUI.Button("Crée un événement", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if Selected then   
							ExecuteCommand("missionsbuilder")
						end      
					end)
				end, function()
				end)

				RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_manage_time'), true, true, true, function()

					RageUI.Button("Choisir une heure", "Format → heures (espace) minutes", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
						if (Selected) then
						local heure = Extasy.KeyboardInput('Entrer l\'heure que vous souhaiter', '', 45)
							ExecuteCommand("timeadmin "..heure)
						end
					end)

					RageUI.Button("Bloqué le temps", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("freezetimeadmin")
						end
					end)
			
					RageUI.Button("Soleil plein", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weatheradmin EXTRASUNNY")
						end
					end)

					RageUI.Button("Temps dégagé", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weatheradmin CLEAR")
						end
					end)

					RageUI.Button("Temps neutre", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						  if (Selected) then
							ExecuteCommand("weatheradmin NEUTRAL")
						  end
					  end)

					RageUI.Button("Temps halloween", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weatheradmin HALLOWEEN")
						end
					end)

					RageUI.Button("Temps de neige", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weatheradmin XMAS")
						end
					end)


					RageUI.Button("Temps de pluit", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weatheradmin RAIN")
						end
					end)

					RageUI.Button("Temps nuageux", nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
						if (Selected) then
							ExecuteCommand("weatheradmin CLOUDS")
						end
					end)
			  
			end, function()
			end)

			RageUI.IsVisible(RMenu:Get('Extasy_player_staff_menu', 'staff_menu_main_tp'), true, true, true, function()

				RageUI.Button("Animalerie", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp 3789.52 7483.63 17.182")
					end
				end)

				RageUI.Button("Ammunation", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp 3405.853 4688.603 9.952331")
					end
				end)

				RageUI.Button("Weazel-News", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp 2282.503 7554.618 10.09798")
					end
				end)

				RageUI.Button("Post OP", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp 2391.743 4912.455 10.4532")
					end
				end)

				RageUI.Button("Vice City Customs", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp 2384.884 6479.416 10.22331")
					end
				end)

				RageUI.Button("Station Services 24/7", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp 3285.913 5134.854 9.425382")
					end
				end)

				RageUI.Button("Coiffeur / Barber Shop", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp 2375.701 5937.897 10.03363")
					end
				end)

				RageUI.Button("Tattoo Shop 1", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp 2040.346 5866.098 9.879869")
					end
				end)
				
				RageUI.Button("Tattoo Shop 2", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp 3644.338 6335.057 10.1040")
					end
				end)

				RageUI.Button("Magasin de vêtement", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp 2443.20 7210.34 10.05")
					end
				end)

				RageUI.Button("Studio / Label", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp ")
					end
				end)

				RageUI.Button("Hospital", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
					if (Selected) then
						ExecuteCommand("tp ")
					end
				end)
		  
			end, function()
			end)

			Wait(0)

			end
		end)
	end
end

GiveCash = function()
	local amount = Extasy.KeyboardInput("Combien?", "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then

			local raison = Extasy.KeyboardInput("Précisez la raison de votre give:", "", 300)

			if raison ~= nil then
				TriggerServerEvent('Extasy:GiveCash', token, amount, raison)
			end
		end
	end
end


GiveBanque = function()
	local amount = Extasy.KeyboardInput("Combien?", "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then

			local raison = Extasy.KeyboardInput("Précisez la raison de votre give:", "", 300)

			if raison ~= nil then
				TriggerServerEvent('Extasy:GiveBanque', token, amount, raison)
			end
		end
	end
end


GiveND = function()
	local amount = Extasy.KeyboardInput("Combien?", "", 8)

	if amount ~= nil then
		amount = tonumber(amount)
		
		if type(amount) == 'number' then

			local raison = Extasy.KeyboardInput("Précisez la raison de votre give:", "", 300)

			if raison ~= nil then
				TriggerServerEvent('Extasy:GiveND', token, amount, raison)
			end
		end
	end
end

RegisterNetEvent("Extasy:sendAllInfoForIdSelected")
AddEventHandler("Extasy:sendAllInfoForIdSelected", function(playerM, playerBlackM, playerBankM, playerI)
	playerMoney 		= playerM
	playerBlackMoney 	= playerBlackM
	playerBankMoney 	= playerBankM
	playerInv 			= playerI
end)

getPlayerInv = function(player)
    Items = {}
    Armes = {}
    ArgentSale = {}
    
    ESX.TriggerServerCallback('Org:getOtherPlayerData2', function(data)
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

admin_heal_player = function()
	local plyId = Extasy.KeyboardInput1("N_BOX_ID", "", "", 8)
	if plyId ~= nil then
		plyId = tonumber(plyId)
		if type(plyId) == 'number' then
			TriggerServerEvent('esx_ambulancejob:revive', token, plyId)
		end
	end
end

GetPlayersInScope = function()
	local players = {}
	local active = GetActivePlayers()
	for k,v in pairs(active) do
		table.insert(players, GetPlayerServerId(v))
	end
	return players
end

FullVehicleBoost = function()
	local pPed = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
	local pVeh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
	
	SetVehicleModKit(pVeh, 0)
	SetVehicleWheelType(pVeh, 7)
	SetVehicleMod(pVeh, 0, GetNumVehicleMods(pVeh, 0) - 1, false)
	SetVehicleMod(pVeh, 1, GetNumVehicleMods(pVeh, 1) - 1, false)
	SetVehicleMod(pVeh, 2, GetNumVehicleMods(pVeh, 2) - 1, false)
	SetVehicleMod(pVeh, 3, GetNumVehicleMods(pVeh, 3) - 1, false)
	SetVehicleMod(pVeh, 4, GetNumVehicleMods(pVeh, 4) - 1, false)
	SetVehicleMod(pVeh, 5, GetNumVehicleMods(pVeh, 5) - 1, false)
	SetVehicleMod(pVeh, 6, GetNumVehicleMods(pVeh, 6) - 1, false)
	SetVehicleMod(pVeh, 7, GetNumVehicleMods(pVeh, 7) - 1, false)
	SetVehicleMod(pVeh, 8, GetNumVehicleMods(pVeh, 8) - 1, false)
	SetVehicleMod(pVeh, 9, GetNumVehicleMods(pVeh, 9) - 1, false)
	SetVehicleMod(pVeh, 10, GetNumVehicleMods(pVeh, 10) - 1, false)
	SetVehicleMod(pVeh, 11, GetNumVehicleMods(pVeh, 11) - 1, false)
	SetVehicleMod(pVeh, 12, GetNumVehicleMods(pVeh, 12) - 1, false)
	SetVehicleMod(pVeh, 13, GetNumVehicleMods(pVeh, 13) - 1, false)
	SetVehicleMod(pVeh, 14, 16, false)
	SetVehicleMod(pVeh, 15, GetNumVehicleMods(pVeh, 15) - 2, false)
	SetVehicleMod(pVeh, 16, GetNumVehicleMods(pVeh, 16) - 1, false)
	ToggleVehicleMod(pVeh, 17, true)
	ToggleVehicleMod(pVeh, 18, true)
	ToggleVehicleMod(pVeh, 19, true)
	ToggleVehicleMod(pVeh, 20, true)
	ToggleVehicleMod(pVeh, 21, true)
	ToggleVehicleMod(pVeh, 22, true)
	SetVehicleMod(pVeh, 23, 1, false)
	SetVehicleMod(pVeh, 24, 1, false)
	SetVehicleMod(pVeh, 25, GetNumVehicleMods(pVeh, 25) - 1, false)
	SetVehicleMod(pVeh, 27, GetNumVehicleMods(pVeh, 27) - 1, false)
	SetVehicleMod(pVeh, 28, GetNumVehicleMods(pVeh, 28) - 1, false)
	SetVehicleMod(pVeh, 30, GetNumVehicleMods(pVeh, 30) - 1, false)
	SetVehicleMod(pVeh, 33, GetNumVehicleMods(pVeh, 33) - 1, false)
	SetVehicleMod(pVeh, 34, GetNumVehicleMods(pVeh, 34) - 1, false)
	SetVehicleMod(pVeh, 35, GetNumVehicleMods(pVeh, 35) - 1, false)
	SetVehicleMod(pVeh, 38, GetNumVehicleMods(pVeh, 38) - 1, true)
	SetVehicleWindowTint(pVeh, 1)
	SetVehicleTyresCanBurst(pVeh, false)
	SetVehicleNumberPlateTextIndex(pVeh, 5)
end

FullVehicleBoostNpc = function(pVeh)
	SetVehicleModKit(pVeh, 0)
	SetVehicleWheelType(pVeh, 7)
	SetVehicleMod(pVeh, 0, GetNumVehicleMods(pVeh, 0) - 1, false)
	SetVehicleMod(pVeh, 1, GetNumVehicleMods(pVeh, 1) - 1, false)
	SetVehicleMod(pVeh, 2, GetNumVehicleMods(pVeh, 2) - 1, false)
	SetVehicleMod(pVeh, 3, GetNumVehicleMods(pVeh, 3) - 1, false)
	SetVehicleMod(pVeh, 4, GetNumVehicleMods(pVeh, 4) - 1, false)
	SetVehicleMod(pVeh, 5, GetNumVehicleMods(pVeh, 5) - 1, false)
	SetVehicleMod(pVeh, 6, GetNumVehicleMods(pVeh, 6) - 1, false)
	SetVehicleMod(pVeh, 7, GetNumVehicleMods(pVeh, 7) - 1, false)
	SetVehicleMod(pVeh, 8, GetNumVehicleMods(pVeh, 8) - 1, false)
	SetVehicleMod(pVeh, 9, GetNumVehicleMods(pVeh, 9) - 1, false)
	SetVehicleMod(pVeh, 10, GetNumVehicleMods(pVeh, 10) - 1, false)
	SetVehicleMod(pVeh, 11, GetNumVehicleMods(pVeh, 11) - 1, false)
	SetVehicleMod(pVeh, 12, GetNumVehicleMods(pVeh, 12) - 1, false)
	SetVehicleMod(pVeh, 13, GetNumVehicleMods(pVeh, 13) - 1, false)
	SetVehicleMod(pVeh, 14, 16, false)
	SetVehicleMod(pVeh, 15, GetNumVehicleMods(pVeh, 15) - 2, false)
	SetVehicleMod(pVeh, 16, GetNumVehicleMods(pVeh, 16) - 1, false)
	ToggleVehicleMod(pVeh, 17, true)
	ToggleVehicleMod(pVeh, 18, true)
	ToggleVehicleMod(pVeh, 19, true)
	ToggleVehicleMod(pVeh, 20, true)
	ToggleVehicleMod(pVeh, 21, true)
	ToggleVehicleMod(pVeh, 22, true)
	SetVehicleMod(pVeh, 23, 1, false)
	SetVehicleMod(pVeh, 24, 1, false)
	SetVehicleMod(pVeh, 25, GetNumVehicleMods(pVeh, 25) - 1, false)
	SetVehicleMod(pVeh, 27, GetNumVehicleMods(pVeh, 27) - 1, false)
	SetVehicleMod(pVeh, 28, GetNumVehicleMods(pVeh, 28) - 1, false)
	SetVehicleMod(pVeh, 30, GetNumVehicleMods(pVeh, 30) - 1, false)
	SetVehicleMod(pVeh, 33, GetNumVehicleMods(pVeh, 33) - 1, false)
	SetVehicleMod(pVeh, 34, GetNumVehicleMods(pVeh, 34) - 1, false)
	SetVehicleMod(pVeh, 35, GetNumVehicleMods(pVeh, 35) - 1, false)
	SetVehicleMod(pVeh, 38, GetNumVehicleMods(pVeh, 38) - 1, true)
	SetVehicleWindowTint(pVeh, 1)
	SetVehicleTyresCanBurst(pVeh, false)
	SetVehicleNumberPlateTextIndex(pVeh, 5)
end

RegisterNetEvent("Extasy:ClearAreaFromObjects")
AddEventHandler("Extasy:ClearAreaFromObjects", function(coords)
    ClearAreaOfObjects(coords, 50.0, 0)
end)

ShowFreemodeMessage = function(title, msg, sec)
	local scaleform = _RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')

	BeginScaleformMovieMethod(scaleform, 'SHOW_SHARD_WASTED_MP_MESSAGE')
	PushScaleformMovieMethodParameterString(title)
	PushScaleformMovieMethodParameterString(msg)
	EndScaleformMovieMethod()

	while sec > 0 do
		Wait(1)
		sec = sec - 0.01

		DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
	end

	SetScaleformMovieAsNoLongerNeeded(scaleform)
end

_RequestScaleformMovie = function(movie)
	local scaleform = RequestScaleformMovie(movie)

	while not HasScaleformMovieLoaded(scaleform) do
		Wait(0)
	end

	return scaleform
end

Popup = function(txt)
	ClearPrints()
	SetNotificationBackgroundColor(140)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(txt)
	DrawNotification(false, true)
end

startsFiltre = function(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  return x,y,z
end

getCamDirection = function()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

getCamDirection = function()
	  local heading = GetGameplayCamRelativeHeading() + GetEntityPhysicsHeading(GetPlayerPed(-1))
	  local pitch = GetGameplayCamRelativePitch()
	  local coords = vector3(-math.sin(heading * math.pi / 180.0), math.cos(heading * math.pi / 180.0), math.sin(pitch * math.pi / 180.0))
	  local len = math.sqrt((coords.x * coords.x) + (coords.y * coords.y) + (coords.z * coords.z))
  
	  if len ~= 0 then
		  coords = coords / len
	  end
  
	  return coords
end

enable = false

SpectatePlayer = function(targetPed, target)
    local playerPed = PlayerPedId()
    enable = true
    if targetPed == playerPed then enable = false end

    if enable then
        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(true, targetPed)
        DrawPlayerInfo(target)
        Extasy.ShowNotification('~g~Mode spectateur en cours')
    else
        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(false, targetPed)
        StopDrawPlayerInfo()
        Extasy.ShowNotification('~b~Mode spectateur arrêtée')
    end
end

DrawPlayerInfo = function(target)
    drawTarget = target
    drawInfo = true
end

StopDrawPlayerInfo = function()
    drawInfo = false
    drawTarget = 0
end

noclip = false
setNoClip = function()
	if playerGroup ~= "user" then
		noclip = true
		Citizen.CreateThread(function()
			local object = UIInstructionalButton.__constructor()
			
			object:Add("Ralentir", 62)
			object:Add("Turbo", 21)
			object:Add("Reculer", 78)
			object:Add("Avancer", 129)
			object:Visible(true)

			while noclip do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local camCoords = getCamDirection()
				local speed = 0.5
				SetEntityVelocity(GetPlayerPed(-1), 0.01, 0.01, 0.01)
				SetEntityInvincible(GetPlayerPed(-1), 1)
				SetEntityVisible(GetPlayerPed(-1), 0, 0)

				if IsControlPressed(1, 21) then
					speed = speed + 4.0
				end

				if IsControlPressed(1, 36) then
					speed = 0.25
				end

				if IsControlPressed(0, 32) then
					plyCoords = plyCoords + (speed * camCoords)
				end

				if IsControlPressed(0, 269) then
					plyCoords = plyCoords - (speed * camCoords)
				end

				SetEntityCoordsNoOffset(GetPlayerPed(-1), plyCoords, true, true, true)
				Wait(0)
				object:onTick()
			end
		end)
	end
end

nombrecheck = 0

notifdezub = function()
	while nombrecheck  < 1 do
		if not StaffMod then
			StaffMod = true
			local couleur = math.random(0,9)
			local model = GetEntityModel(GetPlayerPed(-1))
			armor = GetPedArmour(GetPlayerPed(-1))
		else
			StaffMod = false
			SetPedArmour(GetPlayerPed(-1), armor)

			FreezeEntityPosition(GetPlayerPed(-1), false)
			NoClip = false

			SetEntityVisible(GetPlayerPed(-1), 1, 0)
			NetworkSetEntityInvisibleToNetwork(GetPlayerPed(-1), 0)

			for k,v in pairs(pBlips) do
				RemoveBlip(v)
			end
		end

		startStaff()
		nombrecheck = nombrecheck  + 1
	end
end

give_vehi = function(veh)
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    Wait(1)
    ESX.Game.SpawnVehicle(veh, {x = plyCoords.x+2 ,y = plyCoords.y, z = plyCoords.z+2}, 313.4216, function (vehicle)
		local plate = GeneratePlate()
		table.insert(voituregive, vehicle)		
		local vehicleProps = ESX.Game.GetVehicleProperties(voituregive[#voituregive])
		vehicleProps.plate = plate
		SetVehicleNumberPlateText(voituregive[#voituregive] , plate)
		TriggerServerEvent('shop:vehicule', token, vehicleProps, plate)	
	end)
end

local group = "superadmin"
local states = {}
states.frozen = false
states.frozenPos = nil

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

Citizen.CreateThread(function()
	while true do
		Wait(500)

		if(states.frozen)then
			ClearPedTasksImmediately(PlayerPedId())
			SetEntityCoords(PlayerPedId(), states.frozenPos)
		else
			Wait(200)
		end
	end
end)

local heading = 0

RegisterNetEvent('es_admin:freezePlayer')
AddEventHandler("es_admin:freezePlayer", function(state)
	local player = PlayerId()

	local ped = PlayerPedId()

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		SetPlayerInvincible(player, true)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(x, y, z)
	SetEntityCoords(PlayerPedId(), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

RegisterNetEvent('es_admin:slap')
AddEventHandler('es_admin:slap', function()
	local ped = PlayerPedId()

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('es_admin:kill')
AddEventHandler('es_admin:kill', function()
	SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('es_admin:heal')
AddEventHandler('es_admin:heal', function()
	SetEntityHealth(PlayerPedId(), 200)
end)

RegisterNetEvent('es_admin:healall')
AddEventHandler('es_admin:healall', function()
	SetEntityHealth(PlayerPedId(), 200)
end)

RegisterNetEvent("Extasy:reportexplo")
AddEventHandler('Extasy:reportexplo', function()
	ExecuteCommand('report Je vois énormement d\'explosion. Je suis surement le moddeur...')
end)

GetVehicles = function()
    local vehicles = {}

    for vehicle in EnumerateVehicles() do
        table.insert(vehicles, vehicle)
    end

    return vehicles
end

GetClosestVehicle = function(coords)
    local vehicles = GetVehicles()
    local closestDistance = -1
    local closestVehicle = -1
    local coords = coords

    if coords == nil then
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end

    for i = 1, #vehicles, 1 do
        local vehicleCoords = GetEntityCoords(vehicles[i])
        local distance = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

        if closestDistance == -1 or closestDistance > distance then
            closestVehicle = vehicles[i]
            closestDistance = distance
        end
    end

    return closestVehicle, closestDistance
end

RegisterNetEvent("Staff:cbReportTable")
AddEventHandler("Staff:cbReportTable", function(table)
    -- TODO -> Add a sound when report taken
    reportCount = 0
    take = 0
    for source,report in pairs(table) do
        reportCount = reportCount + 1
        if report.taken then
			 take = take + 1 
		end
    end
    localReportsTable = table
	--TriggerServerEvent("ExtasyReportMenu:GetReport", token)
end)

RegisterNetEvent("Org:sendGangDataForManage")
AddEventHandler("Org:sendGangDataForManage", function(data)
    orgs_data = data
end)

RegisterNetEvent("Extasy:sendGroupData")
AddEventHandler("Extasy:sendGroupData", function(group)
    playerGroup = group
    --print("Votre groupe est "..group)
end)

RegisterNetEvent("Extasy:sendReports")
AddEventHandler("Extasy:sendReports", function(reports)
    reportSQL = reports
end)