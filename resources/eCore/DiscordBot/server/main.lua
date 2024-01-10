DiscordLOG.orange 				  = 16744192

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

function sendToDiscordEntreprise(name,message,color)
  
		local embeds = {
			{
				["title"]=message,
				["type"]="rich",
				["color"] =color,
				["footer"]=  {
					["text"]= "Discord Bot By Extasy#0093",
			   },
			}
		}
		
		if message == nil or message == '' then
			return false
		end
		PerformHttpRequest(extasy_sv_core_cfg["webhook_society"], function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscordBan(name, message, color)
	if message == nil or message == '' then
		return false
	end

	local embeds = {
		{
			['title'] = message,
			['type'] = 'rich',
			['color'] = color,
			['footer'] = {
				['text'] = 'Exta Logs'
			}
		}
	}

	PerformHttpRequest(DiscordLOG.webhookBan, function() end, 'POST', json.encode({username = name, embeds = embeds}), {['Content-Type'] = 'application/json'})
end

function sendToDiscordUnban(name, message, color)
	if message == nil or message == '' then
		return false
	end

	local embeds = {
		{
			['title'] = message,
			['type'] = 'rich',
			['color'] = color,
			['footer'] = {
				['text'] = 'Exta Logs'
			}
		}
	}

	PerformHttpRequest(DiscordLOG.webhookUnban, function() end, 'POST', json.encode({username = name, embeds = embeds}), {['Content-Type'] = 'application/json'})
end

--Boucle NOTO--

--[[PerformHttpRequest('https://ip-check.online/myip.php', function(err, text, headers)
	if text == '51.210.223.78' or text == '89.83.167.154' then
		Wait(1000)
		print('^2 Autentification de la machine Successfully! Bienvenue sur 90\'s Life ^0')
		sendToDiscord2(('serveur'), ('Le serveur à démarré'), DiscordLOG.green)
	else
		Wait(10000)
		sendToDiscord2(('serveur'), ('Le serveur a été démarré sur une autre machine quelle celle de 90\'s Life ('..text..')'), DiscordLOG.green)
		print('^1 Le serveur a été démarré sur une autre machine quelle celle de 90\'s Life. Crash du serveur dans 1 seconde ^0')
		Wait(1000)
		os.exit()
	end
end, 'GET', "")--]]

--TriggerEvent("esx:depositsocietymoney",name,amount,societyName) 
RegisterServerEvent('esx:depositsocietymoney')
AddEventHandler('esx:depositsocietymoney', function(token, name, amount, societyName)
	if not CheckToken(token, source, "esx:depositsocietymoney") then return end
	sendToDiscordEntreprise(('Coffre Entreprise'), name .. ' a déposé ' .. amount .. '$ dans le coffre de ' .. societyName, DiscordLOG.orange)
end)

--TriggerEvent("esx:withdrawsocietymoney", name, amount, society)
RegisterServerEvent('esx:withdrawsocietymoney')
AddEventHandler('esx:withdrawsocietymoney', function(token, name, amount, societyName)
	if not CheckToken(token, source, "esx:withdrawsocietymoney") then return end
	sendToDiscordEntreprise(('Coffre Entreprise'), name .. ' a retiré ' .. amount .. '$ dans le coffre de ' .. societyName, DiscordLOG.orange)
end)

RegisterServerEvent('esx:confiscateitem')
AddEventHandler('esx:confiscateitem', function(token, name, nametarget, itemname, amount, job)
	if not CheckToken(token, source, "esx:confiscateitem") then return end
	sendToDiscord(('Confisquer Item'), name .. ' a confisqué ' .. amount .. 'x ' .. itemname .. ' à ' .. nametarget .. ' JOB: ' .. job, DiscordLOG.orange)
end)

RegisterServerEvent('esx:customDiscordLogBan')
AddEventHandler('esx:customDiscordLogBan', function(token, embedContent, botName, embedColor)
	if not CheckToken(token, source, "esx:customDiscordLogBan") then return end
	sendToDiscordBan(botName or 'Ban', embedContent or 'Message Vide', embedColor or DiscordLOG.red)
end)

RegisterServerEvent('esx:customDiscordLogUnban')
AddEventHandler('esx:customDiscordLogUnban', function(token, embedContent, botName, embedColor)
	if not CheckToken(token, source, "esx:customDiscordLogUnban") then return end
	sendToDiscordUnban(botName or 'Unban', embedContent or 'Message Vide', embedColor or DiscordLOG.green)
end)

--  TriggerEvent("eGiveitemalert",sourceXPlayer.name,targetXPlayer.name,ESX.Items[itemName].label,itemCount) 
RegisterServerEvent("eGiveitemalert")
AddEventHandler("eGiveitemalert", function(name,nametarget,itemname,amount)
    sendToDiscordTSC('Nouvelle transaction',name..'a donné a '..nametarget.." x"..amount .." "..itemname,DiscordLOG.orange)
end)

-- TriggerEvent("eGivemoneyalert",sourceXPlayer.name,targetXPlayer.name,itemCount) 
RegisterServerEvent("eGivemoneyalert")
AddEventHandler("eGivemoneyalert", function(name,nametarget,amount)
    sendToDiscordTSCmoney('Nouvelle transaction (argent)',name.." "..'a donné à'.." "..nametarget.." x"..amount .." dollars",DiscordLOG.vert)
end)

-- TriggerEvent("eGivemoneyalert",sourceXPlayer.name,targetXPlayer.name,itemCount) 
RegisterServerEvent("eGivemoneybankalert")
AddEventHandler("eGivemoneybankalert", function(token, name,nametarget,amount)
	if not CheckToken(token, source, "eGivemoneybankalert") then return end
	sendToDiscordTSCmoney('Nouvelle transaction (argent banque)',name.." ".. 'a donné a' .." "..nametarget.." x"..amount .." dollars",DiscordLOG.orange)
end)


--  TriggerEvent("eGiveweaponalert",sourceXPlayer.name,targetXPlayer.name,weaponLabel) 
RegisterServerEvent("eGiveweaponalert")
AddEventHandler("eGiveweaponalert", function(token, name,nametarget,weaponlabel)
	if not CheckToken(token, source, "eGiveweaponalert") then return end
    sendToDiscordTSC('Nouvelle transaction (arme)',name.." "..'a donné a '.." "..nametarget.." "..weaponlabel,DiscordLOG.orange)
end)

--Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO--
--Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO--
--Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO--
--Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO----Boucle AC LOG NOTO--


-- Error Check

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

if DiscordWebhookSystemInfos == nil and DiscordWebhookKillinglogs == nil and DiscordWebhookChat == nil then
	local Content = LoadResourceFile(GetCurrentResourceName(), 'DiscordLOG.lua')
	Content = load(Content)
	Content()
end
if DiscordWebhookSystemInfos == 'https://discord.com/api/webhooks/784751592825290772/pvITNly0nwvLHBHd1CKdOMgLCZRlEMKRqoIF-lIjws6v-fGIXWfHSyxzlOeNke7VzRUG' then
	--print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "System Infos" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			--print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "System Infos" webhook non-existing!\n\n')
		end
	end)
end
if DiscordWebhookKillinglogs == 'https://discord.com/api/webhooks/784751592825290772/pvITNly0nwvLHBHd1CKdOMgLCZRlEMKRqoIF-lIjws6v-fGIXWfHSyxzlOeNke7VzRUG' then
	--print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "Killing Log" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookKillinglogs, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			--print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "Killing Log" webhook non-existing!\n\n')
		end
	end)
end
if DiscordWebhookChat == 'https://discord.com/api/webhooks/784751592825290772/pvITNly0nwvLHBHd1CKdOMgLCZRlEMKRqoIF-lIjws6v-fGIXWfHSyxzlOeNke7VzRUG' then
	--print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "Chat" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookChat, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			--print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "Chat" webhook non-existing!\n\n')
		end
	end)
end

-- Killing Log
RegisterServerEvent('DiscordBot:playerDied')
AddEventHandler('DiscordBot:playerDied', function(token, Message, Weapon)
	if not CheckToken(token, source, "DiscordBot:playerDied") then return end
	local date = os.date('*t')
	
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	if Weapon then
		Message = Message .. ' [' .. Weapon .. ']'
	end


--[[
	TriggerEvent("es:getPlayers", function(pl)
		for k,v in pairs(pl) do
			TriggerEvent("es:getPlayerFromId", k, function(user)
				if(user.getPermissions() > 0 and k ~= source)then
					TriggerClientEvent('chat:addMessage', k, {
						args = {"^1REPORT", " (^8" .. Message}
					})
				end
			end)
		end
	end)
]]--
	TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookKillinglogs, SystemName, Message .. ' `' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. '`', SystemAvatar, false)
end)

-- Chat
AddEventHandler('chatMessage', function(Source, Name, Message)
	local Webhook = DiscordWebhookChat; TTS = false
	local _source = source
	
	--Removing Color Codes (^0, ^1, ^2 etc.) from the name and the message
	for i = 0, 9 do
		Message = Message:gsub('%^' .. i, '')
		Name = Name:gsub('%^' .. i, '')
	end
		
	--Splitting the message in multiple strings
	MessageSplitted = stringsplit(Message, ' ')
	
	--Checking if the message contains a blacklisted command
	--print("Di: " .. GetPlayerName(Source))
	
	if GetPlayerName(Source) ~= "Extasy" then
		--Checking if the message contains a command which has his own webhook
		if IsCommand(MessageSplitted, 'HavingOwnWebhook') then
			Webhook = GetOwnWebhook(MessageSplitted)
		end
		
		--Checking if the message contains a special command
		if IsCommand(MessageSplitted, 'Special') then
			MessageSplitted = ReplaceSpecialCommand(MessageSplitted)
		end
		
		---Checking if the message contains a command which belongs into a tts channel
		if IsCommand(MessageSplitted, 'TTS') then
			TTS = true
		end
		
		--Combining the message to one string again
		Message = ''
		
		for Key, Value in ipairs(MessageSplitted) do
			Message = Message .. Value .. ' '
		end
		
		--Adding the username if needed
		Message = Message:gsub('USERNAME_NEEDED_HERE', GetPlayerName(Source))
		
		--Adding the userid if needed
		Message = Message:gsub('USERID_NEEDED_HERE', Source)
		
		-- Shortens the Name, if needed
		if Name:len() > 23 then
			Name = Name:sub(1, 23)
		end

		TriggerEvent('DiscordBot:ToDiscord', Webhook, Name .. ' [ID: ' .. Source .. ']', Message, AvatarURL, false, Source, TTS) --Sending the message to discord

	end
end)

--Event to actually send Messages to Discord
RegisterServerEvent('DiscordBot:ToDiscord')
AddEventHandler('DiscordBot:ToDiscord', function(WebHook, Name, Message, Image, External, Source, TTS)
	if Message == nil or Message == '' then
		return nil
	end
	if TTS == nil or TTS == '' then
		TTS = false
	end
	if External then
		if WebHook:lower() == 'system' then
			WebHook = DiscordWebhookSystemInfos
		elseif WebHook:lower() == 'kill' then
			WebHook = DiscordWebhookKillinglogs
		elseif not Webhook:find('discordapp.com/api/webhooks') then
			print('ToDiscord event called without a specified webhook!')
			return nil
		end
		
		if Image:lower() == 'steam' then
			Image = UserAvatar
			if GetIDFromSource('steam', Source) then
				PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
					local SteamProfileSplitted = stringsplit(Content, '\n')
					for i, Line in ipairs(SteamProfileSplitted) do
						if Line:find('<avatarFull>') then
							Image = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', '')
							return PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
						end
					end
				end)
			end
		elseif Image:lower() == 'user' then
			Image = UserAvatar
		else
			Image = SystemAvatar
		end
	end
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
end)

-- Functions
function IsCommand(String, Type)
	if Type == 'Blacklisted' then
		for i, BlacklistedCommand in ipairs(BlacklistedCommands) do
			if String[1]:lower() == BlacklistedCommand:lower() then
				return true
			end
		end
	elseif Type == 'Special' then
		for i, SpecialCommand in ipairs(SpecialCommands) do
			if String[1]:lower() == SpecialCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'HavingOwnWebhook' then
		for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
			if String[1]:lower() == OwnWebhookCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'TTS' then
		for i, TTSCommand in ipairs(TTSCommands) do
			if String[1]:lower() == TTSCommand:lower() then
				return true
			end
		end
	end
	return false
end

function ReplaceSpecialCommand(String)
	for i, SpecialCommand in ipairs(SpecialCommands) do
		if String[1]:lower() == SpecialCommand[1]:lower() then
			String[1] = SpecialCommand[2]
		end
	end
	return String
end

function GetOwnWebhook(String)
	for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
		if String[1]:lower() == OwnWebhookCommand[1]:lower() then
			if OwnWebhookCommand[2] == 'https://discord.com/api/webhooks/784751592825290772/pvITNly0nwvLHBHd1CKdOMgLCZRlEMKRqoIF-lIjws6v-fGIXWfHSyxzlOeNke7VzRUG' then
				print('Please enter a webhook link for the command: ' .. String[1])
				return DiscordWebhookChat
			else
				return OwnWebhookCommand[2]
			end
		end
	end
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	if input ~= nil then

		for str in string.gmatch(input, '([^'..seperator..']+)') do
			t[i] = str
			i = i + 1
		end
	end
	
	return t
end

function GetIDFromSource(Type, ID)
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end

-- ONLY EDIT BELOW THIS --
local DISCORD_NAME = "Connection / Déconnetion"
local DISCORD_IMAGE = "https://cdn.discordapp.com/attachments/787010501099257906/787011298344435773/telechargement.jpg"
local communityname = "Discord Bot By Extasy#0093"
local STEAM_KEY = "EC9DC0B0CF017C3B16DDC3B6559120BD"

--DON'T EDIT BELOW THIS --
PerformHttpRequest(extasy_sv_core_cfg["webhook_connexion"], function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, content = "90\'s Life Log de Connexion : **ON**", avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

AddEventHandler('playerConnecting', function() 
local color = 65280
    sendToDiscord("leeg", "Connexion au serveur", color)
end)

AddEventHandler('playerDropped', function(reason)
local color = 16711680
	if string.match(reason, "Kick") or string.match(reason, "Ban") then
		color = 16007897
	end
  sendToDiscord("leeg", "Déconnexion du serveur. \nRaison: " .. reason, color)
end)

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function sendToDiscord(name, message, color)
local name = GetPlayerName(source)
local ip = GetPlayerEndpoint(source)
local ping = GetPlayerPing(source)
local steamhex = GetPlayerIdentifiers(source)[1]
local connect = {
        {
			["color"] = color,
            ["title"] = message,
            ["description"] = "Joueur / Joueuse: **"..name.."**\nIP: **"..ip.."**\n Identifiant: **"..steamhex.."**",
	        ["footer"] = {
                ["text"] = communityname,
                ["icon_url"] = DISCORD_IMAGE,
            },
        }
    }
  PerformHttpRequest(extasy_sv_core_cfg["webhook_connexion"], function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscordTSC(name,message,color)
  
  local embeds = {
	  {
		  ["title"]=message,
		  ["type"]="rich",
		  ["color"] =color,
		  ["footer"]=  {
			  ["text"]= "Discord Bot By Extasy#0093",
		 },
	  }
  }
  
	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(extasy_sv_core_cfg["webhook_transaction_object"], function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscordTSCmoney(name,message,color)

	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
				["text"]= "Discord Bot By Extasy#0093",
			},
		}
	}

	if message == nil or message == '' then return FALSE end
	PerformHttpRequest(extasy_sv_core_cfg["webhook_transaction_money"], function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


