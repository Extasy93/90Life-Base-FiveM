EBLCK = {}
EBLCK.myBlacklistList = {}

RegisterNetEvent("easyBlacklist:set")
AddEventHandler("easyBlacklist:set", function(job)
    EBLCK.blacklist(job)
end)

RegisterNetEvent("easyBlacklist:remove")
AddEventHandler("easyBlacklist:remove", function()
    EBLCK.inBlacklist = false
    Extasy.ShowNotification("~g~Vous avez été retiré de la blacklist sur laquelle vous étiez dernièrement")
end)

RegisterNetEvent("easyBlacklist:send")
AddEventHandler("easyBlacklist:send", function(data)
    EBLCK.myBlacklistList = data
end)

EBLCK.blacklist = function(job)
    if not cfg_easyBlacklist.jobs[job] then return end

    SetEntityCoords(PlayerPedId(), cfg_easyBlacklist.jobs[job].points[1].pos)
    Extasy.ShowNotification("~r~Vous avez été temporairement blacklist de cette société")

    EBLCK.inBlacklist = true
    Citizen.CreateThread(function()
        while EBLCK.inBlacklist do

            for k,v in pairs(cfg_easyBlacklist.jobs[job].points) do
                local dst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)

                if dst < 5.0 then
                    Extasy.ShowNotification("~r~Vous avez été temporairement blacklist de cette société, vous ne pouvez pas entrer")
                    -- TaskGoStraightToCoord(PlayerPedId(), v.tpPos.x, v.tpPos.y, v.tpPos.z, 1.0, 1.0, 1.0, 1.0)
                    SetEntityCoords(PlayerPedId(), v.tpPos)
                end
            end

            Wait(250)
        end
    end)
end