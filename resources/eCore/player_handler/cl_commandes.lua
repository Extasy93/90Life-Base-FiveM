
local report_cooldown = false
local register_cooldown = false

--[[RegisterCommand('report', function(source, args, rawCommand)
    if not report_cooldown then
        if string.len(Extasy.TableToString(args)) > 8 then
			TriggerServerEvent("staff:sendReportToStaffs", Extasy.TableToString(args))
            whileReportCooldown()
        else
            Extasy.ShowNotification("~r~Votre report ne contient pas assez d'informations !")
        end
    else
        Extasy.ShowNotification("~r~Veuillez patienter avant de refaire un report")
    end
end)

whileReportCooldown = function()
    report_cooldown, num = true, 0
    Citizen.CreateThread(function()
        while num < 60 do
            num = num + 1
            Citizen.Wait(1000)
        end
        report_cooldown = false
    end)
end--]]

RegisterCommand('giveitem', function(source, args, rawCommand)
	TriggerServerEvent("staff:giveItem", token, args[1], args[2], args[3])
end)

RegisterCommand('banoff', function(source, args, rawCommand)
	local pArgs = table.concat(args, " ")
	TriggerServerEvent("staff:sendBanoffline", token, pArgs)
end)

RegisterCommand('annonce', function(source, args, rawCommand)
	local pArgs = table.concat(args, " ")
	TriggerServerEvent("staff:sendGlobalMessage", token, pArgs)
end)

RegisterCommand('re', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])
			
			TriggerServerEvent("staff:Revive", token, player)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		TriggerServerEvent("staff:Revive", token, source)
	end
end)

RegisterCommand('revive', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			TriggerServerEvent("staff:Revive", token, player)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		TriggerServerEvent("staff:Revive", token, source)
	end
end)

RegisterCommand('heal', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			TriggerServerEvent("staff:Heal", token, player)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		TriggerServerEvent("staff:Heal", token, source)
	end
end)

RegisterCommand('refreshtickets', function(source, args, rawCommand)
	TriggerServerEvent("Staff:RefreshAllWheelTicket", token)
	TriggerServerEvent('Extasy:createPlayer', token)
end)

RegisterCommand('qg', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			TriggerServerEvent("staff:teleportQG", token, player)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)


RegisterCommand('pc', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])
			print(player)

			TriggerServerEvent("staff:teleportPC", token, player)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)

RegisterCommand('pl', function(source, user)
	TriggerServerEvent("staff:GetPlayerNumbers", token, source)
end)

RegisterCommand('kick', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local target = tonumber(args[1])
			local reason = table.concat(args, " ", 2)

			TriggerServerEvent("staff:KickPlayer", token, target, reason)	
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)


RegisterCommand('slay', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local target = tonumber(args[1])
			id = PlayerId()
			
			TriggerServerEvent("staff:SlayPlayer", token, target)
			Extasy.ShowNotification("Vous avez tué ~y~" .. GetPlayerName(GetPlayerFromServerId(target)))
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)


RegisterCommand('freeze', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local target = tonumber(args[1])

			TriggerServerEvent("staff:FreezePlayer", token, target)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)

RegisterCommand('br', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local target = tonumber(args[1])
			TriggerServerEvent("staff:BringPlayer", token, target)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)

RegisterCommand('bring', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local target = tonumber(args[1])
			TriggerServerEvent("staff:BringPlayer", token, target)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)


RegisterCommand('goto', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local target = tonumber(args[1])
			TriggerServerEvent("staff:GotoPlayer", token, target)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)


RegisterCommand('go', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local target = tonumber(args[1])
			TriggerServerEvent("staff:GotoPlayer", token, target)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)

RegisterCommand('boom', function(source, args, rawCommand)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local target = tonumber(args[1])

			TriggerServerEvent("staff:BoomPlayer", token, target)
			Extasy.ShowNotification("Vous avez giflé ~y~" .. GetPlayerName(GetPlayerFromServerId(target)))
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)


RegisterCommand('mortrp', function(source, args, rawCommand, callback)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local target = tonumber(args[1])
			TriggerServerEvent("staff:MortrpPlayer", token, target)
		else
			Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur autre que le vôtre")
		end
	else
		Extasy.ShowNotification("~r~ID Invalide, veuillez définir un ID de joueur valide")
	end
end)

