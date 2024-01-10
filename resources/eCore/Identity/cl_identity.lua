local OpenedIdentityOpen = false
local OpenedSkinMenu = false
local ClotheList = {}
local choise_menu = false
local valide1 = false
local valide2 = false
local finalAge = ""
local finalHeight = ""
local index    = 1
local firstName, lastName, height, sexxrslt, age = "", "", "", "", ""
local stateLastname, stateFirstname, stateHeight, stateSexe, stateAge = false, false, false, false, false, false
local MenuList = {List1 = 1,List2 = 1, List3 = 1,List4 = 1,List5 = 1,List6 = 1,List7 = 1,List8 = 1,List9 = 1, List10 = 1,List11 = 1}
local facecam = nil
local pilocam = nil
local tenuecam = nil 
local actionClothe = 1
local SettingsMenu = {
    percentage = 1.0,
    ColorCheveux = {primary = { 1, 1 }, secondary = { 1, 1 }},
    ColorBarbes = {primary = { 1, 1 }, secondary = { 1, 1 }},
}
Creator = {
    Indexsexe = 1,
    Motherindex = 1,
    DadIndex = 1,
    PeauCoulour = 5,
    PeauCoulour2 = 0.5,
    Ressemblance = 5,
    Ressemblance2 = 0.5,

    Hairindex = 1,
    Beardindex = 1,
    Indexeyebow = 1,
    EyexIndex = 1,
    NoseoneIndex = 1,

    Hairlist = {},
    BeardList = {},
    EyebowList = {},
    EyesColorList = {},
    NosoneList = {},
    FaceList = {},

    ColorHair = {
        primary = {1, 1},
        secondary = {1, 1},
    },

    ColorBeard = {
        primary = {1, 1},
        secondary = {1, 1},
    },

    ColorEyebow = {
        primary = {1, 1},
        secondary = {1, 1},
    },

    OpaPercent = 0,
    OpePercentEyebow = 0,
    PercentLargenose = 0,
    PercentHauteurnose = 0,
    PercentCrochuNose = 0,
    PercentJoueHauteur = 0,
    PercentJoueCreux = 0,
    PercentJoueCreuxx = 0,
    PercentMacoire1 = 0,
    PercentMacoire2 = 0,
    PercentMentonHauteur = 0,
    PercentMentonLargeur = 0,
    FaceListIndex = 1,
    ColorFaceIndex = 1,
    ColorFace = {"1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42"},
    DadList = {"Benjamin", "Daniel", "Joshua", "Noah", "Andrew", "Juan", "Alex", "Isaac", "Evan", "Ethan", "Vincent", "Angel", "Diego", "Adrian", "Gabriel", "Michael", "Santiago", "Kevin", "Louis", "Samuel", "Anthony", "Pierre", "Niko"},
    MotherList = {"Adelyn", "Emily", "Abigail", "Beverly", "Kristen", "Hailey", "June", "Daisy", "Elizabeth", "Addison", "Ava", "Cameron", "Samantha", "Madison", "Amber", "Heather", "Hillary", "Courtney", "Ashley", "Alyssa", "Mia", "Brittany"},
}

Citizen.CreateThread(function()
    for i = 1, 130 do
        table.insert(Creator.Hairlist, i)
    end
    for i = 1, 130 do
        table.insert(Creator.FaceList, i)
    end
    for i = 1, 74 do 
        table.insert(Creator.BeardList, i)
    end
    for i = 1, 73 do 
        table.insert(Creator.EyebowList, i)
    end
    for i = 1, 31 do
        table.insert(Creator.EyesColorList, i)
    end
end)

RMenu.Add('identity', 'main', RageUI.CreateMenu("Personnage", "Créez votre identité"))
RMenu.Add('identity', 'choise_menu', RageUI.CreateSubMenu(RMenu:Get('identity', 'main'), "Personnage", "Créez votre personnage"))
RMenu.Add('identity', 'simple_menu', RageUI.CreateSubMenu(RMenu:Get('identity', 'choise_menu'), "Personnage", "Créez votre personnage"))
RMenu.Add('identity', 'advanced_menu', RageUI.CreateSubMenu(RMenu:Get('identity', 'choise_menu'), "Personnage", "Créez votre personnage"))
RMenu.Add('identity', 'pilosity_menu', RageUI.CreateSubMenu(RMenu:Get('identity', 'simple_menu'), "Personnage", "Choisissez votre pilosité"))
RMenu.Add('identity', 'pilosity_menu', RageUI.CreateSubMenu(RMenu:Get('identity', 'advanced_menu'), "Personnage", "Choisissez votre pilosité"))
RMenu.Add('identity', 'finish_menu', RageUI.CreateSubMenu(RMenu:Get('identity', 'pilosity_menu'), "Personnage", "Encore quelques détails"))

RMenu:Get('identity', 'main').Closable = false
RMenu:Get('identity', 'advanced_menu').EnableMouse = true
RMenu:Get('identity', 'pilosity_menu').EnableMouse = true
RMenu:Get('identity', 'choise_menu').Closed = function()
    DestroyAllCams(true)

    sexcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    SetCamCoord(sexcam, -235.06, -2001.01, 25.30)
    SetCamActive(sexcam, true)
    RenderScriptCams(true, true, 2000, true, false)
    PointCamAtEntity(sexcam, PlayerPedId())
    SetCamParams(sexcam, -234.99, -2000.91, 25.30, 4.0, 0.0, 0.415, 50.2442, 0, 1, 1, 2)
end
RMenu:Get('identity', 'main').Closed = function()
    OpenedIdentityOpen = false
    OpenedSkinMenu = false
end
RMenu:Get('identity', 'finish_menu').Closed = function()
    OpenedIdentityOpen = false
    OpenedSkinMenu = false
end

OpenIdentityRegisterMenu = function()
    if OpenedIdentityOpen then
        OpenedIdentityOpen = false
        return
    else
        OpenedIdentityOpen = true
        RageUI.Visible(RMenu:Get('identity', 'main'), true)
        CreateThread(function()
            while OpenedIdentityOpen do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('identity', 'main'), true, true, true, function()

                    IdentityTurnPed()

                    RageUI.Button("> Prénom", nil, {RightLabel = firstName}, true, function(h, a, s)
                        if s then
                            Wait(1)
                            firstName = Extasy.KeyboardInput("Définissez votre prénom", "", 30)
                            firstName = tostring(firstName)
                            stateFirstname = true
                            TriggerServerEvent("Identity:updateFirstname", token, firstName)
                        end
                    end)

                    RageUI.Button("> Nom", nil, {RightLabel = lastName}, true, function(h, a, s)
                        if s then
                            Wait(1)
                            lastName = Extasy.KeyboardInput("Définissez votre nom", "", 30)
                            lastName = tostring(lastName)
                            stateLastname = true
                            TriggerServerEvent("Identity:updateLastname", token, lastName)
                        end
                    end)

                    RageUI.Button("> Âge", nil, {RightLabel = finalAge}, true, function(h, a, s)
                        if s then
                            Wait(1)
                            age = Extasy.KeyboardInput("Définissez votre âge", "", 10)
                            age = tostring(age)
                            finalAge = age.." ans"
                            stateAge = true
                            TriggerServerEvent("Identity:updateAge", token, finalAge)
                        end
                    end)

                    RageUI.Button("> Taille", nil, {RightLabel = finalHeight}, true, function(h, a, s)
                        if s then
                            Wait(1)
                            height = Extasy.KeyboardInput("Définissez votre taille", "", 30)
                            height = tostring(height)
                            finalHeight = height.." cm"
                            stateHeight = true
                            height = GetOnscreenKeyboardResult()
                            TriggerServerEvent("Identity:updateHeight", token, finalHeight)
                        end
                    end)

                    RageUI.List("> Choix du sexe", {"Homme", "Femme"}, index, nil, {}, true, function(h, a, s, Index)
                        index = Index

                        if Index == 1 then
                            TriggerEvent("skinchanger:change", "glasses_1", -1)
                            TriggerEvent("skinchanger:change", "sex", 0)
                            gender = "Homme"
                        else
                            TriggerEvent("skinchanger:change", "glasses_1", 5)
                            TriggerEvent("skinchanger:change", "sex", 1)
                            gender = "Femme"
                        end
                    end)

                    RageUI.Separator("")

                    if stateFirstname == true and stateLastname == true and stateAge == true and stateHeight == true then
                        RageUI.Button("> Valider la Création", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                            if s then
                                TriggerServerEvent("Identity:updateSex", token, gender)
                                whenActive = true
                                --[[destorycam(sexcam)
                                facecam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
                                SetCamCoord(facecam, -785.36511230469,342.24826049805,217.15214233398)
                                SetCamActive(facecam, true)
                                RenderScriptCams(true, true, 2000, true, false)
                                SetCamParams(facecam, -785.46511230469, 342.5826049805, 217.52, 00.0 , 00.0 , 0.215, 42.2442, 0, 1, 1, 2)--]]
                            end
                        end, RMenu:Get('identity', 'choise_menu'))  
                    else
                        RageUI.Button("> Valider la Création", nil, {RightBadge = RageUI.BadgeStyle.Lock}, false, function(h, a, s)
                        end)  
                    end
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('identity', 'choise_menu'), true, true, true, function()

                    RageUI.Button("> Mode simplifié", "pour une création sans prise de tête", {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            TriggerEvent("skinchanger:change", "face", 1)
                            TriggerEvent("skinchanger:change", "skin", 1)

                            destorycam(sexcam)
                            facecam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
                            SetCamCoord(facecam, -234.99, -2000.91, 25.70)
                            SetCamActive(facecam, true)
                            PointCamAtCoord(facecam, -235.48, -2003.06, 25.20)
                            RenderScriptCams(true, false, 2000, true, false)
                            SetCamParams(facecam, -234.99, -2000.91, 25.70, 0.0 --[[ inclinaison haut bas ]], 00.0 --[[ rotation y  float]], 0.215, 20.2442, 0, 1, 1, 2)
                        end
                    end, RMenu:Get('identity', 'simple_menu'))   

                    RageUI.Button("> Mode avancé", "pour une création jusqu'aux moindres détails", {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            TriggerEvent("skinchanger:change", "face", 0)
                            TriggerEvent("skinchanger:change", "skin", 0)

                            destorycam(sexcam)
                            facecam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
                            SetCamCoord(facecam, -234.99, -2000.91, 25.70)
                            SetCamActive(facecam, true)
                            PointCamAtCoord(facecam, -235.48, -2003.06, 25.20)
                            RenderScriptCams(true, false, 2000, true, false)
                            SetCamParams(facecam, -234.99, -2000.91, 25.70, 0.0 --[[ inclinaison haut bas ]], 00.0 --[[ rotation y  float]], 0.215, 20.2442, 0, 1, 1, 2)
                        end
                    end, RMenu:Get('identity', 'advanced_menu'))  

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('identity', 'pilosity_menu'), true, true, true, function()

                    RageUI.List("Cheveux", Creator.Hairlist, Creator.Hairindex, nil, {}, true, function(h, a, s, Index)
                        Creator.Hairindex = Index
                        if a then
                            ColourPanel1_enable = true
                            Creator.Hairindex = Index
                            TriggerEvent("skinchanger:change", "hair_1", Creator.Hairindex)
                        else
                            ColourPanel1_enable = false
                        end
                    end)
        
                    RageUI.List("Barbe", Creator.BeardList, Creator.Beardindex, nil, {}, true, function(h, a, s, Index)
                        Creator.Beardindex = Index 
                        if a then
                            ColourPanel2_enable = true
                            Creator.Beardindex = Index 
                            TriggerEvent("skinchanger:change", "beard_1", Creator.Beardindex)
                        else
                            ColourPanel2_enable = false
                        end
                    end)
        
                    RageUI.List("Sourcil", Creator.EyebowList, Creator.Indexeyebow, nil, {}, true, function(h, a, s, Index)
                        Creator.Indexeyebow = Index 
                        if a then
                            ColourPanel3_enable = true
                            Creator.Indexeyebow = Index 
                            TriggerEvent("skinchanger:change", "eyebrows_1", Creator.Indexeyebow)
                        else
                            ColourPanel3_enable = false
                        end
                    end)
        
                    RageUI.List("Couleur des yeux", Creator.EyesColorList, Creator.EyexIndex, nil, {}, true, function(h, a, s, Index)
                        Creator.EyexIndex = Index 
                        if a then
                            Creator.EyexIndex = Index 
                            TriggerEvent("skinchanger:change", "eye_color", Creator.EyexIndex)
                        end
                    end)

                    RageUI.Separator("")

                    RageUI.Button("> Valider son visage", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            sexcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
                            SetCamCoord(sexcam, -235.06, -2001.01, 25.30)
                            SetCamActive(sexcam, true)
                            RenderScriptCams(true, true, 2000, true, false)
                            PointCamAtEntity(sexcam, PlayerPedId())
                            SetCamParams(sexcam, -234.99, -2000.91, 25.30, 4.0, 0.0, 0.415, 50.2442, 0, 1, 1, 2)
                        end

                    end, RMenu:Get('identity', 'finish_menu')) 

                    if ColourPanel1_enable then
                        RageUI.ColourPanel("Couleur Principale", RageUI.PanelColour.HairCut, Creator.ColorHair.primary[1], Creator.ColorHair.primary[2], function(h, a, MinimumIndex, CurrentIndex)
                            if a then
                                Creator.ColorHair.primary[1] = MinimumIndex
                                Creator.ColorHair.primary[2] = CurrentIndex
                                TriggerEvent("skinchanger:change", "hair_color_1" ,Creator.ColorHair.primary[2])
                            end
                        end)

                        RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, Creator.ColorHair.secondary[1], Creator.ColorHair.secondary[2], function(h, a, MinimumIndex, CurrentIndex)
                            if a then
                                Creator.ColorHair.secondary[1] = MinimumIndex
                                Creator.ColorHair.secondary[2] = CurrentIndex
                                TriggerEvent("skinchanger:change", "hair_color_2", Creator.ColorHair.secondary[2])
                            end
                        end)
                    end
        
                    if ColourPanel2_enable then
                        RageUI.PercentagePanel(Creator.OpaPercent, 'Opacité', '0%', '100%', function(h, a, Percent)
                            Creator.OpaPercent = Percent
                            if a then
                                Creator.OpaPercent = Percent
                                TriggerEvent('skinchanger:change', 'beard_2', Percent*10)
                            end
                        end) 

                        RageUI.ColourPanel("Couleur de la barbe", RageUI.PanelColour.HairCut, Creator.ColorBeard.secondary[1], Creator.ColorBeard.secondary[2], function(h, a, MinimumIndex, CurrentIndex)
                            if a then
                                Creator.ColorBeard.secondary[1] = MinimumIndex
                                Creator.ColorBeard.secondary[2] = CurrentIndex
                                TriggerEvent("skinchanger:change", "beard_3", Creator.ColorBeard.secondary[2])
                            end
                        end)
                    end
        
                    if ColourPanel3_enable then
                        RageUI.PercentagePanel(Creator.OpePercentEyebow, 'Opacité', '0%', '100%', function(h, a, Percent)
                            if a then
                                Creator.OpePercentEyebow = Percent
                                TriggerEvent('skinchanger:change', 'eyebrows_2', Percent*10)
                            end
                        end)
            
                        RageUI.ColourPanel("Couleur des sourcils", RageUI.PanelColour.HairCut, Creator.ColorEyebow.secondary[1], Creator.ColorEyebow.secondary[2], function(h, a, MinimumIndex, CurrentIndex)
                            if a then
                                Creator.ColorEyebow.secondary[1] = MinimumIndex
                                Creator.ColorEyebow.secondary[2] = CurrentIndex
                                TriggerEvent("skinchanger:change", "eyebrows_3", Creator.ColorEyebow.secondary[2])
                            end
                        end)
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('identity', 'finish_menu'), true, true, true, function()

                    RageUI.List("> Tenue d'arrivée", {"Luxe", "Ete", "Ville", "Décontracté", "Urbain"}, actionClothe, nil, {}, true, function(h, a, s, Index)
                        actionClothe = Index
                        if a then
                            setSkinToPed(actionClothe)
                        end
                    end)

                    RageUI.Separator("")

                    RageUI.Button("> Valider", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                            end)
                            RageUI.CloseAll()
                            Wait(1)
                            SetPlayerControl(PlayerId(), false)
                            EndCharCreator()
                        end
                    end) 

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('identity', 'simple_menu'), true, true, true, function()

                    RageUI.List('Visage', Creator.FaceList, Creator.FaceListIndex, nil, {}, true, function(h, a, s, i)
                        if a then
                            TriggerEvent("skinchanger:change", "face", i)
                            Creator.FaceListIndex = i
                        end
                    end)

                    RageUI.List('Couleur de Peau', Creator.ColorFace , Creator.ColorFaceIndex, nil, {}, true, function(h, a, s, i)  
                        if a then
                            TriggerEvent("skinchanger:change", "skin", i)
                            Creator.ColorFaceIndex = i
                        end
                    end)

                    RageUI.Separator("")

                    RageUI.Button("> Valider", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                    end, RMenu:Get('identity', 'pilosity_menu'))  

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('identity', 'advanced_menu'), true, true, true, function()

                    RageUI.HeritageWindow(Creator.Motherindex, Creator.DadIndex)

                    RageUI.List('Mère', Creator.MotherList, Creator.Motherindex, "Choisissez la ~p~mère~w~ de votre personnage.", {}, true, function(h, a, s, index)
                        if a then
                            Creator.Motherindex = index
                            TriggerEvent("skinchanger:change", "mom", index)
                        end
                    end)

                    RageUI.List('Père', Creator.DadList, Creator.DadIndex, "Choisissez le ~p~père~w~ de votre personnage.", {}, true, function(h, a, s, index)
                        if a then
                            Creator.DadIndex = index
                            TriggerEvent("skinchanger:change", "dad", index)
                        end
                    end)

                    RageUI.UISliderHeritage('Couleur de peau', Creator.PeauCoulour, nil, function(h, s, a, Heritage, Index)
                        Creator.PeauCoulour = Index 
                        Creator.PeauCoulour2 = Index*10
                        TriggerEvent("skinchanger:change", "skin_md_weight", Creator.PeauCoulour2)
                    end)

                    RageUI.UISliderHeritage('Ressemblance', Creator.Ressemblance, nil, function(h, s, a, Heritage, Index)
                        Creator.Ressemblance = Index 
                        Creator.Ressemblance2 = Index*10
                        TriggerEvent("skinchanger:change", "face_md_weight", Creator.Ressemblance2)
                    end)
                    
                    RageUI.Button("> Nez", nil, {RightLabel = "<>"}, true, function(h, a, s) 
                        if a then
                            nose_PercentagePanel_enable = true
                        else
                            nose_PercentagePanel_enable = false
                        end
                    end)
                    RageUI.Button("> Joue", nil, {RightLabel = "<>"}, true, function(h, a, s) 
                        if a then
                            joue_PercentagePanel_enable = true
                        else
                            joue_PercentagePanel_enable = false
                        end
                    end)
                    RageUI.Button("> Mâchoires", nil, {RightLabel = "<>"}, true, function(h, a, s) 
                        if a then
                            machoires_PercentagePanel_enable = true
                        else
                            machoires_PercentagePanel_enable = false
                        end
                    end)
                    RageUI.Button("> Menton", nil, {RightLabel = "<>"}, true, function(h, a, s) 
                        if a then
                            menton_PercentagePanel_enable = true
                        else
                            menton_PercentagePanel_enable = false
                        end
                    end)

                    RageUI.Separator("")

                    RageUI.Button("> Valider", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            --[[DoScreenFadeOut(500)
                            Wait(1000)
                            destorycam(facecam)
                            SetEntityCoordsNoOffset(PlayerPedId(), vector3(-805.62152099609,332.31878662109,220.93844604492))
                            pilocam  = CreateCameraWithParams('DEFAULT_SCRIPTED_CAMERA', -805.61324462891,333.69589233398,221.33392334, 0.422939, 0.0, -185.3886, 43.0557, false, 2)
                            SetCamActive(pilocam, true)
                            RenderScriptCams(true, false, 3000, true, false, false)
                            Wait(1000)
                            DoScreenFadeIn(500)--]]
                        end
                    end, RMenu:Get('identity', 'pilosity_menu'))  
            
                    
                end, function()

                    if nose_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentLargenose, 'Largeur', '0%', '100%', function(h, a, Percent)
                            Creator.PercentLargenose = Percent
                            if a then
                                Creator.PercentLargenose = Percent
                                TriggerEvent('skinchanger:change', 'nose_1', Percent*2)
                            end
                        end)
                    end

                    if nose_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentHauteurnose, 'Hauteur', '0%', '100%', function(h, a, Percent)
                            Creator.PercentHauteurnose = Percent
                            if a then
                                Creator.PercentHauteurnose = Percent
                                TriggerEvent('skinchanger:change', 'nose_2', Percent*2)
                            end
                        end)
                    end

                    if nose_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentCrochuNose, 'Crochu', '0%', '100%', function(h, a, Percent)
                            Creator.PercentCrochuNose = Percent
                            if a then
                                Creator.PercentCrochuNose = Percent
                                TriggerEvent('skinchanger:change', 'nose_5', Percent*2)
                            end
                        end)
                    end

                    if joue_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentJoueHauteur, 'Hauteur  des paumettes', '0%', '100%', function(h, a, Percent)
                            Creator.PercentJoueHauteur = Percent
                            if a then
                                Creator.PercentJoueHauteur = Percent
                                TriggerEvent('skinchanger:change', 'cheeks_1', Percent*2)
                            end
                        end)
                    end

                    if joue_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentJoueCreux, 'Creux des paumettes', '0%', '100%', function(h, a, Percent)
                            Creator.PercentJoueCreux = Percent
                            if a then
                                Creator.PercentJoueCreux = Percent
                                TriggerEvent('skinchanger:change', 'cheeks_2', Percent*2)
                            end
                        end)
                    end

                    if joue_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentJoueCreuxx, 'Creux des joues', '0%', '100%', function(h, a, Percent)
                            Creator.PercentJoueCreuxx = Percent
                            if a then
                                Creator.PercentJoueCreuxx = Percent
                                TriggerEvent('skinchanger:change', 'cheeks_3', Percent*2)
                            end
                        end)
                    end


                    if machoires_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentMacoire1, 'Largeur de la Mâchoire', '0%', '100%', function(h, a, Percent)
                            Creator.PercentMacoire1 = Percent
                            if a then
                                Creator.PercentMacoire1 = Percent
                                TriggerEvent('skinchanger:change', 'jaw_1', Percent*2)
                            end
                        end)
                    end

                    if machoires_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentMacoire2, 'Epaisseur de la Mâchoire', '0%', '100%', function(h, a, Percent)
                            Creator.PercentMacoire2 = Percent
                            if a then
                                Creator.PercentMacoire2 = Percent
                                TriggerEvent('skinchanger:change', 'jaw_2', Percent*2)
                            end
                        end)
                    end

                    if menton_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentMentonHauteur, 'Hauteur du menton', '0%', '100%', function(h, a, Percent)
                            Creator.PercentMentonHauteur = Percent
                            if a then
                                Creator.PercentMentonHauteur = Percent
                                TriggerEvent('skinchanger:change', 'chin_1', Percent*2)
                            end
                        end)
                    end

                    if menton_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentMentonLargeur, 'Largeur du menton', '0%', '100%', function(h, a, Percent)
                            Creator.PercentMentonLargeur = Percent
                            if a then
                                Creator.PercentMentonLargeur = Percent
                                TriggerEvent('skinchanger:change', 'chin_2', Percent*2)
                            end
                        end)
                    end
                end)
            end
        end)
    end
end

OpenSkinMenu = function()
    if OpenedSkinMenu then
        OpenedSkinMenu = false
        return
    else
        OpenedSkinMenu = true
        RageUI.Visible(RMenu:Get('identity', 'choise_menu'), true)
        CreateThread(function()
            while OpenedSkinMenu do
                Wait(1)

                RageUI.IsVisible(RMenu:Get('identity', 'choise_menu'), true, true, true, function()

                    IdentityTurnPed()

                    RageUI.List("> Choix du sexe", {"Homme", "Femme"}, index, nil, {}, true, function(h, a, s, Index)
                        index = Index

                        if Index == 1 then
                            TriggerEvent("skinchanger:change", "glasses_1", -1)
                            TriggerEvent("skinchanger:change", "sex", 0)
                            gender = "Homme"
                        else
                            TriggerEvent("skinchanger:change", "glasses_1", 5)
                            TriggerEvent("skinchanger:change", "sex", 1)
                            gender = "Femme"
                        end
                    end)

                    RageUI.Separator("")

                    RageUI.Button("> Mode simplifié", "pour une création sans prise de tête", {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            TriggerEvent("skinchanger:change", "face", 1)
                            TriggerEvent("skinchanger:change", "skin", 1)
                        end
                    end, RMenu:Get('identity', 'simple_menu'))   

                    RageUI.Button("> Mode avancé", "pour une création jusqu'aux moindres détails", {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            TriggerEvent("skinchanger:change", "face", 0)
                            TriggerEvent("skinchanger:change", "skin", 0)
                        end
                    end, RMenu:Get('identity', 'advanced_menu'))  

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('identity', 'pilosity_menu'), true, true, true, function()

                    RageUI.List("Cheveux", Creator.Hairlist, Creator.Hairindex, nil, {}, true, function(h, a, s, Index)
                        Creator.Hairindex = Index
                        if a then
                            ColourPanel1_enable = true
                            Creator.Hairindex = Index
                            TriggerEvent("skinchanger:change", "hair_1", Creator.Hairindex)
                        else
                            ColourPanel1_enable = false
                        end
                    end)
        
                    RageUI.List("Barbe", Creator.BeardList, Creator.Beardindex, nil, {}, true, function(h, a, s, Index)
                        Creator.Beardindex = Index 
                        if a then
                            ColourPanel2_enable = true
                            Creator.Beardindex = Index 
                            TriggerEvent("skinchanger:change", "beard_1", Creator.Beardindex)
                        else
                            ColourPanel2_enable = false
                        end
                    end)
        
                    RageUI.List("Sourcil", Creator.EyebowList, Creator.Indexeyebow, nil, {}, true, function(h, a, s, Index)
                        Creator.Indexeyebow = Index 
                        if a then
                            ColourPanel3_enable = true
                            Creator.Indexeyebow = Index 
                            TriggerEvent("skinchanger:change", "eyebrows_1", Creator.Indexeyebow)
                        else
                            ColourPanel3_enable = false
                        end
                    end)
        
                    RageUI.List("Couleur des yeux", Creator.EyesColorList, Creator.EyexIndex, nil, {}, true, function(h, a, s, Index)
                        Creator.EyexIndex = Index 
                        if a then
                            Creator.EyexIndex = Index 
                            TriggerEvent("skinchanger:change", "eye_color", Creator.EyexIndex)
                        end
                    end)

                    RageUI.Separator("")

                    RageUI.Button("> Valider mon personnage", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                            TriggerEvent('skinchanger:getSkin', function(skin)
                                TriggerServerEvent('esx_skin:save', skin)
                            end)
                            RageUI.CloseAll()
                            OpenedSkinMenu = false
                        end
                    end) 

                end, function()

                    if ColourPanel1_enable then
                        RageUI.ColourPanel("Couleur Principale", RageUI.PanelColour.HairCut, Creator.ColorHair.primary[1], Creator.ColorHair.primary[2], function(h, a, MinimumIndex, CurrentIndex)
                            if a then
                                Creator.ColorHair.primary[1] = MinimumIndex
                                Creator.ColorHair.primary[2] = CurrentIndex
                                TriggerEvent("skinchanger:change", "hair_color_1" ,Creator.ColorHair.primary[2])
                            end
                        end)

                        RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, Creator.ColorHair.secondary[1], Creator.ColorHair.secondary[2], function(h, a, MinimumIndex, CurrentIndex)
                            if a then
                                Creator.ColorHair.secondary[1] = MinimumIndex
                                Creator.ColorHair.secondary[2] = CurrentIndex
                                TriggerEvent("skinchanger:change", "hair_color_2", Creator.ColorHair.secondary[2])
                            end
                        end)
                    end
        
                    if ColourPanel2_enable then
                        RageUI.PercentagePanel(Creator.OpaPercent, 'Opacité', '0%', '100%', function(h, a, Percent)
                            Creator.OpaPercent = Percent
                            if a then
                                Creator.OpaPercent = Percent
                                TriggerEvent('skinchanger:change', 'beard_2', Percent*10)
                            end
                        end) 

                        RageUI.ColourPanel("Couleur de la barbe", RageUI.PanelColour.HairCut, Creator.ColorBeard.secondary[1], Creator.ColorBeard.secondary[2], function(h, a, MinimumIndex, CurrentIndex)
                            if a then
                                Creator.ColorBeard.secondary[1] = MinimumIndex
                                Creator.ColorBeard.secondary[2] = CurrentIndex
                                TriggerEvent("skinchanger:change", "beard_3", Creator.ColorBeard.secondary[2])
                            end
                        end)
                    end
        
                    if ColourPanel3_enable then
                        RageUI.PercentagePanel(Creator.OpePercentEyebow, 'Opacité', '0%', '100%', function(h, a, Percent)
                            if a then
                                Creator.OpePercentEyebow = Percent
                                TriggerEvent('skinchanger:change', 'eyebrows_2', Percent*10)
                            end
                        end)
            
                        RageUI.ColourPanel("Couleur des sourcils", RageUI.PanelColour.HairCut, Creator.ColorEyebow.secondary[1], Creator.ColorEyebow.secondary[2], function(h, a, MinimumIndex, CurrentIndex)
                            if a then
                                Creator.ColorEyebow.secondary[1] = MinimumIndex
                                Creator.ColorEyebow.secondary[2] = CurrentIndex
                                TriggerEvent("skinchanger:change", "eyebrows_3", Creator.ColorEyebow.secondary[2])
                            end
                        end)
                    end
                end)

                RageUI.IsVisible(RMenu:Get('identity', 'simple_menu'), true, true, true, function()

                    RageUI.List('Visage', Creator.FaceList, Creator.FaceListIndex, nil, {}, true, function(h, a, s, i)
                        if a then
                            TriggerEvent("skinchanger:change", "face", i)
                            Creator.FaceListIndex = i
                        end
                    end)

                    RageUI.List('Couleur de Peau', Creator.ColorFace , Creator.ColorFaceIndex, nil, {}, true, function(h, a, s, i)  
                        if a then
                            TriggerEvent("skinchanger:change", "skin", i)
                            Creator.ColorFaceIndex = i
                        end
                    end)

                    RageUI.Separator("")

                    RageUI.Button("> Valider", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                    end, RMenu:Get('identity', 'pilosity_menu'))  

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('identity', 'advanced_menu'), true, true, true, function()

                    RageUI.HeritageWindow(Creator.Motherindex, Creator.DadIndex)

                    RageUI.List('Mère', Creator.MotherList, Creator.Motherindex, "Choisissez la ~p~mère~w~ de votre personnage.", {}, true, function(h, a, s, index)
                        if a then
                            Creator.Motherindex = index
                            TriggerEvent("skinchanger:change", "mom", index)
                        end
                    end)

                    RageUI.List('Père', Creator.DadList, Creator.DadIndex, "Choisissez le ~p~père~w~ de votre personnage.", {}, true, function(h, a, s, index)
                        if a then
                            Creator.DadIndex = index
                            TriggerEvent("skinchanger:change", "dad", index)
                        end
                    end)

                    RageUI.UISliderHeritage('Couleur de peau', Creator.PeauCoulour, nil, function(h, s, a, Heritage, Index)
                        Creator.PeauCoulour = Index 
                        Creator.PeauCoulour2 = Index*10
                        TriggerEvent("skinchanger:change", "skin_md_weight", Creator.PeauCoulour2)
                    end)

                    RageUI.UISliderHeritage('Ressemblance', Creator.Ressemblance, nil, function(h, s, a, Heritage, Index)
                        Creator.Ressemblance = Index 
                        Creator.Ressemblance2 = Index*10
                        TriggerEvent("skinchanger:change", "face_md_weight", Creator.Ressemblance2)
                    end)
                    
                    RageUI.Button("> Nez", nil, {RightLabel = "<>"}, true, function(h, a, s) 
                        if a then
                            nose_PercentagePanel_enable = true
                        else
                            nose_PercentagePanel_enable = false
                        end
                    end)
                    RageUI.Button("> Joue", nil, {RightLabel = "<>"}, true, function(h, a, s) 
                        if a then
                            joue_PercentagePanel_enable = true
                        else
                            joue_PercentagePanel_enable = false
                        end
                    end)
                    RageUI.Button("> Mâchoires", nil, {RightLabel = "<>"}, true, function(h, a, s) 
                        if a then
                            machoires_PercentagePanel_enable = true
                        else
                            machoires_PercentagePanel_enable = false
                        end
                    end)
                    RageUI.Button("> Menton", nil, {RightLabel = "<>"}, true, function(h, a, s) 
                        if a then
                            menton_PercentagePanel_enable = true
                        else
                            menton_PercentagePanel_enable = false
                        end
                    end)

                    RageUI.Separator("")

                    RageUI.Button("> Valider", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                        if s then
                        end
                    end, RMenu:Get('identity', 'pilosity_menu'))  
            
                    
                end, function()

                    if nose_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentLargenose, 'Largeur', '0%', '100%', function(h, a, Percent)
                            Creator.PercentLargenose = Percent
                            if a then
                                Creator.PercentLargenose = Percent
                                TriggerEvent('skinchanger:change', 'nose_1', Percent*2)
                            end
                        end)
                    end

                    if nose_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentHauteurnose, 'Hauteur', '0%', '100%', function(h, a, Percent)
                            Creator.PercentHauteurnose = Percent
                            if a then
                                Creator.PercentHauteurnose = Percent
                                TriggerEvent('skinchanger:change', 'nose_2', Percent*2)
                            end
                        end)
                    end

                    if nose_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentCrochuNose, 'Crochu', '0%', '100%', function(h, a, Percent)
                            Creator.PercentCrochuNose = Percent
                            if a then
                                Creator.PercentCrochuNose = Percent
                                TriggerEvent('skinchanger:change', 'nose_5', Percent*2)
                            end
                        end)
                    end

                    if joue_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentJoueHauteur, 'Hauteur  des paumettes', '0%', '100%', function(h, a, Percent)
                            Creator.PercentJoueHauteur = Percent
                            if a then
                                Creator.PercentJoueHauteur = Percent
                                TriggerEvent('skinchanger:change', 'cheeks_1', Percent*2)
                            end
                        end)
                    end

                    if joue_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentJoueCreux, 'Creux des paumettes', '0%', '100%', function(h, a, Percent)
                            Creator.PercentJoueCreux = Percent
                            if a then
                                Creator.PercentJoueCreux = Percent
                                TriggerEvent('skinchanger:change', 'cheeks_2', Percent*2)
                            end
                        end)
                    end

                    if joue_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentJoueCreuxx, 'Creux des joues', '0%', '100%', function(h, a, Percent)
                            Creator.PercentJoueCreuxx = Percent
                            if a then
                                Creator.PercentJoueCreuxx = Percent
                                TriggerEvent('skinchanger:change', 'cheeks_3', Percent*2)
                            end
                        end)
                    end


                    if machoires_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentMacoire1, 'Largeur de la Mâchoire', '0%', '100%', function(h, a, Percent)
                            Creator.PercentMacoire1 = Percent
                            if a then
                                Creator.PercentMacoire1 = Percent
                                TriggerEvent('skinchanger:change', 'jaw_1', Percent*2)
                            end
                        end)
                    end

                    if machoires_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentMacoire2, 'Epaisseur de la Mâchoire', '0%', '100%', function(h, a, Percent)
                            Creator.PercentMacoire2 = Percent
                            if a then
                                Creator.PercentMacoire2 = Percent
                                TriggerEvent('skinchanger:change', 'jaw_2', Percent*2)
                            end
                        end)
                    end

                    if menton_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentMentonHauteur, 'Hauteur du menton', '0%', '100%', function(h, a, Percent)
                            Creator.PercentMentonHauteur = Percent
                            if a then
                                Creator.PercentMentonHauteur = Percent
                                TriggerEvent('skinchanger:change', 'chin_1', Percent*2)
                            end
                        end)
                    end

                    if menton_PercentagePanel_enable then
                        RageUI.PercentagePanel(Creator.PercentMentonLargeur, 'Largeur du menton', '0%', '100%', function(h, a, Percent)
                            Creator.PercentMentonLargeur = Percent
                            if a then
                                Creator.PercentMentonLargeur = Percent
                                TriggerEvent('skinchanger:change', 'chin_2', Percent*2)
                            end
                        end)
                    end
                end)
            end
        end)
    end
end

setSkinToPed = function(Tenues)
    if Tenues == 1 then
        TriggerEvent("skinchanger:getSkin", function(skin)
            local uniformObject
            if gender == "Homme" then
                uniformObject = cfg_identity.WelcomeTenues1.Male
            else
                uniformObject = cfg_identity.WelcomeTenues1.Female
            end
            if uniformObject then
                TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
                --TriggerServerEvent('esx_skin:save', skin)
            end
        end)
    elseif Tenues == 2 then
        TriggerEvent("skinchanger:getSkin", function(skin)
            local uniformObject
            if gender == "Homme" then
                uniformObject = cfg_identity.WelcomeTenues2.Male
            else
                uniformObject = cfg_identity.WelcomeTenues2.Female
            end
            if uniformObject then
                TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
                --TriggerServerEvent('esx_skin:save', skin)
            end
        end)
    elseif Tenues == 3 then
        TriggerEvent("skinchanger:getSkin", function(skin)
            local uniformObject
            if gender == "Homme" then
                uniformObject = cfg_identity.WelcomeTenues3.Male
            else
                uniformObject = cfg_identity.WelcomeTenues3.Female
            end
            if uniformObject then
                TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
                --TriggerServerEvent('esx_skin:save', skin)
            end
        end)
    elseif Tenues == 4 then
        TriggerEvent("skinchanger:getSkin", function(skin)
            local uniformObject
            if gender == "Homme" then
                uniformObject = cfg_identity.WelcomeTenues4.Male
            else
                uniformObject = cfg_identity.WelcomeTenues4.Female
            end
            if uniformObject then
                TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
                --TriggerServerEvent('esx_skin:save', skin)
            end
        end)
    elseif Tenues == 5 then
        TriggerEvent("skinchanger:getSkin", function(skin)
            local uniformObject
            if gender == "Homme" then
                uniformObject = cfg_identity.WelcomeTenues5.Male
            else
                uniformObject = cfg_identity.WelcomeTenues5.Female
            end
            if uniformObject then
                TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
                --TriggerServerEvent('esx_skin:save', skin)
            end
        end)
    end
end

IdentityTurnPed = function()
    FreezeEntityPosition(PlayerPedId(), true)
   -- DisableAllControlActions(0)
   if OpenedIdentityOpen then 
        Extasy.PopupTime("Appuyez sur ~p~[E]~s~ ou ~p~[A]~s~ pour tourner votre personnage~s~.", 50)
        local Control1, Control2 = IsDisabledControlPressed(1, 44), IsDisabledControlPressed(1, 51)
        if Control1 or Control2 then
            SetEntityHeading(PlayerPedId(), Control1 and GetEntityHeading(PlayerPedId()) - 2.0 or Control2 and GetEntityHeading(PlayerPedId()) + 2.0)
        end
    end
end

OpenIdentityMenu = function()
end

destorycam = function(camera)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(camera, false)
end