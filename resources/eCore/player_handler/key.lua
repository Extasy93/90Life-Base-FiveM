ESX = nil
playerInTrunk = false
local isInAnim, dictLoaded, inKeyAnim, StuntOn, key = false, false, false, nil, nil
local SpecificVehicle_state = false
Vehicles_stunt = { -- N'utilisez pas "Nom du modèle" car il n'y a pas de natif pour obtenir le nom du modèle du véhicule dans GTA, utilisez uniquement "Nom(s) d'étiquette de texte". Vous pouvez les trouver ici: https://gta.fandom.com/wiki/Category:Motorcycles_Vehicle_Class
    "ENDURO",
    "ESSKEY",
    "MANCHEZ",
    "SANCHEZ01",
    "TMAX",
    "SANCHEZ02"
}

Extasy.RegisterControlKey("open_hud", "Hud", "F1", function()
    if not playerIsOnKeyBoard then
        Wait(100)
        TriggerEvent("Extasy:ShowF1Hud")
    end
end)


Extasy.RegisterControlKey("slot_1", "Slot d'arme n°1", "1", function()
    if not playerIsOnKeyBoard then
        if not animation_handsup then
            if not animation_crouch then
                exports.inventory:HotBarUse(1)
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire cela en étant accroupis")
            end
        else
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire cela les mains lever")
        end
    end
end)

Extasy.RegisterControlKey("slot_2", "Slot d'arme n°2", "2", function()
    if not playerIsOnKeyBoard then
        if not animation_handsup then
            if not animation_crouch then
                exports.inventory:HotBarUse(2)
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire cela en étant accroupis")
            end
        else
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire cela les mains lever")
        end
    end
end)

Extasy.RegisterControlKey("slot_3", "Slot d'arme n°3", "3", function()
    if not playerIsOnKeyBoard then
        if not animation_handsup then
            if not animation_crouch then
                exports.inventory:HotBarUse(3)
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire cela en étant accroupis")
            end
        else
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire cela les mains lever")
        end
    end
end)

Extasy.RegisterControlKey("open_inv", "Ouvrir l'inventaire", "TAB", function()
    if not playerIsOnKeyBoard then
        exports.inventory:OpenInventory()
    end
end)

Extasy.RegisterControlKey("props_menu", "Menu objets / props", "", function()
    if not playerIsOnKeyBoard then
        RageUI.Visible(RMenu:Get('props', 'main_menu'), true)
        openProps()
        playerPropsMenu = not playerPropsMenu
    end
end)

Extasy.RegisterControlKey("emote_menu", "Menu animation", "F2", function()
    if not playerIsOnKeyBoard then
        OpenEmotesMenu()
    end
end)

Extasy.RegisterControlKey("open_facture", "Facture", "F9", function()
    if not playerIsOnKeyBoard then
        TriggerEvent("iFacture:openClientMenu", token)
    end
end)

--[[in_pickup_snowball = false
Extasy.RegisterControlKey("Boule_de_Neige", "Pour ramasser des Boule de Neige", "", function()
    if not playerIsDead == 0 then
        Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
    else
        if in_pickup_snowball then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci aussi rapidement")
        else
            if IsNextWeatherType('XMAS') then
                in_pickup_snowball = true
                RequestAnimDict('anim@mp_snowball') -- pre-load the animation
                if not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedSwimmingUnderWater(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedRunning(PlayerPedId()) and not IsPedSprinting(PlayerPedId()) and GetInteriorFromEntity(PlayerPedId()) == 0 and not IsPedShooting(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInCover(PlayerPedId(), 0) then -- check if the snowball should be picked up
                    TaskPlayAnim(PlayerPedId(), 'anim@mp_snowball', 'pickup_snowball', 8.0, -1, -1, 0, 1, 0, 0, 0) -- pickup the snowball
                    Wait(1950)
                    TriggerServerEvent("Extasy:GetSnowBallforPlayer", token)
                    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey('WEAPON_SNOWBALL'), 2, false, true) -- get 2 snowballs each time.
                end
            else
                Extasy.ShowNotification("~r~T'es bête ou quoi il n'y a pas de neige !")
            end
            Wait(5000)
            in_pickup_snowball = false
        end
    end
end)--]]

Extasy.RegisterControlKey("open_chat", "Ouvrir le chat", "T", function()
    if not playerIsOnKeyBoard then
        TriggerEvent("Extasy:OpenChat")
    end
end)

Extasy.RegisterControlKey("inventaire", "Ouvrir menu personnel", "f5", function()
    if not playerIsOnKeyBoard then
        if not playerIsDead == 0 then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
        else
            if not IsHandcuffed then
                if not RageUI.Visible() then
                    openInvPlayer()
                    menu_perso.leave_ok = false
                    ESX.TriggerServerCallback('Extasy:getPet', function(result2)
                        HavePet = result2
                    end)
                    ESX.TriggerServerCallback('Extasy:getPetName', function(result)
                        petName = result
                    end)
                    ESX.TriggerServerCallback('ExtasyMenu:getUsergroup', function(group)
                        playergroup = group
                    end)
                end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas bouger en étant menotté")
            end
        end
    end
end)

Extasy.RegisterControlKey("job_menu", "Ouvrir le menu de job", "f6", function()
    if not playerIsOnKeyBoard then
        if not playerIsDead == 0 then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
        else
            if not IsHandcuffed then
                if playerJob == 'vcpd' then
                    RageUI.Visible(RMenu:Get('vcpd', 'main_menu'), true)
                    OpenVcpdMenu()
                elseif playerJob == 'label' then
                    OpenLabelMenu()
                elseif playerJob == 'weazelnews' then
                    OpenWeazelnewsMenu()
                elseif playerJob == 'weedshop' then
                    OpenWeedshopMenu()
                elseif playerJob == 'taxi' then
                    opentaxicab()
                elseif playerJob == 'ambulance' then
                    openAmbulanceMenuF6()
                elseif playerJob == 'malibu' then
                    openMalibu()
                elseif playerJob == 'pizza' then
                    openPizzaMenu()
                elseif playerJob == 'robina' then
                    openRobina()
                elseif playerJob == 'vccustoms' then
                    openVcCustomsMenuF6()
                elseif playerJob == 'AgentImmo' then
                    RageUI.Visible(RMenu:Get('Extasy_Property_menu', 'create'), true)
                    OpenPropertyCreateMenu()
                elseif playerJob == 'avocat' then
                    OpenAvocatMenu()
                elseif playerJob == 'cityhall' then
                    OpenCityhallMenu()
                elseif playerJob == 'frontpage' then
                    openFront()
                elseif playerJob == 'tabac' then
                    OpenTabacMenu()
                elseif playerJob == 'oceanview' then
                    OpenOceanviewMenu()
                elseif playerJob == 'greasychopper' then
                    openGreasyChopper()
                elseif playerJob == 'icecream' then
                    openIce()
                else
                    Extasy.ShowNotification("~r~Votre job ne possède pas de menu spécial")
                end
            end
        end
    end
end)

local reportSQL = nil

Extasy.RegisterControlKey("menu_admin", "Ouvrir le MenuAdmin", "f7", function()
    if not playerIsOnKeyBoard then
        if not playerIsDead == 0 then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
        else
            ESX.TriggerServerCallback('ExtasyMenu:getUsergroup', function(group)
                playergroup = group
                
				if playergroup == 'superadmin' or playergroup == 'owner' or playergroup == 'dev' then
                    TriggerServerEvent("ExtasyReportMenu:GetReport", token)
                    while reportSQL == nil do Wait(1) end
					superadmin = true
					openStaffMenu()
				elseif playergroup == 'mod' or playergroup == 'admin' then
                    TriggerServerEvent("ExtasyReportMenu:GetReport", token)
                    while reportSQL == nil do Wait(1) end
					superadmin = false
					openStaffMenu()
                else
                    Extasy.ShowNotification("~r~Vous n'avez pas accès à ce menu.")
                end
			end)
        end
    end
end)

RegisterNetEvent("Extasy:sendReports")
AddEventHandler("Extasy:sendReports", function(reports)
    reportSQL = reports
end)

Extasy.RegisterControlKey("open_chest_vehicle", "Ouvrir coffre véhicule", "l", function()
    if not playerIsOnKeyBoard then
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            if not IsHandcuffed then
                local interval = 1
                local pPed = GetPlayerPed(-1)
                local pCoord = GetEntityCoords(pPed)
                local vCloset, vDistance = ESX.Game.GetClosestVehicle(pCoord, true)
                local vPlate = GetVehicleNumberPlateText(vCloset)
                local vClass = GetVehicleClass(vCloset)
                local dist = GetDistanceBetweenCoords(pPed, vDistance, true)
                    if dist < 3 then
                        openCoffre(vCloset, vPlate, vClass)
                        SetVehicleDoorOpen(vCloset, 5, false, false)
                    else 
                        Extasy.ShowNotification("~g~Il n'y as pas de véhicule proche.")
                    end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas ouvrir de coffre en étant menotté")
            end
        else
            Extasy.ShowNotification("~r~Vous devez être en dehors du véhicule")
        end
    end
end)

isCanceling = false
Extasy.RegisterControlKey("cancel_anim", "Annuler l'animation en cours", "x", function()
    if not playerIsOnKeyBoard then
        if isInAnim then
            ClearPedTasks(PlayerPedId())
        end
        if not isCanceling then
            if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
                if not IsHandcuffed then
                    if not playerIsInTIGAnim then
                        isCanceling = true
                        ClearPedTasks(GetPlayerPed(-1))
                        DestroyAllProps()
                        if PtfxPrompt then
                            PtfxStop()
                            FreezeEntityPosition(GetPlayerPed(-1), false)
                        end
                        Wait(5000)
                        isCanceling = false
                    end
                end
            end
        end
    end
end)

--[[local openned = false

Extasy.RegisterControlKey("open_phone", "Ouvrir téléphone", "f2", function()
    if not playerIsOnKeyBoard then
        if not openned then
            TriggerEvent("gcPhone:forceOpenPhone", token)
            --print("1")
            openned = true
        else
            TriggerEvent("gcphone:forceOpenPhone", token)
            --print("2")
            openned = false
        end
    end
end)

function resetOpenned()
    openned = not openned
end

function DoesPlayerGotPhone(cb)
    for k,v in pairs(playerInventory) do
        if v.name == "Telephone" then
            if v.count > 0 then
                cb(true)
            else
                cb(false)
            end
        end
    end
end--]]

Extasy.RegisterControlKey("toggle_noclip", "Activer le noclip (staff)", "", function()
    if not playerIsOnKeyBoard then
        ESX.TriggerServerCallback('ExtasyMenu:getUsergroup', function(playergroup)
            if playergroup ~= nil and (playergroup == 'mod' or playergroup == 'admin' or playergroup == 'superadmin' or playergroup == 'owner' or playergroup == 'helper') then
                if not noclip then
                    if not IsHandcuffed then
                        Wait(2)
                        noclip = true
                        playerIsNoclip = true

                        Citizen.CreateThread(function()
                            local object = UIInstructionalButton.__constructor()

                            object:Add("Ralentir", 62)
                            object:Add("Turbo", 21)
                            object:Add("Reculer", 78)
                            object:Add("Avancer", 129)
                            object:Visible(true)

                            while noclip do
                                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                                local camCoords = getCamDirection()
                                local speed     = 0.8
                                SetEntityVelocity(GetPlayerPed(-1), 0.01, 0.01, 0.01)
                                SetEntityInvincible(GetPlayerPed(-1), 1)
                                SetEntityVisible(GetPlayerPed(-1), 0, 0)

                                if IsControlPressed(1, 21) then
                                    speed = speed + 4.0
                                end

                                if IsControlPressed(1, 36) then
                                    speed = 0.20
                                end

                                if IsControlPressed(0, 32) then
                                    plyCoords = plyCoords + (speed * camCoords)
                                end

                                if IsControlPressed(0, 269) then
                                    plyCoords = plyCoords - (speed * camCoords)
                                end

                                SetEntityCoordsNoOffset(GetPlayerPed(-1), plyCoords, true, true, true)
                                Citizen.Wait(0)
                                object:onTick()
                            end
                        end)
                    end
                else
                    local object = UIInstructionalButton.__constructor()

                    noclip = false
                    playerIsNoclip = false
                    SetEntityVisible(GetPlayerPed(-1), 1, 0)
                    SetEntityInvincible(GetPlayerPed(-1), 0)
                    ClearPedTasksImmediately(GetPlayerPed(-1))

                    object:Delete("Ralentir", 62)
                    object:Delete("Turbo", 21)
                    object:Delete("Avancer", 129)
                    object:Delete("Reculer", 78)
                end
            else
                Extasy.ShowNotification("~r~Vous n'avez pas le grade nécessaire pour utiliser cette fonctionnalité")
            end
        end)
    end
end)

Extasy.RegisterControlKey("tp_marker", "Se TP sur marker (staff)", "", function()
    if not playerIsOnKeyBoard then
        plyPed = PlayerPedId()
        ESX.TriggerServerCallback('ExtasyMenu:getUsergroup', function(playergroup)
            if playergroup ~= nil and (playergroup == 'mod' or playergroup == 'admin' or playergroup == 'superadmin' or playergroup == 'owner' or playergroup == 'helper') then
                local waypointHandle = GetFirstBlipInfoId(8)

                if DoesBlipExist(waypointHandle) then
                    Citizen.CreateThread(function()
                        local waypointCoords = GetBlipInfoIdCoord(waypointHandle)
                        local foundGround, eCoords, zPos = false, -500.0, 0.0

                        while not foundGround do
                            eCoords = eCoords + 10.0
                            RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, eCoords)
                            Citizen.Wait(0)
                            foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, eCoords)

                            if not foundGround and eCoords >= 2000.0 then
                                foundGround = true
                            end
                        end

                        SetPedCoordsKeepVehicle(plyPed, waypointCoords.x, waypointCoords.y, zPos)
                    end)
                else
                    Extasy.ShowNotification('TP')
                end
            end
        end)
    end
end)

Extasy.RegisterControlKey("toggle_sleep", "Dormir/se réveiller", "4", function()
    -- if playerInCombat then Extasy.ShowNotification("~r~Vous ne pouvez pas utiliser ceci en étant en combat") return end
    --if RTJ.isJailed() then return end

    if not playerIsOnKeyBoard then
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            if not IsHandcuffed then
                if not animation_sleep then
                    sleep()
                else
                    animation_sleep = false
                end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire cette animation en étant menotté")
            end
        else
            Extasy.ShowNotification("~r~Vous devez être en dehors du véhicule")
        end
    end
end)

local animation_handsup = false
Extasy.RegisterControlKey("toggle_handsup", "Lever les mains", "OEM_3", function()
    if not playerIsOnKeyBoard then
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            if not IsHandcuffed then
                if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedSwimming(PlayerPedId()) and not IsPedShooting(PlayerPedId()) and not IsPedClimbing(PlayerPedId()) and not IsPedCuffed(PlayerPedId()) and not IsPedDiving(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedJumpingOutOfVehicle(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInParachuteFreeFall(PlayerPedId()) then
                    local dict = "missminuteman_1ig_2"

                    RequestAnimDict(dict)
                    while not HasAnimDictLoaded(dict) do
                        Citizen.Wait(100)
                    end

                    if not animation_handsup then
                        TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                        animation_handsup = true
                    else
                        ClearPedTasks(GetPlayerPed(-1))
                        animation_handsup = false
                    end
                end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire cette animation en étant menotté")
            end
        else
            Extasy.ShowNotification("~r~Vous devez être en dehors du véhicule")
        end
    end
end)

mp_pointing = false
keyPressed = false
startPointing = function()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

stopPointing = function()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end
once = true
oldval = false
oldvalped = false

Extasy.RegisterControlKey("toggle_pointing", "Pointer du doigt", "B", function()
    if not playerIsOnKeyBoard then
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            if not IsHandcuffed then
                if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedSwimming(PlayerPedId()) and not IsPedShooting(PlayerPedId()) and not IsPedClimbing(PlayerPedId()) and not IsPedCuffed(PlayerPedId()) and not IsPedDiving(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedJumpingOutOfVehicle(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInParachuteFreeFall(PlayerPedId()) then
                    if not keyPressed then
                        keyPressed = true
                        startPointing()
                        mp_pointing = true
                        start_pointing()
                    else
                        stopPointing()
                        keyPressed = false
                        mp_pointing = false
                        animation_pointing = false
                    end
                end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire cette animation en étant menotté")
            end
        else
            Extasy.ShowNotification("~r~Vous devez être en dehors du véhicule")
        end
    end
end)

animation_crouch = false
Extasy.RegisterControlKey("toggle_crouch", "S'accroupir", "CAPITAL", function()
    if not playerIsOnKeyBoard then
        if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            if not IsHandcuffed then
                if not IsPedInAnyVehicle(PlayerPedId(), false) and not IsPedArmed(PlayerPedId(), 6) and not IsPlayerFreeAiming(PlayerId()) and not IsPedSwimming(PlayerPedId()) and not IsPedShooting(PlayerPedId()) and not IsPedClimbing(PlayerPedId()) and not IsPedCuffed(PlayerPedId()) and not IsPedDiving(PlayerPedId()) and not IsPedFalling(PlayerPedId()) and not IsPedJumpingOutOfVehicle(PlayerPedId()) and not IsPedUsingAnyScenario(PlayerPedId()) and not IsPedInParachuteFreeFall(PlayerPedId()) then
                    if not animation_crouch then
                        local ped = GetPlayerPed(-1)
                        local inAir = IsEntityInAir(ped)

                        if not inAir then
                            ResetPedMovementClipset(ped, 0)
                            ClearPedTasksImmediately(ped)

                            RequestAnimSet("move_ped_crouched")
                            RequestAnimSet("MOVE_M@TOUGH_GUY@")
                            
                            while (not HasAnimSetLoaded("move_ped_crouched")) do 
                                Wait(100)
                            end 
                            while (not HasAnimSetLoaded("MOVE_M@TOUGH_GUY@")) do 
                                Wait(100)
                            end 
                            animation_crouch = true

                            CreateThread(function()
                                while animation_crouch do

                                    SetPedMovementClipset(ped, "move_ped_crouched", 0.55)
                                    SetPedStrafeClipset(ped, "move_ped_crouched_strafing")

                                    Wait(50)
                                end
                            end)
                        else
                            Extasy.ShowNotification("~r~Vous ne pouvez pas faire cette animation en étant dans les airs")
                        end
                    else
                        local ped = GetPlayerPed(-1)

                        -- ClearPedTasksImmediately(ped)
                        ResetPedMovementClipset(ped, 0)
                        animation_crouch = false
                    end
                end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas faire cette animation en étant menotté")
            end
        else
            Extasy.ShowNotification("~r~Vous devez être en dehors du véhicule")
        end
    end
    --print(animation_crouch, "animation_crouch")
end)

Extasy.RegisterControlKey("show_info", "Connaître ses données", "NUMPAD0", function()
    if not playerIsOnKeyBoard then
        Extasy.ShowNotification("Votre ID: "..GetPlayerServerId(PlayerId()).."\n~p~Votre job: ~s~"..Extasy.firstToUpper(playerJob))
    end
end)

local lastPlayersData    = {}
lastPlayersData.putMask  = false
lastPlayersData.putShirt = false
lastPlayersData.putPants = false
lastPlayersData.putAllCl = false

Extasy.RegisterControlKey("toggle_mask", "Enlever/mettre son chapeau/masque/casque", "", function()
    if not playerIsOnKeyBoard then
        if playerIsDead then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
        else
            RequestAnimDict("missfbi4")
            TaskPlayAnim(PlayerPedId(), "missfbi4", "takeoff_mask", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
            Wait(400)
            ClearPedSecondaryTask(PlayerPedId())
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
                if not lastPlayersData.putMask then
                    lastPlayersData.putMask = true
                    local d = {
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['helmet_1'] = -1, ['helmet_2'] = -1
                    }
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                else
                    lastPlayersData.putMask = false
                    local d = {
                        ['mask_1'] = skin.mask_1, ['mask_2'] = skin.mask_2,
                        ['helmet_1'] = skin.helmet_1, ['helmet_2'] = skin.helmet_2
                    }
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                end
            end)
        end
    end
end)

Extasy.RegisterControlKey("toggle_shirt", "Enlever/mettre son haut", "", function()
    if not playerIsOnKeyBoard then
        if playerIsDead then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
        else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
                if not lastPlayersData.putShirt then
                    lastPlayersData.putShirt = true
                    local d = {
                        ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                        ['torso_1'] = 15, ['torso_2'] = 0,
                        ['arms'] = 15, ['arms_2'] = 0
                    }
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                else
                    lastPlayersData.putShirt = false
                    local d = {
                        ['tshirt_1'] = playerSkin.tshirt_1, ['tshirt_2'] = playerSkin.tshirt_2,
                        ['torso_1'] = playerSkin.torso_1, ['torso_2'] = playerSkin.torso_2,
                        ['arms'] = playerSkin.arms, ['arms_2'] = playerSkin.arms_2
                    }
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                end
            end)
        end
    end
end)

Extasy.RegisterControlKey("toggle_pants", "Enlever/mettre son bas", "", function()
    if not playerIsOnKeyBoard then
        if playerIsDead then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
        else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
                if not lastPlayersData.putPants then
                    lastPlayersData.putPants = true
                    local d = {
                        ['pants_1'] = 14, ['pants_2'] = 0,
                    }
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                else
                    lastPlayersData.putPants = false
                    local d = {
                        ['pants_1'] = playerSkin.pants_1, ['pants_2'] = playerSkin.pants_2,
                    }
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                end
            end)
        end
    end
end)



Extasy.RegisterControlKey("toggle_shoes", "Enlever/mettre ses chaussures", "", function()
    if not playerIsOnKeyBoard then
        if playerIsDead then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
        else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
                if not lastPlayersData.putPants then
                    lastPlayersData.putPants = true
                    local d = {}
                    if playerIsMale then
                        d = {
                            ['shoes_1'] = 54, ['shoes_2'] = 0
                        }
                    else
                        d = {
                            ['shoes_1'] = 54, ['shoes_2'] = 0
                        }
                    end
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                else
                    lastPlayersData.putPants = false
                    local d = {
                        ['shoes_1'] = playerSkin.shoes_1, ['shoes_2'] = playerSkin.shoes_2,
                    }
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                end
            end)
        end
    end
end)

Extasy.RegisterControlKey("toggle_allclothes", "Se déshabiller/rhabiller", "o", function()
    if not playerIsOnKeyBoard then
        if playerIsDead then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
        else
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                TriggerEvent('skinchanger:loadSkin', skin)
                if not lastPlayersData.putAllCl then
                    lastPlayersData.putAllCl = true
                    local d = {}
                    if playerIsMale then
                        d = {
                            ['mask_1'] = 0, ['mask_2'] = 0,
                            ['helmet_1'] = -1, ['helmet_2'] = -1,
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 15, ['torso_2'] = 0,
                            ['arms'] = 15, ['arms_2'] = 0,
                            ['pants_1'] = 14, ['pants_2'] = 0,
                            ['shoes_1'] = 54, ['shoes_2'] = 0
                        }
                    else
                        d = {
                            ['mask_1'] = 0, ['mask_2'] = 0,
                            ['helmet_1'] = -1, ['helmet_2'] = -1,
                            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                            ['torso_1'] = 15, ['torso_2'] = 0,
                            ['arms'] = 15, ['arms_2'] = 0,
                            ['pants_1'] = 15, ['pants_2'] = 0,
                            ['shoes_1'] = 54, ['shoes_2'] = 0
                        }
                    end
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                    TriggerEvent("skinchanger:loadClothes", skin, d)
                else
                    lastPlayersData.putAllCl = false
                
                    TriggerEvent("skinchanger:loadPlayerSkin", playerSkin)
                end      
            end)
            --for i = 1, #playerTattoos, 1 do
                --ApplyPedOverlay(GetPlayerPed(-1), GetHashKey(playerTattoos[i].collection), GetHashKey(cfg_tattoos.tattoosList[playerTattoos[i].collection][playerTattoos[i].texture].nameHash))
            --end
        end
    end
end)

Extasy.RegisterControlKey("toggle_talk_radio", "Activer/désactiver radio", "F3", function()
    if Extasy.HasItem("Radio") >= 1 then 
        if not playerIsOnKeyBoard then
            if not IsHandcuffed then
                if not playerIsOnRadio then
                    playerIsOnRadio = not playerIsOnRadio
                    openRadio_m()
                else
                    playerIsOnRadio = not playerIsOnRadio
                    openRadio_m()
                end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas interagir avec votre radio en étant menotté")
            end
        end
    else
        Extasy.ShowNotification("~r~Vous n'avez pas de radio sur vous")
    end
end)

Extasy.RegisterControlKey("tackle", "Mettre au sol une personne", "", function()
    if not playerIsOnKeyBoard then
        if not playerIsDead == 0 then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
        else
            if not IsHandcuffed then
                if not RageUI.Visible() then
                    Citizen.CreateThread(function()
                        while true do
                            Citizen.Wait(0)
                            if IsPedSprinting(PlayerPedId()) and IsControlJustReleased(0, 38) then --Change the key for tackling here.
                                if IsPedInAnyVehicle(PlayerPedId()) then
                                else
                                    local ForwardVector = GetEntityForwardVector(PlayerPedId())
                                    local Tackled = {}
                    
                                    SetPedToRagdollWithFall(PlayerPedId(), 1000, 1500, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0) --how long the tackler will remain down.
                    
                                    while IsPedRagdoll(PlayerPedId()) do
                                        Citizen.Wait(0)
                                        for Key, Value in ipairs(getTouchedPlayers()) do
                                            if not Tackled[Value] then
                                                Tackled[Value] = true
                                                TriggerServerEvent('Tackle:Server:TacklePlayer', token, GetPlayerServerId(Value), ForwardVector, GetPlayerName(PlayerId()))
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            else
                Extasy.ShowNotification("~r~Vous ne pouvez pas bouger en étant menotté")
            end
        end
    end
end)

RegisterNetEvent('Tackle:Client:TacklePlayer')
AddEventHandler('Tackle:Client:TacklePlayer',function(ForwardVector)
	SetPedToRagdollWithFall(PlayerPedId(), 3000, 3000, 0, ForwardVector, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0) --how long the person being tackled will remain down.
end)

function getPlayers()
    local players = {}

    for i = 0, 255 do
       if NetworkIsPlayerActive(i) then
            table.insert(players, i)
       end
    end

    return players
end

function getTouchedPlayers()
    local touchedPlayer = {}
    for Key, Value in ipairs(getPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(), GetPlayerPed(Value)) then
			table.insert(touchedPlayer, Value)
		end
    end
    return touchedPlayer
end

--[[Extasy.RegisterControlKey("show_info", "Connaître ses données", "", function()
    if not playerIsOnKeyBoard then
        Extasy.ShowNotification("Votre ID: "..GetPlayerServerId(PlayerId()).."\n~p~Votre job: ~s~"..Extasy.firstToUpper(playerJob).."")
    end
end)--]]

---@class Players
Players = {} or {} --- Players lists
PlayersStaff = {} or {} --- Players Staff
GamerTags = {} or {};

function RetrievePlayersDataByID(source)
    local player = {};
    for i, v in pairs(Players) do
        if (v.source == source) then
            player = v;
        end
    end
    return player;
end

function OnGetPlayers()
    local clientPlayers = false;
    ESX.TriggerServerCallback('retrievePlayers', function(players)
        clientPlayers = players
    end)

    while not clientPlayers do
        Citizen.Wait(0)
    end
    return clientPlayers
end

Extasy.RegisterControlKey("menu_org", "Menu Organisation", "F9", function()
    if not playerIsOnKeyBoard then
        if not playerIsDead == 0 then
            Extasy.ShowNotification("~r~Vous ne pouvez pas faire ceci en étant mort")
        else
            if not IsHandcuffed then
                ESX.TriggerServerCallback('Org:getGangData', token, function(result)
                    for k,v in pairs(result) do
                        if ESX.PlayerData.job2 and ESX.PlayerData.job2.name == v.Name then
                            if not Gangbuilders_in_menu_F6 then
                                MenuGangs(v)
                            else
                                Gangbuilders_in_menu_F6 = false
                                RageUI.CloseAll()
                            end
                        else
                            Extasy.ShowNotification("~r~Votre organisation ne possède pas de menu spécial")
                        end
                    end
                end)
            end
        end
    end
end)

--[[local showing = false
Extasy.RegisterControlKey("show_near_ids", "Connaître les IDs proches", "", function()
    if not playerIsOnKeyBoard then
        Players = OnGetPlayers()
                showing = true
                local n = 0
                Citizen.CreateThread(function()
                  while showing do
                     for _, player in ipairs(GetActivePlayers()) do
                         local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                         local coords = GetEntityCoords(GetPlayerPed(player))
                         local name = replaceText(player)
    
                         if dst < 15.0 then
                            DrawText3D_Id(coords.x, coords.y, coords.z + 1.0, "~p~ID:~w~ ["..GetPlayerServerId(player).."]", 14.5)
                         end                        
                    end
                      Wait(0)
                  end
               end)
        Citizen.CreateThread(function()
            while showing do
                n = n + 1
                if n > 10 then
                    showing = false
                end
                Wait(1000)
            end
        end)
    end
end)--]]

Extasy.RegisterControlKey("open_car", "Ouvrir/fermer véhicule personnel", "u", function()
    local dict = "anim@mp_player_intmenu@key_fob@"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    if not playerIsOnKeyBoard then
        if not playerHasCagoule then
            local coords = GetEntityCoords(GetPlayerPed(-1))
            local hasAlreadyLocked = false
            cars = ESX.Game.GetVehiclesInArea(coords, 30)
            local carstrie = {}
            local cars_dist = {}		
            notowned = 0
            if #cars == 0 then
                Extasy.ShowNotification("~r~Aucun véhicule à proximité")
            else
                for j=1, #cars, 1 do
                    local coordscar = GetEntityCoords(cars[j])
                    local distance = Vdist(coordscar.x, coordscar.y, coordscar.z, coords.x, coords.y, coords.z)
                    table.insert(cars_dist, {cars[j], distance})
                end
                for k=1, #cars_dist, 1 do
                    local z = -1
                    local distance, car = 999
                    for l=1, #cars_dist, 1 do
                        if cars_dist[l][2] < distance then
                            distance = cars_dist[l][2]
                            car = cars_dist[l][1]
                            z = l
                        end
                    end
                    if z ~= -1 then
                        table.remove(cars_dist, z)
                        table.insert(carstrie, car)
                    end
                end
                for i=1, #carstrie, 1 do
                
                    GetPlayerServerId(NetworkGetEntityOwner(carstrie[i]))
                    
                    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(carstrie[i]))
                    ESX.TriggerServerCallback('carlock:isVehicleOwner', function(owner)
                        if owner and hasAlreadyLocked ~= true then
                            local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(carstrie[i]))
                            vehicleLabel = GetLabelText(vehicleLabel)
                            local lock = GetVehicleDoorLockStatus(carstrie[i])

                            local playersInArea = Extasy.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 30.0)
                            local inAreaData = {}

                            for i=1, #playersInArea, 1 do
                                table.insert(inAreaData, GetPlayerServerId(playersInArea[i]))
                            end

                            if lock == 1 or lock == 0 then
                                --TriggerEvent("Ambiance:PlayUrl", "Keys", "https://www.youtube.com/watch?v=xSc9xaLkxng", 0.4, false)
                                SetVehicleDoorShut(carstrie[i], 0, false)
                                SetVehicleDoorShut(carstrie[i], 1, false)
                                SetVehicleDoorShut(carstrie[i], 2, false)
                                SetVehicleDoorShut(carstrie[i], 3, false)
                                SetVehicleDoorsLocked(carstrie[i], 2)
                                PlayVehicleDoorCloseSound(carstrie[i], 1)
                                Extasy.ShowNotification("~r~Véhicule fermé")
                                if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                    TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                                end
                                SetVehicleLights(carstrie[i], 2)
                                Citizen.Wait(150)
                                SetVehicleLights(carstrie[i], 0)
                                Citizen.Wait(150)
                                SetVehicleLights(carstrie[i], 2)
                                Citizen.Wait(150)
                                SetVehicleLights(carstrie[i], 0)
                                hasAlreadyLocked = true
                            elseif lock == 2 then
                                --TriggerEvent("Ambiance:PlayUrl", "Keys", "https://www.youtube.com/watch?v=xSc9xaLkxng", 0.4, false)
                                SetVehicleDoorsLocked(carstrie[i], 1)
                                PlayVehicleDoorOpenSound(carstrie[i], 0)
                                Extasy.ShowNotification("~g~Véhicule ouvert")
                                if not IsPedInAnyVehicle(PlayerPedId(), true) then
                                    TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                                end
                                SetVehicleLights(carstrie[i], 2)
                                Citizen.Wait(150)
                                SetVehicleLights(carstrie[i], 0)
                                Citizen.Wait(150)
                                SetVehicleLights(carstrie[i], 2)
                                Citizen.Wait(150)
                                SetVehicleLights(carstrie[i], 0)
                                hasAlreadyLocked = true
                            end
                        else
                            notowned = notowned + 1
                        end
                        if notowned == #carstrie then
                            Extasy.ShowNotification("~r~Aucun véhicule à proximité ne vous appartient")
                        end	
                    end, plate )
                end			
            end
        end
    end
end)

Extasy.RegisterControlKey("change_place_n1", "Place conducteur", "", function()
    if not playerIsOnKeyBoard then
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)

        if not IsHandcuffed then
            if not playerHasCagoule then
                if IsVehicleSeatFree(vehicle, -1) then
                    SetPedIntoVehicle(ped, vehicle, -1)
                end
            end
        else
            Extasy.ShowNotification("~r~Vous ne pouvez pas bouger en étant menotté")
        end
    end
end)

Extasy.RegisterControlKey("change_place_n2", "Place passager", "", function()
    if not playerIsOnKeyBoard then
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)

        if not IsHandcuffed then
            if not playerHasCagoule then
                if IsVehicleSeatFree(vehicle, 0) then
                    SetPedIntoVehicle(ped, vehicle, 0)
                end
            end
        else
            Extasy.ShowNotification("~r~Vous ne pouvez pas bouger en étant menotté")
        end
    end
end)

Extasy.RegisterControlKey("change_place_n3", "Place arrière gauche", "", function()
    if not playerIsOnKeyBoard then
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)

        if not IsHandcuffed then
            if not playerHasCagoule then
                if IsVehicleSeatFree(vehicle, 1) then
                    SetPedIntoVehicle(ped, vehicle, 1)
                end
            end
        else
            Extasy.ShowNotification("~r~Vous ne pouvez pas bouger en étant menotté")
        end
    end
end)

Extasy.RegisterControlKey("change_place_n4", "Place arrière droite", "", function()
    if not playerIsOnKeyBoard then
        local ped = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(ped, false)

        if not IsHandcuffed then
            if not playerHasCagoule then
                if IsVehicleSeatFree(vehicle, 2) then
                    SetPedIntoVehicle(ped, vehicle, 2)
                end
            end
        else
            Extasy.ShowNotification("~r~Vous ne pouvez pas bouger en étant menotté")
        end
    end
end)

Extasy.RegisterControlKey("toggle_limit", "Activer le limitateur de vitesse", "J", function()
    if not playerIsOnKeyBoard then
        if not speed_current then
            local currVehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
            local currCruise = GetEntitySpeed(currVehicle)

            SetEntityMaxSpeed(currVehicle, currCruise)

            currCruise = math.floor(currCruise * 3.6 + 0.5)
            Extasy.ShowNotification("~s~Raccourcis clavier\n~p~Limitateur fixé à "..currCruise.."km/h")
            speed_current = true
        else
            local currVehicle = GetVehiclePedIsUsing(GetPlayerPed(-1))
            local currMaxSpeed = GetVehicleHandlingFloat(currVehicle, "CHandlingData", "fInitialDriveMaxFlatVel")

            SetEntityMaxSpeed(currVehicle, currMaxSpeed)
            Extasy.ShowNotification("~s~Raccourcis clavier\n~p~Limitateur désactivé")
            speed_current = false
        end
    end
end)

EjectStunt = function()
	Veh = GetVehiclePedIsIn(Player, false)
	Vehv = GetEntityVelocity(Veh)
	SetEntityCoords(Player, GetEntityCoords(Veh, 0.0, 0.0, -0.7))
    SetPedToRagdoll(Player, 2800, 2800, 0, 0, 0, 0)
    SetEntityVelocity(Player, Vehv.x * 1.5, Vehv.y * 1.5, Vehv.z)
end

IfInAnimStunt = function()
	if isInAnim then
		InAnim = false
		ClearPedTasks(PlayerPedId())
	end
end

LoadDictStunt = function()
	while not HasAnimDictLoaded('rcmextreme2atv') do
		Wait(20)
		RequestAnimDict('rcmextreme2atv')
	end
	dictLoaded = true
end

SpecificVehicle = function(table, val)
	if SpecificVehicle_state == true then
		for i=1,#table do
			if table[i] == val then
				return true
			end
		end
		return false
	end
	return true
end

Stunt = function(Anim, Start, Mid1, Mid2, Loop, StuntBool)
	isInAnim = true
	Player = PlayerPedId()
	Veh = GetVehiclePedIsIn(Player, false)
	Model = GetEntityModel(Veh)

	StuntOn = StuntBool

	if not dictLoaded then
		LoadDictStunt()
	end

	if IsThisModelABike(Model) then
		--while IsControlPressed(0, key) do
			if not IsEntityPlayingAnim(Player, 'rcmextreme2atv', Anim, 3) then
				TaskPlayAnimAdvanced(Player, 'rcmextreme2atv', Anim, 0, 0, 0, 0, 0, 0, 8.0, 8.0, -1, 0, Start, false, false)
			elseif inKeyAnim then
				inKeyAnim = false
				StuntOn = nil
				return
			elseif GetEntityAnimCurrentTime(Player, 'rcmextreme2atv', Anim) >= Mid1 and GetEntityAnimCurrentTime(Player, 'rcmextreme2atv', Anim) < Mid2 and IsEntityInAir(Veh) then
				TaskPlayAnimAdvanced(Player, 'rcmextreme2atv', Anim, 0, 0, 0, 0, 0, 0, 8.0, 8.0, -1, 0, Loop, false, false)
			end
			Citizen.Wait(50)
		--end 
		StuntOn = nil
	end
end

Extasy.RegisterControlKey("stunt_trick1", "Faire le trix n°1", "MOUSE_LEFT", function()
    if not playerIsOnKeyBoard then
        if SpecificVehicle(Vehicles_stunt, GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))) then
            inKeyAnim = true
            Wait(50)
            inKeyAnim = false
    
            if StuntOn == true or StuntOn == nil then
                Stunt('idle_b', 0.28, 0.5, 0.54, 0.50, true)
                --IfInAnimStunt()
            end
        end
    end
end)

Extasy.RegisterControlKey("stunt_trick2", "Faire le trix n°2", "MOUSE_RIGHT", function()
    if not playerIsOnKeyBoard then
        if SpecificVehicle(Vehicles_stunt, GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))) then
            inKeyAnim = true
            Wait(50)
            inKeyAnim = false
    
            if StuntOn == false or StuntOn == nil then
                Stunt('idle_c', 0.15, 0.44, 0.52, 0.46, false)
                --IfInAnimStunt()
            end
        end
    end
end)

Extasy.RegisterControlKey("stunt_trick3", "Faire le trix n°3", "MOUSE_EXTRABTN1", function()
    if not playerIsOnKeyBoard then
        if SpecificVehicle(Vehicles_stunt, GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))) then
            inKeyAnim = true
            Wait(50)
            inKeyAnim = false
    
            if StuntOn == true or StuntOn == nil then
                Stunt('idle_d', 0.18, 0.69, 0.71, 0.20, true)
                --IfInAnimStunt()
            end
        end
    end
end)

Extasy.RegisterControlKey("stunt_trick4", "Faire le trix n°4", "MOUSE_EXTRABTN2", function()
    if not playerIsOnKeyBoard then
        if SpecificVehicle(Vehicles_stunt, GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsIn(PlayerPedId())))) then
            inKeyAnim = true
            Wait(50)
            inKeyAnim = false
        
            if StuntOn == false or StuntOn == nil then
                Stunt('idle_e', 0.15, 0.35, 0.37, 0.35, false)
                --IfInAnimStunt()
            end
        end
    end
end)

replaceText = function(py)
    menu.n  = GetPlayerName(py)
    menu.n2 = ""
    for i = 1, string.len(menu.n), 1 do
        menu.n2 = menu.n2.."•"
    end

    return menu.n2
end

DrawText3D_Ids = function(coordsx, coordsy, coordsz, text, text2, size)
	local onScreen, x, y = World3dToScreen2d(coordsx, coordsy, coordsz)
	local camCoords      = GetGameplayCamCoords()
	local dist           = GetDistanceBetweenCoords(camCoords, coordsx, coordsy, coordsz, true)
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.0 * scale, 0.55 * scale)
		SetTextFont(4)
		SetTextOutline()
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextCentre(1)
		SetTextEntry('STRING')

		AddTextComponentString(text)
        AddTextComponentString(text2)
		DrawText(x, y)
	end
end

DrawText3D_Id = function(coordsx, coordsy, coordsz, text, text2, size)
	local onScreen, x, y = World3dToScreen2d(coordsx, coordsy, coordsz)
	local camCoords      = GetGameplayCamCoords()
	local dist           = GetDistanceBetweenCoords(camCoords, coordsx, coordsy, coordsz, true)
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 3
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.0 * scale, 0.75 * scale)
		SetTextFont(4)
		SetTextOutline()
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextCentre(1)
		SetTextEntry('STRING')

		AddTextComponentString(text)
        AddTextComponentString(text2)
		DrawText(x, y)
	end
end