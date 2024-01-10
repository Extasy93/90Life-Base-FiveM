ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

SPRAYS = {}
FastBlacklist = {}

Citizen.CreateThread(function()
    if cfg_spray.Blacklist then
        for _, word in pairs(cfg_spray.Blacklist) do
            FastBlacklist[word] = word
        end
    end
end)

GetSprayAtCoords = function(pos)
    for _, spray in pairs(SPRAYS) do
        if spray.location == pos then
            return spray
        end
    end
end

RegisterNetEvent('Spray:addSpray')
AddEventHandler('Spray:addSpray', function(spray)
    local Source = source
    
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem("spray")
    
    if item.count > 0 then
        xPlayer.removeInventoryItem("spray", 1)
        local i = 1
        while true do
            if not SPRAYS[i] then
                SPRAYS[i] = spray
                break
            else
                i = i + 1
            end
        end

        PersistSpray(spray)
        SendLog("Le joueur **["..Source.."]** "..GetPlayerName(Source).." vien de faire un tag **"..spray.text.."** ("..spray.location..")", "spray")
        TriggerEvent('Sprays:addSpray', Source, spray.text, spray.location)
        TriggerClientEvent('Spray:setSprays', -1, SPRAYS)
    else
        TriggerClientEvent('chat:addMessage', Source, {
            template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
            args = {"Vous n'avez pas de spray pour pulvériser"}
        })
    end
end)

PersistSpray = function(spray)
    MySQL.Async.execute([[
        INSERT sprays
        (`x`, `y`, `z`, `rx`, `ry`, `rz`, `scale`, `text`, `font`, `color`, `interior`)
        VALUES
        (@x, @y, @z, @rx, @ry, @rz, @scale, @text, @font, @color, @interior)
    ]], {
        ['@x'] = spray.location.x,
        ['@y'] = spray.location.y,
        ['@z'] = spray.location.z,
        ['@rx'] = spray.realRotation.x,
        ['@ry'] = spray.realRotation.y,
        ['@rz'] = spray.realRotation.z,
        ['@scale'] = spray.scale,
        ['@text'] = spray.text,
        ['@font'] = spray.font,
        ['@color'] = spray.originalColor,
        ['@interior'] = spray.interior,
    })
end

Citizen.CreateThread(function()
    MySQL.Sync.execute([[
        DELETE FROM sprays 
        WHERE DATEDIFF(NOW(), created_at) >= @days
    ]], {['days'] = cfg_spray.general_config})

    local results = MySQL.Sync.fetchAll([[
        SELECT x, y, z, rx, ry, rz, scale, text, font, color, created_at, interior
        FROM sprays
    ]])

    for _, s in pairs(results) do
        table.insert(SPRAYS, {
            location = vector3(s.x + 0.0, s.y + 0.0, s.z + 0.0),
            realRotation = vector3(s.rx + 0.0, s.ry + 0.0, s.rz + 0.0),
            scale = tonumber(s.scale) + 0.0,
            text = s.text,
            font = s.font,
            originalColor = s.color,
            interior = (s.interior == 1) and true or false,
        })
    end

    TriggerClientEvent('Spray:setSprays', -1, SPRAYS)
end)

RegisterNetEvent('Spray:playerSpawned')
AddEventHandler('Spray:playerSpawned', function()
    local Source = source
    TriggerClientEvent('Spray:setSprays', Source, SPRAYS)
end)

HasSpray = function(serverId, cb)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local item = xPlayer.getInventoryItem("spray")

    cb(item.count > 0)
end

ESX.RegisterUsableItem("spray_remover", function(playerId)
    TriggerClientEvent('Spray:removeClosestSpray', playerId)
end)

--[[
RegisterCommand("remove", function(source)
    TriggerClientEvent('Spray:removeClosestSpray', source)
end)
]]--

RegisterNetEvent('Spray:remove')
AddEventHandler('Spray:remove', function(pos)
    local Source = source

    local xPlayer = ESX.GetPlayerFromId(Source)
    local item = xPlayer.getInventoryItem("spray_remover")
    
    if item.count > 0 then
        xPlayer.removeInventoryItem("spray_remover", 1)
        local sprayAtCoords = GetSprayAtCoords(pos)

        MySQL.Async.execute([[
            DELETE FROM sprays WHERE x=@x AND y=@y AND z=@z LIMIT 1
        ]], {
            ['@x'] = pos.x,
            ['@y'] = pos.y,
            ['@z'] = pos.z,
        })

        for idx, s in pairs(SPRAYS) do
            if s.location.x == pos.x and s.location.y == pos.y and s.location.z == pos.z then
                SPRAYS[idx] = nil
            end
        end
        TriggerClientEvent('Spray:setSprays', -1, SPRAYS)

        local sprayAtCoordsAfterRemoval = GetSprayAtCoords(pos)

        -- ensure someone doesnt bug it so its trying to remove other tags
        -- while deducting loyalty from not-deleted-but-at-coords tag
        if sprayAtCoords and not sprayAtCoordsAfterRemoval then
            TriggerEvent('Sprays:removeSpray', Source, sprayAtCoords.text, sprayAtCoords.location)
        end
    end
end)

Citizen.CreateThread(function()
    MySQL.Sync.execute([[
        CREATE TABLE IF NOT EXISTS `sprays` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `x` float(8,4) NOT NULL,
            `y` float(8,4) NOT NULL,
            `z` float(8,4) NOT NULL,
            `rx` float(8,4) NOT NULL,
            `ry` float(8,4) NOT NULL,
            `rz` float(8,4) NOT NULL,
            `scale` float(8,4) NOT NULL,
            `text` varchar(32) NOT NULL,
            `font` varchar(32) NOT NULL,
            `color` int(3) NOT NULL,
            `interior` int(3) NOT NULL,
            `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
            PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    ]])

    local sprayExists = MySQL.Sync.fetchScalar([[
        SELECT count(*) FROM items WHERE name='spray'
    ]])
    local sprayRemoverExists = MySQL.Sync.fetchScalar([[
        SELECT count(*) FROM items WHERE name='spray_remover'
    ]])

    if sprayExists == 0 then
        MySQL.Sync.execute([[
            INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('spray',	'Spray',	1,	1,	1);
        ]])
    end

    if sprayRemoverExists == 0 then
        MySQL.Sync.execute([[
            INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('spray_remover',	'Spray Remover',	1,	1,	1);
        ]])
    end
end)

RegisterNetEvent('Spray:sendSprayText')
AddEventHandler('Spray:sendSprayText', function(s)
    local xPlayer = ESX.GetPlayerFromId(source)
    local sprayText = s

    if FastBlacklist[sprayText] then
        --[[TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
            args = {"Ce mot est sur liste noire."}
        })--]]
    else
        if sprayText then
            if sprayText:len() <= 9 then
                TriggerClientEvent('Spray:spray', source, sprayText)
            else
                --[[TriggerClientEvent('chat:addMessage', source, {
                    template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
                    args = {"Le mot de pulvérisation peut comporter au maximum 9 caractères"}
                })--]]
            end
        else
            --[[TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="background: rgb(180, 136, 29); color: rgb(255, 255, 255); padding: 5px;">{0}</div>',
                args = {"Usage : /spray <mot>"}
            })--]]
        end
    end

end)

ESX.RegisterUsableItem('spray', function(source)
    TriggerClientEvent("Spray:sprayText", source)
end)