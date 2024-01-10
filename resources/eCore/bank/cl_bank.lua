Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

bank_open = false

RMenu.Add("bank", "main_menu", RageUI.CreateMenu("Banque", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get("bank", "main_menu").Closed = function()
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    killCam()
    bank_open = false
    inventory_open = false
end

RMenu.Add("bank", "main_menu_buy", RageUI.CreateMenu("Banque", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get("bank", "main_menu_buy").Closed = function()
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)
    killCam()
    bank_open = false
    inventory_open = false
end

RMenu.Add("bank", "main_menu_deposit", RageUI.CreateSubMenu(RMenu:Get("bank", "main_menu"), "Banque", "Que souhaitez-vous faire ?"))
RMenu.Add("bank", "main_menu_withraw", RageUI.CreateSubMenu(RMenu:Get("bank", "main_menu"), "Banque", "Que souhaitez-vous faire ?"))
RMenu.Add("bank", "main_menu_send", RageUI.CreateSubMenu(RMenu:Get("bank", "main_menu"), "Banque", "Que souhaitez-vous faire ?"))
RMenu.Add("bank", "main_menu_send_choose", RageUI.CreateSubMenu(RMenu:Get("bank", "main_menu"), "Banque", "Que souhaitez-vous faire ?"))
RMenu.Add("bank", "main_menu_transaction", RageUI.CreateSubMenu(RMenu:Get("bank", "main_menu"), "Banque", "Que souhaitez-vous faire ?"))

local acc = {}
local bank_data = {
    {
        label = "5,000$",
        value = 5000,
    },
    {
        label = "15,000$",
        value = 15000,
    },
    {
        label = "50,000$",
        value = 50000,
    },
    {
        label = "100,000$",
        value = 100000,
    },
    {
        label = "500,000$",
        value = 500000,
    },
    {
        label = "1,000,000$",
        value = 1000000,
    }
}

local bank_deposit_reason = "Dépôt"
local used = false

openATM = function()
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    PlaySoundFrontend(-1, "PIN_BUTTON", "ATM_SOUNDS", 1)

    RageUI.Visible(RMenu:Get("bank", "main_menu"), true)
    atm_menu()
end

local total_dp = 0
local total_et = 0
acc.id   = nil

atm_menu = function()
    if bank_open then
        bank_open = false
        return
    else
        bank_open = true
        Citizen.CreateThread(function()
            while bank_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get("bank", "main_menu"), true, true, true, function()

                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == "bank"  then
                            RageUI.Separator("Solde actuel ~b~"..ESX.PlayerData.accounts[i].money.."$")
                        end
                    end
        
                    RageUI.Separator("")
        
                    RageUI.Button("Faire un dépôt", nil, {}, true, function(h, a, s) end, RMenu:Get("bank", "main_menu_deposit"))
                    RageUI.Button("Faire un retrait", nil, {}, true, function(h, a, s) end, RMenu:Get("bank", "main_menu_withraw"))
                    RageUI.Button("Faire un virement", nil, {}, true, function(h, a, s) end, RMenu:Get("bank", "main_menu_send_choose"))
        
                    RageUI.Separator("")
                
                    RageUI.Button("Mes transactions", nil, {}, true, function(h, a, s) end, RMenu:Get("bank", "main_menu_transaction"))
        
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get("bank", "main_menu_deposit"), true, true, true, function()

                    RageUI.Button("Montant personnalisé", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                        if s then
                            a = Extasy.KeyboardInput("Quel montant ?", "", 20)
                            a = tonumber(a)
                            if a ~= nil and type(a) == 'number' then
                                if string.sub(a, 1, string.len("-")) == "-" then
                                    Extasy.ShowNotification("~r~Quantité invalide")
                                else
                                    TriggerServerEvent("bank:depositMoney", token, a)
                                    Addbank_transac("Dépôt", Extasy.Math.GroupDigits(a), "in")
                                end
                            else
                                Extasy.ShowNotification("~r~Valeur invalide")
                            end
                        end
                    end)

                    RageUI.Separator("")

                    for k,v in pairs(bank_data) do
                        RageUI.Button(v.label, nil, {}, true, function(h, a, s) 
                            if s then
                                local i = tonumber(v.value)

                                TriggerServerEvent("bank:depositMoney", token, i)
                                Addbank_transac("Dépôt", Extasy.Math.GroupDigits(i), "in") 
                            end 
                        end)
                    end
                
                end, function()
                end)
        
                RageUI.IsVisible(RMenu:Get("bank", "main_menu_withraw"), true, true, true, function()
        
                    RageUI.Button("Montant personnalisé", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                        if s then
                            a = Extasy.KeyboardInput("Quel montant ?", "", 20)
                            a = tonumber(a)
                            if a ~= nil and type(a) == 'number' then
                                if string.sub(a, 1, string.len("-")) == "-" then
                                    Extasy.ShowNotification("~r~Quantité invalide")
                                else
                                    TriggerServerEvent("bank:withdrawMoney", token, a)
                                    Addbank_transac("Retrait", Extasy.Math.GroupDigits(a), "out")
                                end
                            else
                                Extasy.ShowNotification("~r~Valeur invalide")
                            end
                        end
                    end)
        
                    RageUI.Separator("")
        
                    for k,v in pairs(bank_data) do
                        RageUI.Button(v.label, nil, {}, true, function(h, a, s) 
                            if s then
                                local i = tonumber(v.value)
                                TriggerServerEvent("bank:withdrawMoney", token, i)
                                Addbank_transac("Retrait", Extasy.Math.GroupDigits(i), "out")
                            end 
                        end)
                    end
                
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get("bank", "main_menu_send_choose"), true, true, true, function()
        
                    for _, player in ipairs(GetActivePlayers()) do
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                        local coords = GetEntityCoords(GetPlayerPed(player))
                        local name = Extasy.ReplaceText(player)
                        local sta = Extasy.IsMyId(player)
        
                        if dst < 3.0 then
                            if sta ~= "me" then
                                RageUI.Button("#".._.." "..name, nil, {RightLabel = c}, true, function(Hovered, Active, Selected)
                                    if (Active) then
                                        DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                    end
                                    if Selected then
                                        acc.id = GetPlayerServerId(player)
                                    end
                                end, RMenu:Get("bank", "main_menu_send"))  
                            end
                        end
                    end
        
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get("bank", "main_menu_send"), true, true, true, function()
        
                    if acc.id ~= nil then
                        RageUI.Separator("ID choisi: "..acc.id)
                        RageUI.Button("Montant personnalisé", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                            if s then
                                a = Extasy.KeyboardInput("Quel montant ?", "", 20)
                                a = tonumber(a)
                                if a ~= nil and type(a) == "number" then
                                    if string.sub(a, 1, string.len("-")) == "-" then
                                        Extasy.ShowNotification("~r~Quantité invalide")
                                    else
                                        TriggerServerEvent("bank:transferMoney", token, acc.id, i)
                                        Addbank_transac("Virement à '"..Extasy.ReplaceText(GetPlayerFromServerId(acc.id)).."'", Extasy.Math.GroupDigits(i), "out")
                                        RageUI.CloseAll()
                                        bank_open = false
                                    end
                                else
                                    Extasy.ShowNotification("~r~Valeur invalide")
                                end
                            end
                        end)
        
                        RageUI.Separator("")
        
                        for k,v in pairs(bank_data) do
                            RageUI.Button(v.label, nil, {}, true, function(h, a, s) 
                                if s then
                                    local i = tonumber(v.value)
                                    TriggerServerEvent("bank:transferMoney", token, acc.id, i)
                                    Addbank_transac("Virement à '"..Extasy.ReplaceText(GetPlayerFromServerId(acc.id)).."'", Extasy.Math.GroupDigits(i), "out")
                                    RageUI.CloseAll()
                                    bank_open = false
                                end 
                            end)
                        end
                    end
        
                end, function()
                end)
        
                RageUI.IsVisible(RMenu:Get("bank", "main_menu_transaction"), true, true, true, function()
        
                    RageUI.Button("Vider mes transactions", nil, {RightLabel = "🗑"}, true, function(h, a, s) if s then ClearTransaction() TriggerServerEvent("rF:GetPlayersAccounts", token) end end)
        
                    RageUI.Separator("")
        
                    for k,v in pairs(bank_transac) do
                        RageUI.Button(v.name, nil, {RightLabel = v.amount.." $"}, true, function(h, a, s) end)
                    end
                
                end, function()
                end)
        
                RageUI.IsVisible(RMenu:Get("bank", "main_menu_buy"), true, true, true, function()
        
                    RageUI.Button("Recevoir ma carte bancaire", nil, {}, true, function(h, a, s) 
                        if s then
                            if not used then
                                giveBankCard()
                                used = true
                            else
                                Extasy.ShowNotification("~r~Vous avez déjà reçu votre carte bancaire")
                            end
                        end
                    end)
                
                end, function()
                end)
            end
        end)
    end
end

local gived_bank = false
giveBankCard = function()
    if not gived_bank then
        gived_bank = not gived_bank
        TriggerServerEvent("Extasy:recupCb", token)
    else
        Extasy.ShowNotification("~r~Vous avez déjà récupéré votre carte bancaire")
    end
end

openBank = function()
    RageUI.Visible(RMenu:Get("bank", "main_menu_buy"), true)
    atm_menu()
end