
clothes_shop_openned = false
local clothes = {}
local clothes_notspam = {}
local cl_data = {}
local want_delete = false
local index = 1
playerClothes = {}

RegisterNetEvent("clothes:receveClothes") 
AddEventHandler("clothes:receveClothes", function(clothesData)
    playerClothes = {}
    playerClothes = clothesData
end)

RMenu.Add('clothes_shop', 'main_menu', RageUI.CreateMenu("Magasin de vêtements", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('clothes_shop', 'main_menu').Closed = function()
    clothes_shop_openned = false
    Extasy.KillGlobalCamera()
    TriggerEvent("skinchanger:loadPlayerSkin", playerSkin)
    FreezeEntityPosition(PlayerPedId(), false)
end
RMenu.Add('clothes_shop', 'my_clothes', RageUI.CreateSubMenu(RMenu:Get('clothes_shop', 'main_menu'), "Vos tenues", "Que souhaitez-vous faire ?"))
RMenu.Add('clothes_shop', 'my_clothes_choose', RageUI.CreateSubMenu(RMenu:Get('clothes_shop', 'main_menu'), "Vos tenues", "Que souhaitez-vous faire ?"))

GetMaxVals_tenue = function()
	local playerPed = PlayerPedId()

    TriggerEvent("skinchanger:getSkin", function(skin)
        playerSkin = skin
    end)

	local ten = {
        {label = "T-Shirt", price = 10, item = "tshirt_1", max = GetNumberOfPedDrawableVariations(playerPed, 8) - 1, min = 0, current = playerSkin["tshirt_1"],},
        {label = "Couleur T-Shirt", price = 10, item = "tshirt_2", max = 26 - 1, min = 0, current = playerSkin["tshirt_2"],},
        {label = "Veste", price = 10, item = "torso_1", max = GetNumberOfPedDrawableVariations(playerPed, 11) - 1, min = 0, current = playerSkin["torso_1"],},
        {label = "Couleur veste", price = 10, item = "torso_2", max = 26 - 1, min = 0, current = playerSkin["torso_2"],},
        {label = "Calques", price = 10, item = "decals_1", 		max = GetNumberOfPedDrawableVariations(playerPed, 10) - 1, min = 0, current = playerSkin["decals_1"],},
		{label = "Calques 2", price = 10, item = "decals_2", 		max = 15, min = 0, current = playerSkin["decals_2"],},
        {label = "Sac", price = 10, item = "bags_1", max = GetNumberOfPedDrawableVariations(playerPed, 5) - 1, min = 0, current = playerSkin["bags_1"],},
        {label = "Couleur sac", price = 10, item = "bags_2", max = 30, min = 0, current = playerSkin["bags_2"],},
        {label = "Gilet 1", price = 10,      item = "bproof_1",      max = GetNumberOfPedDrawableVariations(playerPed, 9) - 1,                               min = 0, current = playerSkin["bproof_1"],},
        {label = "Couleur gilet", price = 10,      item = "bproof_2",      max = 15,          min = 0, current = playerSkin["bproof_2"],},
        {label = "Lunette", price = 10,      item = "glasses_1",      max = GetNumberOfPedPropDrawableVariations(playerPed, 1) - 1,                          min = 0, current = playerSkin["glasses_1"],},
        {label = "Couleur lunette", price = 10,      item = "glasses_2",      max = 15,          min = 0, current = playerSkin["glasses_2"],},
        {label = "Chapeaux", price = 10,      item = "helmet_1",      max = GetNumberOfPedPropDrawableVariations(playerPed, 0) - 1,                          min = -1, current = playerSkin["helmet_1"],},
        {label = "Couleur Chapeaux", price = 10,      item = "helmet_2",      max = 15,          min = 0, current = playerSkin["helmet_2"],},
        {label = "Accessoire d'oreil", price = 10,      item = "ears_1",      max = GetNumberOfPedPropDrawableVariations(playerPed, 0) - 1,                          min = -1, current = playerSkin["ears_2"],},
        {label = "Couleur accessoire", price = 10,      item = "ears_2",      max = 15,          min = 0, current = playerSkin["ears_2"],},
        {label = "Bras/gants", price = 10, item = "arms", max = GetNumberOfPedDrawableVariations(playerPed, 3) - 1, min = 0, current = playerSkin["arms"],},
        {label = "Couleur gants", price = 10, item = "arms_2", max = 10, min = 0, current = playerSkin["arms_2"],},
        {label = "Pantalon/short", price = 10, item = "pants_1", max = 200 - 1, min = 0, current = playerSkin["pants_1"],},
        {label = "Couleur pantalon/short", price = 10, item = "pants_2", max = 26 - 1, min = 0, current = playerSkin["pants_2"],},
        {label = "Chaussures", price = 10, item = "shoes_1", max = GetNumberOfPedDrawableVariations(playerPed, 6) - 1, min = 0, current = playerSkin["shoes_1"],},
        {label = "Couleur chaussures", price = 10, item = "shoes_2", max = GetNumberOfPedTextureVariations(playerPed, 6, GetPedTextureVariation(playerPed, 6)) - 1, min = 0, current = playerSkin["shoes_2"],},
    }

	return ten
end

for k,v in pairs(GetMaxVals_tenue()) do
    RMenu.Add('clothes_shop', v.item, RageUI.CreateSubMenu(RMenu:Get('clothes_shop', 'main_menu'), "Magasin de vêtements", "Que souhaitez-vous faire ?"))
    RMenu:Get('clothes_shop', v.item).Closed = function()
        Extasy.SwitchCam(true, "default")
    end
end

openClothes_m = function()
    if clothes_shop_openned then
        clothes_shop_openned = false
        return
    else
        clothes_shop_openned = true
        TriggerServerEvent("Extasy:GetTenues", token)
        Citizen.CreateThread(function()
            while clothes_shop_openned do
                TurnPedClotheShop()
                DisableAllControlActions(0)
                Wait(1)

                RageUI.IsVisible(RMenu:Get('clothes_shop', 'main_menu'), true, true, true, function()

                    RageUI.Button("Mes tenues sauvegardées", nil, {}, true, function(h, a, s)
                    end, RMenu:Get('clothes_shop', 'my_clothes'))   

                    RageUI.Button("Sauvegarder ma tenue", nil, {}, true, function(h, a, s)
                        if s then
                            i = Extasy.KeyboardInput("Définissez le nom de votre tenue", "", 30)
                            i = tostring(i)
                            if i ~= nil then
                                if i ~= '' then
                                    TriggerEvent('skinchanger:getSkin', function(skin)               
                                        TriggerServerEvent("Extasy:SaveTenueS", token, '"'..i..'"', skin)              
                                    end)
                                    Wait(550)
                                    Extasy.ShowNotification("~p~Tenue sauvegarder")
                                    TriggerServerEvent("Extasy:GetTenues", token)
                                else
                                    Extasy.ShowNotification("~r~Nom de tenue incorrect")
                                end
                            else
                                Extasy.ShowNotification("~r~Nom de tenue incorrect")
                            end
                        end
                    end)   

                    RageUI.Separator("")

                    for k,v in pairs(clothes) do
                        local t = nil

                        if v.current ~= nil then
                            t = {RightLabel = "("..v.current..")"} 
                        else 
                            t = {} 
                        end

                        RageUI.Button(v.label, nil, t, true, function(_,h,s)
                            if s then
                                Extasy.SwitchCam(false, v.item)
                                RMenu:Get('clothes_shop', v.item).Index = 1
                            end
                        end, RMenu:Get('clothes_shop', v.item))
                    end
        
                end, function()
                end)

                for k,v in pairs(clothes) do
                    RageUI.IsVisible(RMenu:Get('clothes_shop', v.item), true, true, true, function()

                        for i = v.min, v.max do
                            RageUI.Button(v.label.." #"..i, nil, {RightLabel = v.price.."$"} , true, function(_,h,s)
                                if h then
                                    TriggerEvent("skinchanger:change", v.item, i)
                                    --print(i)
                                    --print(v.item)
                                    --print("----")
                                    --[[if clothes_notspam[k] == nil then clothes_notspam[k] = i end
                                    if clothes_notspam[k] ~= i then
                                        TriggerEvent("skinchanger:change", v.item, i)
                                        clothes_notspam[k] = i
                                    end--]]
                                end
                                if s then
                                    ESX.TriggerServerCallback('Extasy:BuyVetement', function(hasEnoughMoneyForLocation)
                                        if hasEnoughMoneyForLocation then
                                            TriggerEvent("skinchanger:change", v.item, i)
                                            
                                            --[[if v.label == "Sac" then
                                                for k,v in pairs(bagList) do
                                                    if v.bag == i then
                                                        playerGotBag = true
                                                        Extasy.ShowNotification("~g~Ce sac vous donne +20KG de stockage dans votre inventaire !")
                                                    end
                                                end
                                            end--]]
                                            TriggerEvent("skinchanger:getSkin", function(skin)
                                                playerSkin = skin
                                                playerSkin.sex = playerCurrentPed
                                            end)
                                            TriggerEvent('skinchanger:getSkin', function(skin)               
                                                TriggerServerEvent('esx_skin:save', skin)               
                                            end)
                                            clothes = GetMaxVals_tenue()
                                            Extasy.ShowNotification("~p~Vous avez payer : "..v.price.."$")
                                            Addbank_transac("Achat vêtements", Extasy.Math.GroupDigits(v.price), "out")
                                        else
                                            Extasy.ShowNotification("~r~Vous n'avez pas assez d'argent sur vous")
                                        end
                                    end, v.price)
                                end
                            end) 
                        end
                    end, function()
                    end)
                end

                RageUI.IsVisible(RMenu:Get('clothes_shop', 'my_clothes'), true, true, true, function()
        
                    RageUI.Separator(#playerClothes.."/"..extasy_core_cfg["max_clothes_save"].." tenues")
                    RageUI.Separator("")
                    for k,v in pairs(playerClothes) do
                        if v.label ~= nil then
                            RageUI.Button("Tenue #"..k.." '"..v.label.."'", nil, {}, true, function(h, a, s)
                                if h then
                                    TriggerEvent("skinchanger:getSkin", function(skin)
                                        local d = json.decode(v.tenue)
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                        TriggerEvent("skinchanger:loadClothes", skin, d)
                                    end)
                                end
                                if s then
                                    cl_data.d = v
                                    want_delete = false
                                end
                            end, RMenu:Get('clothes_shop', 'my_clothes_choose'))
                        end
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('clothes_shop', 'my_clothes_choose'), true, true, true, function()
                    RageUI.Button("Porter", nil, {}, true, function(h, a, s)
                        if s then
                            TriggerEvent("skinchanger:getSkin", function(skin)
                                TriggerEvent('skinchanger:loadClothes', skin, json.decode(cl_data.d.tenue))
                                    TriggerEvent('esx_skin:setLastSkin', skin)
                                    TriggerEvent('skinchanger:getSkin', function(skin)
                                        TriggerServerEvent('esx_skin:save', skin)
                                    end)
                                RageUI.GoBack()
                            end)
                        end
                    end)
                    RageUI.Button("Renommer", nil, {}, true, function(h, a, s)
                        if s then
                            i = Extasy.KeyboardInput("Définissez le nouveau nom de votre tenue", "", 30)
                            i = tostring(i)
                            if i ~= nil then
                                TriggerServerEvent("Extasy:RenameTenue", token, cl_data.d.id, i)
                                Wait(50)
                                TriggerServerEvent("Extasy:GetTenues", token)
                                RageUI.GoBack()
                            else
                                Extasy.ShowNotification("~r~Nom de tenue incorrect")
                            end
                        end
                    end)
                    RageUI.Button("Compresser", nil, {}, true, function(h, a, s)
                        if s then
                            TriggerServerEvent("Extasy:GiveClothes", token, "Tenue", 1, cl_data.d.tenue, cl_data.d.label)
                            Extasy.ShowNotification("Vous avez reçu ~g~x1 Tenue "..cl_data.d.label)
                            RageUI.GoBack()
                        end
                    end)
                    if not want_delete then
                        RageUI.Button("~r~Supprimer", nil, {}, true, function(h, a, s)
                            if s then
                                want_delete = true
                            end
                        end)
                    else
                        RageUI.Button("~r~Supprimer", nil, {RightLabel = "~r~Appuyez pour confirmer"}, true, function(h, a, s)
                            if s then
                                TriggerServerEvent("Extasy:DeleteTenue", token, cl_data.d.id)
                                Wait(50)
                                TriggerServerEvent("Extasy:GetTenues", token)
                                RageUI.GoBack()
                                want_delete = false
                            end
                        end)
                    end

                end, function()
                end)
            end
        end)
    end
end

openClothes = function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
    Extasy.SwitchCam(true, "default")
    Citizen.Wait(250)
    Extasy.CreateGlobalCamera()

    TriggerEvent("skinchanger:getSkin", function(skin)
        playerSkin = skin
    end)

    clothes = GetMaxVals_tenue()

    RageUI.Visible(RMenu:Get('clothes_shop', 'main_menu'), true)
    openClothes_m()
end


openClothesSaveMenu_m = function()
    if clothes_shop_openned then
        clothes_shop_openned = false
        return
    else
        clothes_shop_openned = true
        TriggerServerEvent("Extasy:GetTenues", token)
        Citizen.CreateThread(function()
            while clothes_shop_openned do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('clothes_shop', 'my_clothes'), true, true, true, function()
        
                    RageUI.Separator(#playerClothes.."/"..extasy_core_cfg["max_clothes_save"].." tenues")
                    RageUI.Separator("")
                    for k,v in pairs(playerClothes) do
                        RageUI.Button("Tenue #"..k.." '"..v.label.."'", nil, {}, true, function(h, a, s)
                            if h then
                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    local d = json.decode(v.tenue)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                end)
                            end
                            if s then
                                cl_data.d = v
                                want_delete = false
                            end
                        end, RMenu:Get('clothes_shop', 'my_clothes_choose'))
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('clothes_shop', 'my_clothes_choose'), true, true, true, function()
                    RageUI.Button("Porter", nil, {}, true, function(h, a, s)
                        if s then
                            TriggerEvent("skinchanger:getSkin", function(skin)
                                TriggerEvent('skinchanger:loadClothes', skin, json.decode(cl_data.d.tenue))
                                TriggerEvent('skinchanger:getSkin', function(skin)               
                                    TriggerServerEvent('esx_skin:save', skin)               
                                end)
                                RageUI.GoBack()
                            end)
                        end
                    end)
                    RageUI.Button("Renommer", nil, {}, true, function(h, a, s)
                        if s then
                            i = Extasy.KeyboardInput("Définissez le nouveau nom de votre tenue", "", 30)
                            i = tostring(i)
                            if i ~= nil then
                                TriggerServerEvent("Extasy:RenameTenue", token, cl_data.d.id, i)
                                Wait(50)
                                TriggerServerEvent("Extasy:GetTenues", token)
                                RageUI.GoBack()
                            else
                                Extasy.ShowNotification("~r~Nom de tenue incorrect")
                            end
                        end
                    end)
                    if not want_delete then
                        RageUI.Button("~r~Supprimer", nil, {}, true, function(h, a, s)
                            if s then
                                want_delete = true
                            end
                        end)
                    else
                        RageUI.Button("~r~Supprimer", nil, {RightLabel = "~r~Appuyez pour confirmer"}, true, function(h, a, s)
                            if s then
                                TriggerServerEvent("Extasy:DeleteTenue", token, cl_data.d.id)
                                Wait(50)
                                TriggerServerEvent("Extasy:GetTenues", token)
                                RageUI.GoBack()
                                want_delete = false
                            end
                        end)
                    end

                end, function()
                end)
            end
        end)
    end
end

openClothesSaveMenuHotel_m = function()
    if clothes_shop_openned then
        clothes_shop_openned = false
        return
    else
        clothes_shop_openned = true
        TriggerServerEvent("Extasy:GetTenues", token)
        Citizen.CreateThread(function()
            while clothes_shop_openned do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('clothes_shop', 'my_clothes'), true, true, true, function()
        
                    RageUI.Separator(#playerClothes.."/"..extasy_core_cfg["max_clothes_save"].." tenues")
                    RageUI.Separator("")
                    for k,v in pairs(playerClothes) do
                        RageUI.Button("Tenue #"..k.." '"..v.label.."'", nil, {}, true, function(h, a, s)
                            if h then
                                TriggerEvent("skinchanger:getSkin", function(skin)
                                    local d = json.decode(v.tenue)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                    TriggerEvent("skinchanger:loadClothes", skin, d)
                                end)
                            end
                            if s then
                                cl_data.d = v
                                want_delete = false
                            end
                        end, RMenu:Get('clothes_shop', 'my_clothes_choose'))
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('clothes_shop', 'my_clothes_choose'), true, true, true, function()
                    RageUI.Button("Porter", nil, {}, true, function(h, a, s)
                        if s then
                            TriggerEvent("skinchanger:getSkin", function(skin)
                                TriggerEvent('skinchanger:loadClothes', skin, json.decode(cl_data.d.tenue))
                                TriggerEvent('skinchanger:getSkin', function(skin)               
                                    TriggerServerEvent('esx_skin:save', skin)               
                                end)
                                RageUI.CloseAll()
                                clothes_shop_openned = false
                                Extasy.KillGlobalCamera()
                                TriggerEvent("skinchanger:loadPlayerSkin", playerSkin)
                                --FreezeEntityPosition(PlayerPedId(), false)
                            end)
                        end
                    end)
                    RageUI.Button("Renommer", nil, {}, true, function(h, a, s)
                        if s then
                            i = Extasy.KeyboardInput("Définissez le nouveau nom de votre tenue", "", 30)
                            i = tostring(i)
                            if i ~= nil then
                                TriggerServerEvent("Extasy:RenameTenue", token, cl_data.d.id, i)
                                Wait(50)
                                TriggerServerEvent("Extasy:GetTenues", token)
                                RageUI.CloseAll()
                                clothes_shop_openned = false
                                Extasy.KillGlobalCamera()
                                TriggerEvent("skinchanger:loadPlayerSkin", playerSkin)
                                --FreezeEntityPosition(PlayerPedId(), false)
                            else
                                Extasy.ShowNotification("~r~Nom de tenue incorrect")
                            end
                        end
                    end)
                    if not want_delete then
                        RageUI.Button("~r~Supprimer", nil, {}, true, function(h, a, s)
                            if s then
                                want_delete = true
                            end
                        end)
                    else
                        RageUI.Button("~r~Supprimer", nil, {RightLabel = "~r~Appuyez pour confirmer"}, true, function(h, a, s)
                            if s then
                                TriggerServerEvent("Extasy:DeleteTenue", token, cl_data.d.id)
                                Wait(50)
                                TriggerServerEvent("Extasy:GetTenues", token)
                                RageUI.CloseAll()
                                clothes_shop_openned = false
                                Extasy.KillGlobalCamera()
                                TriggerEvent("skinchanger:loadPlayerSkin", playerSkin)
                                --FreezeEntityPosition(PlayerPedId(), false)
                                want_delete = false
                            end
                        end)
                    end

                end, function()
                end)
            end
        end)
    end
end

TurnPedClotheShop = function()
    FreezeEntityPosition(PlayerPedId(), true)
   -- DisableAllControlActions(0)
   if clothes_shop_openned then 
        Extasy.PopupTime("Appuyez sur ~p~[E]~s~ ou ~p~[A]~s~ pour tourner votre personnage~s~.", 50)
        local Control1, Control2 = IsDisabledControlPressed(1, 44), IsDisabledControlPressed(1, 51)
        if Control1 or Control2 then
            SetEntityHeading(PlayerPedId(), Control1 and GetEntityHeading(PlayerPedId()) - 2.0 or Control2 and GetEntityHeading(PlayerPedId()) + 2.0)
        end
    end
end

openClothesSaveMenu = function()
    TriggerEvent("skinchanger:getSkin", function(skin)
        playerSkin = skin
    end)

    clothes = GetMaxVals_tenue()

    RageUI.Visible(RMenu:Get('clothes_shop', 'my_clothes'), true)
    openClothesSaveMenuHotel_m()
end

registerNewMarker({
    npcType          = 'drawmarker',
    pos              = vector3(3484.676, 5201.039, 8.480458),
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir ~p~le magasin de vêtements",
    action           = function()
        openClothes()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 50,

    blip_enable      = false,

    marker           = true,
    size             = 1.45,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    pos              = vector3(2444.73, 7212.009, 9.09),
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir ~p~le magasin de vêtements",
    action           = function()
        openClothes()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 50,

    blip_enable      = false,

    marker           = true,
    size             = 1.45,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})