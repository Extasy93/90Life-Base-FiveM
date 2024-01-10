local cat = "Craigslist"
local function sub(str)
    return ("%s_%s"):format(cat,str)
end

isMenuOpened = false
isWaitingForServerUpdate = false


RegisterNetEvent("Craigslist:serverReturnStatus")
AddEventHandler("Craigslist:serverReturnStatus", function(returnedState)
    if returnedState then
        Extasy.ShowNotification("~g~Votre offre a bien été publiée")
    else
        Extasy.ShowNotification("~r~Une erreur est survenue durant la publication de votre offre")
    end
    isWaitingForServerUpdate = false
end)

RegisterNetEvent("Craigslist:serverReturnStatusBuy")
AddEventHandler("Craigslist:serverReturnStatusBuy", function(returnedState)
    if returnedState then
        Extasy.ShowNotification("~g~Le véhicule est désormais le vôtre")
    else
        Extasy.ShowNotification("~r~Une erreur est survenue durant l'achat du véhicule")
    end
    isWaitingForServerUpdate = false
end)

RegisterNetEvent("Craigslist:cb")
AddEventHandler("Craigslist:cb", function(ownedVehicles, availableVehicles)
    if isMenuOpened then return end
    if isWaitingForServerUpdate then return end
    local offerBuilder = {}
    isMenuOpened = true

    -- Vehicles (Sell)
    local selectedVehicle = nil
    -- Categories (Buy)
    local selectedCat = nil
    local availableCategories = {}

    for k,v in pairs(availableVehicles) do
        local vehicleInfos = json.decode(v.model)
        local hash = vehicleInfos.model
        if not availableCategories[hash] then
            availableCategories[hash] = {label = GetDisplayNameFromVehicleModel(hash), offers = {}, count = 0}
        end
        availableCategories[hash].offers[k] = v
    end

    for catId,v in pairs(availableCategories) do
        for _,_ in pairs(v.offers) do
            availableCategories[catId].count = availableCategories[catId].count + 1
        end
    end

    FreezeEntityPosition(PlayerPedId(), true)

    RMenu.Add(cat, sub("main"), RageUI.CreateMenu("Craigslist Car","~p~Véhicules d'occasions"))
    RMenu:Get(cat, sub("main")).Closed = function()end


    RMenu.Add(cat, sub("categoryOffers"), RageUI.CreateSubMenu(RMenu:Get(cat, sub("main")), "Craigslist Car", "~p~Parcourir les offres"))
    RMenu:Get(cat, sub("categoryOffers")).Closed = function()end

    RMenu.Add(cat, sub("sell"), RageUI.CreateSubMenu(RMenu:Get(cat, sub("main")), "Craigslist Car", "~p~Mettre en vente"))
    RMenu:Get(cat, sub("sell")).Closed = function()end

    RMenu.Add(cat, sub("sellVehicle"), RageUI.CreateSubMenu(RMenu:Get(cat, sub("sell")), "Craigslist Car", "~p~Mettre en vente"))
    RMenu:Get(cat, sub("sellVehicle")).Closed = function()end
    
    RageUI.Visible(RMenu:Get(cat, sub("main")), true)

    local cVar = "~p~"
    Citizen.CreateThread(function()
        while isMenuOpened do
            if cVar == "~p~" then cVar = "~o~" else cVar = "~p~" end
            Wait(650)
        end
    end)

    local selectedColor = 1
    --local cVarLongC = { "~p~", "~r~", "~o~", "~p~", "~c~", "~g~", "~b~" }
    local cVarLongC = { "~p~", "~w~"}
    local function rgb()
        return cVarLongC[selectedColor]
    end
    Citizen.CreateThread(function()
        while isMenuOpened do
            Wait(250)
            selectedColor = selectedColor + 1
            if selectedColor > #cVarLongC then
                selectedColor = 1
            end
        end
    end)

    function input(TextEntry, ExampleText, MaxStringLenght, isValueInt)
        AddTextEntry('FMMC_KEY_TIP1', TextEntry)
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
        blockinput = true
    
        while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
            Wait(0)
        end
    
        if UpdateOnscreenKeyboard() ~= 2 then
            local result = GetOnscreenKeyboardResult()
            Wait(500)
            blockinput = false
            if isValueInt then
                local isNumber = tonumber(result)
                if isNumber then
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

    Citizen.CreateThread(function()
        while isMenuOpened do
            local shouldStayOpened = false
            local function tick() shouldStayOpened = true end
            
            RageUI.IsVisible(RMenu:Get(cat, sub("main")),true,true,true,function()
                tick()
                RageUI.Separator("↓ ~p~Actions disponibles ~s~↓")
                --RageUI.Separator("↓ ~p~INDISPONIBLES POUR LE MOMENT ~s~↓")
                if #ownedVehicles > 0 then
                    RageUI.ButtonWithStyle(("%s→ ~s~Mettre un véhicule en vente ~s~(~p~%i~s~)"):format(rgb(), #ownedVehicles), "~p~Description~s~: Vous permet de mettre un de vos véhicules en vente sur Craigslist Vehicles", {}, true, function(_,_,s)
                    end, RMenu:Get(cat, sub("sell")))
                else
                    RageUI.ButtonWithStyle("~r~Vous n'avez aucun véhicule à mettre en vente", nil, {}, true)
                end
                RageUI.Separator("↓ ~p~Véhicules sur le marché ~s~↓")
                for hash,category in pairs(availableCategories) do
                    RageUI.ButtonWithStyle(("%s→ ~b~%s ~s~[~p~%i~s~]"):format(rgb(), category.label, category.count), ("~p~Description~s~: Appuyez pour parcourir les offres concernant le modèle \"~p~%s\""):format(category.label), {}, true, function(_,_,s)
                        if s then
                            selectedCat = hash
                        end
                    end, RMenu:Get(cat, sub("categoryOffers")))
                end
            end, function()  
            end, 1)

            RageUI.IsVisible(RMenu:Get(cat, sub("sell")),true,true,true,function()
                tick()
                RageUI.Separator("↓ ~g~Vos véhicules ~s~↓")
                for k,v in pairs(ownedVehicles) do
                    RageUI.ButtonWithStyle(("%s→ ~r~%s ~s~(~b~%s~s~)"):format(rgb(), GetDisplayNameFromVehicleModel(json.decode(v.vehicle).model), json.decode(v.vehicle).plate), "~p~Description~s~: Cliquez pour entamer la mise en vente de ce véhicule", {RightLabel = "~g~Mettre en vente ~s~→→"}, true, function(_,_,s)
                        if s then
                            selectedVehicle = k
                        end
                    end, RMenu:Get(cat, sub("sellVehicle")))
                end
            end, function()  
            end, 1)

            RageUI.IsVisible(RMenu:Get(cat, sub("sellVehicle")),true,true,true,function()
                tick()
                local vehicleInfos = json.decode(ownedVehicles[selectedVehicle].vehicle)
                local model, plate = vehicleInfos.model, vehicleInfos.plate
                RageUI.Separator(("Mise en vente de ~r~%s ~s~(~b~%s~s~)"):format(GetDisplayNameFromVehicleModel(model), plate))
                RageUI.Separator("↓ ~g~Mise en vente ~s~↓")
                RageUI.ButtonWithStyle(("%s→ ~s~Définir un prix"):format(rgb()), "~p~Description~s~: Cliquez pour définir le prix de votre offre", {RightLabel = "~b~Définir ~s~→→"}, true, function(_,_,s)
                    if s then
                        local result = input("Prix", "", 30, true)
                        if result then
                            offerBuilder.price = tonumber(result)
                            Extasy.ShowNotification("~g~Prix de l'offre correctement défini !")
                        end
                    end
                end)
                RageUI.ButtonWithStyle(("%s→ ~s~Définir une description"):format(rgb()), "~p~Description~s~: Cliquez pour définir la description de votre offre", {RightLabel = "~b~Définir ~s~→→"}, true, function(_,_,s)
                    if s then
                        local result = input("Description", "", 100, false)
                        if result then
                            offerBuilder.description = result
                            Extasy.ShowNotification("~g~Description de l'offre correctement définie !")
                        end
                    end
                end)
                RageUI.Separator("↓ ~p~Confirmation ~s~↓")
                RageUI.ButtonWithStyle(("%s→ ~g~Confirmer la mise en vente"):format(rgb()), "~p~Description~s~: Vous permet de sauvegarder et publier cette offre~n~~r~Attention~s~: Cette action vous fera perdre définitivement la propriété de votre véhicule", {}, offerBuilder.price ~= nil and offerBuilder.price > 0 and offerBuilder.description ~= nil and offerBuilder.description ~= "", function(_,_,s)
                    if s then 
                        isWaitingForServerUpdate = true
                        shouldStayOpened = false
                        TriggerServerEvent("Craigslist:publishOffer", token, plate, offerBuilder)
                    end
                end)

            end, function()  
            end, 1)

            RageUI.IsVisible(RMenu:Get(cat, sub("categoryOffers")),true,true,true,function()
                tick()
                RageUI.Separator(("Catégorie actuelle: ~p~%s"):format(availableCategories[selectedCat].label))
                RageUI.Separator("↓ ~g~Offres disponibles ~s~↓")
                local offers = availableCategories[selectedCat].offers
                for id, offerInfos in pairs(offers) do
                    RageUI.ButtonWithStyle(("%s→ ~r~%s ~s~(~g~%s$~s~)"):format(rgb(), availableCategories[selectedCat].label, ESX.Math.GroupDigits(offerInfos.price)), ("~g~Prix~s~: %s~g~$~n~~p~Postée à~s~: %s~n~~o~Vendeur~s~: %s~n~~r~Description~s~: %s"):format(ESX.Math.GroupDigits(offerInfos.price), offerInfos.createdAt, offerInfos.name, offerInfos.description), {RightLabel = "~g~Acheter ~s~→→"}, true, function(_,_,s)
                        if s then
                            isWaitingForServerUpdate = true
                            shouldStayOpened = false
                            TriggerServerEvent("Craigslist:buyOffer", token, offerInfos.plate, offerInfos.license)
                        end
                    end)
                end
            end, function()  
            end, 1)

            if isMenuOpened and not shouldStayOpened then
                isMenuOpened = false
            end
            Wait(0)
        end
        FreezeEntityPosition(PlayerPedId(), false)
        RMenu:Delete(cat, sub("main"))
        RMenu:Delete(cat, sub("sellVehicle"))
        RMenu:Delete(cat, sub("categoryOffers"))
        RMenu:Delete(cat, sub("sell"))
        canInteract = true
    end)
end)