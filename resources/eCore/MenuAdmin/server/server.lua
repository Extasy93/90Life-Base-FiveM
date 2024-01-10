ESX = nil
local players = {}
local reportsTable = {}
local reportsCount = 0
local inService = {}
local PlayerSQLReport = {}

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("Extasy:getAllInfoForIdSelected")
AddEventHandler("Extasy:getAllInfoForIdSelected", function(token, target)
	if not CheckToken(token, source, "Extasy:getAllInfoForIdSelected") then return end
    local xPlayer = ESX.GetPlayerFromId(target)

 	local playerMoney = xPlayer.getMoney()
	local playerBlackMoney = xPlayer.getAccount('black_money').money
	local playerBankMoney = xPlayer.getAccount('bank').money
	local playerInventory = xPlayer.getInventory()

	TriggerClientEvent("Extasy:sendAllInfoForIdSelected", source, playerMoney, playerBlackMoney, playerBankMoney, playerInventory)
end)

RegisterNetEvent('admin:RemoveItemForPlayerInventory')
AddEventHandler('admin:RemoveItemForPlayerInventory', function(token, target, itemType, itemName, amount)
	if not CheckToken(token, source, "admin:RemoveItemForPlayerInventory") then return end

    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		
			targetXPlayer.removeInventoryItem(itemName, amount)
            TriggerClientEvent("Extasy:ShowNotification", source, "Vous avez retiré ~b~"..amount..' '..sourceItem.label.."~s~.")
            TriggerClientEvent("Extasy:ShowNotification", target, "Un staff ["..source.."] vous a retiré ~b~"..amount..' '..sourceItem.label.."~s~.")
        else
			TriggerClientEvent("Extasy:ShowNotification", source, "~r~Quantiter invalid")
		end


	if itemType == 'item_weapon' then
        if amount == nil then amount = 0 end
        targetXPlayer.removeWeapon(itemName, amount)

        TriggerClientEvent("Extasy:ShowNotification", source, "Vous avez retiré ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
        TriggerClientEvent("Extasy:ShowNotification", target, "Un staff ["..source.."] vous a retiré ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
    end
end)

RegisterNetEvent("Extasy:addMoney")
AddEventHandler("Extasy:addMoney", function(token, target, ammount)
	if not CheckToken(token, source, "Extasy:addMoney") then return end
    local source = source
    local rank = players[source].rank
    local xPlayer = ESX.GetPlayerFromId(target)
	local type = 'liquide'
    xPlayer.addMoney(ammount)
    SendLog("``Le staff ["..source.."] "..GetPlayerName(source).." a give "..ammount.." au joueur ["..target.."] "..GetPlayerName(target).."``", "admin")
end)

RegisterNetEvent("Extasy:removeMoney")
AddEventHandler("Extasy:removeMoney", function(token, target, ammount)
	if not CheckToken(token, source, "Extasy:removeMoney") then return end
    local source = source
    local rank = players[source].rank
    local xPlayer = ESX.GetPlayerFromId(target)
	local type = 'liquide'
    xPlayer.removeMoney(ammount)
	SendLog("``Le staff ["..source.."] "..GetPlayerName(source).." a retiré "..ammount.." au joueur ["..target.."] "..GetPlayerName(target).."``", "admin")
end)

RegisterNetEvent("Extasy:addMoneysale")
AddEventHandler("Extasy:addMoneysale", function(token, target, ammount)
	if not CheckToken(token, source, "Extasy:addMoneysale") then return end
    local source = source
    local rank = players[source].rank
    local xPlayer = ESX.GetPlayerFromId(target)
	local type = 'sale'
    xPlayer.addAccountMoney('black_money', tonumber(ammount))
    SendLog("``Le staff ["..source.."] "..GetPlayerName(source).." a give "..ammount.." au joueur ["..target.."] "..GetPlayerName(target).."``", "admin")
end)

RegisterNetEvent("Extasy:removeMoneysale")
AddEventHandler("Extasy:removeMoneysale", function(token, target, ammount)
	if not CheckToken(token, source, "Extasy:removeMoneysale") then return end
    local source = source
    local rank = players[source].rank
    local xPlayer = ESX.GetPlayerFromId(target)
	local type = 'sale'
    xPlayer.removeAccountMoney('black_money', tonumber(ammount))
	SendLog("``Le staff ["..source.."] "..GetPlayerName(source).." a retiré "..ammount.." au joueur ["..target.."] "..GetPlayerName(target).."``", "admin")
end)

RegisterNetEvent("Extasy:addMoneybank")
AddEventHandler("Extasy:addMoneybank", function(token, target, ammount)
	if not CheckToken(token, source, "Extasy:addMoneybank") then return end
    local source = source
    local rank = players[source].rank
    local xPlayer = ESX.GetPlayerFromId(target)
	local type = 'bank'
    xPlayer.addAccountMoney('bank', tonumber(ammount))
    SendLog("``Le staff ["..source.."] "..GetPlayerName(source).." a give "..ammount.." au joueur ["..target.."] "..GetPlayerName(target).."``", "admin")
end)

RegisterNetEvent("Extasy:removeMoneybank")
AddEventHandler("Extasy:removeMoneybank", function(token, target, ammount)
	if not CheckToken(token, source, "Extasy:removeMoney") then return end
    local source = source
    local rank = players[source].rank
    local xPlayer = ESX.GetPlayerFromId(target)
	local type = 'bank'
    xPlayer.removeAccountMoney('bank', tonumber(ammount))
    SendLog("``Le staff ["..source.."] "..GetPlayerName(source).." a retiré "..ammount.." au joueur ["..target.."] "..GetPlayerName(target).."``", "admin")
end)

RegisterServerEvent('Extasy:StaffInServices')
AddEventHandler('Extasy:StaffInServices', function(token, newVal)
	if not CheckToken(token, source, "Extasy:StaffInServices") then return end
    local source = source
    if newVal then
        inService[source] = true
    else
        inService[source] = nil
    end
end)

RegisterServerEvent('ExtasyReportMenu:GetReport')
AddEventHandler('ExtasyReportMenu:GetReport', function(token)
	if not CheckToken(token, source, "ExtasyReportMenu:GetReport") then return end
	local _source = source

	local player

    for k,v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = '"..player.."'", {}, function (result)
		TriggerClientEvent("Extasy:sendReports", _source, result[1].report)
	end)
end)

ESX.RegisterServerCallback('ExtasyMenu:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()

    --print(("^1[Menu Admin] ^7Player ^3%s ^7loaded with group ^1%s^7 ! ^7"):format(GetPlayerName(source),xPlayer.getGroup()))
    players[source] = {
        timePlayed = { 0, 0 },
        rank = xPlayer.getGroup(),
        name = GetPlayerName(source),
    }
    if xPlayer.getGroup() ~= "user" then
        TriggerClientEvent("Staff:cbReportTable", source, reportsTable)
        TriggerClientEvent("Staff:updatePlayers", source, players)
    end

	cb(group)
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    if players[source] then
        return
    end

    players[source] = {
        timePlayed = { 0, 0 },
        rank = xPlayer.getGroup(),
        name = GetPlayerName(source),
    }
    if xPlayer.getGroup() ~= "user" then
        TriggerClientEvent("Staff:cbReportTable", source, reportsTable)
        TriggerClientEvent("Staff:updatePlayers", source, players)
    end
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    players[source] = nil
    reportsTable[source] = nil
    updateReportsForStaff()
end)

RegisterNetEvent("Staff:takeReport")
AddEventHandler("Staff:takeReport", function(token, reportId)
	if not CheckToken(token, source, "Staff:takeReport") then return end
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() == "user" then
        DropPlayer(source, "Vous n'avez pas la permission de faire cela")
        return
    end
    if not reportsTable[reportId] then
        TriggerClientEvent("Extasy:showNotification", source, "~r~[Report] ~s~Ce report n'est plus en attente de prise en charge")
        return
    end
    reportsTable[reportId].takenBy = GetPlayerName(source)
    reportsTable[reportId].taken = true
    if players[reportId] ~= nil then
        TriggerClientEvent("Extasy:showNotification", reportId, "~r~[Report] ~s~Votre report a été pris en charge.")
    end
    --PlayerStaffNotif("~r~[Report] ~s~Le staff ~r~"..GetPlayerName(source).."~s~ a pris en charge le report ~y~n°"..reportsTable[reportId].uniqueId)
    local coords = GetEntityCoords(GetPlayerPed(reportId))
    TriggerClientEvent("Staff:setCoords", source, coords)
    updateReportsForStaff()
end)

RegisterNetEvent("Staff:closeReport")
AddEventHandler("Staff:closeReport", function(token, reportId)
	if not CheckToken(token, source, "Staff:closeReport") then return end
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() == "user" then
        DropPlayer(source, "Vous n'avez pas la permission de faire cela")
        return
    end
    if not reportsTable[reportId] then
        TriggerClientEvent("Extasy:showNotification", source, "~r~[Report] ~s~Ce report n'est plus valide")
        return
    end
    if players[reportId] ~= nil then
        TriggerClientEvent("Extasy:showNotification", reportId, "~r~[Report] ~s~Votre report a été cloturé. N'hésitez pas à nous recontacter en cas de besoin.")
    end
    --PlayerStaffNotif("~r~[Report] ~s~Le staff ~r~"..GetPlayerName(source).."~s~ a ~g~cloturé ~s~le report ~y~n°"..reportsTable[reportId].uniqueId)
	SendLog("``Le staff ["..source.."] "..GetPlayerName(source).." a cloturé le report n°"..reportsTable[reportId].uniqueId.."``", "report")
    MySQL.Async.fetchAll("SELECT report FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
        for k,v in pairs(result) do
            PlayerSQLReport[xPlayer.identifier] =  {} 
            PlayerSQLReport[xPlayer.identifier].report = v.report
        end

        local newPlayerSQLReport = PlayerSQLReport[xPlayer.identifier].report + 1

        MySQL.Async.execute("UPDATE `users` SET `report` = '"..newPlayerSQLReport.."' WHERE `identifier` = '"..xPlayer.identifier.."'", {}, function() end) 
    end)
    reportsTable[reportId] = nil
    updateReportsForStaff()
end)

updateReportsForStaff = function()
	local xPlayer = ESX.GetPlayerFromId(source)
    for k, player in pairs(players) do
        if player.rank ~= "user" then
            TriggerClientEvent("Staff:cbReportTable", k, reportsTable)
        end
    end
end

PlayerStaffNotif = function(message)
    for k, player in pairs(players) do
        if player.rank ~= "user" then
            if inService[k] ~= nil then
                TriggerClientEvent("Extasy:showNotification", k, message)
            end
        end
    end
end

RegisterCommand("report", function(source, args)
    -- TODO -> Add a sound when report sent
    if source == 0 then
        return
    end
    if reportsTable[source] ~= nil then
        TriggerClientEvent("Extasy:showNotification", source, "~r~[Report] ~s~Vous avez déjà un report à votre actif.")
        return
    end
    reportsCount = reportsCount + 1
    reportsTable[source] = { timeElapsed = {0,0}, uniqueId = reportsCount, id = source, name = GetPlayerName(source), reason = table.concat(args, " "), taken = false, createdAt = os.date('%c'), takenBy = nil }
    PlayerStaffNotif("~r~[Report] ~s~Un nouveau report a été reçu.")
    TriggerClientEvent("Extasy:showNotification", source, "~r~[Report] ~s~Votre report a été envoyé ! Vous serez informé quand il sera pris en charge et / ou cloturé.")
    updateReportsForStaff()
end, false)

-- Players updaters task
Citizen.CreateThread(function()
    while true do
        Wait(5000)
        for source, player in pairs(players) do
			if player.rank ~= "user" then
                TriggerClientEvent("Staff:updatePlayers", source, players)
                TriggerClientEvent("Staff:cbReportTable", source, reportsTable)
            end
        end
    end
end)

-- Session counter task
-- TODO -> add report time elapsed
Citizen.CreateThread(function()
    while true do
        Wait(1000 * 60)
        for k, v in pairs(players) do
            players[k].timePlayed[1] = players[k].timePlayed[1] + 1
            if players[k].timePlayed[1] > 60 then
                players[k].timePlayed[1] = 0
                players[k].timePlayed[2] = players[k].timePlayed[2] + 1
            end
        end
        for k, v in pairs(reportsTable) do
            reportsTable[k].timeElapsed[1] = reportsTable[k].timeElapsed[1] + 1
            if reportsTable[k].timeElapsed[1] > 60 then
                reportsTable[k].timeElapsed[1] = 0
                reportsTable[k].timeElapsed[2] = reportsTable[k].timeElapsed[2] + 1
            end
        end
    end
end)

RegisterNetEvent("core:pList")
AddEventHandler("core:pList", function(token)
	if not CheckToken(token, source, "core:pList") then return end

	--TriggerEvent("ext:AST", source, "core:pList")

    local players = GetPlayers()
    local Callback = {}
    for k,v in pairs(players) do
            Callback[v] = {id = v, name = GetPlayerName(v)}
        table.insert(Callback, {id = v, name = GetPlayerName(v)})
    end
	
    TriggerClientEvent("core:pList", source, Callback)
end)

platenum = math.random(00001, 99998)

Citizen.CreateThread(function()
	while true do
		Wait(5000)
		local r = math.random(00001, 99998)
		platenum = r
	end
end)

RegisterServerEvent("Extasy:GiveCash")
AddEventHandler("Extasy:GiveCash", function(token, money, raison)
	if not CheckToken(token, source, "Extasy:GiveCash") then return end
	local _source = source
	local total = money
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent("ext:AST", _source, "Extasy:GiveCash")

	if xPlayer then
		MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
			if result[1] then
				xPlayer.addMoney((total))
				SendLog("``Le staff [".._source.."] "..GetPlayerName(_source).." c'est give "..total.."$ pour la raison: "..raison.."``", "admin")
			else
				return
			end
		end)
	end
end)

RegisterServerEvent("Extasy:GiveBanque")
AddEventHandler("Extasy:GiveBanque", function(token, money, raison)
	if not CheckToken(token, source, "Extasy:GiveBanque") then return end
	local _source = source
	local total = money
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent("ext:AST", _source, "Extasy:GiveBanque")

	if xPlayer then
		MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
			if result[1] then
				xPlayer.addAccountMoney('bank', total)
				SendLog("``Le staff [".._source.."] "..GetPlayerName(_source).." c'est give "..total.."$ pour la raison: "..raison.."``", "admin")
			else
				return
			end
		end)
	end
end)

RegisterServerEvent("Extasy:GiveND")
AddEventHandler("Extasy:GiveND", function(token, money, raison)
	if not CheckToken(token, source, "Extasy:GiveND") then return end
	local _source = source
	local total = money
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent("ext:AST", _source, "Extasy:GiveND")

	if xPlayer then
		MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
			if result[1] then
				xPlayer.addAccountMoney('black_money', total)
				SendLog("``Le staff [".._source.."] "..GetPlayerName(_source).." c'est give "..total.."$ pour la raison: "..raison.."``", "admin")
			else
				return
			end
		end)
	end
end)

RegisterNetEvent("Extasy:Message")
AddEventHandler("Extasy:Message", function(token, id, type)
	if not CheckToken(token, source, "Extasy:Message") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money

	TriggerEvent("ext:AST", source, "Extasy:Message")

	TriggerClientEvent("Extasy:envoyer", id, type)
end)

RegisterServerEvent('Extasy:KickPerso')
AddEventHandler('Extasy:KickPerso', function(token, target, msg)
	if not CheckToken(token, source, "Extasy:KickPerso") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money

	TriggerEvent("ext:AST", _source, "Extasy:KickPerso")
	name = GetPlayerName(source)
	DropPlayer(source, target, msg)
end)

RegisterServerEvent("deleteVehAll")
AddEventHandler("deleteVehAll", function(token)
	if not CheckToken(token, source, "deleteVehAll") then return end

	TriggerEvent("ext:AST", source, "deleteVehAll")

	TriggerClientEvent("RemoveAllVeh", -1)
end)

RegisterServerEvent("spawnVehAll")
AddEventHandler("spawnVehAll", function(token)
	if not CheckToken(token, source, "spawnVehAll") then return end

	TriggerEvent("ext:AST", source, "spawnVehAll")

	TriggerClientEvent("SpawnAllVeh", -1)
end)

RegisterNetEvent("Extasy:ClearAreaFromObjects")
AddEventHandler("Extasy:ClearAreaFromObjects", function(token, coords, players)
	if not CheckToken(token, source, "Extasy:ClearAreaFromObjects") then return end

	TriggerEvent("ext:AST", source, "Extasy:ClearAreaFromObjects")

	if players ~= nil then
		for k,v in pairs(players) do
			TriggerClientEvent("Extasy:ClearAreaFromObjects", v, coords)
		end
	end
end)

RegisterNetEvent("DeleteEntityTable")
AddEventHandler("DeleteEntityTable", function(token, list)
	if not CheckToken(token, source, "DeleteEntityTable") then return end
	TriggerEvent("ext:AST", source, "DeleteEntityTable")
    for k,v in pairs(list) do
        local entity = NetworkGetEntityFromNetworkId(v)
        Citizen.InvokeNative('DELETE_ENTITY' & 0xFFFFFFFF, entity)
    end
end)

RegisterServerEvent("SavellPlayerAuto")
AddEventHandler("SavellPlayerAuto", function(token)
	if not CheckToken(token, source, "SavellPlayerAuto") then return end

	TriggerEvent("ext:AST", source, "SavellPlayerAuto")

	ESX.SavePlayers(cb)
end)

count = 0
Citizen.CreateThread(function()
	while true do
		Wait(5000)
		count = count + 1

		if count >= 150 then
			ESX.SavePlayers(cb)
			print('^2Save des joueurs ^3Effectué^7')
			count = 0
		end
	end
end)

-----------------------------

-- Warn system 
--[[local warns = {}

RegisterNetEvent("STAFFMOD:RegisterWarn")
AddEventHandler("STAFFMOD:RegisterWarn", function(id, type)
	local steam = GetPlayerIdentifier(id, 1)
	local warnsGet = 0
	local found = false
	for k,v in pairs(warns) do
		if v.id == steam then
			found = true
			warnsGet = v.warns
			table.remove(warns, k)
			break
		end
	end
	if not found then
		table.insert(warns, {
			id = steam,
			warns = 1
		})
	else
		table.insert(warns, {
			id = steam,
			warns = warnsGet + 1
		})
	end
	print(warnsGet+1)
	if warnsGet+1 >= 3 then
		SessionBanPlayer(id, steam, source, type)
	else
		WarnsLog(id, source, type, false)
		TriggerClientEvent("STAFFMOD:RegisterWarn", id, type)
	end
end)

local SessionBanned = {}
local SessionBanMsg = "Vous avez été banni de la session de jeux pour une accumulation de warn. Merci de lire le règlement de nouveau."

function SessionBanPlayer(id, steam, source, type)
	table.insert(SessionBanned, steam)
	WarnsLog(id, source, type, true)
	DropPlayer(id, SessionBanMsg)
end

local webhook = "https://discord.com/api/webhooks/806586897866031154/6y4bSOflrZGfoqDSUcMQYKZmL_8lFUOFWCm9peuJQ8BKVW7HLW7sk5CKVOKKvLgcJDpa" --mes le wehbooks ici mon bb
function WarnsLog(IdWarned, IdSource, Reason, banned)
	if not banned then
		message = GetPlayerName(IdSource).." à warn "..GetPlayerName(IdWarned).." pour "..Reason
	else
		message = GetPlayerName(IdSource).." à warn "..GetPlayerName(IdWarned).." pour "..Reason.." et à été banni de la session pour accumulation de warn."
	end

	local discordInfo = {
			["color"] = "15158332",
			["type"] = "rich",
			["title"] = "**WARN**",
			["description"] = message,
			["footer"] = {
			["text"] = 'WARN SYSTEM' 
		}
	}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'WARN', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end--]]


---------------------------------------------------------
----------------- functions and events ------------------
---------------------------------------------------------

function havePermission(xPlayer, exclude)
	if exclude and type(exclude) ~= 'table' then exclude = nil; end	

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(ConfigStaffMenu.adminRanks) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end

-----------------------
AddEventHandler('es:playerLoaded', function(Source, user)
	TriggerEvent("ext:AST", source, "es:playerLoaded")
	TriggerClientEvent('es_admin:setGroup', Source, user.getGroup())
end)

RegisterServerEvent('es_admin:set')
AddEventHandler('es_admin:set', function(t, USER, GROUP)
	local Source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		TriggerEvent('es:canGroupTarget', user.getGroup(), "admin", function(available)
			if available then
			if t == "group" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', source, {
						args = {"^190Life :", "Joueur non trouvé"}
					})
				else
					TriggerEvent("es:getAllGroups", function(groups)
						if(groups[GROUP])then
							TriggerEvent("es:setPlayerData", USER, "group", GROUP, function(response, success)
								TriggerClientEvent('es_admin:setGroup', USER, GROUP)
								TriggerClientEvent('chat:addMessage', -1, {
									args = {"^1CONSOLE", "Groupe de ^2^*" .. GetPlayerName(tonumber(USER)) .. "^r^0 a été réglé sur ^2^*" .. GROUP}
								})
							end)
						else
							TriggerClientEvent('chat:addMessage', Source, {
								args = {"^190Life :", "Groupe introuvable"}
							})
						end
					end)
				end
			elseif t == "level" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^190Life :", "Joueur non trouvé"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
							if(true)then
								TriggerClientEvent('chat:addMessage', -1, {
									args = {"^1CONSOLE", "Niveau d'autorisation de ^2" .. GetPlayerName(tonumber(USER)) .. "^0 a été réglé sur ^2 " .. tostring(GROUP)}
								})
							end

						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^190Life :", "Niveau d'autorisation de ^2" .. GetPlayerName(tonumber(USER)) .. "^0 a été réglé sur ^2 " .. tostring(GROUP)}
						})
					else
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^190Life :", "Invalid integer entered"}
						})
					end
				end
			elseif t == "money" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^190Life :", "Joueur non trouvé"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setMoney(GROUP)
						end)
					else
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^190Life :", "Invalid integer entered"}
						})
					end
				end
			elseif t == "bank" then
				if(GetPlayerName(USER) == nil)then
					TriggerClientEvent('chat:addMessage', Source, {
						args = {"^190Life :", "Joueur non trouvé"}
					})
				else
					GROUP = tonumber(GROUP)
					if(GROUP ~= nil and GROUP > -1)then
						TriggerEvent('es:getPlayerFromId', USER, function(target)
							target.setBankBalance(GROUP)
						end)
					else
						TriggerClientEvent('chat:addMessage', Source, {
							args = {"^190Life :", "Invalid integer entered"}
						})
					end
				end
			end
			else
				TriggerClientEvent('chat:addMessage', Source, {
					args = {"^190Life :", "Superadmin required to do this"}
				})
			end
		end)
	end)
end)

local nbexploreport = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000 * 5)
		nbexploreport = {}
	end
end)

AddEventHandler('explosionEvent', function(sender, ev)
    --CancelEvent()
    print(GetPlayerName(sender), json.encode(ev))
	
	if nbexploreport[sender] ~= nil then
		nbexploreport[sender] = nbexploreport[sender] + 1
	else
		nbexploreport[sender] = 0
	end
	
	if nbexploreport[sender] >= 10 then
		TriggerClientEvent('Extasy:reportexplo', sender)
		print(GetPlayerName(sender) .. " a vu plus de 10 explosion !!")
	end
end)

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

-- COMMANDES

RegisterCommand('giveweapon', function(source)
	local xPlayers = ESX.GetPlayerFromId(source)

	TriggerClientEvent("Extasy:ShowNotification", source, "~r~Cette commande à été désactivé merci d'utiliser /giveitem pour vous give des armes")
	--[[xPlayer.addWeapon(weaponName, tonumber(args[3]))
	sendWebhookGiveWeapon(_source, weaponName, GetPlayerName(xPlayers.source), xPlayer.source, 1)
	TriggerEvent("over:creationarmestupeuxpasdeviner", token, source, weaponName, 250, "Commande staff /giveweapon")--]]
end, true)

-- log