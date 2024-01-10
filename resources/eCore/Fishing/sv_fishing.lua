ESX = nil


TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
    Wait(0)
  end
end)

ESX.RegisterUsableItem('turtlebait', function(source)
	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "turtle")
		
		xPlayer.removeInventoryItem('turtlebait', 1)
		TriggerClientEvent('fishing:message', _source, "~g~Vous accrochez un appât à tortue sur l'hamecon.")
	else
		TriggerClientEvent('fishing:message', _source, "~r~Vous n'avez pas de canne à pêche.")
	end
end)

ESX.RegisterUsableItem('fishbait', function(source)

	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "fish")
		
		xPlayer.removeInventoryItem('fishbait', 1)
		TriggerClientEvent('fishing:message', _source, "~g~Vous accrochez un appât à l'hamecon.")
		
	else
		TriggerClientEvent('fishing:message', _source, "~r~Vous n'avez pas de canne à pêche.")
	end
	
end)

ESX.RegisterUsableItem('turtle', function(source)
	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('fishing:setbait', _source, "shark")
		
		xPlayer.removeInventoryItem('turtle', 1)
		TriggerClientEvent('fishing:message', _source, "~g~Vous accrochez un appât sanglant à l'hamecon.")
	else
		TriggerClientEvent('fishing:message', _source, "~r~Vous n'avez pas de canne à pêche.")
	end
end)

ESX.RegisterUsableItem('fishingrod', function(source)
	local _source = source
	TriggerClientEvent('fishing:fishstart', _source)
end)


				
RegisterNetEvent('fishing:catch')
AddEventHandler('fishing:catch', function(token, bait)
	if not CheckToken(token, source, "fishing:catch") then return end	
	_source = source
	local weight = 2
	local rnd = math.random(1,100)
	xPlayer = ESX.GetPlayerFromId(_source)
	if bait == "turtle" then
		if rnd >= 3 then
			if rnd >= 94 then
				TriggerClientEvent('fishing:setbait', _source, "none")
				TriggerClientEvent('fishing:message', _source, "~r~Il était immense! Votre canne à pêche n'a pas supporté la pression.")
				TriggerClientEvent('fishing:break', _source)
				xPlayer.removeInventoryItem('fishingrod', 1)
			else
				TriggerClientEvent('fishing:setbait', _source, "none")
				if xPlayer.getInventoryItem('turtle').count > 4 then
					TriggerClientEvent('fishing:message', _source, "~r~Vous avez trop de tortues.")
				else
					TriggerClientEvent('fishing:message', _source, "~g~Vous avez pêché une tortue.\n~r~C'est une espèce en voie de disparition, il est illégal d'en posséder.")
					xPlayer.addInventoryItem('turtle', 1)
				end
			end
		else
			if rnd >= 75 then
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~Vous avez trop de poissons.")
				else
					weight = math.random(4,9)
					TriggerClientEvent('fishing:message', _source, "~g~Vous avez pêché un poissons: ~y~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
				
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~Vous avez trop de poissons.")
				else
					weight = math.random(2,6)
					TriggerClientEvent('fishing:message', _source, "~g~Vous avez pêché un lieu: ~y~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
			end
		end
	else
		if bait == "fish" then
			if rnd >= 75 then
				TriggerClientEvent('fishing:setbait', _source, "none")
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~Vous avez trop de poissons.")
				else
					weight = math.random(4,11)
					TriggerClientEvent('fishing:message', _source, "~g~Vous avez pêché un thon: ~y~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
				
			else
				if xPlayer.getInventoryItem('fish').count > 100 then
					TriggerClientEvent('fishing:message', _source, "~r~Vous avez trop de poissons.")
				else
					weight = math.random(1,6)
					TriggerClientEvent('fishing:message', _source, "~g~Vous avez pêché un poisson de : ~y~~h~" .. weight .. "kg")
					xPlayer.addInventoryItem('fish', weight)
				end
			end
		end
		if bait == "none" then
			
			if rnd >= 70 then
			TriggerClientEvent('fishing:message', _source, "~y~Vous pêchez sans appât !")
				if  xPlayer.getInventoryItem('fish').count > 100 then
						TriggerClientEvent('fishing:message', _source, "~r~Vous avez trop de poissons.")
					else
						weight = math.random(2,4)
						TriggerClientEvent('fishing:message', _source, "~g~Vous avez pêché un bar: ~y~~h~" .. weight .. "kg")
						xPlayer.addInventoryItem('fish', weight)
					end
				else
					TriggerClientEvent('fishing:message', _source, "~y~Vous pêchez sans appât !")
					if xPlayer.getInventoryItem('fish').count > 100 then
						TriggerClientEvent('fishing:message', _source, "~r~Vous avez trop de poissons.")
					else
						weight = math.random(1,2)
						TriggerClientEvent('fishing:message', _source, "~g~Vous avez pêché un bar: ~y~~h~" .. weight .. "kg")
						xPlayer.addInventoryItem('fish', weight)
					end
				end
		end
		if bait == "shark" then
			if rnd >= 2 then
				if rnd >= 91 then
					TriggerClientEvent('fishing:setbait', _source, "none")
					TriggerClientEvent('fishing:message', _source, "~r~Il était immense! Votre canne à pêche n'a pas supporté la pression.")
					TriggerClientEvent('fishing:break', _source)
					xPlayer.removeInventoryItem('fishingrod', 1)
				else
					if xPlayer.getInventoryItem('shark').count > 100  then
						TriggerClientEvent('fishing:setbait', _source, "none")
						TriggerClientEvent('fishing:message', _source, "~r~Vous avez déjà un requin.")
					else
						TriggerClientEvent('fishing:message', _source, "~g~Vous avez pêché un requin!\n~r~C'est une espèce en voie de disparition, il est illégal d'en posséder.")
						TriggerClientEvent('fishing:spawnPed', _source)
						xPlayer.addInventoryItem('shark', 1)
					end
				end	
					else
						if xPlayer.getInventoryItem('fish').count > 100 then
							TriggerClientEvent('fishing:message', _source, "~r~Vous avez trop de poissons.")
						else
							weight = math.random(4,8)
							TriggerClientEvent('fishing:message', _source, "~g~Vous avez pêché des crevettes: ~y~~h~" .. weight .. "kg")
							xPlayer.addInventoryItem('fish', weight)
						end
					end
				end
			end
end)

RegisterServerEvent("fishing:lowmoney")
AddEventHandler("fishing:lowmoney", function(token, money)
	if not CheckToken(token, source, "fishing:lowmoney") then return end	

    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(money)
end)

RegisterServerEvent('fishing:startSelling')
AddEventHandler('fishing:startSelling', function(token, item)
	if not CheckToken(token, source, "fishing:startSelling") then return end

	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	if item == "fish" then
		local FishQuantity = xPlayer.getInventoryItem('fish').count
			if FishQuantity <= 4 then
			TriggerClientEvent('Extasy:ShowNotification', source, '~r~Vous n\'avez pas assez de poisson')			
		else   
			xPlayer.removeInventoryItem('fish', 5)
			local payment = sv_core_cfg["resell_fish"] 
			xPlayer.addMoney(payment)
			TriggerClientEvent('fishing:message', _source, "~g~Vous avez vendu 5kg de poisson: ~y~~h~" .. payment .. "$")	
		end
	elseif item == "turtle" then
		local FishQuantity = xPlayer.getInventoryItem('turtle').count

		if FishQuantity <= 0 then
			TriggerClientEvent('Extasy:ShowNotification', source, '~r~Vous n\'avez pas de tortue')			
		else   
			xPlayer.removeInventoryItem('turtle', 1)
			local payment = sv_core_cfg["resell_turtle"]
			xPlayer.addAccountMoney('black_money', payment)
			TriggerClientEvent('fishing:message', _source, "~r~Vous avez vendu votre tortue: ~s~~h~" .. payment .. "$")
			
		end
	elseif item == "shark" then
		local FishQuantity = xPlayer.getInventoryItem('shark').count

		if FishQuantity <= 0 then
			TriggerClientEvent('Extasy:ShowNotification', source, '~r~Vous n\'avez pas de requin')			
		else   
			xPlayer.removeInventoryItem('shark', 1)
			local payment = sv_core_cfg["resell_shark"]
			xPlayer.addAccountMoney('black_money', payment)
			TriggerClientEvent('fishing:message', _source, "~r~Vous avez vendu votre requin: ~s~~h~" .. payment .. "$")
			
		end
	end
end)