-- // OPTIMIZE PAIR!
local ObjectAr = {}
local currObject = 0

-- // BASIC
local InUse = false
local IsTextInUse = false
local PlyLastPos = 0

-- // ANIMATION
local Anim = 'sit'
local AnimScroll = 0

-- // QUAND VOUS ÊTES HORS DE PORTÉE, IL DOSENT TOUS LES MS!
local canSleep = false

CreateThread(function()
    while true do
        Wait(2500)
        if (InUse == false) and (canSleep == true) then
            plyCoords = GetEntityCoords(PlayerPedId(), 0)
            for k, v in pairs(fesseConfig.objects.locations) do
                local oObject = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 1.0, GetHashKey(v.object), 0, 0, 0)
                if (oObject ~= 0) then
                    local oObjectCoords = GetEntityCoords(oObject)
                    local ObjectDistance = #(vector3(oObjectCoords) - plyCoords)
                    if (ObjectDistance < 2) then
                        if (oObject ~= currObject) then
                            currObject = oObject
                            local oObjectExists = DoesEntityExist(oObject)
                            ObjectAr = {
                                fObject = oObject,
                                fObjectCoords = oObjectCoords,
                                fObjectcX = v.verticalOffsetX,
                                fObjectcY = v.verticalOffsetY,
                                fObjectcZ = v.verticalOffsetZ,
                                fObjectDir = v.direction,
                                fObjectIsBed = v.bed
                            }
                        end
                    end
                end
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        canSleep = true
        if ObjectAr.fObject ~= nil then
            ply = PlayerPedId()
            plyCoords = GetEntityCoords(ply, 0)
            ObjectCoords = ObjectAr.ObjectCoords
            local ObjectDistance = #(vector3(ObjectAr.fObjectCoords) - plyCoords)
            if (ObjectDistance < 1.8 and not InUse) then
                if (ObjectAr.fObjectIsBed) == true then
                    
                    --[[ ARROW RIGHT ]]
                    if IsControlJustPressed(0, 175) then -- right
                        if (AnimScroll ~= 2) then
                            AnimScroll = AnimScroll + 1
                        end
                        if AnimScroll == 1 then
                            Anim = "back"
                        elseif AnimScroll == 2 then
                            Anim = "stomach"
                        end
                    end
                    
                    --[[ ARROW LEFT ]]
                    if IsControlJustPressed(0, 174) then -- left
                        if (AnimScroll ~= 0) then
                            AnimScroll = AnimScroll - 1
                        end
                        if AnimScroll == 1 then
                            Anim = "back"
                        elseif AnimScroll == 0 then
                            Anim = "sit"
                        end
                    end
                    
                    if (Anim == 'sit') then
                        
                        -- // Sorry for this shitty space solution :joy: <br> dont work with the buttons ;(
                        DisplayHelpText(fesseConfig.Text.SitOnBed .. '                               ' .. fesseConfig.Text.SwitchBetween, 1)
                    else
                        -- // Sorry for this shitty space solution :joy: <br> dont work with the buttons ;(
                        DisplayHelpText(fesseConfig.Text.LieOnBed .. ' ' .. Anim .. '                          ' .. fesseConfig.Text.SwitchBetween, 1)
                    end
                    if IsControlJustPressed(0, fesseConfig.objects.ButtonToLayOnBed) then
                        TriggerServerEvent('ChairBedSystem:Server:Enter', token, ObjectAr, ObjectAr.fObjectCoords)
                    end
                else
                    DisplayHelpText(fesseConfig.Text.SitOnChair, 1)
                    if IsControlJustPressed(0, fesseConfig.objects.ButtonToSitOnChair) then
                        TriggerServerEvent('ChairBedSystem:Server:Enter', token, ObjectAr, ObjectAr.fObjectCoords)
                    end
                end
            end
            
            if (inUse) then
                DisplayHelpText(fesseConfig.Text.Standup, 0)
                if IsControlJustPressed(0, fesseConfig.objects.ButtonToStandUp) then
                    inUse = false
                    TriggerServerEvent('ChairBedSystem:Server:Leave', token, ObjectAr.fObjectCoords)
                    ClearPedTasksImmediately(ply)
                    FreezeEntityPosition(ply, false)
                    
                    local x, y, z = table.unpack(PlyLastPos)
                    if GetDistanceBetweenCoords(x, y, z, plyCoords) < 10 then
                        SetEntityCoords(ply, PlyLastPos)
                    end
                end
            end
        end
        if canSleep then
            Citizen.Wait(2500)
        end
    end
end)

CreateThread(function()
	while fesseConfig.Healing ~= 0 do
		Wait(fesseConfig.Healing*1000)
		if inUse == true then
			if ObjectAr.fObjectIsBed == true then
				local health = GetEntityHealth(oPlayer)
				if health <= 199 then
					SetEntityHealth(oPlayer,health+1)
				end
			end
		end
	end
end)

RegisterNetEvent('ChairBedSystem:Client:Animation')
AddEventHandler('ChairBedSystem:Client:Animation', function(v, objectcoords)
    local object = v.fObject
    local vertx = v.fObjectcX
    local verty = v.fObjectcY
    local vertz = v.fObjectcZ
    local dir = v.fObjectDir
    local isBed = v.fObjectIsBed
    local objectcoords = v.fObjectCoords
    
    local ped = PlayerPedId()
    PlyLastPos = GetEntityCoords(ped)
    FreezeEntityPosition(object, true)
    FreezeEntityPosition(ped, true)
    inUse = true
    if isBed == false then
        if fesseConfig.objects.SitAnimation.dict ~= nil then
            SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
            SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
            local dict = fesseConfig.objects.SitAnimation.dict
            local anim = fesseConfig.objects.SitAnimation.anim
            
            AnimLoadDict(dict, anim, ped)
        else
            TaskStartScenarioAtPosition(ped, fesseConfig.objects.SitAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true)
        end
    else
        if Anim == 'back' then
            if fesseConfig.objects.BedBackAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = fesseConfig.objects.BedBackAnimation.dict
                local anim = fesseConfig.objects.BedBackAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, fesseConfig.objects.BedBackAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true
            )
            end
        elseif Anim == 'stomach' then
            if fesseConfig.objects.BedStomachAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = fesseConfig.objects.BedStomachAnimation.dict
                local anim = fesseConfig.objects.BedStomachAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, fesseConfig.objects.BedStomachAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true)
            end
        elseif Anim == 'sit' then
            if fesseConfig.objects.BedSitAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = fesseConfig.objects.BedSitAnimation.dict
                local anim = fesseConfig.objects.BedSitAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, fesseConfig.objects.BedSitAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + 180.0, 0, true, true)
            end
        end
    end
end)

function DisplayHelpText(text, sound)
    canSleep = false
    AddTextEntry('label', text)
    BeginTextCommandDisplayHelp('label')
    DisplayHelpTextFromStringLabel(0, 0, sound, -1)
    EndTextCommandDisplayText(0.5, 0.5)
end


function Animation(dict, anim, ped)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    
    TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
end



RegisterCommand("wander", function(source, args, rawCommand)
    local pPed = GetPlayerPed(-1)
    local pVeh = GetVehiclePedIsIn(pPed, false)
    TaskVehicleDriveWander(pPed, pVeh, 150.0, 786603)
end, false)