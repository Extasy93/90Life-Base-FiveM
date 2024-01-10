
local GymExerciceRadius = 2.0
local IsWorkingOutInGym = false
local GymInstructions = nil
local LastMuscleValue = nil
local s_index = 1
local index = 1
local GymObjects = {
    { hash = `prop_weight_squat`,       hint = 'Appuyez sur ~INPUT_CONTEXT~ pour vous muscler vos bras', animName = 'weights', relativeCoords = vector3(0.0, -0.5, -1.0),     relativeHeading = -180.0 },
    { hash = `prop_muscle_bench_03`,    hint = 'Appuyez sur ~INPUT_CONTEXT~ pour vous muscler',          animName = 'bench',   relativeCoords = vector3(0.0, -0.15, -1.25),   relativeHeading = -180.0 },
    { hash = `prop_beach_bars_02`,      hint = 'Appuyez sur ~INPUT_CONTEXT~ pour faire des tractions',   animName = 'chinup',  relativeCoords = vector3(0.0, -0.15, 0.0),     relativeHeading = 0.0    },
}

local GymExercices = {
    { coord = vector3(2432.04, 4860.26, 9.39),  heading = 246.5,  animName = 'chinup'},
    { coord = vector3(2432.94, 4861.85, 9.39), heading = 253.6,  animName = 'chinup'},
    { coord = vector3(2425.93, 4846.58, 9.52),  heading = 159.7,  animName = 'jog'   },
    { coord = vector3(2429.35, 4862.15, 9.40), heading = 248.87, animName = 'yoga'},
    { coord = vector3(2428.51, 4854.48, 9.39), heading = 343.43, animName = 'flex'  },
    { coord = vector3(2431.93, 4852.88, 9.37), heading = 248.32, animName = 'pushup'},
}

local GymZones = {
    { coord = vector3(2432.75, 4861.94, 10.39), radius = 30.0, blip = true},
}

local GymNotifications = {
    {threshold = 100000, upText = '💪 Votre condition physique est ~b~médiocre~s~',   downText = '💪 Votre condition physique est ~b~exécrable~s~'},
    {threshold = 250000, upText = '💪 Votre condition physique est ~b~normale~s~',    downText = '💪 Votre condition physique est ~b~médiocre~s~'  },
    {threshold = 500000, upText = '💪 Votre condition physique est ~b~bonne~s~',      downText = '💪 Votre condition physique est ~b~normale~s~'   },
    {threshold = 750000, upText = '💪 Votre condition physique est ~b~très bonne~s~', downText = '💪 Votre condition physique est ~b~bonne~s~'     },
    {threshold = 900000, upText = '💪 Votre condition physique est ~b~excellente~s~', downText = '💪 Votre condition physique est ~b~très bonne~s~'},
}

local GymAnims = {
    ['chinup' ] = {type = 1, hint = 'Appuyez sur ~INPUT_CONTEXT~ pour faire des tractions',   scenario = 'PROP_HUMAN_MUSCLE_CHIN_UPS'},
    ['situp'  ] = {type = 1, hint = 'Appuyez sur ~INPUT_CONTEXT~ pour vous muscler',          scenario = 'WORLD_HUMAN_SIT_UPS'},
    ['weights'] = {type = 1, hint = 'Appuyez sur ~INPUT_CONTEXT~ pour vous muscler vos bras', scenario = 'WORLD_HUMAN_MUSCLE_FREE_WEIGHTS'},
    ['pushup' ] = {type = 1, hint = 'Appuyez sur ~INPUT_CONTEXT~ pour faire des pompes',      scenario = 'WORLD_HUMAN_PUSH_UPS'},
    ['jog' ]    = {type = 1, hint = 'Appuyez sur ~INPUT_CONTEXT~ pour faire du cardio',       scenario = 'WORLD_HUMAN_JOG_STANDING'},
    ['flex'  ]  = {type = 1, hint = 'Appuyez sur ~INPUT_CONTEXT~ pour s\'échauffer',          scenario = 'WORLD_HUMAN_MUSCLE_FLEX'},
    ['yoga'  ]  = {type = 1, hint = 'Appuyez sur ~INPUT_CONTEXT~ pour faire du yoga',         scenario = 'WORLD_HUMAN_YOGA'},
    ['bench'  ] = {type = 1, hint = 'Appuyez sur ~INPUT_CONTEXT~ pour vous muscler',          scenario = 'PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS_PRISON'},
}

RMenu.Add('gym', 'main_menu', RageUI.CreateMenu("Salle de Gym", "Que souhaitez-vous acheter ?", 1, 100))
RMenu.Add('gym', 'main_menu_buy', RageUI.CreateMenu("Salle de Gym", "Que souhaitez-vous acheter ?", 1, 100))
RMenu:Get('gym', 'main_menu').Closed = function()
    gym_open = false
end

openGym_m = function()
    if gym_open then
        gym_open = false
        return
    else
        gym_open = true
        Citizen.CreateThread(function()
            while gym_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('gym', 'main_menu'), true, true, true, function()

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index = Index
                    end)

                    RageUI.Separator("")
                     
                    for k,v in pairs(cfg_gym.items) do    
                        RageUI.Button(v.label, nil, {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                cfg_gym.label     = v.label
                                cfg_gym.price     = v.price
                                cfg_gym.item_name = v.item
                            end
                        end, RMenu:Get('gym', 'main_menu_buy'))
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('gym', 'main_menu_buy'), true, true, true, function() 

                    if cfg_gym.label ~= "carte_acces" then
                        RageUI.List("Combien de '"..cfg_gym.label.."' ?", cfg_gym.max, s_index, nil, {}, true, function(Hovered, Active, Selected, Index) s_index = Index end)
                    end 

                    RageUI.Button("~g~Acheter "..s_index.." '"..cfg_gym.label.."' pour "..s_index * cfg_gym.price.."$", nil, {}, true, function(Hovered, Active, Selected) 
                        if (Selected) then
                            if index == 1 then
                                TriggerServerEvent("Shop:BuyItemsByBankMoney", token, s_index * cfg_gym.price, cfg_gym.item_name, s_index, cfg_gym.label)
                                RageUI.CloseAll()
                                gym_open = false
                            elseif index == 2 then
                                TriggerServerEvent("Shop:BuyItemsByMoney", token, s_index * cfg_gym.price, cfg_gym.item_name, s_index, cfg_gym.label)
                                RageUI.CloseAll()
                                gym_open = false
                            elseif index == 3 then
                                TriggerServerEvent("Shop:BuyItemsByDirtyMoney", token, s_index * cfg_gym.price, cfg_gym.item_name, s_index, cfg_gym.label)
                                RageUI.CloseAll()
                                gym_open = false
                            end
                        end			
                    end)

                end, function()
                end)

            end
        end)
    end
end

openGym = function(number)
    RageUI.Visible(RMenu:Get('gym', 'main_menu'), true)
    openGym_m()
    gym_number = number
end

Citizen.CreateThread(function()
    while ESX == nil do Wait(0) end

    while true do 
        local sleepTime = 2000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local exerciseFound = false

        if not IsWorkingOutInGym then   
            -- Auto detect gym object
            for _, object in pairs(GymObjects) do
                local entity = GetClosestObjectOfType(playerCoords, GymExerciceRadius, object.hash, false, false, false)
    
                if not exerciseFound and DoesEntityExist(entity) then
                    sleepTime = 0
                    local entityCoords = GetEntityCoords(entity)
    
                    if #(playerCoords - entityCoords) < GymExerciceRadius then
                        exerciseFound = true
                        Extasy.ShowHelpNotification(GymAnims[object.animName].hint)
    
                        if IsControlJustPressed(0, 38) then
                            local entityHeading = GetEntityHeading(entity)
                            local gymCoords = GetOffsetFromEntityInWorldCoords(entity, object.relativeCoords.x, object.relativeCoords.y, object.relativeCoords.z)
                            TaskGoStraightToCoord(playerPed, gymCoords.x, gymCoords.y, gymCoords.z, 1.0, 5000, entityHeading - object.relativeHeading, 0.0)
                            Wait(2000)
                            FreezePedForGym()
                            SetEntityCoords(playerPed, gymCoords, 0.0, 0.0, 0.0, 0)
                            SetEntityHeading(playerPed, entityHeading - object.relativeHeading)
                            DoGymAnim(object.animName)
                        end
                    end
                end
            end
    
            -- GymExercices at a specific coord
            for _, gymExercice in pairs(GymExercices) do
                local gymCoords = gymExercice.coord
                if not exerciseFound and #(playerCoords - gymCoords) < GymExerciceRadius then
                    sleepTime = 0
                    exerciseFound = true
                    Extasy.ShowHelpNotification(GymAnims[gymExercice.animName].hint)
    
                    if IsControlJustPressed(0, 38) then
                        TaskGoStraightToCoord(playerPed, gymCoords.x, gymCoords.y, gymCoords.z, 1.0, 5000, gymExercice.heading, 0.0)
                        Wait(2000)
                        FreezePedForGym()
                        SetEntityCoords(playerPed, gymCoords, 0.0, 0.0, 0.0, 0)
                        SetEntityHeading(playerPed, gymExercice.heading)
                        DoGymAnim(gymExercice.animName)
                    end
    
                end
            end
        end

        Wait(sleepTime)
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do Wait(0) end

    while true do
        local isWorkingOut = false
        for _, gymZone in pairs(GymZones) do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            if #(playerCoords - gymZone.coord) < gymZone.radius then
                if IsDoingGymAnim() then
                    isWorkingOut = true
                    --TriggerEvent('Extasy:updateZen', 3000)
                    TriggerEvent('Extasy:useOxygen', 2.0)
                end
                if IsPedSprinting(playerPed) then
                    --TriggerEvent('Extasy:updateZen', 3000)
                    TriggerEvent('Extasy:useOxygen', 2.0)
                end

                break
            end
        end

        if isWorkingOut and not IsWorkingOutInGym then -- Started working out this loop
            GymInstructions = Extasy.SetupInstructionalButtons({ {key = 22, label = "Se muscler"}, {key = 194,  label = "Arrêter l'activité"} })
        elseif not isWorkingOut and IsWorkingOutInGym then -- Stopped working out this loop
            GymInstructions = nil
            DeleteGymProp()
            AnimpostfxStopAll()
        end

        if isWorkingOut then
            IsWorkingOutInGym = true
            TriggerEvent('Extasy:getCurrentOxygenLevel', function(oxygenLevel)
                if oxygenLevel < 5.0 then
                    local playerPed = PlayerPedId()
                    Extasy.ShowNotification('Vous êtes à court d\'~b~oxygène~s~...')
                    ClearPedTasks(playerPed)
                    FreezeEntityPosition(PlayerPedId(), false)
                    SetPedToRagdoll(playerPed, 10000, 10000, 0, 0, 0, 0)
                end
            end)
        else
            IsWorkingOutInGym = false
        end
        Wait(1000)
    end
end)

Citizen.CreateThread(function()
    local lastMuscleTime = 0

    while true do
        local sleepTime = 500

        if IsWorkingOutInGym then
            sleepTime = 0

            if GymInstructions then
                DrawScaleformMovieFullscreen(GymInstructions, 255, 255, 255, 255, 0)
            end

            if IsControlJustPressed(0, 22) and GetGameTimer() > lastMuscleTime + 500 then
                lastMuscleTime = GetGameTimer()
                AnimpostfxPlay('SwitchHUDOut', 500, false)
                TriggerEvent('esx_status:add', 'muscle', 500)
                TriggerEvent('esx_status:remove', 'thirst', 250)
                TriggerEvent('Extasy:useOxygen', 0.5)
            end

            if IsControlJustPressed(0, 194) then
                ClearPedTasks(PlayerPedId())
            end
        end

        Wait(sleepTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        TriggerEvent('esx_status:getStatus', 'muscle', function(status)
            if LastMuscleValue then
                local currentValue = status.val

                if currentValue > LastMuscleValue then -- Gaining muscle
                    for _, notification in pairs(GymNotifications) do
                        if currentValue >= notification.threshold and LastMuscleValue < notification.threshold then
                            Extasy.ShowNotification(notification.upText)
                        end
                    end
                else -- Losing muscle
                    for _, notification in pairs(GymNotifications) do
                        if currentValue <= notification.threshold and LastMuscleValue > notification.threshold then
                            Extasy.ShowNotification(notification.downText)
                        end
                    end
                end
                LastMuscleValue = currentValue
            else 
                LastMuscleValue = status.val
            end
		end)
    end
end)

-- Restore stamina
Citizen.CreateThread(function()
    local sleepTime = 1000
    local maxStaminaFactor = 7 -- (0 means nothing - 10 means no stamina loss)
    while true do
        if LastMuscleValue then
            local staminaBoost = maxStaminaFactor/100 * (LastMuscleValue/1000000) -- Scale on muscle value. More muscle = more stamina

            if (100.0-GetPlayerSprintStaminaRemaining(PlayerId())) < 15.0 then -- Limit on remaining stamina < 10.0 to allow natural stamina handling by GTA
                staminaBoost = 0
            end

            RestorePlayerStamina(PlayerId(), staminaBoost)
        end
        Wait(sleepTime)
    end
end)

local muscle = 30

Citizen.CreateThread(function()
    while true do
        Wait(60*60*1000)
        muscle = muscle - 10
        if muscle < 25 then
            Extasy.ShowNotification('💪 Pensez à faire du ~b~sport~s~ afin de maintenir votre condition physique !')
        end
    end
end)

DeleteGymProp = function()
    local propList = {`prop_barbell_02`, `prop_curl_bar_01`}

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for _, hash in pairs(propList) do
        local object = GetClosestObjectOfType(playerCoords, 3.0, hash, false, false, false)
        if DoesEntityExist(object) then
            ESX.Game.DeleteObject(object)
            break
        end
    end
end

IsDoingGymAnim = function()
    local playerPed = PlayerPedId()
    for _, gymAnim in pairs(GymAnims) do
        if gymAnim.type == 0 and IsEntityPlayingAnim(playerPed, gymAnim.animDict, gymAnim.anim, 3) or gymAnim.type == 1 and IsPedUsingScenario(playerPed, gymAnim.scenario) then
            return true
        end
    end
    return false
end

FreezePedForGym = function()
    FreezeEntityPosition(PlayerPedId(), true)
    Wait(2000)
    Citizen.CreateThread(function()
        while IsDoingGymAnim() do
            Wait(500)
        end
        FreezeEntityPosition(PlayerPedId(), false)
    end)
end

DoGymAnim = function(animName)
    local playerPed = PlayerPedId()
    local gymAnim = GymAnims[animName]

    if gymAnim.type == 1 then
        TaskStartScenarioInPlace(playerPed, gymAnim.scenario, 0, false)
    elseif gymAnim.type == 0 then
        ESX.Streaming.RequestAnimDict(gymAnim.animDict)
		TaskPlayAnim(playerPed, gymAnim.animDict, gymAnim.anim, 8.0, -8.0, -1, 1, 0, false, false, false)
    end
end
