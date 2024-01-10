RegisterNetEvent("ServerEmoteRequest")
AddEventHandler("ServerEmoteRequest", function(token, target, emoteanim, emotename)
	if not CheckToken(token, source, "ServerEmoteRequest") then return end
	TriggerClientEvent("ClientEmoteRequestReceive", target, emoteanim, emotename)
end)

RegisterServerEvent("ServerValidEmote") 
AddEventHandler("ServerValidEmote", function(token, target, requestedemote)
	if not CheckToken(token, source, "ServerValidEmote") then return end
	TriggerClientEvent("SyncPlayEmote", source, otheremote, true)
	TriggerClientEvent("SyncPlayEmote", target, requestedemote, false)
end)