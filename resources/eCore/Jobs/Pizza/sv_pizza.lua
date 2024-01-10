ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('Society:registerSociety', 'pizza', 'pizza', 'society_pizza', 'society_pizza', 'society_pizza', {type = 'private'})

RegisterServerEvent('Pizza:takeStockItem')
AddEventHandler('Pizza:takeStockItem', function(token, itemName, count, societe)
	if not CheckToken(token, source, "Pizza:takeStockItem") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('eAddoninventory:getSharedInventory', 'society_pizza', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- is there enough in the society?
        if count > 0 and inventoryItem.count >= count then

            inventory.removeItem(itemName, count)
            xPlayer.addInventoryItem(itemName, count)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Pizza", "Coffre", "Vous venez de retirer ~g~x"..count.." "..inventoryItem.label, "CHAR_PIZZA")
        else
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Pizza", "Coffre", "~r~Quantité invalide", "CHAR_PIZZA")
        end
    end)
end)

RegisterNetEvent('Pizza:DepositStockItem')
AddEventHandler('Pizza:DepositStockItem', function(token, itemName, count, societe)
	if not CheckToken(token, source, "Pizza:DepositStockItem") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('eAddoninventory:getSharedInventory', 'society_pizza', function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- does the player have enough of the item?
        if sourceItem.count >= count and count > 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Pizza", "Coffre", "Vous venez de déposer ~g~x"..count.." "..inventoryItem.label, "CHAR_PIZZA")
        else
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Pizza", "Coffre", "~r~Quantité invalide", "CHAR_PIZZA")
        end
    end)
end)

ESX.RegisterServerCallback('Pizza:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
end)

ESX.RegisterServerCallback('Pizza:getSharedInventory', function(source, cb, societe)
    TriggerEvent('eAddoninventory:getSharedInventory', 'society_pizza', function(inventory)
        cb(inventory.items)
    end)
end)

RegisterNetEvent('PizzaCraft:playerHasItemsMargarita')
AddEventHandler('PizzaCraft:playerHasItemsMargarita', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local pate = xPlayer.getInventoryItem('pate').count
    local sauce = xPlayer.getInventoryItem('saucetomate').count
    local mozzarella = xPlayer.getInventoryItem('mozzarella').count
    local margarita = xPlayer.getInventoryItem('margarita').count

    if margarita > 50 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Tu as atteint la limite !", "CHAR_PIZZA")
    elseif pate == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de pâte pour cuisiner !", "CHAR_PIZZA")
    elseif sauce == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de sauce pour cuisiner !", "CHAR_PIZZA")
    elseif mozzarella == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de mozzarella pour cuisiner !", "CHAR_PIZZA")
    else
        TriggerClientEvent('PizzaCraft:startCookingMargarita', source)
    end
end)

RegisterNetEvent('PizzaCraft:finishCookingMargarita')
AddEventHandler('PizzaCraft:finishCookingMargarita', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeInventoryItem('pate', 1)
    xPlayer.removeInventoryItem('saucetomate', 1)
    xPlayer.removeInventoryItem('mozzarella', 1)
    xPlayer.addInventoryItem('margarita', 1)   

end)

RegisterNetEvent('PizzaCraft:playerHasItemsPepperoni')
AddEventHandler('PizzaCraft:playerHasItemsPepperoni', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local pate = xPlayer.getInventoryItem('pate').count
    local sauce = xPlayer.getInventoryItem('saucetomate').count
    local mozzarella = xPlayer.getInventoryItem('mozzarella').count
    local pepperoni = xPlayer.getInventoryItem('pepperoni').count
    local pizzapepperoni = xPlayer.getInventoryItem('pizzapepperoni').count

    if pizzapepperoni > 50 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Tu as atteint la limite !", "CHAR_PIZZA")
    elseif pate == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de pâte pour cuisiner !", "CHAR_PIZZA")
    elseif sauce == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de sauce pour cuisiner !", "CHAR_PIZZA")
    elseif mozzarella == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de mozzarella pour cuisiner !", "CHAR_PIZZA")
    elseif pepperoni == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de pepperoni pour cuisiner !", "CHAR_PIZZA")
    else
        TriggerClientEvent('PizzaCraft:startCookingPepperoni', source)
    end
end)

RegisterNetEvent('PizzaCraft:finishCookingPepperoni')
AddEventHandler('PizzaCraft:finishCookingPepperoni', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeInventoryItem('pate', 1)
    xPlayer.removeInventoryItem('saucetomate', 1)
    xPlayer.removeInventoryItem('mozzarella', 1)
    xPlayer.removeInventoryItem('pepperoni', 1)
    xPlayer.addInventoryItem('pizzapepperoni', 1)   

end)

RegisterNetEvent('PizzaCraft:playerHasItemsJambon')
AddEventHandler('PizzaCraft:playerHasItemsJambon', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local pate = xPlayer.getInventoryItem('pate').count
    local sauce = xPlayer.getInventoryItem('saucetomate').count
    local mozzarella = xPlayer.getInventoryItem('mozzarella').count
    local jambon = xPlayer.getInventoryItem('jambon').count
    local champignon = xPlayer.getInventoryItem('champignon').count
    local pizzajambonchampignon = xPlayer.getInventoryItem('pizzajambonchampignon').count

    if pizzajambonchampignon > 50 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Tu as atteint la limite !", "CHAR_PIZZA")
    elseif pate == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de pâte pour cuisiner !", "CHAR_PIZZA")
    elseif sauce == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de sauce pour cuisiner !", "CHAR_PIZZA")
    elseif mozzarella == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de mozzarella pour cuisiner !", "CHAR_PIZZA")
    elseif jambon == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de jambon pour cuisiner !", "CHAR_PIZZA")
    elseif champignon == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de champignon pour cuisiner !", "CHAR_PIZZA")
    else
        TriggerClientEvent('PizzaCraft:startCookingJambon', source)
    end
end)

RegisterNetEvent('PizzaCraft:finishCookingJambon')
AddEventHandler('PizzaCraft:finishCookingJambon', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeInventoryItem('pate', 1)
    xPlayer.removeInventoryItem('saucetomate', 1)
    xPlayer.removeInventoryItem('mozzarella', 1)
    xPlayer.removeInventoryItem('jambon', 1)
    xPlayer.removeInventoryItem('champignon', 1)
    xPlayer.addInventoryItem('pizzajambonchampignon', 1)   

end)

RegisterNetEvent('PizzaCraft:playerHasItemsCalzone')
AddEventHandler('PizzaCraft:playerHasItemsCalzone', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local pate = xPlayer.getInventoryItem('pate').count
    local sauce = xPlayer.getInventoryItem('saucetomate').count
    local mozzarella = xPlayer.getInventoryItem('mozzarella').count
    local calzone = xPlayer.getInventoryItem('calzone').count

    if calzone > 50 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Tu as atteint la limite !", "CHAR_PIZZA")
    elseif pate == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de pâte pour cuisiner !", "CHAR_PIZZA")
    elseif sauce == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de sauce pour cuisiner !", "CHAR_PIZZA")
    elseif mozzarella == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de mozzarella pour cuisiner !", "CHAR_PIZZA")
    else
        TriggerClientEvent('PizzaCraft:startCookingCalzone', source)
    end
end)

RegisterNetEvent('PizzaCraft:finishCookingCalzone')
AddEventHandler('PizzaCraft:finishCookingCalzone', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeInventoryItem('pate', 1)
    xPlayer.removeInventoryItem('saucetomate', 1)
    xPlayer.removeInventoryItem('mozzarella', 1)
    xPlayer.addInventoryItem('calzone', 1)   

end)

RegisterNetEvent('PizzaCraft:playerHasItemsMozzarella')
AddEventHandler('PizzaCraft:playerHasItemsMozzarella', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local mozzarella = xPlayer.getInventoryItem('mozzarella').count
    local mozzarellasticks = xPlayer.getInventoryItem('mozzarellasticks').count

    if mozzarellasticks > 50 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Tu as atteint la limite !", "CHAR_PIZZA")
    elseif mozzarella == 0 then
        TriggerClientEvent('Extasy:ShowAdvancedNotification', source, "Pizza", "Cuisine", "~r~Pas assez de mozzarella pour cuisiner !", "CHAR_PIZZA")
    else
        TriggerClientEvent('PizzaCraft:startCookingMozzarella', source)
    end
end)

RegisterNetEvent('PizzaCraft:finishCookingMozzarella')
AddEventHandler('PizzaCraft:finishCookingMozzarella', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.removeInventoryItem('mozzarella', 1)
    xPlayer.addInventoryItem('mozzarellasticks', 1)   

end)

RegisterServerEvent('pizza:teleportCuisine')
AddEventHandler('pizza:teleportCuisine', function(token, player)
    if not CheckToken(token, source, "pizza:teleportCuisine") then return end

    SetEntityCoords(source, 3663.4338378906, 6293.0395507813, 9.187274932861)
end)

RegisterServerEvent('pizza:teleportMain')
AddEventHandler('pizza:teleportMain', function(token, player)
    if not CheckToken(token, source, "pizza:teleportMain") then return end

    SetEntityCoords(source, 3663.565, 6289.455, 9.08776)
end)


RegisterServerEvent("pizza:itemadd") --Ajout temporaire de l'item "pizza"
AddEventHandler("pizza:itemadd", function(nbPizza)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  xPlayer.addInventoryItem('margarita', tonumber(nbPizza))
end)

RegisterServerEvent("pizza:itemrm") --Rm de l'item "pizza"
AddEventHandler("pizza:itemrm", function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)

  xPlayer.removeInventoryItem('margarita', 1)
end)

RegisterServerEvent('pizza:pourboire') --Paie a la livraison d'une pizza + pourboire eventuel
AddEventHandler('pizza:pourboire', function(token, pourboire)
    if not CheckToken(token, source, "pizza:pourboire") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    xPlayer.addMoney(pourboire)
end)

RegisterServerEvent("pizza:deleteAllPizz") --Rm de l'item "pizza"
AddEventHandler("pizza:deleteAllPizz", function()
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
    
  local pizzanbr = xPlayer.getInventoryItem('margarita').count
  
  xPlayer.removeInventoryItem('margarita', pizzanbr)
end)

RegisterServerEvent("pizza:paie") --Paie "bonus" lors de la fin de service
AddEventHandler("pizza:paie", function()
    if not CheckToken(token, source, "pizza:paie") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local flouzefin = math.random(50, 150)

    xPlayer.addMoney(flouzefin)
    TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Pizza", "Livraison", "Voici votre paie : " .. flouzefin .. "$", "CHAR_PIZZA")
end)