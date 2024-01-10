ESX                = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'vccustoms', 'vccustoms', 'society_vccustoms', 'society_vccustoms', 'society_vccustoms', {type = 'private'})

RegisterServerEvent('VcCustoms:fixKit')
AddEventHandler('VcCustoms:fixKit', function(token)
	if not CheckToken(token, source, "VcCustoms:fixKit") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local fixkitQuantity = xPlayer.getInventoryItem('Kit_de_reparation').count

	if fixkitQuantity > 0 then
		TriggerClientEvent('VcCustoms:useKit', source)
	else
		TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez pas de kit de réparation sur vous.")
	end
end)

ESX.RegisterUsableItem('Kit_de_reparation', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Kit_de_reparation', 1)
	TriggerClientEvent('VcCustoms:useKit', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "~g~Vous avez utilisé un kit de réparation.")
end)

--

local Vehicles
local VehiclesInShop = {}

RegisterServerEvent('VcCustoms:refreshOwnedVehicle')
AddEventHandler('VcCustoms:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicleProps.model == vehicle.model then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@vehicle'] = json.encode(vehicleProps)
				})
			else
				print(('VcCustoms: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)

ESX.RegisterServerCallback('VcCustoms:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)

RegisterServerEvent('VcCustoms:checkVehicle')
AddEventHandler('VcCustoms:checkVehicle', function(token, plate)
	
	if not CheckToken(token, source, "VcCustoms:checkVehicle") then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	--print("plate: " .. plate)
	for k, v in pairs(VehiclesInShop) do 
		--print("k: " .. k)
		--print("v['plate']: " .. v['plate'])
		if v.plate == plate and _source ~= k then
			--print("found it")
			TriggerClientEvent('VcCustoms:resetVehicle', source, v)
			VehiclesInShop[xPlayer.identifier] = nil
			break
		end
	end
end)

RegisterServerEvent('VcCustoms:saveVehicle')
AddEventHandler('VcCustoms:saveVehicle', function(token, oldVehProps)
	if not CheckToken(token, source, "VcCustoms:saveVehicle") then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	--print("oldVehProps['plate']: " .. oldVehProps['plate'])
	if oldVehProps then
		VehiclesInShop[xPlayer.identifier] = oldVehProps
		--print("VehiclesInShop[_source][plate]: " .. VehiclesInShop[_source]['plate'])
	end
end)

RegisterServerEvent('VcCustoms:setupBilling')
AddEventHandler('VcCustoms:setupBilling', function(token, reason, price, society, buyer, action, execute, deduce, isForce, vehModsNew, shopCart, shopProfit)
	if not CheckToken(token, source, "VcCustoms:setupBilling") then return end
	TriggerEvent("ext:AST", source, "VcCustoms:setupBilling")

    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    TriggerClientEvent("billing:open", buyer, reason, price, society, source, action, execute, deduce, isForce, vehModsNew, shopCart, shopProfit)
	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à donner une facture de société "..society.." à **["..buyer.."]** "..GetPlayerName(buyer).." de **"..price.."$** avec la raison: "..reason, "facture")
end)


RegisterServerEvent('Extasy_customs:finishPurchase')
AddEventHandler('Extasy_customs:finishPurchase', function(token, society, newVehProps, shopCart, buyer, shopProfit)
	if not CheckToken(token, source, "Extasy_customs:finishPurchase") then return end

	print(society)
	print(newVehProps)
	print(shopCart)
	print(buyer)
	print(shopProfit)

	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(buyer)
	local pid = buyer
	local isFinished = false
	--local price, amount = calcFinalPrice(shopCart, shopProfit)
	local price, amount = 1, 2

	if price <= 0 or amount <= 0 then
		TriggerClientEvent('Extasy_customs:cantBill', source)
		TriggerClientEvent('Extasy_customs:resetVehicle', source, VehiclesInShop[xPlayer.identifier])
		VehiclesInShop[xPlayer.identifier] = nil
		return
	end

	local societyAccount

	TriggerEvent('eAddonaccount:getSharedAccount', "society_"..society, function(account)
		societyAccount = account
	end)

	local targetMoney = xTarget.getAccount('bank')
	if price < societyAccount.money then
		TriggerClientEvent('Extasy_customs:canBill', source, amount, pid)
		TriggerEvent('Extasy_customs:refreshOwnedVehicle', newVehProps)
		isFinished = true
	else
		TriggerClientEvent('Extasy:ShowAdvancedNotification', source, 'Vc Customs', 'Factures', 'Il n\'y a pas assez d\'argent dans l\'entriprise.', 'CHAR_MP_MECHANIC', 9)
		isFinished = false
	end

	if not isFinished then
		TriggerClientEvent('Extasy_customs:cantBill', source)
		TriggerClientEvent('Extasy_customs:resetVehicle', source, VehiclesInShop[xPlayer.identifier])
	end

	if VehiclesInShop[xPlayer.identifier] then VehiclesInShop[xPlayer.identifier] = nil end
end)
