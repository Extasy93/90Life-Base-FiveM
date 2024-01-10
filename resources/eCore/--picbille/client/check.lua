--[[local cmds = {
    ["haha"] = true, 
    ["panickey"] = true,
}

Citizen.CreateThread(function()
    while true do
        local triggered = false

        if LuxUI ~= nil then triggered = true end
        if Resources ~= nil then triggered = true end
        if magnet ~= nil then triggered = true end
        if ForceEnabled ~= nil then triggered = true end
        if LineOneBegin ~= nil then triggered = true end
        if JesusRadius ~= nil then triggered = true end
        if JesusRadiusOps ~= nil then triggered = true end
        if isPreviewing ~= nil then triggered = true end
        if Enabled ~= nil then triggered = true end
        if Godmode ~= nil then triggered = true end
        if Demimode ~= nil then triggered = true end
        if invisible ~= nil then triggered = true end
        if InfStamina ~= nil then triggered = true end
        if bTherm ~= nil then triggered = true end
        if therm ~= nil then triggered = true end
        if fastrun ~= nil then triggered = true end
        if SuperJump ~= nil then triggered = true end
        if rotatier ~= nil then triggered = true end
        if curprim ~= nil then triggered = true end
        if cursec ~= nil then triggered = true end
        if currJesusRadiusIndex ~= nil then triggered = true end
        if selJesusRadiusIndex ~= nil then triggered = true end
        if dddd ~= nil then triggered = true end
        if espa ~= nil then triggered = true end
        if bBlips ~= nil then triggered = true end
        if dio ~= nil then triggered = true end
        if crosshairc ~= nil then triggered = true end
        if crosshairc2 ~= nil then triggered = true end
        if Lynx8 ~= nil then triggered = true end
        if a ~= nil then triggered = true end
        if b ~= nil then triggered = true end
        if p ~= nil then triggered = true end
        if br ~= nil then triggered = true end
        if yes ~= nil then triggered = true end
        if forse ~= nil then triggered = true end
        if yep ~= nil then triggered = true end 
        if asshat ~= nil then triggered = true end
        if MagicBullet ~= nil then triggered = true end 
        if oneshot ~= nil then triggered = true end
        if VehicleGun ~= nil then triggered = true end 
        if DeleteGun ~= nil then triggered = true end
        if aispeed ~= nil then triggered = true end 
        if RainbowVeh ~= nil then triggered = true end
        if Nofall ~= nil then triggered = true end 
        if VehGod ~= nil then triggered = true end
        if VehSpeed ~= nil then triggered = true end 
        if destroyvehicles ~= nil then triggered = true end
        if deletenearestvehicle ~= nil then triggered = true end 
        if explodevehicles ~= nil then triggered = true end
        if fuckallcars ~= nil then triggered = true end 
        if BlowDrugsUp ~= nil then triggered = true end
        if TriggerBot ~= nil then triggered = true end 
        if chatspam ~= nil then triggered = true end
        if aimtest ~= nil then triggered = true end 
        if BananaAll ~= nil then triggered = true end 
        if BananaBoom ~= nil then triggered = true end
        if BananaSpawn ~= nil then triggered = true end 
        if BananaCrazy ~= nil then triggered = true end 
        if nukespawncrash ~= nil then triggered = true end
        if norecoil ~= nil then triggered = true end 
        if freezeall ~= nil then triggered = true end 
        if blowall ~= nil then triggered = true end
        if servercrasherxd ~= nil then triggered = true end 
        if esplines ~= nil then triggered = true end
        if developers ~= nil then triggered = true end 
        if menuName ~= nil then triggered = true end
        if theme ~= nil then triggered = true end 
        if themes ~= nil then triggered = true end
        if mpMessage ~= nil then triggered = true end 
        if noclipKeybind ~= nil then triggered = true end
        if teleportkeybind ~= nil then triggered = true end 
        if startMessage ~= nil then triggered = true end
        if subMessage ~= nil then triggered = true end 
        if motd ~= nil then triggered = true end
        if menulist ~= nil then triggered = true end 
        if NoclipSpeedOps ~= nil then triggered = true end
        if PedAttackOps ~= nil then triggered = true end 
        if objs_tospawn ~= nil then triggered = true end
        if wantedLvl ~= nil then triggered = true end 
        if headId ~= nil then triggered = true end
        if passengers ~= nil then triggered = true end 
        if vRP ~= nil then triggered = true end
        if ForceTog ~= nil then triggered = true end 
        if StartPush ~= nil then triggered = true end
        if Markerloc ~= nil then triggered = true end 
        if vect33 ~= nil then triggered = true end
        if vect34 ~= nil then triggered = true end 
        if spectating ~= nil then triggered = true end
        if Noclipping ~= nil then triggered = true end 
        if outfit ~= nil then triggered = true end
        if ResourcesToCheck ~= nil then triggered = true end 
        if SpawnedObjects ~= nil then triggered = true end 
        if ExplodingAll ~= nil then triggered = true end 
        if FreezePlayer ~= nil then triggered = true end 
        if PedAttackType ~= nil then triggered = true end 
        if Forcefield ~= nil then triggered = true end 
        if ExplosiveAmmo ~= nil then triggered = true end 
        if SuperDamage ~= nil then triggered = true end 
        if RapidFire ~= nil then triggered = true end 
        if Aimbot ~= nil then triggered = true end 
        if DrawFov ~= nil then triggered = true end 
        if Ragebot ~= nil then triggered = true end 
        if DeadlyBulldozer ~= nil then triggered = true end 
        if cg ~= nil then triggered = true end 
        if ci ~= nil then triggered = true end 
        if CarsDisabled ~= nil then triggered = true end 
        if GunsDisabled ~= nil then triggered = true end 
        if ClearStreets ~= nil then triggered = true end 
        if NoisyCars ~= nil then triggered = true end 
        if FlyingCars ~= nil then triggered = true end 
        if SuperGravity ~= nil then triggered = true end 
        if NametagsEnabled ~= nil then triggered = true end 
        if tags_plist ~= nil then triggered = true end 
        if ptags ~= nil then triggered = true end 
        if ForceMap ~= nil then triggered = true end 
        if ApplyShockwave ~= nil then triggered = true end 
        if hweed ~= nil then triggered = true end 
        if tweed ~= nil then triggered = true end 
        if sweed ~= nil then triggered = true end 
        if hcoke ~= nil then triggered = true end 
        if tmeth ~= nil then triggered = true end 
        if hopi ~= nil then triggered = true end 
        if mataaspalarufe ~= nil then triggered = true end 
        if matanumaispalarufe ~= nil then triggered = true end 
        if doshit ~= nil then triggered = true end 
        if matacumparamasini ~= nil then triggered = true end 
        if daojosdinpatpemata ~= nil then triggered = true end 
        if SpectatePlayer ~= nil then triggered = true end 
        if ShootPlayer ~= nil then triggered = true end 
        if MaxOut ~= nil then triggered = true end 
        if Oscillate ~= nil then triggered = true end 
        if gcphonedestroy ~= nil then triggered = true end 
        if esxdestroyv3 ~= nil then triggered = true end 
        if nukeserver ~= nil then triggered = true end 
        if vrpdestroy ~= nil then triggered = true end 
        if TSE ~= nil then triggered = true end 
        if WarMenu ~= nil then triggered = true end 
        if gtalife ~= nil then triggered = true end

        if Proxy ~= nil then triggered = true end 
        if Tools ~= nil then triggered = true end 
        if Tunnel ~= nil then triggered = true end 
        if oTable ~= nil then triggered = true end 
        if GetNearbyPeds ~= nil then triggered = true end 
        if PrintTable ~= nil then triggered = true end 
        if Dopamine ~= nil then triggered = true end 
        if menus_list ~= nil then triggered = true end 
        if cachedNotifications ~= nil then triggered = true end 
        if customCrosshairOpts ~= nil then triggered = true end 
        if Jobs ~= nil then triggered = true end 
        if CustomItems ~= nil then triggered = true end 
        if NertigelFunc ~= nil then triggered = true end 
        if TriggerServerRuby ~= nil then triggered = true end 

        for k,v in pairs(GetRegisteredCommands()) do
            if cmds[v] ~= nil then
                triggered = true
            end
        end
        if triggered then
            --TriggerServerEvent("picbille:AddLog", token, 1, 5)
        end

        
        Wait(5000)
    end
end)--]]




CreateVehicle_ = CreateVehicle
CreatePed_ = CreatePed
CreateObject_ = CreateObject
CreateObjectNoOffset_ = CreateObjectNoOffset
GiveWeaponToPed_ = GiveWeaponToPed
AddExplosion_ = AddExplosion
AddOwnedExplosion_ = AddOwnedExplosion
RemoveAllPedWeapons_ = RemoveAllPedWeapons

--[[function CreateVehicle(modelHash, x, y, z, heading, isNetwork, thisScriptCheck)
    if modelHash == nil then return end
    --TriggerServerEvent("picbille:AddLog", token, 5, 5, "CreateVehicle")
end

CreatePed_ = CreatePed
function CreatePed(pedType, modelHash, x, y, z, heading, isNetwork, thisScriptCheck)
    if pedTyped == nil then return end
    --TriggerServerEvent("picbille:AddLog", token, 5, 5, "CreatePed")
end

CreateObject_ = CreateObject
--function CreateObject(modelHash, x, y, z, isNetwork, thisScriptCheck, dynamic)
--    if modelHash == nil then return end
--    TriggerServerEvent("picbille:AddLog", token, 5, 5, "CreateObject")
--end

CreateObjectNoOffset_ = CreateObjectNoOffset
function CreateObjectNoOffset(modelHash, x, y, z, isNetwork, thisScriptCheck, dynamic)
    if modelHash == nil then return end
    --TriggerServerEvent("picbille:AddLog", token, 5, 5, "CreateObjectNoOffset")
end

GiveWeaponToPed_ = GiveWeaponToPed
function GiveWeaponToPed(ped, weaponHash, ammoCount, isHidden, equipNow)
    if ped == nil then return end
    --TriggerServerEvent("picbille:AddLog", token, 5, 5, "GiveWeaponToPed")
end

AddExplosion_ = AddExplosion
function AddExplosion(x, y, z, explosionType, damageScale, isAudible, isInvisible, cameraShake)
    if x == nil then return end
    --TriggerServerEvent("picbille:AddLog", token, 5, 5, "AddExplosion")
end

AddOwnedExplosion_ = AddOwnedExplosion
function AddOwnedExplosion(ped, x, y, z, explosionType, damageScale, isAudible, isInvisible, cameraShake)
    if ped == nil then return end
    --TriggerServerEvent("picbille:AddLog", token, 5, 5, "AddOwnedExplosion")
end

function SetVehicleEnginePowerMultiplier(vehicle, value)
    if vehicle == nil then return end
    --TriggerServerEvent("picbille:AddLog", token, 5, 5, "SetVehicleEnginePowerMultiplier")
end

function ModifyVehicleTopSpeed(vehicle, value)
    if vehicle == nil then return end
    --TriggerServerEvent("picbille:AddLog", token, 5, 5, "ModifyVehicleTopSpeed")
end

RemoveAllPedWeapons_ = RemoveAllPedWeapons
function RemoveAllPedWeapons(ped, p1)
    if ped ~= GetPlayerPed(-1) then
        --TriggerServerEvent("picbille:AddLog", token, 5, 5, "RemoveAllPedWeapons")
    end
end--]]