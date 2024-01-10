-- ESX = nil

-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(5000)

--         SendNUIMessage({type = "ui", display = false})
--         SetNuiFocus(false)

--     end  
-- end)

function OpenWebsite(url)
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'ui', display = true, url = url})
end

RegisterNUICallback("close", function(data, cb)
    SendNUIMessage({type = "ui", display = false})
    SetNuiFocus(false)
end)