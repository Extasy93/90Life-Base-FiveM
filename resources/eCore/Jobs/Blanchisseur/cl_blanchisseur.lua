money_wash_menu_openned = false
local playerLevel = nil
local index = 1
local current_washed = 0
local wash_blip = nil
local wash_max_can_wash = 0

RMenu.Add('money_wash_menu', 'main_menu', RageUI.CreateMenu("Blanchisseur", "Combien voulez-vous blanchir ?", 1, 100))
RMenu:Get('money_wash_menu', 'main_menu').Closed = function()
    money_wash_menu_openned = false
end

openWashing_m = function()
    if money_wash_menu_openned then
        money_wash_menu_openned = false
        return
    else
        money_wash_menu_openned = true
        Citizen.CreateThread(function()
            while money_wash_menu_openned do
                Wait(1)

                RageUI.IsVisible(RMenu:Get('money_wash_menu', 'main_menu'), true, true, true, function()

                    for k,v in pairs(cfg_money_wash.list) do
                        if not v.check then
                            RageUI.Button(Extasy.Math.GroupDigits(v.value).."$", nil, {}, true, function(h, a, s)
                                if s then
                                    v.check = true
                                end
                            end)
                        else
                            RageUI.Button(Extasy.Math.GroupDigits(v.value).."$", nil, {RightLabel = "Confirmez ("..Extasy.Math.GroupDigits(v.value).."$)"}, true, function(h, a, s)
                                if s then
                                    ESX.TriggerServerCallback('Extasy:WashMoney', function (hasEnoughMoneyForWash)
                                        if hasEnoughMoneyForWash then
                                            --local jCount = ESX.getCountOfJob("lspd")
                                        
                                            --if jCount >= 2 then
                                                local dTogo = nil

                                                dTogo = cfg_money_wash.doors[math.random(2, #cfg_money_wash.doors)]
                                                washSystemSetMarker(dTogo, tonumber(v.value), v.tranch, tonumber(v.time))
                                                wash_max_can_wash = tonumber(v.value)
                                                RageUI.CloseAll()
                                                money_wash_menu_openned = false
                                            --else
                                                --Extasy.ShowNotification("~r~Mon contact n'est pas disponible pour le moment ("..jCount.."/ 2]")")
                                            --end
                                        else
                                            Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent de source inconnue sur vous")
                                        end
                                    end, v.value)
                                end
                            end)
                        end
                    end
                end, function()
                end)
            end
        end)
    end
end

washSystemSetMarker = function(_coords, _max_wash, _tranch, _time)
    Citizen.CreateThread(function()
        Wait(5000)
        Extasy.ShowNotification("~r~Contact~s~\nRejoins-moi ici avec la mallette, je t'envoie la pos")
        PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)

        Wait(3500)

        wash_blip = AddBlipForCoord(_coords)
		SetBlipSprite(wash_blip, 280)
		SetBlipColour(wash_blip, 75)
		SetBlipShrink(wash_blip, true)
	    SetBlipScale(wash_blip, 0.90)
	    SetBlipPriority(wash_blip, 50)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName("Contact illégal")
		EndTextCommandSetBlipName(wash_blip)
        SetBlipRoute(wash_blip, true)
        SetThisScriptCanRemoveBlipsCreatedByAnyScript(true)

        local searching = true

        while searching do
            Wait(1)
            local pPed = GetPlayerPed(-1)
            local pCoords = GetEntityCoords(pPed)
            local dst = GetDistanceBetweenCoords(pCoords, _coords, true)

            if dst < 2.5 then
                ESX.ShowHelpNotification("Appuyez sur ~p~[E]~s~ pour intéragir avec le contact")
                if IsControlJustReleased(1, 38) then
                    if current_washed >= _max_wash then
                        searching = false
                    else
                        ESX.TriggerServerCallback('Extasy:WashMoney', function (hasEnoughMoneyForWash)
                            if hasEnoughMoneyForWash then
                                local pChance = math.random(1, 16)

                                TriggerEvent("eCore:AfficherBar", token, _time * 60000, "⏳ Blanchiment en cours...")
    
                                Wait(_time * 60000)
    
                                pPed = GetPlayerPed(-1)
                                pCoords = GetEntityCoords(pPed)
                                dst = GetDistanceBetweenCoords(pCoords, _coords, true)
    
                                if dst < 2.5 then
                                    ESX.TriggerServerCallback('Extasy:WashMoney', function (hasEnoughMoneyForWash)
                                        if hasEnoughMoneyForWash then
                                            TriggerServerEvent("Extasy:blanchiement", token, _tranch)
                                            Extasy.ShowNotification("~r~[Transaction terminée]~n~~s~Partez d'ici vous ne me reverez plus jamais...")
                                        else
                                            Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent de source inconnue sur vous")
                                        end
                                    end, _tranch)
    
                                    current_washed = current_washed + _tranch
    
                                    if current_washed == _max_wash then
                                        searching = false
                                    end
                                else
                                    searching = false
                                end
                            else
                                Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent de source inconnue sur vous")
                            end
                        end, _tranch)
                    end
                end
            else
                if current_washed >= 500 then
                    searching = false
                    Extasy.ShowNotification("~r~Transaction annulée")
                end
            end
        end
        --Extasy.ShowNotification("~r~Transaction terminée")
        RemoveBlip(wash_blip)
        wash_max_can_wash = 0
        current_washed = 0
    end)
end



function openWashing()
    if wash_max_can_wash == 0 then
        RageUI.Visible(RMenu:Get('money_wash_menu', 'main_menu'), true)
        openWashing_m()
    else
        Extasy.ShowNotification("~r~Vous avez déjà un contact à rencontrer")
    end
end