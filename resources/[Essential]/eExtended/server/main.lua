RegisterNetEvent('esx:onPlayerJoined')
AddEventHandler('esx:onPlayerJoined', function()
	if not ESX.Players[source] then
		onPlayerJoined(source)
	end
end)

onPlayerJoined = function(playerId)
	SetMapName('Vice City')
	
	local identifier
	local license
	
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, Config.PrimaryIdentifier) then
			identifier = v
		end
		if string.match(v, 'license:') then
			license = v
		end
	end

	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			print(playerId, ('il y a eu une erreur de chargement de votre personnage !\nCode d\'erreur: identifier-active-ingame\n\nCette erreur est causée par un joueur sur ce serveur qui a le même identifiant que vous. Assurez-vous que vous ne jouez pas sur le même compte Rockstar.\n\nVotre identifiant Rockstar: %s'):format(identifier))
		else
			MySQL.Async.fetchScalar('SELECT 1 FROM users WHERE identifier = @identifier', {
				['@identifier'] = identifier
			}, function(result)
				if result then
					loadESXPlayer(identifier, playerId)
				else
					local accounts = {}

					for account,money in pairs(Config.StartingAccountMoney) do
						accounts[account] = money
					end

					MySQL.Async.execute('INSERT INTO users (accounts, identifier, license) VALUES (@accounts, @identifier, @license)', {
						['@accounts'] = json.encode(accounts),
						['@identifier'] = identifier,
						['@license'] = license,						
					}, function(rowsChanged)
						loadESXPlayer(identifier, playerId)
					end)
				end
			end)
		end
	else
		print(playerId, 'il y a eu une erreur de chargement de votre personnage !\nCode d\'erreur: identifier-missing-ingame\n\nLa cause de cette erreur n\'est pas connue, votre identifiant n\'a pas pu être trouvé. Veuillez revenir plus tard ou signaler ce problème à l\'équipe d\'administration du serveur.')
	end
end

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	deferrals.defer()
	local playerId, identifier = source
	Wait(100)

	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, Config.PrimaryIdentifier) then
			identifier = v
			break
		end
	end

	if not ExM.DatabaseReady then
		deferrals.update("La base de données n'est pas initialisée. Contacter Le fondateur du serveur Extasy#0093 ou veuillez patienter...")
		while not ExM.DatabaseReady do
			Wait(1000)
		end
	end

	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			deferrals.done(('Il y a eu une erreur lors du chargement de votre personnage !\nCode Erreur: identifier-active\n\nCette erreur est causée par un joueur sur ce serveur qui a le même identifiant que vous. Assurez-vous que vous ne jouez pas sur le même compte Rockstar.\n\nVotre identifiant Rockstar: %s'):format(identifier))
		else
			deferrals.done()
		end
	else
		deferrals.done('Il y a eu une erreur lors du chargement de votre personnage !\nCode Erreur: identifier-missing\n\nLa cause de cette erreur n\'est pas connue, votre identifiant n\'a pas pu être trouvé. Veuillez revenir plus tard ou signaler ce problème à l\'équipe d\'administration du serveur.')
	end
end)


function loadESXPlayer(identifier, playerId)
	-- TODO: Implement other loading methods
	
	local userData = {
		accounts = {},
		inventory = {},
		job = {},
		job2 = {},
		loadout = {},
		playerName = GetPlayerName(playerId),
		weight = 0
	}

	MySQL.Async.fetchAll('SELECT accounts, job, job_grade, job2, job2_grade, `group`, loadout, position, inventory FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		local job, grade, jobObject, gradeObject = result[1].job, tostring(result[1].job_grade)
		local job2, grade2, job2Object, grade2Object = result[1].job2, tostring(result[1].job2_grade)
		local foundAccounts, foundItems = {}, {}

		-- Accounts
		if result[1].accounts and result[1].accounts ~= '' then
			local accounts = json.decode(result[1].accounts)

			for account,money in pairs(accounts) do
				foundAccounts[account] = money
			end
		end

		for account,label in pairs(Config.Accounts) do
			table.insert(userData.accounts, {
				name = account,
				money = foundAccounts[account] or Config.StartingAccountMoney[account] or 0,
				label = label
			})
		end

		-- Job
		if ESX.DoesJobExist(job, grade) then
			jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
		else
			print(('[ExtendedMode] [^3WARNING^7] Ignorer le job invalide pour %s [job: %s, grade: %s]'):format(identifier, job, grade))
			job, grade = 'unemployed', '0'
			jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
		end

		userData.job.id = jobObject.id
		userData.job.name = jobObject.name
		userData.job.label = jobObject.label

		userData.job.grade = tonumber(grade)
		userData.job.grade_name = gradeObject.name
		userData.job.grade_label = gradeObject.label
		userData.job.grade_salary = gradeObject.salary

		userData.job.skin_male = {}
		userData.job.skin_female = {}

		if gradeObject.skin_male then userData.job.skin_male = json.decode(gradeObject.skin_male) end
		if gradeObject.skin_female then userData.job.skin_female = json.decode(gradeObject.skin_female) end

		-- Job2
		if ESX.DoesJobExist(job2, grade2) then
			job2Object, grade2Object = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade2]
		else
			print(('[eExtended] [^3WARNING^7] Ignorer le job2 invalide pour %s [job2: %s, grade2: %s]'):format(identifier, job2, grade2))
			job2, grade2 = 'unemployed2', '0'
			job2Object, grade2Object = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade2]
		end

		userData.job2.id = job2Object.id
		userData.job2.name = job2Object.name
		userData.job2.label = job2Object.label

		userData.job2.grade = tonumber(grade2)
		userData.job2.grade_name = grade2Object.name
		userData.job2.grade_label = grade2Object.label
		userData.job2.grade_salary = grade2Object.salary

		userData.job2.skin_male = {}
		userData.job2.skin_female = {}

		if grade2Object.skin_male then userData.job2.skin_male = json.decode(grade2Object.skin_male) end
		if grade2Object.skin_female then userData.job2.skin_female = json.decode(grade2Object.skin_female) end

		-- Inventory
		if result[1].inventory and result[1].inventory ~= '' then
			local inventory = json.decode(result[1].inventory)

			for name,count in pairs(inventory) do
				local item = ESX.Items[name]

				if item then
					foundItems[name] = count
				else
					print(('[ExtendedMode] [^3WARNING^7] Ignorer un item non valable "%s" pour "%s"'):format(name, identifier))
				end
			end
		end

		for name,item in pairs(ESX.Items) do
			local count = foundItems[name] or 0
			if count > 0 then userData.weight = userData.weight + (item.weight * count) end

			if(count > 0)then
				table.insert(userData.inventory, {
					name = name,
					count = count,
					label = item.label,
					weight = item.weight,
					limit = item.limit,
					usable = ESX.UsableItemsCallbacks[name] ~= nil,
					rare = item.rare,
					canRemove = item.canRemove
				})
			end
		end

		table.sort(userData.inventory, function(a, b)
			return a.label < b.label
		end)

		-- Group
		if result[1].group then
			userData.group = result[1].group
		else
			userData.group = 'user'
		end

		-- Loadout
		if result[1].loadout and result[1].loadout ~= '' then
			local loadout = json.decode(result[1].loadout)

			for name,weapon in pairs(loadout) do
				local label = ESX.GetWeaponLabel(name)

				if label then
					if not weapon.components then weapon.components = {} end
					if not weapon.tintIndex then weapon.tintIndex = 0 end

					table.insert(userData.loadout, {
						name = name,
						ammo = weapon.ammo,
						label = label,
						components = weapon.components,
						tintIndex = weapon.tintIndex
					})
				end
			end
		end

		-- Position
		if result[1].position and result[1].position ~= '' then
			userData.coords = json.decode(result[1].position)
		else
			userData.coords = Config.FirstSpawnCoords
		end

		-- Create Extended Player Object
		local xPlayer = CreateExtendedPlayer(playerId, identifier, userData.group, userData.accounts, userData.inventory, userData.weight, userData.job, userData.job2, userData.loadout, userData.playerName, userData.coords)
		ESX.Players[playerId] = xPlayer
		TriggerEvent('esx:playerLoaded', playerId, xPlayer)

		xPlayer.triggerEvent('esx:playerLoaded', {
			accounts = xPlayer.getAccounts(),
			coords = xPlayer.getCoords(),
			identifier = xPlayer.getIdentifier(),
			inventory = xPlayer.getInventory(),
			job = xPlayer.getJob(),
			job2 = xPlayer.getJob2(),
			loadout = xPlayer.getLoadout(),
			maxWeight = xPlayer.maxWeight,
			money = xPlayer.getMoney()
		})

		xPlayer.triggerEvent('esx:createMissingPickups', ESX.Pickups)
		xPlayer.triggerEvent('esx:registerSuggestions', ESX.RegisteredCommands)
	end)
end

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		TriggerEvent('esx:playerDropped', playerId, reason)

		ESX.SavePlayer(xPlayer, function()
			ESX.Players[playerId] = nil
		end)
	end
end)

RegisterNetEvent('esx:updateCoords')
AddEventHandler('esx:updateCoords', function(coords)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateCoords(coords)
	end
end)

RegisterNetEvent('esx:updateWeaponAmmo')
AddEventHandler('esx:updateWeaponAmmo', function(weaponName, ammoCount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateWeaponAmmo(weaponName, ammoCount)
	end
end)

RegisterNetEvent('esx:donneItem')
AddEventHandler('esx:donneItem', function(target, type, itemName, itemCount)
	local playerId = source
	local _source = source
	local _target = target
	local sourceXPlayer = ESX.GetPlayerFromId(playerId)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if type == 'item_standard' then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		local targetItem = targetXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if targetXPlayer.canCarryItem(itemName, itemCount) then
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem   (itemName, itemCount)

				sourceXPlayer.showNotification(_U('gave_item', itemCount, sourceItem.label, targetXPlayer.name))
				targetXPlayer.showNotification(_U('received_item', itemCount, sourceItem.label, sourceXPlayer.name))
				TriggerEvent("eGiveitemalert",sourceXPlayer.name,targetXPlayer.name,ESX.Items[itemName].label,itemCount) 
			else
				sourceXPlayer.showNotification(_U('ex_inv_lim', targetXPlayer.name))
			end
		else
			sourceXPlayer.showNotification(_U('imp_invalid_quantity'))
		end
	elseif type == 'item_account' then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney   (itemName, itemCount)

			sourceXPlayer.showNotification(_U('gave_account_money', ESX.Math.GroupDigits(itemCount), Config.Accounts[itemName], targetXPlayer.name))
			targetXPlayer.showNotification(_U('received_account_money', ESX.Math.GroupDigits(itemCount), Config.Accounts[itemName], sourceXPlayer.name))
			if itemCount > 10000 then
				TriggerEvent("eGivemoneyalert",sourceXPlayer.name,targetXPlayer.name,itemCount)
			end 
		else
			sourceXPlayer.showNotification(_U('imp_invalid_amount'))
		end
	elseif type == 'item_weapon' then
		if sourceXPlayer.hasWeapon(itemName) then
			local weaponLabel = ESX.GetWeaponLabel(itemName)

			if not targetXPlayer.hasWeapon(itemName) then
				local _, weapon = sourceXPlayer.getWeapon(itemName)
				local _, weaponObject = ESX.GetWeapon(itemName)
				itemCount = weapon.ammo

				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)
				TriggerEvent("over:logsmoicadelete", source, itemName, itemCount)
                TriggerEvent("over:creationarmestupeuxpasdevinerExtended", target, itemName, itemCount, "Depuis l'inventaire'")

				if weaponObject.ammo and itemCount > 0 then
					local ammoLabel = weaponObject.ammo.label
					sourceXPlayer.showNotification(_U('gave_weapon_withammo', weaponLabel, itemCount, ammoLabel, targetXPlayer.name))
					targetXPlayer.showNotification(_U('received_weapon_withammo', weaponLabel, itemCount, ammoLabel, sourceXPlayer.name))
				else
					sourceXPlayer.showNotification(_U('gave_weapon', weaponLabel, targetXPlayer.name))
					targetXPlayer.showNotification(_U('received_weapon', weaponLabel, sourceXPlayer.name))
					TriggerEvent("eGiveweaponalert",sourceXPlayer.name,targetXPlayer.name,weaponLabel) 
				end
			else
				sourceXPlayer.showNotification(_U('gave_weapon_hasalready', targetXPlayer.name, weaponLabel))
				targetXPlayer.showNotification(_U('received_weapon_hasalready', sourceXPlayer.name, weaponLabel))
			end
		end
	elseif type == 'item_ammo' then
		if sourceXPlayer.hasWeapon(itemName) then
			local weaponNum, weapon = sourceXPlayer.getWeapon(itemName)

			if targetXPlayer.hasWeapon(itemName) then
				local _, weaponObject = ESX.GetWeapon(itemName)

				if weaponObject.ammo then
					local ammoLabel = weaponObject.ammo.label

					if weapon.ammo >= itemCount then
						sourceXPlayer.removeWeaponAmmo(itemName, itemCount)
						targetXPlayer.addWeaponAmmo(itemName, itemCount)

						sourceXPlayer.showNotification(_U('gave_weapon_ammo', itemCount, ammoLabel, weapon.label, targetXPlayer.name))
						targetXPlayer.showNotification(_U('received_weapon_ammo', itemCount, ammoLabel, weapon.label, sourceXPlayer.name))
					end
				end
			else
				sourceXPlayer.showNotification(_U('gave_weapon_noweapon', targetXPlayer.name))
				targetXPlayer.showNotification(_U('received_weapon_noweapon', sourceXPlayer.name, weapon.label))
			end
		end
	end
end)

RegisterServerEvent('esx:lynxtmort')
AddEventHandler('esx:lynxtmort', function()
	local xPlayer  = ESX.GetPlayerFromId(source)
	--DropPlayer(source, _U('drop_player_blcars_notification')..Config.Discord)
	bandata = {}
	bandata.period = '0' -- days, 0 for permanent
	TriggerEvent('Anticheat:AutoBan', source, bandata)
	TriggerEvent("BanSql:ICheat", "Vous êtes expulsé. si vous pensez que c\'est une erreur, demandez à un staff. Code de ban : Extasy69", source)
	DropPlayer(source, 'Vous êtes expulsé. si vous pensez que c\'est une erreur, demandez en radio à un staff. Code de ban : Brouette69')
end)

RegisterNetEvent('esx:retirerItem')
AddEventHandler('esx:retirerItem', function(type, itemName, itemCount)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if type == 'item_standard' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showNotification(_U('imp_invalid_quantity'))
		else
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				xPlayer.showNotification(_U('imp_invalid_quantity'))
			else
				xPlayer.removeInventoryItem(itemName, itemCount)
				local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(xItem.label, itemCount)
				ESX.CreatePickup('item_standard', itemName, itemCount, pickupLabel, playerId)
				xPlayer.showNotification(_U('threw_standard', itemCount, xItem.label))
			end
		end
	elseif type == 'item_account' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showNotification(_U('imp_invalid_amount'))
		else
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				xPlayer.showNotification(_U('imp_invalid_amount'))
			else
				xPlayer.removeAccountMoney(itemName, itemCount)
				local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(account.label, _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
				ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, playerId)
				xPlayer.showNotification(_U('threw_account', ESX.Math.GroupDigits(itemCount), string.lower(account.label)))
			end
		end
	elseif type == 'item_weapon' then
		itemName = string.upper(itemName)

		if xPlayer.hasWeapon(itemName) then
			local _, weapon = xPlayer.getWeapon(itemName)
			local _, weaponObject = ESX.GetWeapon(itemName)
			local pickupLabel

			xPlayer.removeWeapon(itemName)

			TriggerServerEvent("over:logsmoicadelete", _source, itemName, 0)

			if weaponObject.ammo and weapon.ammo > 0 then
				local ammoLabel = weaponObject.ammo.label
				pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(weapon.label, weapon.ammo)
				xPlayer.showNotification(_U('threw_weapon_ammo', weapon.label, weapon.ammo, ammoLabel))
			else
				pickupLabel = ('~y~%s~s~'):format(weapon.label)
				xPlayer.showNotification(_U('threw_weapon', weapon.label))
			end

			ESX.CreatePickup('item_weapon', itemName, weapon.ammo, pickupLabel, playerId, weapon.components, weapon.tintIndex)
		end
	end
end)

RegisterNetEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local count = xPlayer.getInventoryItem(itemName).count

	if count > 0 then
		ESX.UseItem(source, itemName)
	else
		xPlayer.showNotification(_U('act_imp'))
	end
end)

RegisterNetEvent('esx:onPickup')
AddEventHandler('esx:onPickup', function(id)
	local pickup, xPlayer, success = ESX.Pickups[id], ESX.GetPlayerFromId(source)
	local _source = source
	local _target = target
	if pickup then
		if pickup.type == 'item_standard' then
			if xPlayer.canCarryItem(pickup.name, pickup.count) then
				xPlayer.addInventoryItem(pickup.name, pickup.count)
				success = true
			else
				xPlayer.showNotification(_U('threw_cannot_pickup'))
			end
		elseif pickup.type == 'item_account' then
			success = true
			xPlayer.addAccountMoney(pickup.name, pickup.count)
		elseif pickup.type == 'item_weapon' then
			if xPlayer.hasWeapon(pickup.name) then
				xPlayer.showNotification(_U('threw_weapon_already'))
			else
				success = true
				xPlayer.addWeapon(pickup.name, pickup.count)
				--TriggerEvent("over:logsmoica", _source, _source, 0, itemName) -- Non fonctionel
				xPlayer.setWeaponTint(pickup.name, pickup.tintIndex)

				for k,v in ipairs(pickup.components) do
					xPlayer.addWeaponComponent(pickup.name, v)
				end
			end
		end

		if success then
			ESX.Pickups[id] = nil
			TriggerClientEvent('esx:removePickup', -1, id)
		end
	end
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		loadout      = xPlayer.getLoadout(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		loadout      = xPlayer.getLoadout(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:getPlayerNames', function(source, cb, players)
	players[source] = nil

	for playerId,v in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer then
			players[playerId] = xPlayer.getName()
		else
			players[playerId] = nil
		end
	end

	cb(players)
end)

-- Add support for EssentialMode >6.4.x
AddEventHandler("es:setMoney", function(user, value) ESX.GetPlayerFromId(user).setMoney(value, true) end)
AddEventHandler("es:addMoney", function(user, value) ESX.GetPlayerFromId(user).addMoney(value, true) end)
AddEventHandler("es:removeMoney", function(user, value) ESX.GetPlayerFromId(user).removeMoney(value, true) end)
AddEventHandler("es:set", function(user, key, value) ESX.GetPlayerFromId(user).set(key, value, true) end)

AddEventHandler("es_db:doesUserExist", function(identifier, cb)
	cb(true)
end)

AddEventHandler('es_db:retrieveUser', function(identifier, cb, tries)
	tries = tries or 0

	if(tries < 500)then
		tries = tries + 1
		local player = ESX.GetPlayerFromIdentifier(identifier)

		if player then
			cb({money = player.getMoney(), bank = 0, identifier = player.identifier, license = player.get("license"), group = player.group, roles = ""}, false, true)
		else
			Citizen.SetTimeout(100, function()
				TriggerEvent("es_db:retrieveUser", identifier, cb, tries)
			end)
		end
	end
end)
