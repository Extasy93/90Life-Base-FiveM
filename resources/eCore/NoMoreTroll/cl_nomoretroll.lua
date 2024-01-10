local TimeToWait        = 0
local SetTimeToWait     = 3600
local secondes          = 0
local NotifCheck        = false
local BddCheck          = false
local showHelp          = false
local loaded            = false
local rechecked         = true

AddEventHandler("playerSpawned", function()
    if extasy_core_cfg["anti_troll"] then
        Wait(3000)
        TriggerServerEvent('Extasy:GetTimeInfo', token)

        if BddCheck then
            if SetTimeToWait > secondes then -- 7 200 = 2H / 10 800 = 3H / 1H = 3 600
                processBeginnerSecurity()
            else
                rechecked = false
            end
        else 
            Wait(5000)
            if SetTimeToWait > secondes then -- 7 200 = 2H / 10 800 = 3H / 1H = 3 600
                processBeginnerSecurity()
            else
                rechecked = false
            end
        end

        return
    end
end)

CheckMyDickTime = function()
    if extasy_core_cfg["anti_troll"] then
        if SetTimeToWait > secondes then -- 7 200 = 2H / 10 800 = 3H / 1H = 3 600
            processBeginnerSecurity()
        else
            rechecked = false
        end
    end
end

NoMoreTrollNotification = function()
    if extasy_core_cfg["anti_troll"] then
        if not NotifCheck then
            NotifCheck = true
            TriggerServerEvent('Extasy:GetTimeInfo', token)
            if TimeToWait > 0 then
                Extasy.ShowNotification("~r~Vous n'êtes pas encore capable de faire cela\n\n~r~Il vous reste: ~s~"..TimeToWait.." secondes~s~")
            else
                rechecked = false
            end
            
            Citizen.CreateThread(function()
                while NotifCheck do
                    Wait(13000)
                    NotifCheck = false
                end
            end)
        else 
            return
        end
    end
end

processBeginnerSecurity = function()
    Citizen.CreateThread(function()
        local pPed = GetPlayerPed(-1)

        while rechecked do
            Wait(5)

            DisableControlAction(2, 37, true)
            DisablePlayerFiring(GetPlayerPed(-1), true)
            DisableControlAction(0, 106, true)
            DisableControlAction(0, 140, true)

            if IsDisabledControlJustPressed(2, 37) then
                SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
                NoMoreTrollNotification()
            end
            if IsDisabledControlJustPressed(0, 106) then
                SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
                NoMoreTrollNotification()
            end

            if IsControlJustPressed(0, 106) then
                NoMoreTrollNotification()
            end
        end
    end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000) 

        if BddCheck then

            --[[TimeToWaitM = secondes / 3600 * 60
            TimeToWaitH = secondes / 3600
            
            if TimeToWaitM > 60 and TimeToWaitH < 2 then
                TimeToWaitM = TimeToWaitM - 60
            elseif TimeToWaitM > 120 and TimeToWaitH < 3 then
                TimeToWaitM = TimeToWaitM - 120
            elseif TimeToWaitM > 180 and TimeToWaitH < 4 then
                TimeToWaitM = TimeToWaitM - 180
            elseif TimeToWaitM > 240 and TimeToWaitH < 5 then
                TimeToWaitM = TimeToWaitM - 240
            elseif TimeToWaitM > 300 and TimeToWaitH < 6 then
                TimeToWaitM = TimeToWaitM - 300
            elseif TimeToWaitM > 360 and TimeToWaitH < 7 then
                TimeToWaitM = TimeToWaitM - 360
            elseif TimeToWaitM > 420 and TimeToWaitH < 8 then
                TimeToWaitM = TimeToWaitM - 420
            elseif TimeToWaitM > 480 and TimeToWaitH < 9 then
                TimeToWaitM = TimeToWaitM - 480
            elseif TimeToWaitM > 540 and TimeToWaitH < 10 then
                TimeToWaitM = TimeToWaitM - 540
            elseif TimeToWaitM > 600 and TimeToWaitH < 11 then
                TimeToWaitM = TimeToWaitM - 600
            elseif TimeToWaitM > 660 and TimeToWaitH < 12 then
                TimeToWaitM = TimeToWaitM - 660
            elseif TimeToWaitM > 720 and TimeToWaitH < 13 then
                TimeToWaitM = TimeToWaitM - 720
            elseif TimeToWaitM > 780 and TimeToWaitH < 14 then
                TimeToWaitM = TimeToWaitM - 780
            elseif TimeToWaitM > 840 and TimeToWaitH < 15 then
                TimeToWaitM = TimeToWaitM - 840
            elseif TimeToWaitM > 900 and TimeToWaitH < 16 then
                TimeToWaitM = TimeToWaitM - 900
                print("Bcp d'heure de jeu")
            else
                print("Bcp trop d'heure de jeu")
            end--]]

            --print("---------------------------")
            --print(ESX.Math.Round(secondes))
            --print(ESX.Math.Round(TimeToWaitH))
            --print(ESX.Math.Round(TimeToWaitM))

            TimeToWait = SetTimeToWait - secondes
            TriggerServerEvent("Extasy:SaveTime", token, 5)
            CheckMyDickTime()
        end
	end
end)

RegisterNetEvent("Extasy:initializeTimeToWait")
AddEventHandler("Extasy:initializeTimeToWait", function(s)
    secondes = s
    BddCheck = true
end)
