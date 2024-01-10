local maxQuantity = 120 -- Quantité maximum d'action en prison

RegisterCommand('prison', function(source, args)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playergroup = xPlayer.getGroup()

    if not args[1] or not args[2] then
		TriggerClientEvent("Extasy:notify", source, "~r~Erreur :~w~\nLa bonne commande est /prison [JoueurID] [Nombre d'action en prison]", 3000)
	else
		local otherPlayerID = tonumber(args[1])
		local quantity = tonumber(args[2])
		if quantity > maxQuantity then quantity = maxQuantity end

		TriggerClientEvent("Extasy:setInprison", otherPlayerID, quantity)
		TriggerClientEvent("Extasy:notify", source, "~g~Fait :~w~\n" .. GetPlayerName(otherPlayerID) .. " a été envoyé en prison", 3000)
		sendWebhookPrison(_source, otherPlayerID, 1)
	end
end, false)

RegisterCommand('jail', function(source, args)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local playergroup = xPlayer.getGroup()
	if not args[1] or not args[2] then
		TriggerClientEvent("Extasy:notify", source, "~r~Erreur :~w~\nLa bonne commande est /prison [JoueurID] [Nombre d'action en prison]", 3000)
	else
		local otherPlayerID = tonumber(args[1])
		local quantity = tonumber(args[2])
		if quantity > maxQuantity then quantity = maxQuantity end

		TriggerClientEvent("Extasy:setInprison", otherPlayerID, quantity)
		TriggerClientEvent("Extasy:notify", source, "~g~Fait :~w~\n" .. GetPlayerName(otherPlayerID) .. " a été envoyé en prison", 3000)
		sendWebhookPrison(_source, otherPlayerID, 1)
	end
end, false)

RegisterCommand('unjail', function(source, args)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local otherPlayerID = tonumber(args[1])
	local playergroup = xPlayer.getGroup()
	TriggerClientEvent("Extasy:SortieDePrison", otherPlayerID)
	TriggerClientEvent("Extasy:notify", source, "~g~Fait :~w~\n" .. GetPlayerName(otherPlayerID) .. " est sortie de prison", 4000)
end, false)

-- log

sendWebhookPrison = function(source, otherPlayerID, _source, prisoner)
	local msgPrison = ""
	if prisoner then
		msgPrison = "**Le staff avec l'ID : [".._source.."] - ** a mis en prison l'ID: ***" ..otherPlayerID.. " ***."
	else
		msgPrison = "**Le staff avec l'ID : [".._source.."] - ** a mis en prison l'ID: ***" ..otherPlayerID.. " ***."
	end

	local discordInfo = {
        ["color"] = "15158332",
        ["type"] = "rich",
        ["title"] = "Log de prison",
        ["description"] = msgPrison,
        ["footer"] = {
        ["text"] = 'Discord Bot By Extasy#0093'
        }
    }

	PerformHttpRequest(extasy_sv_core_cfg["webhook_jail"], function(err, text, headers) end, 'POST', json.encode({ username = '90Life-Logs', embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end