serflex_data = {}

RMenu.Add('serflex', 'main_menu', RageUI.CreateMenu("Serflex", "Qui souhaitez-vous fouiller ?", 1, 100))
RMenu.Add('serflex', 'main_menu_inventory', RageUI.CreateSubMenu(RMenu:Get('serflex', 'main_menu'), "Serflex", "Voici l'inventaire de la personne"))
RMenu:Get('serflex', 'main_menu').Closed = function()
    serflex_menu_openned = false
end

openSerflex_m = function()
    if serflex_menu_openned then
        serflex_menu_openned = false
        return
    else
        serflex_menu_openned = true
        Citizen.CreateThread(function()
            while serflex_menu_openned do
                Wait(1)
                
                RageUI.IsVisible(RMenu:Get('serflex', 'main_menu'), true, true, true, function()

                    for _, player in ipairs(GetActivePlayers()) do
                        local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                        local coords = GetEntityCoords(GetPlayerPed(player))
                        local name = Extasy.ReplaceText(player)
                        local sta = Extasy.IsMyId(player)
        
                        if dst < 3.0 then
                            RageUI.Button("#".._.." "..name, nil, {}, true, function(h, a, s)
                                if a then
                                    DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                end
                                if s then
                                    TriggerServerEvent('lspd:handcuff', token, GetPlayerServerId(player))

                                    TriggerServerEvent('Extasy:GetOtherPlayerInventory', token, GetPlayerServerId(player))
                                    --TriggerServerEvent('Extasy:GetOtherPlayerAccounts', token, GetPlayerServerId(player))
                                    serflex_data.lastID = GetPlayerServerId(player)
                                end
                            end, RMenu:Get('serflex', 'main_menu_inventory'))
                        end
                    end
        
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('serflex', 'main_menu_inventory'), true, true, true, function()

                    RageUI.Button("Menotter", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            TriggerServerEvent("Extasy:RemoveItem", token, "Serflex", 1)
                            TriggerServerEvent('lspd:handcuff', token, serflex_data.lastID)
                        end
                    end)

                    RageUI.Separator("")

                    --RageUI.Button("~g~Argent liquide", nil, {RightLabel = "~g~"..Extasy.Math.GroupDigits(otherMoney).."$"}, true, function(Hovered, Active, Selected) end)
                    --RageUI.Button("~c~Source inconnue", nil, {RightLabel = "~c~"..Extasy.Math.GroupDigits(otherDirty).."$"}, true, function(Hovered, Active, Selected) end)
                    RageUI.Separator("")
                    
                    while otherInventory == nil do Wait(1) end
                    for k,v in pairs(otherInventory) do
                        if v.label == v.olabel then
                            RageUI.Button(v.label.." ("..v.count..")", nil, {}, true, function(Hovered, Active, Selected) end)
                        else
                            RageUI.Button(v.olabel.." '"..v.label.."' ("..v.count..")", nil, {}, true, function(Hovered, Active, Selected) end)
                        end
                    end
        
                end, function()
                end)

            end
        end)
    end
end

openSerflexThing = function()
    RageUI.Visible(RMenu:Get('serflex', 'main_menu'), true)
    openSerflex_m()
end

RegisterNetEvent('Extasy:useSerflex')
AddEventHandler('Extasy:useSerflex', function()
    RageUI.CloseAll()
    F5_in_menu_perso = false

    Wait(150)

    openSerflexThing()
end)