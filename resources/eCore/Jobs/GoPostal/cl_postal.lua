local delivery_open = false
local inJob = false
local haveClothes = false
local PlayerData = nil
local inAnim = false
local entity = nil
local haveBox = false
local getBox = false
local vehicle, vehicle2 = nil, nil
local gotoPoint = false
local comeBack = false
local dest_blip, blipStatus
local data = {}

RMenu.Add('delivery', 'main_menu', RageUI.CreateMenu("Post OP", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('delivery', 'main_menu_action', RageUI.CreateMenu("Post OP", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('delivery', 'main_menu').Closed = function()
    delivery_open = false
end

openGopostal_m = function()
    if delivery_open then
        delivery_open = false
        return
    else
        delivery_open = true
        Citizen.CreateThread(function()
            while delivery_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('delivery', 'main_menu'), true, true, true, function()

                    if haveClothes then 
                        if not inJob then
                            RageUI.Button("Commencer une livraison", nil, {RightLabel = ""}, true, function(h, a, s)
                                if s then
                                    goPostalStartJob()
                                end
                            end)
                        else
                            RageUI.Button("~r~Finir une livraison", nil, {RightLabel = ""}, true, function(h, a, s)
                                if s then
                                    goPostalStopJob()
                                end
                            end)
                        end
                    else
                        RageUI.Button("Commencer une livraison", "Vous n'avez pas pris votre tenue de travail", {RightBadge = RageUI.BadgeStyle.Lock}, true, function(h, a, s)
                            if s then
                            end
                        end)
                    end

                    if not haveClothes then
                        RageUI.Button("S'équiper de la tenue Post OP", nil, {RightLabel = "👔"}, true, function(h, a, s)
                            if s then              
                                ExecuteCommand("e me")
                                Wait(1400)
                                GoPostalGetClothes()
                                haveClothes = true
                            end
                        end)
                    else
                        RageUI.Button("~r~Rendre la tenue Post OP", nil, {RightLabel = "👔"}, true, function(h, a, s)
                            if s then              
                                ExecuteCommand("e me")
                                TriggerEvent("eCore:AfficherBar", 1400, "⏳ Changement en cours...")
                                Wait(1400)
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                end)
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                end)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                haveClothes = false
                            end
                        end)
                    end
                end, function()
                end)
            end
        end)
    end
end

openGopostal = function()
    RageUI.Visible(RMenu:Get('delivery', 'main_menu'), true)
    openGopostal_m()
end

goPostalfloatingText = function(msg, coords)
	AddTextEntry('FloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('FloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

goPostalSetBlipRoutes = function(x, y, z, sprite, colour)
    dest_blip, blipStatus = AddBlipForCoord(x, y, z), nil
    SetBlipSprite(dest_blip, sprite)
    SetBlipDisplay(dest_blip, 4)
    SetBlipScale(dest_blip, 0.70)
    SetBlipColour(dest_blip, colour)
    SetBlipRoute(dest_blip, true)
    SetBlipAsShortRange(garbageHQBlip, false)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Destination")
    EndTextCommandSetBlipName(dest_blip)

    blipStatus = true

    CreateThread(function()
        while true do
            local distance = Vdist(x, y, z, GetEntityCoords(PlayerPedId()))
            if blipStatus == 'delete' then
                RemoveBlip(dest_blip)
                break
            end
            Wait(1000)
        end
    end)
end

goPostalGetBox = function()
    CreateThread(function()
        while not haveBox and inJob do
            goPostalfloatingText("Appuyez sur ~p~[E]~s~ pour prendre le colis", vec3(cfg_goPostal.props['x'], cfg_goPostal.props['y'], cfg_goPostal.props['z'] + 1.0))
            if Vdist(GetEntityCoords(PlayerPedId()), GetEntityCoords(entity)) < 2 then
                if IsControlJustPressed(0, 38) then
                    haveBox = true
                    Wait(200)
                    ClearPedTasksImmediately(PlayerPedId())
                    CreateThread(function()
                        while haveBox == true and inJob == true do
                            Wait(2000)
                            TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
                            AttachEntityToEntity(entity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
                        end
                    end)
                    goPostalPutBoxInVehicle()
                end
            end
            Wait(0)
        end
    end)
end

goPostalPutBoxInVehicle = function()
    Extasy.ShowNotification("Mettez le colis dans le coffre du véhicule de livraison!")
    CreateThread(function()
        while haveBox and inJob do
            local dist = Vdist(GetEntityCoords(vehicle), GetEntityCoords(PlayerPedId()))
                if dist < 4 then
                    goPostalfloatingText("Appuyez sur ~p~[E]~s~ pour mettre le colis dans le coffre du véhicule de livraison", GetEntityCoords(PlayerPedId()))
                    if IsControlJustPressed(0, 38) then
                        DeleteObject(entity)
                        SetVehicleDoorsShut(vehicle, false)
                        ClearPedTasksImmediately(PlayerPedId())
                        haveBox = false
                        gotoPoint = true
                        goPostalGoToPointAndDelivery()
                    end
                end
            Wait(0)
        end
    end)
end

goPostalGetClosestVehicle = function()
    CreateThread(function()
        Wait(1000)
        while gotoPoint and inJob and not getBox do
            local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
            vehicle2 = ESX.Game.GetClosestVehicle(vec3(px, py, pz))
            Wait(2000)
        end
    end)
end

goPostalGoToPointAndDelivery = function()
    if not HasAnimDictLoaded("anim@heists@box_carry@") then
		RequestAnimDict("anim@heists@box_carry@") 
		while not HasAnimDictLoaded("anim@heists@box_carry@") do 
			Citizen.Wait(0)
		end
	end

    if not HasModelLoaded(cfg_goPostal.props['Model']) then
        RequestModel(cfg_goPostal.props['Model'])
        while not HasModelLoaded(cfg_goPostal.props['Model']) do
            Citizen.Wait(0)
        end
    end

    local dest = math.random(1, #cfg_goPostal.destinations)
    goPostalSetBlipRoutes(cfg_goPostal.destinations[dest]['x'], cfg_goPostal.destinations[dest]['y'], cfg_goPostal.destinations[dest]['z'], 1, 27)
    Extasy.ShowNotification("Rendez-vous au point marqué sur votre ~g~GPS !")
    goPostalGetClosestVehicle()
    getBox = false
    CreateThread(function()
        Wait(5000)
        while gotoPoint and inJob do
            local msec = 1000
            local dist = Vdist(vec3(cfg_goPostal.destinations[dest]['x'], cfg_goPostal.destinations[dest]['y'], cfg_goPostal.destinations[dest]['z']), GetEntityCoords(PlayerPedId()))
            local isInVeh = IsPedInVehicle(PlayerPedId(), vehicle2)

            if not getBox then
                msec = 500
                local door = GetEntryPositionOfDoor(vehicle2, 3)
                local dist2 = Vdist(door, GetEntityCoords(PlayerPedId()))
                if dist2 < 1 and not getBox then
                    msec = 0
                    goPostalfloatingText("Appuyez sur ~p~[E]~s~ pour prendre le colis", GetEntityCoords(PlayerPedId()))
                    if IsControlJustPressed(0, 38) then
                        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                        SetVehicleDoorOpen(vehicle2, 3, false, true)
                        Wait(250)
                        SetVehicleDoorOpen(vehicle2, 2, false, true)
                        Wait(5000)
                        ClearPedTasks(PlayerPedId())
                        Wait(2500)
                        entity = CreateObject(cfg_goPostal.props['Model'], GetEntityCoords(PlayerPedId()), true, false, false)
                        Wait(150)
                        SetVehicleDoorsShut(vehicle2, false)
                        ClearPedTasksImmediately(PlayerPedId())
                        Wait(750)
                        TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
                        AttachEntityToEntity(entity, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
                        getBox = true
                    end
                end
            else
                if dist < 8 then
                    msec = 0
                    DrawMarker(6, cfg_goPostal.destinations[dest]['x'], cfg_goPostal.destinations[dest]['y'], cfg_goPostal.destinations[dest]['z'] - 0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 0.8, 0.8, 0.8, 84, 3, 159, 155)
                    if dist < 1.25 then
                        goPostalfloatingText("Appuyez sur ~p~[E]~s~ pour déposer le colis sur le sol", vec3(cfg_goPostal.destinations[dest]['x'], cfg_goPostal.destinations[dest]['y'], cfg_goPostal.destinations[dest]['z']))
                        if IsControlJustPressed(0, 38) then
                            ClearPedTasksImmediately(PlayerPedId())
                            DeleteObject(entity)
                            Wait(500)
                            blipStatus = 'delete'
                            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                            Wait(5000)
                            ClearPedTasks(PlayerPedId())
                            Wait(2500)
                            entity = CreateObject(cfg_goPostal.props['Model'], vec3(cfg_goPostal.destinations[dest]['x'], cfg_goPostal.destinations[dest]['y'], cfg_goPostal.destinations[dest]['z'] - 1.0), true, false, false)
                            gotoPoint = false
                            comeBack = true
                            Extasy.ShowNotification("Revenez à l'entrepôt !")
                            goPostalComeBack()
                        end
                    end
                end
            end
            Wait(msec)
        end
    end)
end

goPostalComeBack = function()
    goPostalSetBlipRoutes(cfg_goPostal.vehicles['Deleter']['x'], cfg_goPostal.vehicles['Deleter']['y'], cfg_goPostal.vehicles['Deleter']['z'], 1, 27)
    CreateThread(function()
        while comeBack do
            local msec = 1000
            local dist = Vdist(GetEntityCoords(PlayerPedId()), cfg_goPostal.vehicles['Deleter'])

            if dist > 60 and dist < 80 then
                DeleteObject(entity)
            end

            if dist < 15 then
                msec = 0
                DrawMarker(6, cfg_goPostal.vehicles['Deleter'], 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 5, 5, 5, 255, 0, 0, 155)
                if dist < 5 then
                    msec = 0
                    goPostalfloatingText("Appuyez sur ~r~[E]~s~ pour ranger le véhicule", GetEntityCoords(GetVehiclePedIsIn(PlayerPedId())))
                    if IsControlJustPressed(0, 38) then
                        local v = GetVehiclePedIsIn(PlayerPedId())
                        TaskLeaveVehicle(PlayerPedId(), v)
                        Wait(2500)
                        NetworkFadeOutEntity(v, true, false)
                        Wait(2000)
                        DeleteVehicle(v)
                        DeleteObject(entity)
                        GoPostalPay()
                        blipStatus = 'delete'
                        comeBack = false
                        inJob = false
                    end
                end
            end
            Wait(msec)
        end
    end)
end

GoPostalPay = function()
    TriggerServerEvent('goPostal:pay', token, extasy_core_cfg["gopostal_sell_price"])
end

GoPostalGetClothes = function()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['bags_1'] = 0, ['bags_2'] = 0,
                ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                ['torso_1'] = 88, ['torso_2'] = 0,
                ['arms'] = 11,
                ['pants_1'] = 13, ['pants_2'] = 0,
                ['shoes_1'] = 10, ['shoes_2'] = 2,
                ['mask_1'] = 0, ['mask_2'] = 0,
                ['bproof_1'] = 0,
                ['helmet_1'] = -1, ['helmet_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 9,   ['torso_2'] = 1,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 0,
                ['pants_1'] = 6,   ['pants_2'] = 0,
                ['shoes_1'] = 65,   ['shoes_2'] = 0,
                ['helmet_1'] = -1,  ['helmet_2'] = 0,
                ['chain_1'] = -1,    ['chain_2'] = 0,
                ['mask_1'] = -1,  	['mask_2'] = 0,
                ['bproof_1'] = 0,  	['bproof_2'] = 0,
                ['ears_1'] = -1,     ['ears_2'] = 0,
                ['bags_1'] = 0,    ['bags_2'] = 0,
                ['glasses_1'] = 5,    ['glasses_2'] = 0
            }
        end
    TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end

goPostalStopJob = function()
    inJob = false
    haveBox = false
    blipStatus = 'delete'
    inAnim = false
    ClearPedTasksImmediately(PlayerPedId())
    DeleteObject(entity)
    DeleteVehicle(vehicle)
end

goPostalStartJob = function()
    local random = math.random(1, #cfg_goPostal.vehicles['Cars'])
    local bone = 4089

    if not HasAnimDictLoaded("anim@heists@box_carry@") then
		RequestAnimDict("anim@heists@box_carry@") 
		while not HasAnimDictLoaded("anim@heists@box_carry@") do 
			Wait(0)
		end
	end

    if not HasModelLoaded(cfg_goPostal.props['Model']) then
        RequestModel(cfg_goPostal.props['Model'])
        while not HasModelLoaded(cfg_goPostal.props['Model']) do
            Wait(0)
        end
    end

    for k, v in pairs(cfg_goPostal.vehicles['Spawner']['coords']) do
        local vehicles = ESX.Game.GetVehiclesInArea(v, 2)

        if #vehicles == 0 then
            ESX.Game.SpawnVehicle(cfg_goPostal.vehicles['Cars'][random], v, cfg_goPostal.vehicles['Spawner']['rotation'], function(veh)
                vehicle = veh
                SetVehicleNumberPlateText(veh, cfg_goPostal.vehicles['Plate'])
                SetVehicleDoorOpen(veh, 3, false, false)
                SetVehicleDoorOpen(veh, 2, false, false)
            end)
            inJob = true
            inAnim = true
        else
            inAnim = false
            Extasy.ShowNotification("~r~Il n'y a pas de place pour sortir votre véhicule !")
        end

        if inAnim then
            entity = CreateObject(cfg_goPostal.props['Model'], cfg_goPostal.props['x'], cfg_goPostal.props['y'], cfg_goPostal.props['z'], true, false, false)
            goPostalGetBox()
            haveBox = false
        else
            Extasy.ShowNotification("~r~La livraison n'a pas pu se lancer !")
        end
    end
end

