ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

sanitize = function(string)
    return string:gsub('%@', '')
end

--[[RegisterCommand('twt', function(source, args, rawCommand)
    local src = source
	local msgTWT1 = rawCommand:sub(5)
	local args = msgTWT1
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        local xPlayer = ESX.GetPlayerFromId(source)
        MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier,
        }, function(result)
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Twitter', ''..result[1].firstname.." "..result[1].lastname..'', ''..msgTWT1..'', 'CHAR_STRETCH', 0)
            end
        end)
        msgTWTlog1 = 'Le joueur ['..src..'] a écris dans tweeter : **'..msgTWT1..'.**'
        webhooksTWT = "https://discord.com/api/webhooks/852587090351882240/t4ofpmvpKlcQrkP0YeTJKP7AQr0_5P4d-WJfp2qSloDeKFNJPeE_tmXk7UU0gKtBd570"

        local discordInfoTwt = {
            ["color"] = "15158332",
            ["type"] = "rich",
            ["title"] = "Log Tweeter",
            ["description"] = msgTWTlog1,
            ["footer"] = {
            ["text"] = '90's Life - LOG'
            }
        }

        PerformHttpRequest(webhooksTWT, function(err, text, headers) end, 'POST', json.encode({ username = '90's Life - LOG', embeds = { discordInfoTwt } }), { ['Content-Type'] = 'application/json' })
    end
end, false)--]]

--[[RegisterCommand('ano', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Anonyme', 'Anonyme', ''..msg..'', 'CHAR_ARTHUR', 0)
        end
    end
end, false)

RegisterCommand('anonyme', function(source, args, rawCommand)
    local src = source
	local msg = rawCommand:sub(5)
	local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Anonyme', 'Anonyme', ''..msg..'', 'CHAR_ARTHUR', 0)
        end
    end
end, false)--]]

RegisterCommand('lspd', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "police" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'LSPD', '~b~Annonce LSPD', ''..msg..'', 'CHAR_ABIGAIL', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~policier pour éfféctué cette commande', 'CHAR_ABIGAIL', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~policier pour éfféctué cette commande', 'CHAR_ABIGAIL', 0)
    end
 end, false)

 RegisterCommand('avocat', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "avocat" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Avocat', '~b~Annonce Avocat', ''..msg..'', 'CHAR_SOLOMON', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~Avocat pour éfféctué cette commande', 'CHAR_SOLOMON', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~Avocat pour éfféctué cette commande', 'CHAR_SOLOMON', 0)
    end
 end, false)
 
RegisterCommand('mecano', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "mechanic" then
        local src = source
        local msg = rawCommand:sub(7)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Mécano [SUD]', '~b~Annonce Mécano [SUD]', ''..msg..'', 'CHAR_LS_CUSTOMS', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~mécano pour éfféctué cette commande', 'CHAR_LS_CUSTOMS', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~mécano pour éfféctué cette commande', 'CHAR_LS_CUSTOMS', 0)
    end
 end, false)

RegisterCommand('bennys', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)  

    if xPlayer.job.name == "mechanic" or xPlayer.job.name == "bennys" then
        local src = source
        local msg = rawCommand:sub(7)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Mécano [SUD]', '~b~Annonce Mécano [SUD]', ''..msg..'', 'CHAR_LS_CUSTOMS', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~mécano pour éfféctué cette commande', 'CHAR_LS_CUSTOMS', 0)
    end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~mécano pour éfféctué cette commande', 'CHAR_LS_CUSTOMS', 0)
    end
end, false)

RegisterCommand('NorthMecano', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)  
    
    if xPlayer.job.name == "NorthMecano" then
        local src = source
        local msg = rawCommand:sub(12)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'NorthMécano', '~b~Annonce Mécano [NORD]', ''..msg..'', 'CHAR_LS_CUSTOMS', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~mécano pour éfféctué cette commande', 'CHAR_LS_CUSTOMS', 0)
    end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~un Mécano du [NORD] pour éfféctué cette commande', 'CHAR_LS_CUSTOMS', 0)
    end
end, false)
 
 RegisterCommand('concess', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "cardealer" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'concessionnaire', '~b~Annonce concessionnaire', ''..msg..'', 'CHAR_CARSITE', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~concessionnaire pour éfféctué cette commande', 'CHAR_CARSITE', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~concessionnaire pour éfféctué cette commande', 'CHAR_CARSITE', 0)
    end
 end, false)
 
RegisterCommand('unicorn', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "unicorn" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Unicorn', '~b~Annonce Unicorn', ''..msg..'', 'CHAR_TANISHA', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~unicorn pour éfféctué cette commande', 'CHAR_TANISHA', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~unicorn pour éfféctué cette commande', 'CHAR_TANISHA', 0)
    end
 end, false)
 
RegisterCommand('bahamas', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "bahama_mamas" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Bahamas', '~b~Annonce Bahamas', ''..msg..'', 'CHAR_STRIPPER_PEACH', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~bahamas pour éfféctué cette commande', 'CHAR_STRIPPER_PEACH', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~bahamas pour éfféctué cette commande', 'CHAR_STRIPPER_PEACH', 0)
    end
end, false)
 
RegisterCommand('taxi', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "taxi" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Taxi', '~b~Annonce Taxi', ''..msg..'', 'CHAR_TAXI', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~taxi pour éfféctué cette commande', 'CHAR_TAXI', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~taxi pour éfféctué cette commande', 'CHAR_TAXI', 0)
    end
 end, false)
 
RegisterCommand('vigne', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "vigne" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Vignerons', '~b~Annonce Vignerons', ''..msg..'', 'CHAR_CHEF', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~vignerons pour éfféctué cette commande', 'CHAR_CHEF', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~vignerons pour éfféctué cette commande', 'CHAR_CHEF', 0)
    end
 end, false)
 
RegisterCommand('ems', function(source, args, rawCommand)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
if xPlayer.job.name == "ambulance" then
    local src = source
    local msg = rawCommand:sub(5)
    local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'EMS', '~b~Annonce EMS', ''..msg..'', 'CHAR_WENDY', 0)
    end
else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~EMS pour éfféctué cette commande', 'CHAR_WENDY', 0)
end
else
TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~EMS pour éfféctué cette commande', 'CHAR_WENDY', 0)
end
end, false)

RegisterCommand('gouv', function(source, args, rawCommand)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
if xPlayer.job.name == "gouv" then
    local src = source
    local msg = rawCommand:sub(5)
    local args = msg
    if player ~= false then
        local name = GetPlayerName(source)
        local xPlayers	= ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Gouverneur', '~b~Annonce Gouverneur', ''..msg..'', 'CHAR_ANDREAS', 0)
    end
else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~Gouverneur pour éfféctué cette commande', 'CHAR_ANDREAS', 0)
end
else
TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~Gouverneur pour éfféctué cette commande', 'CHAR_ANDREAS', 0)
end
end, false)

RegisterCommand('tabac', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "tabac" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Tabac', '~b~Annonce TABAC', ''..msg..'', 'CHAR_MP_ROBERTO', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~Tabac pour éfféctué cette commande', 'CHAR_MP_ROBERTO', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~Tabac pour éfféctué cette commande', 'CHAR_MP_ROBERTO', 0)
    end
end, false)

RegisterCommand('weedshop', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "weed" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Weedshop', '~g~Annonce Weedshop', ''..msg..'', 'CHAR_PROPERTY_WEED_SHOP', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~Weedshop pour éfféctué cette commande', 'CHAR_PROPERTY_WEED_SHOP', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~Weedshop pour éfféctué cette commande', 'CHAR_PROPERTY_WEED_SHOP', 0)
    end
end, false)

RegisterCommand('bcso', function(source, args, rawCommand)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.job.name == "bcso" then
        local src = source
        local msg = rawCommand:sub(5)
        local args = msg
        if player ~= false then
            local name = GetPlayerName(source)
            local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            TriggerClientEvent('Extasy:showAdvancedNotification', xPlayers[i], 'Bcso', '~y~Annonce Bcso', ''..msg..'', 'CHAR_MANUEL', 0)
        end
    else
        TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'pas' , '~b~Bcso pour éfféctué cette commande', 'CHAR_MANUEL', 0)
    end
    else
    TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Avertisement', '~b~Tu n\'est pas' , '~b~Bcso pour éfféctué cette commande', 'CHAR_MANUEL', 0)
    end
end, false)
 
 
 
 
    
    
    
    
