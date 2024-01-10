ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("drivingschool:pay")
AddEventHandler("drivingschool:pay", function(token, price, index, method, value, k, item, label, name)
    if not CheckToken(token, source, "drivingschool:pay") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if index == 1 then
        if xPlayer.getBank() >= price then
            xPlayer.removeAccountMoney('bank', price)
            TriggerClientEvent("drivingschool:payResult", xPlayer.source, price, method, value, k, item, label, name)
			TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "Vous avez payé votre examen ~r~"..price.."$")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
        end
    elseif index == 2 then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            TriggerClientEvent("drivingschool:payResult", xPlayer.source, price, method, value, k, item, label, name)
			TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "Vous avez payé votre examen ~r~"..price.."$")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
        end
    elseif index == 3 then
        if xPlayer.getAccount('black_money').money >= price then
            xPlayer.removeAccountMoney('black_money', tonumber(price))
            TriggerClientEvent("drivingschool:payResult", xPlayer.source, price, method, value, k, item, label, name)
			TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "Vous avez payé votre examen ~r~"..price.."$")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent de source inconnue")
        end
    end
end)

RegisterServerEvent('drivingschool:finish')
AddEventHandler('drivingschool:finish', function(token, permis)
	if not CheckToken(token, source, "drivingschool:finish") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addInventoryItem(permis, 1)
	TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "Vous avez reçu ~g~x1 "..permis)
end)