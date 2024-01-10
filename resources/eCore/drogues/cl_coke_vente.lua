startDrugsSellCoke = function()
    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        local oldTime   = GetGameTimer()
        playerIsPlayingFarm = true
        local _time     = 7*1000
        local _count    = count or 1
        local _price    = 120
        local ped       = PlayerPedId()
        local pCoords   = GetEntityCoords(ped)
        local pDst      = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, 2073.288, 6272.854, 16.91674, false)

        -- if pDst > 5.0 then
        --     playerIsPlayingFarm = false
        --     FreezeEntityPosition(GetPlayerPed(-1), false)
        --     TriggerEvent("api:stopUI")
        --     Extasy.print("societyFarm", "^1Player is glitching, removing all society farm data now")
        -- end

        TriggerEvent("eCore:AfficherBar", _time, "⏳ Vente en cours...")

        Extasy.StartInteractAnimation()

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                FreezeEntityPosition(ped, true)

                if playerIsDead then
                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans le coma")

                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end

                Wait(1)
            end
        end)

        CreateThread(function()
            while playerIsPlayingFarm do
                Extasy.ShowHelpNotification("~p~Appuyez sur [E] pour annuler l'animation")
                if IsControlJustReleased(1, 38) then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end
                Wait(1)
            end
        end)

        while playerIsPlayingFarm do
            if oldTime + _time < GetGameTimer() then
                --local iCount = Extasy.getItemCount(item)
                oldTime = GetGameTimer()
                TriggerServerEvent("Extasy:SellItemToDrugsCoke", token, "pochon_de_coke", _price, _count)

                if not playerCanBypassE then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                end
                FreezeEntityPosition(ped, false)
                if playerCanBypassE then
                    playerIsPlayingFarm = false
                    startSocietySell()
                end
            end

            Wait(0)
        end
    else
        Extasy.ShowNotification("~r~Vous ne pouvez pas réaliser cette action en étant dans un véhicule")
    end
end
        
startDrugsSellWeed = function()
    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        local oldTime   = GetGameTimer()
        playerIsPlayingFarm = true
        local _time     = 7*1000
        local _count    = count or 1
        local _price    = 85
        local ped       = PlayerPedId()
        local pCoords   = GetEntityCoords(ped)
        local pDst      = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, 2073.288, 6272.854, 16.91674, false)

        -- if pDst > 5.0 then
        --     playerIsPlayingFarm = false
        --     FreezeEntityPosition(GetPlayerPed(-1), false)
        --     TriggerEvent("api:stopUI")
        --     Extasy.print("societyFarm", "^1Player is glitching, removing all society farm data now")
        -- end

        TriggerEvent("eCore:AfficherBar", _time, "⏳ Vente en cours...")

        Extasy.StartInteractAnimation()

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                FreezeEntityPosition(ped, true)

                if playerIsDead then
                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans le coma")

                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end

                Wait(1)
            end
        end)

        CreateThread(function()
            while playerIsPlayingFarm do
                Extasy.ShowHelpNotification("~p~Appuyez sur [E] pour annuler l'animation")
                if IsControlJustReleased(1, 38) then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end
                Wait(1)
            end
        end)

        while playerIsPlayingFarm do
            if oldTime + _time < GetGameTimer() then
                --local iCount = Extasy.getItemCount(item)
                oldTime = GetGameTimer()
                TriggerServerEvent("Extasy:SellItemToDrugsWeed", token, "pochon_de_weed", _price, _count)

                if not playerCanBypassE then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                end
                FreezeEntityPosition(ped, false)
                if playerCanBypassE then
                    playerIsPlayingFarm = false
                    startSocietySell()
                end
            end

            Wait(0)
        end
    else
        Extasy.ShowNotification("~r~Vous ne pouvez pas réaliser cette action en étant dans un véhicule")
    end
end

startDrugsSellMeth = function()
    if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
        local oldTime   = GetGameTimer()
        playerIsPlayingFarm = true
        local _time     = 7*1000
        local _count    = count or 1
        local _price    = 150
        local ped       = PlayerPedId()
        local pCoords   = GetEntityCoords(ped)
        local pDst      = GetDistanceBetweenCoords(pCoords.x, pCoords.y, pCoords.z, 2073.288, 6272.854, 16.91674, false)

        -- if pDst > 5.0 then
        --     playerIsPlayingFarm = false
        --     FreezeEntityPosition(GetPlayerPed(-1), false)
        --     TriggerEvent("api:stopUI")
        --     Extasy.print("societyFarm", "^1Player is glitching, removing all society farm data now")
        -- end

        TriggerEvent("eCore:AfficherBar", _time, "⏳ Vente en cours...")

        Extasy.StartInteractAnimation()

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                FreezeEntityPosition(ped, true)

                if playerIsDead then
                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans le coma")

                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end

                Wait(1)
            end
        end)

        CreateThread(function()
            while playerIsPlayingFarm do
                Extasy.ShowHelpNotification("~p~Appuyez sur [E] pour annuler l'animation")
                if IsControlJustReleased(1, 38) then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    --TriggerEvent("api:stopUI")
                end
                Wait(1)
            end
        end)

        while playerIsPlayingFarm do
            if oldTime + _time < GetGameTimer() then
                --local iCount = Extasy.getItemCount(item)
                oldTime = GetGameTimer()
                TriggerServerEvent("Extasy:SellItemToDrugsMeth", token, "pochon_de_meth", _price, _count)

                if not playerCanBypassE then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                end
                FreezeEntityPosition(ped, false)
                if playerCanBypassE then
                    playerIsPlayingFarm = false
                    startSocietySell()
                end
            end

            Wait(0)
        end
    else
        Extasy.ShowNotification("~r~Vous ne pouvez pas réaliser cette action en étant dans un véhicule")
    end
end
        