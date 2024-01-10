ESX = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('staff:sendReportToStaffs')
AddEventHandler('staff:sendReportToStaffs', function(token, args)
    if not CheckToken(token, source, "staff:sendReportToStaffs") then return end
    TriggerClientEvent('chat:addMessage', source, {
        args = {"^3".. source .."^0|| ^3" .. GetPlayerName(source) .. " ^0: "..args.." "}
    })

    TriggerEvent("es:getPlayers", function(pl)
        for k,v in pairs(pl) do
            TriggerEvent("es:getPlayerFromId", k, function(user)
                if(user.getGroup() == "mod" or user.getGroup() == "admin" or user.getGroup() == "superadmin" and k ~= source)then
                    TriggerClientEvent('chat:addMessage', k, {
                        args = {"^3".. source .."^0|| ^3" .. GetPlayerName(source) .. " ^0: " ..args.." "}
                    })
                end
            end)
        end
    end)
end)

RegisterServerEvent('staff:Revive')
AddEventHandler('staff:Revive', function(token, player)
    if not CheckToken(token, source, "staff:Revive") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()

    if playerSrvGroup ~= "user" then
        if player == 0 then
            TriggerClientEvent('staff:RevivePlayer', source)
        else
            TriggerClientEvent('staff:RevivePlayer', player)
        end
    end
end)

RegisterServerEvent('staff:Heal')
AddEventHandler('staff:Heal', function(token, player)
    if not CheckToken(token, source, "staff:Heal") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()

    if playerSrvGroup ~= "user" then
        SendLog("Le staff **["..source.."]** "..GetPlayerName(source).." a heal ["..player.."]** "..GetPlayerName(player), "admin")
        if player == 0 then
            TriggerClientEvent('staff:HealPlayer', source)
        else
            TriggerClientEvent('staff:HealPlayer', player)
        end
    end
end)

RegisterServerEvent('staff:sendGlobalMessage')
AddEventHandler('staff:sendGlobalMessage', function(token, args)
    if not CheckToken(token, source, "staff:sendGlobalMessage") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()

    if playerSrvGroup ~= "user" then
        TriggerClientEvent('Extasy:chatMessage', -1, "annonce", "ANNONCE", args)
        SendLog("Le staff **["..source.."]** "..GetPlayerName(source).." a fait une annonce (**"..args.."**)", "annonce")
    end
end)

RegisterServerEvent('staff:teleportPC')
AddEventHandler('staff:teleportPC', function(token, player)
    if not CheckToken(token, source, "staff:teleportPC") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    SetEntityCoords(player, 258.257, -786.605, 29.438)
end)

RegisterServerEvent('staff:teleportPC')
AddEventHandler('staff:teleportPC', function(token, player)
    if not CheckToken(token, source, "staff:teleportPC") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    SetEntityCoords(player, 258.257, -786.605, 29.438)
end)

RegisterServerEvent('staff:teleportQG')
AddEventHandler('staff:teleportQG', function(token, player)
    if not CheckToken(token, source, "staff:teleportQG") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()

    SetEntityCoords(player, 3093.60, -4712.64, 15.4)
end)

RegisterServerEvent('staff:GetPlayerNumbers')
AddEventHandler('staff:GetPlayerNumbers', function(token)
    if not CheckToken(token, source, "staff:GetPlayerNumbers") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    local players = GetPlayers()
    local Callback = {}

    if playerSrvGroup ~= "user" then
        for k,v in pairs(players) do
            Callback[v] = {id = v, name = GetPlayerName(v)}
            table.insert(Callback, {id = v, name = GetPlayerName(v)})
        end

        TriggerClientEvent('Extasy:chatMessage', -1, "info", "90's Life Monitoring", "Il y a ^3" ..#Callback.. " ^0joueurs connectés")
    end
end)

RegisterServerEvent('staff:KickPlayer')
AddEventHandler('staff:KickPlayer', function(token, args, reasons)
    if not CheckToken(token, source, "staff:KickPlayer") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    local player = args
    local reason = reasons
    DropPlayer(player, reason)
end)

RegisterServerEvent('staff:SlayPlayer')
AddEventHandler('staff:SlayPlayer', function(token, args)
    if not CheckToken(token, source, "staff:SlayPlayer") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    local players = args
    print(players)

    TriggerClientEvent('es_admin:kill', players)
end)

local frozen = {}

RegisterServerEvent('staff:FreezePlayer')
AddEventHandler('staff:FreezePlayer', function(token, args)
    if not CheckToken(token, source, "staff:FreezePlayer") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()

    local players = args

        if(frozen[players])then
            frozen[players] = false
        else
            frozen[players] = true
        end

        TriggerClientEvent('es_admin:freezePlayer', players, frozen[players])

        local state = "unfrozen"
        if(frozen[players])then
            state = "frozen"
        end
end)

local savedCoords   = {}

RegisterServerEvent('staff:BringPlayer')
AddEventHandler('staff:BringPlayer', function(token, args)
    if not CheckToken(token, source, "staff:BringPlayer") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerSrvGroup = xPlayer.getGroup()
    local targetId = args
    local xTarget = ESX.GetPlayerFromId(targetId)

    if xTarget ~= nil then
        local targetCoords = xTarget.getCoords()
        local playerCoords = xPlayer.getCoords()
        savedCoords[targetId] = targetCoords
        xTarget.setCoords(playerCoords)
    end
end)

RegisterServerEvent('staff:GotoPlayer')
AddEventHandler('staff:GotoPlayer', function(token, args)
    if not CheckToken(token, source, "staff:GotoPlayer") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerSrvGroup = xPlayer.getGroup()

    if playerSrvGroup ~= 'user' then
        local targetId = args
        local xTarget = ESX.GetPlayerFromId(targetId)

        if xTarget ~= nil then
            local targetCoords = xTarget.getCoords()
            local playerCoords = xPlayer.getCoords()
            savedCoords[source] = playerCoords
            xPlayer.setCoords(targetCoords)
        end
    end
end)

RegisterServerEvent('staff:BoomPlayer')
AddEventHandler('staff:BoomPlayer', function(token, args)
    if not CheckToken(token, source, "staff:BoomPlayer") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerSrvGroup = xPlayer.getGroup()
    TriggerClientEvent('es_admin:slap', args)
end)

RegisterServerEvent('staff:VivrePlayer')
AddEventHandler('staff:VivrePlayer', function(token)
    if not CheckToken(token, source, "staff:VivrePlayer") then return end
    DropPlayer(source, 'Vous avez choisi de vivre votre MortRP n\'a pas été comtabilisé !')
end)

RegisterServerEvent('staff:MortrpPlayer')
AddEventHandler('staff:MortrpPlayer', function(token, args)
    if not CheckToken(token, source, "staff:MortrpPlayer") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerSrvGroup = xPlayer.getGroup()
    local identifier = GetPlayerIdentifiers(args)

    TriggerClientEvent('Extasy:showNotification', args, "Vous êtes ~r~MortRP~s~, Déconnexion dans 15 secondes !")
    TriggerClientEvent('Extasy:showNotification', args, "Si vous êtes contre cette mortrp faite la commande ~g~/vivre~s~ sinon laissez vous mourir...")

    Citizen.Wait(8000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~15")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~14")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~13")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~12")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~11")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~10")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~9")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~8")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~7")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~6")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~5")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~4")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~3")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~2")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~1")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~0")
    Citizen.Wait(1000)
    TriggerClientEvent('Extasy:showNotification', args, "~r~Suppréssion de votre personnage en cours...")
    Citizen.Wait(3000)

    MySQL.Async.execute("DELETE FROM `users` WHERE identifier = @identifier",
        {
                ['@identifier']   = identifier
        })

    MySQL.Async.execute("DELETE FROM `owned_properties` WHERE owner = @owner",
        {
                ['@owner']   = identifier
        })

    MySQL.Async.execute("DELETE FROM `owned_vehicles` WHERE owner = @owner AND job <> boutique",
        {
                ['@owner']   = identifier
        })

    MySQL.Async.execute("DELETE FROM `user_licenses` WHERE owner = @owner",
        {
                ['@owner']   = identifier
        })

    MySQL.Async.execute("DELETE FROM `datastore_data` WHERE owner = @owner",
        {
                ['@owner']   = identifier
        })

    MySQL.Async.execute("DELETE FROM `phone_users_contacts` WHERE identifier = @identifier",
        {
        ['@identifier']   = identifier
        })

    MySQL.Async.execute("DELETE FROM `user_accounts` WHERE identifier = @identifier",
        {
        ['@identifier']   = identifier
        })

    MySQL.Async.execute("DELETE FROM `user_inventory` WHERE identifier = @identifier",
        {
        ['@identifier']   = identifier
        })
        
    MySQL.Async.execute("DELETE FROM `characters` WHERE identifier = @identifier",  { ['@identifier']   = identifier })

    Citizen.Wait(1000)

    DropPlayer(args, 'Un admin vient de faire la commande de /mortrp sur toi. Tu es maintenant wipe, reconnecte toi !')
end)

RegisterServerEvent('staff:giveItem')
AddEventHandler('staff:giveItem', function(token, player, item, count)
    if not CheckToken(token, source, "staff:giveItem") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayer2 = ESX.GetPlayerFromId(player)
	local playerSrvGroup = xPlayer.getGroup()

    if playerSrvGroup ~= "user" then
        SendLog("Le staff **["..source.."] "..GetPlayerName(source).."** c'est give **x"..count.." "..item.."**", "admin")
        xPlayer2.addInventoryItem(item, count)
        TriggerClientEvent("Extasy:ShowNotification", player, "~g~Vous avez reçu x"..count.." "..item.."")
    end
end)

RegisterServerEvent('staff:AnnonceChat')
AddEventHandler('staff:AnnonceChat', function(token, message)
    if not CheckToken(token, source, "staff:AnnonceChat") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerSrvGroup = xPlayer.getGroup()
    TriggerClientEvent('chat:addMessage', -1, { args = {"^5Annonce", ""..message..""} })
end)

RegisterCommand('wladd', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playergroup = xPlayer.getGroup()

    if playergroup ~= "user" then
		if args[1] then
			if isWhiteListed(args[1]) then
                TriggerClientEvent("Extasy:ShowNotification", source, args[1].." ~o~est déja sur la WhiteListe")
			else
				addWhiteList(args[1])
                TriggerClientEvent("Extasy:ShowNotification", source, args[1].." ~g~a été ajouter sur la WhiteListe")
                print(args[1].." a été ajouter sur la WhiteListe")
			end
		else
            TriggerClientEvent("Extasy:ShowNotification", source, "~r~Idetifiant Invalide, veuillez définir un nouvel Idetifiant de joueur")
		end
	end
end, true)

RegisterCommand('wlremove', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playergroup = xPlayer.getGroup()

    if playergroup ~= "user" then
		if args[1] then
			if isWhiteListed(args[1]) then
				removeWhiteList(args[1])
                print(args[1].." n'est plus sur la WhiteListe")
                TriggerClientEvent("Extasy:ShowNotification", source, args[1].." ~g~n'est plus sur la WhiteListe")
			else
                TriggerClientEvent("Extasy:ShowNotification", source, args[1].." ~o~n'est pas sur la WhiteListe")
			end
		else
			TriggerClientEvent("Extasy:ShowNotification", source, "~r~Idetifiant Invalide, veuillez définir un nouvel Idetifiant de joueur")
		end
	end
end, true)

addWhiteList = function(identifier)
	MySQL.Sync.execute("INSERT INTO user_whitelist (`identifier`, `whitelisted`) VALUES (@identifier, @whitelisted)",{['@identifier'] = identifier, ['@whitelisted'] = 1})
end

removeWhiteList = function(identifier)
	MySQL.Sync.execute("DELETE FROM user_whitelist WHERE identifier = @identifier", {['@identifier'] = identifier})
end
