ESX              = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Extasy:prostituebuy', function (source, cb, price)
	TriggerEvent("ext:AST", source, "Extasy:prostituebuy")
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 50 then
		xPlayer.removeMoney(50)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('Extasy:prostituebuy2', function (source, cb, price)
	TriggerEvent("ext:AST", source, "Extasy:prostituebuy")
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 150 then
		xPlayer.removeMoney(150)
		cb(true)
	else
		cb(false)
	end
end)