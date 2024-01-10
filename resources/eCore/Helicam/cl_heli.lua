
local fov_max = 80.0
local fov_min = 10.0
local zoomspeed = 2.0
local speed_lr = 3.0
local speed_ud = 3.0
local toggle_helicam = 51
local toggle_vision = 25
local toggle_rappel = 154
local toggle_lock_on = 22
local time = 3000
local helicam = false
local fov = (fov_max+fov_min)*0.5
local vision_state = 0


Citizen.CreateThread(function()
	while true do
        Wait(time)
        if IsPlayerInPolmav() or IsPlayerInas332() then
            time = 0
            local lPed = GetPlayerPed(-1)
            local heli = GetVehiclePedIsIn(lPed)
            
            if IsHeliHighEnough(heli) then
                if IsControlJustPressed(0, toggle_helicam) then
                    PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                    helicam = true
                end
            
                if IsControlJustPressed(0, toggle_rappel) then 
                    if GetPedInVehicleSeat(heli, 1) == lPed or GetPedInVehicleSeat(heli, 2) == lPed then
                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                        TaskRappelFromHeli(GetPlayerPed(-1), 1)
                    else
                        Extasy.ShowNotification("~r~Tu ne peut pas dessendre en rappel de ce siège !")
                        PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", false) 
                    end
                end
            end
            

            if helicam then
                SetTimecycleModifier("heliGunCam")
                SetTimecycleModifierStrength(0.3)
                local scaleform = RequestScaleformMovie("HELI_CAM")
                while not HasScaleformMovieLoaded(scaleform) do
                    Citizen.Wait(0)
                end
                local lPed = GetPlayerPed(-1)
                local heli = GetVehiclePedIsIn(lPed)
                local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
                AttachCamToEntity(cam, heli, 0.0,0.0,-1.5, true)
                SetCamRot(cam, 0.0,0.0,GetEntityHeading(heli))
                SetCamFov(cam, fov)
                RenderScriptCams(true, false, 0, 1, 0)
                PushScaleformMovieFunction(scaleform, "SET_CAM_LOGO")
                PushScaleformMovieFunctionParameterInt(0) 
                PopScaleformMovieFunctionVoid()
                local locked_on_vehicle = nil
                while helicam and not IsEntityDead(lPed) and (GetVehiclePedIsIn(lPed) == heli) and IsHeliHighEnough(heli) do
                    if IsControlJustPressed(0, toggle_helicam) then 
                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                        helicam = false
                    end
                    if IsControlJustPressed(0, toggle_vision) then
                        PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                        ChangeVision()
                    end
    
                    if locked_on_vehicle then
                        if DoesEntityExist(locked_on_vehicle) then
                            PointCamAtEntity(cam, locked_on_vehicle, 0.0, 0.0, 0.0, true)
                            RenderVehicleInfo(locked_on_vehicle)
                            if IsControlJustPressed(0, toggle_lock_on) then
                                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                locked_on_vehicle = nil
                                local rot = GetCamRot(cam, 2)
                                local fov = GetCamFov(cam)
                                local old cam = cam
                                DestroyCam(old_cam, false)
                                cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA", true)
                                AttachCamToEntity(cam, heli, 0.0,0.0,-1.5, true)
                                SetCamRot(cam, rot, 2)
                                SetCamFov(cam, fov)
                                RenderScriptCams(true, false, 0, 1, 0)
                            end
                        else
                            locked_on_vehicle = nil 
                        end
                    else
                        local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
                        CheckInputRotation(cam, zoomvalue)
                        local vehicle_detected = GetVehicleInView(cam)
                        if DoesEntityExist(vehicle_detected) then
                            RenderVehicleInfo(vehicle_detected)
                            if IsControlJustPressed(0, toggle_lock_on) then
                                PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                locked_on_vehicle = vehicle_detected
                            end
                        end
                    end
                    HandleZoom(cam)
                    HideHUDThisFrame()
                    PushScaleformMovieFunction(scaleform, "SET_ALT_FOV_HEADING")
                    PushScaleformMovieFunctionParameterFloat(GetEntityCoords(heli).z)
                    PushScaleformMovieFunctionParameterFloat(zoomvalue)
                    PushScaleformMovieFunctionParameterFloat(GetCamRot(cam, 2).z)
                    PopScaleformMovieFunctionVoid()
                    DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
                    Citizen.Wait(0)
                end
                helicam = false
                ClearTimecycleModifier()
                fov = (fov_max+fov_min)*0.5 
                RenderScriptCams(false, false, 0, 1, 0) 
                SetScaleformMovieAsNoLongerNeeded(scaleform)
                DestroyCam(cam, false)
                SetNightvision(false)
                SetSeethrough(false)
            end	
		else
            time = 3000
            Wait(time)
        end
	end
end)


IsPlayerInPolmav = function()
	local lPed = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(lPed)
	return IsVehicleModel(vehicle, GetHashKey("polmav"))
end

IsPlayerInas332 = function()
	local lPed = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(lPed)
	return IsVehicleModel(vehicle, GetHashKey("as332"))
end

IsHeliHighEnough = function(heli)
	return GetEntityHeightAboveGround(heli) > 1.5
end

ChangeVision = function()
	if vision_state == 0 then
		SetNightvision(true)
		vision_state = 1
	elseif vision_state == 1 then
		SetNightvision(false)
		SetSeethrough(true)
		vision_state = 2
	else
		SetSeethrough(false)
		vision_state = 0
	end
end

HideHUDThisFrame = function()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(19) 
	HideHudComponentThisFrame(1) 
	HideHudComponentThisFrame(2) 
	HideHudComponentThisFrame(3) 
	HideHudComponentThisFrame(4) 
	HideHudComponentThisFrame(13) 
	HideHudComponentThisFrame(11) 
	HideHudComponentThisFrame(12) 
	HideHudComponentThisFrame(15) 
	HideHudComponentThisFrame(18) 
end

CheckInputRotation = function(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0, 220)
	local rightAxisY = GetDisabledControlNormal(0, 221)
	local rotation = GetCamRot(cam, 2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0, rotation.x + rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)), -89.5) 
		SetCamRot(cam, new_x, 0.0, new_z, 2)
	end
end

HandleZoom = function(cam)
	if IsControlJustPressed(0,241) then 
		fov = math.max(fov - zoomspeed, fov_min)
	end
	if IsControlJustPressed(0,242) then
		fov = math.min(fov + zoomspeed, fov_max) 	
	end
	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then 
		fov = current_fov
	end
	SetCamFov(cam, current_fov + (fov - current_fov)*0.05) 
end

GetVehicleInView = function(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam, 2))
	local rayhandle = CastRayPointToPoint(coords, coords+(forward_vector*200.0), 10, GetVehiclePedIsIn(GetPlayerPed(-1)), 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

RenderVehicleInfo = function(vehicle)
	local model = GetEntityModel(vehicle)
	local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
	local licenseplate = GetVehicleNumberPlateText(vehicle)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.55)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString("Model de la voiture: "..vehname.."\nPlaque: "..licenseplate)
	DrawText(0.45, 0.9)
end


RotAnglesToVec = function(rot)
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end