ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

SendToDiscordToAbateur = function(name,message,color,url)
	local embeds = {
		{
			["title"]= message,
			["type"]= "rich",
			["color"] = color,
			["footer"]=  {
			    ["text"]= "90Life",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(extasy_sv_core_cfg["webhook_pôle_emplois_abateur"], function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('JobListing:SendWebhookAbateur')
AddEventHandler('JobListing:SendWebhookAbateur', function(token, msg)
    if not CheckToken(token, source, "JobListing:SendWebhookAbateur") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, phone_number FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
	local firstname = result[1].firstname
	local lastname  = result[1].lastname
	local phone = result[1].phone_number

    SendToDiscordToAbateur("Demande pôle emplois","Demande reçue de: **__"..firstname.." "..lastname.. "__.** Tél: **__"..phone.."__**:\n\n"..msg, 16744192)
end)

RegisterServerEvent('JobListing:setJobMineur')
AddEventHandler('JobListing:setJobMineur', function(token, job)
    if not CheckToken(token, source, "JobListing:setJobMineur") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("miner", 0)
end)

RegisterServerEvent('JobListing:setJobBûcheron')
AddEventHandler('JobListing:setJobBûcheron', function(token, job)
    if not CheckToken(token, source, "JobListing:setJobBûcheron") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("lumberjack", 0)
end)

RegisterServerEvent('JobListing:setJobbrinks')
AddEventHandler('JobListing:setJobbrinks', function(token, job)
    if not CheckToken(token, source, "JobListing:setJobbrinks") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("brinks", 0)
end)

RegisterServerEvent('JobListing:setJobCouturier')
AddEventHandler('JobListing:setJobCouturier', function(token, job)
    if not CheckToken(token, source, "JobListing:setJobCouturier") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("tailor", 0)
end)

RegisterServerEvent('JobListing:setJobtrucker')
AddEventHandler('JobListing:setJobtrucker', function(token, job)
    if not CheckToken(token, source, "JobListing:setJobtrucker") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("trucker", 0)
end)

RegisterServerEvent('JobListing:setJobMenuisier')
AddEventHandler('JobListing:setJobMenuisier', function(token, job)
    if not CheckToken(token, source, "JobListing:setJobMenuisier") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("Menuisier", 0)
end)

RegisterServerEvent('JobListing:setJobChômeur')
AddEventHandler('JobListing:setJobChômeur', function(token, job)
    if not CheckToken(token, source, "JobListing:setJobChômeur") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.setJob("unemployed", 0)
end)

RegisterServerEvent('Extasy:payJobsFarm')
AddEventHandler('Extasy:payJobsFarm', function(token, money)
    if not CheckToken(token, source, "Extasy:payJobsFarm") then return end

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addMoney(money)
end)