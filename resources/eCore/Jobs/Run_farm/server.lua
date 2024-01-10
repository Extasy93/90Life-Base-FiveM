ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

function farmwater(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local waterQuantity = xPlayer.getInventoryItem('water').count

        if waterQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('water', 1)
            farmwater(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_water')
AddEventHandler('start:farm_water', function(token)
    if not CheckToken(token, source, "start:farm_water") then return end

    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmwater(source)
end)

function farmmojito(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local mojitoQuantity = xPlayer.getInventoryItem('mojito').count

        if mojitoQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('mojito', 1)
            farmmojito(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_mojito')
AddEventHandler('start:farm_mojito', function(token)
    if not CheckToken(token, source, "start:farm_mojito") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmmojito(source)
end)

function farmrhumcoca(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local rhumcocaQuantity = xPlayer.getInventoryItem('rhumcoca').count

        if rhumcocaQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('rhumcoca', 1)
            farmrhumcoca(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_rhumcoca')
AddEventHandler('start:farm_rhumcoca', function(token)
    if not CheckToken(token, source, "start:farm_rhumcoca") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmrhumcoca(source)
end)

function farmrhumfruit(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local rhumfruitQuantity = xPlayer.getInventoryItem('rhumfruit').count

        if rhumfruitQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('rhumfruit', 1)
            farmrhumfruit(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_rhumfruit')
AddEventHandler('start:farm_rhumfruit', function(token)
    if not CheckToken(token, source, "start:farm_rhumfruit") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmrhumfruit(source)
end)

function farmvodkafruit(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local vodkafruitQuantity = xPlayer.getInventoryItem('vodkafruit').count

        if vodkafruitQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('vodkafruit', 1)
            farmvodkafruit(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_vodkafruit')
AddEventHandler('start:farm_vodkafruit', function(token)
    if not CheckToken(token, source, "start:farm_vodkafruit") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmvodkafruit(source)
end)

function farmvodkaenergy(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local vodkaenergyQuantity = xPlayer.getInventoryItem('vodkaenergy').count

        if vodkaenergyQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('vodkaenergy', 1)
            farmvodkaenergy(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_vodkaenergy')
AddEventHandler('start:farm_vodkaenergy', function(token)
    if not CheckToken(token, source, "start:farm_vodkaenergy") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmvodkaenergy(source)
end)

function farmwhiskycoca(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local whiskycocaQuantity = xPlayer.getInventoryItem('whiskycoca').count

        if whiskycocaQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('whiskycoca', 1)
            farmwhiskycoca(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_whiskycoca')
AddEventHandler('start:farm_whiskycoca', function(token)
    if not CheckToken(token, source, "start:farm_whiskycoca") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmwhiskycoca(source)
end)

function farmvodka(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local vodkaQuantity = xPlayer.getInventoryItem('vodka').count

        if vodkaQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('vodka', 1)
            farmvodka(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_vodka')
AddEventHandler('start:farm_vodka', function(token)
    if not CheckToken(token, source, "start:farm_vodka") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmvodka(source)
end)

function farmrhum(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local rhumQuantity = xPlayer.getInventoryItem('rhum').count

        if rhumQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('rhum', 1)
            farmrhum(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_rhum')
AddEventHandler('start:farm_rhum', function(token)
    if not CheckToken(token, source, "start:farm_rhum") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmrhum(source)
end)

function farmmartini(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local martiniQuantity = xPlayer.getInventoryItem('martini').count

        if martiniQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('martini', 1)
            farmmartini(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_martini')
AddEventHandler('start:farm_martini', function(token)
    if not CheckToken(token, source, "start:farm_martini") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmmartini(source)
end)

function farmjagerbomb(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local jagerbombQuantity = xPlayer.getInventoryItem('jagerbomb').count

        if jagerbombQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('jagerbomb', 1)
            farmjagerbomb(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_jagerbomb')
AddEventHandler('start:farm_jagerbomb', function(token)
    if not CheckToken(token, source, "start:farm_jagerbomb") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmjagerbomb(source)
end)

function farmtequila(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local tequilaQuantity = xPlayer.getInventoryItem('tequila').count

        if tequilaQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('tequila', 1)
            farmtequila(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_tequila')
AddEventHandler('start:farm_tequila', function(token)
    if not CheckToken(token, source, "start:farm_tequila") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmtequila(source)
end)

function farmlimonade(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local limonadeQuantity = xPlayer.getInventoryItem('limonade').count

        if limonadeQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('limonade', 1)
            farmlimonade(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_limonade')
AddEventHandler('start:farm_limonade', function(token)
    if not CheckToken(token, source, "start:farm_limonade") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmlimonade(source)
end)


function farmdrpepper(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local drpepperQuantity = xPlayer.getInventoryItem('drpepper').count

        if drpepperQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('drpepper', 1)
            farmdrpepper(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_drpepper')
AddEventHandler('start:farm_drpepper', function(token)
    if not CheckToken(token, source, "start:farm_drpepper") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmdrpepper(source)
end)

function farmcocacola(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local cocacolaQuantity = xPlayer.getInventoryItem('cocacola').count

        if cocacolaQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('cocacola', 1)
            farmcocacola(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_cocacola')
AddEventHandler('start:farm_cocacola', function(token)
    if not CheckToken(token, source, "start:farm_cocacola") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmcocacola(source)
end)

function farmjusfruit(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local jusfruitQuantity = xPlayer.getInventoryItem('jusfruit').count

        if jusfruitQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('jusfruit', 1)
            farmjusfruit(source)
            end)
        end
    end
end

function farmjusfruit(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local jusfruitQuantity = xPlayer.getInventoryItem('jusfruit').count

        if jusfruitQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('jusfruit', 1)
            farmjusfruit(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_jusfruit')
AddEventHandler('start:farm_jusfruit', function(token)
    if not CheckToken(token, source, "start:farm_jusfruit") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmjusfruit(source)
end)

function farmfanta(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local fantaQuantity = xPlayer.getInventoryItem('fanta').count

        if fantaQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('fanta', 1)
            farmfanta(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_fanta')
AddEventHandler('start:farm_fanta', function(token)
    if not CheckToken(token, source, "start:farm_fanta") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmfanta(source)
end)

function farmsprite(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local spriteQuantity = xPlayer.getInventoryItem('sprite').count

        if spriteQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('sprite', 1)
            farmsprite(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_sprite')
AddEventHandler('start:farm_sprite', function(token)
    if not CheckToken(token, source, "start:farm_sprite") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmsprite(source)
end)

function farmcocacola(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local cocacolaQuantity = xPlayer.getInventoryItem('cocacola').count

        if cocacolaQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('cocacola', 1)
            farmcocacola(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_cocacola')
AddEventHandler('start:farm_cocacola', function(token)
    if not CheckToken(token, source, "start:farm_cocacola") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmcocacola(source)
end)

function farmicetea(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local iceteaQuantity = xPlayer.getInventoryItem('icetea').count

        if iceteaQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('icetea', 1)
            farmicetea(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_icetea')
AddEventHandler('start:farm_icetea', function(token)
    if not CheckToken(token, source, "start:farm_icetea") then return end
    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmicetea(source)
end)

function farmredbull(source)
    if PlayersHarvesting[source] == true then
        local xPlayer = ESX.GetPlayerFromId(source)
        local redbullQuantity = xPlayer.getInventoryItem('redbull').count

        if redbullQuantity >= 150 then
            TriggerClientEvent('Extasy:showNotification', source, 'Tu n\'as plus de place dans ton inventaire')
        else
            SetTimeout(1800, function()
            xPlayer.addInventoryItem('redbull', 1)
            farmredbull(source)
            end)
        end
    end
end


RegisterServerEvent('start:farm_redbull')
AddEventHandler('start:farm_redbull', function(token)
    if not CheckToken(token, source, "start:farm_redbull") then return end

    local _source = source
    PlayersHarvesting[_source] = true
    TriggerClientEvent('Extasy:showNotification', _source, 'Récupération...')
    FreezeEntityPosition(playerPed, true)
    farmredbull(source)
end)
