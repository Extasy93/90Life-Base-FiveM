ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('Extasy:notif1')
AddEventHandler('Extasy:notif1', function(token)
    if not CheckToken(token, source, "Extasy:notif1") then return end
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('Extasy:showAdvancedNotification', xPlayer.source, "Tom", "~r~Body Guard", "Si tu souhaite tentez de gagner cette maginfique voiture il te suffie juste d\'aller tourner la roue dans l\'arcade à coté (1% de chance de l'avoir).", 'CHAR_CASINO', 9)
end)

RegisterNetEvent('Extasy:notif2')
AddEventHandler('Extasy:notif2', function(token)
    if not CheckToken(token, source, "Extasy:notif2") then return end
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('Extasy:showAdvancedNotification', xPlayer.source, "Tom", "~r~Body Guard", "~r~BRUTALE !~w~\nC\'est le mot qui définie la M4 GTS qui a tout sacrifié pour être une bête de circuit. Son excellent chrono au Nürburgring (Allemagne) en témoigne.", 'CHAR_CASINO', 9)
end)

RegisterNetEvent('Extasy:notif3')
AddEventHandler('Extasy:notif3', function(token)
    if not CheckToken(token, source, "Extasy:notif3") then return end
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('Extasy:showAdvancedNotification', xPlayer.source, "Vincent", "~r~Body Guard", "Le système de ticket est basé sur 24H. Tout les jours a 00H00 vous recevrez votre ticket journalier, si tu souhaite achetez des ticket en plus c'est possible ! ~g~↓", 'CHAR_CASINO', 9)
end)

RegisterNetEvent('Extasy:notif4')
AddEventHandler('Extasy:notif4', function(token)
    if not CheckToken(token, source, "Extasy:notif4") then return end
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('Extasy:showAdvancedNotification', xPlayer.source, "Vincent", "~r~Body Guard", "~g~→🛒 ~w~ Rendez-vous sur https://shop.90Life.fr/ ! ", 'CHAR_CASINO', 9)
end)