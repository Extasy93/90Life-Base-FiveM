ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

local ArmeItem =  false
local roueActive = {}
local GetVehicleWheel = {}
local playerroue = {}
local playerroueNotif = {}


RegisterServerEvent('Staff:RefreshAllWheelTicket')
AddEventHandler('Staff:RefreshAllWheelTicket', function(player)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playergroup = xPlayer.getGroup()
    local date = os.date('%H:%M:%S', os.time())
    TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, "Dave & Buster's", "~y~Nouvelle Participation", 'Il est acctuelement:~o~ '..date..'~s~, Tous le monde viens de recevoir ~g~+1 Ticket~s~! Venez vous aussi tentez votre chance à l\'arcade 🎰', "DAVE_BUSTERS")
    MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local date = os.date('%H:%M:%S', os.time())
        --print(date)
        if date == '00:00:00' then
            TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, "Dave & Buster's", "~y~Nouvelle Participation", 'Il est acctuelement:~o~ '..date..'~s~, Tous le monde viens de recevoir ~g~+1 Ticket~s~! Venez vous aussi tentez votre chance à l\'arcade 🎰', "DAVE_BUSTERS")
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        if date == '00:00:01' then
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        if date == '00:00:02' then
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        if date == '00:00:03' then
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        if date == '00:00:04' then
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        if date == '00:00:05' then
            TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, "Dave & Buster's", "~y~Nouvelle Participation", 'Il est acctuelement:~o~ '..date..'~s~, Tous le monde viens de recevoir ~g~+1 Ticket~s~! Venez vous aussi tentez votre chance à l\'arcade 🎰', "DAVE_BUSTERS")
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        if date == '00:00:06' then
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        if date == '00:00:07' then
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        if date == '00:00:08' then
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        if date == '00:00:09' then
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        if date == '00:00:10' then
            TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, "Dave & Buster's", "~y~Nouvelle Participation", 'Il est acctuelement:~o~ '..date..'~s~, Tous le monde viens de recevoir ~g~+1 Ticket~s~! Venez vous aussi tentez votre chance à l\'arcade 🎰', "DAVE_BUSTERS")
            MySQL.Async.execute("UPDATE `users` SET `roue` = 1 WHERE `roue` = 0", {}, function() end)
        end
        Citizen.Wait(5000)
    end
end)

local roue = {
    [1] = { "5 Sandwich poulet curry", "5 Jus de fruits", "500$"},
    [2] = { "2 Sprays", "1 Chaise de jardin", "1500$" },
    [3] = { "2 Bouteilles de vin ", "15 bananes", "5 000$"},
    [4] = { "5 Sprays", "15000$"},
    [5] = { "LA VOITURE !!!"},
}

local getrecompense = {
    ['500$']                = {type = 'money', moneycount = 500},  
    ['1500$']               = {type = 'money', moneycount = 1500},
    ['5000$']               = {type = 'money', moneycount = 10000},
    ['15000$']              = {type = 'money', moneycount = 15000},
    ['20000$']              = {type = 'money', moneycount = 20000},

    ['2 Bouteilles de vin'] = {type = 'item', itemmodel = 'bouteilledevin', quantity = 2},
    ['2 Sprays']            = {type = 'item', itemmodel = 'spray', quantity = 2},
    ['5 Sprays']            = {type = 'item', itemmodel = 'spray', quantity = 5},
    ['1 Chaise de jardin']  = {type = 'item', itemmodel = 'Chaise', quantity = 1},
    ['5 limonades']         = {type = 'item', itemmodel = 'limonade', quantity = 5},

    ['LA VOITURE !!!']      = {type = 'vehicle', vehiclemodel = 'CITRUS2'},
}

RegisterServerEvent('Extasy:notifTicket')
AddEventHandler('Extasy:notifTicket', function()
    src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.Async.fetchAll("SELECT roue FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
        for k,v in pairs(result) do
            if not playerroueNotif[xPlayer.identifier] then 
                playerroueNotif[xPlayer.identifier] =  {} 
                playerroueNotif[xPlayer.identifier].roue = v.roue
            end
        end

        if playerroueNotif[xPlayer.identifier].roue == 0 then
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "Dave & Buster's", "~y~Tickets", "Vous n'avez plus de ticket ~r~(0)~w~.", "DAVE_BUSTERS")
        elseif playerroueNotif[xPlayer.identifier].roue == 1 then
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "Dave & Buster's", "~y~Tickets", "Vous avez recu votre ticket journalier ~g~+1~w~.", "DAVE_BUSTERS")
        elseif playerroueNotif[xPlayer.identifier].roue >= 1 then
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "Dave & Buster's", "~y~Tickets", "Il vous reste actuellement [~y~" .. playerroue[xPlayer.identifier].roue .. "~w~] tours de roue.", "DAVE_BUSTERS")
        end
    end)
end)

RegisterServerEvent('Extasy:createPlayer')
AddEventHandler('Extasy:createPlayer', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.Async.fetchAll("SELECT roue FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
        for k,v in pairs(result) do
            if not playerroue[xPlayer.identifier] then 
                playerroue[xPlayer.identifier] =  {} 
                playerroue[xPlayer.identifier].roue = v.roue
            end
        end
        TriggerClientEvent('Extasy:servertoclient', src, playerroue[xPlayer.identifier])
    end)
end)

RegisterServerEvent('Exatsy:loadingAnimation')
AddEventHandler('Exatsy:loadingAnimation', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('Extasy:roueonoff', -1, true) -- Pour que personne l'utilise en même temps.
    src = source
    roueActive[xPlayer.identifier] = true
    local xPlayer = ESX.GetPlayerFromId(src)
    if playerroue[xPlayer.identifier].roue == 1 then
        playerroue[xPlayer.identifier].roue = 0
        MySQL.Async.execute("UPDATE `users` SET `roue` = 0 WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end) 
    else
        local newticket = playerroue[xPlayer.identifier].roue - 1
        MySQL.Async.execute("UPDATE `users` SET `roue`= '".. newticket .."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end)  
        playerroue[xPlayer.identifier].roue = newticket
    end
    TriggerClientEvent('Extasy:servertoclient', src, playerroue[xPlayer.identifier])
end)

local playerRouee = {}

RegisterServerEvent('Extasy:start')
AddEventHandler('Extasy:start', function(token)
    if not CheckToken(token, source, "Extasy:start") then return end
    src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if roueActive[xPlayer.identifier] then
        table.insert(playerRouee, src)
        StartRoue(src)
        roueActive[xPlayer.identifier] = false
    end
end)

GetRandomHeartSv = function()
	local hearts = {"❤", "🧡", "💛", "💚", "💙", "💜", "🤎", "🤍", "❣", "💕", "💞", "💓", "💗", "💖", "💘", "💝", "💟"}

	return hearts[math.random(1, #hearts)]
end

StartRoue = function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    local percentage = math.random(1, 1000)
    --local percentage = 100
    local award = {}
    for k,v in pairs(playerRouee) do
        if v == src then
            award[v] = {}
            if src == v then
                if percentage >= 999 then
                    award[v] = roue[6][math.random(1, #roue[6])]
                    print("Gagne la voiture")
                elseif percentage >= 950 then
                    award[v] = roue[1][math.random(1, #roue[1])]
                elseif percentage >= 750 then
                    award[v] = roue[2][math.random(1, #roue[2])]
                elseif percentage >= 650 then
                    award[v] = roue[3][math.random(1, #roue[3])]
                elseif percentage >= 400 then
                    award[v] = roue[4][math.random(1, #roue[4])]
                else
                    award[v] = roue[5][math.random(1, #roue[5])]
                end
                TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "Dave & Buster's", "~y~Félicitation !", 'Vous venez de remporter '.. award[v], "DAVE_BUSTERS")
                local lot = award[v]
                award = {}
                if getrecompense[lot] == nil then
                    --TriggerEvent('BanSql:ICheatServer', xPlayer.source)
                    --TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, "Dave & Buster's", "~y~Nouvelle Participation", '~o~' .. xPlayer.name .. '~s~ vient d\'obtenir: ~r~UN BAN~s~ dans Dave & Buster's de la fortune ! \nVenez vous aussi tentez votre chance à l\'arcade', "DAVE_BUSTERS")
                elseif getrecompense[lot].type == 'vehicle' then
                    GetVehicleWheel[v] = true
                    TriggerClientEvent('ExtasyWheel:WinTheCar', src, getrecompense[lot].vehiclemodel)
                    TriggerClientEvent('Extasy:ShowAdvancedNotification', -1, "Dave & Buster's", "~g~Nouvelle Participation", "Un(e) citoyen vien de gagner ~g~Une voiture ~s~ en tournant La Dave's Wheel !\n\nSa chance était de 0.01%, valeur de la voiture: ~y~1 678 000$~s~", "DAVE_BUSTERS")
                end
                TriggerClientEvent('Extasy:roueonoff', -1, false)
                table.remove(playerRouee, k)
                SendLog("**Dave & Buster's**```\nPseudo: "..GetPlayerName(id).."\nRP NAME: "..PlayersData[id].lastname.." "..PlayersData[id].firstname.."\nLot gagné:\n"..lot.."```", "wheel")
            end
        end
    end
end

RegisterServerEvent('Exatsy:boutiquevehicle')
AddEventHandler('Exatsy:boutiquevehicle', function(vehicleProps, vehicleType)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    if GetVehicleWheel[_source] == true then
        
        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (@owner, @plate, @vehicle, @type)', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@type'] = vehicleType
        }, function(rowsChanged)
        end)
        GetVehicleWheel[_source] = false
    else
        TriggerEvent('BanSql:ICheatServer', xPlayer.source)
    end
end)

ESX.RegisterServerCallback('Extasy:getPlate', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

RegisterCommand('gt', function(source, args)
    local _source = args[1]
	local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer and source == 0 then 
        MySQL.Async.fetchAll("SELECT roue FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            for k,v in pairs(result) do
                if not playerroue[xPlayer.identifier] then 
                    playerroue[xPlayer.identifier] =  {} 
                    playerroue[xPlayer.identifier].roue = v.roue
                    local newticketgive = playerroue[xPlayer.identifier].roue + args[2]
                    MySQL.Async.execute("UPDATE `users` SET `roue` = '"..newticketgive.."' WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function() end) 
                end
            end
        end)
	end
end)

RegisterCommand("ticket", function(source, args, rawCommand)
    src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    MySQL.Async.fetchAll("SELECT roue FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
        for k,v in pairs(result) do
            if not playerroue[xPlayer.identifier] then 
                playerroue[xPlayer.identifier] =  {} 
                playerroue[xPlayer.identifier].roue = v.roue
                print(playerroue[xPlayer.identifier].roue)
            end
        end

        if playerroue[xPlayer.identifier].roue == 0 then
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "Dave & Buster's", "~y~Tickets", "Vous n'avez plus de ticket ~r~(0)~w~.", "DAVE_BUSTERS")
        elseif playerroue[xPlayer.identifier].roue == 1 then
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "Dave & Buster's", "~y~Tickets", "Vous avez recu votre ticket journalier ~g~+1~w~.", "DAVE_BUSTERS")
        elseif playerroue[xPlayer.identifier].roue >= 1 then
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "Dave & Buster's", "~y~Tickets", "Il vous reste actuelement [~y~" .. playerroue[xPlayer.identifier].roue .. "~w~] tours de roue.", "DAVE_BUSTERS")
        end
    end)
end, false)