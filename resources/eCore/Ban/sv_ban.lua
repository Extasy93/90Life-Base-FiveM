BanList            = {}
BanListLoad        = false

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

CreateThread(function()
	while true do
		Wait(1000)
        if BanListLoad == false then
			loadBanList()
			if BanList ~= {} then
				print("La BanList a ete charger avec succes.")
				BanListLoad = true
			else
				print("ERREUR : La BanList ou l'historique n'a pas ete charger nouvelle tentative.")
			end
		end
	end
end)

CreateThread(function()
	Wait(2000)
	MySQL.Async.fetchAll('SELECT * FROM banlist', {}, function(data)
		if #data ~= #BanList then
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
				added      = data[i].added,
				expiration = data[i].expiration,
				permanent  = data[i].permanent
				})
			end
		TriggerClientEvent('BanSql:Respond', -1)
		end
	end)
end)

TriggerEvent('es:addGroupCommand', 'banreload', "admin", function (source)
	BanListLoad        = false
	Wait(500)
	if BanListLoad == true then
		TriggerEvent('bansql:sendMessage', source, "La BanList a ete charger avec succes.")
	else
		TriggerEvent('bansql:sendMessage', source, "ERREUR : La BanList n'a pas été charger.")
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.reload})

TriggerEvent('es:addGroupCommand', 'unban', "admin", function (source, args, user)
	if args[1] then
		local target = table.concat(args, " ")
		MySQL.Async.fetchAll('SELECT * FROM banlist WHERE targetplayername like @playername', 
		{
			['@playername'] = ("%"..target.."%")
		}, function(data)
			if data[1] then
				if #data > 1 then
					TriggerEvent('bansql:sendMessage', source, "Trop de résultats, veillez être plus précis.")
					for i=1, #data, 1 do
						TriggerEvent('bansql:sendMessage', source, data[i].targetplayername)
					end
				else
					MySQL.Async.execute(
					'DELETE FROM banlist WHERE targetplayername = @name',
					{
					['@name']  = data[1].targetplayername
					},
						function ()
						loadBanList()
						if cfg_ban.EnableDiscordLink then
							local sourceplayername = GetPlayerName(source)
							local message = (data[1].targetplayername.." a été déban par "..sourceplayername)
							sendToDiscordBAN(extasy_sv_core_cfg["webhook_unban"], message)
						end
						TriggerEvent('bansql:sendMessage', source, data[1].targetplayername.." a été déban")
					end)
				end
			else
				TriggerEvent('bansql:sendMessage', source, "Le nom n'est pas valide")
			end

		end)
	else
		TriggerEvent('bansql:sendMessage', source, Text.cmdunban)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.unban, params = {{name = "name", help = Text.steamname}}})

TriggerEvent('es:addGroupCommand', 'ban', "mod", function (source, args, user)
	local license,identifier,liveid,xblid,discord,playerip
	local target    = tonumber(args[1])
	local duree     = tonumber(args[2])
	local reason    = table.concat(args, " ",3)
	print(target)
	print(duree)
	print(reason)

	if args[1] then		
		if reason == "" then
			reason = Text.noreason
		end
		if target and target > 0 then
			local ping = GetPlayerPing(target)
		
			if ping and ping > 0 then
				if duree and duree < 365 then
					local sourceplayername = GetPlayerName(source)
					local targetplayername = GetPlayerName(target)
					
					for k,v in ipairs(GetPlayerIdentifiers(target))do
						if string.sub(v, 1, string.len("license:")) == "license:" then
							license = v
						elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
							identifier = v
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
						ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0)
						DropPlayer(target, "\n💢Vous avez été banni du serveur\n\n📜Raison: " ..reason.."\n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
					else
						ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1)
						DropPlayer(target, "\n💢Vous avez été banni du serveur\n\n📜Raison: " ..reason.."\n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
					end
				else
					TriggerEvent('bansql:sendMessage', source, "Duree du ban incorrecte")
				end	
			else
				TriggerEvent('bansql:sendMessage', source, "ID du joueur incorrect")
			end
		else
			TriggerEvent('bansql:sendMessage', source, "ID du joueur incorrect")
		end
	else
		TriggerEvent('bansql:sendMessage', source, "Text.cmdban")
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.ban, params = {{name = "id"}, {name = "day", help = Text.dayhelp}, {name = "reason", help = Text.reason}}})

--How to use from server side : TriggerEvent("BanSql:ICheat", "Auto-Cheat Custom Reason",TargetId)
RegisterServerEvent('BanSql:ICheat')
AddEventHandler('BanSql:ICheat', function(reason,servertarget)
	local license,identifier,liveid,xblid,discord,playerip,target
	local duree     = 0
	local reason    = reason

	if not reason then reason = "Pffff t cramé mon reuf..." end

	if tostring(source) == "" then
		target = tonumber(servertarget)
	else
		target = source
	end

	if target and target > 0 then
		local ping = GetPlayerPing(target)
	
		if ping and ping > 0 then
			if duree and duree < 365 then
				local sourceplayername = "Anti-Cheat-System"
				local targetplayername = GetPlayerName(target)
					for k,v in ipairs(GetPlayerIdentifiers(target))do
						if string.sub(v, 1, string.len("license:")) == "license:" then
							license = v
						elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
							identifier = v
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
					ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0)
					DropPlayer(target, "\n💢Vous avez été banni du serveur\n\n📜Raison: " ..reason.."\n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
				else
					ban(target,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1)
					DropPlayer(target, "\n💢Vous avez été banni du serveur\n\n📜Raison: " ..reason.."\n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
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

RegisterServerEvent('BanSql:CheckMe')
AddEventHandler('BanSql:CheckMe', function()
	doublecheck(source)
end)

AddEventHandler('bansql:sendMessage', function(source, message)
	print('Ban Système: ' .. message)
end)

AddEventHandler('playerConnecting', function (playerName, setKickReason)
	local license, steamID, liveid, xblid, discord, playerip  = "n/a", "n/a", "n/a", "n/a", "n/a", "n/a"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
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

	if BanList == {} then
		setKickReason("\n💢La liste de ban du serveur n'est pas encore chargé \n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
		loadBanList()
	else
		for i = 1, #BanList, 1 do
			if ((tostring(BanList[i].license)) == tostring(license) or (tostring(BanList[i].identifier)) == tostring(steamID) or (tostring(BanList[i].liveid)) == tostring(liveid) or (tostring(BanList[i].xblid)) == tostring(xblid) or (tostring(BanList[i].discord)) == tostring(discord) or (tostring(BanList[i].playerip)) == tostring(playerip)) then
				if (tonumber(BanList[i].permanent)) == 1 then
					setKickReason("\n💢Vous avez été banni du serveur\n\n📜Raison: " ..BanList[i].reason.."\n⏰Expiration: Permanant\n📌License ID: "..BanList[i].license.."\n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
					CancelEvent()
					break
				elseif (tonumber(BanList[i].expiration)) > os.time() then
					local tempsrestant     = (((tonumber(BanList[i].expiration)) - os.time())/60)
					if tempsrestant >= 1440 then
						local day        = (tempsrestant / 60) / 24
						local hrs        = (day - math.floor(day)) * 24
						local minutes    = (hrs - math.floor(hrs)) * 60
						local txtday     = math.floor(day)
						local txthrs     = math.floor(hrs)
						local txtminutes = math.ceil(minutes)

						setKickReason("\n💢Vous avez été banni du serveur\n\n📜Raison: " ..BanList[i].reason.."\n⏰Expiration: " ..txtday.. " Jours " ..txthrs.. " Heures " ..txtminutes.. " Minutes\n📌License ID: "..BanList[i].license.."\n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
						CancelEvent()
						break
					elseif tempsrestant >= 60 and tempsrestant < 1440 then
						local day        = (tempsrestant / 60) / 24
						local hrs        = tempsrestant / 60
						local minutes    = (hrs - math.floor(hrs)) * 60
						local txtday     = math.floor(day)
						local txthrs     = math.floor(hrs)
						local txtminutes = math.ceil(minutes)

						setKickReason("\n💢Vous avez été banni du serveur\n\n📜Raison: " ..BanList[i].reason.."\n⏰Expiration: " ..txtday.. " Jours " ..txthrs.. " Heures " ..txtminutes.. " Minutes\n📌License ID: "..BanList[i].license.."\n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
						CancelEvent()
						break
					elseif tempsrestant < 60 then
						local txtday     = 0
						local txthrs     = 0
						local txtminutes = math.ceil(tempsrestant)

						setKickReason("\n💢Vous avez été banni du serveur\n\n📜Raison: " ..BanList[i].reason.."\n⏰Expiration: " ..txtday.. " Jours " ..txthrs.. " Heures " ..txtminutes.. " Minutes\n📌License ID: "..BanList[i].license.."\n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
						CancelEvent()
						break
					end
				elseif (tonumber(BanList[i].expiration)) < os.time() and (tonumber(BanList[i].permanent)) == 0 then
					deletebanned(license)
					break
				end
			else
				deferrals.update(GetPlayerName(source)..", tu es entrain de te connecter à 90's Life ! 💜")
				Wait(1500)
				deferrals.update("Vérification terminée, bienvenue sur 90's Life 💜")
				Wait(1500)
				deferrals.done()
			end
		end
	end
end)

AddEventHandler('esx:playerLoaded', function(xPlayer)
	CreateThread(function()
		Wait(2000)
		local license,steamID,liveid,xblid,discord,playerip
		local playername = GetPlayerName(xPlayer)

		for k,v in ipairs(GetPlayerIdentifiers(xPlayer))do
			if string.sub(v, 1, string.len("license:")) == "license:" then
				license = v
			elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
				steamID = v
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

		MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `license` = @license', {['@license'] = license}, function(data)
		local found = false
			for i=1, #data, 1 do
				if data[i].license == license then
					found = true
				end
			end
			if not found then
				MySQL.Async.execute('INSERT INTO baninfo (license,identifier,liveid,xblid,discord,playerip,playername) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@playername)', 
					{ 
					['@license']    = license,
					['@identifier'] = steamID,
					['@liveid']     = liveid,
					['@xblid']      = xblid,
					['@discord']    = discord,
					['@playerip']   = playerip,
					['@playername'] = playername
					},
					function ()
				end)
			else
				MySQL.Async.execute('UPDATE `baninfo` SET `identifier` = @identifier, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playerip` = @playerip, `playername` = @playername WHERE `license` = @license', 
					{ 
					['@license']    = license,
					['@identifier'] = steamID,
					['@liveid']     = liveid,
					['@xblid']      = xblid,
					['@discord']    = discord,
					['@playerip']   = playerip,
					['@playername'] = playername
					},
					function ()
				end)
			end
		end)
	end)
end)

cmdban = function(source, args)
	local license,identifier,liveid,xblid,discord,playerip
	local target    = tonumber(args[1])
	local duree     = tonumber(args[2])
	local reason    = table.concat(args, " ", 3)

	if args[1] then		
		if reason == "" then
			reason = "Raison Inconnue"
		end
		if target and target > 0 then
			local ping = GetPlayerPing(target)
        
			if ping and ping > 0 then
				if duree and duree < 365 then
					local targetplayername = GetPlayerName(target)
					local sourceplayername = ""
					if source == false then
						sourceplayername = "Console"
					else
						sourceplayername = source.name
					end

						for k,v in ipairs(GetPlayerIdentifiers(target))do
							if string.sub(v, 1, string.len("license:")) == "license:" then
								license = v
							elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
								identifier = v
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
						ban(source,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,0) --Timed ban here
						DropPlayer(target, "\n💢Vous avez été banni du serveur\n\n📜Raison: " ..reason.."\n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
					else
						ban(source,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1) --Perm ban here
						DropPlayer(target, "\n💢Vous avez été banni du serveur\n\n📜Raison: " ..reason.."\n\nSi vous pensez qu'il s'agit d'une erreur, dirigez-vous vers notre discord (💜 https://discord.gg/90Life)")
					end
				
				else
					TriggerEvent('bansql:sendMessage', source, "Duree du ban incorrecte")
				end	
			else
				TriggerEvent('bansql:sendMessage', source, "ID du joueur incorrect")
			end
		else
			TriggerEvent('bansql:sendMessage', source, "ID du joueur incorrect")
		end
	else
		TriggerEvent('bansql:sendMessage', source, "cmdban")
	end
end

cmdunban = function(source, args)
	if args[1] then
	local target = table.concat(args, " ")
		MySQL.Async.fetchAll('SELECT * FROM banlist WHERE license like @playername', {['@playername'] = ("%"..target.."%")}, function(data)
			if data[1] then
				if #data > 1 then
					TriggerEvent('bansql:sendMessage', source, "Trop de résultats, veillez être plus précis.")
					for i=1, #data, 1 do
						TriggerEvent('bansql:sendMessage', source, data[i].license)
					end
				else
					MySQL.Async.execute(
					'DELETE FROM banlist WHERE license = @name',
					{
					['@name']  = data[1].license
					},
						function ()
						loadBanList()
							local sourceplayername = ""
							if source == false then
								sourceplayername = "Console"
							else
								sourceplayername = source.name
							end
							local message = (data[1].license .. " a été déban par ".. sourceplayername)
							PerformHttpRequest(extasy_sv_core_cfg["webhook_unban"], function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
						TriggerEvent('bansql:sendMessage', source, data[1].license .. " a été déban")
					end)
				end
			else
				TriggerEvent('bansql:sendMessage', source, "Le nom n'est pas valide")
			end
		end)
	else
		TriggerEvent('bansql:sendMessage', source, "Le nom n'est pas valide")
	end
end

cmdbanoffline = function(source, args)
	if args ~= "" then
		local target           = args[1]
		local duree            = tonumber(args[2])
		local reason           = table.concat(args, " ",3)
		local sourceplayername = ""
		print(target)
		if source == false then
			sourceplayername = "Console"
		else
			sourceplayername = source.name
		end

		if duree ~= "" then
			if target ~= "" then
				MySQL.Async.fetchAll('SELECT * FROM baninfo WHERE license = @license', 
				{
					['@license'] = "license:"..target
				}, function(data)
					if data[1] then
						if duree and duree < 365 then
							if reason == "" then
								reason = "Raison Inconnue"
							end
							if duree > 0 then --Here if not perm ban
								ban(source,data[1].license,data[1].identifier,data[1].liveid,data[1].xblid,data[1].discord,data[1].playerip,data[1].playername,sourceplayername,duree,reason,0) --Timed ban here
							else --Here if perm ban
								ban(source,data[1].license,data[1].identifier,data[1].liveid,data[1].xblid,data[1].discord,data[1].playerip,data[1].playername,sourceplayername,duree,reason,1) --Perm ban here
							end
						else
							TriggerEvent('bansql:sendMessage', source, "Duree du ban incorrecte")
						end
					else
						TriggerEvent('bansql:sendMessage', source, "ID du joueur incorrect")
					end
				end)
			else
				TriggerEvent('bansql:sendMessage', source, "Le nom n'est pas valide")
			end
		else
			TriggerEvent('bansql:sendMessage', source, "Duree du ban incorrecte")
			TriggerEvent('bansql:sendMessage', source, "cmdbanoff")
		end
	else
		TriggerEvent('bansql:sendMessage', source, "cmdbanoff")
	end
end

ban = function(source,license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,permanent)
	MySQL.Async.fetchAll('SELECT * FROM banlist WHERE targetplayername like @playername', {['@playername'] = ("%"..targetplayername.."%")}, function(data)
		if not data[1] then
			local expiration = duree * 86400 --calcul total expiration (en secondes)
			local timeat     = os.time()
			local added      = os.date()

			if expiration < os.time() then
				expiration = os.time()+expiration
			end
			
			table.insert(BanList, {
				license    = license,
				identifier = identifier,
				liveid     = liveid,
				xblid      = xblid,
				discord    = discord,
				playerip   = playerip,
				reason     = reason,
				expiration = expiration,
				permanent  = permanent
			  })

			MySQL.Async.execute('INSERT INTO banlist (license,identifier,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@license,@identifier,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)',
					{ 
					['@license']          = license,
					['@identifier']       = identifier,
					['@liveid']           = liveid,
					['@xblid']            = xblid,
					['@discord']          = discord,
					['@playerip']         = playerip,
					['@targetplayername'] = targetplayername,
					['@sourceplayername'] = sourceplayername,
					['@reason']           = reason,
					['@expiration']       = expiration,
					['@timeat']           = timeat,
					['@permanent']        = permanent,
					},
					function ()
			end)

			loadBanList()

			if permanent == 0 then
				TriggerEvent('bansql:sendMessage', source, ("Vous avez banni : " .. targetplayername .. " pendant : " .. duree .. " jours. Pour : " .. reason))
			else
				TriggerEvent('bansql:sendMessage', source, ("Vous avez banni : " .. targetplayername .. "Vous avez ete ban permanent pour : " .. reason))
			end

			loadBanList()

			local license1,identifier1,liveid1,xblid1,discord1,playerip1,targetplayername1,sourceplayername1,message
			if not license          then license1          = "N/A" else license1          = license          end
			if not identifier       then identifier1       = "N/A" else identifier1       = identifier       end
			if not liveid           then liveid1           = "N/A" else liveid1           = liveid           end
			if not xblid            then xblid1            = "N/A" else xblid1            = xblid           end
			if not discord          then discord1          = "N/A" else discord1          = discord          end
			if not playerip         then playerip1         = "N/A" else playerip1         = playerip         end
			if not targetplayername then targetplayername1 = "N/A" else targetplayername1 = targetplayername end
			if not sourceplayername then sourceplayername1 = "Joueur Inconnu" else sourceplayername1 = sourceplayername end
			if permanent == 0 then
				message = (targetplayername1.." a été ban "..duree.." jours. Pour : "..reason.."par".." "..sourceplayername1.."```"..identifier1.."\n"..license1.."\n"..liveid1.."\n"..xblid1.."\n"..discord1.."\n"..playerip1.."```")
			else
				message = (targetplayername1.." a été ban Vous avez ete ban permanent pour : "..reason.." ".."par".." "..sourceplayername1.."```"..identifier1.."\n"..license1.."\n"..liveid1.."\n"..xblid1.."\n"..discord1.."\n"..playerip1.."```")
			end
			PerformHttpRequest(extasy_sv_core_cfg["webhook_ban"], function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		else
			TriggerEvent('bansql:sendMessage', source, (targetplayername .. "Deja ban" .. reason))
		end
	end)
end

loadBanList = function()
	MySQL.Async.fetchAll('SELECT * FROM banlist', {}, function(data)
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

deletebanned = function(license) 
	MySQL.Async.execute('DELETE FROM banlist WHERE license=@license', {['@license']  = license}, function()
		loadBanList()
	end)
end

doublecheck = function(player)
	if GetPlayerIdentifiers(player) then
		local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

		for k,v in ipairs(GetPlayerIdentifiers(player))do
			if string.sub(v, 1, string.len("license:")) == "license:" then
				license = v
			elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
				steamID = v
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

		for i = 1, #BanList, 1 do
			if 
				  ((tostring(BanList[i].license)) == tostring(license) 
				or (tostring(BanList[i].identifier)) == tostring(steamID) 
				or (tostring(BanList[i].liveid)) == tostring(liveid) 
				or (tostring(BanList[i].xblid)) == tostring(xblid) 
				or (tostring(BanList[i].discord)) == tostring(discord) 
				or (tostring(BanList[i].playerip)) == tostring(playerip)) 
			then

				if (tonumber(BanList[i].permanent)) == 1 then
					DropPlayer(player, "Vous avez ete ban pour : " .. BanList[i].reason)
					break

				elseif (tonumber(BanList[i].expiration)) > os.time() then

					local tempsrestant     = (((tonumber(BanList[i].expiration)) - os.time())/60)
					if tempsrestant > 0 then
						DropPlayer(player, "Vous avez ete ban pour : " .. BanList[i].reason)
						break
					end

				elseif (tonumber(BanList[i].expiration)) < os.time() and (tonumber(BanList[i].permanent)) == 0 then

					deletebanned(license)
					break

				end
			end
		end
	end
end

RegisterServerEvent('staff:sendBan')
AddEventHandler('staff:sendBan', function(token, args)
    if not CheckToken(token, source, "staff:sendBan") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()

    if playerSrvGroup == "admin" or playerSrvGroup == "superadmin" or playerSrvGroup == "owner" then
		print(args)
		print(source)
        cmdban(source, args)
    end
end)

RegisterServerEvent('staff:sendUnBan')
AddEventHandler('staff:sendUnBan', function(token, args)
    if not CheckToken(token, source, "staff:sendUnBan") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()

    if playerSrvGroup == "admin" or playerSrvGroup == "superadmin" or playerSrvGroup == "owner" then
        cmdunban(source, args)
    end
end)

RegisterServerEvent('staff:sendBanoffline')
AddEventHandler('staff:sendBanoffline', function(token, args)
    if not CheckToken(token, source, "staff:sendBanoffline") then return end
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()

    if playerSrvGroup == "admin" or playerSrvGroup == "superadmin" or playerSrvGroup == "owner" then
        cmdbanoffline(source, args)
    end
end)
