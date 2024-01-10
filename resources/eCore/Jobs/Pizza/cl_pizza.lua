local PlayerData = {}
local pizza_in_menu = false
local nbPizza = 0
local leaderboard = {  
    {pos = vector3(2159.752, 4830.353, 10.85879)},
}
--CONFIGURATION--

local pizzeria = {x = 3658.1254882813, y = 6310.4482421875, z = 9.320711135864} --Configuration marker prise de service
local pizzeriafin = {x = 3662.9770507813, y = 6305.6181640625, z = 9.305788993835} --Configuration marker fin de service
local spawnfaggio = {x = 3662.4643554688, y = 6305.5922851563, z = 10.308590888977} --Configuration du point de spawn du faggio

local livpt = { --Configuration des points de livraisons (point de de Maykellll1 / NetOut / Patoche )
    [1] = {name = "Motel", x = 3684.4575195313, y = 6335.9907226563, z = 9.199221611023},
    [2] = {name = "Deveraux St.",x = 3688.4624023438, y = 6484.9702148438, z = 9.605904579163},
    [3] = {name = "Belzer Ave.",x = 3757.7458496094, y = 6624.6225585938, z = 9.035271644592},
    [4] = {name = "Dirk St.",x = 3277.3220214844, y = 7115.5654296875, z = 8.9128227233887},
    [5] = {name = "Merlrose Blvrd.",x = 2576.5109863281, y = 7241.041015625, z = 9.19206237793},
    [6] = {name = "Bayfront Ave.",x = 2681.3273925781, y = 6881.5688476563, z = 9.056784629822},
    [7] = {name = "Bayshore Ave.",x = 2455.501953125, y = 6717.287109375, z = 9.072703361511},
    [8] = {name = "Belleview Rd.",x = 2301.806640625, y = 6535.7993164063, z = 9.222663879395},
    [9] = {name = "Bayshore Ave.",x = 2386.244140625, y = 5698.1640625, z = 9.062265396118},
    [10] = {name = "Crocket St.",x = 2252.072265625, y = 5515.2221679688, z = 9.740376472473},
    [11] = {name = "Bayshore Ave.",x = 2397.9499511719, y = 5252.8305664063, z = 9.061507225037},
    [12] = {name = "Bayshore Ave.",x = 2414.9233398438, y = 5127.5698242188, z = 9.063210487366},
    [13] = {name = "Brick St.",x = 2368.9975585938, y = 4895.517578125, z = 9.822562217712},
    [14] = {name = "Ventura Blvrd.",x = 3215.5546875, y = 4672.6196289063, z = 8.3973236083984},
    [15] = {name = "Angel RD.",x = 3263.8295898438, y = 4875.75, z = 8.4250354766846},
    [16] = {name = "Ace St.",x = 3280.8166503906, y = 5008.9453125, z = 8.4250373840332},
    [17] = {name = "Collins Ave.",x = 3360.76953125, y = 5321.189453125, z = 8.395658493042},
    [18] = {name = "Collins Ave.",x = 3479.3872070313, y = 5467.626953125, z = 8.3956537246704},
    [19] = {name = "Ocean Drive",x = 3731.4965820313, y = 5772.1352539063, z = 8.8597106933594},
    [20] = {name = "Grove Ct.",x = 3522.8139648438, y = 6212.8676757813, z = 9.030877113342},
    [21] = {name = "Ribera Circle",x = 2719.4372558594, y = 5903.8251953125, z = 8.9891471862793}
}

local coefflouze = 0.1 --Coeficient multiplicateur qui en fonction de la distance definit la paie

--INIT--

local isInJobPizz = false
local livr = 0
local plateab = "POPJOBS"
local isToHouse = false
local isToPizzaria = false
local paie = 150

local pourboire = 0
local posibilidad = 0
local px = 0
local py = 0
local pz = 0
blip = nil

InitPizza = function()
    registerSocietyFarmZone({ 
        pos           = vector3(3655.077, 6308.973, 10.3578),
        spawnPoint    = {
            {pos = vector3(3659.234, 6303.083, 10.36144), heading = 307.94},
        },
        type          = 5,
        msg           = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le garage",
        garage        = {
            {name     = "Faggio de livraison",        hash = "foodbike2"},
            {name     = "Blista de livraison",        hash = "foodcar"},
        },
        marker        = true,
        name          = "",
        name_garage   = "Pizza",
        size          = 2.5,
    })

    registerSocietyFarmZone({ 
        pos           = vector3(3659.234, 6303.083, 10.36144),
        type          = 7,
        msg           = "~r~Appuyez sur ~INPUT_CONTEXT~ pour ranger votre véhicule",
        marker        = true,
        name          = "",
        name_garage   = "Pizza",
        size          = 2.5,
    })

    registerSocietyFarmZone({
        pos      = vector3(3671.03, 6297.057, 10.25064),
        type     = 6,
        size     = 1.0,
        marker   = true,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le menu d'entreprise",
    })

    registerSocietyFarmZone({
        pos      = vector3(3664.542, 6297.813, 10.15531),
        type     = 9,
        size     = 1.5,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre de la société",
    })

    registerSocietyFarmZone({
        pos      = vector3(3665.486, 6292.857, 10.2061),
        type     = 4,
        size     = 1.5,
        msg      = "~b~Appuyez sur ~INPUT_CONTEXT~ pour prendre votre tenue de service",
        marker   = true,
        name     = "Pizza",
        service  = false,
    
        blip_enable     = false,
    })

    aBlip = AddBlipForCoord(3671.03, 6297.057, 10.25064)
    SetBlipSprite(aBlip, 619)
    SetBlipDisplay(aBlip, 4)
    SetBlipColour(aBlip, 26)
    SetBlipScale(aBlip, 0.65)
    SetBlipAsShortRange(aBlip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Gestion entreprise Pizza")
    EndTextCommandSetBlipName(aBlip)
    
    registerSocietyFarmZone({
        pos      = vector3(3254.802, 4668.599, 9.423715),
        type     = 1,
        item     = "mozzarella",
        count    = 1,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter de la mozzarella",
    })

    registerSocietyFarmZone({
        pos      = vector3(3391.793, 5423.251, 9.428),
        type     = 1,
        item     = "saucetomate",
        count    = 1,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter de la sauce tomate",
    })

    registerSocietyFarmZone({
        pos      = vector3(3570.941, 6435.659, 10.40288),
        type     = 1,
        item     = "pate",
        count    = 1,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter de la pâte",
    })

    registerSocietyFarmZone({
        pos      = vector3(3641.519, 6887.79, 10.66103),
        type     = 1,
        item     = "pepperoni",
        count    = 1,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter des pepperoni",
    })

    registerSocietyFarmZone({
        pos      = vector3(2370.751, 7453.177, 10.34722),
        type     = 1,
        item     = "jambon",
        count    = 1,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter du jambon",
    })

    registerSocietyFarmZone({
        pos      = vector3(2053.132, 5576.788, 10.60307),
        type     = 1,
        item     = "champignon",
        count    = 1,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour récolter du champignon",
    })

    registerSocietyFarmZone({
        pos      = vector3(2755.233, 7554.242, 10.74531),
        type     = 2,
        item     = "pate",
        item_g   = "margarita",
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour transformer votre pâte",
    })
    
    registerSocietyFarmZone({
        pos      = vector3(2401.626, 4715.404, 10.99464),
        type     = 3,
        item     = "margarita",
        price    = extasy_core_cfg["private_society_sell_price"],
        society  = playerJob,
        size     = 5.0,
        time     = 7 * 1000,
        marker   = true,
        msg      = "~p~Appuyez sur ~INPUT_CONTEXT~ pour vendre votre pizza",
    })

    local b = {
        {pos = vector3(3254.802, 4668.599, 9.423715), sprite = 502, color = 17, scale = 0.60, title = "Pizza | Récolte mozzarella"},
        {pos = vector3(3391.793, 5423.251, 9.428), sprite = 502, color = 17, scale = 0.60, title = "Pizza | Récolte sauce"},
        {pos = vector3(3570.941, 6435.659, 10.40288), sprite = 502, color = 17, scale = 0.60, title = "Pizza | Récolte pâte"},
        {pos = vector3(3641.519, 6887.79, 10.66103), sprite = 502, color = 17, scale = 0.60, title = "Pizza | Récolte pepperoni"},
        {pos = vector3(2370.751, 7453.177, 10.34722), sprite = 502, color = 17, scale = 0.60, title = "Pizza | Récolte jambon"},
        {pos = vector3(2053.132, 5576.788, 10.60307), sprite = 502, color = 17, scale = 0.60, title = "Pizza | Récolte champignon"},
        {pos = vector3(3664.49, 6297.85, 9.15), sprite = 557, color = 2,  scale = 0.60, title = "Pizza | Coffre d'entreprise"},
        {pos = vector3(3665.486, 6292.857, 10.2061), sprite = 557, color = 3,  scale = 0.60, title = "Pizza | Vestaire"},
        {pos = vector3(3655.077, 6308.973, 10.3578), sprite = 557, color = 17, scale = 0.60, title = "Pizza | Garage"},
        {pos = vector3(3658.94, 6303.56, 9.36), sprite = 557, color = 59, scale = 0.60, title = "Pizza | Rangement véhicule"},
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

    Citizen.CreateThread(function()
        while true do
    
            local nearThing = false
    
            for k,l in pairs(leaderboard) do
                local dst = GetDistanceBetweenCoords(l.pos, GetEntityCoords(PlayerPedId()), false)
    
                if dst < 5.0 then
                    nearThing = true
    
                    if showLeaderboard then
                        Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + 2.39), "~s~[G] pour cacher le tableau", 0.75)
                        Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + 2.35), "~p~Tableau des employées~s~", 1.75)
    
                        local zOffset = 0
                        zOffset = 0.230*9
                        for k,v in pairs(bestTabacSeller) do
                            if k == 1 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~y~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." pizza(s) vendu ~s~", 1.0)
                            elseif k == 2 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~r~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." pizza(s) vendu ~s~", 1.0)
                            elseif k == 3 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~w~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." pizza(s) vendu ~s~", 1.0)
                            elseif k == 4 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." pizza(s) vendu ~s~", 1.0)
                            elseif k == 5 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." pizza(s) vendu ~s~", 1.0)
                            elseif k == 6 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." pizza(s) vendu ~s~", 1.0)
                            elseif k == 7 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." pizza(s) vendu ~s~", 1.0)
                            elseif k == 8 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." pizza(s) vendu ~s~", 1.0)
                            elseif k == 9 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." pizza(s) vendu ~s~", 1.0)
                            elseif k == 10 then
                                Extasy.DrawText3D(vector3(l.pos.x, l.pos.y, l.pos.z + zOffset), "~c~"..v.firstname.." "..v.lastname.."~s~ - ~g~"..v.farm_count.." pizza(s) vendu ~s~", 1.0)
                            end

                            zOffset = zOffset - 0.150
                        end
                    end
                end
            end
    
            if IsControlJustPressed(0, 47) then
                showLeaderboard = not showLeaderboard
            end
    
            if nearThing then
                Wait(0)
            else
                Wait(3000)
            end
        end
    end)

    Citizen.CreateThread(function()
        while true do
            Wait(2000)
            for k,v in pairs(leaderboard) do
                local dst = GetDistanceBetweenCoords(v.pos, GetEntityCoords(PlayerPedId()), false)
    
                if dst < 5.0 then
                    if not askedData then
                        TriggerServerEvent("pizza:getLeaderboard", token)
                    end
                end
            end
        end
    end)

    Draw2DText = function(x, y, text, scale)
        SetTextFont(4)
        SetTextProportional(7)
        SetTextScale(scale, scale)
        SetTextColour( 198, 25, 66, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
    end

    startPizzaLivraison = function()
        notif = true
        isInJobPizz = true
        isToHouse = true
        livr = math.random(1, 21)
    
        px = livpt[livr].x
        py = livpt[livr].y
        pz = livpt[livr].z
        distance = round(GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, px,py,pz))
        paie = distance * coefflouze
    
        spawn_faggio()
        goliv(livpt,livr)
        nbPizza = math.random(1, 5)
    
        TriggerServerEvent("pizza:itemadd", nbPizza)
    end

    registerNewMarker({
        npcType          = 'drawmarker',
        interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~accéder à la cuisine",
        pos              = vector3(3663.565, 6289.455, 9.08776),
        action          = function()
            TriggerServerEvent('pizza:teleportCuisine', token)
        end,
    
        spawned          = false,
        entity           = nil,
        load_dst         = 15,
    
    
        blip_enable      = false,
    
        marker           = true,
        size             = 0.6,
    
        drawmarkerType   = 6,
        drawmarkerRotation = 270.0,
    
        drawmarkerColorR = 100,
        drawmarkerColorG = 0,
        drawmarkerColorB = 200,
    })

    registerNewMarker({
        npcType          = 'drawmarker',
        interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~cuisiner",
        pos              = vector3(3668.07, 6300.22, 9.16),
        action           = function()
            openCuisinePizza()
        end,
    
        spawned          = false,
        entity           = nil,
        load_dst         = 30,
    
    
        blip_enable      = false,
    
        marker           = true,
        size             = 0.6,
    
        drawmarkerType   = 6,
        drawmarkerRotation = 270.0,
        
        drawmarkerColorR = 100,
        drawmarkerColorG = 0,
        drawmarkerColorB = 200,
    })

    registerNewMarker({
        npcType          = 'drawmarker',
        interactMessage  = "Appuyez sur ~INPUT_CONTEXT~ pour ~p~sortir de la cuisine",
        pos              = vector3(3663.43, 6293.03, 9.18),
        action          = function()
            TriggerServerEvent('pizza:teleportMain', token)
        end,
    
        spawned          = false,
        entity           = nil,
        load_dst         = 15,
    
    
        blip_enable      = false,
    
        marker           = true,
        size             = 0.6,
    
        drawmarkerType   = 6,
        drawmarkerRotation = 270.0,
    
        drawmarkerColorR = 100,
        drawmarkerColorG = 0,
        drawmarkerColorB = 200,
    })
end

openPizzaMenu = function()
    RMenu.Add('pizza', 'main', RageUI.CreateMenu("Pizza", "Que souhaitez-vous faire ?", 1, 100))
    RMenu.Add('pizza', 'billing', RageUI.CreateSubMenu(RMenu:Get('pizza', 'main'), "Facturation", "Qui souhaitez-vous facturer ?"))
    RMenu:Get('pizza', "main").Closed = function()
        pizza_menu_openned = false

        RMenu:Delete('pizza', 'main')
        RMenu:Delete('pizza', 'billing')
    end
    
    if pizza_menu_openned then
        pizza_menu_openned = false
        return
    else
        RageUI.CloseAll()

        pizza_menu_openned = true
        RageUI.Visible(RMenu:Get('pizza', 'main'), true)
    end

    local buy = {}

    CreateThread(function()
        while pizza_menu_openned do
            Wait(1)

            RageUI.IsVisible(RMenu:Get('pizza', 'main'), true, true, true, function()

                RageUI.Button("Annonce Pizza", nil, {RightLabel = "→→→"}, true, function(h, a, s) 
                    if s then
                        local a = Extasy.KeyboardInput("Que souhaitez-vous dire ?", "", 300)
                        if a ~= nil then
                            if string.sub(a, 1, string.len("-")) == "-" then
                                Extasy.ShowNotification("~r~Quantité invalide")
                            else
                                if string.len(a) > 5 then
                                    TriggerServerEvent("Jobs:sendToAllAdvancedMessage", token, 'Pizza', '~o~Publicité~s~', a, 'CHAR_PIZZA', 2, "Pizza")
                                end
                            end
                        else
                            Extasy.ShowNotification("~r~Heure invalide")
                        end
                    end
                end)

                RageUI.Button("Facturation", nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected) end, RMenu:Get('pizza', 'billing'))                           

            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('pizza', 'billing'), true, true, true, function()

                for _, player in ipairs(GetActivePlayers()) do
                    local dst = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(GetPlayerPed(-1)), true)
                    local sta = Extasy.IsMyId(player)
                    local coords = GetEntityCoords(GetPlayerPed(player))
                    local name = Extasy.ReplaceText(player)
        
                    if dst < 3.0 then
                        if sta ~= "me" then
                            RageUI.Button(name.." #".._, nil, {RightLabel = c}, true, function(Hovered, Active, Selected)
                                if Active then
                                    DrawMarker(20, coords.x, coords.y, coords.z + 1.1, nil, nil, nil, nil, nil, nil, 0.4, 0.4, 0.4, 100, 0, 200, 100, true, true)
                                    c = ""
                                else
                                    c = "💰"
                                end

                                if Selected then
                                    local i = Extasy.KeyboardInput("Définissez le montant", "", 10)
                                    i = tonumber(i)
                                    if i ~= nil then
                                        if i > 0 then
                                            if string.sub(i, 1, string.len("-")) == "-" then
                                                Extasy.ShowNotification("~r~Quantité invalide")
                                            else
                                                ClearPedTasks(GetPlayerPed(-1))
                                                TaskStartScenarioInPlace(GetPlayerPed(-1), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", -1, true)

                                                Wait(2500)
                                                TriggerServerEvent('pizza:sendBilling', token, "Facture Pizza", i, "pizza", GetPlayerServerId(player), false, nil)
                                            end
                                        else
                                            Extasy.ShowNotification("~r~Montant invalide")
                                        end
                                    else
                                        Extasy.ShowNotification("~r~Montant invalide")
                                    end
                                end
                            end)
                        end
                    end
                end

            end, function()
            end)
        end
    end)
end

local pizza_in_menu_cuisine = false

RMenu.Add('cuisine_pizza', "cuisine_main", RageUI.CreateMenu('Cuisine Stacked Pizza',"Que souhaitez-vous faire ?"))
RMenu:Get('cuisine_pizza', 'cuisine_main').Closed = function()
    pizza_in_menu_cuisine = false
end

openCuisinePizza = function()	  
    if not pizza_in_menu_cuisine then 
        pizza_in_menu_cuisine = true
		RageUI.Visible(RMenu:Get('cuisine_pizza', 'cuisine_main'), true)

		Citizen.CreateThread(function()
			while pizza_in_menu_cuisine do
                Wait(1)
				RageUI.IsVisible(RMenu:Get('cuisine_pizza','cuisine_main'),true,false,true,function()
            
                    RageUI.ButtonWithStyle("Pizza Margarita", nil, {RightLabel = "→→→"},true, function(h, a, s)
                        if s then
                            TriggerServerEvent('PizzaCraft:playerHasItemsMargarita')
                        end
                    end)

                    RageUI.ButtonWithStyle("Pizza Pepperoni", nil, {RightLabel = "→→→"},true, function(h, a, s)
                        if s then
                            TriggerServerEvent('PizzaCraft:playerHasItemsPepperoni')
                        end
                    end)

                    RageUI.ButtonWithStyle("Pizza Jambon & Champignons", nil, {RightLabel = "→→→"},true, function(h, a, s)
                        if s then
                            TriggerServerEvent('PizzaCraft:playerHasItemsJambon')
                        end
                    end)

                    RageUI.ButtonWithStyle("Calzone", nil, {RightLabel = "→→→"},true, function(h, a, s)
                        if s then
                            TriggerServerEvent('PizzaCraft:playerHasItemsCalzone')
                        end
                    end)

                    RageUI.ButtonWithStyle("Mozarella Sticks", nil, {RightLabel = "→→→"},true, function(h, a, s)
                        if s then
                            TriggerServerEvent('PizzaCraft:playerHasItemsMozzarella')
                        end
                    end)
				end, function()
                end)   
            end
        end)
    end
end

RegisterNetEvent('PizzaCraft:startCookingMargarita')
AddEventHandler('PizzaCraft:startCookingMargarita', function()
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = GetPlayerPed(-1);
            if DoesEntityExist(playerPed) then -- Check if ped exist
                dataAnim = { lib = "amb@prop_human_bbq@male@base", anim = "base" }

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                    TriggerEvent("eCore:AfficherBar", 6000, "Préparation en cours...")
                end

                -- Wait end animation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerServerEvent('PizzaCraft:finishCookingMargarita')
                        
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end)

RegisterNetEvent('PizzaCraft:startCookingPepperoni')
AddEventHandler('PizzaCraft:startCookingPepperoni', function()
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = GetPlayerPed(-1);
            if DoesEntityExist(playerPed) then -- Check if ped exist
                dataAnim = { lib = "amb@prop_human_bbq@male@base", anim = "base" }

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                    TriggerEvent("eCore:AfficherBar", 6000, "Préparation en cours...")
                end

                -- Wait end animation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerServerEvent('PizzaCraft:finishCookingPepperoni')
                        
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end)

RegisterNetEvent('PizzaCraft:startCookingJambon')
AddEventHandler('PizzaCraft:startCookingJambon', function()
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = GetPlayerPed(-1);
            if DoesEntityExist(playerPed) then -- Check if ped exist
                dataAnim = { lib = "amb@prop_human_bbq@male@base", anim = "base" }

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                    TriggerEvent("eCore:AfficherBar", 6000, "Préparation en cours...")
                end

                -- Wait end animation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerServerEvent('PizzaCraft:finishCookingJambon')
                        
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end)

RegisterNetEvent('PizzaCraft:startCookingCalzone')
AddEventHandler('PizzaCraft:startCookingCalzone', function()
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = GetPlayerPed(-1);
            if DoesEntityExist(playerPed) then -- Check if ped exist
                dataAnim = { lib = "amb@prop_human_bbq@male@base", anim = "base" }

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                    TriggerEvent("eCore:AfficherBar", 6000, "Préparation en cours...")
                end

                -- Wait end animation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerServerEvent('PizzaCraft:finishCookingCalzone')
                        
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end)

RegisterNetEvent('PizzaCraft:startCookingMozzarella')
AddEventHandler('PizzaCraft:startCookingMozzarella', function()
    Citizen.CreateThread(function()
        if not playAnim then
            local playerPed = GetPlayerPed(-1);
            if DoesEntityExist(playerPed) then -- Check if ped exist
                dataAnim = { lib = "amb@prop_human_bbq@male@base", anim = "base" }

                -- Play Animation
                RequestAnimDict(dataAnim.lib)
                while not HasAnimDictLoaded(dataAnim.lib) do
                    Citizen.Wait(0)
                end
                if HasAnimDictLoaded(dataAnim.lib) then
                    local flag = 0
                    if dataAnim.loop ~= nil and dataAnim.loop then
                        flag = 1
                    elseif dataAnim.move ~= nil and dataAnim.move then
                        flag = 49
                    end

                    TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
                    playAnimation = true
                    TriggerEvent("eCore:AfficherBar", 6000, "Préparation en cours...")
                end

                -- Wait end animation
                while true do
                    Citizen.Wait(0)
                    if not IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3) then
                        playAnim = false
                        TriggerServerEvent('PizzaCraft:finishCookingMozzarella')
                        
                        break
                    end
                end
            end -- end ped exist
        end
    end)
end)

----------------------------------------------
----------- LIVRAISON DE PIZZA --------------
----------------------------------------------

-- blips shop --
local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},

     }

    CreateThread(function()

    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 1.0)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

--THREADS--

Citizen.CreateThread(function() --Thread d'ajout du point de la pizzeria sur la carte

  for _, info in pairs(blips) do

    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.9)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
  end

end)

Citizen.CreateThread(function() --Thread lancement + livraison depuis le marker vert
  while true do

    Citizen.Wait(0)

    if isToHouse == true then

      destinol = livpt[livr].name

      while notif == true do

        Extasy.ShowAdvancedNotification("Pizza", "Livraison", "Direction : " ..destinol.. " pour livrer la pizza", "CHAR_PIZZA", source)
        notif = false

        i = 1
      end

      DrawMarker(1,livpt[livr].x,livpt[livr].y,livpt[livr].z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,0,255,0, 200, 0, 0, 0, 0)

      if GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(GetPlayerPed(-1),true)) < 3 then
        Extasy.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour livrer la pizza")

        if IsControlJustPressed(1,38) then
            if IsPedInAnyVehicle(GetPlayerPed(-1), true) then 
                Extasy.ShowAdvancedNotification("Pizza", "Livraison", "~r~ Vous devez sortir de votre véhicule !", "CHAR_PIZZA", source)
            else
                notif2 = true
                posibilidad = math.random(1, 100)
                afaitunepizzamin = true

                ExecuteCommand("e mechanic")
                FreezeEntityPosition(GetPlayerPed(-1), true)
                Wait(2000)
                ClearPedTasks(GetPlayerPed(-1))
                FreezeEntityPosition(GetPlayerPed(-1), false)
                TriggerServerEvent("pizza:itemrm")
                TriggerServerEvent("pizza:paie")
                nbPizza = nbPizza - 1
                Extasy.ShowAdvancedNotification("Pizza", "Livraison", "Rendez-vous à votre prochaine livraison !", "CHAR_PIZZA", source)
                    if (posibilidad > 70) and (posibilidad < 90) then

                        pourboire = math.random(50, 100)

                        Extasy.ShowAdvancedNotification("Pizza", "Livraison", "Un petit pourboire : " .. pourboire .. "$", "CHAR_PIZZA", source)
                        TriggerServerEvent("pizza:pourboire", token, pourboire)
                    end

                RemoveBlip(liv)
                Wait(250)
                if nbPizza == 0 then
                    isToHouse = false
                    isToPizzaria = true
                else
                    isToHouse = true
                    isToPizzaria = false
                    livr = math.random(1, 21)

                    px = livpt[livr].x
                    py = livpt[livr].y
                    pz = livpt[livr].z

                    distance = round(GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, px,py,pz))
                    paie = distance * coefflouze

                    goliv(livpt,livr)
                end
            end
        end
      end
    end

    if isToPizzaria == true then

      while notif2 == true do
        SetNewWaypoint(pizzeria.x,pizzeria.y)

        Extasy.ShowAdvancedNotification("Pizza", "Livraison", "Direction la pizzeria !", "CHAR_PIZZA", source)
        notif2 = false

      end
      DrawMarker(1,pizzeria.x,pizzeria.y,pizzeria.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,0,255,0, 200, 0, 0, 0, 0)

      if GetDistanceBetweenCoords(pizzeria.x,pizzeria.y,pizzeria.z, GetEntityCoords(GetPlayerPed(-1),true)) < 3 and afaitunepizzamin == true then
        Extasy.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour recuperer les pizzas")

        if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("foodbike2"))  then

          if IsControlJustPressed(1,38) then

            if IsInVehicle() then

              afaitunepizzamin = false

              Extasy.ShowAdvancedNotification("Pizza", "Livraison", "Nous vous remercions de votre travail, voici votre paie : " .. paie .. "$", "CHAR_PIZZA", source)
              TriggerServerEvent("pizza:pourboire", token, paie)

              isInJobPizz = true
              isToHouse = true
              livr = math.random(1, 21)

              px = livpt[livr].x
              py = livpt[livr].y
              pz = livpt[livr].z

              distance = round(GetDistanceBetweenCoords(pizzeria.x, pizzeria.y, pizzeria.z, px,py,pz))
              paie = distance * coefflouze

              goliv(livpt,livr)
              nbPizza = math.random(1, 5)

              TriggerServerEvent("pizza:itemadd", nbPizza)

            else

              notifmoto1 = true

                while notifmoto1 == true do

                    Extasy.ShowAdvancedNotification("Pizza", "Livraison", "Et la moto tu l'as oublié ?", "CHAR_PIZZA", source)
                    notifmoto1 = false
                end
            end
          end
        else

          notifmoto2 = true

          while notifmoto2 == true do

            Extasy.ShowAdvancedNotification("Pizza", "Livraison", "Et la moto tu l'as oublié ?", "CHAR_PIZZA", source)
            notifmoto2 = false
          end
        end
      end
    end
    if IsEntityDead(GetPlayerPed(-1)) then

      isInJobPizz = false
      livr = 0
      isToHouse = false
      isToPizzaria = false

      paie = 0
      px = 0
      py = 0
      pz = 0
      RemoveBlip(liv)

    end
  end
end)



Citizen.CreateThread(function() -- Thread de "fin de service" depuis le point rouge
  while true do

    Citizen.Wait(0)

    if isInJobPizz == true then

      DrawMarker(1,pizzeriafin.x,pizzeriafin.y,pizzeriafin.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,0,0, 200, 0, 0, 0, 0)

      if GetDistanceBetweenCoords(pizzeriafin.x, pizzeriafin.y, pizzeriafin.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
        Extasy.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour arreter la livraison de ~r~pizza")

        if IsControlJustPressed(1,38) then
          TriggerServerEvent('pizza:deleteAllPizz')
          isInJobPizz = false
          livr = 0
          isToHouse = false
          isToPizzaria = false

          paie = 0
          px = 0
          py = 0
          pz = 0

          if afaitunepizzamin == true then

            local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)

            SetEntityAsMissionEntity( vehicleu, true, true )
            deleteCar( vehicleu )

            Extasy.ShowAdvancedNotification("Pizza", "Livraison", "Merci d'avoir travaillé, bonne journée", "CHAR_PIZZA", source)

            SetWaypointOff()

            afaitunepizzamin = false

          else

            local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)

            SetEntityAsMissionEntity( vehicleu, true, true )
            deleteCar( vehicleu )

            Extasy.ShowAdvancedNotification("Pizza", "Livraison", "Merci quand même (pour rien), bonne journée", "CHAR_PIZZA", source)
          end
        end
      end
    end
  end
end)

--FONCTIONS--

function goliv(livpt,livr) -- Fonction d'ajout du point en fonction de la destination de livraison chosie
  liv = AddBlipForCoord(livpt[livr].x,livpt[livr].y, livpt[livr].z)
  SetBlipSprite(liv, 1)
  SetNewWaypoint(livpt[livr].x,livpt[livr].y)
end

function spawn_faggio() -- Thread spawn faggio

  Citizen.Wait(0)

  local myPed = GetPlayerPed(-1)
  local player = PlayerId()
  local vehicle = GetHashKey('foodbike2')

  RequestModel(vehicle)

  while not HasModelLoaded(vehicle) do
    Wait(1)
  end

  local plateJob = math.random(1000, 9999)
  local spawned_car = CreateVehicle(vehicle, spawnfaggio.x,spawnfaggio.y,spawnfaggio.z, 3662.4643554688, 6305.5922851563, 10.308590888977, true, false)

  local plate = "PIZZ"..plateJob

  SetVehicleNumberPlateText(spawned_car, plate)
  SetVehicleOnGroundProperly(spawned_car)
  SetVehicleLivery(spawned_car, 2)
  SetPedIntoVehicle(myPed, spawned_car, - 1)
  SetModelAsNoLongerNeeded(vehicle)

  Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end

function round(num, numDecimalPlaces)
  local mult = 5^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function deleteCar( entity )
  Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) ) --Native qui del le vehicule
end

function IsInVehicle() --Fonction de verification de la presence ou non en vehicule du joueur
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end


pizzaBlip = AddBlipForCoord(3670.73, 6288.06, 10.95)
SetBlipSprite(pizzaBlip, 78)
SetBlipDisplay(pizzaBlip, 4)
SetBlipColour(pizzaBlip, 69)
SetBlipScale(pizzaBlip, 0.65)
SetBlipAsShortRange(pizzaBlip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("The Well Stacked Pizza")
EndTextCommandSetBlipName(pizzaBlip)

