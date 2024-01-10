ESX, isMenuActive, canInteractWithZone, serverInteraction = nil, false, true, false

Citizen.CreateThread(function()
    TriggerEvent("ext:getSharedObject", function(obj)
        ESX = obj
    end)
end)

-- Menu
local cat = "hotel"

local function customGroupDigits(value)
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')

	return left..(num:reverse():gsub('(%d%d%d)','%1' .. "."):reverse())..right
end

local function sub(name)
    return cat..name
end

local function showbox(TextEntry, ExampleText, MaxStringLenght, isValueInt)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    local blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        if isValueInt then
            local isNumber = tonumber(result)
            if isNumber and tonumber(result) > 0 then
                return result
            else
                return nil
            end
        end

        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end

local function createMenuPanes()
    local title = "Hôtel"
    desc = "Location de chambres d'hotel"
    descSafe = "~p~Coffre fort"

    RMenu.Add(cat, sub("main"), RageUI.CreateMenu(title, desc))
        RMenu:Get(cat, sub("main")).Closed = function()
    end

    RMenu.Add(cat, sub("safe"), RageUI.CreateMenu(title, descSafe))
        RMenu:Get(cat, sub("safe")).Closed = function()
    end

    RMenu.Add(cat, sub("safe_deposit"), RageUI.CreateSubMenu(RMenu:Get(cat, sub("safe")), title, descSafe))
        RMenu:Get(cat, sub("safe_deposit")).Closed = function()
    end

    RMenu.Add(cat, sub("rent"), RageUI.CreateSubMenu(RMenu:Get(cat, sub("main")), title, desc))
        RMenu:Get(cat, sub("rent")).Closed = function()
    end
end


Citizen.CreateThread(function()
    createMenuPanes()
end)

RegisterNetEvent("hotel:updateContent")
RegisterNetEvent("hotel:updatePlayerContent")
RegisterNetEvent("hotel:openSafe")
AddEventHandler("hotel:openSafe", function(playerContent, content, labelTable)
    if isMenuActive then return end
    isMenuActive = true
    canInteractWithZone = true
    AddEventHandler("hotel:updateContent", function(newContent)
        content = newContent
    end)
    AddEventHandler("hotel:updatePlayerContent", function(newContent)
        playerContent = newContent
    end)
    FreezeEntityPosition(PlayerPedId(), true)
    RageUI.Visible(RMenu:Get(cat, sub("safe")), true)
    Citizen.CreateThread(function()
        while isMenuActive do
            local shouldStayOpened = false
            local function tick()
                shouldStayOpened = true
            end

            RageUI.IsVisible(RMenu:Get(cat, sub("safe")), true, true, true, function()
                tick()
                RageUI.Separator("Bienvenue au ~p~"..cfg_hotel.name)

                RageUI.Separator("Contenu: ~p~"..countItems(content).."~s~/~p~"..cfg_hotel.safeMaxQty)

                RageUI.ButtonWithStyle("Mes tenues", "Appuyez pour voir vos tenues", {RightLabel = "Regarder →→"}, true, function(_,_,s)
                    if s then
                        RageUI.CloseAll()
                        isMenuActive = false
                        Extasy.KillGlobalCamera()
                        clothes_shop_openned = false
                        openClothesSaveMenu()
                    end
                end)

                RageUI.ButtonWithStyle("Déposer des objects", "Appuyez pour déposer des objets", {RightLabel = "→"}, true, nil, RMenu:Get(cat, sub("safe_deposit")))

                RageUI.Separator("↓ ~p~Contenu ~s~↓")
                if countTable(content) > 0 then
                    for itemName, count in pairs(content) do
                        RageUI.ButtonWithStyle("[~p~x"..count.."~s~] "..labelTable[itemName], "Appuyez pour récupérer cet item", {RightLabel = "Retirer →→"}, not serverInteraction, function(_,_,s)
                            if s then
                                local qty = showbox("Quantité à retirer du coffre", "", 20, true)
                                if qty ~= nil then
                                    serverInteraction = true
                                    TriggerServerEvent("hotel:itemRecover", token, itemName, qty)
                                else
                                    Extasy.ShowNotification("~r~Quantité invalide")
                                end
                            end
                        end)
                    end
                else
                    RageUI.ButtonWithStyle("~r~Le coffre est vide", nil, {}, true)
                end
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get(cat, sub("safe_deposit")), true, true, true, function()
                tick()
                RageUI.Separator("Bienvenue au ~p~"..cfg_hotel.name)
                RageUI.Separator("Contenu: ~p~"..countItems(content).."~s~/~p~"..cfg_hotel.safeMaxQty)
                RageUI.Separator("↓ ~p~Votre inventaire ~s~↓")
                if countTable(playerContent) > 0 then
                    for itemName, count in pairs(playerContent) do
                        RageUI.ButtonWithStyle("[~p~x"..count.."~s~] "..labelTable[itemName], "Appuyez pour déposer cet item", {RightLabel = "Déposer →→"}, not serverInteraction, function(_,_,s)
                            if s then
                                local qty = showbox("Quantité à déposer du coffre", "", 20, true)
                                if qty ~= nil then
                                    serverInteraction = true
                                    TriggerServerEvent("hotel:itemDeposit", token, itemName, qty)
                                else
                                    Extasy.ShowNotification("~r~Quantité invalide")
                                end
                            end
                        end)
                    end
                else
                    RageUI.ButtonWithStyle("~r~Le coffre est vide", nil, {}, true)
                end
            end, function()
            end)

            if not shouldStayOpened and isMenuActive then
                FreezeEntityPosition(PlayerPedId(), false)
                isMenuActive = false
            end
            Wait(0)
        end
    end)
end)

RegisterNetEvent("hotel:openMenu")
AddEventHandler("hotel:openMenu", function(isOwner, expiration)
    if isMenuActive then return end
    FreezeEntityPosition(PlayerPedId(), true)
    serverInteraction = false
    isMenuActive = true
    RageUI.Visible(RMenu:Get(cat, sub("main")), true)

    Citizen.CreateThread(function()
        local selectedNights = 1
        while isMenuActive do
            local shouldStayOpened = false
            local function tick()
                shouldStayOpened = true
            end

            RageUI.IsVisible(RMenu:Get(cat, sub("main")), true, true, true, function()
                tick()
                RageUI.Separator("Bienvenue au ~p~"..cfg_hotel.name)
                if isOwner then
                    RageUI.Separator("Expiration: ~y~"..expiration)
                    RageUI.Separator("↓ ~p~Interactions ~s~↓")
                    RageUI.ButtonWithStyle("Entrer dans ma chambre", "Appuyez pour entrer dans votre chambre", {}, not serverInteraction, function(_,_,s)
                        if s then
                            serverInteraction = true
                            shouldStayOpened = false
                            TriggerServerEvent("hotel:enter", token)
                            DisplayRadar(false)
                        end
                    end)
                else
                    RageUI.Separator("Prix d'une nuit: ~g~"..customGroupDigits(cfg_hotel.PrixParJour).."$~s~")
                    RageUI.Separator("↓ ~p~Interactions ~s~↓")
                    RageUI.ButtonWithStyle("Louer une chambre", "Appuyez pour louer une chambre", {}, not serverInteraction, function(_,_,s)
                    end, RMenu:Get(cat, sub("rent")))
                end
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get(cat, sub("rent")), true, true, true, function()
                tick()
                RageUI.Separator("Bienvenue au ~p~"..cfg_hotel.name)
                RageUI.Separator("Prix d'une nuit: ~g~"..customGroupDigits(cfg_hotel.PrixParJour).."$~s~")
                RageUI.Separator("↓ ~r~Paiement ~s~↓")
                RageUI.ButtonWithStyle("Nombre de nuits à louer", nil, {RightLabel = "~o~"..selectedNights.." Nuit".. (selectedNights > 1 and "s" or "") .." ~s~→"}, true, function(_,_,s)
                    if s then
                        local qty = showbox("Nombre de nuits", "", 5, true)
                        if qty ~= nil then
                            qty = tonumber(qty)
                            selectedNights = qty
                        end
                    end
                end)
                RageUI.ButtonWithStyle("Procéder au paiement ~g~"..customGroupDigits(selectedNights * cfg_hotel.PrixParJour).."$", nil, {RightLabel = "→"}, not serverInteraction, function(_,_,s)
                    if s then
                        serverInteraction = true
                        shouldStayOpened = false
                        TriggerServerEvent("hotel:rent", token, selectedNights)
                    end
                end)
            end, function()
            end)

            if not shouldStayOpened and isMenuActive then
                FreezeEntityPosition(PlayerPedId(), false)
                isMenuActive = false
            end
            Wait(0)
        end
    end)
end)

RegisterNetEvent("hotel:serverCb")
AddEventHandler("hotel:serverCb", function(message)
    serverInteraction = false
    if message ~= nil then Extasy.ShowNotification(message) end
end)

RegisterNetEvent("hotel:exitRoom")
AddEventHandler("hotel:exitRoom", function()
    if cfg_hotel.animationGod then SetEntityInvincible(PlayerPedId(), true) end
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(2000)
    while not IsScreenFadedOut() do Wait(1) end
    Wait(1200)
    SetEntityCoords(PlayerPedId(), cfg_hotel.position, false, false, false, false)
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeIn(750)
    if cfg_hotel.animationGod then SetEntityInvincible(PlayerPedId(), false) end
    Wait(750)
    canInteractWithZone = true
end)

exitRoom = function()
    canInteractWithZone = false
    TriggerServerEvent("hotel:exitRoom", token)
    DisplayRadar(true)
    return
end

openChesh = function()
    canInteractWithZone = false
    TriggerServerEvent("hotel:openSafe", token)
end

RegisterNetEvent("hotel:enterRoom")
AddEventHandler("hotel:enterRoom", function()
    canInteractWithZone = false
    if cfg_hotel.animationGod then SetEntityInvincible(PlayerPedId(), true) end
    FreezeEntityPosition(PlayerPedId(), true)
    DoScreenFadeOut(2000)
    while not IsScreenFadedOut() do Wait(1) end
    Wait(1200)
    SetEntityCoords(PlayerPedId(), cfg_hotel.indoorPosition, false, false, false, false)
    SetEntityHeading(PlayerPedId(), cfg_hotel.heading)
    if cfg_hotel.animationGod then SetEntityInvincible(PlayerPedId(), false) end
    canInteractWithZone = true
    FreezeEntityPosition(PlayerPedId(), false)
    DoScreenFadeIn(750)
    --local position, safe = cfg_hotel.indoorPosition, cfg_hotel.safePosition
end)

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = cfg_hotel.indoorPosition,
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~r~sortir de votre chambre",
    action          = function()
        exitRoom()
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 15,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 255,
    drawmarkerColorG = 0,
    drawmarkerColorB = 0,
})

registerNewMarker({
    npcType         = 'drawmarker',
    pos             = cfg_hotel.safePosition,
    interactMessage = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~ouvrir le coffre de votre chambre",
    action          = function()
        openChesh()
    end,
    spawned         = false,
    entity          = nil,
    load_dst        = 15,

    blip_enable     = false,

    marker          = true,
    size            = 0.45,

    drawmarkerType  = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})