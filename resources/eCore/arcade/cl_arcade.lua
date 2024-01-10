
gotTicket = false
minutes = 0
seconds = 0
local bar_open = false
local arcade_open = false
local arcade_computer_open = false
local index = 1
local index2 = 1
local s_index = 1
local back_ok = false

RMenu.Add('arcade', 'main_menu', RageUI.CreateMenu("Arcade Ticket", "Que souhaitez-vous acheter ?", 1, 100))
RMenu.Add('arcade', 'main_menu_buy', RageUI.CreateMenu("Arcade Ticket", "Que souhaitez-vous acheter ?", 1, 100))
RMenu:Get('arcade', 'main_menu').Closed = function()
    arcade_open = false
end

openArcade_m = function()
    if arcade_open then
        arcade_open = false
        return
    else
        arcade_open = true
        Citizen.CreateThread(function()
            while arcade_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('arcade', 'main_menu'), true, true, true, function()

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index = Index
                    end)

                    RageUI.Separator("")

                    if gotTicket == true then
                        if not back_ok then
                            RageUI.Button("~r~Rendre son ticket", "Après avoir rendu votre ticket, vous ne pourrez plus jouer aux bornes d'arcades", {RightLabel = "🎫"}, true, function(Hovered, Active, Selected) if Selected then back_ok = true end end)
                        else
                            RageUI.Button("~r~Rendre son ticket", "Après avoir rendu votre ticket, vous ne pourrez plus jouer aux bornes d'arcades", {RightLabel = "~r~Confirmez"}, true, function(h, a, s)
                                if s then
                                    minutes = 0
                                    seconds = 0
                                    gotTicket = false
                                    RageUI.CloseAll()
                                    arcade_open = false
                                    back_ok = false
                                end
                            end)
                        end
                    else
                        RageUI.Button("x1 Ticket", "Achetez un ticket pour 30 minutes de jeu aux bornes d'arcades", {RightLabel = "~p~[25$]"}, true, function(h, a, s)
                            if s then
                                TriggerServerEvent("arcade:buyTicket", token, 25, index)
                                RageUI.CloseAll()
                                arcade_open = false
                            end
                        end)
                    end

                end, function()
                end)
            end
        end)
    end
end

openArcade = function()
    RageUI.Visible(RMenu:Get('arcade', 'main_menu'), true)
    openArcade_m()
end

RMenu.Add('arcade_computer', 'main_menu', RageUI.CreateMenu("Arcade Computer", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('arcade_computer', 'main_menu_buy', RageUI.CreateMenu("Arcade Computer", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('arcade_computer', 'main_menu').Closed = function()
    arcade_open = false
end

openArcadeComputer_m = function()
    if arcade_computer_open then
        arcade_computer_open = false
        return
    else
        arcade_computer_open = true
        Citizen.CreateThread(function()
            while arcade_computer_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('arcade_computer', 'main_menu'), true, true, true, function()

                    RageUI.Button("Pacman", nil, {RightLabel = ""}, true, function(h, a, s)
                        if s then
                            exports.arcade_games:Pacman()
                            RageUI.CloseAll()
                            arcade_computer_open = false
                        end
                    end)

                    RageUI.Button("Tetris", nil, {RightLabel = ""}, true, function(h, a, s)
                        if s then
                            exports.arcade_games:Tetris()
                            RageUI.CloseAll()
                            arcade_computer_open = false
                        end
                    end)

                    RageUI.Button("Ping Pong", nil, {RightLabel = ""}, true, function(h, a, s)
                        if s then
                            exports.arcade_games:PingPong()
                            RageUI.CloseAll()
                            arcade_computer_open = false
                        end
                    end)

                    RageUI.Button("DOOM", nil, {RightLabel = ""}, true, function(h, a, s)
                        if s then
                            exports.arcade_games:DOOM()
                            RageUI.CloseAll()
                            arcade_computer_open = false
                        end
                    end)

                    RageUI.Button("Duke Nukem 3D", nil, {RightLabel = ""}, true, function(h, a, s)
                        if s then
                            exports.arcade_games:DukeNukem3D()
                            RageUI.CloseAll()
                            arcade_computer_open = false
                        end
                    end)

                    RageUI.Button("Wolfenstein 3D", nil, {RightLabel = ""}, true, function(h, a, s)
                        if s then
                            exports.arcade_games:Wolfenstein3D()
                            RageUI.CloseAll()
                            arcade_computer_open = false
                        end
                    end)

                end, function()
                end)
            end
        end)
    end
end

openArcadeComputer = function()
    RageUI.Visible(RMenu:Get('arcade_computer', 'main_menu'), true)
    local index = 0
    if not gotTicket then
        Extasy.ShowNotification("~r~Vous n'avez pas de ticket")
        return
    end
    openArcadeComputer_m()
end

--- Bar
RMenu.Add('bar', 'main_menu', RageUI.CreateMenu("Bar", "Que souhaitez-vous faire ?", 1, 100))
RMenu.Add('bar', 'main_menu_buy', RageUI.CreateMenu("Bar", "Que souhaitez-vous acheter ?", 1, 100))

RMenu.Add('bar', 'main_menu_alcooloui', RageUI.CreateSubMenu(RMenu:Get('bar', 'main_menu'), "Bar", "Que souhaitez-vous acheter ?"))
RMenu.Add('bar', 'main_menu_alcoolnon', RageUI.CreateSubMenu(RMenu:Get('bar', 'main_menu'), "Bar", "Que souhaitez-vous acheter ?"))
RMenu.Add('bar', 'main_menu_snacks', RageUI.CreateSubMenu(RMenu:Get('bar', 'main_menu'), "Bar", "Que souhaitez-vous acheter ?"))

RMenu:Get('bar', 'main_menu').Closed = function()
    bar_open = false
end

openBar_m = function(_side)
    if bar_open then
        bar_open = false
        return
    else
        bar_open = true
        Citizen.CreateThread(function()
            while bar_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('bar', 'main_menu'), true, true, true, function()

                    RageUI.Button("Nos boissons alcoolisées", nil, {RightLabel = "~p~→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                        end
                    end, RMenu:Get('bar', 'main_menu_alcooloui'))

                    RageUI.Button("Nos boissons non-alcoolisées", nil, {RightLabel = "~p~→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                        end
                    end, RMenu:Get('bar', 'main_menu_alcoolnon'))

                    RageUI.Button("Nos snacks", nil, {RightLabel = "~p~→→"}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                        end
                    end, RMenu:Get('bar', 'main_menu_snacks'))

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('bar', 'main_menu_alcooloui'), true, true, true, function() 

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index2, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index2 = Index
                    end)

                    RageUI.Separator("~p~← Nos boissons alcoolisées →")
                     
                    for k,v in pairs(cfg_arcade.alcooloui) do    
                        RageUI.Button(v.label, nil, {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                cfg_arcade.label     = v.label
                                cfg_arcade.price     = v.price
                                cfg_arcade.item_name = v.item
                            end
                        end, RMenu:Get('bar', 'main_menu_buy'))
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('bar', 'main_menu_alcoolnon'), true, true, true, function() 

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index2, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index2 = Index
                    end)

                    RageUI.Separator("~p~← Nos boissons non-alcoolisées →")
                     
                    for k,v in pairs(cfg_arcade.alcoolnon) do    
                        RageUI.Button(v.label, nil, {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                cfg_arcade.label     = v.label
                                cfg_arcade.price     = v.price
                                cfg_arcade.item_name = v.item
                            end
                        end, RMenu:Get('bar', 'main_menu_buy'))
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('bar', 'main_menu_snacks'), true, true, true, function() 

                    RageUI.List("Mode de paiement", extasy_core_cfg["available_payments"], index2, nil, {}, true, function(Hovered, Active, Selected, Index)
                        index2 = Index
                    end)

                    RageUI.Separator("~p~← Nos boissons non-alcoolisées →")
                     
                    for k,v in pairs(cfg_arcade.snacks) do    
                        RageUI.Button(v.label, nil, {RightLabel = v.price.."$"}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                cfg_arcade.label     = v.label
                                cfg_arcade.price     = v.price
                                cfg_arcade.item_name = v.item
                            end
                        end, RMenu:Get('bar', 'main_menu_buy'))
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('bar', 'main_menu_buy'), true, true, true, function() 

                    if cfg_arcade.label ~= "Téléphone" then
                        RageUI.List("Combien voulez-vous de "..cfg_arcade.label.." ?", cfg_arcade.max, s_index, nil, {}, true, function(Hovered, Active, Selected, Index) s_index = Index end)
                    end 

                    RageUI.Button("~g~Acheter "..s_index.." "..cfg_arcade.label.." pour "..s_index * cfg_arcade.price.."$", nil, {RightLabel = "~g~→→"}, true, function(Hovered, Active, Selected) 
                        if (Selected) then
                            if index2 == 1 then
                                TriggerServerEvent("Arcade:BuyItemsByBankMoney", token, s_index * cfg_arcade.price, cfg_arcade.item_name, s_index, cfg_arcade.label)
                                RageUI.CloseAll()
                                bar_open = false
                            elseif index2 == 2 then
                                TriggerServerEvent("Arcade:BuyItemsByMoney", token, s_index * cfg_arcade.price, cfg_arcade.item_name, s_index, cfg_arcade.label)
                                RageUI.CloseAll()
                                bar_open = false
                            elseif index2 == 3 then
                                TriggerServerEvent("Arcade:BuyItemsByDirtyMoney", token, s_index * cfg_arcade.price, cfg_arcade.item_name, s_index, cfg_arcade.label)
                                RageUI.CloseAll()
                                bar_open = false
                            end
                        end			
                    end)

                end, function()
                end)

            end
        end)
    end
end

openBar = function(number, _side)
    RageUI.Visible(RMenu:Get('bar', 'main_menu'), true)
    openBar_m(_side)
    bar_number = number
end

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if gotTicket then
            if hasPlayerRunOutOfTime() then
                Extasy.ShowNotification("~r~Votre ticket vient d'expirer")
                gotTicket = false
                exports.arcade_games:CloseNUI()
            end

            countTime()
            displayTime()
        end
    end
end)

hasPlayerRunOutOfTime = function()
    return (minutes == 0 and seconds <= 1)
end

countTime = function()
    seconds = seconds - 1
    if seconds == 0 then
        seconds = 59
        minutes = minutes - 1
    end

    if minutes == -1 then
        minutes = 0
        seconds = 0
    end
end

displayTime = function()
    Extasy.PopupTime("Temps restant "..minutes..":"..seconds, 1001)
end

RegisterNetEvent("arcade:ticketResult")
AddEventHandler("arcade:ticketResult", function()
    seconds = 1
    minutes = 30
    gotTicket = true

    Extasy.ShowNotification("Vous avez acheté un ticket, passez un bon moment dans la salle d'arcade. Vous avez: 30 minutes")
end)

--Markers
registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3823.848, 5988.915, 11.70719),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3822.405, 5987.437, 11.70721),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3820.84, 5988.874, 11.7072),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3822.331, 5990.397, 11.70718),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3817.719, 5987.633, 11.70721),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3816.271, 5986.065, 11.70721),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3817.798, 5984.661, 11.70723),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3819.213, 5986.152, 11.70721),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3811.886, 5991.642, 11.70717),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3809.568, 5991.652, 11.70),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3821.893, 5981.877, 11.70),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3821.932, 5979.814, 11.70),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3817.421, 5980.332, 11.70),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3815.154, 5980.254, 11.70),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3812.826, 5983.905, 11.70723),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3810.537, 5983.843, 11.70724),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3810.537, 5983.843, 11.70724),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3821.729, 5972.252, 11.70731),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3821.738, 5970.207, 11.70732),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3815.203, 5975.208, 11.70729),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3817.241, 5977.856, 11.70728),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3815.04, 5977.724, 11.70727),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3815.063, 5971.934, 11.70732),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})

registerNewMarker({
    npcType          = 'drawmarker',
    interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la borne d'arcade",
    pos              = vector3(3817.369, 5971.994, 11.70732),
    action           = function()
        openArcadeComputer()
    end,

    spawned          = false,
    entity           = nil,
    load_dst         = 30,


    blip_enable      = false,

    marker           = true,
    size             = 0.6,

    drawmarkerType   = 25,
    
    drawmarkerColorR = 100,
    drawmarkerColorG = 0,
    drawmarkerColorB = 200,
})