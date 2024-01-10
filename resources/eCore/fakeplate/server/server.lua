ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

local webhookName = "FakePlate Log"
local avatarWebhook = "https://i1.sndcdn.com/artworks-6x9vJH1uzKQJTOLF-xwsaTg-t500x500.jpg"

local authorName = "Fake Plate System"
local authorIcon = "https://i1.sndcdn.com/artworks-6x9vJH1uzKQJTOLF-xwsaTg-t500x500.jpg"

local footerText = "Fake Plate by Extasy#0093"

Citizen.CreateThread(function()
	local char = cfg_fakeplate.PlateLetters
	char = char + cfg_fakeplate.PlateNumbers
	if cfg_fakeplate.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('[fakeplate] [^3WARNING^7] Nombre de caractères de la plaque atteint, %s/8 characters!'):format(char))
	end
end)

ESX.RegisterServerCallback('fakeplate:isPlateTaken', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterUsableItem('Fausses_plaques', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    --local item = xPlayer.getInventoryItem("wrench").count

    --if item > 0 then
        TriggerClientEvent('fakeplate:newPlate', source)
     --else
         --xPlayer.showNotification('Vous avez oublié un outil !')
     --end
end)

ESX.RegisterUsableItem('oldplate', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    --local item = xPlayer.getInventoryItem("wrench").count

    --if item > 0 then
        TriggerClientEvent('fakeplate:oldPlate', source)
     --else
         --xPlayer.showNotification('Vous avez oublié un outil !')
     --end
end)

RegisterServerEvent('fakeplate:useOld')
AddEventHandler('fakeplate:useOld', function(token)
    if not CheckToken(token, source, "fakeplate:useOld") then return end
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('oldplate', 1)
end)

RegisterServerEvent('fakeplate:useFake')
AddEventHandler('fakeplate:useFake', function()
	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.canSwapItem('Fausses_plaques', 1, 'oldplate', 1) then
        xPlayer.removeInventoryItem('Fausses_plaques', 1)
        xPlayer.addInventoryItem('oldplate', 1)
    else
        xPlayer.showNotification('Pas assez d\'espace d\'inventaire.')
    end
end)

RegisterServerEvent('fakeplate:dclog')
AddEventHandler('fakeplate:dclog', function(text)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    dclog(xPlayer, text)
end)

function dclog(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
    
    for k, v in ipairs(GetPlayerIdentifiers(xPlayer.source)) do
        if string.match(v, 'discord:') then
            identifierDiscord = v
        end
        --if string.match(v, 'ip:') then
            --identifierIp = v
        --end
    end
	
	local discord_webhook = GetConvar('discord_webhook', extasy_sv_core_cfg["webhook_fake_plate"])
	if discord_webhook == '' then
	  return
	end
	local headers = {
	  ['Content-Type'] = 'application/json'
	}
	local data = {
        ['username'] = webhookName,
        ['avatar_url'] = avatarWebhook,
        ['embeds'] = {{
          ['author'] = {
            ['name'] = authorName,
            ['icon_url'] = authorIcon
          },
          ['footer'] = {
              ['text'] = footerText
          },
          ['color'] = 12914,
          ['timestamp'] = os.date('!%Y-%m-%dT%H:%M:%SZ')
        }}
      }
    text = '**'..text..'**\n🆔 **ID**: '..tonumber(xPlayer.source)..'\n💻 **Steam:** '..xPlayer.identifier..'\n📋 **Nom du joueur:** '..xPlayer.getName()
    if identifierDiscord ~= nil then
        text = text..'\n🛰️ **Discord:** <@'..string.sub(identifierDiscord, 9)..'>'
        identifierDiscord = nil
    end
    --if identifierIp ~= nil then
        --text = text..'\n🌐 **Ip:** '..string.sub(identifierIp, 4)
        --identifierIp = nil
    --end
    data['embeds'][1]['description'] = text
	PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function Sanitize(str)
	local replacements = {
		['&' ] = '&amp;',
		['<' ] = '&lt;',
		['>' ] = '&gt;',
		['\n'] = '<br/>'
	}

	return str
		:gsub('[&<>\n]', replacements)
		:gsub(' +', function(s)
			return ' '..('&nbsp;'):rep(#s-1)
		end)
end