-- VARIABLES
local targetPlayer
local targetPlayerName
local pasarme = false
local pasarme2 = false
local checkanim = false
local anim = false

-- FUNCTION 

function RefreshPlayerInventory() Inv:SetPlayerInventoryData() end

function Inv:Animation()
    CreateThread(function()
        while true do
            Wait(10)

            local ped = PlayerPedId()
            local plyCoords = GetEntityCoords(ped)

            if anim then
                if not checkanim then
                    checkanim = true
                    ESX.Streaming.RequestAnimDict('missexile3', function()
                        TaskPlayAnim(PlayerPedId(), 'missexile3', 'ex03_dingy_search_case_a_michael', 8.0, -8.0, -1, 35, 0.0, false, false, false)
                    end)
                elseif checkanim then
                    if IsControlJustReleased(0, 37) and checkanim then
                        checkanim = false
                        anim = false
                        ClearPedTasks(PlayerPedId())

                        local target, distance = ESX.Game.GetClosestPlayer()
                        local playerPed = GetPlayerPed(target)
                        local Ply = PlayerPedId()

                        if target and distance < 1 then
                            TriggerServerEvent('debloqueontrol', GetPlayerServerId(target))
                            pasarme = false
                        end
                    end
                end
            end
        end
    end)
end

function Inv:SetPlayerInventoryData()
    ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventory",
                              function(data)
        SendNUIMessage({
            action = "setInfoOther",
            label = 'Other Player',
            id = targetPlayerName,
            max = '~',
            used = '~'
        })

        items = {}
        inventory = data.inventory
        accounts = data.accounts
        money = data.money
        weapons = data.weapons

        if Shared.IncludeCash and money ~= nil and money > 0 then
            moneyData = {
                label = "Argent",
                name = "cash",
                type = "item_money",
                count = money,
                usable = false,
                rare = false,
                limit = -1,
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
                            label = "Argent sale",
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
                if value.count <= 0 then
                    value = nil
                else
                    local total = value.count
                    value.type = value.type or "item_standard"

                    if value.batch then
                        for batch, item in pairs(value.batch) do
                            local newData = copyTable(value)
                            newData.count = item.count
                            newData.info = item.info
                            newData.batch = batch
                            total = total - item.count
                            if item.info.lifetime then
                                local remaintime =
                                    item.info.expiredtime - data.serverTime
                                local quality =
                                    math.floor(remaintime / item.info.lifetime *
                                                   100)
                                newData.info.quality = quality
                            end
                            table.insert(items, newData)
                        end

                        if total > 0 then
                            value.count = total
                            value.batch = false
                            table.insert(items, value)
                        end
                    else
                        table.insert(items, value)
                    end
                end
            end
        end

        if Shared.IncludeWeapons and weapons ~= nil then
            for key, value in pairs(weapons) do
                local weaponHash = GetHashKey(weapons[key].name)
                local playerPed = GetPlayerPed(GetPlayerFromServerId(targetPlayer))
                if weapons[key].name ~= "WEAPON_UNARMED" then
                    local ammo = weapons[key].ammo
                    table.insert(items, {
                        label = weapons[key].label,
                        count = ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = true
                    })
                end
            end
        end

        SendNUIMessage({action = "setSecondInventoryItems", itemList = items})
    end, targetPlayer)
end

function Inv:OpenPlayerInventory()
    Inv:LoadPlayerInventory(currentMenu)
    isInInventory = true

    SendNUIMessage({action = "display", type = "player"})

    DisplayRadar(false)
    SetNuiFocus(true, true)
    TriggerScreenblurFadeIn()
    SetKeepInputMode(true)
end

-- EVENT

RegisterNetEvent("esx_inventoryhud:Inv:OpenPlayerInventory")
AddEventHandler("esx_inventoryhud:Inv:OpenPlayerInventory", function(target, playerName)
    pasarme = true
    targetPlayer = target
    targetPlayerName = playerName
    Inv:SetPlayerInventoryData()
    Inv:OpenPlayerInventory()
end)

RegisterNetEvent("esx_inventoryhud:blockcontrol")
AddEventHandler("esx_inventoryhud:blockcontrol", function()
    CreateThread(function()
        while true do
            if pasarme2 then
                SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), true)
            end
            Wait(1)
        end
    end)
    Wait(1)
end)

RegisterNetEvent("esx_inventoryhud:blockcontrol1")
AddEventHandler("esx_inventoryhud:blockcontrol1", function()
    pasarme2 = true
    Wait(1)
end)

RegisterNetEvent("esx_inventoryhud:debloqueontrol")
AddEventHandler("esx_inventoryhud:debloqueontrol", function()
    pasarme2 = false
end)

-- COMMAND

RegisterCommand('fouiller', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    local Ply = PlayerPedId()

    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        --if IsEntityPlayingAnim(GetPlayerPed(closestPlayer),"random@arrests@busted", "idle_c", 3) then
            ExecuteCommand('me fouille quelqu\'un')
            anim = true
            Inv:Animation()
            TriggerEvent("esx_inventoryhud:Inv:OpenPlayerInventory", GetPlayerServerId(closestPlayer), GetPlayerName(PlayerPedId()))
        --else
            --InventoryShowNotification('~r~Impossible~s~~n~L\'individu doit lever les mains.')
        --end
    else
        InventoryShowNotification("~r~Impossible~s~\nAucune personne autour de vous.")
    end
end)

-- NUI CALLBACK

RegisterNUICallback("PutIntoPlayer", function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then return end

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 1.0 then
        closeInventory()
    else
        if GetPlayerServerId(closestPlayer) == targetPlayer then
            if type(data.number) == "number" and math.floor(data.number) ==
                data.number then
                local count = tonumber(data.number)
                if data.item.type == "item_weapon" then
                    count = data.item.count
                end
                TriggerServerEvent("esx_inventoryhud:tradePlayerItem", GetPlayerServerId(PlayerId()), targetPlayer, data.item.type, data.item.name, count, data.item)
            end
            Wait(250)
            RefreshPlayerInventory()
            Inv:LoadPlayerInventory(currentMenu)
        end
    end
    cb("ok")
end)

RegisterNUICallback("TakeFromPlayer", function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then return end

    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer == -1 or closestDistance > 1.0 then
        closeInventory()
    else
        if GetPlayerServerId(closestPlayer) == targetPlayer then
            if type(data.number) == "number" and math.floor(data.number) ==
                data.number then
                local count = tonumber(data.number)
                if data.item.type == "item_weapon" then
                    count = data.item.count
                end
                TriggerServerEvent("esx_inventoryhud:tradePlayerItem", targetPlayer, GetPlayerServerId(PlayerId()), data.item.type, data.item.name, count, data.item)
            end
            Wait(250)
            RefreshPlayerInventory()
            Inv:LoadPlayerInventory(currentMenu)
        end
    end
    cb("ok")
end)
