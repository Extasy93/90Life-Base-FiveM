ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'weazelnews', 'weazelnews', 'society_weazelnews', 'society_weazelnews', 'society_weazelnews', {type = 'private'})

SendToDiscordToWeazelNews = function(name,message,color,url)
	local embeds = {
		{
			["title"]= message,
			["type"]= "rich",
			["color"] = color,
			["footer"]=  {
			    ["text"]= "Weazel News Accueil",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(extasy_sv_core_cfg["webhook_weazel_news_1"], function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

SendToDiscordToWeazelNews2 = function(name,message,color,url)
	local embeds = {
		{
			["title"]= message,
			["type"]= "rich",
			["color"] = color,
			["footer"]=  {
			    ["text"]= "Weazel News Accueil",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(extasy_sv_core_cfg["webhook_weazel_news_2"], function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('WeazelNews:SendWebhookLobby')
AddEventHandler('WeazelNews:SendWebhookLobby', function(token, discord, msg)
    if not CheckToken(token, source, "WeazelNews:SendWebhookLobby") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    SendToDiscordToWeazelNews("Demande accueil Weazel News","Demande reçue de: ** Discord: **__"..discord.."__:\n\n**Message:** "..msg, 16744192)
end)

RegisterServerEvent('WeazelNews:SendWebhookLobby2')
AddEventHandler('WeazelNews:SendWebhookLobby2', function(token, discord, msg)
    if not CheckToken(token, source, "WeazelNews:SendWebhookLobby2") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    SendToDiscordToWeazelNews2("Demande accueil Weazel News","Demande reçue de: ** Discord: **__"..discord.."__:\n\n**Message:** "..msg, 16744192)
end)