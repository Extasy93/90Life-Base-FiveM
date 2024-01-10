Citizen.CreateThread(function()
    SetMapZoomDataLevel(0, 2.75, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 2.8, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 20.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 35.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        
        if IsPedOnFoot(GetPlayerPed(-1)) then 
            SetRadarZoom(1100)
        elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			      SetRadarZoom(1100)
		    end
    end
end)