local shop_open = false
local index    = 1
local wanna_rob = false
local objects = {}
local bag = nil
local getterJob = false
local getterJob_count = nil
local shop_number = nil
local wait_for_cooldown = false
local shop_cooldown = false

RMenu.Add('shop', 'main_menu', RageUI.CreateMenu("Épicerie", "Que souhaitez-vous acheter ?", 1, 100))
RMenu.Add('shop', 'main_menu_buy', RageUI.CreateMenu("Épicerie", "Que souhaitez-vous acheter ?", 1, 100))
RMenu:Get('shop', 'main_menu').Closed = function()
    shop_open = false
end

local NumberCharset = {}
local Charset = {}
for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

local s_index = 1

openShop_m = function(number)
    if shop_open then
        shop_open = false
        return
    else
        shop_open = true
        Citizen.CreateThread(function()
            while shop_open do
                shop_number = number
                Wait(1)
                RageUI.IsVisible(RMenu:Get('shop', 'main_menu'), true, true, true, function()

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index = Index
                    end)

                    if not wanna_rob then
                        RageUI.Button("~c~Braquer", nil, {}, true, function(h, a, s)
                            if s then
                                wanna_rob = true
                            end
                        end)
                    else
                        RageUI.Button("~c~Braquer", nil, {RightLabel = "~c~Appuyez pour confirmer"}, true, function(h, a, s)
                            if s then
                                local jCount = Extasy.getCountOfJob("vcpd")
                                --TriggerServerEvent("shops:getCooldownForShop", shop_number)
                                ESX.TriggerServerCallback('shops:getCooldownForShop', function(cb)
                                    shop_cooldown = cb

                                    while shop_cooldown == nil do Wait(1) end
                                    if shop_cooldown then
                                        if jCount >= extasy_core_cfg["shop_min_cops_vcpd"] then
                                            if IsPedArmed(GetPlayerPed(-1), 7) then
                                                if IsPedArmed(GetPlayerPed(-1), 1) then
                                                    RageUI.CloseAll()
                                                    wanna_rob = false

                                                    TriggerServerEvent("Jobs:handleMapAlert", token, 1, "vcpd", GetEntityCoords(GetPlayerPed(-1)), "Braquage de l'épicerie n°"..shop_number.." en cours !\n~r~Une zone rouge vous à été rajouter dans votre gps", 2)

                                                    for k,v in pairs(active_npc) do
                                                        SetPedCombatAttributes(v.ped, 46, true)                     
                                                        SetPedFleeAttributes(v.ped, 0, 0)                      
                                                        SetBlockingOfNonTemporaryEvents(v.ped, true)
                                                        
                                                        SetEntityAsMissionEntity(v.ped, true, true)
                                                        SetNetworkIdCanMigrate(PedToNet(v.ped), true)

                                                        PlayAmbientSpeechWithVoice(v.ped, "APOLOGY_NO_TROUBLE", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)
                                                        FreezeEntityPosition(v.ped, false)
                                                        
                                                        GiveWeaponToPed(v.ped, GetHashKey("WEAPON_PUMPSHOTGUN"), 12, false, true)
                                                        SetPedCombatMovement(v.ped, 1)
                                                        TaskCombatPed(v.ped, PlayerPedId(), 0, 16)
                                                        SetPedCombatAbility(v.ped, 100)
                                                    end
                                                else
                                                    --TriggerServerEvent("shops:addToCooldownCache", shop_number)
                                                    RageUI.CloseAll()
                                                    wanna_rob = false

                                                    TriggerServerEvent("Jobs:handleMapAlert", token, 1, "vcpd", GetEntityCoords(GetPlayerPed(-1)), "Braquage de l'épicerie n°"..shop_number.." en cours !\n~r~Une zone rouge vous à été rajouter dans votre gps", 2)
                                                    TriggerEvent("eCore:AfficherBar", 180 * 1000, "⏳ Braquage en cours...")

                                                    for k,v in pairs(active_npc) do
                                                        SetPedCombatAttributes(v.ped, 46, true)                     
                                                        SetPedFleeAttributes(v.ped, 0, 0)                      
                                                        SetBlockingOfNonTemporaryEvents(v.ped, true)

                                                        SetEntityAsMissionEntity(v.ped, true, true)
                                                        SetNetworkIdCanMigrate(PedToNet(v.ped), true)
        
                                                        FreezeEntityPosition(v.ped, false)
                                                        RequestAnimDict("missminuteman_1ig_2")
        
                                                        while not HasAnimDictLoaded("missminuteman_1ig_2") do Wait(100) end
        
                                                        TaskPlayAnim(v.ped, "missminuteman_1ig_2", "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                                                    end

                                                    Wait(180*1000)
                                                    TriggerServerEvent("shop_robbery:processPayment", token, extasy_core_cfg["shop_money"], shop_number)

                                                    PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
                                                    DeleteObject(bag)
                                                    ClearPedTasks(GetPlayerPed(-1))
                                                end
                                            else
                                                for k,v in pairs(active_npc) do
                                                    PlayAmbientSpeechWithVoice(v.ped, "APOLOGY_NO_TROUBLE", "MP_M_SHOPKEEP_01_PAKISTANI_MINI_01", "SPEECH_PARAMS_FORCE", 1)
                                                end
                                                Extasy.ShowNotification("~r~Vous ne semblez pas faire peur à l'épicier")
                                            end
                                        else
                                            Extasy.ShowNotification("~r~Il n'y a pas assez de VCPD en ville pour faire ceci ("..jCount.."/"..extasy_core_cfg["shop_min_cops_vcpd"]..")")
                                        end
                                    else
                                        Extasy.ShowNotification("~r~Il n'y a plus de billets dans la caisse")
                                    end
                                end, shop_number, jCount)
                            end
                        end)
                    end

                    RageUI.Separator("")
                     
                    for k,v in pairs(cfg_shops.items) do    
                        RageUI.Button(v.label, nil, {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                cfg_shops.label     = v.label
                                cfg_shops.price     = v.price
                                cfg_shops.item_name = v.item
                            end
                        end, RMenu:Get('shop', 'main_menu_buy'))
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('shop', 'main_menu_buy'), true, true, true, function() 

                    if cfg_shops.label ~= "Téléphone" then
                        RageUI.List("Combien de '"..cfg_shops.label.."' ?", cfg_shops.max, s_index, nil, {}, true, function(Hovered, Active, Selected, Index) s_index = Index end)
                    end 

                    RageUI.Button("~g~Acheter "..s_index.." '"..cfg_shops.label.."' pour "..s_index * cfg_shops.price.."$", nil, {}, true, function(Hovered, Active, Selected) 
                        if (Selected) then
                            if index == 1 then
                                TriggerServerEvent("Shop:BuyItemsByBankMoney", token, s_index * cfg_shops.price, cfg_shops.item_name, s_index, cfg_shops.label)
                                RageUI.CloseAll()
                                shop_open = false
                            elseif index == 2 then
                                TriggerServerEvent("Shop:BuyItemsByMoney", token, s_index * cfg_shops.price, cfg_shops.item_name, s_index, cfg_shops.label)
                                RageUI.CloseAll()
                                shop_open = false
                            elseif index == 3 then
                                TriggerServerEvent("Shop:BuyItemsByDirtyMoney", token, s_index * cfg_shops.price, cfg_shops.item_name, s_index, cfg_shops.label)
                                RageUI.CloseAll()
                                shop_open = false
                            end
                        end			
                    end)

                end, function()
                end)

            end
        end)
    end
end

openShop = function(number, _side)
    RageUI.Visible(RMenu:Get('shop', 'main_menu'), true)
    openShop_m(number)
    shop_number = number
end

RegisterNetEvent("jobCounter:sendInfo")
AddEventHandler("jobCounter:sendInfo", function(table)
    jobCount = table
end)

RegisterNetEvent("shops:sendCooldownForShop")
AddEventHandler("shops:sendCooldownForShop", function(cooldown)
    shop_cooldown = cooldown
    wait_for_cooldown = false
end)