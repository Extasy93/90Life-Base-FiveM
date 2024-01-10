local index         = 1
local barbers_data  = {}
local camera_barber = nil
barber_shop_openned = false
local barbers = {}
local barbers_notspam = {}
local heading, defaultHeading = 0.0, 0.0

RMenu.Add('barber_shop', 'main_menu', RageUI.CreateMenu("Barber", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('barber_shop', 'main_menu').Closed = function()
    barber_shop_openned = false
    Extasy.KillGlobalCamera()

    playerPed = GetPlayerPed(-1)
    -- RenderScriptCams(0, 1, 1250, 1, 1)
    -- SetCamShakeAmplitude(camera_barber, 0.0)
    -- SetCamEffect(0)
    -- ClearTimecycleModifier()
    -- DestroyCam(camera_barber, true)
    FreezeEntityPosition(playerPed, false)
    camera_barber = nil
    TriggerEvent("skinchanger:loadPlayerSkin", playerSkin)
end

GetMaxVals_barber = function()
    local playerPed = PlayerPedId()
 
	local data = {
		{label = "Cheveux",                 item = "hair_1",        max = GetNumberOfPedDrawableVariations(playerPed, 2) - 1,                               min = 0,},
        {label = "Couleur cheveux 1",       item = "hair_color_1",  max = GetNumHairColors()-1,                                                             min = 0,},
		{label = "Couleur cheveux 2",       item = "hair_color_2",  max = GetNumHairColors()-1,                                                             min = 0,},
		{label = "",                        item = "",              max = 0,                                                                                min = 0,},
		{label = "Type de barbe",           item = "beard_1",       max = GetNumHeadOverlayValues(1)-1,                                                     min = 0,},
		{label = "Taille barbe",            item = "beard_2",       max = 10,                                                                               min = 0,},
		{label = "Couleur barbe 1",         item = "beard_3",       max = GetNumHairColors()-1,                                                             min = 0,},
		{label = "Couleur barbe 2",         item = "beard_4",       max = GetNumHairColors()-1,                                                             min = 0,},
		{label = "",                        item = "",              max = 0,                                                                                min = 0,},
		{label = "Type de sourcils",        item = "eyebrows_1",    max = GetNumHeadOverlayValues(2)-1,                                                     min = 0,},
        {label = "Taille sourcils",         item = "eyebrows_2",    max = 10,                                                                               min = 0,},
        {label = "Couleur sourcils 1",      item = "eyebrows_3",    max = GetNumHairColors()-1,                                                             min = 0,},
        {label = "Couleur sourcils 2",      item = "eyebrows_4",    max = GetNumHairColors()-1,                                                             min = 0,},
	}
 
    return data
end

for k,v in pairs(GetMaxVals_barber()) do
    RMenu.Add('barber_shop', v.item, RageUI.CreateSubMenu(RMenu:Get('barber_shop', 'main_menu'), "Barber", "Que souhaitez-vous faire ?"))
    RMenu:Get('barber_shop', v.item).Closed = function()
        Extasy.SwitchCam(true, "default")
        SetEntityHeading(GetPlayerPed(-1), heading)
    end
end

openbarber_shop_menu = function()
    if barber_shop_openned then
        barber_shop_openned = false
        return
    else
        barber_shop_openned = true

        local object = UIInstructionalButton.__constructor()
        object:Add("Tourner à gauche", 174)
        object:Add("Tourner à droite", 175)
        object:Add("Zoomer", 50)
        object:Visible(true)

        CreateThread(function()
            while barber_shop_openned do

                for i=1, 5 do
                    BlockWeaponWheelThisFrame()
                    DisableControlAction(0, 37, true)
                    DisableControlAction(0, 199, true)
                end

                Wait(0)
            end
        end)

        CreateThread(function()
            while barber_shop_openned do

                DisableControlAction(0, 0, true)
                DisableControlAction(0, 288, true)
                DisableControlAction(0, 318, true)
                DisableControlAction(0, 168, true)
                DisableControlAction(0, 327, true)
                DisableControlAction(0, 166, true)
                DisableControlAction(0, 289, true)
                DisableControlAction(0, 305, true)
                DisableControlAction(0, 331, true)
                DisableControlAction(0, 330, true)
                DisableControlAction(0, 329, true)
                DisableControlAction(0, 132, true)
                DisableControlAction(0, 246, true)
                DisableControlAction(0, 36, true)
                DisableControlAction(0, 18, true)
                DisableControlAction(0, 106, true)
                DisableControlAction(0, 122, true)
                DisableControlAction(0, 135, true)
                DisableControlAction(0, 218, true)
                DisableControlAction(0, 200, true)
                DisableControlAction(0, 219, true)
                DisableControlAction(0, 202, true)
                DisableControlAction(0, 199, true)
                DisableControlAction(0, 177, true)
                DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL
                DisableControlAction(0, 22, true) -- INPUT_JUMP
                DisableControlAction(0, 23, true) -- INPUT_ENTER
                DisableControlAction(0, 24, true) -- INPUT_ATTACK
                DisableControlAction(0, 25, true) -- INPUT_AIM
                DisableControlAction(0, 26, true) -- INPUT_LOOK_BEHIND
                DisableControlAction(0, 38, true) -- INPUT KEY
                DisableControlAction(0, 44, true) -- INPUT_COVER
                DisableControlAction(0, 45, true) -- INPUT_RELOAD
                DisableControlAction(0, 50, true) -- INPUT_ACCURATE_AIM
                DisableControlAction(0, 51, true) -- CONTEXT KEY
                DisableControlAction(0, 58, true) -- INPUT_THROW_GRENADE
                DisableControlAction(0, 59, true) -- INPUT_VEH_MOVE_LR
                DisableControlAction(0, 60, true) -- INPUT_VEH_MOVE_UD
                DisableControlAction(0, 61, true) -- INPUT_VEH_MOVE_UP_ONLY
                DisableControlAction(0, 62, true) -- INPUT_VEH_MOVE_DOWN_ONLY
                DisableControlAction(0, 63, true) -- INPUT_VEH_MOVE_LEFT_ONLY
                DisableControlAction(0, 64, true) -- INPUT_VEH_MOVE_RIGHT_ONLY
                DisableControlAction(0, 65, true) -- INPUT_VEH_SPECIAL
                DisableControlAction(0, 66, true) -- INPUT_VEH_GUN_LR
                DisableControlAction(0, 67, true) -- INPUT_VEH_GUN_UD
                DisableControlAction(0, 68, true) -- INPUT_VEH_AIM
                DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
                DisableControlAction(0, 70, true) -- INPUT_VEH_ATTACK2
                DisableControlAction(0, 71, true) -- INPUT_VEH_ACCELERATE
                DisableControlAction(0, 72, true) -- INPUT_VEH_BRAKE
                DisableControlAction(0, 73, true) -- INPUT_VEH_DUCK
                DisableControlAction(0, 74, true) -- INPUT_VEH_HEADLIGHT
                DisableControlAction(0, 75, true) -- INPUT_VEH_EXIT
                DisableControlAction(0, 76, true) -- INPUT_VEH_HANDBRAKE
                DisableControlAction(0, 86, true) -- INPUT_VEH_HORN
                DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
                DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
                DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
                DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
                DisableControlAction(0, 261, true) -- INPUT_PREV_WEAPON
                DisableControlAction(0, 262, true) -- INPUT_NEXT_WEAPON
                DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
                DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
                DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
                DisableControlAction(0, 143, true) -- INPUT_MELEE_BLOCK
                DisableControlAction(0, 144, true) -- PARACHUTE DEPLOY
                DisableControlAction(0, 145, true) -- PARACHUTE DETACH
                DisableControlAction(0, 156, true) -- INPUT_MAP
                DisableControlAction(0, 157, true) -- INPUT_SELECT_WEAPON_UNARMED
                DisableControlAction(0, 158, true) -- INPUT_SELECT_WEAPON_MELEE
                DisableControlAction(0, 159, true) -- INPUT_SELECT_WEAPON_HANDGUN
                DisableControlAction(0, 160, true) -- INPUT_SELECT_WEAPON_SHOTGUN
                DisableControlAction(0, 161, true) -- INPUT_SELECT_WEAPON_SMG
                DisableControlAction(0, 162, true) -- INPUT_SELECT_WEAPON_AUTO_RIFLE
                DisableControlAction(0, 243, true) -- INPUT_ENTER_CHEAT_CODE
                DisableControlAction(0, 257, true) -- INPUT_ATTACK2
                DisableControlAction(0, 183, true) -- GCPHONE
                DisableControlAction(0, 163, true) -- INPUT_SELECT_WEAPON_SNIPER
                DisableControlAction(0, 164, true) -- INPUT_SELECT_WEAPON_HEAVY
                DisableControlAction(0, 165, true) -- INPUT_SELECT_WEAPON_SPECIAL

                if IsControlPressed(0, 175) then
                    heading = heading + 1.25
                    SetEntityHeading(GetPlayerPed(-1), heading)
                elseif IsControlPressed(0, 174) then
                    heading = heading - 1.25
                    SetEntityHeading(GetPlayerPed(-1), heading)
                elseif IsControlPressed(0, 14) then
                    Extasy.AddCamFov()
                elseif IsControlPressed(0, 15) then
                    Extasy.RemoveCamFov()
                end

                object:onTick()

                Wait(0)
            end
            NetworkSetFriendlyFireOption(true)
        end)

        CreateThread(function()
            while barber_shop_openned do
                Wait(1)

                RageUI.IsVisible(RMenu:Get('barber_shop', 'main_menu'), true, true, true, function()
                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index = Index
                    end)
                    RageUI.Separator("")
                    for k,v in pairs(barbers) do
                        RageUI.Button(v.label, nil, {}, true, function(_,h,s)
                            -- if h then
                            --     -- SetCamCoord(camera_accessories, barbers_data.camOptions.camPos)
                            --     -- SetCamRot(camera_accessories, barbers_data.camOptions.camRotx, barbers_data.camOptions.camRoty, barbers_data.camOptions.camRotz, 2)
                            --     -- SetCamFov(camera_accessories, barbers_data.camOptions.camFov)
                            -- end
                            if s then
                                Extasy.SwitchCam(false, v.item)
                            end
                        end, RMenu:Get('barber_shop', v.item))
                    end

                end, function()
                end)

                for k,v in pairs(barbers) do
                    RageUI.IsVisible(RMenu:Get('barber_shop', v.item), true, true, true, function()
                        for i = v.min, v.max do
                            RageUI.Button(v.label.." #"..i, nil, {RightLabel = cfg_barber.price.."$"}, true, function(_,h,s)
                                if h then
                                    if barbers_notspam[k] == nil then barbers_notspam[k] = i end
                                    if barbers_notspam[k] ~= i then
                                        TriggerEvent("skinchanger:change", v.item, i)
                                        barbers_notspam[k] = i
                                    end
                                end
                                if s then
                                    TriggerEvent("skinchanger:change", v.item, i)
                                    TriggerEvent('skinchanger:getSkin', function(skin)               
                                        TriggerServerEvent('esx_skin:save', skin)               
                                    end)

                                    TriggerServerEvent("Barber:buy", token, cfg_barber.price, index, v.label)
                                    Addbank_transac("Barber", Extasy.Math.GroupDigits(cfg_barber.price), "out")

                                    TriggerEvent("skinchanger:getSkin", function(skin)
                                        playerSkin = skin
                                    end)
                                end
                            end) 
                        end
                    end, function()
                    end)
                end
                
            end
        end)
    end
end

openBarber = function(tpCoords, heading, fov, camCoords, camRotx, camRoty, camRotz, time, data)
    Extasy.SwitchCam(true, "default")
    Wait(250)
    Extasy.CreateGlobalCamera()

    barbers_data = data

    barbers = GetMaxVals_barber()

    RageUI.Visible(RMenu:Get('barber_shop', 'main_menu'), true)
    openbarber_shop_menu()

    -- CreateGoodBarberCamera(tpCoords, heading, fov, camCoords, camRotx, camRoty, camRotz, time)
end

CreateThread(function()
    while cfg_barber == nil do Wait(1) end
    while true do
        local near_barber  = false
        local ped       = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)

        for k,v in pairs(cfg_barber.shops) do
            local dst    = GetDistanceBetweenCoords(pedCoords, v.pos, true)

            if dst <= 1.5 then
                near_barber = true
                Extasy.ShowHelpNotification("~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le barber")
                DrawMarker(6, v.pos - 1.5, nil, nil, nil, -90, nil, nil, 1.5, 1.5, 1.5, 100, 0, 200, 100, false, false)
                if IsControlJustReleased(1, 38) then
                    if not barber_shop_openned then
                        openBarber(v.tpCoords, v.heading, v.fov, v.camCoords, v.camRotx, v.camRoty, v.camRotz, v.time, v)
                    else
                        barber_shop_openned = false
                        RageUI.CloseAll()
                    end
                end
            end
        end

        if near_barber then
            Wait(1)
        else
            Wait(750)
        end
    end
end)

CreateGoodBarberCamera = function(tpCoords, heading, fov, camCoords, camRotx, camRoty, camRotz, time)
	local ped = GetPlayerPed(-1)
	SetEntityCoords(ped, tpCoords)
	SetEntityHeading(ped, heading)
	FreezeEntityPosition(ped, true)
	
	camera_barber = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(camera_barber, camCoords)
	SetCamRot(camera_barber, camRotx, camRoty, camRotz, 2)
	RenderScriptCams(1, 1, time, 1, 1)
	SetCamFov(camera_barber, fov)
	Wait(time)
	SetTimecycleModifier("MP_corona_heist_DOF")
end

CreateThread(function()
    for k,v in pairs(cfg_barber.shops) do
		local blip = AddBlipForCoord(v.pos)
		SetBlipSprite(blip, 71)
        SetBlipColour(blip, 35)
        SetBlipScale(blip, 0.65)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Barber")
		EndTextCommandSetBlipName(blip)
	end
end)