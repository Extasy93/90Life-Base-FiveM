ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Extasy:getUsergroup', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()
    cb(group)
end)

RegisterServerEvent('Extasy:Weapon_addAmmoToPedS')
AddEventHandler('Extasy:Weapon_addAmmoToPedS', function(token, plyId, value, quantity)
	if not CheckToken(token, source, "Extasy:Weapon_addAmmoToPedS") then return end
	if #(GetEntityCoords(source, false) - GetEntityCoords(plyId, false)) <= 3.0 then
		TriggerClientEvent('Extasy:Weapon_addAmmoToPedC', plyId, value, quantity)
	end
end)


ESX.RegisterServerCallback('ExtasyReportMenu:GetReport', function(source, cb)
    local xPlayer  = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = '".. xPlayer.identifier .."'", {}, function (result)
            if result[1] then
                cb(result[1].report)
            else
                return
            end
            --print(result[1].report)
        end)
    end
end)

RegisterServerEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
	local _source = source

	if type == 'item_standard' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent('Extasy:showNotification', _source, 'quantitée invalide')
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				TriggerClientEvent('Extasy:showNotification', _source, 'quantitée invalide')
			else
				xPlayer.removeInventoryItem(itemName, itemCount)

				local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(xItem.label, itemCount)
				ESX.CreatePickup('item_standard', itemName, itemCount, pickupLabel, _source)
				TriggerClientEvent('Extasy:showAdvancedNotification', _source, "Personel", "Inventaire", "Vous avez jeter ~g~" ..itemCount.." ~s~" ..xItem.label, "CHAR_ARTHUR", 1)
			end
		end

	elseif type == 'item_money' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent('Extasy:showNotification', _source, 'quantitée invalide')
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local playerCash = xPlayer.getMoney()

			if (itemCount > playerCash or playerCash < 1) then
				TriggerClientEvent('Extasy:showNotification', _source, 'quantitée invalide')
			else
				xPlayer.removeMoney(itemCount)

				local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format('money'.. 'x' ..ESX.Math.GroupDigits(itemCount))
				ESX.CreatePickup('item_money', 'money', itemCount, pickupLabel, _source)
				TriggerClientEvent('Extasy:showNotification', _source, 'tu a dorp :' ..ESX.Math.GroupDigits(itemCount))
			end
		end

	elseif type == 'item_account' then

		if itemCount == nil or itemCount < 1 then
			TriggerClientEvent('Extasy:showNotification', _source, 'quantitée invalide')
		else
			local xPlayer = ESX.GetPlayerFromId(source)
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				TriggerClientEvent('Extasy:showNotification', _source, 'quantitée invalide')
			else
				xPlayer.removeAccountMoney(itemName, itemCount)

				local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(account.label.. 'x' ..ESX.Math.GroupDigits(itemCount))
				ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, _source)
				TriggerClientEvent('Extasy:showNotification', _source, 'tu a dorp :' ..ESX.Math.GroupDigits(itemCount), string.lower(account.label))
			end
		end

	elseif type == 'item_weapon' then

		local xPlayer = ESX.GetPlayerFromId(source)
		local loadout = xPlayer.getLoadout()

		for i=1, #loadout, 1 do
			if loadout[i].name == itemName then
				itemCount = loadout[i].ammo
				break
			end
		end

		if xPlayer.hasWeapon(itemName) then
			local weaponLabel, weaponPickup = ESX.GetWeaponLabel(itemName), 'PICKUP_' .. string.upper(itemName)

			xPlayer.removeWeapon(itemName)

			if itemCount > 0 then
				TriggerClientEvent('esx:pickupWeapon', _source, weaponPickup, itemName, itemCount)
				TriggerClientEvent('Extasy:showAdvancedNotification', _source, "Personel", "Inventaire", "Vous avez jeter: ~g~" ..weaponLabel.."~s~ avec ~b~" ..itemCount.. "~s~ Balles", "CHAR_ARTHUR", 1)
			else
				-- workaround for CreateAmbientPickup() giving 30 rounds of ammo when you drop the weapon with 0 ammo
				TriggerClientEvent('esx:pickupWeapon', _source, weaponPickup, itemName, 1)
				TriggerClientEvent('Extasy:showNotification', _source, 'Vous avez jeter ' ..weaponLabel)
			end
		end

	end
end)

RegisterServerEvent('Extasy:GetReport')
AddEventHandler("Extasy:GetReport", function(token, src)
	if not CheckToken(token, source, "Extasy:GetReport") then return end
	local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll('SELECT report FROM users WHERE identifier=@identifier', {

        ['@identifier'] = xPlayer.getIdentifier()

    }, function(result)

		if (result[1] ~= nil) then
			TriggerClientEvent("Extasy:UpdateReport", src, result[1].report)
		end
    end)
end)

ESX.RegisterServerCallback('Extasy:billing', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bills = {}

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for i = 1, #result, 1 do
			table.insert(bills, {
				id = result[i].id,
				label = result[i].label,
				amount = result[i].amount
			})
		end

		cb(bills)
	end)
end)

function getMaximumGrade(jobname)
	local queryDone, queryResult = false, nil

	MySQL.Async.fetchAll('SELECT * FROM job_grades WHERE job_name = @jobname ORDER BY `grade` DESC ;', {
		['@jobname'] = jobname
	}, function(result)
		queryDone, queryResult = true, result
	end)

	while not queryDone do
		Citizen.Wait(10)
	end

	if queryResult[1] then
		return queryResult[1].grade
	end

	return nil
end



RegisterServerEvent('job:set')
AddEventHandler('job:set', function(token, job, grade)
	if not CheckToken(token, source, "job:set") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob(job, 0)	
end)

RegisterServerEvent('job2:set')
AddEventHandler('job2:set', function(token, job2, grade)
	if not CheckToken(token, source, "job2:set") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob2(job2, 0)	
end)

 RegisterServerEvent('Extasy:Boss_promouvoirplayer')
 AddEventHandler('Extasy:Boss_promouvoirplayer', function(token, target)
	if not CheckToken(token, source, "Extasy:Boss_promouvoirplayer") then return end
 	local sourceXPlayer = ESX.GetPlayerFromId(source)
 	local targetXPlayer = ESX.GetPlayerFromId(target)

 	if (targetXPlayer.job.grade == tonumber(getMaximumGrade(sourceXPlayer.job.name)) - 1) then
 		TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous devez demander une autorisation du ~r~Gouvernement~w~.')
 	else
 		if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
 			targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) + 1)

 			TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous avez ~g~promu ' .. targetXPlayer.name .. '~w~.')
 			TriggerClientEvent('Extasy:showNotification', target, 'Vous avez été ~g~promu par ' .. sourceXPlayer.name .. '~w~.')
 		else
 			TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
 		end
 	end
 end)

 RegisterServerEvent('Extasy:Boss_destituerplayer')
 AddEventHandler('Extasy:Boss_destituerplayer', function(token, target)
	if not CheckToken(token, source, "Extasy:Boss_destituerplayer") then return end
 	local sourceXPlayer = ESX.GetPlayerFromId(source)
 	local targetXPlayer = ESX.GetPlayerFromId(target)

 	if (targetXPlayer.job.grade == 0) then
 		TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous ne pouvez pas ~r~rétrograder~w~ davantage.')
 	else
 		if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
 			targetXPlayer.setJob(targetXPlayer.job.name, tonumber(targetXPlayer.job.grade) - 1)

 			TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous avez ~r~rétrogradé ' .. targetXPlayer.name .. '~w~.')
 			TriggerClientEvent('Extasy:showNotification', target, 'Vous avez été ~r~rétrogradé par ' .. sourceXPlayer.name .. '~w~.')
 		else
 			TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
 		end
 	end
 end)

RegisterServerEvent('Extasy:Boss_recruterplayer')
AddEventHandler('Extasy:Boss_recruterplayer', function(token, target, job, grade)
	if not CheckToken(token, source, "Extasy:Boss_recruterplayer") then return end
	local sourceXPlayer = ESX.GetPlayerFromId(source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.grade_name == 'boss' then
		targetXPlayer.setJob(job, grade)
		TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous avez ~g~recruté ' .. targetXPlayer.name .. '~w~.')
		TriggerClientEvent('Extasy:showNotification', target, 'Vous avez été ~g~embauché par ' .. sourceXPlayer.name .. '~w~.')
	end
end)

RegisterServerEvent('Extasy:Boss_recruterplayer2')
AddEventHandler('Extasy:Boss_recruterplayer2', function(token, target, job2, grade)
	if not CheckToken(token, source, "Extasy:Boss_recruterplayer2") then return end
local sourceXPlayer = ESX.GetPlayerFromId(source)
local targetXPlayer = ESX.GetPlayerFromId(target)

if sourceXPlayer.job2.grade_name == 'boss' then
	targetXPlayer.setJob2(job2, grade)
	TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous avez ~g~recruté ' .. targetXPlayer.name .. '~w~.')
	TriggerClientEvent('Extasy:showNotification', target, 'Vous avez été ~g~embauché par ' .. sourceXPlayer.name .. '~w~.')
end
end)

RegisterServerEvent('Extasy:Boss_virerplayer')
 AddEventHandler('Extasy:Boss_virerplayer', function(token, target)
	if not CheckToken(token, source, "Extasy:Boss_virerplayer") then return end
 	local sourceXPlayer = ESX.GetPlayerFromId(source)
 	local targetXPlayer = ESX.GetPlayerFromId(target)

 	if sourceXPlayer.job.grade_name == 'boss' and sourceXPlayer.job.name == targetXPlayer.job.name then
 		targetXPlayer.setJob('unemployed', 0)
 		TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous avez ~r~viré ' .. targetXPlayer.name .. '~w~.')
 		TriggerClientEvent('Extasy:showNotification', target, 'Vous avez été ~g~viré par ' .. sourceXPlayer.name .. '~w~.')
 	else
 		TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
 	end
end)

RegisterServerEvent('Extasy:Boss_virerplayer2')
 AddEventHandler('Extasy:Boss_virerplayer2', function(token, target)
	if not CheckToken(token, source, "Extasy:Boss_virerplayer2") then return end
 	local sourceXPlayer = ESX.GetPlayerFromId(source)
 	local targetXPlayer = ESX.GetPlayerFromId(target)

 	if sourceXPlayer.job2.grade_name == 'boss' and sourceXPlayer.job2.name == targetXPlayer.job2.name then
 		targetXPlayer.setJob2('unemployed2', 0)
 		TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous avez ~r~viré ' .. targetXPlayer.name .. '~w~.')
 		TriggerClientEvent('Extasy:showNotification', target, 'Vous avez été ~g~viré par ' .. sourceXPlayer.name .. '~w~.')
 	else
 		TriggerClientEvent('Extasy:showNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
 	end
end)

--------------------- SIM


ESX.RegisterServerCallback('get:sim', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local keys = {}

	MySQL.Async.fetchAll('SELECT * FROM sim WHERE identifier = @owner', {
        ['@owner'] = xPlayer.identifier
    },
        function(result)
        for sim = 1, #result, 1 do
            table.insert(keys, {
				id = result[sim].id,
				identifier = result[sim].identifier,
				number = result[sim].number,
				label = result[sim].label,
            })
        end
        cb(keys)
    end)
end)

--------------------- Clé(s)

ESX.RegisterServerCallback('get:key', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local keyss = {}

	MySQL.Async.fetchAll('SELECT * FROM open_car WHERE owner = @owner', {
        ['@owner'] = xPlayer.identifier
    },
        function(result)
        for key = 1, #result, 1 do
            table.insert(keyss, {
				id = result[key].id,
				identifier = result[key].identifier,
				label = result[key].label,
				value = result[key].value,
				got = result[key].got,
				NB = result[key].NB,
            })
        end
        cb(keyss)
    end)
end)

RegisterNetEvent("Extasy:deleteEntityOne")
AddEventHandler("EExtasy:deleteEntityOne", function(token, list)
	if not CheckToken(token, source, "Extasy:deleteEntityOne") then return end
    local entity = NetworkGetEntityFromNetworkId(list)
    Citizen.InvokeNative("DELETE_ENTITY" & 0xFFFFFFFF, entity)
end) 

RegisterNetEvent("Extasy:KickPlayer")
AddEventHandler("Extasy:KickPlayer", function(token, target, reason)
	if not CheckToken(token, source, "Extasy:KickPlayer") then return end
    DropPlayer(target, reason)
end)