fruits_shop_openned = false
local index = 1
local playerCanBypassE = true

RMenu.Add('fruits_shop', 'main_menu', RageUI.CreateMenu("Revente fruits", "Que souhaitez-vous vendre ?", 1, 100))
RMenu:Get('fruits_shop', 'main_menu').Closed = function()
    fruits_shop_openned = false
end
selledFruits = 0

openFruitsMarket_m = function()
    if fruits_shop_openned then
        fruits_shop_openned = false
        return
    else
        fruits_shop_openned = true
        Citizen.CreateThread(function()
            while fruits_shop_openned do
                Wait(1)
                
                RageUI.IsVisible(RMenu:Get('fruits_shop', 'main_menu'), true, true, true, function()

                    RageUI.Separator("")

                    if Extasy.TableCount(playerContent) < 1 then
                        RageUI.Button("Inventaire vide", nil, {}, true, function(_, _, _)
                        end)
                    elseif Extasy.TableCount(playerContent) > 0 then
                        if GetGameTimer() > selledFruits then
                            for itemName, count in pairs(playerContent) do
                                if string.sub(itemName, 1, string.len("Pomme")) == "Pomme" then
                                    RageUI.ButtonWithStyle("[~p~"..count.." "..itemName.."~s~] Vendre mes fruits", nil, {RightLabel = "→"}, true, function(h, a, s)
                                        if s then
                                            TriggerServerEvent("recoltActivity:sell", token, itemName, count, extasy_core_cfg["pomme_price"]*extasy_core_cfg["price_fruit_mult"])
                                            selledFruits = GetGameTimer() + 60 * 1000
                                            TriggerServerEvent("recoltActivity:refreshMyPlayerContent", token)
                                        end
                                    end)
                                end

                                if string.sub(itemName, 1, string.len("Orange")) == "Orange" then
                                    RageUI.ButtonWithStyle("[~p~"..count.." "..itemName.."~s~] Vendre mes fruits", nil, {RightLabel = "→"}, true, function(h, a, s)
                                        if s then
                                            TriggerServerEvent("recoltActivity:sell", token, itemName, count, extasy_core_cfg["orange_price"]*extasy_core_cfg["price_fruit_mult"])
                                            selledFruits = GetGameTimer() + 60 * 1000
                                            TriggerServerEvent("recoltActivity:refreshMyPlayerContent", token)
                                        end
                                    end)
                                end

                                if string.sub(itemName, 1, string.len("Framboises")) == "Framboises" then
                                    RageUI.ButtonWithStyle("[~p~"..count.." "..itemName.."~s~] Vendre mes fruits", nil, {RightLabel = "→"}, true, function(h, a, s)
                                        if s then
                                            TriggerServerEvent("recoltActivity:sell", token, itemName, count, extasy_core_cfg["framboise_price"]*extasy_core_cfg["price_fruit_mult"])
                                            selledFruits = GetGameTimer() + 60 * 1000
                                            TriggerServerEvent("recoltActivity:refreshMyPlayerContent", token)
                                        end
                                    end)
                                end

                                if string.sub(itemName, 1, string.len("Mures")) == "Mures" then
                                    RageUI.ButtonWithStyle("[~p~"..count.." "..itemName.."~s~] Vendre mes fruits", nil, {RightLabel = "→"}, true, function(h, a, s)
                                        if s then
                                            TriggerServerEvent("recoltActivity:sell", token, itemName, count, extasy_core_cfg["mure_price"]*extasy_core_cfg["price_fruit_mult"])
                                            selledFruits = GetGameTimer() + 60 * 1000
                                            TriggerServerEvent("recoltActivity:refreshMyPlayerContent", token)
                                        end
                                    end)
                                end

                                if string.sub(itemName, 1, string.len("Myrtilles")) == "Myrtilles" then
                                    RageUI.ButtonWithStyle("[~p~"..count.." "..itemName.."~s~] Vendre mes fruits", nil, {RightLabel = "→"}, true, function(h, a, s)
                                        if s then
                                            TriggerServerEvent("recoltActivity:sell", token, itemName, count, extasy_core_cfg["myrtille_price"]*extasy_core_cfg["price_fruit_mult"])
                                            selledFruits = GetGameTimer() + 60 * 1000
                                            TriggerServerEvent("recoltActivity:refreshMyPlayerContent", token)
                                        end
                                    end)
                                end
                            end

                            RageUI.Button("Vous n'avez rien à vendre", nil, {}, true, function(_, _, _)
                            end)
                        else
                            RageUI.Button("~c~Vendre mes fruits", "Veuillez patienter entre chaque vente de vos fruits", {RightBadge = RageUI.BadgeStyle.Lock}, true, function(_, _, Selected) end)
                        end
                    end
        
                end, function()
                end)

            end
        end)
    end
end

openFruitsMenu = function()
    TriggerServerEvent("recoltActivity:refreshMyPlayerContent", token)
    while playerContent == nil do Wait(1) end
    RageUI.Visible(RMenu:Get('fruits_shop', 'main_menu'), true)
    openFruitsMarket_m()
end

RegisterNetEvent("recoltActivity:refreshPlayerContent")
AddEventHandler("recoltActivity:refreshPlayerContent", function(newContent)
    playerContent = newContent
end)

Citizen.CreateThread(function()
    if extasy_core_cfg["map_los_santos"] then
        while cfg_recolt_activity.points == nil do Wait(1) end
        for k,v in pairs(cfg_recolt_activity.points) do

            registerNewMarker({
                npcType             = 'drawmarker',
                pos                 = v.pos,
                interactMessage     = v.msg,
                action              = function()
                    startActivityFarm(v.item, v.time, v.count)
                end,
                spawned             = false,
                entity              = nil,
                load_dst            = 50,
                dst                 = 25,
            
                blip_enable         = false,
            
                marker              = v.marker,
                size                = v.size,
            
                drawmarkerType      = 25,
                
                drawmarkerColorR    = 100,
                drawmarkerColorG    = 0,
                drawmarkerColorB    = 200,
            })

            AddTextEntry('RECOLT_ACTIVITY_'..k, v.name)

            b = AddBlipForCoord(v.pos)
            SetBlipSprite(b, v.sprite)
            SetBlipDisplay(b, v.display)
            SetBlipScale(b, v.scale)
            SetBlipColour(b, v.colour)
            SetBlipAsShortRange(b, true)
            BeginTextCommandSetBlipName('RECOLT_ACTIVITY_'..k)
            EndTextCommandSetBlipName(b)
        end
    end
end)

startActivityFarm = function(item, time, count)
    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        local oldTime   = GetGameTimer()
        playerIsPlayingFarm = true
        local _time     = time or 3500
        local _count    = count or 1
        local ped       = PlayerPedId()
        local pCoords   = GetEntityCoords(ped)
        --local pDst      = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, lastCoordsData.farm.x, lastCoordsData.farm.y, lastCoordsData.farm.z, false)

        -- if pDst > 5.0 then
        --     playerIsPlayingFarm = false
        --     FreezeEntityPosition(GetPlayerPed(-1), false)
        --     TriggerEvent("eCore:PlusLaBar")
        --     Extasy.print("societyFarm", "^1Player is glitching, removing all society farm data now")
        -- end

        TriggerEvent("eCore:AfficherBar", _time, "⏳ Récolte en cours...")

        Extasy.StartInteractAnimation()

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                FreezeEntityPosition(GetPlayerPed(-1), true)

                if playerIsDead then
                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans le coma")

                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    TriggerEvent("eCore:PlusLaBar")
                end

                Wait(1)
            end
        end)

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                Extasy.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~r~annuler l'animation")
                if IsControlJustReleased(1, 38) then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                    TriggerEvent("eCore:PlusLaBar")
                end
                Wait(1)
            end
        end)

        while playerIsPlayingFarm do
            if oldTime + _time < GetGameTimer() then
                oldTime = GetGameTimer()
                print(item)
                print(_count)
                print(Extasy.GetPlayerCapacity())
                TriggerServerEvent("recoltActivity:giveItem", token, item, _count, Extasy.GetPlayerCapacity())
                if not playerCanBypassE then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(GetPlayerPed(-1), false)
                end

                if playerCanBypassE then
                    playerIsPlayingFarm = false
                    startActivityFarm(item, time, count)
                end
            end

            Wait(0)
        end
    else
        Extasy.ShowNotification("~r~Vous ne pouvez pas réaliser cette action en étant dans un véhicule")
    end
end