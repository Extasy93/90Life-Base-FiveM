ESX = nil
local billing_data = {} 
local bank = 0
local money = 0
local index = 1
billing_open = false

CreateThread(function()
    while ESX == nil do
        TriggerEvent("ext:getSharedObject", function(obj) ESX = obj end)
        Wait(1)
    end
    ESX.PlayerData = ESX.GetPlayerData()
end)

RMenu.Add('billing', 'main_menu', RageUI.CreateMenu("Facturation", "Vous avez reçu une nouvelle facture", 1, 100))
RMenu:Get('billing', 'main_menu').Closable = false
RMenu:Get('billing', 'main_menu').Closed = function()
    appt_menu_openned = false
    billing_open = false
end

billing_menu = function()
    billing_open = true
    Citizen.CreateThread(function()
        while billing_open do
            Wait(1)
            RageUI.IsVisible(RMenu:Get('billing', 'main_menu'), true, false, true, function()
    
                RageUI.Button("Détails", nil, {RightLabel = "📝"}, true, function(Hovered, Active, Selected)  end)
                RageUI.Separator("~b~'"..billing_data.reason.."'")
                RageUI.List("Mode de paiement", extasy_core_cfg["available_payments_billing"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                    index = Index
                end)
                RageUI.Button("~g~Payer "..Extasy.Math.GroupDigits(billing_data.price).."$", nil, {}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        if index == 1 then
                            TriggerServerEvent("Billing:PayeByBankMoney", token, GetPlayerServerId(PlayerId()), billing_data.price, billing_data.sender, billing_data.deduce, billing_data.society, billing_data.execute, billing_data.action, billing_data.hash, billing_data.name, billing_data.shopCart, billing_data.shopProfit)
                        elseif index == 2 then
                            TriggerServerEvent("Billing:PayeByMoney", token, GetPlayerServerId(PlayerId()), billing_data.price, billing_data.sender, billing_data.deduce, billing_data.society, billing_data.execute, billing_data.action, billing_data.hash, billing_data.name, billing_data.shopCart, billing_data.shopProfit)
                        end
                    end
                end)

                RageUI.Button("~r~Refuser de payer", nil, {}, true, function(Hovered, Active, Selected) 
                    if Selected then
                        TriggerServerEvent("Billing:notBuy", token, billing_data.sender)
                        RageUI.Visible(RMenu:Get('billing', 'main_menu'), false)
                    end
                end)
            
            end, function()
            end)
        end
    end)
end

RegisterNetEvent('billing:open')      -- label,  price, society, source, action, execute, deduce
AddEventHandler('billing:open', function(reason, price, society, sender, action, execute, deduce, isForce, hash, name, shopCart, shopProfit)
    --if society == 'concess' or society == 'Concessionnaire bateau' or society == 'Inconnu' or society == 'Concessionnaire aérien' then
    --    extasy_core_cfg["max_billing_amount"] = extasy_core_cfg["max_billing_amount"] * 15.0
    --end

    if price < extasy_core_cfg["max_billing_amount"] then
        ClearPedTasks(GetPlayerPed(GetPlayerFromServerId(sender)))

        billing_data.reason     = reason
        billing_data.price      = price
        billing_data.society    = society
        billing_data.sender     = sender
        billing_data.action     = action
        billing_data.execute    = execute
        billing_data.isForce    = isForce
        billing_data.deduce     = nil
        billing_data.name       = name
        billing_data.shopCart   = shopCart
        billing_data.shopProfit = shopProfit

        if society == 'vccustoms' then
            billing_data.vehModsNew = hash
            billing_data.hash     = hash
        else
            billing_data.hash     = hash
        end

        if deduce ~= nil then
            billing_data.deduce  = deduce
        end

        if string.sub(society, 1, string.len("24/7")) == "24/7" then
            billing_data.deduce  = price * 2.5
        end

        if billing_data.isForce then
            TriggerServerEvent("Billing:PayeByBankMoney", token, GetPlayerServerId(PlayerId()), billing_data.price, billing_data.sender, billing_data.deduce, billing_data.society, billing_data.execute, billing_data.action, billing_data.hash, billing_data.name)
            Addbank_transac(billing_data.reason.." (Facture forcée)", Extasy.Math.GroupDigits(billing_data.price), "out")

            billing_open = false
            RageUI.CloseAll()

            local t = 0
            if billing_data.deduce ~= nil then t = billing_data.deduce else t = billing_data.price end
            TriggerServerEvent("Extasy:ShowAdvancedNotification", token, billing_data.sender, "Transaction effectuée", "Facturation", "La personne vient de payer la facture, votre société a reçu le virement de "..Extasy.Math.GroupDigits(t).."$", "BILLING")

            if deduce ~= nil then
                TriggerServerEvent("Extasy:ProcessPaySociety", token, billing_data.society, billing_data.deduce, billing_data.sender)
            else
                TriggerServerEvent("Extasy:ProcessPaySociety", token, billing_data.society, billing_data.price, billing_data.sender)
            end

            if billing_data.action then
                TriggerEvent(billing_data.execute, billing_data.sender, Details)
            end
            
            Extasy.ShowAdvancedNotification("Transaction effectuée", "Facturation", "Vous avez payé une facture de "..billing_data.price.."$ (facture automatique)", "BILLING")
            PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
        else
            RMenu:Get('billing', 'main_menu'):SetPageCounter("")
            RageUI.Visible(RMenu:Get('billing', 'main_menu'), true)
            billing_menu()
        end
    end
end)

RegisterNetEvent('billing:isGood')
AddEventHandler('billing:isGood', function(thePrice, sender, deduce, society, execute, action, buyer, hash, name, shopCart, shopProfit)
    local t = 0
    if deduce ~= nil then t = deduce else t = thePrice end
    
    billing_open = false
    RageUI.CloseAll()

    if deduce ~= nil then
        TriggerServerEvent("Extasy:ProcessPaySociety", token, society, deduce, sender)
    else
        TriggerServerEvent("Extasy:ProcessPaySociety", token, society, deduce, sender)
    end

    if action and society == 'vccustoms' then
        TriggerEvent(execute, sender, buyer, hash, name, shopCart, shopProfit)
    elseif action then
        TriggerEvent(execute, sender, buyer, hash, name)
    end
    
    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
end)

RegisterNetEvent('billing:isNotGood')
AddEventHandler('billing:isNotGood', function()
    billing_open = false
    RageUI.CloseAll()
end)