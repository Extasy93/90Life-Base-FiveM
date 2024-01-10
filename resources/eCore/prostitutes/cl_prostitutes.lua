local Extasy_prostitue = {}

Extasy_prostitue.openned = false
Extasy_prostitue.isPlayingAnimation = false
Extasy_prostitue.callback = nil
Extasy_prostitue.blips = {}

RMenu.Add('Extasy_prostitue', 'main_menu', RageUI.CreateMenu("Prostitué", "Que souhaitez-vous faire ?"))
RMenu:Get('Extasy_prostitue', 'main_menu').Closed = function()
    Extasy_prostitue.openned   = false
    ClearPedTasks(GetPlayerPed(-1))
    ClearPedTasks(Extasy_prostitue.currentEntity)
    TaskLeaveVehicle(Extasy_prostitue.currentEntity, GetVehiclePedIsUsing(GetPlayerPed(-1)), 1)
    Wait(2500)
    for k,v in pairs(cfg_prostitutesServices.points) do
        if v.entity == Extasy_prostitue.currentEntity then
            v.needShow = true
        end
    end
end

startAnimProstipute = function(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
	end)
end

Extasy_prostitue.openMenu = function()
    if Extasy_prostitue.openned then
        Extasy_prostitue.openned = false
        return
    else
        Extasy_prostitue.openned = true

        RageUI.Visible(RMenu:Get('Extasy_prostitue', 'main_menu'), true)
        CreateThread(function()
            while Extasy_prostitue.openned do
                RageUI.IsVisible(RMenu:Get('Extasy_prostitue', 'main_menu'), true, true, true, function()
                    RageUI.Button("Faire une pi*e", nil, {RightLabel = Extasy.Math.GroupDigits(cfg_prostitutesServices.prices["p**e"]).."$"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RageUI.CloseAll()
                            Extasy_prostitue.openned = false

                            ESX.TriggerServerCallback('Extasy:prostituebuy', function (hasEnoughMoneyProstitue)
                                if hasEnoughMoneyProstitue then
                                    Extasy.ShowNotification("Vous venez de donner (~r~"..cfg_prostitutesServices.prices["p**e"].."$~w~) à ~p~la prostituée")

                                    local isPlaying = false
                                    RequestAnimDict('mini@prostitutes@sexnorm_veh')
                                    while not HasAnimDictLoaded('mini@prostitutes@sexnorm_veh') do Wait(1) end
                                    RequestAnimDict('mini@prostitutes@sexnorm_veh')
                                    while not HasAnimDictLoaded('mini@prostitutes@sexnorm_veh') do Wait(1) end
                                    Wait(100)
                                    TaskPlayAnim(Extasy_prostitue.currentEntity, 'mini@prostitutes@sexnorm_veh', 'bj_loop_prostitute', 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
                                    TaskPlayAnim(GetPlayerPed(-1), 'mini@prostitutes@sexnorm_veh', 'bj_loop_male', 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
                                    Extasy_prostitue.WhilePlayingAnimation()
                                else
                                    Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent")
                                end
                            end)
                        end
                    end)

                    RageUI.Button("Ba*ser", nil, {RightLabel = Extasy.Math.GroupDigits(cfg_prostitutesServices.prices["b**ser"]).."$"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RageUI.CloseAll()
                            Extasy_prostitue.openned = false
                            ESX.TriggerServerCallback('Extasy:prostituebuy2', function (hasEnoughMoneyProstitue)
                                if hasEnoughMoneyProstitue then
                                    Extasy.ShowNotification("Vous venez de donner (~r~"..cfg_prostitutesServices.prices["b**ser"].."$~w~) à ~p~la prostituée")

                                    local isPlaying = false
                                    RequestAnimDict('mini@prostitutes@sexnorm_veh')
                                    while not HasAnimDictLoaded('mini@prostitutes@sexnorm_veh') do Wait(1) end
                                    RequestAnimDict('mini@prostitutes@sexnorm_veh')
                                    while not HasAnimDictLoaded('mini@prostitutes@sexnorm_veh') do Wait(1) end
                                    Wait(100)
                                    TaskPlayAnim(Extasy_prostitue.currentEntity, 'mini@prostitutes@sexnorm_veh', 'sex_loop_prostitute', 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
                                    TaskPlayAnim(GetPlayerPed(-1), 'mini@prostitutes@sexnorm_veh', 'sex_loop_male', 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
                                    Extasy_prostitue.WhilePlayingAnimation()
                                else
                                    Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent")
                                end
                            end)
                        end
                    end)
                end, function()
                end)
                Wait(1)
            end
        end)
    end
end

CreateThread(function()
    while true do
        local pPed      = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(pPed)

        for _,v in pairs(cfg_prostitutesServices.points) do
            local dst = GetDistanceBetweenCoords(v.pos, pedCoords, true)

            if not v.spawned then
                if dst <= v.load_dst then
                    if v.needShow then
                        v.spawned = true

                        Extasy.LoadModel(v.hash)
                        v.entity = CreatePed(1, v.hash, v.pos.x, v.pos.y, v.pos.z - 1.0, v.heading, 0, 0)
                        FreezeEntityPosition(v.entity, true)

                        if v.anim then
                            if v.animType == 'TaskPlayAnim' then
                                RequestAnimDict(v.animData.dict)
                                while not HasAnimDictLoaded(v.animData.dict) do Wait(1) end

                                Wait(100)	
                                TaskPlayAnim(v.entity, v.animData.dict, v.animData.name, v.animData.blendIn, v.animData.blendOut, v.animData.duration, v.animData.flag, v.animData.playback, v.animData.lockX, v.animData.lockY, v.animData.lockZ)
                            elseif v.animType == 'TaskStartScenarioInPlace' then
                                TaskStartScenarioInPlace(v.entity, v.animData.name, 0, true)
                            end
                        end
                    end
                end
            else
                if dst > v.load_dst then
                    if v.needShow then
                        if DoesEntityExist(v.entity) then
                            v.spawned = false
                            DeleteEntity(v.entity)
                        end
                    end
                end
            end
        end
        Wait(2500)
    end
end)

CreateThread(function()
    while true do
        local w       = 2000
        local pPed    = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)

        for k,v in pairs(cfg_prostitutesServices.points) do
            local dst = GetDistanceBetweenCoords(v.pos, pCoords, true)

            if dst < 5.0 then
                if v.needShow then
                    w = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour interagir avec ~p~la prostituée")

                    if IsControlJustPressed(0, 38) then
                        if IsVehicleSeatFree(GetVehiclePedIsUsing(pPed), 0) then
                            v.needShow = false
                            FreezeEntityPosition(v.entity, false)
                            TaskEnterVehicle(v.entity, GetVehiclePedIsUsing(pPed), 1.0, 0, 1.0, 1, 0)
                            Extasy_prostitue.currentEntity = v.entity
                            Extasy_prostitue.StartHookSystem()
                        else
                            Extasy.ShowNotification("~r~La place passager n'est pas disponible pour la prostituée")
                        end
                    end
                end
            end
        end
        Wait(w)
    end
end)

CreateThread(function()
    while true do
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)

        for k,v in pairs(cfg_prostitutesServices.points) do
            local dst = GetDistanceBetweenCoords(pCoords, v.pos, false)

            if dst < 150.0 then
                if not DoesBlipExist(Extasy_prostitue.blips[k]) then
                    AddTextEntry('PROSTITUTE_BLIP'..k, "Prostituée")

                    Extasy_prostitue.blips[k] = AddBlipForCoord(v.pos)
                    SetBlipSprite(Extasy_prostitue.blips[k], 280)
                    SetBlipDisplay(Extasy_prostitue.blips[k], 4)
                    SetBlipScale(Extasy_prostitue.blips[k], 0.45)
                    SetBlipColour(Extasy_prostitue.blips[k], v.color)
                    SetBlipAsShortRange(Extasy_prostitue.blips[k], true)

                    BeginTextCommandSetBlipName('PROSTITUTE_BLIP'..k)
                    EndTextCommandSetBlipName(Extasy_prostitue.blips[k])
                end
            else
                RemoveBlip(Extasy_prostitue.blips[k])
            end
        end
        Wait(750)
    end
end)

Extasy_prostitue.StartHookSystem = function()
    local n = 0

    CreateThread(function()
        while n < cfg_prostitutesServices.timeBeforeStart do
            n = n + 1
            Wait(1000)
        end
    end)

    CreateThread(function()
        while n < cfg_prostitutesServices.timeBeforeStart do
            ESX.ShowHelpNotification("Dirigez-vous vers un endroit plus calme...")
            Wait(0)
        end
        Extasy_prostitue.openMenu()
    end)
end

Extasy_prostitue.WhilePlayingAnimation = function()
    Extasy_prostitue.isPlayingAnimation = true
    while Extasy_prostitue.isPlayingAnimation do
        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CELLPHONE_CANCEL~ pour arrêter l'animation")

        if IsControlJustPressed(0, 177) then
            ClearPedTasks(GetPlayerPed(-1))
            ClearPedTasks(Extasy_prostitue.currentEntity)
            break
        end
        Wait(0)
    end

    TaskLeaveVehicle(Extasy_prostitue.currentEntity, GetVehiclePedIsUsing(GetPlayerPed(-1)), 1)
    Wait(2500)
    for k,v in pairs(cfg_prostitutesServices.points) do
        if v.entity == Extasy_prostitue.currentEntity then
            v.needShow = true
        end
    end
end