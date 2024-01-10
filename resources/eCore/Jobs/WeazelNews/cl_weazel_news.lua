weazel_news_inmenu = false
weazel_news_in_menu_lobby = false

InitWeazelNews = function()
    registerSocietyFarmZone({ 
        pos           = vector3(2314.01, 7538.76, 10.09),
        spawnPoint    = {
            {pos = vector3(2315.97, 7535.48, 10.09), heading = 178.99},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage Weazel News",
        garage        = {
            {name     = "Camion Weazel News", hash = "newsvan", props = {color1=42, color2=42}},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage Weazel News",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(2303.79, 7536.00, 22.95),
        spawnPoint    = {
            {pos = vector3(2290.82, 7534.80, 24.20), heading = 86.99},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage aérien Weazel News",
        garage        = {
            {name     = "Hélico 1", hash = "Newsheli", props = {color1=42, color2=42}},
            {name     = "Hélico 2", hash = "Newsheli2", props = {color1=42, color2=42}},
        },
        marker        = true,
        name          = "",
        name_garage   = "Garage aérien Weazel News",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(2316.17, 7544.37, 10.10),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage Weazel News",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(2290.94, 7534.04, 22.95),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Garage aérien Weazel News",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos      = vector3(2302.38, 7526.22, 15.22),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(2316.63, 7550.12, 19.71),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2313.68, 7553.07, 19.71),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2308.17, 7548.86, 19.71),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(2277.39, 7550.71, 10.18),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Weazel News",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(2302.38, 7526.22, 15.22)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Weazel News")
    EndTextCommandSetBlipName(aBlip)

    local b = {
        {pos = vector3(2316.85, 7550.15, 19.71), sprite = 557, color = 2,  scale = 0.60, title = "Weazel News | Coffre d'entreprise"},
        {pos = vector3(2277.39, 7550.71, 10.18), sprite = 557, color = 3,  scale = 0.60, title = "Weazel News | Vestaire"},
        {pos = vector3(2314.01, 7538.76, 10.09), sprite = 557, color = 17, scale = 0.60, title = "Weazel News | Garage"},
        {pos = vector3(2316.17, 7544.37, 10.10), sprite = 557, color = 59, scale = 0.60, title = "Weazel News | Rangement véhicule"},
        {pos = vector3(2304.85, 7536.17, 23.20), sprite = 557, color = 17, scale = 0.60, title = "Weazel News | Garage Hélico"},
        {pos = vector3(2290.94, 7534.04, 22.95), sprite = 557, color = 59, scale = 0.60, title = "Weazel News | Rangement Hélico"},
    }
    
    for _, info in pairs(b) do
        info.blip = AddBlipForCoord(info.pos.x, info.pos.y, info.pos.z)
        SetBlipSprite(info.blip, info.sprite)
        SetBlipDisplay(info.blip, 4)
        SetBlipColour(info.blip, info.color)
        SetBlipScale(info.blip, info.scale)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end

RMenu.Add('weazel_news', 'main_menu', RageUI.CreateMenu("Weazel News", "Que souhaitez-vous faire ?", 1, 100))
RMenu:Get('weazel_news', 'main_menu').Closed = function()
    weazel_news_inmenu = false
end

OpenWeazelnewsMenu = function()
    if weazel_news_inmenu then
        weazel_news_inmenu = false
        return
    else
        weazel_news_inmenu = true
        RageUI.Visible(RMenu:Get('weazel_news', 'main_menu'), true)
        Citizen.CreateThread(function()
            while weazel_news_inmenu do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('weazel_news', 'main_menu'), true, false, true, function()

                    RageUI.Button("Annonce aux citoyens", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            local i = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 200)
                            i = tostring(i)
                            if i ~= nil and string.len(i) > 5 then
                                TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Weazel News', 'Publicité', i, 'CHAR_WEAZELNEWS')
                            end
                        end
                    end)

                    RageUI.Button("Sortir/ranger la caméra", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RageUI.CloseAll()
                            weazel_news_inmenu = false
                            
                            TriggerEvent("Cam:ToggleCam")
                        end
                    end)

                    RageUI.Button("Sortir/ranger le micro", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RageUI.CloseAll()
                            weazel_news_inmenu = false
                            
                            TriggerEvent("Mic:ToggleMic")
                        end
                    end)
                    
                    RageUI.Button("Sortir/ranger la perche", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            RageUI.CloseAll()
                            weazel_news_inmenu = false
                            
                            TriggerEvent("Mic:ToggleBMic")
                        end
                    end)

                end, function()
                end)
            end
        end)
    end
end

RMenu.Add('Extasy_lobby_weazelnews', "lobby_main", RageUI.CreateMenu('Accueil Weazel News',"Que souhaitez-vous faire ?"))
RMenu:Get('Extasy_lobby_weazelnews', 'lobby_main').Closed = function()
    weazel_news_in_menu_lobby  = false
end 

openLobbyWeazelNewsMenu = function() 	  
    if not weazel_news_in_menu_lobby  then 
        weazel_news_in_menu_lobby  = true
		RageUI.Visible(RMenu:Get('Extasy_lobby_weazelnews', 'lobby_main'), true)
		Citizen.CreateThread(function()
			while weazel_news_in_menu_lobby  do
                Citizen.Wait(1)
				RageUI.IsVisible(RMenu:Get('Extasy_lobby_weazelnews', 'lobby_main'),true,true,true,function()

					RageUI.Separator('~r~Bienvenue chez Weazel News~s~')
                    RageUI.Separator()

                    RageUI.ButtonWithStyle("Envoyez une demande de recrutement", nil, {RightLabel = "→"}, true, function(_, _, s)
						if s then
                            local discord = Extasy.KeyboardInput("Précisez votre nom & Tag discord ex: (Extasy#0093):", "", 30)

                            if discord ~= nil then
                                local text = Extasy.KeyboardInput("Précisez votre demande de recrutement :", "", 300)

                                if text ~= nil then
                                    TriggerServerEvent("WeazelNews:SendWebhookLobby", token, discord, text)
                                    PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 0)
                                    Extasy.ShowAdvancedNotification('~r~Weazel News', '~g~Succès', "Votre demande a été envoyée et sera traitée dans les plus brefs délais.", 'CHAR_CHAT_CALL', 2, true, false, 60)
                                    demandeCooldown = true
                                    Citizen.SetTimeout((1000*60)*2, function()
                                        demandeCooldown = false
                                    end)
                                    RageUI.CloseAll()
                                    weazel_news_in_menu_lobby = false
                                end
                            end
                        end
					end)

                    RageUI.ButtonWithStyle("Envoyez une demande de rendez-vous", nil, {RightLabel = "→"}, true, function(_, _, s)
						if s then
                            local discord = Extasy.KeyboardInput("Précisez votre nom & Tag discord ex: (Extasy#0093):", "", 30)

                            if discord ~= nil then
                                local text = Extasy.KeyboardInput("Précisez la raison de votre demande de rendez-vous :", "", 300)

                                if text ~= nil then
                                    TriggerServerEvent("WeazelNews:SendWebhookLobby2", token, discord, text)
                                    PlaySoundFrontend(-1, "Event_Message_Purple", "GTAO_FM_Events_Soundset", 0)
                                    Extasy.ShowAdvancedNotification('~r~Weazel News', '~g~Succès', "Votre demande a été envoyée et sera traitée dans les plus brefs délais.", 'CHAR_CHAT_CALL', 2, true, false, 60)
                                    demandeCooldown = true
                                    Citizen.SetTimeout((1000*60)*2, function()
                                        demandeCooldown = false
                                    end)
                                    RageUI.CloseAll()
                                    weazel_news_in_menu_lobby = false
                                end
                            end
                        end
					end)
                    
				end, function()
                end)
            end
        end)
    end 
end