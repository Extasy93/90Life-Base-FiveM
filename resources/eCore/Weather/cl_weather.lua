AddEventHandler('playerSpawned', function()
    TriggerServerEvent('Weather:requestSync')
end)

CurrentWeather = 'EXTRASUNNY'
local lastWeather = CurrentWeather

RegisterNetEvent('Weather:updateWeather')
AddEventHandler('Weather:updateWeather', function(NewWeather)
    CurrentWeather = NewWeather
end)

CreateThread(function()
    while true do
        if lastWeather ~= CurrentWeather then
            lastWeather = CurrentWeather
            SetWeatherTypeOverTime(CurrentWeather, 15.0)
            Wait(1850)
        end
        Wait(1500)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(lastWeather)
        SetWeatherTypeNow(lastWeather)
        SetWeatherTypeNowPersist(lastWeather)
        if lastWeather == 'EXTRASUNNY' then
            SetForceVehicleTrails(true)
            SetForcePedFootstepsTracks(true)
        else
            SetForceVehicleTrails(false)
            SetForcePedFootstepsTracks(false)
        end
    end
end)

RegisterNetEvent('Weather:updateTime')
AddEventHandler('Weather:updateTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)