makeup_shop_openned = false
local makeup = {}
local makeup_notspam = {}
local cl_data = {}
local want_delete = false
local index = 1

RMenu.Add('makeup_shop', 'main_menu', RageUI.CreateMenu("Maquilleuse", "Que souhaitez-vous acheter ?", 1, 100))
RMenu:Get('makeup_shop', 'main_menu').Closed = function()
    makeup_shop_openned = false
    Extasy.KillGlobalCamera()
    TriggerEvent("skinchanger:loadPlayerSkin", playerSkin)
end

GetMaxVals_makeup = function()
    local playerPed = PlayerPedId()
 
    local data = {
        {label = "Type maquillage",                 price = 15,  item = "makeup_1",      max = GetNumHeadOverlayValues(4)-1,  min = 0},
        {label = "Épaisseur maquillage",            price = 15,  item = "makeup_2",      max = 10,                            min = 0},
        {label = "Couleur maquillage princpale",    price = 15,  item = "makeup_3",      max = GetNumHairColors()-1,          min = 0},
        {label = "Couleur maquillage secondaire",   price = 15,  item = "makeup_4",      max = GetNumHairColors()-1,          min = 0},
        {label = "Type lipstick",                   price = 15,  item = "lipstick_1",    max = GetNumHeadOverlayValues(8)-1,  min = 0},
        {label = "Épaisseur lipstick",              price = 15,  item = "lipstick_2",    max = 10,                            min = 0},
        {label = "Couleur lipstick princpale",      price = 15,  item = "lipstick_3",    max = GetNumHairColors()-1,          min = 0},
        {label = "Couleur lipstick secondaire",     price = 15,  item = "lipstick_4",    max = GetNumHairColors()-1,          min = 0},
        {label = "Lentilles colorées",              price = 15,  item = "eye_color",     max = 31,                            min = 0, },
    }
 
    return data
end

for k,v in pairs(GetMaxVals_makeup()) do
    RMenu.Add('makeup_shop', v.item, RageUI.CreateSubMenu(RMenu:Get('makeup_shop', 'main_menu'), "Maquilleuse", "Que souhaitez-vous acheter ?"))
    RMenu:Get('makeup_shop', v.item).Closed = function()
        Extasy.SwitchCam(true, "default")
    end
end

openmakeup_m = function()
    if makeup_shop_openned then
        makeup_shop_openned = false
        return
    else
        makeup_shop_openned = true
        Citizen.CreateThread(function()
            while makeup_shop_openned do
                Wait(1)
                
                RageUI.IsVisible(RMenu:Get('makeup_shop', 'main_menu'), true, true, true, function()

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index = Index
                    end)  

                    RageUI.Separator("")

                    for k,v in pairs(makeup) do
                        RageUI.Button(v.label, nil, {}, true, function(_,h,s)
                            -- if h then
                            --     -- SetCamCoord(camera_accessories, barbers_data.camOptions.camPos)
                            --     -- SetCamRot(camera_accessories, barbers_data.camOptions.camRotx, barbers_data.camOptions.camRoty, barbers_data.camOptions.camRotz, 2)
                            --     -- SetCamFov(camera_accessories, barbers_data.camOptions.camFov)
                            -- end
                            if s then
                                Extasy.SwitchCam(false, v.item)
                            end
                        end, RMenu:Get('makeup_shop', v.item))
                    end
        
                end, function()
                end)

                for k,v in pairs(makeup) do
                    RageUI.IsVisible(RMenu:Get('makeup_shop', v.item), true, true, true, function()
        
                        for i = v.min, v.max do
                            RageUI.Button(v.label.." #"..i, nil, {RightLabel = v.price.."$"}, true, function(_,h,s)
                                if h then
                                    if makeup_notspam[k] == nil then makeup_notspam[k] = i end
                                    if makeup_notspam[k] ~= i then
                                        TriggerEvent("skinchanger:change", v.item, i)
                                        makeup_notspam[k] = i
                                    end
                                end
                                if s then
                                    TriggerEvent("skinchanger:change", v.item, i)
                                    TriggerEvent('skinchanger:getSkin', function(skin)               
                                        TriggerServerEvent('esx_skin:save', skin)               
                                    end)

                                    TriggerServerEvent("Makeup:buy", token, cfg_makeup.price, index, v.label)
                                    Addbank_transac("Makeup", Extasy.Math.GroupDigits(cfg_makeup.price), "out")

                                    TriggerEvent("skinchanger:getSkin", function(skin)
                                        playerSkin = skin
                                    end)
                                end
                            end) 
                        end
                    end, function()
                    end)
                end

            end
        end)
    end
end

CreateThread(function()
    while cfg_makeup == nil do Wait(1) end
    while true do
        local near_makeup  = false
        local ped       = GetPlayerPed(-1)
        local pedCoords = GetEntityCoords(ped)

        for k,v in pairs(cfg_makeup.shops) do
            local dst    = GetDistanceBetweenCoords(pedCoords, v.pos, true)

            if dst <= 1.5 then
                near_makeup = true
                Extasy.ShowHelpNotification("~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le salon de maquillage")
                DrawMarker(6, v.pos - 1.5, nil, nil, nil, -90, nil, nil, 1.5, 1.5, 1.5, 100, 0, 200, 100, false, false)
                if IsControlJustReleased(1, 38) then
                    if not makeup_shop_openned then
                        openmakeup()
                    else
                        makeup_shop_openned = false
                        RageUI.CloseAll()
                    end
                end
            end
        end

        if near_makeup then
            Wait(1)
        else
            Wait(750)
        end
    end
end)

openmakeup = function()
    Extasy.SwitchCam(true, "default")
    Wait(250)
    Extasy.CreateGlobalCamera()
    
    TriggerEvent("skinchanger:getSkin", function(skin)
        playerSkin = skin
    end)

    makeup = GetMaxVals_makeup()

    RageUI.Visible(RMenu:Get('makeup_shop', 'main_menu'), true)
    openmakeup_m()
end

CreateThread(function()
    for k,v in pairs(cfg_makeup.shops) do
		local blip = AddBlipForCoord(v.pos)
		SetBlipSprite(blip, 102)
        SetBlipColour(blip, 48)
        SetBlipScale(blip, 0.65)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Salon de maquillage")
		EndTextCommandSetBlipName(blip)
	end
end)