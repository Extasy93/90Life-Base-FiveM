SRBB = {}
srbb_callback = nil
srbb_currentCops = nil
playerCrew = "test"

Srbb_canStartRobbery = function(index)
    jCount = Extasy.getCountOfJob("vcpd")
    srbb_currentCops = "vcpd"

    if jCount >= cfg_simpleRobberys.list[index].neededCops then
        return true
    else
        return false
    end
end

Citizen.CreateThread(function()
    for k,v in pairs(cfg_simpleRobberys.list) do
        if v.blip then
            if v.requiredGang then
                if playerCrew ~= 'Aucun' then
                    if not v.blipStatic then
                        AddTextEntry('BLIPS_ROBBERYS_'..k, v.blipName)
    
                        v.blipEntity = AddBlipForCoord(v.pos)
                        SetBlipSprite(v.blipEntity, v.blipSprite)
                        SetBlipDisplay(v.blipEntity, 4)
                        SetBlipColour(v.blipEntity, v.blipColor)
                        SetBlipScale(v.blipEntity, v.blipScale)
                        SetBlipAsShortRange(v.blipEntity, true)
    
                        BeginTextCommandSetBlipName('BLIPS_ROBBERYS_'..k)
                        EndTextCommandSetBlipName(v.blipEntity)
                    else
                        Citizen.CreateThread(function()
                            while true do
    
                                local dst = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.pos, false)
    
                                if dst < 150.0 then
                                    if not DoesBlipExist(v.blipEntity) then
                                        AddTextEntry('BLIPS_ROBBERYS_'..k, v.blipName)
    
                                        v.blipEntity = AddBlipForCoord(v.pos)
                                        SetBlipSprite(v.blipEntity, v.blipSprite)
                                        SetBlipDisplay(v.blipEntity, 4)
                                        SetBlipScale(v.blipEntity, v.blipScale)
                                        SetBlipColour(v.blipEntity, v.blipColor)
                                        SetBlipAsShortRange(v.blipEntity, true)
    
                                        BeginTextCommandSetBlipName('BLIPS_ROBBERYS_'..k)
                                        EndTextCommandSetBlipName(v.blipEntity)
                                    end
                                else
                                    RemoveBlip(v.blipEntity)
                                end
    
                                Wait(750)
                            end
                        end)
                    end
                end
            else
                if not v.blipStatic then
                    AddTextEntry('BLIPS_ROBBERYS_'..k, v.blipName)

                    v.blipEntity = AddBlipForCoord(v.pos)
                    SetBlipSprite(v.blipEntity, v.blipSprite)
                    SetBlipDisplay(v.blipEntity, 4)
                    SetBlipColour(v.blipEntity, v.blipColor)
                    SetBlipScale(v.blipEntity, v.blipScale)
                    SetBlipAsShortRange(v.blipEntity, true)

                    BeginTextCommandSetBlipName('BLIPS_ROBBERYS_'..k)
                    EndTextCommandSetBlipName(v.blipEntity)
                else
                    Citizen.CreateThread(function()
                        while true do

                            local dst = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.pos, false)

                            if dst < 150.0 then
                                if not DoesBlipExist(v.blipEntity) then
                                    AddTextEntry('BLIPS_ROBBERYS_'..k, v.blipName)

                                    v.blipEntity = AddBlipForCoord(v.pos)
                                    SetBlipSprite(v.blipEntity, v.blipSprite)
                                    SetBlipDisplay(v.blipEntity, 4)
                                    SetBlipScale(v.blipEntity, v.blipScale)
                                    SetBlipColour(v.blipEntity, v.blipColor)
                                    SetBlipAsShortRange(v.blipEntity, true)

                                    BeginTextCommandSetBlipName('BLIPS_ROBBERYS_'..k)
                                    EndTextCommandSetBlipName(v.blipEntity)
                                end
                            else
                                RemoveBlip(v.blipEntity)
                            end

                            Wait(750)
                        end
                    end)
                end
            end
        end
    end

    Citizen.CreateThread(function()
        while true do
            local nearThing = false

            for k,v in pairs(cfg_simpleRobberys.list) do
                local dst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
    
                if dst < v.dst then
                    nearThing = true

                    if v.helpNotif then Extasy.ShowHelpNotification(v.helpNotif) end
                    if v.showMarker then DrawMarker(6, v.pos.x, v.pos.y, v.pos.z - 1.0, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 100, 0, 200, 150, false, false) end
                end
            end

            if nearThing then
                Wait(0)
            else
                Wait(1000)
            end
        end
    end)

    while true do

        local nearThing = false

        for k,v in pairs(cfg_simpleRobberys.list) do
            local dst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)

            if dst < v.dst then
                nearThing = true

                if v.key then
                    if v.singleKey then
                        if IsControlJustPressed(0, v.key) then
                            if Srbb_canStartRobbery(k) then
                                TriggerServerEvent("simpleRobberys:getStatus", token, k)

                                --SRBB.canRob = nil
                                --while SRBB.canRob == nil do Wait(100) end

                                --if SRBB.canRob then
                                    if v.neededItem then
                                        if v.requiredGang then
                                            if playerCrew ~= 'Aucun' then
                                                local iCount = Extasy.HasItem(v.neededItem)

                                                if iCount >= v.neededItemCount then
                                                    if v.beforeAnimation then
                                                        if v.animation then
                                                            if v.animationType == 'drilling' then
                                                                if v.coords then
                                                                    SetEntityCoords(PlayerPedId(), v.coords)
                                                                end

                                                                if v.heading then
                                                                    SetEntityHeading(PlayerPedId(), v.heading)
                                                                end

                                                                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)

                                                                TriggerServerEvent("simpleRobberys:rob", token, k)

                                                                if v.alertMessage then
                                                                    TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                                else
                                                                    TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                                end

                                                                TriggerEvent("Drilling:Start", function(success)
                                                                    if success then
                                                                        ClearPedTasks(PlayerPedId())

                                                                        if v.timeRob then
                                                                            Citizen.CreateThread(function()
                                                                                if v.barMessage then
                                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                                else
                                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                                end
                                                                                Wait(v.timeRob)
                                    
                                                                                if v.openDoor then
                                                                                    TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                                end

                                                                                local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                                if rDst < v.maxDst then
                                                                                    TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                                end
                                                                            end)
                                                                        end
                                                                    else
                                                                        ClearPedTasks(PlayerPedId())

                                                                        if v.removeItemOnLose then
                                                                            TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                        end

                                                                        if v.failAnimNotif then
                                                                            Extasy.ShowNotification(v.failAnimNotif)
                                                                        else
                                                                            Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                        end
                                                                    end
                                                                end)
                                                            elseif v.animationType == 'keystroke' then
                                                                if v.coords then
                                                                    SetEntityCoords(PlayerPedId(), v.coords)
                                                                end

                                                                if v.heading then
                                                                    SetEntityHeading(PlayerPedId(), v.heading)
                                                                end

                                                                Extasy.KeyStrokeAnim()

                                                                TriggerServerEvent("simpleRobberys:rob", token, k)

                                                                if v.alertMessage then
                                                                    TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                                else
                                                                    TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                                end

                                                                TriggerEvent("KeyStroke:Start", function(success)
                                                                    if success then
                                                                        --ClearPedTasks(PlayerPedId())

                                                                        if v.timeRob then
                                                                            Citizen.CreateThread(function()
                                                                                if v.barMessage then
                                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                                else
                                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                                end
                                                                                Wait(v.timeRob)
                                    
                                                                                if v.openDoor then
                                                                                    TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                                end

                                                                                local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                                if rDst < v.maxDst then
                                                                                    TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                                end
                                                                            end)
                                                                        end
                                                                    else
                                                                        --ClearPedTasks(PlayerPedId())

                                                                        if v.removeItemOnLose then
                                                                            TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                        end

                                                                        if v.failAnimNotif then
                                                                            Extasy.ShowNotification(v.failAnimNotif)
                                                                        else
                                                                            Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                        end
                                                                    end
                                                                end)
                                                            else
                                                                print("not others animationType setted up :(")
                                                            end
                                                        else
                                                            Citizen.CreateThread(function()
                                                                if v.barMessage then
                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                else
                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                end
                                                                Wait(v.timeRob)

                                                                if v.openDoor then
                                                                    TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                end

                                                                local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                if rDst < v.maxDst then
                                                                    TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                end
                                                            end)
                                                        end
                                                    else
                                                        TriggerServerEvent("simpleRobberys:rob", token, k)

                                                        if v.alertMessage then
                                                            TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                        else
                                                            TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                        end

                                                        Citizen.CreateThread(function()
                                                            if v.barMessage then
                                                                TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                            else
                                                                TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                            end
                                                            Wait(v.timeRob)
                                                            
                                                            if v.animation then
                                                                if v.animationType == 'drilling' then
                                                                    if v.coords then
                                                                        SetEntityCoords(PlayerPedId(), v.coords)
                                                                    end
                
                                                                    if v.heading then
                                                                        SetEntityHeading(PlayerPedId(), v.heading)
                                                                    end

                                                                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)

                                                                    TriggerEvent("Drilling:Start", function(success)
                                                                        if success then
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.openDoor then
                                                                                TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                            end

                                                                            local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                            if rDst < v.maxDst then
                                                                                TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                            end
                                                                        else
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.removeItemOnLose then
                                                                                TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                            end

                                                                            if v.failAnimNotif then
                                                                                Extasy.ShowNotification(v.failAnimNotif)
                                                                            else
                                                                                Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                            end
                                                                        end
                                                                    end)
                                                                elseif v.animationType == 'keystroke' then
                                                                    if v.coords then
                                                                        SetEntityCoords(PlayerPedId(), v.coords)
                                                                    end
                
                                                                    if v.heading then
                                                                        SetEntityHeading(PlayerPedId(), v.heading)
                                                                    end

                                                                    Extasy.KeyStrokeAnim()

                                                                    TriggerEvent("KeyStroke:Start", function(success)
                                                                        if success then
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.timeRob then
                                                                                Citizen.CreateThread(function()
                                                                                    if v.barMessage then
                                                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                                    else
                                                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                                    end
                                                                                    Wait(v.timeRob)
                                        
                                                                                    if v.openDoor then
                                                                                        TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                                    end

                                                                                    local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                                    if rDst < v.maxDst then
                                                                                        TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                                    end
                                                                                end)
                                                                            end
                                                                        else
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.removeItemOnLose then
                                                                                TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                            end
                
                                                                            if v.failAnimNotif then
                                                                                Extasy.ShowNotification(v.failAnimNotif)
                                                                            else
                                                                                Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                            end
                                                                        end
                                                                    end)
                                                                else
                                                                    print("not others animationType setted up :(")
                                                                end
                                                            end
                                                        end)
                                                    end
                                                else
                                                    if v.notHavingNeededItem then
                                                        Extasy.ShowNotification(v.notHavingNeededItem)
                                                    else
                                                    Extasy.ShowNotification("~r~Vous n'avez pas l'objet nécessaire pour faire ce braquage")
                                                    end
                                                end
                                            else
                                                Extasy.ShowNotification("~r~Cette activité est réservée aux gangs officiels")
                                            end
                                        else
                                            if v.requiredGang then
                                                if playerCrew ~= 'Aucun' then
                                                    local iCount = Extasy.HasItem(v.neededItem)

                                                    if iCount >= v.neededItemCount then
                                                        if v.beforeAnimation then
                                                            if v.animation then
                                                                if v.animationType == 'drilling' then
                                                                    if v.coords then
                                                                        SetEntityCoords(PlayerPedId(), v.coords)
                                                                    end

                                                                    if v.heading then
                                                                        SetEntityHeading(PlayerPedId(), v.heading)
                                                                    end

                                                                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)

                                                                    TriggerServerEvent("simpleRobberys:rob", token, k)

                                                                    if v.alertMessage then
                                                                        TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                                    else
                                                                        TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                                    end

                                                                    TriggerEvent("Drilling:Start", function(success)
                                                                        if success then
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.timeRob then
                                                                                Citizen.CreateThread(function()
                                                                                    if v.barMessage then
                                                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                                    else
                                                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                                    end
                                                                                    Wait(v.timeRob)
                                            
                                                                                    if v.openDoor then
                                                                                        TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                                    end

                                                                                    local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                                    if rDst < v.maxDst then
                                                                                        TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                                    end
                                                                                end)
                                                                            end
                                                                        else
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.removeItemOnLose then
                                                                                TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                            end

                                                                            if v.failAnimNotif then
                                                                                Extasy.ShowNotification(v.failAnimNotif)
                                                                            else
                                                                                Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                            end
                                                                        end
                                                                    end)
                                                                elseif v.animationType == 'keystroke' then
                                                                    if v.coords then
                                                                        SetEntityCoords(PlayerPedId(), v.coords)
                                                                    end

                                                                    if v.heading then
                                                                        SetEntityHeading(PlayerPedId(), v.heading)
                                                                    end

                                                                    Extasy.KeyStrokeAnim()

                                                                    TriggerServerEvent("simpleRobberys:rob", token, k)

                                                                    if v.alertMessage then
                                                                        TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                                    else
                                                                        TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                                    end

                                                                    TriggerEvent("KeyStroke:Start", function(success)
                                                                        if success then
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.timeRob then
                                                                                Citizen.CreateThread(function()
                                                                                    if v.barMessage then
                                                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                                    else
                                                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                                    end
                                                                                    Wait(v.timeRob)
                                            
                                                                                    if v.openDoor then
                                                                                        TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                                    end

                                                                                    local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                                    if rDst < v.maxDst then
                                                                                        TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                                    end
                                                                                end)
                                                                            end
                                                                        else
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.removeItemOnLose then
                                                                                TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                            end

                                                                            if v.failAnimNotif then
                                                                                Extasy.ShowNotification(v.failAnimNotif)
                                                                            else
                                                                                Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                            end
                                                                        end
                                                                    end)
                                                                else
                                                                    print("not others animationType setted up :(")
                                                                end
                                                            else
                                                                Citizen.CreateThread(function()
                                                                    if v.barMessage then
                                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                    else
                                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                    end
                                                                    Wait(v.timeRob)

                                                                    if v.openDoor then
                                                                        TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                    end

                                                                    local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                    if rDst < v.maxDst then
                                                                        TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                    end
                                                                end)
                                                            end
                                                        else
                                                            TriggerServerEvent("simpleRobberys:rob", token, k)

                                                            if v.alertMessage then
                                                                TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                            else
                                                                TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                            end

                                                            Citizen.CreateThread(function()
                                                                if v.barMessage then
                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                else
                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                end
                                                                Wait(v.timeRob)
                                                                
                                                                if v.animation then
                                                                    if v.animationType == 'drilling' then
                                                                        if v.coords then
                                                                            SetEntityCoords(PlayerPedId(), v.coords)
                                                                        end
                        
                                                                        if v.heading then
                                                                            SetEntityHeading(PlayerPedId(), v.heading)
                                                                        end

                                                                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)

                                                                        TriggerEvent("Drilling:Start", function(success)
                                                                            if success then
                                                                                ClearPedTasks(PlayerPedId())

                                                                                if v.openDoor then
                                                                                    TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                                end

                                                                                local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                                if rDst < v.maxDst then
                                                                                    TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                                end
                                                                            else
                                                                                ClearPedTasks(PlayerPedId())

                                                                                if v.removeItemOnLose then
                                                                                    TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                                end

                                                                                if v.failAnimNotif then
                                                                                    Extasy.ShowNotification(v.failAnimNotif)
                                                                                else
                                                                                    Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                                end
                                                                            end
                                                                        end)
                                                                    elseif v.animationType == 'keystroke' then
                                                                        if v.coords then
                                                                            SetEntityCoords(PlayerPedId(), v.coords)
                                                                        end
                        
                                                                        if v.heading then
                                                                            SetEntityHeading(PlayerPedId(), v.heading)
                                                                        end

                                                                        Extasy.KeyStrokeAnim()

                                                                        TriggerEvent("KeyStroke:Start", function(success)
                                                                            if success then
                                                                                ClearPedTasks(PlayerPedId())

                                                                                if v.timeRob then
                                                                                    Citizen.CreateThread(function()
                                                                                        if v.barMessage then
                                                                                            TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                                        else
                                                                                            TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                                        end
                                                                                        Wait(v.timeRob)
                                                
                                                                                        if v.openDoor then
                                                                                            TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                                        end

                                                                                        local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                                        if rDst < v.maxDst then
                                                                                            TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                                        end
                                                                                    end)
                                                                                end
                                                                            else
                                                                                ClearPedTasks(PlayerPedId())

                                                                                if v.removeItemOnLose then
                                                                                    TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                                end
                        
                                                                                if v.failAnimNotif then
                                                                                    Extasy.ShowNotification(v.failAnimNotif)
                                                                                else
                                                                                    Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                                end
                                                                            end
                                                                        end)
                                                                    else
                                                                        print("not others animationType setted up :(")
                                                                    end
                                                                end
                                                            end)
                                                        end
                                                    else
                                                        if v.notHavingNeededItem then
                                                            Extasy.ShowNotification(v.notHavingNeededItem)
                                                        else
                                                            Extasy.ShowNotification("~r~Vous n'avez pas l'objet nécessaire pour faire ce braquage")
                                                        end
                                                    end
                                                else
                                                    Extasy.ShowNotification("~r~Cette activité est réservée aux gangs officiels")
                                                end
                                            else
                                                local iCount = Extasy.HasItem(v.neededItem)

                                                if iCount >= v.neededItemCount then
                                                    if v.beforeAnimation then
                                                        if v.animation then
                                                            if v.animationType == 'drilling' then
                                                                if v.coords then
                                                                    SetEntityCoords(PlayerPedId(), v.coords)
                                                                end

                                                                if v.heading then
                                                                    SetEntityHeading(PlayerPedId(), v.heading)
                                                                end

                                                                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)

                                                                TriggerServerEvent("simpleRobberys:rob", token, k)

                                                                if v.alertMessage then
                                                                    TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                                else
                                                                    TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                                end

                                                                TriggerEvent("Drilling:Start", function(success)
                                                                    if success then
                                                                        ClearPedTasks(PlayerPedId())

                                                                        if v.timeRob then
                                                                            Citizen.CreateThread(function()
                                                                                if v.barMessage then
                                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                                else
                                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                                end
                                                                                Wait(v.timeRob)
                                        
                                                                                if v.openDoor then
                                                                                    TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                                end

                                                                                local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                                if rDst < v.maxDst then
                                                                                    TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                                end
                                                                            end)
                                                                        end
                                                                    else
                                                                        ClearPedTasks(PlayerPedId())

                                                                        if v.removeItemOnLose then
                                                                            TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                        end

                                                                        if v.failAnimNotif then
                                                                            Extasy.ShowNotification(v.failAnimNotif)
                                                                        else
                                                                            Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                        end
                                                                    end
                                                                end)
                                                            elseif v.animationType == 'keystroke' then
                                                                if v.coords then
                                                                    SetEntityCoords(PlayerPedId(), v.coords)
                                                                end

                                                                if v.heading then
                                                                    SetEntityHeading(PlayerPedId(), v.heading)
                                                                end

                                                                Extasy.KeyStrokeAnim()

                                                                TriggerServerEvent("simpleRobberys:rob", token, k)

                                                                if v.alertMessage then
                                                                    TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                                else
                                                                    TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                                end

                                                                TriggerEvent("KeyStroke:Start", function(success)
                                                                    if success then
                                                                        --ClearPedTasks(PlayerPedId())

                                                                        if v.timeRob then
                                                                            Citizen.CreateThread(function()
                                                                                if v.barMessage then
                                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                                else
                                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                                end
                                                                                Wait(v.timeRob)
                                        
                                                                                if v.openDoor then
                                                                                    TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                                end

                                                                                local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                                if rDst < v.maxDst then
                                                                                    TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                                end
                                                                            end)
                                                                        end
                                                                    else
                                                                        ClearPedTasks(PlayerPedId())

                                                                        if v.removeItemOnLose then
                                                                            TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                        end

                                                                        if v.failAnimNotif then
                                                                            Extasy.ShowNotification(v.failAnimNotif)
                                                                        else
                                                                            Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                        end
                                                                    end
                                                                end)
                                                            else
                                                                print("not others animationType setted up :(")
                                                            end
                                                        else
                                                            Citizen.CreateThread(function()
                                                                if v.barMessage then
                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                else
                                                                    TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                end
                                                                Wait(v.timeRob)

                                                                if v.openDoor then
                                                                    TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                end

                                                                local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                if rDst < v.maxDst then
                                                                    TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                end
                                                            end)
                                                        end
                                                    else
                                                        TriggerServerEvent("simpleRobberys:rob", token, k)

                                                        if v.alertMessage then
                                                            TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                        else
                                                            TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                        end

                                                        Citizen.CreateThread(function()
                                                            if v.barMessage then
                                                                TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                            else
                                                                TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                            end
                                                            Wait(v.timeRob)
                                                            
                                                            if v.animation then
                                                                if v.animationType == 'drilling' then
                                                                    if v.coords then
                                                                        SetEntityCoords(PlayerPedId(), v.coords)
                                                                    end
                    
                                                                    if v.heading then
                                                                        SetEntityHeading(PlayerPedId(), v.heading)
                                                                    end

                                                                    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)

                                                                    TriggerEvent("Drilling:Start", function(success)
                                                                        if success then
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.openDoor then
                                                                                TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                            end

                                                                            local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                            if rDst < v.maxDst then
                                                                                TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                            end
                                                                        else
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.removeItemOnLose then
                                                                                --TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                            end

                                                                            if v.failAnimNotif then
                                                                                Extasy.ShowNotification(v.failAnimNotif)
                                                                            else
                                                                                Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                            end
                                                                        end
                                                                    end)
                                                                elseif v.animationType == 'keystroke' then
                                                                    if v.coords then
                                                                        SetEntityCoords(PlayerPedId(), v.coords)
                                                                    end
                    
                                                                    if v.heading then
                                                                        SetEntityHeading(PlayerPedId(), v.heading)
                                                                    end

                                                                    Extasy.KeyStrokeAnim()

                                                                    TriggerEvent("KeyStroke:Start", function(success)
                                                                        if success then
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.timeRob then
                                                                                Citizen.CreateThread(function()
                                                                                    if v.barMessage then
                                                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                                    else
                                                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                                    end
                                                                                    Wait(v.timeRob)
                                            
                                                                                    if v.openDoor then
                                                                                        TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                                    end

                                                                                    local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                                    if rDst < v.maxDst then
                                                                                        TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                                    end
                                                                                end)
                                                                            end
                                                                        else
                                                                            ClearPedTasks(PlayerPedId())

                                                                            if v.removeItemOnLose then
                                                                                TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                            end
                    
                                                                            if v.failAnimNotif then
                                                                                Extasy.ShowNotification(v.failAnimNotif)
                                                                            else
                                                                                Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                            end
                                                                        end
                                                                    end)
                                                                else
                                                                    print("not others animationType setted up :(")
                                                                end
                                                            end
                                                        end)
                                                    end
                                                else
                                                    if v.notHavingNeededItem then
                                                        Extasy.ShowNotification(v.notHavingNeededItem)
                                                    else
                                                    Extasy.ShowNotification("~r~Vous n'avez pas l'objet nécessaire pour faire ce braquage")
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if v.requiredGang then
                                            if playerCrew ~= 'Aucun' then
                                                if v.beforeAnimation then
                                                    if v.animation then
                                                        if v.animationType == 'drilling' then
                                                            if v.coords then
                                                                SetEntityCoords(PlayerPedId(), v.coords)
                                                            end
        
                                                            if v.heading then
                                                                SetEntityHeading(PlayerPedId(), v.heading)
                                                            end
        
                                                            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)
        
                                                            TriggerServerEvent("simpleRobberys:rob", token, k)
        
                                                            if v.alertMessage then
                                                                TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                            else
                                                                TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                            end
        
                                                            TriggerEvent("Drilling:Start", function(success)
                                                                if success then
                                                                    ClearPedTasks(PlayerPedId())
        
                                                                    if v.timeRob then
                                                                        Citizen.CreateThread(function()
                                                                            if v.barMessage then
                                                                                TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                            else
                                                                                TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                            end
                                                                            Wait(v.timeRob)
                            
                                                                            if v.openDoor then
                                                                                TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                            end

                                                                            local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                            if rDst < v.maxDst then
                                                                                TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                            end
                                                                        end)
                                                                    end
                                                                else
                                                                    ClearPedTasks(PlayerPedId())
        
                                                                    if v.removeItemOnLose then
                                                                        TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                    end
        
                                                                    if v.failAnimNotif then
                                                                        Extasy.ShowNotification(v.failAnimNotif)
                                                                    else
                                                                        Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                    end
                                                                end
                                                            end)
                                                        elseif v.animationType == 'keystroke' then
                                                            if v.coords then
                                                                SetEntityCoords(PlayerPedId(), v.coords)
                                                            end
        
                                                            if v.heading then
                                                                SetEntityHeading(PlayerPedId(), v.heading)
                                                            end
        
                                                            Extasy.KeyStrokeAnim()
        
                                                            TriggerServerEvent("simpleRobberys:rob", token, k)
        
                                                            if v.alertMessage then
                                                                TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                            else
                                                                TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                            end
        
                                                            TriggerEvent("KeyStroke:Start", function(success)
                                                                if success then
                                                                    ClearPedTasks(PlayerPedId())
        
                                                                    if v.timeRob then
                                                                        Citizen.CreateThread(function()
                                                                            if v.barMessage then
                                                                                TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                            else
                                                                                TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                            end
                                                                            Wait(v.timeRob)
                                
                                                                            if v.openDoor then
                                                                                TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                            end

                                                                            local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                            if rDst < v.maxDst then
                                                                                TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                            end
                                                                        end)
                                                                    end
                                                                else
                                                                    ClearPedTasks(PlayerPedId())
        
                                                                    if v.removeItemOnLose then
                                                                        TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                    end
        
                                                                    if v.failAnimNotif then
                                                                        Extasy.ShowNotification(v.failAnimNotif)
                                                                    else
                                                                        Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                    end
                                                                end
                                                            end)
                                                        else
                                                            print("not others animationType setted up :(")
                                                        end
                                                    else
                                                        Citizen.CreateThread(function()
                                                            if v.barMessage then
                                                                TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                            else
                                                                TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                            end
                                                            Wait(v.timeRob)
        
                                                            if v.openDoor then
                                                                TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                            end

                                                            local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                            if rDst < v.maxDst then
                                                                TriggerServerEvent("simpleRobberys:finish", token, k)
                                                            end
                                                        end)
                                                    end
                                                else
                                                    TriggerServerEvent("simpleRobberys:rob", token, k)
        
                                                    if v.alertMessage then
                                                        TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                    else
                                                        TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                    end
        
                                                    Citizen.CreateThread(function()
                                                        if v.barMessage then
                                                            TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                        else
                                                            TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                        end
                                                        Wait(v.timeRob)
                                                        
                                                        if v.animation then
                                                            if v.animationType == 'drilling' then
                                                                if v.coords then
                                                                    SetEntityCoords(PlayerPedId(), v.coords)
                                                                end
        
                                                                if v.heading then
                                                                    SetEntityHeading(PlayerPedId(), v.heading)
                                                                end
        
                                                                TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)
        
                                                                TriggerEvent("Drilling:Start", function(success)
                                                                    if success then
                                                                        ClearPedTasks(PlayerPedId())
        
                                                                        if v.openDoor then
                                                                            TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                        end

                                                                        local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                        if rDst < v.maxDst then
                                                                            TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                        end
                                                                    else
                                                                        ClearPedTasks(PlayerPedId())
        
                                                                        if v.removeItemOnLose then
                                                                            TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                        end
        
                                                                        if v.failAnimNotif then
                                                                            Extasy.ShowNotification(v.failAnimNotif)
                                                                        else
                                                                            Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                        end
                                                                    end
                                                                end)
                                                            elseif v.animationType == 'keystroke' then
                                                                if v.coords then
                                                                    SetEntityCoords(PlayerPedId(), v.coords)
                                                                end
        
                                                                if v.heading then
                                                                    SetEntityHeading(PlayerPedId(), v.heading)
                                                                end
        
                                                                Extasy.KeyStrokeAnim()
        
                                                                TriggerEvent("KeyStroke:Start", function(success)
                                                                    if success then
                                                                        --ClearPedTasks(PlayerPedId())
        
                                                                        if v.openDoor then
                                                                            TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                        end

                                                                        local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                        if rDst < v.maxDst then
                                                                            TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                        end
                                                                    else
                                                                        ClearPedTasks(PlayerPedId())
        
                                                                        if v.removeItemOnLose then
                                                                            TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                        end
            
                                                                        if v.failAnimNotif then
                                                                            Extasy.ShowNotification(v.failAnimNotif)
                                                                        else
                                                                            Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                        end
                                                                    end
                                                                end)
                                                            else
                                                                print("not others animationType setted up :(")
                                                            end
                                                        end
                                                    end)
                                                end
                                            else
                                                Extasy.ShowNotification("~r~Cette activité est réservée aux gangs officiels")
                                            end
                                        else
                                            if v.beforeAnimation then
                                                if v.animation then
                                                    if v.animationType == 'drilling' then
                                                        if v.coords then
                                                            SetEntityCoords(PlayerPedId(), v.coords)
                                                        end

                                                        if v.heading then
                                                            SetEntityHeading(PlayerPedId(), v.heading)
                                                        end

                                                        TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)

                                                        TriggerServerEvent("simpleRobberys:rob", token, k)

                                                        if v.alertMessage then
                                                            TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                        else
                                                            TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                        end

                                                        TriggerEvent("Drilling:Start", function(success)
                                                            if success then
                                                                ClearPedTasks(PlayerPedId())

                                                                if v.timeRob then
                                                                    Citizen.CreateThread(function()
                                                                        if v.barMessage then
                                                                            TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                        else
                                                                            TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                        end
                                                                        Wait(v.timeRob)
                        
                                                                        if v.openDoor then
                                                                            TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                        end

                                                                        local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                        if rDst < v.maxDst then
                                                                            TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                        end
                                                                    end)
                                                                end
                                                            else
                                                                ClearPedTasks(PlayerPedId())

                                                                if v.removeItemOnLose then
                                                                    TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                end

                                                                if v.failAnimNotif then
                                                                    Extasy.ShowNotification(v.failAnimNotif)
                                                                else
                                                                    Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                end
                                                            end
                                                        end)
                                                    elseif v.animationType == 'keystroke' then
                                                        if v.coords then
                                                            SetEntityCoords(PlayerPedId(), v.coords)
                                                        end

                                                        if v.heading then
                                                            SetEntityHeading(PlayerPedId(), v.heading)
                                                        end

                                                        Extasy.KeyStrokeAnim()

                                                        TriggerServerEvent("simpleRobberys:rob", token, k)

                                                        if v.alertMessage then
                                                            TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                        else
                                                            TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                        end

                                                        TriggerEvent("KeyStroke:Start", function(success)
                                                            if success then
                                                                ClearPedTasks(PlayerPedId())

                                                                if v.timeRob then
                                                                    Citizen.CreateThread(function()
                                                                        if v.barMessage then
                                                                            TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                                        else
                                                                            TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                                        end
                                                                        Wait(v.timeRob)
                            
                                                                        if v.openDoor then
                                                                            TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                        end

                                                                        local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                        if rDst < v.maxDst then
                                                                            TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                        end
                                                                    end)
                                                                end
                                                            else
                                                                ClearPedTasks(PlayerPedId())

                                                                if v.removeItemOnLose then
                                                                    TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                end

                                                                if v.failAnimNotif then
                                                                    Extasy.ShowNotification(v.failAnimNotif)
                                                                else
                                                                    Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                end
                                                            end
                                                        end)
                                                    else
                                                        print("not others animationType setted up :(")
                                                    end
                                                else
                                                    Citizen.CreateThread(function()
                                                        if v.barMessage then
                                                            TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                        else
                                                            TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                        end
                                                        Wait(v.timeRob)

                                                        if v.openDoor then
                                                            TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                        end

                                                        local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                        if rDst < v.maxDst then
                                                            TriggerServerEvent("simpleRobberys:finish", token, k)
                                                        end
                                                    end)
                                                end
                                            else
                                                TriggerServerEvent("simpleRobberys:rob", token, k)

                                                if v.alertMessage then
                                                    TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, v.alertMessage, 2)
                                                else
                                                    TriggerServerEvent("Jobs:handleMapAlert", token, srbb_currentCops, v.pos, "Braquage en cours", 2)
                                                end

                                                Citizen.CreateThread(function()
                                                    if v.barMessage then
                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, v.barMessage)
                                                    else
                                                        TriggerEvent("eCore:AfficherBar", v.timeRob, "⏳ Braquage en cours...")
                                                    end
                                                    Wait(v.timeRob)
                                                    
                                                    if v.animation then
                                                        if v.animationType == 'drilling' then
                                                            if v.coords then
                                                                SetEntityCoords(PlayerPedId(), v.coords)
                                                            end

                                                            if v.heading then
                                                                SetEntityHeading(PlayerPedId(), v.heading)
                                                            end

                                                            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CONST_DRILL", 0, true)

                                                            TriggerEvent("Drilling:Start", function(success)
                                                                if success then
                                                                    ClearPedTasks(PlayerPedId())

                                                                    if v.openDoor then
                                                                        TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                    end

                                                                    local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                    if rDst < v.maxDst then
                                                                        TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                    end
                                                                else
                                                                    ClearPedTasks(PlayerPedId())

                                                                    if v.removeItemOnLose then
                                                                        TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                    end

                                                                    if v.failAnimNotif then
                                                                        Extasy.ShowNotification(v.failAnimNotif)
                                                                    else
                                                                        Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                    end
                                                                end
                                                            end)
                                                        elseif v.animationType == 'keystroke' then
                                                            if v.coords then
                                                                SetEntityCoords(PlayerPedId(), v.coords)
                                                            end

                                                            if v.heading then
                                                                SetEntityHeading(PlayerPedId(), v.heading)
                                                            end

                                                            Extasy.KeyStrokeAnim()

                                                            TriggerEvent("KeyStroke:Start", function(success)
                                                                if success then
                                                                    ClearPedTasks(PlayerPedId())

                                                                    if v.openDoor then
                                                                        TriggerServerEvent('doorlock:updateState', v.doorIndex, false)
                                                                    end

                                                                    local rDst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
                                                                    if rDst < v.maxDst then
                                                                        TriggerServerEvent("simpleRobberys:finish", token, k)
                                                                    end
                                                                else
                                                                    ClearPedTasks(PlayerPedId())

                                                                    if v.removeItemOnLose then
                                                                        TriggerServerEvent("rF:RemoveItem", token, v.neededItem, 1, Extasy.FindItemIDFromInventory(v.neededItem))
                                                                    end
        
                                                                    if v.failAnimNotif then
                                                                        Extasy.ShowNotification(v.failAnimNotif)
                                                                    else
                                                                        Extasy.ShowNotification("~r~Vous avez échoué le forçage")
                                                                    end
                                                                end
                                                            end)
                                                        else
                                                            print("not others animationType setted up :(")
                                                        end
                                                    end
                                                end)
                                            end
                                        end
                                    end
                                --else
                                    --if v.cantNotif then
                                        --Extasy.ShowNotification(v.cantNotif)
                                    --else
                                        --Extasy.ShowNotification("~r~Cet endroit a déjà été braqué")
                                   --end
                                --end
                            else
                                if v.notEnoughtNotif then
                                    Extasy.ShowNotification(v.notEnoughtNotif)
                                else
                                    Extasy.ShowNotification("~r~Il n'y a pas assez de policiers pour faire cette activité")
                                end
                            end
                        end
                    else
                        -- need multiple key pressing for rob
                    end
                end
            end
        end

        if nearThing then
            Wait(0)
        else
            Wait(500)
        end
    end
end)

GlobalFunction = function(event, data)
    local options = {event = event, data = data}
    TriggerServerEvent("bankrobberies:globalEvent", options)
end

refreshCopsWhiteliste = function()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end

	for k,v in ipairs('vcpd') do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

RegisterNetEvent("simpleRobberys:sendStatus")
AddEventHandler("simpleRobberys:sendStatus", function(s)
    SRBB.canRob = s
end)