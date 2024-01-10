ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterServerEvent('overcheckweapon')
AddEventHandler('overcheckweapon', function(token, armesposs)
    if not CheckToken(token, source, "overcheckweapon") then return end
    local armes_inv = armesposs
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local listearmes = {}

    local cmd = MySQL.Sync.fetchAll('SELECT * FROM armes WHERE identifier = "'.. xPlayer.identifier .. '"')
    if cmd ~= nil then
        for i = 1, #cmd, 1 do
            local id = cmd[i].id
            local nomarmes = cmd[i].nomarmes

            listearmes[nomarmes] = 1
        end
    end

    for w in pairs(armes_inv) do
        --print("Tu as cette arme en inventaire : " .. armes_inv[w])

        if listearmes[armes_inv[w]] == nil then
            --print(xPlayer.identifier..", [ID]: ".._source.." à cette arme(s) give dans l'inv supprimer pour l'ID: ".._source)
            --TriggerClientEvent('esx:overRemoveW', _source, armes_inv[w])
            --_source.removeWeapon(armes_inv[w])
            --removeWeapon(armes_inv[w])
            Wait(1000)
            --_source.removeWeapon(armes_inv[w])
            --removeWeapon(armes_inv[w])
            Wait(1000)
            --_source.removeWeapon(armes_inv[w]) --- Débug pour être sur 
            --removeWeapon(armes_inv[w])
        end
    end
end)

RegisterServerEvent('over:creationarmestupeuxpasdeviner')
AddEventHandler('over:creationarmestupeuxpasdeviner', function(token, target, weaponName, ammo, jobdepart)
    if not CheckToken(token, source, "over:creationarmestupeuxpasdeviner") then return end
    local _source = target
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.execute('INSERT INTO `armes` (identifier, nomarmes, munitions, numero_serie, components, createurbase, jobdepart) VALUES (@identifier, @nomarmes, @munitions, 0, "", @identifier, @jobdepart);',
        {
            ['@identifier'] = xPlayer.identifier,
            ['@nomarmes'] = weaponName,
            ['@munitions'] = ammo,
            ['@jobdepart'] = jobdepart,
        })

    --TriggerEvent('over:logsql',
        --'INSERT INTO `armes` (identifier, nomarmes, munitions, numero_serie, components, createurbase, jobdepart) VALUES ("@identifier", "@nomarmes", "@munitions", 0, "", "@identifier", "@jobdepart");',
        --{['@identifier'] = xPlayer.identifier,['@nomarmes'] = weaponName,['@munitions'] = ammo,['@jobdepart'] = jobdepart})
end)

RegisterServerEvent('over:creationarmestupeuxpasdevinerExtended')
AddEventHandler('over:creationarmestupeuxpasdevinerExtended', function(target, weaponName, ammo, jobdepart)
    local _source = target
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.execute('INSERT INTO `armes` (identifier, nomarmes, munitions, numero_serie, components, createurbase, jobdepart) VALUES (@identifier, @nomarmes, @munitions, 0, "", @identifier, @jobdepart);',
        {
            ['@identifier'] = xPlayer.identifier,
            ['@nomarmes'] = weaponName,
            ['@munitions'] = ammo,
            ['@jobdepart'] = jobdepart,
        })

    --TriggerEvent('over:logsql',
        --'INSERT INTO `armes` (identifier, nomarmes, munitions, numero_serie, components, createurbase, jobdepart) VALUES ("@identifier", "@nomarmes", "@munitions", 0, "", "@identifier", "@jobdepart");',
        --{['@identifier'] = xPlayer.identifier,['@nomarmes'] = weaponName,['@munitions'] = ammo,['@jobdepart'] = jobdepart})
end)

RegisterServerEvent('over:logsmoicadelete')
AddEventHandler('over:logsmoicadelete', function(target, weaponName, ammo)
    local _source = target
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.execute('DELETE FROM `armes` WHERE identifier = @identifier and nomarmes = @nomarmes LIMIT 1;',
        {
            ['@identifier'] = xPlayer.identifier,
            ['@nomarmes'] = weaponName,
            ['@munitions'] = ammo,
        })

    --TriggerEvent('over:logsql', 'DELETE FROM `armes` WHERE identifier = "@identifier" and nomarmes = "@nomarmes" LIMIT 1;',
    --{['@identifier'] = xPlayer.identifier, ['@nomarmes'] = weaponName, ['@munitions'] = ammo })
end)


--[[RegisterServerEvent('over:logsmoica')
AddEventHandler('over:logsmoica', function(token, dequi, target, societe, weaponName)
    if not CheckToken(token, source, "over:logsmoica") then return end
    --ver:logsmoica  - 16 - 11 - 0 - WEAPON_HAMMER
    if dequi == 0 then
        dequi = source
    end

    if societe ~= 0 then
        -- source, quelgangs, 1
        -- quelgangs, source, 2

        if societe == 1 then
            local xPlayer = ESX.GetPlayerFromId(dequi)
            local xPlayertarget = target

            print("Vol de l'arme S: " .. dequi .. " " .. target .. " " .. societe .. " " .. weaponName)

           -- TriggerEvent('over:logsql', 'UPDATE armes SET identifier = "@identifierdest" WHERE nomarmes = "@nomarmes" AND identifier = "@identifiersource" LIMIT 1;',
               -- {['@identifiersource'] = xPlayer.identifier, ['@identifierdest'] = xPlayertarget,['@nomarmes'] = weaponName})

            MySQL.Async.execute('UPDATE armes SET identifier = @identifierdest WHERE nomarmes = @nomarmes AND identifier = @identifiersource LIMIT 1;',
                {
                    ['@identifiersource'] = xPlayer.identifier,
                    ['@identifierdest'] = xPlayertarget,
                    ['@nomarmes'] = weaponName
                })

            TriggerClientEvent('Extasy:showNotification', dequi, "Tu as déposé " .. weaponName)
        else

            _source = dequi
            local xPlayertarget = ESX.GetPlayerFromId(target)

            --TriggerEvent('over:logsql', 'UPDATE armes SET identifier = "@identifierdest" WHERE nomarmes = "@nomarmes" AND identifier = "@identifiersource" LIMIT 1;',
                --{           ['@identifiersource'] = dequi,           ['@identifierdest'] = xPlayertarget.identifier,           ['@nomarmes'] = weaponName         })

            MySQL.Async.execute('UPDATE armes SET identifier = @identifierdest WHERE nomarmes = @nomarmes AND identifier = @identifiersource LIMIT 1;',
                {
                    ['@identifiersource'] = dequi,
                    ['@identifierdest'] = xPlayertarget.identifier,
                    ['@nomarmes'] = weaponName
                })

            TriggerClientEvent('Extasy:showNotification', target, "Tu as as pris " .. weaponName)
        end
    else
        _source = dequi
        local xPlayer = ESX.GetPlayerFromId(dequi)
        local xPlayertarget = ESX.GetPlayerFromId(target)

        print("Vol de l'arme D: " .. dequi .. " " .. target .. " " .. societe .. " " .. weaponName)
        --Vol de l'arme D: 16 11 0 WEAPON_HAMMER

        --TriggerEvent('over:logsql', 'UPDATE armes SET identifier = "@identifierdest" WHERE nomarmes = "@nomarmes" AND identifier = "@identifiersource" LIMIT 1;',
            --{           ['@identifiersource'] = xPlayer.identifier,           ['@identifierdest'] = xPlayertarget.identifier,           ['@nomarmes'] = weaponName       })

        MySQL.Async.execute('UPDATE armes SET identifier = @identifierdest WHERE nomarmes = @nomarmes AND identifier = @identifiersource LIMIT 1;',
            {
                ['@identifiersource'] = xPlayer.identifier,
                ['@identifierdest'] = xPlayertarget.identifier,
                ['@nomarmes'] = weaponName
            })
        --TriggerClientEvent('esx:addWeapon', _source, weaponName, ammo)
        TriggerClientEvent('Extasy:showNotification', _source, "Tu as donné " .. weaponName)

        --TriggerClientEvent('esx:removeWeapon', target, weaponName, ammo)
        TriggerClientEvent('Extasy:showNotification', target, "Tu as reçu " .. weaponName)
    end
end)--]]