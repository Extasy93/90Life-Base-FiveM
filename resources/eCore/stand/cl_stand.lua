local OpenStandMenu = false

RMenu.Add('Extasy_stand_menu', 'main', RageUI.CreateMenu("Stand de tir","Que souhaitez-vous faire ?"))
RMenu:Get('Extasy_stand_menu', 'main').Closed = function()
    OpenStandMenu = false
    RageUI.CloseAll()
    FreezeEntityPosition(GetPlayerPed(-1), false)
end

OpenMenuStand = function()
    if not OpenStandMenu then 
        OpenStandMenu = true
		RageUI.Visible(RMenu:Get('Extasy_stand_menu', 'main'), true)

		Citizen.CreateThread(function()
			while OpenStandMenu do
				Citizen.Wait(1)

                RageUI.IsVisible(RMenu:Get('Extasy_stand_menu', 'main'), true, true, true, function()

                RageUI.ButtonWithStyle("~p~Session~s~ - ~r~[20 sec]", nil, {RightLabel = "~g~120$"}, true, function(_,_,s)
                    if s then 
                        Session1()
                        OpenStandMenu = false
                        RageUI.CloseAll()
                        FreezeEntityPosition(GetPlayerPed(-1), false)
                    end
                end)


                RageUI.ButtonWithStyle("~p~Session~s~ - ~r~[30 sec]", nil, {RightLabel = "~g~150$"}, true, function(_,_,s)
                    if s then 
                        Session2()
                        OpenStandMenu = false
                        RageUI.CloseAll()
                        FreezeEntityPosition(GetPlayerPed(-1), false)
                    end
                end)

                RageUI.ButtonWithStyle("~p~Session~s~ - ~r~[40 sec]", nil, {RightLabel = "~g~200$"}, true, function(_,_,s)
                    if s then 
                        Session3()
                        OpenStandMenu = false
                        RageUI.CloseAll()
                        FreezeEntityPosition(GetPlayerPed(-1), false)
                    end
                end)

                RageUI.ButtonWithStyle("~p~Session~s~ - ~r~[50 sec]", nil, {RightLabel = "~g~225$"}, true, function(_,_,s)
                    if s then 
                        Session4()
                        OpenStandMenu = false
                        RageUI.CloseAll()
                        FreezeEntityPosition(GetPlayerPed(-1), false)
                    end
                end)

                RageUI.ButtonWithStyle("~p~Session~s~ - ~r~[60 sec]", nil, {RightLabel = "~g~250$"}, true, function(_,_,s)
                    if s then 
                        Session5()
                        OpenStandMenu = false
                        RageUI.CloseAll()
                        FreezeEntityPosition(GetPlayerPed(-1), false)
                    end
                end)
            
                RageUI.ButtonWithStyle("Classement [BIENTÔT]", nil, { RightLabel = "→→" }, false, function(_,_,s)
                end, RMenu:Get('', '')) -- Menu pas encore crée 

                end, function()
                end)
            end
        end)
    end
end

local v1 = vector3(2582.419, 7442.953, 10.03869)

local distance = 10

Session1 = function()
    Extasy.ShowNotification("~o~Hop !\n~s~Tiens, je t'ai mis les ~o~mannequins~s~ en place") 
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1) 
    local hashm1 = GetHashKey("a_m_y_bevhills_01")
    while not HasModelLoaded(hashm1) do
    RequestModel(hashm1)
    Wait(20)
    end
    -- Ped 1
    Wait(50) 
    mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01", 2574.61, 7437.401, 10.03868, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin1, true)

    -- Ped 2
    Wait(50) 
    mannequin2 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2572.308, 7439.29, 10.03868, 266.319, false, true)
    SetBlockingOfNonTemporaryEvents(mannequin2, true)

    -- Ped 3
    Wait(50) 
    mannequin3 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2569.137, 7437.844, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin3, true)

    -- Ped 4
    Wait(50) 
    mannequin4 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2564.53, 7439.573, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin4, true)

    -- Ped 5
    Wait(50) 
    mannequin5 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2566.327, 7437.229, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin5, true)

    -- Ped 6
    Wait(50) 
    mannequin6 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.437, 7439.905, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin6, true)

    -- Ped 7
    Wait(50) 
    mannequin7 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2561.431, 7438.009, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin7, true)

    -- Ped 8
    Wait(50) 
    mannequin8 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2574.995, 7434.022, 10.03868, 266.31, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin8, true)

    -- Ped 9
    Wait(50) 
    mannequin9 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2572.303, 7435.537, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin9, true)

    -- Ped 10
    Wait(50) 
    mannequin10 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2561.78, 7435.256, 10.03868, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin10, true)

    -- Ped 11
    Wait(50) 
    mannequin11 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.822, 7434.052, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin11, true)

    -- Ped 12
    Wait(50) 
    mannequin12 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.799, 7438.76, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin12, true)

    -- Ped 13
    Wait(50) 
    mannequin13 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",18.672371368408,-1070.0399658203,28.797008514404, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin13, true)

    -- Ped 14
    Wait(50) 
    mannequin14 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",26.572371368408,-1073.1399658203,28.797008514404, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin14, true)
    
    Wait(20000) 
    Extasy.ShowNotification("~o~Votre session est ~r~[terminer!") 
    DeletePed(mannequin1)--1
    Wait(50) -- Anti Lag
    DeletePed(mannequin2)--2
    Wait(50) -- Anti Lag
    DeletePed(mannequin3)--3
    Wait(50) -- Anti Lag
    DeletePed(mannequin4)--4
    Wait(50) -- Anti Lag
    DeletePed(mannequin5)--5
    Wait(50) -- Anti Lag
    DeletePed(mannequin6)--6
    Wait(50) -- Anti Lag
    DeletePed(mannequin7)--7
    Wait(50) -- Anti Lag
    DeletePed(mannequin8)--8
    Wait(50) -- Anti Lag
    DeletePed(mannequin9)--9
    Wait(50) -- Anti Lag
    DeletePed(mannequin10)--10
    Wait(50) -- Anti Lag
    DeletePed(mannequin11)--11
    Wait(50) -- Anti Lag
    DeletePed(mannequin12)--12
    Wait(50) -- Anti Lag
    DeletePed(mannequin13)--13
    Wait(50) -- Anti Lag
    DeletePed(mannequin14)--14
end

Session2 = function()
    Extasy.ShowNotification("~o~Hop !\n~s~Tiens, je t'ai mis les ~o~mannequins~s~ en place") 
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1) 
    local hashm1 = GetHashKey("a_m_y_bevhills_01")
    while not HasModelLoaded(hashm1) do
    RequestModel(hashm1)
    Wait(20)
    end
    -- Ped 1
    Wait(50) 
    mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01", 2574.61, 7437.401, 10.03868, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin1, true)

    -- Ped 2
    Wait(50) 
    mannequin2 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2572.308, 7439.29, 10.03868, 266.319, false, true)
    SetBlockingOfNonTemporaryEvents(mannequin2, true)

    -- Ped 3
    Wait(50) 
    mannequin3 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2569.137, 7437.844, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin3, true)

    -- Ped 4
    Wait(50) 
    mannequin4 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2564.53, 7439.573, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin4, true)

    -- Ped 5
    Wait(50) 
    mannequin5 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2566.327, 7437.229, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin5, true)

    -- Ped 6
    Wait(50) 
    mannequin6 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.437, 7439.905, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin6, true)

    -- Ped 7
    Wait(50) 
    mannequin7 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2561.431, 7438.009, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin7, true)

    -- Ped 8
    Wait(50) 
    mannequin8 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2574.995, 7434.022, 10.03868, 266.31, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin8, true)

    -- Ped 9
    Wait(50) 
    mannequin9 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2572.303, 7435.537, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin9, true)

    -- Ped 10
    Wait(50) 
    mannequin10 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2561.78, 7435.256, 10.03868, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin10, true)

    -- Ped 11
    Wait(50) 
    mannequin11 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.822, 7434.052, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin11, true)

    -- Ped 12
    Wait(50) 
    mannequin12 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.799, 7438.76, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin12, true)

    -- Ped 13
    Wait(50) 
    mannequin13 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",18.672371368408,-1070.0399658203,28.797008514404, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin13, true)

    -- Ped 14
    Wait(50) 
    mannequin14 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",26.572371368408,-1073.1399658203,28.797008514404, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin14, true)
    
    Wait(30000) 
    Extasy.ShowNotification("~o~Votre session est ~r~[terminer!") 
    DeletePed(mannequin1)--1
    Wait(50) -- Anti Lag
    DeletePed(mannequin2)--2
    Wait(50) -- Anti Lag
    DeletePed(mannequin3)--3
    Wait(50) -- Anti Lag
    DeletePed(mannequin4)--4
    Wait(50) -- Anti Lag
    DeletePed(mannequin5)--5
    Wait(50) -- Anti Lag
    DeletePed(mannequin6)--6
    Wait(50) -- Anti Lag
    DeletePed(mannequin7)--7
    Wait(50) -- Anti Lag
    DeletePed(mannequin8)--8
    Wait(50) -- Anti Lag
    DeletePed(mannequin9)--9
    Wait(50) -- Anti Lag
    DeletePed(mannequin10)--10
    Wait(50) -- Anti Lag
    DeletePed(mannequin11)--11
    Wait(50) -- Anti Lag
    DeletePed(mannequin12)--12
    Wait(50) -- Anti Lag
    DeletePed(mannequin13)--13
    Wait(50) -- Anti Lag
    DeletePed(mannequin14)--14
end

Session3 = function()
    Extasy.ShowNotification("~o~Hop !\n~s~Tiens, je t'ai mis les ~o~mannequins~s~ en place") 
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1) 
    local hashm1 = GetHashKey("a_m_y_bevhills_01")
    while not HasModelLoaded(hashm1) do
    RequestModel(hashm1)
    Wait(20)
    end
    -- Ped 1
    Wait(50) 
    mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01", 2574.61, 7437.401, 10.03868, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin1, true)

    -- Ped 2
    Wait(50) 
    mannequin2 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2572.308, 7439.29, 10.03868, 266.319, false, true)
    SetBlockingOfNonTemporaryEvents(mannequin2, true)

    -- Ped 3
    Wait(50) 
    mannequin3 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2569.137, 7437.844, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin3, true)

    -- Ped 4
    Wait(50) 
    mannequin4 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2564.53, 7439.573, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin4, true)

    -- Ped 5
    Wait(50) 
    mannequin5 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2566.327, 7437.229, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin5, true)

    -- Ped 6
    Wait(50) 
    mannequin6 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.437, 7439.905, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin6, true)

    -- Ped 7
    Wait(50) 
    mannequin7 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2561.431, 7438.009, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin7, true)

    -- Ped 8
    Wait(50) 
    mannequin8 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2574.995, 7434.022, 10.03868, 266.31, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin8, true)

    -- Ped 9
    Wait(50) 
    mannequin9 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2572.303, 7435.537, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin9, true)

    -- Ped 10
    Wait(50) 
    mannequin10 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2561.78, 7435.256, 10.03868, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin10, true)

    -- Ped 11
    Wait(50) 
    mannequin11 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.822, 7434.052, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin11, true)

    -- Ped 12
    Wait(50) 
    mannequin12 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.799, 7438.76, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin12, true)

    -- Ped 13
    Wait(50) 
    mannequin13 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",18.672371368408,-1070.0399658203,28.797008514404, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin13, true)

    -- Ped 14
    Wait(50) 
    mannequin14 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",26.572371368408,-1073.1399658203,28.797008514404, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin14, true)
    
    Wait(40000) 
    Extasy.ShowNotification("~o~Votre session est ~r~[terminer!") 
    DeletePed(mannequin1)--1
    Wait(50) -- Anti Lag
    DeletePed(mannequin2)--2
    Wait(50) -- Anti Lag
    DeletePed(mannequin3)--3
    Wait(50) -- Anti Lag
    DeletePed(mannequin4)--4
    Wait(50) -- Anti Lag
    DeletePed(mannequin5)--5
    Wait(50) -- Anti Lag
    DeletePed(mannequin6)--6
    Wait(50) -- Anti Lag
    DeletePed(mannequin7)--7
    Wait(50) -- Anti Lag
    DeletePed(mannequin8)--8
    Wait(50) -- Anti Lag
    DeletePed(mannequin9)--9
    Wait(50) -- Anti Lag
    DeletePed(mannequin10)--10
    Wait(50) -- Anti Lag
    DeletePed(mannequin11)--11
    Wait(50) -- Anti Lag
    DeletePed(mannequin12)--12
    Wait(50) -- Anti Lag
    DeletePed(mannequin13)--13
    Wait(50) -- Anti Lag
    DeletePed(mannequin14)--14
end

Session4 = function()
    Extasy.ShowNotification("~o~Hop !\n~s~Tiens, je t'ai mis les ~o~mannequins~s~ en place") 
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1) 
    local hashm1 = GetHashKey("a_m_y_bevhills_01")
    while not HasModelLoaded(hashm1) do
    RequestModel(hashm1)
    Wait(20)
    end
    -- Ped 1
    Wait(50) 
    mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01", 2574.61, 7437.401, 10.03868, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin1, true)

    -- Ped 2
    Wait(50) 
    mannequin2 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2572.308, 7439.29, 10.03868, 266.319, false, true)
    SetBlockingOfNonTemporaryEvents(mannequin2, true)

    -- Ped 3
    Wait(50) 
    mannequin3 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2569.137, 7437.844, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin3, true)

    -- Ped 4
    Wait(50) 
    mannequin4 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2564.53, 7439.573, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin4, true)

    -- Ped 5
    Wait(50) 
    mannequin5 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2566.327, 7437.229, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin5, true)

    -- Ped 6
    Wait(50) 
    mannequin6 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.437, 7439.905, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin6, true)

    -- Ped 7
    Wait(50) 
    mannequin7 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2561.431, 7438.009, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin7, true)

    -- Ped 8
    Wait(50) 
    mannequin8 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2574.995, 7434.022, 10.03868, 266.31, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin8, true)

    -- Ped 9
    Wait(50) 
    mannequin9 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2572.303, 7435.537, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin9, true)

    -- Ped 10
    Wait(50) 
    mannequin10 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2561.78, 7435.256, 10.03868, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin10, true)

    -- Ped 11
    Wait(50) 
    mannequin11 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.822, 7434.052, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin11, true)

    -- Ped 12
    Wait(50) 
    mannequin12 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.799, 7438.76, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin12, true)

    -- Ped 13
    Wait(50) 
    mannequin13 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",18.672371368408,-1070.0399658203,28.797008514404, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin13, true)

    -- Ped 14
    Wait(50) 
    mannequin14 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",26.572371368408,-1073.1399658203,28.797008514404, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin14, true)
    
    Wait(50000) 
    Extasy.ShowNotification("~o~Votre session est ~r~[terminer!") 
    DeletePed(mannequin1)--1
    Wait(50) -- Anti Lag
    DeletePed(mannequin2)--2
    Wait(50) -- Anti Lag
    DeletePed(mannequin3)--3
    Wait(50) -- Anti Lag
    DeletePed(mannequin4)--4
    Wait(50) -- Anti Lag
    DeletePed(mannequin5)--5
    Wait(50) -- Anti Lag
    DeletePed(mannequin6)--6
    Wait(50) -- Anti Lag
    DeletePed(mannequin7)--7
    Wait(50) -- Anti Lag
    DeletePed(mannequin8)--8
    Wait(50) -- Anti Lag
    DeletePed(mannequin9)--9
    Wait(50) -- Anti Lag
    DeletePed(mannequin10)--10
    Wait(50) -- Anti Lag
    DeletePed(mannequin11)--11
    Wait(50) -- Anti Lag
    DeletePed(mannequin12)--12
    Wait(50) -- Anti Lag
    DeletePed(mannequin13)--13
    Wait(50) -- Anti Lag
    DeletePed(mannequin14)--14
end

Session5 = function()
    Extasy.ShowNotification("~o~Hop !\n~s~Tiens, je t'ai mis les ~o~mannequins~s~ en place") 
    PlaySoundFrontend(-1, "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1) 
    local hashm1 = GetHashKey("a_m_y_bevhills_01")
    while not HasModelLoaded(hashm1) do
    RequestModel(hashm1)
    Wait(20)
    end
    -- Ped 1
    Wait(50) 
    mannequin1 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01", 2574.61, 7437.401, 10.03868, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin1, true)

    -- Ped 2
    Wait(50) 
    mannequin2 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2572.308, 7439.29, 10.03868, 266.319, false, true)
    SetBlockingOfNonTemporaryEvents(mannequin2, true)

    -- Ped 3
    Wait(50) 
    mannequin3 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2569.137, 7437.844, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin3, true)

    -- Ped 4
    Wait(50) 
    mannequin4 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2564.53, 7439.573, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin4, true)

    -- Ped 5
    Wait(50) 
    mannequin5 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2566.327, 7437.229, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin5, true)

    -- Ped 6
    Wait(50) 
    mannequin6 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.437, 7439.905, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin6, true)

    -- Ped 7
    Wait(50) 
    mannequin7 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2561.431, 7438.009, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin7, true)

    -- Ped 8
    Wait(50) 
    mannequin8 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2574.995, 7434.022, 10.03868, 266.31, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin8, true)

    -- Ped 9
    Wait(50) 
    mannequin9 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2572.303, 7435.537, 10.03869, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin9, true)

    -- Ped 10
    Wait(50) 
    mannequin10 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2561.78, 7435.256, 10.03868, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin10, true)

    -- Ped 11
    Wait(50) 
    mannequin11 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.822, 7434.052, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin11, true)

    -- Ped 12
    Wait(50) 
    mannequin12 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",2557.799, 7438.76, 10.0387, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin12, true)

    -- Ped 13
    Wait(50) 
    mannequin13 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",18.672371368408,-1070.0399658203,28.797008514404, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin13, true)

    -- Ped 14
    Wait(50) 
    mannequin14 = CreatePed("PED_TYPE_CIVMALE", "a_m_y_bevhills_01",26.572371368408,-1073.1399658203,28.797008514404, 266.319, false, true) 
    SetBlockingOfNonTemporaryEvents(mannequin14, true)
    
    Wait(60000) 
    Extasy.ShowNotification("~o~Votre session est ~r~[terminer!") 
    DeletePed(mannequin1)--1
    Wait(50) -- Anti Lag
    DeletePed(mannequin2)--2
    Wait(50) -- Anti Lag
    DeletePed(mannequin3)--3
    Wait(50) -- Anti Lag
    DeletePed(mannequin4)--4
    Wait(50) -- Anti Lag
    DeletePed(mannequin5)--5
    Wait(50) -- Anti Lag
    DeletePed(mannequin6)--6
    Wait(50) -- Anti Lag
    DeletePed(mannequin7)--7
    Wait(50) -- Anti Lag
    DeletePed(mannequin8)--8
    Wait(50) -- Anti Lag
    DeletePed(mannequin9)--9
    Wait(50) -- Anti Lag
    DeletePed(mannequin10)--10
    Wait(50) -- Anti Lag
    DeletePed(mannequin11)--11
    Wait(50) -- Anti Lag
    DeletePed(mannequin12)--12
    Wait(50) -- Anti Lag
    DeletePed(mannequin13)--13
    Wait(50) -- Anti Lag
    DeletePed(mannequin14)--14
end