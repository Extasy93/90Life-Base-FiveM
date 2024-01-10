ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Wait(1)
    end
end)

function GetLicense(id)
    local identifiers = GetPlayerIdentifiers(id)
    for _, v in pairs(identifiers) do
        if string.find(v, "license") then
            return v
        end
    end
end

RegisterServerEvent("cxDevTool:setPlayerToBucket")
AddEventHandler("cxDevTool:setPlayerToBucket", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    SetPlayerRoutingBucket(source, 1)
end)

RegisterServerEvent("cxDevTool:setPlayerToNormalBucket")
AddEventHandler("cxDevTool:setPlayerToNormalBucket", function()
    SetPlayerRoutingBucket(source, 0)
end)

RegisterNetEvent('cxDevTool:GetGroups')
AddEventHandler('cxDevTool:GetGroups', function()
    local source = source
    if source == 0 then return end
    local license = GetLicense(source)
    --[[if not Config.AllowedLicences[license] then
        print("pas autorisé")
        return
    end--]]
    TriggerClientEvent("cxDevTool:OpenDevToolMenu", source)
end)