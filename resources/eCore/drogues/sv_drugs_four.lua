ESX = nil

TriggerEvent('ext:getSharedObject', function(obj)
    ESX = obj
end)

local peuvendre = false

RegisterCommand('four', function(source, args, rawcommand)
    TriggerClientEvent('Extasy:ouverturefourC', source)
end, false)

RegisterServerEvent('Extasy:ouverturefour')
AddEventHandler('Extasy:ouverturefour', function(token)
	if not CheckToken(token, source, "Extasy:ouverturefour") then return end	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	peuvendre = true
	
	if peuvendre then
		local copsOnDuty = 0
		local Players = ESX.GetPlayers()

		if xPlayer.getInventoryItem("pochon_de_coke").count > 0 then
			TriggerClientEvent("Extasy:getcustomer", _source)
			waitingForClient = 1
		elseif xPlayer.getInventoryItem("pochon_de_weed").count > 0 then
			TriggerClientEvent("Extasy:getcustomer", _source)
			waitingForClient = 1
		elseif xPlayer.getInventoryItem("pochon_de_meth").count > 0 then
			TriggerClientEvent("Extasy:getcustomer", _source)
			waitingForClient = 1
		else
			TriggerClientEvent('Extasy:ShowNotification', _source, "~o~[Yencli]:~s~ T'as rien à vendre, je me casse d'ici !")
			TriggerClientEvent('Extasy:venteok', _source)
		end
	end
end)

RegisterServerEvent('Extasy:clientpassed')
AddEventHandler('Extasy:clientpassed', function(token, source) -- Ajout de source
	if not CheckToken(token, source, "Extasy:clientpassed") then return end	
	TriggerClientEvent('Extasy:venteok', _source)
end)

RegisterServerEvent('Extasy:udanyzakup')
AddEventHandler('Extasy:udanyzakup', function(token, x, y, z)
	if not CheckToken(token, source, "Extasy:udanyzakup") then return end	
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if peuvendre then		
		local cheatLuck = math.random(1,100)

		if cheatLuck <= 10 then
			TriggerClientEvent('Extasy:ShowNotification', _source, "~o~[Yencli]:~s~ C'est de la merde ton truc ! Garde le !")
			TriggerClientEvent('Extasy:venteok', _source)
			TriggerClientEvent('Call:fours', _source)
			return
		end

		--sellRate = math.random(1, 3)

		if xPlayer.getInventoryItem("pochon_de_weed").count > 0 then
			
			TriggerClientEvent('Extasy:ShowNotification', _source, "~g~x1 Pochon de weed vendu~s~\n~c~+("..cfg_fours.Pochon_de_weedPrice.."$)~s~ d'argent de source inconnu")
			xPlayer.removeInventoryItem("pochon_de_weed", 1)
			
			if cfg_fours.ArgentSale then
				xPlayer.addAccountMoney('black_money', cfg_fours.Pochon_de_weedPrice)
			else
				xPlayer.addMoney(cfg_fours.Pochon_de_weedPrice)
			end

			TriggerClientEvent('Extasy:venteok', _source)

		elseif xPlayer.getInventoryItem("pochon_de_coke").count > 0 then
		
			TriggerClientEvent('Extasy:ShowNotification', _source, "~g~x1 Pochon de coke vendu~s~\n~c~+("..cfg_fours.Pochon_de_cokePrice.."$)~s~ d'argent de source inconnu")
			xPlayer.removeInventoryItem("pochon_de_coke", 1)
			
			if cfg_fours.ArgentSale then
				xPlayer.addAccountMoney('black_money', cfg_fours.Pochon_de_cokePrice)
			else
				xPlayer.addMoney(cfg_fours.Pochon_de_cokePrice)
			end

			TriggerClientEvent('Extasy:venteok', _source)
			
		elseif xPlayer.getInventoryItem("pochon_de_meth").count > 0 then
		
			TriggerClientEvent('Extasy:ShowNotification', _source, "~g~x1 Pochon de meth vendu~s~\n~c~+("..cfg_fours.Pochon_de_methPrice.."$)~s~ d'argent de source inconnu")
			xPlayer.removeInventoryItem("pochon_de_meth", 1)
			
			if cfg_fours.ArgentSale then
				xPlayer.addAccountMoney('black_money', cfg_fours.Pochon_de_methPrice)
			else
				xPlayer.addMoney(cfg_fours.Pochon_de_methPrice)
			end

			TriggerClientEvent('Extasy:venteok', _source)
		else
			TriggerClientEvent("Extasy:ShowNotification", "~r~Tu n'as plus rien a vendre !")
			TriggerClientEvent('Extasy:venteok', _source)
		end

		local infoPsy = math.random(1,100)

		if infoPsy <= 3 then
			TriggerClientEvent('Call:fours', _source)
			Wait(500)
		end
	end
end)