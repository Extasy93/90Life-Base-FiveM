local cachedData = {}

RegisterServerEvent("bankrobberies:globalEvent")
AddEventHandler("bankrobberies:globalEvent", function(options)
    print("bankrobberies:globalEvent server")
	if type(options["data"]) == "table" then
		if options["data"]["save"] then
			cachedData[options["data"]] = {["started"] = os.time(), ["robber"] = source, ["trolleys"] = options["data"]["trolleys"]}
		end
	end

    TriggerClientEvent("bankrobberies:eventHandler", -1, options["event"] or "none", options["data"])
end)

RegisterServerEvent("bankrobberies:takeMoney")
AddEventHandler("bankrobberies:takeMoney", function()
	local player = ESX.GetPlayerFromId(source)

	if player then
		local randomMoney = math.random(cfg_simpleRobberys.trolleys["cash"][1], cfg_simpleRobberys.trolleys["cash"][2])

		if cfg_simpleRobberys.BlackMoney then
		    player.addAccountMoney('black_money', randomMoney)
		    TriggerClientEvent("Extasy:showTimeoutNotification", source, "Tu a pris~r~ " .. randomMoney .. " ~w~$ d'argent", 490)
		else
		    player.addMoney(randomMoney)
		    TriggerClientEvent("Extasy:showTimeoutNotification", source, "Tu a pris~r~ " .. randomMoney .. " ~w~$ d'argent", 490)
		end
	end
end)
