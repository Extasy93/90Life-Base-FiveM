ESX = nil
vehiculeTable = {}
OwnerInfoTable = {}
local check = false

TriggerEvent("ext:getSharedObject", function(obj)
    ESX = obj
    Wait(5000)
    --MySQL.Async.fetchAll("SELECT * FROM owned_vehicles", {}, function(result)
        --for k,v in pairs(result) do
         ---vehiculeTable = {owner = v.owner, state = v.state, plate = v.plate, vehicle = v.vehicle, stored = v.stored, vehiculeTable.vehicleName, type = v.type}
        --end
    --end)
end)

RegisterServerEvent("garage:sendAllVehiclesFromPlayer")
AddEventHandler("garage:sendAllVehiclesFromPlayer", function(token)
	if not CheckToken(token, source, "garage:sendAllVehiclesFromPlayer") then return end
    local _source = source
	local FinalResult = {}
    local player
	
	for k,v in ipairs(GetPlayerIdentifiers(_source)) do
		if string.match(v, 'license:') then
			player = v
		end
	end

    while player == nil do Wait(1) end

	TriggerClientEvent("garage:recevePlayerUUID", _source, player)

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier',
      {
        ['@identifier'] = player
      },
      function(result)
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE isShared = @isShared',
		{
			['@isShared'] = player
		},
		function(result)
			for _,v in pairs(result) do
				jsonCar = json.decode(v.vehicle)
				table.insert(FinalResult, {
					owner = v.owner,
					state = v.state,
					plate = v.plate,
					isBuyed = v.isBuyed,
					vehicle = jsonCar,
					vehicleName = v.vehicleName,
					type = v.type,
					isShared = v.isShared 
				})
				TriggerClientEvent("garage:sendGarageInfo", _source, FinalResult)
			end

			for _,v in pairs(result) do
				result.vehicle = json.decode(v.vehicle)
				local plate = v.plate
				local vehicleName = v.vehicleName
				local type = v.type

				TriggerClientEvent("garage:sendAddToCache", plate, Vehicle, vehicleName, type)
			end
		end)

		for _,v in pairs(result) do
			jsonCar = json.decode(v.vehicle)
            table.insert(FinalResult, {
                owner = v.owner,
                state = v.state,
                plate = v.plate,
				isBuyed = v.isBuyed,
				vehicle = jsonCar,
				vehicleName = v.vehicleName,
				type = v.type,
				isShared = v.isShared 
            })
			TriggerClientEvent("garage:sendGarageInfo", _source, FinalResult)
        end

		for _,v in pairs(result) do
			result.vehicle = json.decode(v.vehicle)
			local plate = v.plate
			local vehicleName = v.vehicleName
			local type = v.type

			TriggerClientEvent("garage:sendAddToCache", plate, Vehicle, vehicleName, type)
		end
    end)
end)

RegisterNetEvent("garage:checkOwnerForThisPlate")
AddEventHandler("garage:checkOwnerForThisPlate", function(token, plate)
	if not CheckToken(token, source, "ggarage:checkOwnerForThisPlate") then return end
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then
			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				TriggerClientEvent("Extasy:ShowNotification", _source, "La plaque appartient à ~b~"..result2[1].firstname.." "..result2[1].lastname.."")
			end)
		else
			TriggerClientEvent("Extasy:ShowNotification", _source, "~r~Ce véhicule n'a pas de propriétaire")
		end
	end)
end)

RegisterNetEvent("garage:addToGarageCache")
AddEventHandler("garage:addToGarageCache", function(token)
	if not CheckToken(token, source, "garage:addToGarageCache") then return end
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll(
      'SELECT * FROM owned_vehicles WHERE owner = @identifier',
      {
        ['@identifier'] = xPlayer.identifier,
		['@identifier2'] = xPlayer.identifier
      },
      function(result)
		TriggerClientEvent("garage:sendGarageInfo", _source, result)
      end
    )
end)

RegisterNetEvent("garage:notSharingThisPlateAnymore")
AddEventHandler("garage:notSharingThisPlateAnymore", function(token, plate)
	if not CheckToken(token, source, "garage:notSharingThisPlateAnymore") then return end
    MySQL.Async.execute('UPDATE owned_vehicles SET isShared = @isShared WHERE plate = @plate', {
		['@isShared'] = 'no',
		['@plate'] = plate
	}, function()
	end)
end)

RegisterNetEvent("garage:changeOwnerForThisPlate")
AddEventHandler("garage:changeOwnerForThisPlate", function(token, plate, NewOwner)
	if not CheckToken(token, source, "garage:changeOwnerForThisPlate") then return end
    local _source = NewOwner
    local xPlayer  = ESX.GetPlayerFromId(_source)

    MySQL.Async.execute('UPDATE owned_vehicles SET owner = @owner WHERE plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function()
	end)
end)

RegisterNetEvent("garage:changeName")
AddEventHandler("garage:changeName", function(token, plate, NewName)
	if not CheckToken(token, source, "garage:changeName") then return end
    MySQL.Async.execute('UPDATE owned_vehicles SET vehicleName = @vehicleName WHERE plate = @plate', {
		['@vehicleName'] = NewName,
		['@plate'] = plate
	}, function()
	end)
end)

RegisterNetEvent("garage:delete")
AddEventHandler("garage:delete", function(token, plate)
	if not CheckToken(token, source, "garage:delete") then return end
    MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function()
	end)
end)

RegisterNetEvent("garage:addNewCoOwnerToThisPlate")
AddEventHandler("garage:addNewCoOwnerToThisPlate", function(token, plate, isShared)
	if not CheckToken(token, source, "garage:addNewCoOwnerToThisPlate") then return end
	local _source = isShared
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('Extasy:showNotification', _source, 'Un véhicule vient de vous être partagé')
	MySQL.Async.execute('UPDATE owned_vehicles SET isShared = @isShared WHERE plate = @plate', {
		['@isShared'] = xPlayer.identifier,
		['@plate'] = plate
	}, function()
	end)
end)

ESX.RegisterServerCallback('garage:saveProps', function(source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate
				}, function (rowsChanged)
					if rowsChanged == 0 then
					end
					cb(true)
				end)
			else
				DropPlayer(source, 'You have been Kicked from the Server by Extasy for Possible Garage Cheating !')
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('garage:savePropsShare', function(source, cb, vehicleProps)
	local ownedCars = {}
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE isShared = @isShared AND @plate = plate', {
		['@isShared'] = xPlayer.identifier,
		['@plate'] = vehicleProps.plate
	}, function (result)
		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate
				}, function (rowsChanged)
					if rowsChanged == 0 then
					end
					cb(true)
				end)
			else
				DropPlayer(source, 'You have been Kicked from the Server by Extasy for Possible Garage Cheating !')
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('Extasy:PayImpound', function(source, cb, price)
	local _source = source
  	local xPlayer  = ESX.GetPlayerFromId(source)
	
	if xPlayer.getMoney() >= price then
    	xPlayer.removeMoney(price)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('garage:payhealthExtasy')
AddEventHandler('garage:payhealthExtasy', function(token, price)
	if not CheckToken(token, source, "garage:payhealthExtasy") then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(price)
	TriggerClientEvent('Extasy:showNotification', source, 'Vous venez de payer $' .. price)
end)

RegisterServerEvent('garage:setVehicleState')
AddEventHandler('garage:setVehicleState', function(token, plate, state)
	if not CheckToken(token, source, "garage:setVehicleState") then return end
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `state` = @state WHERE plate = @plate', {
		['@state'] = state,
		['@plate'] = plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
		end
	end)
end)
