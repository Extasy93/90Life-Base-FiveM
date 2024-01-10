RegisterNetEvent("ocean_view:firework_1")
AddEventHandler("ocean_view:firework_1", function(data)
    Citizen.CreateThread(function()
        if not HasNamedPtfxAssetLoaded("scr_indep_fireworks") then
            RequestNamedPtfxAsset("scr_indep_fireworks")
            while not HasNamedPtfxAssetLoaded("scr_indep_fireworks") do
                Wait(10)
            end
        end

        for k,v in pairs(cfg_ocean_view.fireworkPatterns[1].pos) do
            Citizen.CreateThread(function()
                for i=1, 10 do
                    UseParticleFxAssetNextCall("scr_indep_fireworks")
                    local part = StartParticleFxNonLoopedAtCoord("scr_indep_firework_fountain", v.pos.x, v.pos.y, v.pos.z - 0.25, 0.0, 0.0, 0.0, 0.20, false, false, false, false)
                    Citizen.Wait(1000)
                end
            end)
            Citizen.Wait(500)
        end
    end)
end)