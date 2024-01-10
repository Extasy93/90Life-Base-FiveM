ESX = nil

Citizen.CreateThread(function()
    TriggerEvent("ext:getSharedObject", function(obj)   ESX = obj   end)

    while true do
        local interval = 1500
        local playerPos = GetEntityCoords(PlayerPedId())
        if not currentSteal then
            for k,v in pairs(Config_heist_house.stealzone) do
                local zoneCenter = v.Enter
                local dst = #(playerPos-zoneCenter)
                if not v.cooldownentry then 
                    if dst <= 15.0 then
                        interval = 0
                        DrawMarker(6, zoneCenter.x, zoneCenter.y, zoneCenter.z-0.95, 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 0.6, 0.6, 0.6, 200, 0, 0, 100)
                        if dst <= 1.0 then
                            Extasy.ShowHelpNotification("Appuyez sur ~r~[E]~s~ pour commencer le cambriolage")
                            if IsControlJustPressed(0, 51) then
                                StealStart(v)
                            end
                        end
                    end
                end
            end
        end
        Wait(interval)
    end
end)

StealStart = function(house)
    local inventory = ESX.GetPlayerData().inventory
    local lockpick = nil
    for i=1, #inventory, 1 do                          
        if inventory[i].name == 'Outil_crochetage' then
            lockpick = inventory[i].count
        else
            --
        end
    end

    local jCount = Extasy.getCountOfJob("vcpd")

    if jCount >= extasy_core_cfg["cambriolage_min_cops_vcpd"] then
        if lockpick == nil then
            Extasy.ShowNotification("~r~Vous n'avez pas d'outils de crochetage")
        elseif lockpick > 0 then
            TriggerServerEvent("Jobs:handleMapAlert", token, 3, "vcpd", GetEntityCoords(GetPlayerPed(-1)), "Cambriolage de la maison "..house.name.." en cours !\n~r~Une zone rouge vous à été rajouter dans votre gps", 2)

            local playerPed = PlayerPedId()
            FreezeEntityPosition(playerPed, true)
            SetEntityCoords(playerPed, house.Enter.x, house.Enter.y, house.Enter.z-0.98)
            SetEntityHeading(playerPed, house.hEnter)
            AnimJoueur("mini@safe_cracking", "idle_base")
            TriggerEvent("eCore:AfficherBar", house.lockpicktime * 1000, "⏳ Crochetage en cours...")
            Wait(5000)
            AnimJoueur("mini@safe_cracking", "idle_base")
            Wait(5000)
            AnimJoueur("mini@safe_cracking", "idle_base")
            Wait(5000)
            AnimJoueur("mini@safe_cracking", "idle_base")
            Wait(5000)
            AnimJoueur("mini@safe_cracking", "idle_base")
            --Wait(house.lockpicktime * 1000)
            SetEntityCoords(playerPed, house.Exit.x, house.Exit.y, house.Exit.z-0.98)
            SetEntityHeading(playerPed, house.hExit+180)
            FreezeEntityPosition(playerPed, false)
            ClearPedTasksImmediately(playerPed)
            currentSteal = true
            Extasy.ShowHelpNotification("Vous avez ~r~réussi~s~ le crochetage.", 1)
            TriggerServerEvent("Extasy:sellItem", "Outil_crochetage")
            Citizen.SetTimeout(house.MaxStealTime*1000,function()
                if currentSteal then
                    currentSteal = false
                    Extasy.ShowNotification("Vous êtes ~r~sorti~s~ de "..house.name.." car vous avez pris trop de temps !")
                    DoScreenFadeOut(1500)
                    Wait(3000)
                    DoScreenFadeIn(1500)
                    SetEntityCoords(playerPed, house.Enter.x, house.Enter.y, house.Enter.z-0.98)
                    SetEntityHeading(playerPed, house.hEnter+180)
                end
            end)
            local timestartrandom = ESX.Math.Round(house.MaxStealTime/3)
            local randomtime = math.random(timestartrandom , house.MaxStealTime)
            Citizen.SetTimeout(randomtime*1000, function()
                if currentSteal then
                    TriggerServerEvent('Extasy:vcpdGetSmugglerAlert', house.Enter)
                    Wait(5000)
                    Extasy.ShowNotification("~r~La VCPD a été prévenue du vol!")
                end
            end)
            while currentSteal do 
                house.cooldownentry = true
                local playerPos = GetEntityCoords(PlayerPedId())
                local dstexit = #(playerPos-house.Exit)
                DrawMarker(6, house.Exit.x, house.Exit.y, house.Exit.z-0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 200, 0, 0, 100)
                if dstexit <= 1.5 then
                    Extasy.ShowHelpNotification("Appuyez sur ~r~[E]~s~ pour sortir", 1)
                    if IsControlJustPressed(0, 51) then
                        FreezeEntityPosition(playerPed, true)
                        SetEntityHeading(playerPed, house.hExit)
                        SetEntityCoords(playerPed, house.Exit.x, house.Exit.y, house.Exit.z-0.98)
                        TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
                        DoScreenFadeOut(1000)
                        Wait(2000)
                        DoScreenFadeIn(1000)
                        currentSteal = false
                        SetEntityCoords(playerPed, house.Enter.x, house.Enter.y, house.Enter.z-0.98)
                        SetEntityHeading(playerPed, house.hEnter+180)
                        FreezeEntityPosition(playerPed, false)
                        Extasy.ShowNotification("Vous êtes ~r~sorti~s~ de "..house.name)

                        Citizen.SetTimeout(200000,function()
                            house.cooldownentry = false
                        end)
                    end
                end
                for k,v in pairs(house.Objects) do
                    local posobj = v.pos
                    local dstobj = #(playerPos-posobj)
                    if not v.cooldown then 
                        DrawMarker(6, posobj.x, posobj.y, posobj.z-0.95, 0.0, 0.0, 0.0, 90.0, 0.0, 0.0, 1.0, 1.0, 1.0, 200, 0, 0, 100)
                        if dstobj <= 1.0 then
                            Extasy.ShowHelpNotification("Appuyez sur ~r~[E]~s~ pour voler un(e) "..v.name, 1)
                            if IsControlJustPressed(0, 51) then
                                FreezeEntityPosition(playerPed, true)
                                SetEntityHeading(playerPed, v.hObj)
                                SetEntityCoords(playerPed, v.pos.x, v.pos.y, v.pos.z-0.98)
                                TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true)
                                Wait(v.time * 1000)
                                if currentSteal then
                                    FreezeEntityPosition(playerPed, false)
                                    ClearPedTasksImmediately(playerPed)
                                    Extasy.ShowNotification("Vous avez ~r~réussi~s~ à voler un(e) "..v.name)
                                    TriggerServerEvent("Extasy:buy", v.Item)
                                    v.cooldown = true
                                    Citizen.SetTimeout(80000,function()
                                        v.cooldown = false
                                    end)
                                else
                                    FreezeEntityPosition(playerPed, false)
                                    ClearPedTasksImmediately(playerPed)
                                end
                            end
                        end
                    end
                end
                Wait(0)
            end
        else
            Extasy.ShowNotification("~r~Il vous manque un outil de crochetage !")
        end
    else
        Extasy.ShowNotification("~r~Il n'y a pas assez de VCPD en ville pour faire ceci ("..jCount.."/"..extasy_core_cfg["cambriolage_min_cops_vcpd"]..")")
    end
end

OpenSmugglerSellMenu = function()
    local playerPed = PlayerPedId()

    MenuSellMain = RageUI.CreateMenu("Contrebandier", "Contrebandier")
    MenuSellMain:SetRectangleBanner(0, 0, 0, 255)
    MenuSellMain.Closed = function()
        SetPlayerControl(PlayerId(), true, 12)
        FreezeEntityPosition(playerPed, false)
        isMenuActive = false
    end

    isMenuActive = true

    RageUI.Visible(MenuSellMain, true)
    Citizen.CreateThread(function()
        FreezeEntityPosition(playerPed, true)
        while isMenuActive do

            RageUI.IsVisible(MenuSellMain, function()

                for k, v in pairs(ESX.GetPlayerData().inventory) do
                    local price = Config_heist_house.SellPrice[v.name]

                    if price and v.count > 0 then 
                        RageUI.Button("Vendre "..v.label, "Vous vendez votre "..v.label.." au contrebandier pour ~r~"..price.."$", {RightLabel = "~r~"..price.."$"}, true, {
                            onSelected = function()
                                Extasy.ShowNotification("Vous avez vendu "..v.label.." pour ~r~"..price.."$")
                                TriggerServerEvent("Extasy:sellItem", v.name)
                            end
                        })
                    end
                end

            end, function()
            end, 1)
            Wait(0)
        end
    end)
end

AnimJoueur = function(dict,annim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(1000)
    end
    TaskPlayAnim(PlayerPedId(), dict, annim, 8.0, -8.0, -1, 0, 0, false, false, false)
end

RegisterNetEvent('Extasy:vcpdSendSmugglerAlert')
AddEventHandler('Extasy:vcpdSendSmugglerAlert', function(targetCoords)
	local rueHash = GetStreetNameAtCoord(targetCoords.x, targetCoords.y, targetCoords.z)
	local rue = GetStreetNameFromHashKey(rueHash)
    Extasy.ShowNotification("Un vol a été signalé à ~r~"..rue.."~s~")

    local alpha = 250
    local vcpdBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, 50.0)

    SetBlipHighDetail(vcpdBlip, true)
    SetBlipColour(vcpdBlip, 1)
    SetBlipAlpha(vcpdBlip, alpha)
    SetBlipAsShortRange(vcpdBlip, true)

    while alpha ~= 0 do
        Citizen.Wait(135)
        alpha = alpha - 1
        SetBlipAlpha(vcpdBlip, alpha)

        if alpha == 0 then
            RemoveBlip(vcpdBlip)
            return
        end
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config_heist_house.stealzone) do
        b = AddBlipForCoord(v.Enter)
        SetBlipSprite(b, 730)
        SetBlipDisplay(b, 4)
        SetBlipScale(b, 0.5)
        SetBlipColour(b, 17)
        SetBlipAsShortRange(b, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Cambriolage")
        EndTextCommandSetBlipName(b)
    end
end)
