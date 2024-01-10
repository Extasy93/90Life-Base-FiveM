function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
    AddTextEntry(entryTitle, textEntry)
    DisplayOnscreenKeyboard(1, entryTitle, "", inputText, "", "", "", maxLength)
	blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
		blockinput = false
        return result
    else
        Citizen.Wait(500)
		blockinput = false
        return nil
    end
end

Citizen.CreateThread(function()
    for i = 1, 43 do
        table.insert(Config.TypeMarker, i)
    end
    for i = 1, 10 do
        table.insert(Config.HeightMarker, i)
    end
    for i = 1, 8 do
        table.insert(Config.RotateMarker, i)
    end

end)

function TeleportBlips()
    local entity = PlayerPedId()
    if IsPedInAnyVehicle(entity, false) then
        entity = GetVehiclePedIsUsing(entity)
    end
    local success = false
    local blipFound = false
    local blipIterator = GetBlipInfoIdIterator()
    local blip = GetFirstBlipInfoId(8)
    while DoesBlipExist(blip) do
        if GetBlipInfoIdType(blip) == 4 then
            cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(), Citizen.ResultAsVector()))
            blipFound = true
            break
        end
        blip = GetNextBlipInfoId(blipIterator)
        Wait(0)
    end
    if blipFound then
        local groundFound = false
        local yaw = GetEntityHeading(entity)
        for i = 0, 1000, 1 do
            SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
            SetEntityRotation(entity, 0, 0, 0, 0, 0)
            SetEntityHeading(entity, yaw)
            Wait(0)
            if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then
                cz = ToFloat(i)
                groundFound = true
                break
            end
        end
        if not groundFound then
            cz = -300.0
        end
        success = true
    else
        ESX.ShowNotification("~r~Aucun point sur la carte")
    end
    if success then
        ESX.ShowNotification("~g~Vous avez été téléporter sur le marker avec succès")
        SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            if GetPedInVehicleSeat(GetVehiclePedIsUsing(PlayerPedId()), -1) == PlayerPedId() then
                SetVehicleOnGroundProperly(GetVehiclePedIsUsing(PlayerPedId()))
            end
        end
    end
end

function CreateCamProps()
    camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(camera, -1267.07, -3025.49, -48.49)
    SetCamFov(camera, 45.0)
    AttachCamToEntity(SpawnProps, PlayerPedId())
	RenderScriptCams(1, 1, 1000, 1, 1)
end

function TeleportIPLProps()
    GetOldEntityCoord = GetEntityCoords(PlayerPedId())
    DoScreenFadeOut(1000)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), -1267.07, -3025.49, -48.49)
    TriggerServerEvent("cxDevTool:setPlayerToBucket")
    SetEntityVisible(PlayerPedId(), false)
    Wait(500)
    DoScreenFadeIn(1000)
    CreateCamProps()
end

function ReturnOldPosition()
    DoScreenFadeOut(1000)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(camera, false)
    DeleteEntity(SpawnProps)
    Wait(1000)
    SetEntityCoords(PlayerPedId(), GetOldEntityCoord)
    TriggerServerEvent("cxDevTool:setPlayerToNormalBucket")
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(1000)
end