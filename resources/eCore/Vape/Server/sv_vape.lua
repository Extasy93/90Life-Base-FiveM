LogBanToDiscordCleaning = function(playerId)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local discord  = "Aucun"
    local t = os.date("*t", time)

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        end
    end

    local footer = 'Log envoyée le '..t.day..'/'..t.month..'/'..t.year..' à '..t.hour..':'..t.min..''

    local discordInfo = {
        ["color"] = "1752220",
        ["type"] = "rich",
        ["title"] = "Anti-Cheat (Vape)",
        ["description"] = "Son Nom : **"..name.."**\n Son Discord : **"..discord.."**\nTricher est interdit sur notre serveur.",
        ["footer"] = {
            ["text"] = footer
        }
    }

    PerformHttpRequest(extasy_sv_core_cfg["webhook_vape_simple"], function(err, text, headers) end, 'POST', json.encode({ username = 'Vape Anti-Cheat', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

LogBanToDiscord = function(playerId,reason)
    --LogBanToDiscordCleaning(playerId)

    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local steamid  = "Aucun"
    local license  = "Aucun"
    local discord  = "Aucun"
    local xbl      = "Aucun"
    local liveid   = "Aucun"
    local ip       = "Aucun"

    for k,v in pairs(GetPlayerIdentifiers(playerId)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steamid = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
            xbl  = v
        elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
            ip = string.sub(v, 4)
        elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            discord = "<@"..discordid..">"
        elseif string.sub(v, 1, string.len("live:")) == "live:" then
            liveid = v
        end
    end

    local discordInfo = {
        ["color"] = "16487167",
        ["type"] = "rich",
        ["title"] = "Ce joueurs a potentielement tricher ",
        ["description"] = "**Son Nom : **"..name.."\n **La Raison : **"..reason.."\n **Son ID (ingame) : **"..playerId.."\n **Son adresse IP : **"..ip.."\n **Son Steam Hex : **"..steamid.."\n **Sa License : **"..license.."\n **Et son Discord : **"..discord,
        ["footer"] = {
            ["text"] = 'Anti Cheat (By Extasy#0093)'
        }
    }

    PerformHttpRequest(extasy_sv_core_cfg["webhook_vape_detail"], function(err, text, headers) end, 'POST', json.encode({ username = 'Vape Anti-Cheat', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

ACStarted = function()
    local discordInfo = {
        ["color"] = "16487167",
        ["type"] = "rich",
        ["title"] = "Vape Anti-Cheat vien de démarrer",
        ["footer"] = {
            ["text"] = 'Anti Cheat Vape (By Extasy#0093)'
        }
    }

    PerformHttpRequest(extasy_sv_core_cfg["webhook_vape_detail"], function(err, text, headers) end, 'POST', json.encode({ username = 'Vape Anti-Cheat', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent("AC:CpoRPsa")
AddEventHandler("AC:CpoRPsa", function(token)
    if not CheckToken(token, source, "AC:CpoRPsa") then return end
    local source = source
    local name = GetPlayerName(source)
    local id = ESX.GetPlayerFromId(source).identifier
    SendLog("**["..source.."]** "..GetPlayerName(source) .. "  a tenté de se mettre en RAT :D !", "ac")
    local lol = math.random(5000,6000)
    DropPlayer(source, "Server->client connection timed out. Last seen "..lol.." msec ago.")
end)

RegisterServerEvent('Extasyyy:detectionf748esf4esf4se85de7des7fesf5ede8sf')
AddEventHandler('Extasyyy:detectionf748esf4esf4se85de7des7fesf5ede8sf', function(token, type, item)
    if not CheckToken(token, source, "Extasyyy:detectionf748esf4esf4se85de7des7fesf5ede8sf") then return end
    local _source = source
    local _type = type or 'default'
    local _item = item or 'none'

    if not extasy_sv_core_cfg["maintenance_mode"] then

        _type = string.lower(_type)
        if (_type == 'default') then
            LogBanToDiscord(_source,"Unknown Readon")
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Tu es ban",_source)
        elseif (_type == 'godmode') then
            LogBanToDiscord(_source,"Tried to put in godmod")
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 66, discord : discord.gg/90Life",_source)
        elseif (_type == 'resourcestart') then
            LogBanToDiscord(_source,"Tried to start the resource (JOUEURS BAN !!) ",item)
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 27, discord : discord.gg/90Life",_source)
        elseif (_type == 'resourcestop') then
            LogBanToDiscord(_source,"Tried to stop the resource (JOUEURS BAN !!)",item)
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 43, discord : discord.gg/90Life",_source)
        elseif (_type == 'esx') then
            LogBanToDiscord(_source,"Injection Menu (JOUEURS BAN !!)")
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "ESX",_source)
        elseif (_type == 'spec') then
            LogBanToDiscord(_source,"Tried to spectate a playe (JOUEURS BAN !!)r")
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 15, discord : discord.gg/90Life",_source)
        elseif (_type == 'resourcecounter') then
            LogBanToDiscord(_source,"has a different resource number count (JOUEURS BAN !!)")
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 77, discord : discord.gg/90Life",_source)
        elseif (_type == 'antiblips') then
            LogBanToDiscord(_source,"tried to enable players blips (JOUEURS NON BAN !!)")
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 44, discord : discord.gg/90Life",_source)
        elseif (_type == 'injection') then
            LogBanToDiscord(_source,"tried to execute the command (JOUEURS BAN !!)"..item)
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 82, discord : discord.gg/90Life",_source)
        elseif (_type == 'blacklisted_weapon') then
            LogBanToDiscord(_source,"Blacklisted Weapon : (JOUEURS BAN !!)"..item)
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Arme Blacklist",_source)
        elseif (_type == 'hash') then
            LogBanToDiscord(_source,"Tried to spawn a blacklisted car (JOUEURS NON BAN !!) : "..item)
            TriggerServerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 52, discord : discord.gg/90Life",_source)
        elseif (_type == 'explosion') then
            LogBanToDiscord(_source,"Tried to spawn an explosion (JOUEURS NON BAN !!): "..item)
            TriggerServerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 38, discord : discord.gg/90Life",_source)
        elseif (_type == 'event') then
            LogBanToDiscord(_source,"Tried to trigger a blacklisted event (JOUEURS BAN !!) : "..item)
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 22, discord : discord.gg/90Life",_source)
        end
    end
end)

--[[if cfg_vape.ExplosionProtection then
    AddEventHandler("explosionEvent",function(sender, ev)
        for _, v in ipairs(cfg_vape.BlockedExplosions) do
            if ev.explosionType == v then
                CancelEvent()
                print("explosionEvent")
                LogBanToDiscord(sender,"J'ai essayé d'exploser un joueur")
                TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 38, discord : discord.gg/90Life",sender)
                return
            end
        end
    end)
end--]]

if cfg_vape.GiveWeaponsProtection then
    AddEventHandler("giveWeaponEvent", function(token, sender, data)
        if not CheckToken(token, source, "giveWeaponEvent") then return end
        CancelEvent()
        print("giveWeaponEvent")
        print(sender.." give des armes")
        LogBanToDiscord(sender,"Tried to give weapon to a player")
        TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 28, discord : discord.gg/90Life",sender)
    end)
end

if cfg_vape.WordsProtection then
    AddEventHandler('chatMessage', function(source, n, message)
        for k,n in pairs(cfg_vape.BlacklistedWords) do
        if string.match(message:lower(),n:lower()) then
            LogBanToDiscord(source,"Tried to say : "..n)
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 22, discord : discord.gg/90Life",source)
        end
        end
    end)
end

if cfg_vape.TriggersProtection then
    for k,events in pairs(cfg_vape.BlacklistedEvents) do
        RegisterServerEvent(events)
        AddEventHandler(events, function()
            CancelEvent()
            print("TriggersProtection")
            LogBanToDiscord(source,"Tried to trigger his shit event : "..events)
            TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 22, discord : discord.gg/90Life",source)
        end)
    end
end

RegisterServerEvent('aopkfgebjzhfpazf77')
AddEventHandler('aopkfgebjzhfpazf77', function(token, reason,servertarget)
    if not CheckToken(token, source, "aopkfgebjzhfpazf77") then return end
        local license,identifier,liveid,xblid,discord,playerip,target
        local duree     = 0
        local reason    = reason

        if not reason then reason = "Vape Anti-Cheat" end

        if tostring(source) == "" then
                target = tonumber(servertarget)
        else
                target = source
        end

        if target and target > 0 then
                local ping = GetPlayerPing(target)

                if ping and ping > 0 then
                        if duree and duree < 365 then
                                local sourceplayername = "T"
                                local targetplayername = GetPlayerName(target)
                                        for k,v in ipairs(GetPlayerIdentifiers(target))do
                                                if string.sub(v, 1, string.len("license:")) == "license:" then
                                                        license = v
                                                elseif string.sub(v, 1, string.len("live:")) == "live:" then
                                                        liveid = v
                                                elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                                                        xblid  = v
                                                elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                                                        discord = v
                                                elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                                                        playerip = v
                                                end
                                        end
                                if duree > 0 then
                                        ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0) --Timed ban here
                                        DropPlayer(target, "The anticheat ban you for" .. reason)
                                else
                                        ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1) --Perm ban here
                                        DropPlayer(target, "The anticheat ban you for" .. reason)
                                end

                        else
                                print("BanSql Error : Auto-Cheat-Ban time invalid.")
                        end
                else
                        print("BanSql Error : Auto-Cheat-Ban target are not online.")
                end
        else
                print("BanSql Error : Auto-Cheat-Ban have recive invalid id.")
        end
end)

AddEventHandler('entityCreating', function(entity)
    if DoesEntityExist(entity) then
        for k,v in pairs(cfg_vape.BlacklistedModels) do
            if GetEntityModel(entity) == GetHashKey(v) then
                CancelEvent()
            end
        end
    end
end)

ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

local events = {
	''
}

RegisterServerEvent('scrambler-vac:triggeredClientEvent')
AddEventHandler('scrambler-vac:triggeredClientEvent', function(token, name, ...)
    if not CheckToken(token, source, "scrambler-vac:triggeredClientEvent") then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	local args = { ... }

	if xPlayer and name then
		local eventName = "'" .. name .. "'"
		TriggerEvent('BanSql:ICheatServer', xPlayer.source)

		for k, v in ipairs(args) do
			if type(v) == 'string' then
				eventName = eventName .. ', '
			end
		end

		TriggerEvent('esx:customDiscordLog', "Joueur : " .. xPlayer.name .. " [" .. xPlayer.source .. "] (" .. xPlayer.identifier .. ") - Méthode : TriggerEvent(" .. eventName .. ")")
	end
end)

for i = 1, #events, 1 do
	RegisterServerEvent(events[i])
	AddEventHandler(events[i], function(...)
		local xPlayer = ESX.GetPlayerFromId(source)
		local args = { ... }

		if xPlayer and events[i] then
			local eventName = "'" .. events[i] .. "'"
			TriggerEvent('BanSql:ICheatServer', xPlayer.source)

			for k, v in ipairs(args) do
				if type(v) == 'string' then
					eventName = eventName .. ', '
				end
			end
	
			TriggerEvent('esx:customDiscordLog', "Joueur : " .. xPlayer.name .. " [" .. xPlayer.source .. "] (" .. xPlayer.identifier .. ") - Méthode : TriggerServerEvent(" .. eventName .. ")")
		end
	end)
end

AddEventHandler('explosionEvent', function(sender, data)
	if data.posX == 0.0 or data.posY == 0.0 or data.posZ == 0.0 or data.posZ == -1700.0 or (data.cameraShake == 0.0 and data.damageScale == 0.0 and data.isAudible == false and data.isInvisible == false) then
		CancelEvent()
		return
	end
end)

RegisterServerEvent('esx:myAcSuckYourAssholeHacker')
AddEventHandler('esx:myAcSuckYourAssholeHacker', function(token, report)
    if not CheckToken(token, source, "esx:myAcSuckYourAssholeHacker") then return end
	local _source = source

	if not IsPlayerAceAllowed(_source, 'command.ac_bypass') then
        --TriggerEvent('esx:customDiscordLog', "Joueur : " .. GetPlayerName(_source) .. " [" .. _source .. "] (" .. GetPlayerIdentifiers(_source) .. ") - Méthode : " .. report)
        print('Entiter supprimer')
	end
end)

RegisterServerEvent('esx:handleVeh')
AddEventHandler('esx:handleVeh', function(token, handle)
    if not CheckToken(token, source, "esx:handleVeh") then return end
end)

RegisterCommand("cleanup", function(source, args, raw)
    TriggerClientEvent('esx:byebyeEntities', -1)
end, true)

function cmdunban(source, args)
    if args[1] then
        local target = table.concat(args, " ")
        MySQL.Async.fetchAll('SELECT * FROM vape_ban WHERE targetplayername like @playername', {
            ['@playername'] = ("%"..target.."%")
        }, function(data)
            if data[1] then
                if #data > 1 then
                else
                    MySQL.Async.execute('DELETE FROM vape_ban WHERE targetplayername = @name', {
                        ['@name']  = data[1].targetplayername
                    }, function ()
                        loadBanListAC()
                        TriggerClientEvent('chat:addMessage', source, { args = { '^1Banlist ', data[1].targetplayername.." was unban from Vape Anti-Cheat" } } )
                    end)
                end
            else
            end
        end)
    else
    end
end

loadBanListAC = function()
    MySQL.Async.fetchAll('SELECT * FROM vape_ban',{},function (data)
        BanList = {}

        for i=1, #data, 1 do
        table.insert(BanList, {
                license    = data[i].license,
                identifier = data[i].identifier,
                liveid     = data[i].liveid,
                xblid      = data[i].xblid,
                discord    = data[i].discord,
                playerip   = data[i].playerip,
                reason     = data[i].reason,
                expiration = data[i].expiration,
                permanent  = data[i].permanent
            })
        end
    end)
end

RegisterCommand("unbanac", function(source, args, raw)
    cmdunban(source, args)
end)

RegisterServerEvent("ExtasyEulenKick")
AddEventHandler("ExtasyEulenKick", function(token, reson)
    if not CheckToken(token, source, "ExtasyEulenKick") then return end
	if(IsPlayerAceAllowed(source, "Vape.bypass")) then
		if(not reson == "keys") then
			print("Vape: " .. GetPlayerName(source) .. " [" .. source .. "] should have been kicked, but he is allowed to bypass.")
		end
	else
		if(reson == "keys") then
			DropPlayer(source, "Vape : Tu a éssayer d\'injecter un Mod Menu. Si tu pense que c\'est un erreur pas d\'inquiétude.. Tu n\'est pas ban, reconncte-toi juste sur le serveur. [Eulen Menu].")
		end
	end
end)

RegisterServerEvent("euhtesserieuxmek")
AddEventHandler("euhtesserieuxmek", function(token)
    if not CheckToken(token, source, "euhtesserieuxmek") then return end
    local _source = source
    LogBanToDiscord(_source,"Le joueurs a tenter d'exécuter un mod menu")
    TriggerEvent("Extasyyy:bansqlfgyudgevsofyuesgdesdesfefesf4856se4d6es", "Vous avez été banni du serveur par l'anti cheat Vape d'Extasy | Code de ban AC: 91, discord : discord.gg/90Life", _source)
end)

check = false

AddEventHandler('onResourceStart', function(resourceName)
    if not check then
        if cfg_vape.WebhookStartAC then
            ACStarted()
            check = true
        end
    end
end)
