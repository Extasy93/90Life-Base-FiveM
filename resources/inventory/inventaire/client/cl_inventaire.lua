-- VARIABLES

Inv = {}
KEEP_FOCUS = false
isInInventory = false
playerIdentity          = {}
ESX = nil
currentMenu = 'item'
weaponEquiped = nil
weaponLock = false
local soifF5            = 50
local faimF5            = 50

local playerMasksData         = {}
local playerClothesData       = {}

local weaponOFF = false

RegisterNetEvent("Extasy:sendIdentityData")
AddEventHandler("Extasy:sendIdentityData", function(identity)
    playerIdentity = identity
end)

RegisterNetEvent("Extasy:sendMasksData")
AddEventHandler("Extasy:sendMasksData", function(MasksData)
    playerMasksData = {}
    if MasksData == nil then
        playerMasksData = {}
    else
        playerMasksData = MasksData
    end
end)

RegisterNetEvent("Extasy:sendClothesData")
AddEventHandler("Extasy:sendClothesData", function(ClothesData)
    playerClothesData = {}
    if ClothesData == nil then
        playerClothesData = {}
    else
        playerClothesData = ClothesData
    end
end)

RegisterNetEvent("Extasy:TienLeStatus")
AddEventHandler("Extasy:TienLeStatus", function(_soifF5, _faimF5)
    soifF5 = _soifF5
    faimF5 = _faimF5
end)

local open = false
local disablecontrol = false
local threadCreated = false
local controlDisabled = {1, 2, 3, 4, 5, 6, 18, 24, 25, 37, 69, 70, 111, 117, 118, 182, 199, 200, 257}

local fastWeapons = {
	[1] = nil,
	[2] = nil,
	[3] = nil
}

-- FUNCTION 

SetKeepInputMode = function(bool)
    if SetNuiFocusKeepInput then
        SetNuiFocusKeepInput(bool)
    end

    KEEP_FOCUS = bool

    if not threadCreated and bool then
        threadCreated = true

        Citizen.CreateThread(function()
            while KEEP_FOCUS do
                Wait(0)

                for _,v in pairs(controlDisabled) do
                    DisableControlAction(0, v, true)
                end
            end

            threadCreated = false
        end)
    end
end

HotBarUse = function(num)
    if not Shared.Blacklistitem[fastWeapons[num]] then
        if fastWeapons[num] ~= nil then
            if string.sub(fastWeapons[num], 1, string.len("WEAPON_")) == "WEAPON_" then
                if not weaponLock then
                    weaponLock = true
            
                    local checkh = Shared.Throwables
                    local playerPed = GetPlayerPed(-1)
                    local hash = GetHashKey(fastWeapons[num])
            
                    weaponOFF = true
                    InventoryShowNotification('~g~Vous avez équipé votre arme')
                    SetCurrentPedWeapon(GetPlayerPed(-1), 'WEAPON_UNARMED', true)
                    RemoveAllPedWeapons(playerPed, true)
                    Wait(100)
                    GiveWeaponToPed(playerPed, hash, 1, false, true)
                    ESX.Streaming.RequestAnimDict('reaction@intimidation@1h', function()
                        TaskPlayAnim(playerPed, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0)
                        Wait(1500)
                        ClearPedTasks(playerPed)
                        weaponOFF = false
                    end) 

                    ResetPedMovementClipset(playerPed, 0)
            
                    ESX.TriggerServerCallback('WeaponItem:getAmmoCount', function(ammoCount)
                        if checkh[weapon] == hash then
                            SetPedAmmo(playerPed, hash, 1)
                        elseif Shared.FuelCan == hash and ammoCount == nil then
                            SetPedAmmo(playerPed, hash, 1000)
                        else
                            SetPedAmmo(playerPed, hash, ammoCount or 0)
                        end
                    end, hash)
                else 
                    local playerPed = GetPlayerPed(-1)
                    weaponLock = false
                    local newAmmo = GetAmmoInPedWeapon(GetPlayerPed(-1), fastWeapons[num]) -- newAmmo
                    TriggerServerEvent('WeaponItem:updateAmmoCount', GetHashKey(fastWeapons[num]), newAmmo)
            
                    InventoryShowNotification('~r~Vous avez ranger votre arme')
            
                    weaponOFF = true
                    ESX.Streaming.RequestAnimDict('reaction@intimidation@1h', function()
                        TaskPlayAnim(playerPed, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0)
                        Wait(1500)
                        ClearPedTasks(playerPed)
                        SetCurrentPedWeapon(GetPlayerPed(-1), 'WEAPON_UNARMED', true)
                        RemoveAllPedWeapons(playerPed, true)
                        weaponOFF = false
                    end) 

                    ResetPedMovementClipset(playerPed, 0)
                end
            else
                TriggerServerEvent('esx:useItem', fastWeapons[num])
            end
        end
    end
end

RegisterNUICallback("UseItemData", function(data, cb)
    if data.item.type == "item_standard" then 
        if data.item.name == "CarteID" then
            InventoryShowAdvancedNotification("Carte d'identité", "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Âge: ~s~"..playerIdentity.age.."\n~p~Taille: ~s~"..playerIdentity.taille.."\n~p~Sexe: ~s~"..playerIdentity.sexe, "CHAR_PREF")
            Inv:CloseInventory()
        elseif data.item.name == "Permis_voiture" then
            Inv:CloseInventory()
            InventoryShowAdvancedNotification("Permis de conduire (voiture)", "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Âge: ~s~"..playerIdentity.age.."\n~p~Taille: ~s~"..playerIdentity.taille.."\n~p~Sexe: ~s~"..playerIdentity.sexe, "CHAR_PREF")
        elseif data.item.name == "Permis_moto" then
            Inv:CloseInventory()
            InventoryShowAdvancedNotification("Permis de conduire (moto)", "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Âge: ~s~"..playerIdentity.age.."\n~p~Taille: ~s~"..playerIdentity.taille.."\n~p~Sexe: ~s~"..playerIdentity.sexe, "CHAR_PREF")
        elseif data.item.name == "Permis_arme" then
            Inv:CloseInventory()
            InventoryShowAdvancedNotification("Permis port d'arme", "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Âge: ~s~"..playerIdentity.age, "CHAR_PREF")
        elseif data.item.name == "Permis_bateau" then
            Inv:CloseInventory()
            InventoryShowAdvancedNotification("Permis Bateau", "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Âge: ~s~"..playerIdentity.age, "CHAR_PREF")
        elseif data.item.name == "Badge" then
            InventoryShowAdvancedNotification("Badge "..string.upper(playerJob), "Préfecture", "~p~Prénom: ~s~"..playerIdentity.prenom.."\n~p~Nom: ~s~"..playerIdentity.nom.."\n~p~Matricule: ~s~"..playerIdentity.matricule, "CHAR_PREF")
        elseif data.item.name == "spray" then
            TriggerServerEvent("esx:useItem", data.item.name)
            Wait(10)
            Inv:CloseInventory()
        else
            if string.sub(data.item.name, 1, string.len("WEAPON_")) == "WEAPON_" then
                if not weaponLock then
                    weaponLock = true
            
                    local checkh = Shared.Throwables
                    local playerPed = GetPlayerPed(-1)
                    local hash = GetHashKey(data.item.name)
            
                    weaponOFF = true
                    InventoryShowNotification('~g~Vous avez équipé votre arme')
                    SetCurrentPedWeapon(GetPlayerPed(-1), 'WEAPON_UNARMED', true)
                    RemoveAllPedWeapons(playerPed, true)
                    Wait(100)
                    GiveWeaponToPed(playerPed, hash, 1, false, true)
                    ESX.Streaming.RequestAnimDict('reaction@intimidation@1h', function()
                        TaskPlayAnim(playerPed, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0)
                        Wait(1500)
                        ClearPedTasks(playerPed)
                        weaponOFF = false
                    end) 
            
                    ESX.TriggerServerCallback('WeaponItem:getAmmoCount', function(ammoCount)
                        if checkh[weapon] == hash then
                            SetPedAmmo(playerPed, hash, 1)
                        elseif Shared.FuelCan == hash and ammoCount == nil then
                            SetPedAmmo(playerPed, hash, 1000)
                        else
                            SetPedAmmo(playerPed, hash, ammoCount or 0)
                        end
                    end, hash)
                else 
                    local playerPed = GetPlayerPed(-1)
                    weaponLock = false
                    local newAmmo = GetAmmoInPedWeapon(GetPlayerPed(-1), data.item.name) -- newAmmo
                    TriggerServerEvent('WeaponItem:updateAmmoCount', GetHashKey(data.item.name), newAmmo)
            
                    InventoryShowNotification('~r~Vous avez ranger votre arme')
            
                    weaponOFF = true
                    ESX.Streaming.RequestAnimDict('reaction@intimidation@1h', function()
                        TaskPlayAnim(playerPed, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0)
                        Wait(1500)
                        ClearPedTasks(playerPed)
                        SetCurrentPedWeapon(GetPlayerPed(-1), 'WEAPON_UNARMED', true)
                        RemoveAllPedWeapons(playerPed, true)
                        weaponOFF = false
                    end) 
                end
            else
                TriggerServerEvent("esx:useItem", data.item.name)
            end
        end
    elseif data.item.type == "item_tenue" then
        ESX.Streaming.RequestAnimDict('clothingtie', function()
            TaskPlayAnim(PlayerPedId(), 'clothingtie', 'try_tie_neutral_b', 2.0, 2.0, 3555, 48, 0, false, false, false)
        end)
        TriggerEvent("eCore:AfficherBar", 3555, "📦 Changement de tenue en cours...")
        Wait(3555)
        ClearPedSecondaryTask(PlayerPedId())
        TriggerEvent("skinchanger:getSkin", function(skin)
            TriggerEvent('skinchanger:loadClothes', skin, { 
                ["pants_1"] = json.decode(data.item.skins)["pants_1"], 
                ["tshirt_2"] = json.decode(data.item.skins)["tshirt_2"], 
                ["tshirt_1"] = json.decode(data.item.skins)["tshirt_1"], 
                ["torso_1"] = json.decode(data.item.skins)["torso_1"], 
                ["torso_2"] = json.decode(data.item.skins)["torso_2"],
                ["arms"] = json.decode(data.item.skins)["arms"],
                ["arms_2"] = json.decode(data.item.skins)["arms_2"],
                ["decals_1"] = json.decode(data.item.skins)["decals_1"],
                ["decals_2"] = json.decode(data.item.skins)["decals_2"],
                ["shoes_1"] = json.decode(data.item.skins)["shoes_1"],
                ["shoes_2"] = json.decode(data.item.skins)["shoes_2"]
            })
            InventoryShowNotification("Vous avez ~b~équipé~s~ votre ~b~"..data.item.label)
            TriggerEvent('esx_skin:setLastSkin', skin)
            TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)
            end)
        end)

        tenue = not tenue
        Inv:SaveSkin()
        RefreshPedScreen()

    elseif data.item.type == "item_masque" then
        TriggerEvent('skinchanger:getSkin', function(skin)
            ESX.Streaming.RequestAnimDict('misscommon@van_put_on_masks', function()
                TaskPlayAnim(PlayerPedId(), 'misscommon@van_put_on_masks', 'put_on_mask_ps', 2.0, 2.0, 1000, 48, 0, false, false, false)
            end)

            local pPed         = GetPlayerPed(-1)
            local ma_1   = data.item.info
            local ma_2   = data.item.info2
            local ma_3   = data.item.info3

            Wait(1000)

            if masque then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)

                        SetPedComponentVariation(pPed, 1, 0, 0, 2)

                        TriggerEvent("skinchanger:change", 'mask_1', 0)
                        TriggerEvent("skinchanger:change", 'mask_2', 0)
                    end)
                end)
                masque = false
            else
                InventoryShowNotification("Vous avez ~b~équipé~s~ vôtre ~b~"..data.item.label)

                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)

                        SetPedComponentVariation(pPed, ma_1, ma_2, ma_3, 2)
                        playerGotMaskOrHat = true

                        TriggerEvent("skinchanger:change", 'mask_1', ma_2)
                        TriggerEvent("skinchanger:change", 'mask_2', ma_3)
                    end)
                end)

                masque = true

                Inv:SaveSkin()
                RefreshPedScreen()
            end
        end)
    end

    if Inv:ShouldCloseInventory(data.item.name) then
        Inv:CloseInventory()
    else
        Inv:LoadPlayerInventory(currentMenu)
    end

    cb("ok")
end)

RegisterNetEvent('WeaponItem:useWeapon')
AddEventHandler('WeaponItem:useWeapon', function(weapon)
    if not weaponLock then
        weaponLock = true

        local checkh = Shared.Throwables
        local playerPed = GetPlayerPed(-1)
        local hash = GetHashKey(data.item.name)

        weaponOFF = true
        InventoryShowNotification('~g~Vous avez équipé votre arme')
        SetCurrentPedWeapon(GetPlayerPed(-1), 'WEAPON_UNARMED', true)
        RemoveAllPedWeapons(playerPed, true)
        Wait(100)
        GiveWeaponToPed(playerPed, hash, 1, false, true)
        ESX.Streaming.RequestAnimDict('reaction@intimidation@1h', function()
            TaskPlayAnim(playerPed, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0)
            Wait(1500)
            ClearPedTasks(playerPed)
            weaponOFF = false
        end) 

        ESX.TriggerServerCallback('WeaponItem:getAmmoCount', function(ammoCount)
            if checkh[weapon] == hash then
                SetPedAmmo(playerPed, hash, 1)
            elseif Shared.FuelCan == hash and ammoCount == nil then
                SetPedAmmo(playerPed, hash, 1000)
            else
                SetPedAmmo(playerPed, hash, ammoCount or 0)
            end
        end, hash)
    else 
        local playerPed = GetPlayerPed(-1)
        weaponLock = false
        local newAmmo = GetAmmoInPedWeapon(GetPlayerPed(-1), data.item.name) -- newAmmo
        TriggerServerEvent('WeaponItem:updateAmmoCount', GetHashKey(data.item.name), newAmmo)

        InventoryShowNotification('~r~Vous avez ranger votre arme')

        weaponOFF = true
        ESX.Streaming.RequestAnimDict('reaction@intimidation@1h', function()
            TaskPlayAnim(playerPed, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0)
            Wait(1500)
            ClearPedTasks(playerPed)
            SetCurrentPedWeapon(GetPlayerPed(-1), 'WEAPON_UNARMED', true)
            RemoveAllPedWeapons(playerPed, true)
            weaponOFF = false
        end) 
    end
end)

RegisterNetEvent('UseAmmo')
AddEventHandler('UseAmmo', function(ammo)
    local playerPed = GetPlayerPed(-1)
    local weapon

    local found, currentWeapon = GetCurrentPedWeapon(playerPed, true)
    if found then
        for _, v in pairs(ammo.weapons) do
            if currentWeapon == v then
                weapon = v
                break
            end
        end
        if weapon ~= nil then
            local pedAmmo = GetAmmoInPedWeapon(playerPed, weapon)
            local newAmmo = pedAmmo + ammo.count
            ClearPedTasks(playerPed)
            local found, maxAmmo = GetMaxAmmo(playerPed, weapon)
            if newAmmo < 40 then
                TriggerServerEvent('WeaponItem:updateAmmoCount', weapon, newAmmo)
                SetPedAmmo(playerPed, weapon, newAmmo)
                TriggerServerEvent('RemoveAmmo', ammo)
                InventoryShowNotification("Vous avez recharger votre ~g~Armes.")
            else
                InventoryShowNotification("Le chargeur de votre ~g~arme~s~ est déjà plein.")
            end
        end
    end
end)

local tenue, masque = {}, {}

function Inv:LoadPlayerInventory(result)

    if result == 'item' then 
        ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventory", function(data)
            items = {}
            fastItems = {}
			inventory = data.inventory
			accounts = data.accounts
			money = data.money
			weapons = data.weapons
			weight = data.weight
            maxWeight = 24

            WeaponData = ESX.GetWeaponList()

            for i = 1, #WeaponData, 1 do
                if WeaponData[i].name == 'WEAPON_UNARMED' then
                    WeaponData[i] = nil
                else
                    WeaponData[i].hash = GetHashKey(WeaponData[i].name)
                end
            end

            while WeaponData == nil do Wait(0) end

            SendNUIMessage(
                {
                    action = "setItems",
                    text = "<div id=\"weightValue\"><p>" ..weight.. " / " ..maxWeight.. "KG</p></span>"
                }
            )

			if Shared.IncludeCash and money ~= nil and money > 0 then
				moneyData = {
					label = "Argent",
					name = "cash",
					type = "item_money",
					count = money,
					usable = false,
					rare = false,
					weight = 0,
					canRemove = true
				}
				table.insert(items, moneyData)
			end

            if Shared.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not Inv:ShouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = "Argent non déclaré",
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                weight = 0,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end

            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        local infast = false
                        if json.encode(fastWeapons) ~= "[]" then
                            for fast, bind in pairs(fastWeapons) do
                                if inventory[key].name == bind then
                                    table.insert(fastItems, {
                                        label = inventory[key].label,
                                        count = inventory[key].count,
                                        limit = -1,
                                        type = inventory[key].type,
                                        name = inventory[key].name,
                                        usable = true,
                                        rare = false,
                                        canRemove = true,
                                        slot = fast
                                    })
                                    infast = true
                                end
                            end
                        end
                        if not infast then
                            --print(inventory[key].type)
                            inventory[key].type = "item_standard"
                            table.insert(items, inventory[key])
                        end
                    end
                end
            end
         
        SendNUIMessage({ action = "setItems", itemList = items, fastItems = fastItems, text = texts, crMenu = currentMenu})
        end, GetPlayerServerId(PlayerId()))

    elseif result == 'clothe' then 
        items = {}

        TriggerServerEvent("Extasy:sendAllMasksFromPlayerInv")
        TriggerServerEvent("Extasy:sendAllClothesFromPlayerInv")

        while playerClothesData == {} do Wait(1) end
        while playerMasksData == {} do Wait(1) end

        for k,v in pairs(playerClothesData) do
            if #playerClothesData > 0 then
                tenueData = {
                    label = v.label,
                    name = "tenue",
                    type = "item_tenue",
                    skins = v.data,
                    count = "",
                    usable = true,
                    rename = true,
                    rare = false,
                    id = tonumber(v.id), 
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, tenueData)
            end
        end

        for k,v in pairs(playerMasksData) do
            if #playerMasksData > 0 then
                masqueData = {
                    label = v.label,
                    name = "mask",
                    type = "item_masque",
                    skins = v.skins,
                    info = tonumber(v.data.mask_1),
                    info2 = tonumber(v.data.mask_2),
                    info3 = tonumber(v.data.mask_3),
                    id = tonumber(v.id), 
                    count = "",
                    usable = true,
                    rename = true,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }
                table.insert(items, masqueData)
            end
        end

        Wait(250)

        SendNUIMessage({ action = "setItems", itemList = items, fastItems = fastItems, text = texts, crMenu = currentMenu})
        Wait(250)
    end
end

function Inv:ShouldCloseInventory(itemName)
    for index, value in ipairs(Shared.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function Inv:ShouldSkipAccount(accountName)
    for index, value in ipairs(Shared.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

function Inv:SaveSkin()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:save', skin)
	end)
end

function Inv:ActiveHud()
    SendNUIMessage({showUi = true})

    if IsPedSwimmingUnderWater(PlayerPedId()) then
        isUnderwater = true
        SendNUIMessage({showOxygen = true})
    elseif not IsPedSwimmingUnderWater(PlayerPedId()) then
        isUnderwater = false
        SendNUIMessage({showOxygen = false})
    end

    --TriggerEvent('esx_status:getStatus', 'hunger',function(status) hunger = status.val / 10000 end)
    --TriggerEvent('esx_status:getStatus', 'thirst', function(status) thirst = status.val / 10000 end)
    --TriggerEvent('esx_status:getStatus', 'stress',function(status) stress = status.val / 10000 end)

    SendNUIMessage({
        action = "update_hud",
        hp = GetEntityHealth(PlayerPedId())-100,
        armor = GetPedArmour(PlayerPedId()),
        --hunger = hunger,
        --thirst = thirst,
        --stress = stress,
        hunger = faimF5,
        thirst = soifF5,
        stress = 50,
        oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
    })
end

function Inv:OpenInventory()
    TriggerServerEvent("Extasy:sendAllMasksFromPlayerInv")
    TriggerServerEvent("Extasy:sendAllClothesFromPlayerInv")
    TriggerServerEvent("Extasy:getPlayerIdentityInv")
    Inv:LoadPlayerInventory(currentMenu)
    Inv:ActiveHud()
    CreatePedScreen(true)
    isInInventory = true
    open = true
    SendNUIMessage({action = "display", type = "normal"})
    SetNuiFocus(true, true)
    SetKeepInputMode(true)
    disablecontrol = true
    TriggerScreenblurFadeIn(0)
    DisplayRadar(false)
end

function Inv:CloseInventory()
    if not weaponOFF then
        DeletePedScreen()
        isInInventory = false
        open = false
        SendNUIMessage({action = "hide"})
        SetNuiFocus(false, false)
        SetKeepInputMode(false)
        disablecontrol = false
        SendNUIMessage({showUi = false})
        TriggerScreenblurFadeOut(0)
        TriggerServerEvent("getgps")
        DisplayRadar(true)
    end
end

-- EVENT

RegisterNetEvent(Shared.prefix.."addgps")
AddEventHandler(Shared.prefix.."addgps", function()
	DisplayRadar(true)
end)

RegisterNetEvent(Shared.prefix.."removegps")
AddEventHandler(Shared.prefix.."removegps", function()
	DisplayRadar(false)
end)

AddEventHandler("esx:playerLoaded", function(xPlayer)
    PlayerData = xPlayer
	DisplayRadar(false)
	TriggerServerEvent(Shared.prefix.."getgps")
end)

-- THREAD

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(750)
        HideHudComponentThisFrame(19)
        HideHudComponentThisFrame(20)
        BlockWeaponWheelThisFrame()
        SetPedCanSwitchWeapon(PlayerPedId(), false)

        if not isInInventory then 
            SendNUIMessage({showUi = false})
        end 
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("ext:getSharedObject", function(obj)
            ESX = obj
        end)
    Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
	while true do
		if disablecontrol then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 69, true) -- Attack
			DisableControlAction(0, 70, true) -- Attack
			DisableControlAction(0, 92, true) -- Attack
			DisableControlAction(0, 114, true) -- Attack
			DisableControlAction(0, 121, true) -- Attack
            DisableControlAction(0, 140, true) -- Attack
            DisableControlAction(0, 141, true) -- Attack
            DisableControlAction(0, 142, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack
            DisableControlAction(0, 263, true) -- Attack
            DisableControlAction(0, 264, true) -- Attack
            DisableControlAction(0, 331, true) -- Attack

            DisableControlAction(0, 157, true) -- Weapon 1
            DisableControlAction(0, 158, true) -- Weapon 2
            DisableControlAction(0, 160, true) -- Weapon 3
		end
		Wait(0)
	end
end)

-- COMMAND

RegisterCommand('invbug', function()
    if invbug then 
        SetNuiFocus(false, false)
        SetKeepInputMode(false)
    else
        SetNuiFocus(true, true)
        SetKeepInputMode(true)
    end
    invbug = not invbug
end)

RegisterCommand("nohud",function()  
    SendNUIMessage({showUi = false})
end)

OpenInventory = function()
    if not isInInventory then
		DisplayRadar(false)
        Inv:OpenInventory()
    elseif isInInventory then 
        Inv:CloseInventory()
    end
end

-- NUICALLBAKC

RegisterNUICallback('escape', function(data, cb)
    Inv:CloseInventory()
    SetKeepInputMode(false)
end)

RegisterNUICallback("NUIFocusOff",function()
    Inv:CloseInventory()
    SetKeepInputMode(false)
end)

RegisterNUICallback("GetNearPlayers", function(data, cb)
    local targetT = GetNearbyPlayer(false, true)

    if not targetT then return end

    if targetT then
        Inv:CloseInventory()
        
        local count = tonumber(data.number)

        if data.item.type == "item_money" then 
            GiveWeaponToPed(GetPlayerPed(-1), "weapon_unarmed", 1, false, true)
            ESX.Streaming.RequestAnimDict("mp_common", function()
                TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
            end)
            TriggerServerEvent("esx_inventoryhud:tradePlayerItem", GetPlayerServerId(PlayerId()), GetPlayerServerId(targetT), data.item.type, data.item.name, count)
        end

        if data.item.type == "item_tenue" or data.item.type == "item_masque" then
            TriggerServerEvent("Extasy:updateUserForThisClothesInv", data.item.id, GetPlayerServerId(targetT), data.item.type)
            ESX.Streaming.RequestAnimDict("mp_common", function()
                TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
            end)
            Wait(250)
            Inv:LoadPlayerInventory(currentMenu)
            InventoryShowNotification('Vous venez de donner votre ~b~'..data.item.label.."~s~ à l'ID: ~b~"..GetPlayerServerId(targetT))
        else
            if data.item.name == "CarteID" or data.item.name == "Permis_voiture" or data.item.name == "Permis_moto" or data.item.name == "Permis_camion" or data.item.name == "Permis_bateau" or data.item.name == "Permis_arme" then
                InventoryShowNotification("La personne à recu votre ~b~"..data.item.label)
            else
                TriggerServerEvent("esx:donneItem", GetPlayerServerId(targetT), data.item.type, data.item.name, count)
                ExecuteCommand("me donne ("..data.item.label..")")
                ESX.Streaming.RequestAnimDict("mp_common", function()
                    TaskPlayAnim(PlayerPedId(), "mp_common", "givetake2_a", 2.0, -2.0, 2500, 49, 0, false, false, false)
                end)
                Wait(250)
                Inv:LoadPlayerInventory(currentMenu)
            end
        end

        TriggerServerEvent("Extasy:getPlayerIdentityInv")

        while playerIdentity == {} do Wait(1) end

        if data.item.name == "CarteID" then
            TriggerServerEvent("identity:showToPlayerInv", GetPlayerServerId(targetT), playerIdentity)
            Inv:CloseInventory()
        elseif data.item.name == "Permis_voiture" then
            TriggerServerEvent("car_licence:showToPlayerInv", GetPlayerServerId(targetT), playerIdentity)
            Inv:CloseInventory()
        elseif data.item.name == "Permis_moto" then
            TriggerServerEvent("bike_licence:showToPlayerInv", GetPlayerServerId(targetT), playerIdentity)
            Inv:CloseInventory()
        elseif data.item.name == "Permis_camion" then
            TriggerServerEvent("truck_licence:showToPlayerInv", GetPlayerServerId(targetT), playerIdentity)
            Inv:CloseInventory()
        elseif data.item.name == "Permis_bateau" then
            TriggerServerEvent("boat_licence:showToPlayerInv", GetPlayerServerId(targetT), playerIdentity)
            Inv:CloseInventory()
        elseif data.item.name == "Permis_arme" then
            TriggerServerEvent("license_ppa:showToPlayerInv", GetPlayerServerId(targetT), playerIdentity)
            Inv:CloseInventory()
        end
    end

    cb("ok")
end)

RegisterNUICallback("dsqds", function(data, cb)
    if currentMenu ~= data.type then 
        currentMenu = data.type
        Inv:LoadPlayerInventory(data.type)
    end
end)

RegisterNUICallback("RenameItem", function(data, cb)
    --if data.item.type ~= "item_standard" then 
        --TriggerServerEvent(Shared.prefix.."changename", data.item.id, i)
        --TriggerServerEvent(Shared.prefix.."changename", data.item.name, i)
    if data.item.type == "item_standard" then 
        --TriggerServerEvent("changename", data.item.name, i)
        InventoryShowNotification("~r~Vous ne pouvez pas renommer ce type d'item")
        Inv:CloseInventory()
    elseif data.item.type == "item_money" then 
        --TriggerServerEvent("changename", data.item.name, i)
        InventoryShowNotification("~r~Vous ne pouvez pas renommer ce type d'item")
        Inv:CloseInventory()
    elseif data.item.type == "item_masque" then
        Inv:CloseInventory()
        Wait(1)
        i = Extasy.KeyboardInput("Définissez le nouveau nom de votre "..data.item.label, "", 30)
        i = tostring(i)

        if i ~= nil then 
            TriggerServerEvent("Extasy:updateNameForThisMaskInv", data.item.id, i)
            InventoryShowNotification('Vous avez ~g~changer~s~ le nom de votre vêtement ~g~'..data.item.label..'~s~ en ~b~'..i..'~s~')
        end
    end
end)

RegisterNUICallback("DropItem", function(data, cb)
    local playerPed = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
		if data.item.type == "item_money" then
			TriggerServerEvent("esx:removeInventoryItem", "item_account", "money", data.number, GetEntityCoords(playerPed))
            TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low" , 8.0, -8.0, 1780, 35, 0.0, false, false, false)
            GiveWeaponToPed(GetPlayerPed(-1), "weapon_unarmed", 1, false, true)
		else
			TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number, GetEntityCoords(playerPed))
			TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low" , 8.0, -8.0, 1780, 35, 0.0, false, false, false)
        end
    end

    if data.item.type == "item_masque" then
        TriggerServerEvent("Extasy:deleteThisMaskInv", data.item.id) 
        TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low" , 8.0, -8.0, 1780, 35, 0.0, false, false, false)
    end

    if data.item.type == "item_tenue" then
        TriggerServerEvent("Extasy:deleteThisClothesInv", data.item.id) 
        TaskPlayAnim(GetPlayerPed(-1), "random@domestic", "pickup_low" , 8.0, -8.0, 1780, 35, 0.0, false, false, false)
    end

    Wait(250)
    Inv:LoadPlayerInventory(currentMenu)

    cb("ok")
end)

RegisterNUICallback("PutIntoFast", function(data, cb)
    if not Shared.Blacklistitem[data.item.name] then
	    if data.item.slot ~= nil then
		    fastWeapons[data.item.slot] = nil
	    end
	    fastWeapons[data.slot] = data.item.name
	    --TriggerServerEvent("esx_inventoryhud:changeFastItem", data.slot, data.item.name)
	    Inv:LoadPlayerInventory(currentMenu)
	    cb("ok")
    end
end)

RegisterNUICallback("TakeFromFast", function(data, cb)
	fastWeapons[data.item.slot] = nil
	--TriggerServerEvent("esx_inventoryhud:changeFastItem", 0, data.item.name)
	Inv:LoadPlayerInventory(currentMenu)
	cb("ok")
end)

InventoryShowNotification = function(msg, flash, saveToBrief, hudColorIndex)
	if title == nil then title = "90's Life" end
	if subject == nil then subject = "INFORMATIONS" end
	if icon == nil then icon = "message" end

	exports.bulletin:Send(msg, nil, nil, true)
end

InventoryShowAdvancedNotification = function(title, subject, msg, icon, timeout)
	-- if IsPauseMenuActive() then return end

	if title == nil then title = "90's Life" end
	if subject == nil then subject = "INFORMATIONS" end
	if icon == nil then icon = "SERVERLOGO" end
	if timeout == nil then timeout = 7500 end
	if icon == nil or subject == nil or title == nil then wait(50) end

	--[[print(icon)
	print(msg)
	print(title)
	print(subject)
	print(timeout)--]]
	exports.bulletin:SendAdvanced(msg, title, subject, icon, timeout, nil, true)
end

RegisterNetEvent("Inventory:ShowAdvancedNotification")
AddEventHandler("Inventory:ShowAdvancedNotification", function(title, subject, msg, icon, time, gravity)
    InventoryShowAdvancedNotification(title, subject, msg, icon)
end)
















local canfire = false
local currWeapon = nil
local currentWeapon
------------- Recule -------------

local weapons = {
	'WEAPON_PISTOL',
    'WEAPON_APPISTOL',
    'WEAPON_PISTOL50',
    'WEAPON_REVOLVER',
    'WEAPON_SNSPISTOL',
    'WEAPON_HEAVYPISTOL',
    'WEAPON_VINTAGEPISTOL',
    'WEAPON_DOUBLEACTION',
    'WEAPON_COMBATPISTOL',
}

CheckWeapon = function(newWeap)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == newWeap then
			return true
		end
	end
	return false
end

loadAnimDict = function(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(5)
	end
end
