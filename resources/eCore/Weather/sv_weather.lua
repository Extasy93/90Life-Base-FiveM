DynamicWeather = true
debugprint = true
AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    --'XMAS', 
    'HALLOWEEN',
}

CurrentWeather = "EXTRASUNNY"
local baseTime = 0
local timeOffset = 0
local freezeTime = true
local blackout = false
local newWeatherTimer = 10

RegisterServerEvent('Weather:requestSync')
AddEventHandler('Weather:requestSync', function()
    TriggerClientEvent('Weather:updateWeather', -1, CurrentWeather, blackout)
    TriggerClientEvent('Weather:updateTime', -1, baseTime, timeOffset, freezeTime)
end)

RegisterCommand('freezetime', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    if source ~= 0 then
        if playerSrvGroup ~= "user" then
            freezeTime = not freezeTime
            if freezeTime then
                TriggerClientEvent('Extasy:ShowNotification', source, 'Time is now ~g~frozen~s~.')
            else
                TriggerClientEvent('Extasy:ShowNotification', source, 'Time is ~g~no longer frozen~s~.')
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1You are not allowed to use this command.')
        end
    else
        freezeTime = not freezeTime
        if freezeTime then
            print("Time is now frozen.")
        else
            print("Time is no longer frozen.")
        end
    end
end)

RegisterCommand('freezeweather', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    if source ~= 0 then
        if playerSrvGroup ~= "user" then
            DynamicWeather = not DynamicWeather
            if not DynamicWeather then
                ExecuteCommand("say NEIGE UNFREEZE")
            else
                ExecuteCommand("say NEIGE FREEZE")
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1You are not allowed to use this command.')
        end
    else
        DynamicWeather = not DynamicWeather
        if not DynamicWeather then
            print("Weather is now frozen.")
        else
            print("Weather is no longer frozen.")
        end
    end
end)

RegisterCommand('weather', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    if source == 0 then
        local validWeatherType = false
        if args[1] == nil then
            print("Invalid syntax, correct syntax is: /weather <weathertype> ")
            return
        else
            for i,wtype in ipairs(AvailableWeatherTypes) do
                if wtype == string.upper(args[1]) then
                    validWeatherType = true
                end
            end
            if validWeatherType then
                print("Weather has been updated.")
                CurrentWeather = string.upper(args[1])
                newWeatherTimer = 10
                TriggerEvent('Weather:requestSync')
            else
                print("Invalid weather type, valid weather types are: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ")
            end
        end
    else
        if playerSrvGroup ~= "user" then
            local validWeatherType = false
            if args[1] == nil then
                TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Invalid syntax, use ^0/weather <weatherType> ^1instead!')
            else
                for i,wtype in ipairs(AvailableWeatherTypes) do
                    if wtype == string.upper(args[1]) then
                        validWeatherType = true
                    end
                end
                if validWeatherType then
                    TriggerClientEvent('Extasy:ShowNotification', source, 'Weather will change to: ~g~' .. string.lower(args[1]) .. "~s~.")
                    CurrentWeather = string.upper(args[1])
                    newWeatherTimer = 10
                    TriggerEvent('Weather:requestSync')
                else
                    TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Invalid weather type, valid weather types are: ^0\nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ')
                end
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1You do not have access to that command.')
            print('Access for command /weather denied.')
        end
    end
end, false)

RegisterCommand('blackout', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    if source == 0 then
        blackout = not blackout
        if blackout then
            print("Blackout is now enabled.")
        else
            print("Blackout is now disabled.")
        end
    else
        if playerSrvGroup ~= "user" then
            blackout = not blackout
            if blackout then
                TriggerClientEvent('Extasy:ShowNotification', source, 'Blackout is now ~g~enabled~s~.')
            else
                TriggerClientEvent('Extasy:ShowNotification', source, 'Blackout is now ~g~disabled~s~.')
            end
            TriggerEvent('Weather:requestSync')
        end
    end
end)

RegisterCommand('morning', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    if playerSrvGroup ~= "user" then
        ShiftToMinute(0)
        ShiftToHour(9)
        TriggerClientEvent('Extasy:ShowNotification', source, 'Time set to ~g~morning~s~.')
        TriggerEvent('Weather:requestSync')
    end
end)
RegisterCommand('noon', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    if playerSrvGroup ~= "user" then
        ShiftToMinute(0)
        ShiftToHour(12)
        TriggerClientEvent('Extasy:ShowNotification', source, 'Time set to ~g~noon~s~.')
        TriggerEvent('Weather:requestSync')
    end
end)
RegisterCommand('evening', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    if playerSrvGroup ~= "user" then
        ShiftToMinute(0)
        ShiftToHour(18)
        TriggerClientEvent('Extasy:ShowNotification', source, 'Time set to ~g~evening~s~.')
        TriggerEvent('Weather:requestSync')
    end
end)
RegisterCommand('night', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()
    if source == 0 then
        print("For console, use the \"/time <hh> <mm>\" command instead!")
        return
    end
    if playerSrvGroup ~= "user" then
        ShiftToMinute(0)
        ShiftToHour(23)
        TriggerClientEvent('Extasy:ShowNotification', source, 'Time set to ~g~night~s~.')
        TriggerEvent('Weather:requestSync')
    end
end)

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

RegisterCommand('time', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
	local playerSrvGroup = xPlayer.getGroup()

    if source == 0 then
        if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
            local argh = tonumber(args[1])
            local argm = tonumber(args[2])
            if argh < 24 then
                ShiftToHour(argh)
            else
                ShiftToHour(0)
            end
            if argm < 60 then
                ShiftToMinute(argm)
            else
                ShiftToMinute(0)
            end
            print("Time has changed to " .. argh .. ":" .. argm .. ".")
            TriggerEvent('Weather:requestSync')
        else
            print("Invalid syntax, correct syntax is: time <hour> <minute> !")
        end
    elseif source ~= 0 then
        if playerSrvGroup ~= "user" then
            if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil then
                local argh = tonumber(args[1])
                local argm = tonumber(args[2])
                if argh < 24 then
                    ShiftToHour(argh)
                else
                    ShiftToHour(0)
                end
                if argm < 60 then
                    ShiftToMinute(argm)
                else
                    ShiftToMinute(0)
                end
                local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
				local minute = math.floor((baseTime+timeOffset)%60)
                if minute < 10 then
                    newtime = newtime .. "0" .. minute
                else
                    newtime = newtime .. minute
                end
                TriggerClientEvent('Extasy:ShowNotification', source, 'Time was changed to: ~g~' .. newtime .. "~s~!")
                TriggerEvent('Weather:requestSync')
            else
                TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1Invalid syntax. Use ^0/time <hour> <minute> ^1instead!')
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1You do not have access to that command.')
            print('Access for command /time denied.')
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)

CreateThread(function()
    while true do
        Wait(10000)
        TriggerClientEvent('Weather:updateTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

CreateThread(function()
    while true do
        Wait(3000000)
        TriggerClientEvent('Weather:updateWeather', -1, CurrentWeather, blackout)
        local names = {
            ["EXTRASUNNY"] = "La météo devient plus calme avec un ciel dégagé et une température de 27°.",
            ["CLEAR"] = "Une brume vient de se former, attention sur la route.",
            ["NEUTRAL"] = "Le ciel est maintenant bien dégagé, les températures sont normals.",
            ["SMOG"] = "Une très légère brume s'est levée.",
            ["FOGGY"] = "Une ambiance brumeuse vient de se lever.",
            ["OVERCAST"] = "Le ciel est maintenant assez couvert.",
            ["CLOUDS"] = "Le ciel est maintenant un peu nuageux.",
            ["CLEARING"] = "Le ciel se dégage.",
            ["RAIN"] = "La pluie commence à tomber.",
            ["THUNDER"] = "L'orage est de sortie !",
            ["SNOW"] = "Une légère neige commence à tomber.",
            ["BLIZZARD"] = "Un blizzard vient de se lever, sortez couvert!",
            ["SNOWLIGHT"] = "Une ambiance neigeuse c'est lever, attention à vous.",
            ["XMAS"] = "La neige recouvre maintenant le sol, attention à votre conduite et sortez couvert!",
            ["HALLOWEEN"] = "Une ambiance sinistre s'installe sur la ville ....",
        }
        
        TriggerClientEvent("Extasy:ShowAdvancedNotification", -1, "INFORMATIONS", "Météo !", names[CurrentWeather], "CHAR_BOATMECANO", 10)
    end
end)

CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Wait(60000)
        if newWeatherTimer == 0 then
            if DynamicWeather then
                NextWeatherStage()
            end
            newWeatherTimer = 10
        end
    end
end)

NextWeatherStage = function()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("Weather:requestSync")
    if debugprint then
        print("[Météo] New random weather type has been generated: " .. CurrentWeather .. ".\n")
        print("[Météo] Resetting timer to 10 minutes.\n")
    end
end
