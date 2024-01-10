local AM = {}

AM.ActivesObjects = {}

Citizen.CreateThread(function()
    while true do
        local ped       = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)
        for _,v in pairs(cfg_auto_mapper.objects) do
            local dst = GetDistanceBetweenCoords(v.pos, pedCoords, true)
            if not v.spawned then
                if dst <= v.distance then
                    v.spawned = true

                    Citizen.CreateThread(function()
                        local objectHash = GetHashKey(v.object)
                        RequestModel(objectHash)

                        while not HasModelLoaded(objectHash) do
                            Citizen.Wait(1)
                        end

                        v.entity = CreateObject(objectHash, v.pos, false, false, true)

                        SetEntityHeading(v.entity, v.heading or 0)
                        PlaceObjectOnGroundProperly(v.entity)
                        Citizen.Wait(100)
                        FreezeEntityPosition(v.entity, true)
                        SetEntityInvincible(v.entity, true)
                        SetModelAsNoLongerNeeded(objectHash)
                    end)
                end
            else
                if dst > v.distance then
                    if DoesEntityExist(v.entity) then
                        v.spawned = false
                        DeleteEntity(v.entity)
                        for k,v in pairs(AM.ActivesObjects) do
                            if v.pos == v.pos then
                                table.remove(AM.ActivesObjects, k)
                            end
                        end
                    end
                end
            end
        end
        Wait(1000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local near_npc  = false
        local ped       = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)

        for k,v in pairs(cfg_auto_mapper.objects) do
            local dst = GetDistanceBetweenCoords(pedCoords, v.pos, true)
            local v_dst = v.distanceAction or 2.5

            if dst <= v_dst then
                near_npc = true
                if v.message ~= nil then
                   ESX.ShowHelpNotification(v.message)
                    if IsControlJustPressed(0, 38) then
                        v.action()
                    end
                end
            end
        end

        if near_npc then
            Wait(1)
        else
            Wait(500)
        end
    end
end)