InitGrossiste = function()
    local grossiste_open = false
    local index    = 1
    local objects = {}
    local bag = nil
    local getterJob = false
    local getterJob_count = nil
    local grossiste_number = nil
    local wait_for_cooldown = false
    local grossiste_cooldown = false

    RMenu.Add('grossiste', 'main_menu', RageUI.CreateMenu("Grossiste", "Que souhaitez-vous acheter ?", 1, 100))
    RMenu.Add('grossiste', 'main_menu_buy', RageUI.CreateMenu("Grossiste", "Que souhaitez-vous acheter ?", 1, 100))
    RMenu:Get('grossiste', 'main_menu').Closed = function()
        grossiste_open = false
    end

    local NumberCharset = {}
    local Charset = {}
    for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
    for i = 65,  90 do table.insert(Charset, string.char(i)) end
    for i = 97, 122 do table.insert(Charset, string.char(i)) end

    local s_index = 1

    openGrossiste_m = function(number)
        if grossiste_open then
            grossiste_open = false
            return
        else
            grossiste_open = true
            Citizen.CreateThread(function()
                while grossiste_open do
                    grossiste_number = number
                    Wait(1)
                    RageUI.IsVisible(RMenu:Get('grossiste', 'main_menu'), true, true, true, function()

                        RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                            index = Index
                        end)
                        
                        for k,v in pairs(cfg_grossiste.items) do    
                            RageUI.Button(v.label, nil, {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    cfg_grossiste.label     = v.label
                                    cfg_grossiste.price     = v.price
                                    cfg_grossiste.item_name = v.item
                                end
                            end, RMenu:Get('grossiste', 'main_menu_buy'))
                        end

                    end, function()
                    end)

                    RageUI.IsVisible(RMenu:Get('grossiste', 'main_menu_buy'), true, true, true, function() 

                        RageUI.Button("~g~Acheter "..s_index.." '"..cfg_grossiste.label.."' pour "..s_index * cfg_grossiste.price.."$", nil, {}, true, function(Hovered, Active, Selected) 
                            if (Selected) then
                                if index == 1 then
                                    TriggerServerEvent("Grossiste:BuyItemsByBankMoney", token, s_index * cfg_grossiste.price, cfg_grossiste.item_name, s_index, cfg_grossiste.label)
                                    RageUI.CloseAll()
                                    grossiste_open = false
                                elseif index == 2 then
                                    TriggerServerEvent("Grossiste:BuyItemsByMoney", token, s_index * cfg_grossiste.price, cfg_grossiste.item_name, s_index, cfg_grossiste.label)
                                    RageUI.CloseAll()
                                    grossiste_open = false
                                elseif index == 3 then
                                    TriggerServerEvent("Grossiste:BuyItemsByDirtyMoney", token, s_index * cfg_grossiste.price, cfg_grossiste.item_name, s_index, cfg_grossiste.label)
                                    RageUI.CloseAll()
                                    grossiste_open = false
                                end
                            end			
                        end)

                    end, function()
                    end)

                end
            end)
        end
    end

    GrossisteBlip = AddBlipForCoord(2561.836, 4685.298, 11.50513)
    SetBlipSprite(GrossisteBlip, 52)
    SetBlipDisplay(GrossisteBlip, 4)
    SetBlipColour(GrossisteBlip, 8)
    SetBlipScale(GrossisteBlip, 0.65)
    SetBlipAsShortRange(GrossisteBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Grossiste Entreprises")
    EndTextCommandSetBlipName(GrossisteBlip)
end

openGrossiste = function(number, _side)
    RageUI.Visible(RMenu:Get('grossiste', 'main_menu'), true)
    openGrossiste_m(number)
    grossiste_number = number
end