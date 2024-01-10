local oArray = {}
local oPlayerUse = {}


AddEventHandler('playerDropped', function()
    local oSource = source
    if oPlayerUse[oSource] ~= nil then
        oArray[oPlayerUse[oSource]] = nil
        oPlayerUse[oSource] = nil
    end
end)


RegisterServerEvent('ChairBedSystem:Server:Enter')
AddEventHandler('ChairBedSystem:Server:Enter', function(token, object, objectcoords)
    if not CheckToken(token, source, "ChairBedSystem:Server:Enter") then return end
    local oSource = source
    if oArray[objectcoords] == nil then
        oPlayerUse[oSource] = objectcoords
        oArray[objectcoords] = true
        TriggerClientEvent('ChairBedSystem:Client:Animation', oSource, object, objectcoords)
    end
end)


RegisterServerEvent('ChairBedSystem:Server:Leave')
AddEventHandler('ChairBedSystem:Server:Leave', function(token, objectcoords)
    if not CheckToken(token, source, "ChairBedSystem:Server:Leave") then return end
    local oSource = source

    oPlayerUse[oSource] = nil
    oArray[objectcoords] = nil
end)

