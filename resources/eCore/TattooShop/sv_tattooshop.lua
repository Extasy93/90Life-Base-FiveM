ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

--[[RegisterNetEvent("TattooShop:pay")
AddEventHandler("TattooShop:pay", function(price,playerTatoos)
    local _src = source
    local money = exports.rFramework:getAllPlayerMoney(_src)
    
    if money.money >= price then
        exports.rFramework:RemovePlayerMoneyNoToken(_src,price)
        TriggerClientEvent("TattooShop:buyCallback", _src, true)
        performDbUpdate(playerTatoos,_src)

    else
        TriggerClientEvent("TattooShop:buyCallback", _src, false)
    end
end)]]--

RegisterServerEvent('TattooShop:pay')
AddEventHandler('TattooShop:pay', function(token, price, playerTatoos) -- Mettre le save dans la db
    if not CheckToken(token, source, "TattooShop:pay") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        TriggerClientEvent("TattooShop:buyCallback", _source, true)
        performDbUpdate(playerTatoos, _source)
    else
        TriggerClientEvent("TattooShop:buyCallback", _source, false) 
    end
end) 

RegisterServerEvent('TattooShop:payClean')
AddEventHandler('TattooShop:payClean', function(token, price)
    if not CheckToken(token, source, "TattooShop:payClean") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)

        MySQL.Async.execute("UPDATE `users` SET tattoos = @tat WHERE identifier = @identifier",
            {['@identifier'] = xPlayer.identifier,['@tat'] = "[]" },
            function(insertId)
        end)

        TriggerClientEvent("TattooShop:clean", _source, 1)
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Tatouages', '~g~Paiement', 'Paiement de ~g~$' ..price, 'CHAR_ALPHAV', 6)
        
    else
        TriggerClientEvent("TattooShop:clean", _source, 0)
        TriggerClientEvent('Extasy:showNotification', _source, "~o~Attention\n~r~Tu n'a pas assez d'argent")  
    end
end) 

RegisterNetEvent("TattooShop:requestPlayerTatoos")
AddEventHandler("TattooShop:requestPlayerTatoos", function(token)
    if not CheckToken(token, source, "TattooShop:requestPlayerTatoos") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local result = nil
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE identifier = @identifier", {['@identifier']    = xPlayer.identifier}, function(rslt)
        if rslt[1] ~= nil then
            result = rslt[1].tattoos
        else
            result = nil
        end
    end)
    Wait(150)
    TriggerClientEvent("TattooShop:tatoesCallback", _source, result)
end)

function performDbUpdate(playerTatoos,_source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local tattoos = json.encode(playerTatoos)
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE identifier = @identifier", {['@identifier']    = xPlayer.identifier}, function(rslt)
        if rslt[1] ~= nil then
            MySQL.Async.execute("UPDATE `users` SET tattoos = @tat WHERE identifier = @identifier",
            {['@identifier'] = xPlayer.identifier,['@tat'] = tattoos},
            function(insertId)
            end
        )
        else
            MySQL.Async.insert("INSERT INTO users (`identifier`, `tattoos`) VALUES (@identifier, @tat)",
                {['@identifier'] = xPlayer.identifier,['@tat'] = tattoos},
                function(insertId)
                end
            )
        end
    end)
end

function performDbClear(_source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll("SELECT * FROM `users` WHERE identifier = @identifier", {['@identifier']    = xPlayer.identifier}, function(rslt)
        if rslt[1] ~= nil then
            MySQL.Async.execute("DELETE FROM `users` WHERE identifier = @identifier",
            {['@identifier'] = xPlayer.identifier},
            function(insertId)
                
            end
        )
        end
    end)
end



