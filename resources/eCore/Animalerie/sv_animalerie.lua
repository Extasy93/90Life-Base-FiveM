ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Extasy:getPet', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT pet FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].pet ~= nil then
			cb(result[1].pet)
		else
			cb('')
		end
	end)
end)

ESX.RegisterServerCallback('Extasy:getPetName', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT petName FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if result[1].petName ~= nil then
			cb(result[1].petName)
		else
			cb('')
		end
	end)
end)

RegisterServerEvent('Extasy:petDied')
AddEventHandler('Extasy:petDied', function(token)
	if not CheckToken(token, source, "Extasy:petDied") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('UPDATE users SET pet = "(NULL)" WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
end)

RegisterServerEvent('Extasy:consumePetFood')
AddEventHandler('Extasy:consumePetFood', function(token)
	if not CheckToken(token, source, "Extasy:consumePetFood") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('croquettes', 1)
end)

ESX.RegisterServerCallback('Extasy:buyPet', function(source, cb, pet)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = GetPriceFromPet(pet)

	if price == 0 then
		print(('Extasy: %s attempted to buy an invalid pet!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= price then
		xPlayer.removeMoney(price)

		MySQL.Async.execute('UPDATE users SET pet = @pet WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@pet'] = pet
		}, function(rowsChanged)
			TriggerClientEvent('Extasy:showNotification', xPlayer.source, 'Tu as acheté un(e) ~p~' ..pet..' ~w~pour~r~ ' ..ESX.Math.GroupDigits(price)..'$')
			cb(true)
		end)
	else
		TriggerClientEvent('Extasy:showNotification', source, "~r~Vous n'avez pas assez d'argent sur vous")
		cb(false)
	end
end)

RegisterServerEvent('Extasy:ChangePetName')
AddEventHandler('Extasy:ChangePetName', function(token, petname)
	if not CheckToken(token, source, "Extasy:ChangePetName") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('UPDATE users SET PetName = @petname WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
		['@petname'] = petname
	}, function()
	end)
end)

function GetPriceFromPet(pet)
	for i=1, #cfg_animalerie.pets, 1 do
		if cfg_animalerie.pets[i].pet == pet then
			return cfg_animalerie.pets[i].price
		end
	end

	return 0
end