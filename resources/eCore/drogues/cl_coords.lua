drug_farm_data = {}


registerDrugFarmZone = function(data)
    table.insert(drug_farm_data, data)
end

--[[registerDrugFarmZone({
    pos      = vector3(2647.069, 6866.437, 9.886489),
    type     = 1,
    item     = 'beuh',
    count    = 1,
    size     = 10.0,
    marker   = false,
    msg      = "~p~[E] pour recolter",
})

registerDrugFarmZone({
    pos      = vector3(1035.93, -3205.79, -38.17),
    type     = 2,
    item     = 'beuh',
    item_g   = 'join',
    size     = 5.0,
    time     = time,
    marker   = false,
    msg      = "~p~[E] pour traiter",
})

registerDrugFarmZone({
    pos      = vector3(325.06, 6623.45, 28.75),
    type     = 1,
    item     = 'cocaine',
    count    = 1,
    size     = 5.0,
    marker   = false,
    msg      = "~p~[E] pour recolter",
})

registerDrugFarmZone({
    pos      = vector3(1093.36, -3195.89, -38.13),
    type     = 2,
    item     = 'cocaine',
    item_g   = 'pochon_de_coke',
    size     = 5.0,
    time     = time,
    marker   = false,
    msg      = "~p~[E] pour traiter",
})

registerDrugFarmZone({
    pos      = vector3(3603.31, 3668.9, 33.87),
    type     = 1,
    item     = 'methamphetamine',
    count    = 1,
    size     = 5.0,
    marker   = false,
    msg      = "~p~[E] pour recolter",
})

registerDrugFarmZone({
    pos      = vector3(1012.93, -3195.65, -38.99),
    type     = 2,
    item     = 'methamphetamine',
    item_g   = 'pochon_de_methamphetamine',
    size     = 5.0,
    time     = time,
    marker   = false,
    msg      = "~p~[E] pour traiter",
})

registerDrugFarmZone({
    pos      = vector3(1389.4, 3604.32, 38.94),
    type     = 1,
    item     = 'crack',
    count    = 1,
    size     = 5.0,
    marker   = false,
    msg      = "~p~[E] pour recolter",
})

registerDrugFarmZone({
    pos      = vector3(1007.08, -3150.99, -38.1),
    type     = 2,
    item     = 'methamphetamine',
    item_g   = 'pochon_de_methamphetamine',
    size     = 5.0,
    time     = time,
    marker   = false,
    msg      = "~p~[E] pour traiter",
})

registerDrugFarmZone({
    pos      = vector3(-293.31, -2780.91, 6.41),
    type     = 1,
    item     = 'opium',
    count    = 1,
    size     = 5.0,
    marker   = false,
    msg      = "~p~[E] pour recolter",
})

registerDrugFarmZone({
    pos      = vector3(1096.44, -3098.38, -39.0),
    type     = 2,
    item     = 'opium',
    item_g   = 'pochon_de_opium',
    size     = 5.0,
    time     = time,
    marker   = false,
    msg      = "~p~[E] pour traiter",
})

registerDrugFarmZone({
    pos      = vector3(1233.14, 1876.89, 78.87),
    type     = 1,
    item     = 'heroine',
    count    = 1,
    size     = 5.0,
    marker   = false,
    msg      = "~p~[E] pour recolter",
})

registerDrugFarmZone({
    pos      = vector3(1161.17, -3191.82, -39.01),
    type     = 2,
    item     = 'heroine',
    item_g   = 'pochon_de_heroine',
    size     = 5.0,
    time     = time,
    marker   = false,
    msg      = "~p~[E] pour traiter",
})--]]

Citizen.CreateThread(function()
    while true do
        local near_point = false
        local ped        = GetPlayerPed(-1)
		local pedCoords  = GetEntityCoords(ped)

        for k,v in pairs(drug_farm_data) do
            if v.pos ~= nil then
                local dst   = GetDistanceBetweenCoords(v.pos, pedCoords, true)
                local _size = v.size or 3.0
                local _msg  = v.msg or "~b~Appuyez sur E pour interagir"

                if _size ~= nil then
                    if dst <= _size then
                        near_point = true
                        if v.type == 1 then
							Extasy.DrawText3D(pedCoords, _msg, 1.0)
                            if IsControlJustReleased(1, 38) then
                                if IsPedInAnyVehicle(ped, false) then
                                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans un véhicule")
								else
                                    startDrugFarm(v.item, v.time, v.count)
                                end
                            end
                        elseif v.type == 2 then
                            Extasy.DrawText3D(pedCoords, _msg, 1.0)
                            if IsControlJustReleased(1, 38) then
                                if IsPedInAnyVehicle(ped, false) then
                                    Extasy.ShowNotification("~r~Vous ne pouvez pas interagir en étant dans un véhicule")
								else
									--[[local pDst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 350.0, -1400.0, 0.0, false)
									local nJob = nil

									if pDst < 4500 then
										nJob = "lspd"
									else
										nJob = "bcsd"
									end

									local jCount = Extasy.getCountOfJob(nJob)

                                    if jCount >= core_cfg["drug_interact_cops"] then
                                        inAreaData = {}
                                        playersInArea = Extasy.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 15.0)

                                        for i=1, #playersInArea, 1 do
                                            if playersInArea[i] ~= PlayerId() then
                                                table.insert(inAreaData, {
                                                    name = GetPlayerName(playersInArea[i]),
                                                    id   = GetPlayerServerId(playersInArea[i])
                                                })
                                            end
                                        end

                                        if #inAreaData >= core_cfg["drug_interact_crew_min"] then
                                            TriggerServerEvent("jobCounter:sendAlertToRandomGang", token, "~r~Inconnu~s~\nEh les gars y'a l'air d'avoir un trafic de drogue en cours !", 1)
                                        end]]

                                        startDrugTransform(v.item, v.time, v.item_g, v.count)
									--[[lelse
										Extasy.ShowNotification("~r~Le fournisseur illégal ne semble pas être disponible\n("..jCount.."/"..core_cfg["drug_interact_cops"]..")")
									end]]
                                end
                            end
                        end
                        if v.marker then
                            DrawMarker(1, v.pos.x, v.pos.y, v.pos.z - 1.0, nil, nil, nil, nil, nil, nil, _size, _size, 0.3, settings.color[1], settings.color[2], settings.color[3], 100, false, false)
                        end
                    end
                end
            end
        end

        if near_point then
            Wait(0)
        else
            Wait(1000)
        end
    end
end)



function startDrugFarm(item, time, count)
    local oldTime   = GetGameTimer()
    playerIsPlayingFarm = true
    local _time     = time or 3500
    local _count    = count or 1
    local ped       = PlayerPedId()

    TriggerEvent("eCore:AfficherBar", _time, "💊 Récolte en cours...")

    ExecuteCommand('e puddle')

    Citizen.CreateThread(function()
        while playerIsPlayingFarm do
            FreezeEntityPosition(GetPlayerPed(-1), true)
            Wait(1)
        end
    end)

    Citizen.CreateThread(function()
        while playerIsPlayingFarm do
            ESX.ShowHelpNotification("~p~Appuyez sur E pour annuler l'animation")
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
            if playerGotBag then
                TriggerServerEvent("Triso:GiveItem", token, item, _count)
            else
                TriggerServerEvent("Triso:GiveItem", token, item, _count)
            end
            if not playerCanBypassE then
                playerIsPlayingFarm = false
                FreezeEntityPosition(GetPlayerPed(-1), false)
            end
            if playerCanBypassE then
                playerIsPlayingFarm = false
                startDrugFarm(item, time, count)
            end
        end

        Wait(0)
    end
    
end

local SyncDrogueCountVente = 0
local SyncCountEtat = false
RegisterNetEvent("Triso:ItemCount")
AddEventHandler("Triso:ItemCount", function(dure)
    SyncDrogueCountVente = dure
	SyncCountEtat = true
end)

function startDrugTransform(item, time, item_g, count)
    local oldTime   = GetGameTimer()
    SyncCountEtat = false
    TriggerServerEvent("Triso:ItemCount", token, item)
	while not SyncCountEtat do Wait(1) end
	if SyncDrogueCountVente > 0 then
        playerIsPlayingFarm = true
        local _time     = time or 3500
        local _count    = count or 1
        local ped       = PlayerPedId()

        TriggerEvent("eCore:AfficherBar", _time, "💊 Traitement en cours...")
        
        ExecuteCommand('e puddle')

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                FreezeEntityPosition(ped, true)
                Wait(1)
            end
        end)

        Citizen.CreateThread(function()
            while playerIsPlayingFarm do
                ESX.ShowHelpNotification("~p~Appuyez sur E pour annuler l'animation")
                if IsControlJustReleased(1, 38) then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                    TriggerEvent("eCore:PlusLaBar")
                    PtfxStop()
                end
                Wait(1)
            end
        end)

        while playerIsPlayingFarm do
            if oldTime + _time < GetGameTimer() then
                oldTime = GetGameTimer()
                if playerGotBag then
                    TriggerServerEvent("Triso:Traitememt", token, item, item_g, _count)
                else
                    TriggerServerEvent("Triso:Traitememt", token, item, item_g, _count)
                end
                if not playerCanBypassE then
                    playerIsPlayingFarm = false
                    FreezeEntityPosition(ped, false)
                end
                if playerCanBypassE then
                    playerIsPlayingFarm = false
                    startDrugTransform(item, time, item_g, count)
                end
            end

            Wait(0)
        end
    else 
        Extasy.ShowNotification("Vous n'avez pas assez de : ~r~"..item.." ~w~sur vous")
    end
end



