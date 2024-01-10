local tatooMenuOpened = false
local playerTatoos = {}
local currentPreviewTatoo = nil
local cleaning = false

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Wait(5)
	end
end)

AddEventHandler('skinchanger:modelLoaded', function()
	TriggerServerEvent('TattooShop:requestPlayerTatoos', token)
end)

RegisterNetEvent("TattooShop:buyCallback")
AddEventHandler("TattooShop:buyCallback", function(ok)
    if ok then
        Extasy.ShowNotification("~g~Tatouage acheté")
        TriggerServerEvent('TattooShop:requestPlayerTatoos', token)
    else
        Extasy.ShowNotification("~r~Tatouages\n~o~Tu n'a pas assez d'argent")
    end
end)

RegisterNetEvent("TattooShop:tatoesCallback")
AddEventHandler("TattooShop:tatoesCallback", function(ok)
    if ok ~= nil then
        print("Player has tatooes")
        playerTatoos = json.decode(ok)
        ClearPedDecorations(PlayerPedId())
        for _,t in pairs(playerTatoos) do
            ApplyPedOverlay(PlayerPedId(),t.cat,t.name) 
        end
    end
end)

RegisterNetEvent("TattooShop:clean")
AddEventHandler("TattooShop:clean", function(ok)
    if ok then
        playerTatoos = {}
        DoScreenFadeOut(1000)
        while not IsScreenFadedOut() do Citizen.Wait(10) end
        ClearPedDecorations(PlayerPedId())
        Citizen.Wait(200)
        DoScreenFadeIn(1000)
        cleaning = false
    end
end)

function Mettretoutnu()
    FreezeEntityPosition(playerPed, true)
    TriggerEvent('skinchanger:getSkin', function(skin)
        local clothesSkin = {
            ['tshirt_1'] = 15, ['tshirt_2'] = 0,
            ['torso_1'] = 15, ['torso_2'] = 3,
            ['arms'] = 15,
            ['pants_1'] = 14, ['pants_2'] = 0,
            ['shoes_1'] = 16, ['shoes_2'] = 0,
            ['mask_1'] = 0, ['mask_2'] = 0,
            ['bproof_1'] = 0, ['bproof_2'] = 0,
            ['helmet_1'] = -1, ['helmet_2'] = 0,
        }
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
    TriggerServerEvent('TattooShop:requestPlayerTatoos', token)
end

local tatooMenuOpened = false

RMenu.Add("TattooShop", 'tatoos', RageUI.CreateMenu(nil,"Tatouages", nil, nil, "root_cause", "shopui_title_inkinc"))
RMenu:Get('TattooShop', 'tatoos').Closed = function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
            TriggerEvent('esx:restoreLoadout') 
        end) 
    end)
    FreezeEntityPosition(playerPed, false)
end

function openTattooShopMenu()
    Mettretoutnu()
    if not tatooMenuOpened then 
        tatooMenuOpened = true
		RageUI.Visible(RMenu:Get("TattooShop", 'tatoos'), true)
		Citizen.CreateThread(function()
			while tatooMenuOpened do
                Citizen.Wait(1)

                tatooMenuOpened = false
                RageUI.IsVisible(RMenu:Get("TattooShop",'tatoos'),true,true,true,function()
                    tatooMenuOpened = true
                    for k,v in pairs(cfg_tattooshop.TattooCategories) do
                        RMenu.Add('TattooShop', 'part'..k, RageUI.CreateSubMenu(RMenu:Get('TattooShop', 'tatoos'), nil, "Sélectionnez vos Tatouages"))
                        RMenu:Get('TattooShop', 'part'..k).Closed = function()
                            ClearPedDecorations(PlayerPedId())
                            for _,t in pairs(playerTatoos) do
                                ApplyPedOverlay(PlayerPedId(),t.cat,t.name) 
                            end
                        end
                    end

                    RageUI.ButtonWithStyle("~y~Effacer tous mes tatouages", nil, { RightLabel = "~r~1500$ ~s~→→" }, not cleaning, function(h, a, s)
                        if s then
                            cleaning = true
                            TriggerServerEvent("TattooShop:payClean", token, 1500)
                            Addbank_transac("Retrait tatouage", Extasy.Math.GroupDigits(1500), "out")
                        end
                    end)

                    RageUI.Separator("↓ ~p~Catégories~s~ ↓")

                    for k,v in pairs(cfg_tattooshop.TattooCategories) do
                        RageUI.Button(v.name, nil, { RightLabel = "→→" }, true, function()
                        end, RMenu:Get('TattooShop', 'part'..k))
                    end
                    
                end, function()
                end)


                for k,v in pairs(cfg_tattooshop.TattooCategories) do
                    RageUI.IsVisible(RMenu:Get('TattooShop', 'part'..k), true, true, true, function()
                        tatooMenuOpened = true
                        for index,tatoo in pairs(cfg_tattooshop.TattooList[v.value]) do
                            RageUI.Button("Tatouage n°"..index, nil, { RightLabel = "~g~$"..tatoo.price.." ~s~→→" }, true, function(Hovered, a, s)
                                if (a) then
                                    if currentPreviewTatoo ~= GetHashKey(tatoo.nameHash) then 
                                        ClearPedDecorations(PlayerPedId())
                                        for _,t in pairs(playerTatoos) do
                                            ApplyPedOverlay(PlayerPedId(),t.cat,t.name) 
                                        end
                                        ApplyPedOverlay(PlayerPedId(),GetHashKey(cfg_tattooshop.TattooCategories[k].value),GetHashKey(tatoo.nameHash)) 
                                    end
                                    currentPreviewTatoo = GetHashKey(tatoo.nameHash)
                                end
                                if (s) then
                                    local needModif = true
                                    for _,t in pairs(playerTatoos) do
                                        if GetHashKey(cfg_tattooshop.TattooCategories[k].value) == playerTatoos.cat and GetHashKey(tatoo.nameHash) == playerTatoos.name then
                                            needModif = false
                                        end
                                    end
                                    if needModif then
                                        table.insert(playerTatoos, {cat = GetHashKey(cfg_tattooshop.TattooCategories[k].value), name = GetHashKey(tatoo.nameHash)})
                                        TriggerServerEvent("TattooShop:pay", token, tatoo.price, playerTatoos)
                                        Addbank_transac("Tatouage n°"..index, Extasy.Math.GroupDigits(tatoo.price), "out")
                                        Citizen.Wait(100)
                                        TriggerServerEvent('TattooShop:requestPlayerTatoos', token)
                                    else
                                        Extasy.ShowNotification("~r~Vous possédez déjà ce tatouage!")
                                    end
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

