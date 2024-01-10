ESX = nil


TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fuel:pay')
AddEventHandler('fuel:pay', function(token, price)
	if not CheckToken(token, source, "fuel:pay") then return end
	local xPlayer = ESX.GetPlayerFromId(source)
	local amount = ESX.Math.Round(price)
	if price > 0 then
		xPlayer.removeMoney(amount)
		xPlayer.addInventoryItem("WEAPON_PETROLCAN", 1)
		TriggerClientEvent("Extasy:ShowNotification", source, "Vous avez reçu ~g~x1 bidon d'essence")
		TriggerEvent("over:creationarmestupeuxpasdeviner", token, source, "WEAPON_PETROLCAN", 4500, "Bidon d'essence à la station")
	end
end)

