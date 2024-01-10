RegisterNetEvent("item:useUSB")
AddEventHandler("item:useUSB", function()
    checkForHacking()
end)

local cam = nil
local ATM_cooldown = false
local ATM_cooldownN = 0
local ATMs = {
    GetHashKey("prop_atm_01"),
    GetHashKey("prop_atm_02"),
    GetHashKey("prop_atm_03"),
    GetHashKey("prop_fleeca_atm"),
}

function checkForHacking()
    local ped       = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)

    for k,v in pairs(ATMs) do
        obj = Extasy.GetClosestObject(pedCoords, 3.0, v)

        if obj then
            break
        end
    end
    if not obj then
        Extasy.ShowNotification("~r~Aucun ATM à proximité")
    else
        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 350.0, -1400.0, 0.0, false)
        local dTogo = nil
        if dst < 4500 then
            local jCount = Extasy.getCountOfJob("vcpd")

            if jCount >= extasy_core_cfg["atm_min_cops_needed"] then
                if not ATM_cooldown then
                    local c    = GetOffsetFromEntityInWorldCoords(obj, 0.0, -0.6, 1.2)
                    local ctoc = GetOffsetFromEntityInWorldCoords(obj, 0.0, 0.0, 0.9)
        
                    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
        
                    SetCamActive(cam, 1)
                    SetCamCoord(cam, c)
                    SetCamFov(cam, 55.0)
                    PointCamAtCoord(cam, ctoc)
                    RenderScriptCams(1, 1, 1000, 0, 0)
                    TaskTurnPedToFaceEntity(ped, obj, 2500)
        
                    Wait(1000)
        
                    openHackingThing()
                else
                    Extasy.ShowNotification("~r~Vous avez déjà piraté cet ATM")
                end
            else
                Extasy.ShowNotification("~r~Il n'y a pas assez de vcpd en ville pour ceci ("..jCount.."/"..extasy_core_cfg["atm_min_cops_needed"]..")")
            end
        else
            local jCount = Extasy.getCountOfJob("bcsd")

            if jCount >= extasy_core_cfg["atm_min_cops_needed"] then
                if not ATM_cooldown then
                    local c    = GetOffsetFromEntityInWorldCoords(obj, 0.0, -0.6, 1.2)
                    local ctoc = GetOffsetFromEntityInWorldCoords(obj, 0.0, 0.0, 0.9)
        
                    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
        
                    SetCamActive(cam, 1)
                    SetCamCoord(cam, c)
                    SetCamFov(cam, 55.0)
                    PointCamAtCoord(cam, ctoc)
                    RenderScriptCams(1, 1, 1000, 0, 0)
                    TaskTurnPedToFaceEntity(ped, obj, 2500)
        
                    Wait(1000)
        
                    openHackingThing()
                else
                    Extasy.ShowNotification("~r~Vous avez déjà piraté cet ATM")
                end
            else
                Extasy.ShowNotification("~r~Il n'y a pas assez de BCSD en ville pour ceci ("..jCount.."/"..extasy_core_cfg["atm_min_cops_needed"]..")")
            end
        end
    end
end

openHackingThing = function()
    ATM_cooldown = true
    ATM_cooldownN = extasy_core_cfg["atm_cooldown_time"]
    local pPed = GetPlayerPed(-1)
    local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 350.0, -1400.0, 0.0, false)
    local tCall = nil

    if dst < 4500 then
        tCall = 'vcpd'
    else
        tCall = 'bcsd'
    end

    TriggerServerEvent("jobCounter:sendAlert", token, tCall, "~s~Appel anonyme\n~o~Quelqu'un semble essayer de pirater un ATM à cette position !")
    TriggerServerEvent("jobCounter:sendAlertOnMap", token, tCall, "atm_hacking", GetEntityCoords(GetPlayerPed(-1)))

    TriggerEvent("core:drawBar", 10 * 1000, "⏳ Initialisation du programme...")

    Wait(10 * 1000)

    TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start", 1, 30, hackingSucess)
    FreezeEntityPosition(pPed, true)

    Citizen.CreateThread(function()
        while ATM_cooldownN > 1 do
            ATM_cooldownN = ATM_cooldownN - 1

            Wait(1000)
        end
        ATM_cooldown = false
    end)
end

hackingSucess = function(sucess)
    local pPed = GetPlayerPed(-1)

    FreezeEntityPosition(pPed, false)
    TriggerEvent("mhacking:hide")

    -- :)
    TriggerServerEvent("bankHacking:processSucess", token, sucess)

    ClearPedTasks(pPed)
    ClearPedTasksImmediately(pPed)

    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    killCam()
end