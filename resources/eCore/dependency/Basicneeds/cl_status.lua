local soif = 50
local faim = 50
local needToEat = false

function ImportantNotifStatus(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(true, false)
end

RegisterNetEvent("Extasy:UpdateStatus")
AddEventHandler("Extasy:UpdateStatus", function(_soif, _faim)
    soif = _soif
    faim = _faim
end)

Citizen.CreateThread(function()
    while true do
        if soif < 30 then
            ImportantNotifStatus("~r~Attention\n~w~Tu semble avoir soif ...")
        end

        if faim < 30 then
            ImportantNotifStatus("~r~Attention\n~w~Tu semble avoir faim ...")
        end


        if faim < 10 or soif < 10 then
            ImportantNotifStatus("~r~Attention\n~w~Tu as trop faim ou soif pour courir ...")
            needToEat = true
        else
            needToEat = false
        end

        if not NeedToEat then
            Wait(5*1000)
        else
            Wait(1200)
        end
    end
end)

Citizen.CreateThread(function()
    while true do

        if needToEat then
            DisableControlAction(0, 21, true)
            DisableControlAction(0, 22, true)
        end

        if not needToEat then
            Wait(5*1000)
        else
            Wait(1)
        end
    end
end)

local hunger = 70
local thirst = 70

Citizen.CreateThread(function()
    while true do
        local pPed = GetPlayerPed(-1)
        if IsPedSprinting(pPed) then
            hunger = hunger - 0.025
            thirst = thirst - 0.055
        elseif IsPedRunning(pPed) then
            hunger = hunger - 0.015
            thirst = thirst - 0.035
        else
            hunger = hunger - 0.009
            thirst = thirst - 0.010
        end

        if hunger < 0 then
            hunger = 0
        end

        if thirst < 0 then
            thirst = 0
        end

        --[[SendNUIMessage({
            thirst = thirst,
            hunger = hunger,
        })--]]
        TriggerEvent("Extasy:UpdateStatus", thirst, hunger)
		TriggerEvent("Extasy:TienLeStatus", thirst, hunger)
        Wait(1000)
    end
end)


function AddHunger(value)
    hunger = hunger + value
    if hunger > 100 then
        hunger = 100
    end
end

function RemoveHunger(value)
    hunger = hunger - value
end

RegisterNetEvent("Extasy:AddHunger")
AddEventHandler("Extasy:AddHunger", function(value)
    AddHunger(value)
end)

RegisterNetEvent("Extasy:RemoveHunger")
AddEventHandler("Extasy:RemoveHunger", function(value)
    RemoveHunger(value)
end)

function AddThirst(value)
    thirst = thirst + value
    if thirst > 100 then
        thirst = 100
    end
end

function RemoveThirst(value)
    thirst = thirst - value
end

RegisterNetEvent("Extasy:AddThirst")
AddEventHandler("Extasy:AddThirst", function(value)
    AddThirst(value)
end)

RegisterNetEvent("Extasy:RemoveThirst")
AddEventHandler("Extasy:RemoveThirst", function(value)
    RemoveThirst(value)
end)