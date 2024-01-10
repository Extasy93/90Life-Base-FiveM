local place = 0
local started = false
local grade = 0.5
local disabledControl = 0
local bestPlayers = {}
local showLeaderboard = true
local askedData = false
local armsBlips = {}
local MyData = {}
    
Citizen.CreateThread(function()
    while true do
        Wait(2000)
        for i, modelConfig in pairs(cfg_armWrestling.props) do
            if Vdist(GetEntityCoords(PlayerPedId()), modelConfig.pos) < 50 then
                thisTable = GetClosestObjectOfType(modelConfig.pos, 1.5, GetHashKey(modelConfig.model), 0, 0, 0)
                if DoesEntityExist(thisTable) then
                    SetEntityHeading(thisTable)
                    PlaceObjectOnGroundProperly(thisTable)
                else
                    thisTable = CreateObject(GetHashKey(modelConfig.model), modelConfig.pos, false, false, false)
                    SetEntityHeading(thisTable)
                    PlaceObjectOnGroundProperly(thisTable)
                end
            elseif Vdist(GetEntityCoords(PlayerPedId()), modelConfig.pos) >= 50 then
                thisTable = GetClosestObjectOfType(modelConfig.pos, 1.5, GetHashKey(modelConfig.model), 0, 0, 0)
                if DoesEntityExist(thisTable) then
                    DeleteEntity(thisTable)
                end
            end
        end		
    end
end)
    
Citizen.CreateThread(function()
    while true do
        local nearThing = false

        for k,v in pairs(cfg_armWrestling.props) do
            local dst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)

            if dst < 5.0 then
                nearThing = true
            end
        end

        if IsControlJustPressed(0, 38) and place == 0 then
            for i, modelConfig in pairs(cfg_armWrestling.props) do
                local table = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.5, GetHashKey(modelConfig.model), 0, 0, 0)
                if DoesEntityExist(table) then
                    local position = GetEntityCoords(PlayerPedId())
                    TriggerServerEvent('armWrestling:check_sv', token, position)
                    break
                end
            end
        end
    
        if disabledControl == 1 then
            DisableControlAction(2, 71, true)
            DisableControlAction(2, 72, true)
            DisableControlAction(2, 63, true)
            DisableControlAction(2, 64, true)
            DisableControlAction(2, 75, true)
            DisableControlAction(2, 32, true)
            DisableControlAction(2, 33, true)
            DisableControlAction(2, 34, true)
            DisableControlAction(2, 35, true)
            DisableControlAction(2, 37, true)
            DisableControlAction(2, 23, true)
            DisableControlAction(2, 246, true)
        elseif disabledControl == 2 then
            DisableControlAction(2, 71, true)
            DisableControlAction(2, 72, true)
            DisableControlAction(2, 63, true)
            DisableControlAction(2, 64, true)
            DisableControlAction(2, 75, true)
            DisableControlAction(2, 73, true)
            DisableControlAction(2, 32, true)
            DisableControlAction(2, 33, true)
            DisableControlAction(2, 34, true)
            DisableControlAction(2, 35, true)
            DisableControlAction(2, 37, true)
            DisableControlAction(2, 23, true)
            DisableControlAction(2, 38, true)
            DisableControlAction(2, 246, true)
        end

        if nearThing then
            Wait(0)
        else
            Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do

        local nearThing = false

        for k,l in pairs(cfg_armWrestling.props) do
            local dst = GetDistanceBetweenCoords(l.pos, GetEntityCoords(PlayerPedId()), false)

            if dst < 5.0 then
                nearThing = true

                if showLeaderboard then
                    Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + 2.39), "~s~[G] pour cacher le classement", 0.75)
                    Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + 2.35), "~p~Classement Bras de fer~s~", 1.75)

                    local zOffset = 0
                    zOffset = 0.230*9
                    for k,v in pairs(bestPlayers) do
                        if k == 1 then
                            Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~y~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.wins.." victoires ~s~/~o~ "..v.games.." parties~s~", 1.0)
                        elseif k == 2 then
                            Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~r~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.wins.." victoires ~s~/~o~ "..v.games.." parties~s~", 1.0)
                        elseif k == 3 then
                            Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~w~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.wins.." victoires ~s~/~o~ "..v.games.." parties~s~", 1.0)
                        elseif k == 4 then
                            Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.wins.." victoires ~s~/~o~ "..v.games.." parties~s~", 1.0)
                        elseif k == 5 then
                            Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.wins.." victoires ~s~/~o~ "..v.games.." parties~s~", 1.0)
                        elseif k == 6 then
                            Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.wins.." victoires ~s~/~o~ "..v.games.." parties~s~", 1.0)
                        elseif k == 7 then
                            Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.wins.." victoires ~s~/~o~ "..v.games.." parties~s~", 1.0)
                        elseif k == 8 then
                            Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.wins.." victoires ~s~/~o~ "..v.games.." parties~s~", 1.0)
                        end

                        --for k,v in pairs(MyData) do
                            --Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "Votre score: ~g~"..v.firstname.." "..v.lastname.."~s~ - "..v.wins.." victoires ~s~/ "..v.games.." parties~s~", 1.0)
                        --end
                        zOffset = zOffset - 0.150
                    end
                end
            end

            if dst < 1.5 and place == 0 then
                Extasy.ShowHelpNotification("Appuyez sur ~p~~INPUT_TALK~ ~w~pour interagir avec ~p~la table de bras de fer")
            end
        end

        if IsControlJustPressed(0, 47) then
            showLeaderboard = not showLeaderboard
        end

        if nearThing then
            Wait(0)
        else
            Wait(3000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(5000)
        for k,v in pairs(cfg_armWrestling.props) do
            local dst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)

            if dst < 5.0 then
                if not askedData then
                    TriggerServerEvent("armWrestling:getLeaderboard", token)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
        for k,v in pairs(cfg_armWrestling.props) do
            local dst = GetDistanceBetweenCoords(pCoords, v.pos, false)

            if dst < 150.0 then
                if not DoesBlipExist(armsBlips[k]) then
                    AddTextEntry('ARMWRESTLING_BLIP_'..k, "Table de bras de fer")

                    armsBlips[k] = AddBlipForCoord(v.pos)
                    SetBlipSprite(armsBlips[k], 311)
                    SetBlipDisplay(armsBlips[k], 4)
                    SetBlipScale(armsBlips[k], 0.50)
                    SetBlipColour(armsBlips[k], 6)
                    SetBlipAsShortRange(armsBlips[k], true)

                    BeginTextCommandSetBlipName('ARMWRESTLING_BLIP_'..k)
                    EndTextCommandSetBlipName(armsBlips[k])
                end
            else
                RemoveBlip(armsBlips[k])
            end
        end
        Citizen.Wait(750)
    end
end)

timer = function()
    PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
    local T = GetGameTimer()
    while GetGameTimer() - T < 1000 do
        Wait(0)
        Draw2DText(0.5, 0.4, ("~s~3"), 3.0)
    end
    PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
    local T = GetGameTimer()
    while GetGameTimer() - T < 1000 do
        Wait(0)
        Draw2DText(0.5, 0.4, ("~s~2"), 3.0)
    end
    PlaySoundFrontend(-1, "Out_Of_Area", "DLC_Lowrider_Relay_Race_Sounds", 0)
    local T = GetGameTimer()
    while GetGameTimer() - T < 1000 do
        Wait(0)
        Draw2DText(0.5, 0.4, ("~s~1"), 3.0)
    end
    PlaySoundFrontend(-1, "CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", 0)
    
    local T = GetGameTimer()
    while GetGameTimer() - T < 1000 do
        Wait(0)
        Draw2DText(0.4, 0.4, ("~s~GO ~w~!"), 3.0)
    end
    showLeaderboard = false
end
    
checkFunction = function()
    for i, modelConfig in pairs(cfg_armWrestling.props) do
        local table = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.5, GetHashKey(modelConfig.model), 0, 0, 0)
        if DoesEntityExist(table) then
            local position = GetEntityCoords(PlayerPedId())
            TriggerServerEvent('armWrestling:check_sv', token, position)
            break
        end
    end
end

RegisterNetEvent("armWrestling:sendLeaderboard")
AddEventHandler("armWrestling:sendLeaderboard", function(data, MyArmData)
    bestPlayers = data
    --MyData = MyArmData
end)

RegisterNetEvent('armWrestling:updategrade_cl')
AddEventHandler('armWrestling:updategrade_cl', function(gradeUpValue)
    grade = gradeUpValue
end)
    
RegisterNetEvent('armWrestling:start_cl')
AddEventHandler('armWrestling:start_cl', function()
    started = true
    if place == 1 then
        disabledControl = 2
        timer()
    
        PlayAnim(PlayerPedId(), "mini@arm_wrestling", "sweep_a", 1)
        SetEntityAnimSpeed(PlayerPedId(), "mini@arm_wrestling", "sweep_a", 0.0)
        SetEntityAnimCurrentTime(PlayerPedId(), "mini@arm_wrestling", "sweep_a", grade)
        PlayFacialAnim(PlayerPedId(), "electrocuted_1", "facials@gen_male@base")
        disabledControl = 1
    
        while grade >= 0.10 and grade <= 0.90 do
            Wait(0)
            PlayFacialAnim(PlayerPedId(), "electrocuted_1", "facials@gen_male@base")
            Extasy.ShowHelpNotification("~y~Partie en cours...~s~\nPour jouer appuyez rapidement sur ~INPUT_JUMP~")
            SetEntityAnimSpeed(PlayerPedId(), "mini@arm_wrestling", "sweep_a", 0.0)
            SetEntityAnimCurrentTime(PlayerPedId(), "mini@arm_wrestling", "sweep_a", grade)

            if IsControlPressed(0, 22) then
                TriggerServerEvent('armWrestling:updategrade_sv', token, 0.015) 
                SetEntityAnimCurrentTime(PlayerPedId(), "mini@arm_wrestling", "sweep_a", grade)

                while IsControlPressed(0, 22) do
                    Wait(0)
                    Extasy.ShowHelpNotification("~y~Partie en cours...~s~\nPour jouer appuyez rapidement sur ~INPUT_JUMP~")
                    SetEntityAnimCurrentTime(PlayerPedId(), "mini@arm_wrestling", "sweep_a", grade)
                end
            end
        end
    
        if grade >= 0.90 then
            PlayAnim(PlayerPedId(), "mini@arm_wrestling", "win_a_ped_a", 2)
            TriggerServerEvent("armWrestling:won", token)
            Extasy.ShowNotification("~g~Vous avez gagné la partie de bras de fer !")
        elseif grade <= 0.10 then
            PlayAnim(PlayerPedId(), "mini@arm_wrestling", "win_a_ped_b", 2)
            TriggerServerEvent("armWrestling:lose", token)
            Extasy.ShowNotification("~r~Vous avez perdu la partie de bras de fer !")
        end

        showLeaderboard = true

        Wait(4000)
        TriggerServerEvent('armWrestling:disband_sv', token, GetEntityCoords(PlayerPedId()))
        return
    elseif place == 2 then
    
        disabledControl = 2
        timer()
    
        PlayAnim(PlayerPedId(), "mini@arm_wrestling", "sweep_b", 1)
        SetEntityAnimSpeed(PlayerPedId(), "mini@arm_wrestling", "sweep_b", 0.0)
        SetEntityAnimCurrentTime(PlayerPedId(), "mini@arm_wrestling", "sweep_b", grade)
        PlayFacialAnim(PlayerPedId(), "electrocuted_1", "facials@gen_male@base")
        disabledControl = 1
    
        while grade >= 0.10 and grade <= 0.90 do
            Wait(0)
            PlayFacialAnim(PlayerPedId(), "electrocuted_1", "facials@gen_male@base")
            Extasy.ShowHelpNotification("~y~Partie en cours...~s~\nPour jouer appuyez rapidement sur ~INPUT_JUMP~")
            SetEntityAnimSpeed(PlayerPedId(), "mini@arm_wrestling", "sweep_b", 0.0)
            SetEntityAnimCurrentTime(PlayerPedId(), "mini@arm_wrestling", "sweep_b", grade)

            if IsControlPressed(0, 22) then
                TriggerServerEvent('armWrestling:updategrade_sv', token, -0.015) 
                SetEntityAnimCurrentTime(PlayerPedId(), "mini@arm_wrestling", "sweep_b", grade)

                while IsControlPressed(0, 22) do
                    Wait(0)
                    Extasy.ShowHelpNotification("~y~Partie en cours...~s~\nPour jouer appuyez rapidement sur ~INPUT_JUMP~")
                    SetEntityAnimCurrentTime(PlayerPedId(), "mini@arm_wrestling", "sweep_b", grade)
                end
            end
        end
    
        if grade <= 0.10 then
            PlayAnim(PlayerPedId(), "mini@arm_wrestling", "win_a_ped_a", 2)
            TriggerServerEvent("armWrestling:won", token)
            Extasy.ShowNotification("~g~Vous avez gagné la partie de bras de fer !")
        elseif grade >= 0.90 then
            PlayAnim(PlayerPedId(), "mini@arm_wrestling", "win_a_ped_b", 2)
            TriggerServerEvent("armWrestling:lose", token)
            Extasy.ShowNotification("~r~Vous avez perdu la partie de bras de fer !")
        end

        showLeaderboard = true

        Wait(4000)
        TriggerServerEvent('armWrestling:disband_sv', token, GetEntityCoords(PlayerPedId()))
        return
    end
end)
    
RegisterNetEvent('armWrestling:check_cl')
AddEventHandler('armWrestling:check_cl', function(args)
    local table = 0
    if args == 'place1' then
        place = 1
        for i, modelConfig in pairs(cfg_armWrestling.props) do
            table = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.5, GetHashKey(modelConfig.model), 0, 0, 0)
            if DoesEntityExist(table) then
                break
            end
        end

        disabledControl = 2
        showLeaderboard = false

        SetEntityNoCollisionEntity(PlayerPedId(), table, false)
        SetEntityHeading(PlayerPedId(), GetEntityHeading(table))
        Wait(100)
        SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(table, -0.20, 0.0, 0.0).x, GetOffsetFromEntityInWorldCoords(table, 0.0, -0.65, 0.0).y, GetEntityCoords(PlayerPedId()).z-1)
        FreezeEntityPosition(PlayerPedId(), true)
        PlayAnim(PlayerPedId(), "mini@arm_wrestling","aw_ig_intro_alt1_a", 2)
        while (GetEntityAnimCurrentTime(PlayerPedId(), "mini@arm_wrestling", "aw_ig_intro_alt1_a") < 0.95) do
            Wait(0)
        end
        PlayAnim(PlayerPedId(), "mini@arm_wrestling", "nuetral_idle_a", 1)
        disabledControl = 1
    
        while not started do
            Wait(0)

            Extasy.ShowHelpNotification("Attente d'un adversaire...\nAppuyez sur ~INPUT_VEH_DUCK~ pour ~r~annnuler votre participation")

            if IsControlPressed(2, 73) or IsPedRagdoll(PlayerPedId()) or IsControlPressed(2, 200) or IsControlPressed(2, 214) then
                SetEntityNoCollisionEntity(PlayerPedId(), table, true)
                TriggerServerEvent('armWrestling:disband_sv', token, GetEntityCoords(PlayerPedId()))
                showLeaderboard = true
                return
            end
        end
    elseif args == 'place2' then
        place = 2
        for i, modelConfig in pairs(cfg_armWrestling.props) do
            table = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.5, GetHashKey(modelConfig.model), 0, 0, 0)
            if DoesEntityExist(table) then
                break
            end
        end

        disabledControl = 2
        showLeaderboard = false
    
        SetEntityNoCollisionEntity(PlayerPedId(), table, false)
        SetEntityHeading(PlayerPedId(), GetEntityHeading(table)-180)
        Wait(100)
        SetEntityCoords(PlayerPedId(), GetOffsetFromEntityInWorldCoords(table, 0.0, 0.0, 0.0).x, GetOffsetFromEntityInWorldCoords(table, 0.0, 0.50, 0.0).y, GetEntityCoords(PlayerPedId()).z-1)
        
        FreezeEntityPosition(PlayerPedId(), true)
        PlayAnim(PlayerPedId(), "mini@arm_wrestling","aw_ig_intro_alt1_b", 2)
        while ( GetEntityAnimCurrentTime(PlayerPedId(), "mini@arm_wrestling", "aw_ig_intro_alt1_b") < 0.95 ) do
            Wait(0)
        end
        PlayAnim(PlayerPedId(), "mini@arm_wrestling", "nuetral_idle_b", 1)
        disabledControl = 1
        
        while not started do
            Wait(0)
            
            Extasy.ShowHelpNotification("Attente d'un adversaire...\nAppuyez sur ~INPUT_VEH_DUCK~ ~r~pour annnuler votre participation")

            if IsControlPressed(2, 73) or IsPedRagdoll(PlayerPedId()) or IsControlPressed(2, 200) or IsControlPressed(2, 214) then
                SetEntityNoCollisionEntity(PlayerPedId(), table, true)
                TriggerServerEvent('armWrestling:disband_sv', token, GetEntityCoords(PlayerPedId()))
                return
            end
        end
    elseif args == 'noplace' then
        Extasy.ShowNotification("~r~Un bras de fer est déjà en cours sur cette table")
    end
end)
    
RegisterNetEvent('armWrestling:reset_cl')
AddEventHandler('armWrestling:reset_cl', function()
    for i, modelConfig in pairs(cfg_armWrestling.props) do
        local tableId = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 1.5, GetHashKey(modelConfig.model), 0, 0, 0)
        if DoesEntityExist(tableId) then
            SetEntityNoCollisionEntity(PlayerPedId(), tableId, true)
            break
        end
    end
    ClearPedTasks(PlayerPedId())
    place = 0
    started = false
    grade = 0.5
    disabledControl = 0
    FreezeEntityPosition(PlayerPedId(), false)
end)

PlayAnim = function(ped, dict, name, flag)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
      Citizen.Wait(0)
    end
    TaskPlayAnim(ped, dict, name, 1.5, 1.5, -1, flag, 0.0, false, false, false)
end

Draw2DText = function(x, y, text, scale)
    SetTextFont(4)
    SetTextProportional(7)
    SetTextScale(scale, scale)
    SetTextColour( 198, 25, 66, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end