RegisterServerEvent('Shop:BuyItemsByBankMoney')
AddEventHandler('Shop:BuyItemsByBankMoney', function(token, thePrice, theItem, s_index, theLabel)
    if not CheckToken(token, source, "Shop:BuyItemsByBankMoney") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getBank() >= thePrice then
        xPlayer.removeAccountMoney('bank',thePrice)
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~g~Vous avez reçu x"..s_index.." "..theLabel)
        xPlayer.addInventoryItem(theItem, s_index)
    else
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
	end
end)

RegisterServerEvent('Shop:BuyItemsByMoney')
AddEventHandler('Shop:BuyItemsByMoney', function(token, thePrice, theItem, s_index, theLabel)
    if not CheckToken(token, source, "Shop:BuyItemsByMoney") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= thePrice then
        xPlayer.removeMoney(thePrice)
        xPlayer.addInventoryItem(theItem, s_index)
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~g~Vous avez reçu x"..s_index.." "..theLabel)
    else
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
	end
end)

RegisterServerEvent('Shop:BuyItemsByDirtyMoney')
AddEventHandler('Shop:BuyItemsByDirtyMoney', function(token, thePrice, theItem, s_index, theLabel)
    if not CheckToken(token, source, "Shop:BuyItemsByByDirtyMoney") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getAccount('black_money').money >= thePrice then
        xPlayer.removeAccountMoney('black_money', tonumber(thePrice))
        xPlayer.addInventoryItem(theItem, s_index)
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~g~Vous avez reçu x"..s_index.." "..theLabel)
    else
        TriggerClientEvent('Extasy:showNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent de source inconnue sur vous")
	end
end)

ESX.RegisterUsableItem('chips_sel', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('chips_sel', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "Vous avez mangé un packet Chips gout sel")
end)

ESX.RegisterUsableItem('sandwich_p_curry', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sandwich_p_curry', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "Vous avez mangé un Sandwich poulet curry")
end)

ESX.RegisterUsableItem('Donut', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Donut', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "Vous avez mangé un Donut")
end)

ESX.RegisterUsableItem('chips_sel', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('chips_sel', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "Vous avez mangé un packet Chips gout sel")
end)

ESX.RegisterUsableItem('Cafe', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Cafe', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)   
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "Tu as bu du Cafe")
end)

ESX.RegisterUsableItem('Coca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Coca', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)   
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "Tu as bu du Cola")
end)

ESX.RegisterUsableItem('Champagne', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Champagne', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)   
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "Tu as bu du Champagne")
end)

ESX.RegisterUsableItem('Sprunk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Sprunk', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)   
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "Tu as bu du Sprunk")
end)

ESX.RegisterUsableItem('Heineken', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Heineken', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)   
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, "Tu as bu du Heineken")
end)


Shops = {
	[1] = false,
	[2] = false,
	[3] = false,
	[4] = false,
	[5] = false,
	[6] = false,
	[7] = false,
	[8] = false,
	[9] = false,
	[10] = false,
}

RegisterServerEvent('shop_robbery:processPayment')
AddEventHandler('shop_robbery:processPayment', function(token, money, store)
    if not CheckToken(token, source, "shop_robbery:processPayment") then return end
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addAccountMoney('black_money', money)
    TriggerClientEvent('Extasy:ShowNotification', source, "Vous avez volé: ~r~" ..money.. " $")

	Shops[store] = true
	Wait(60*60000)
    Shops[store] = false
end)

ESX.RegisterServerCallback('shops:getCooldownForShop', function(source, cb, store, jCount)
	if not Shops[store] then
		cb(true)
		SendLog("["..source.."] "..GetPlayerName(source).." à lancer un braquage de superette avec "..jCount.." policer.", "superette")
	else
		cb(false)
	end
end)