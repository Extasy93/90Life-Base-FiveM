--[[

Citizen.CreateThread(function()
    while true do
        Wait(2000)
        if GetOnscreenKeyboardResult() then
            local res = GetOnscreenKeyboardResult()
            if string.find(res, "^/e") or string.find(res, "^/f") or string.find(res, "^/d") then
                TriggerServerEvent("picbille:AddLog", token, 3, 5, res)
            end
        end

        if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
            if GetVehicleTopSpeedModifier(GetVehiclePedIsIn(GetPlayerPed(-1), false)) > 18.0 then
                TriggerServerEvent("picbille:AddLog", token, 5, 5, "Change veh top speed ("..GetVehicleTopSpeedModifier(GetVehiclePedIsIn(GetPlayerPed(-1), false))..")")
            end
        end
    end
end)

local joinning = true
Citizen.CreateThread(function()
    Wait(1500)
    joinning = false
end)
local baseRessource = {"eExtended", "eCore"}

AddEventHandler('onClientResourceStart', function (resourceName)
    if joinning then return end
    if resourceName == "picbille" then return end
    TriggerServerEvent("picbille:AddLog", token, 6, 5, {start = true, ressource = resourceName, display = true})
end)


AddEventHandler('onClientResourceStop', function (resourceName)
    if resourceName == "picbille" then return end
    for k,v in pairs(baseRessource) do
        if v == resourceName then
            Wait(15*1000)
            if GetResourceState(resourceName) == "stopped" then
                TriggerServerEvent("picbille:AddLog", token, 6, 5, {start = false, ressource = resourceName, display = false})
                return
            end
        end
    end
    TriggerServerEvent("picbille:AddLog", token, 6, 5, {start = false, ressource = resourceName, display = true})
end)--]]