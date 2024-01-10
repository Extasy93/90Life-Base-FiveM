RMenu.Add('props', 'main_menu', RageUI.CreateMenu("Props", "Que souhaitez-vous faire ?"))
RMenu:Get('props', "main_menu").Closed = function()
    props_menu_openned = false
    RMenu:Get('props', "main_menu").Index = 1
end

local pCat = {}
pObjets = {}
Citizen.CreateThread(function()
    for k,v in pairs(cfg_menuperso.list) do
        RMenu.Add('props', v.name, RageUI.CreateSubMenu(RMenu:Get('props', 'main_menu'), 'Props', 'Props disponibles'))
        table.insert(pCat, v.name)
    end
end)

openProps = function()
    if props_menu_openned then
        props_menu_openned = false
        return
    else
        props_menu_openned = true
        Citizen.CreateThread(function()
            while props_menu_openned do
                Wait(1)
                
                RageUI.IsVisible(RMenu:Get('props', 'main_menu'), true, true, true, function()

                    for k,v in pairs(pCat) do
                        RageUI.Button(v, nil, {}, true, function(h, a, s) end, RMenu:Get('props', v))
                    end
        
                end, function()
                end)

                for k,v in pairs(pCat) do
                    RageUI.IsVisible(RMenu:Get('props', v), true, true, true, function()

                        for i,l in pairs(cfg_menuperso.list) do
                            if l.name == v then
                                for _,j in pairs(l.props) do
                                    if j.vip then
                                        if playerVip ~= "Aucun" then
                                            RageUI.Button(j.name, nil, {}, true, function(h, a, s)
                                                if s then
                                                    SpawnObj(j.prop, j.name)
                                                end
                                            end)
                                        else
                                            RageUI.Button("~c~"..j.name, nil, {RightBadge = RageUI.BadgeStyle.Lock, RightLabel = '~c~VIP'}, true, function(h, a, s)
                                                if s then
                                                    Extasy.ShowNotification("~r~Ce props est réservé aux joueurs ayant un grade VIP/VIP+\n~h~shop.alyniarp.fr")
                                                end
                                            end)
                                        end
                                    else
                                        RageUI.Button(j.name, nil, {}, true, function(h, a, s)
                                            if s then
                                                SpawnObj(j.prop, j.name)
                                            end
                                        end)
                                    end
                                end
                            end
                        end
            
                    end, function()
                    end)
                end

            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        pObjets = {}
        for v in EnumerateObjects() do
            table.insert(pObjets, v)
        end
        Wait(2000)
    end
end)

Citizen.CreateThread(function()
    DecorRegister("props", 3)
    local tWait = 500
    while true do
        Wait(tWait)
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
        for k,v in pairs(pObjets) do
            local oCoords = GetEntityCoords(v)
            local dst = GetDistanceBetweenCoords(pCoords, oCoords, true)
            if dst <= 2.0 then
                if DecorExistOn(v, "props") then
                    tWait = 1
                    Extasy.ShowHelpNotification("~p~Appuyez sur ~INPUT_PICKUP~ pour ramasser l'objet")
                    if IsControlJustReleased(1, 38) then
                        TriggerServerEvent("Extasy:deleteEntity", token, NetworkGetNetworkIdFromEntity(v))
                    end
                    break
                end
            else
                tWait = 500
            end
        end
    end
end)

SpawnObj = function(obj, nam)
    local playerPed = PlayerPedId()
	local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)
    local Ent = nil

    SpawnObject(obj, objectCoords, function(obj)
        SetEntityCoords(obj, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(obj)
        Ent = obj
        Wait(1)
    end)
    Wait(1)
    while Ent == nil do Wait(1) end
    SetEntityHeading(Ent, GetEntityHeading(playerPed))
    PlaceObjectOnGroundProperly(Ent)
    local placed = false
    while not placed do
        Wait(1)
        local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
        local objectCoords = (coords + forward * 2.0)
        SetEntityCoords(Ent, objectCoords, 0.0, 0.0, 0.0, 0)
        SetEntityHeading(Ent, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(Ent)
		SetEntityAlpha(Ent, 170, 170)
        SetEntityCollision(Ent, 0, 0)
        
        DisableControlAction(0, 22, true)

        Extasy.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour poser l'objet\nAppuyez sur ~INPUT_CELLPHONE_CAMERA_EXPRESSION~ pour annuler")

        if IsControlJustReleased(1, 38) then
            placed = true
        end
        if IsControlJustReleased(1, 186) then
            DeleteEntity(Ent)
            break
        end
    end

    EnableControlAction(0, 22, true)

	SetEntityCollision(Ent, 1, 1)
    FreezeEntityPosition(Ent, true)
    SetEntityInvincible(Ent, true)
    ResetEntityAlpha(Ent)
	local NetId = NetworkGetNetworkIdFromEntity(Ent)
	SetNetworkIdCanMigrate(NetId, true)
    DecorSetInt(NetworkGetEntityFromNetworkId(NetId), "props", 1)
end

SpawnObject = function(model, coords, cb)
	local model = GetHashKey(model)

	Citizen.CreateThread(function()
		RequestModels(model)
        Wait(1)
		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

		if cb then
			cb(obj)
		end
	end)
end

RequestModels = function(modelHash)
	if not HasModelLoaded(modelHash) and IsModelInCdimage(modelHash) then
		RequestModel(modelHash)

        while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
		end
	end
end