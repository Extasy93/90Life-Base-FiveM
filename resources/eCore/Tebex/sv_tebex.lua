ESX = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Extasy:getPlayerGrade')
AddEventHandler('Extasy:getPlayerGrade', function(token)
	if not CheckToken(token, source, "Extasy:getPlayerGrade") then return end
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        for _, v in pairs(result) do
			if v.grade ~= nil then
            	grade = v.grade
			end
        end
		TriggerClientEvent("Extasy:sendPlayerGrade", _source, grade)
    end)
end)

RegisterCommand('_givegrade', function(source, args)
    if source == 0 then
		local numtel = args[1]
		if args[1] == nil or args[2] == nil then
			print("SYNTAX ERROR: _givegrade <NumDeTel> <grade>")
		else
			RefreshTebexGrade(numtel, args[2])				
		end				
	else
		print("Vous pouvez faire ceci uniquement depuis la console du serveur")
	end
end)


RegisterCommand('_deletegrade', function(source, args)
    if source == 0 then
		local numtel = args[1]
		if args[1] == nil then
			print("SYNTAX ERROR: _deletegrade <<NumDeTel>")
		else
			RefreshTebexGrade(numtel, "AUCUN")				
		end				
	else
		print("Vous pouvez faire ceci uniquement depuis la console du serveur")
	end
end)

RefreshTebexGrade = function(phone_number, grade)
	MySQL.Async.execute('UPDATE `users` SET `grade` = @grade WHERE phone_number = @phone_number', {
		['@phone_number'] = phone_number,
		['@grade'] = grade
	}, function(rowsChange)
		MySQL.Async.fetchAll("SELECT * FROM users WHERE phone_number = @phone_number", {['@phone_number'] = phone_number}, function(result)
			for _, v in pairs(result) do
				--TriggerClientEvent("Extasy:sendPlayerGrade", result.identifer, grade)
			end
		end)
	end)
end

--give car with a random plate- 1: playerID 2: carModel (3: plate)
RegisterCommand('givecar', function(source, args)
	if args[1] == nil or args[2] == nil then
		TriggerClientEvent('Extasy:showNotification', source, '~r~/givecar <playerID> <carModel> [plate]')
	elseif args[3] ~= nil then
		local playerName = GetPlayerName(args[1])
		local plate = args[3]
		if #args > 3 then
			for i=4, #args do
				plate = plate.." "..args[i]
			end		
		end	
		plate = string.upper(plate)
		TriggerClientEvent('ExtasyTebex:spawnVehiclePlate', source, args[1], args[2], plate, playerName, 'player')		
	else
		local playerName = GetPlayerName(args[1])
		TriggerClientEvent('ExtasyTebex:spawnVehicle', source, args[1], args[2], playerName, 'player')
	end
end, true)

RegisterCommand('_givecar', function(source, args)
    if source == 0 then
		local sourceID = args[1]
		if args[1] == nil or args[2] == nil then
			print("SYNTAX ERROR: _givecar <playerID> <carModel> [plate]")
		elseif args[3] ~= nil then
			local playerName = GetPlayerName(sourceID)
			local plate = args[3]
			if #args > 3 then
				for i=4, #args do
					plate = plate.." "..args[i]
				end		
			end
			plate = string.upper(plate)
			TriggerClientEvent('ExtasyTebex:spawnVehiclePlate', sourceID, args[1], args[2], plate, playerName, 'console')
		else
			local playerName = GetPlayerName(args[1])
			TriggerClientEvent('ExtasyTebex:spawnVehicle', sourceID, args[1], args[2], playerName, 'console')					
		end				
	end
end)

RegisterCommand('delcarplate', function(source, args)
	if args[1] == nil then
		TriggerClientEvent('Extasy:showNotification', source, '~r~/delcarplate <plate>')
	else
		local plate = args[1]
		if #args > 1 then
			for i=2, #args do
				plate = plate.." "..args[i]
			end		
		end
		plate = string.upper(plate)
		
		local result = MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
			['@plate'] = plate
		})
		if result == 1 then
			TriggerClientEvent('Extasy:showNotification', source, 'A supprimé un véhicule avec numéro de plaque ~y~', plate)
		elseif result == 0 then
			TriggerClientEvent('Extasy:showNotification', source, 'Impossible de trouver le véhicule avec plaque ~y~', plate)
		end		
	end	
end, true)

RegisterCommand('_delcarplate', function(source, args)
    if source == 0 then
		if args[1] == nil then	
			print("SYNTAX ERROR: _delcarplate <plate>")
		else
			local plate = args[1]
			if #args > 1 then
				for i=2, #args do
					plate = plate.." "..args[i]
				end		
			end
			plate = string.upper(plate)
			
			local result = MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
				['@plate'] = plate
			})
			if result == 1 then
				print('Deleted car plate: ' ..plate)
			elseif result == 0 then
				print('Can\'t find car with plate is ' ..plate)
			end
		end
	end
end)


--functions--

RegisterServerEvent('ExtasyTebex:setVehicle')
AddEventHandler('ExtasyTebex:setVehicle', function (token, vehicleProps, playerID)
	if not CheckToken(token, source, "ExtasyTebex:setVehicle") then return end
	local _source = playerID
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
	}, function ()
		if true then
			TriggerClientEvent('Extasy:showNotification', _source, 'Vous avez reçu votre véhicule avec pour numéro de plaque ~h~~y~[' ..vehicleProps.plate.. '] !')
			TriggerClientEvent("ExtasyBoutiqueTebexMenu:Notification", -1, "El famoso :~h~~y~ " .. xPlayer.name .. "~s~ vient de soutenir 90's Life ! Merci à toi.")
		end
	end)
end)


RegisterServerEvent('ExtasyTebex:setVehicle2')
AddEventHandler('ExtasyTebex:setVehicle2', function (token, vehicleProps, playerID)
	if not CheckToken(token, source, "ExtasyTebex:setVehicle2") then return end
	local _source = playerID
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
	}, function ()
		if true then
			--TriggerClientEvent('Extasy:showNotification', _source, 'Vous avez reçu votre véhicule avec pour numéro de plaque ~h~~y~[' ..vehicleProps.plate.. '] !')
			--TriggerClientEvent("ExtasyBoutiqueTebexMenu:Notification", -1, "El famoso :~h~~y~ " .. xPlayer.name .. "~s~ vient de soutenir 90's Life ! Merci à toi.")
		end
	end)
end)

RegisterServerEvent('ExtasyTebex:printToConsole')
AddEventHandler('ExtasyTebex:printToConsole', function(token, msg)
	if not CheckToken(token, source, "ExtasyTebex:printToConsole") then return end
	print(msg)
end)

function havePermission(_source)
	local identifier = GetPlayerIdentifier(_source)
	local isAdmin = false
	for _,v in pairs(Tebex.Admins) do
		if v == identifier then
			isAdmin = true
			break
		end
	end
	
	if IsPlayerAceAllowed(_source, "giveownedcar.command") then isAdmin = true end
	
	return isAdmin
end
