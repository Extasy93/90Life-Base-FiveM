local ESX
orgTable = {}
labelTable = {}

TriggerEvent("ext:getSharedObject", function(obj)
    ESX = obj
	
	Wait(5000)

	MySQL.Async.fetchAll("SELECT * FROM gangs", {}, function(result)
        for k,v in pairs(result) do
            orgTable[v.orgName] = {orgInventory = json.decode(v.orgInventory)}
        end
    end)
	MySQL.Async.fetchAll("SELECT name,label FROM items", {}, function(result)
        for k,v in pairs(result) do
            labelTable[v.name] = v.label
        end
    end)
end)

RegisterServerEvent('Org:createNewOrg')
AddEventHandler('Org:createNewOrg', function(token, gang)
	if not CheckToken(token, source, "Org:createNewOrg") then return end

	MySQL.Async.execute([[
INSERT INTO `addon_account` (name, label, shared) VALUES (@society, @orgLabel, 1);
INSERT INTO `datastore` (name, label, shared) VALUES (@society, @orgLabel, 1);
INSERT INTO `addon_inventory` (name, label, shared) VALUES (@society, @orgLabel, 1);
INSERT INTO `jobs` (`name`, `label`) VALUES (@orgName, @orgLabel);
INSERT INTO `gangs` (orgName, orgLabel, society, orgBoss, orgGarage, orgVehicles, orgChest, orgInventory, orgMoney, orgGSpawn, orgWear, orgGDelete, orgChestCapacity) VALUES (@orgName, @orgLabel, @society, @orgBoss, @orgGarage, @orgVehicles, @orgChest, @orgInventory, @orgMoney, @orgGSpawn, @orgWear, @orgGDelete, @orgChestCapacity);
INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `skin_male`, `skin_female`) VALUES
	(@orgName, 0, 'rookie', 'Associé', '{}', '{}'),
	(@orgName, 1, 'member', 'Soldat', '{}', '{}'),
	(@orgName, 2, 'elite', 'Elite', '{}', '{}'),
	(@orgName, 3, 'lieutenant', 'Lieutenant', '{}', '{}'),
	(@orgName, 4, 'viceboss', 'Bras Droit', '{}', '{}'),
	(@orgName, 5, 'boss', 'Patron', '{}', '{}')
;
	]], {
		['orgName'] = gang.orgName,
		['orgLabel'] = gang.orgLabel,
		['society'] = 'society_' .. gang.orgName,
        ['orgBoss'] = json.encode(gang.orgBoss),
        ['orgGarage'] = json.encode(gang.orgGarage),
		['orgVehicles'] = json.encode(gang.orgVehicles),
        ['orgChest'] = json.encode(gang.orgChest),
		['orgGSpawn'] = json.encode(gang.orgGSpawn),
		['orgWear'] = json.encode(gang.orgWear),
		['orgGDelete'] = json.encode(gang.orgGDelete),
		['orgInventory'] = '[]',
		['orgChestCapacity'] = 100,
		['orgMoney'] = 0,
	}, function(rowsChanged)
	end)
	print('Nouveau gang enregistrer : '..gang.orgLabel);
end)

RegisterServerEvent('org:DeleteThisOrg')
AddEventHandler('org:DeleteThisOrg', function(token, gang)
	if not CheckToken(token, source, "Org:DeleteThisOrg") then return end

	GangDeleteorg = "society_"..gang
	GangDeleteName = gang
	MySQL.Async.execute('DELETE FROM addon_account WHERE label = @gangLabel', {['@gangLabel']  = GangDeleteName}, function(rowsChanged)
	end)
	MySQL.Async.execute('DELETE FROM addon_account_data WHERE account_name = @gangLabel', {['@gangLabel']  = GangDeleteorg}, function(rowsChanged)
	end)
	MySQL.Async.execute('DELETE FROM datastore WHERE label = @gangLabel', {['@gangLabel']  = GangDeleteName}, function(rowsChanged)
	end)
	MySQL.Async.execute('DELETE FROM addon_inventory WHERE label = @gangLabel', {['@gangLabel']  = GangDeleteName}, function(rowsChanged)
	end)
	MySQL.Async.execute('DELETE FROM jobs WHERE label = @gangLabel', {['@gangLabel']  = GangDeleteName}, function(rowsChanged)
	end)
	MySQL.Async.execute('DELETE FROM gangs WHERE orgLabel = @gangLabel', {['@gangLabel']  = GangDeleteName}, function(rowsChanged)
	end)
	MySQL.Async.execute('DELETE FROM job_grades WHERE job_name = @gangLabel', {['@gangLabel']  = GangDeleteName}, function(rowsChanged)
	end)

	print('Gang : '..gang..' a été supprimer')
end)

RegisterServerEvent('Org:getGangData')
AddEventHandler('Org:getGangData', function(token, gangName)
	if not CheckToken(token, source, "Org:getGangData") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local MyOrgData = {}
	
	MySQL.Async.fetchAll("SELECT name,label FROM items", {}, function(result)
        for k,v in pairs(result) do
            labelTable[v.name] = v.label
        end
    end)

    MySQL.Async.fetchAll("SELECT * FROM gangs WHERE orgName = @orgName", {['@orgName'] = gangName}, function(result)
        for _, v in pairs(result) do
            MyOrgData = {
				orgName = v.orgName,
				orgLabel = v.orgLabel,
				org = v.society,
				orgBoss = v.orgBoss,
				orgGarage = v.orgGarage,
				orgVehicles = v.orgVehicles,
				orgChest = v.orgChest,
				orgGSpawn = v.orgGSpawn,
				orgWear = v.orgWear,
				orgGDelete = v.orgGDelete,
				orgActivity = v.orgActivity,
				orgChestCapacity = v.orgChestCapacity,
			}
        end
		TriggerClientEvent("Org:sendGangData", _source, MyOrgData, labelTable)
    end)
end)

RegisterServerEvent('Org:getGangDataForManage')
AddEventHandler('Org:getGangDataForManage', function(token)
	if not CheckToken(token, source, "Org:getGangDataForManage") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local OrgData = {}

    MySQL.Async.fetchAll("SELECT * FROM gangs", {}, function(result)
        for _, v in pairs(result) do
			table.insert(OrgData, {
				orgName = v.orgName,
				orgLabel = v.orgLabel,
				org = v.society,
				orgBoss = v.orgBoss,
				orgGarage = v.orgGarage,
				orgVehicles = v.orgVehicles,
				orgChest = v.orgChest,
				orgGSpawn = v.orgGSpawn,
				orgWear = v.orgWear,
				orgGDelete = v.orgGDelete,
				orgActivity = v.orgActivity,
				orgChestCapacity = v.orgChestCapacity,
			})
        end
		TriggerClientEvent("Org:sendGangDataForManage", _source, OrgData)
    end)
end)

RegisterNetEvent('Org:getStockItem')
AddEventHandler('Org:getStockItem', function(token, itemName, count, society)
	if not CheckToken(token, source, "Org:getStockItem") then return end

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('eAddoninventory:getSharedInventory', 'society_'..society, function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
			SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à retiré **x"..count.." "..itemName.."** du stock de l'organisation **"..society.."**", "org")
			TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Coffre', '~o~Informations~s~', 'Vous avez retiré ~r~'..inventoryItem.label.." x"..count, 'CHAR_MP_FM_CONTACT', 8)
		else
			TriggerClientEvent('Extasy:showAdvancedNotification', _source, 'Coffre', '~o~Informations~s~', "Quantité ~r~invalide", 'CHAR_MP_FM_CONTACT', 9)
		end
	end)
end)

RegisterServerEvent('Org:getVehiclesFromThisOrg')
AddEventHandler('Org:getVehiclesFromThisOrg', function(token, org)
	if not CheckToken(token, source, "Org:getVehiclesFromThisOrg") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT * FROM gangs WHERE orgName = @orgName", {['@orgName'] = org}, function(result)
        for _, v in pairs(result) do
			TriggerClientEvent("Org:refreshVehiclesOrg", _source, v.orgVehicles)
        end
    end)
end)

RegisterServerEvent('Org:refreshVehicleFromOrg')
AddEventHandler('Org:refreshVehicleFromOrg', function(token, org, orgVehicles)
	if not CheckToken(token, source, "Org:refreshVehicleFromOrg") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('UPDATE `gangs` SET `orgVehicles` = @orgVehicles WHERE orgName = @orgName', {
		['@orgName'] = org,
		['@orgVehicles'] = json.encode(orgVehicles)
	}, function(rowsChange)
		MySQL.Async.fetchAll("SELECT * FROM gangs WHERE orgName = @orgName", {['@orgName'] = org}, function(result)
			for _, v in pairs(result) do
				TriggerClientEvent("Org:refreshVehiclesOrg", _source, v.orgVehicles)
			end
		end)
	end)
end)

RegisterServerEvent('Org:getAllWearsFromThisOrg')
AddEventHandler('Org:getAllWearsFromThisOrg', function(token, org)
	if not CheckToken(token, source, "Org:getAllWearsFromThisOrg") then return end
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local OrgClothesData = {}

    MySQL.Async.fetchAll("SELECT * FROM orgWear WHERE orgName = @orgName", {['@orgName'] = org}, function(result)
        for _, v in pairs(result) do
			table.insert(OrgClothesData, {
				orgName = v.orgName,
				id = v.id,
				orgWearName = v.orgWearName,
				orgClothes = v.orgClothes,
			})
			TriggerClientEvent("Org:refreshAllWearsFromThisOrg", _source, OrgClothesData)
        end
    end)
end)

RegisterServerEvent('Org:addNewWearFormThisOrg')
AddEventHandler('Org:addNewWearFormThisOrg', function(token, orgName, orgClothes, orgWearName)
	if not CheckToken(token, source, "Org:addNewWearFormThisOrg") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local OrgClothesData = {}

	MySQL.Async.execute('INSERT INTO orgWear (orgName,orgWearName,orgClothes) VALUES (@orgName,@orgWearName,@orgClothes)',{
      ['@orgName'] = orgName, 
      ['@orgWearName'] = orgWearName,
	  ['@orgClothes'] =  orgClothes
    },function(rowsChange)
		MySQL.Async.fetchAll("SELECT * FROM orgWear WHERE orgName = @orgName", {['@orgName'] = org}, function(result)
			for _, v in pairs(result) do
				table.insert(OrgClothesData, {
					orgName = v.orgName,
					id = v.id,
					orgWearName = v.orgWearName,
					orgClothes = v.orgClothes,
				})
				TriggerClientEvent("Org:refreshAllWearsFromThisOrg", _source, OrgClothesData)
			end
		end)
	end)
end)

RegisterServerEvent('Org:removeWearFromThisOrg')
AddEventHandler('Org:removeWearFromThisOrg', function(token, id, org)
	if not CheckToken(token, source, "Org:removeWearFromThisOrg") then return end
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchAll('DELETE FROM orgWear WHERE id = @id', {
		['@id'] = id
	},
        function(result)
    end)
end)

RegisterServerEvent('Org:GetGangsMembres')
AddEventHandler('Org:GetGangsMembres', function(token, org)
	if not CheckToken(token, source, "Org:GetGangsMembres") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local MembresduGang = {}

    MySQL.Async.fetchAll('SELECT * FROM users WHERE job2 = @job2', {
		['@job2'] = org
	},
        function(result)
        for _,v in pairs(result) do
			table.insert(MembresduGang, {
				Name = v.firstname.." "..v.lastname,
				Info = v.identifier,
				Gang = v.job2,
				Grade = v.job2_grade,
			})
        end
		TriggerClientEvent("Org:refreshGangsMembres", _source, MembresduGang)
		MembresduGang = {}
    end)
end)

RegisterServerEvent('Org:getMyGangMoney')
AddEventHandler('Org:getMyGangMoney', function(token, org)
	if not CheckToken(token, source, "Org:getMyGangMoney") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local items   = xPlayer.inventory
	
	if org then
		TriggerEvent('eAddonaccount:getSharedAccount', org, function(account)
			TriggerClientEvent("Org:refreshGangMoney", _source, account.money)
		end)
	else
		print("ERREUR: Les données d'argent societé du gang "..org.." sont corompu !")
	end
end)

formatPlayerInventoryOrg = function(xPlayer)
    local playerInventory = {}
    for name, count in pairs(xPlayer.getInventory(true)) do
        playerInventory[name] = count
    end
    return playerInventory
end

countItemsOrg = function(content)
    local i = 0
    for item, qty in pairs(content) do
        i = i + qty
    end
    return i
end

RegisterServerEvent('Org:getChestInventory')
AddEventHandler('Org:getChestInventory', function(token, org)
	if not CheckToken(token, source, "Org:getChestInventory") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	local inventory = xPlayer.getInventory(true)
	local playerInventory = {}
    for name, count in pairs(inventory) do
        playerInventory[name] = count
    end

	MySQL.Async.fetchAll("SELECT * FROM gangs WHERE orgName = @orgName", {['@orgName'] = org}, function(result)
		for _, v in pairs(result) do
			TriggerClientEvent("Org:refreshChest", _source, v.orgInventory, v.orgChestCapacity, v.orgMoney, playerInventory, labelTable)
		end
	end)

	TriggerClientEvent("Org:refreshPlayerContent", _source, formatPlayerInventoryOrg(xPlayer))
end)

RegisterServerEvent('Org:TransferWeaponFromInvToChest')
AddEventHandler('Org:TransferWeaponFromInvToChest', function(token, orgName, label, qty, OrgChestCapacity)
	if not CheckToken(token, source, "Org:TransferWeaponFromInvToChest") then return end

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local org = orgName

	MySQL.Async.fetchAll("SELECT name,label FROM items", {}, function(result)
        for k,v in pairs(result) do
            labelTable[v.name] = v.label
        end
    end)

	if not xPlayer.hasWeapon(label) then
		TriggerClientEvent("Org:serverCb", _source, "~r~Vous ne possédez pas cette arme !")
		return
	end

	if orgTable[org] == nil then
		TriggerClientEvent("Org:serverCb", _source, "~r~Une erreur est survenue")
        return
    end

	local inventory = formatPlayerInventoryOrg(xPlayer)
	local orgRInventory = orgTable[org].orgInventory
	if 1 < qty then
		TriggerClientEvent("Org:serverCb", _source, "~r~Vous ne pouvez pas déposer autant de "..labelTable[itemName])
        return
    end
	
    --if countItemsOrg(orgRInventory) + qty > OrgChestCapacity then
		--print("~r~Limite de stockage dépassée")
        --TriggerClientEvent("hotel:serverCb", _src, "~r~Limite de stockage dépassée")
        --return
    --end

	xPlayer.removeWeapon(label)
	TriggerEvent("over:logsmoicadelete", _source, label, 0)

	if not orgRInventory[label] then
        orgRInventory[label] = 0
    end
	orgRInventory[label] = orgRInventory[label] + qty
    orgTable[org].orgInventory = orgRInventory
	MySQL.Async.execute("UPDATE gangs SET orgInventory = @a WHERE orgName = @b", {
        ["a"] = json.encode(orgTable[org].orgInventory),
        ["b"] = org
    })
	TriggerClientEvent("Org:refreshChestTable", _source, orgTable[org].orgInventory, labelTable)
	TriggerClientEvent("Org:refreshPlayerContent", _source, formatPlayerInventoryOrg(xPlayer))
	TriggerClientEvent("Org:serverCb", _source, "~g~Objet"..(qty > 1 and "s" or "").." déposé"..(qty > 1 and "s" or "").." avec succès")
end)

RegisterServerEvent('Org:TransferItemFromInvToChest')
AddEventHandler('Org:TransferItemFromInvToChest', function(token, orgName, label, qty, OrgChestCapacity)
	if not CheckToken(token, source, "Org:TransferItemFromInvToChest") then return end

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local org = orgName

	MySQL.Async.fetchAll("SELECT name,label FROM items", {}, function(result)
        for k,v in pairs(result) do
            labelTable[v.name] = v.label
        end
    end)

	if orgTable[org] == nil then
		TriggerClientEvent("Org:serverCb", _source, "~r~Une erreur est survenue")
        return
    end

	local inventory = formatPlayerInventoryOrg(xPlayer)
	local orgRInventory = orgTable[org].orgInventory
	if not inventory[label] or inventory[label] < qty then
		TriggerClientEvent("Org:serverCb", _source, "~r~Vous ne pouvez pas déposer autant de "..labelTable[itemName])
        return
    end
	
    --if countItemsOrg(orgRInventory) + qty > OrgChestCapacity then
		--print("~r~Limite de stockage dépassée")
        --TriggerClientEvent("hotel:serverCb", _src, "~r~Limite de stockage dépassée")
        --return
    --end

	xPlayer.removeInventoryItem(label, qty)

	if not orgRInventory[label] then
        orgRInventory[label] = 0
    end
	orgRInventory[label] = orgRInventory[label] + qty
    orgTable[org].orgInventory = orgRInventory
	MySQL.Async.execute("UPDATE gangs SET orgInventory = @a WHERE orgName = @b", {
        ["a"] = json.encode(orgTable[org].orgInventory),
        ["b"] = org
    })
	TriggerClientEvent("Org:refreshChestTable", _source, orgTable[org].orgInventory, labelTable)
	TriggerClientEvent("Org:refreshPlayerContent", _source, formatPlayerInventoryOrg(xPlayer))
	TriggerClientEvent("Org:serverCb", _source, "~g~Objet"..(qty > 1 and "s" or "").." déposé"..(qty > 1 and "s" or "").." avec succès")
end)

RegisterServerEvent('Org:TransferWeaponFromChestToInv')
AddEventHandler('Org:TransferWeaponFromChestToInv', function(token, orgName, label, qty, OrgChestCapacity)
	if not CheckToken(token, source, "Org:TransferWeaponFromChestToInv") then return end

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local org = orgName

	MySQL.Async.fetchAll("SELECT name,label FROM items", {}, function(result)
        for k,v in pairs(result) do
            labelTable[v.name] = v.label
        end
    end)

	if orgTable[org] == nil then
		TriggerClientEvent("Org:serverCb", _source, "~r~Une erreur est survenue")
        return
    end

	if not orgTable[org].orgInventory[label] or orgTable[org].orgInventory[label] < qty then
		TriggerClientEvent("Org:serverCb", _source, "~r~Le coffre n'a pas assez d'item de ce type")
        return
    end

	local orgRInventory = orgTable[org].orgInventory
	if (orgRInventory[label] or 0) - qty <= 0 then
        orgRInventory[label] = nil
    else
        orgRInventory[label] = orgRInventory[label] - qty
    end

	xPlayer.addWeapon(label, 250)
	TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, label, 250, "Depuis le coffre du gang: "..orgName)
	orgTable[org].orgInventory = orgRInventory

	MySQL.Async.execute("UPDATE gangs SET orgInventory = @a WHERE orgName = @b", {
        ["a"] = json.encode(orgTable[org].orgInventory),
        ["b"] = org
    })

	TriggerClientEvent("Org:refreshChestTable", _source, orgTable[org].orgInventory, labelTable)
	TriggerClientEvent("Org:refreshPlayerContent", _source, formatPlayerInventoryOrg(xPlayer))
	TriggerClientEvent("Org:serverCb", _source, "~g~Objet"..(qty > 1 and "s" or "").." retiré"..(qty > 1 and "s" or "").." avec succès")
end)

RegisterServerEvent('Org:TransferItemFromChestToInv')
AddEventHandler('Org:TransferItemFromChestToInv', function(token, orgName, label, qty, OrgChestCapacity)
	if not CheckToken(token, source, "Org:TransferItemFromChestToInv") then return end

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local org = orgName

	MySQL.Async.fetchAll("SELECT name,label FROM items", {}, function(result)
        for k,v in pairs(result) do
            labelTable[v.name] = v.label
        end
    end)

	if orgTable[org] == nil then
		TriggerClientEvent("Org:serverCb", _source, "~r~Une erreur est survenue")
        return
    end

	if not orgTable[org].orgInventory[label] or orgTable[org].orgInventory[label] < qty then
		TriggerClientEvent("Org:serverCb", _source, "~r~Le coffre n'a pas assez d'item de ce type")
        return
    end

	local orgRInventory = orgTable[org].orgInventory
	if (orgRInventory[label] or 0) - qty <= 0 then
        orgRInventory[label] = nil
    else
        orgRInventory[label] = orgRInventory[label] - qty
    end

	xPlayer.addInventoryItem(label, qty)
	orgTable[org].orgInventory = orgRInventory

	MySQL.Async.execute("UPDATE gangs SET orgInventory = @a WHERE orgName = @b", {
        ["a"] = json.encode(orgTable[org].orgInventory),
        ["b"] = org
    })

	TriggerClientEvent("Org:refreshChestTable", _source, orgTable[org].orgInventory, labelTable)
	TriggerClientEvent("Org:refreshPlayerContent", _source, formatPlayerInventoryOrg(xPlayer))
	TriggerClientEvent("Org:serverCb", _source, "~g~Objet"..(qty > 1 and "s" or "").." retiré"..(qty > 1 and "s" or "").." avec succès")
end)

RegisterServerEvent('Org:TransferMoneyFromChestToInv')
AddEventHandler('Org:TransferMoneyFromChestToInv', function(token, orgName, orgGiveMoney, orgMoney)
	if not CheckToken(token, source, "Org:TransferMoneyFromChestToInv") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local TotalMoney = orgMoney - orgGiveMoney 

	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à retiré **"..TotalMoney.."$** du coffre de l'organisation **"..orgName.."**", "org")

	MySQL.Async.execute('UPDATE `gangs` SET `orgMoney` = @orgMoney WHERE orgName = @orgName', {
		['@orgName'] = orgName,
		['@orgMoney'] = TotalMoney 
	}, function(rowsChange)
		xPlayer.addAccountMoney('black_money', orgGiveMoney)
	end)
end)

RegisterServerEvent('Org:TransferMoneyFromInvToChest')
AddEventHandler('Org:TransferMoneyFromInvToChest', function(token, orgName, orgGiveMoneyToPlayer, orgMoney)
	if not CheckToken(token, source, "Org:TransferMoneyFromInvToChest") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local TotalRemoveMoney = orgMoney + orgGiveMoneyToPlayer

	SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à déposé **"..TotalRemoveMoney.."$** dans le coffre de l'organisation **"..orgName.."**", "org")

	MySQL.Async.execute('UPDATE `gangs` SET `orgMoney` = @orgMoney WHERE orgName = @orgName', {
		['@orgName'] = orgName,
		['@orgMoney'] = TotalRemoveMoney
	}, function(rowsChange)
		xPlayer.removeAccountMoney('black_money', orgGiveMoneyToPlayer)
	end)
end)

RegisterServerEvent('Org:getMyInventory')
AddEventHandler('Org:getMyInventory', function(token)
	if not CheckToken(token, source, "Org:getMyInventory") then return end

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local items   = xPlayer.inventory
	
	TriggerClientEvent("Org:refreshMyInventory", _source, items)
end)

RegisterServerEvent('Org:withdrawMoney')
AddEventHandler('Org:withdrawMoney', function(token, org, amount)
	if not CheckToken(token, source, "Org:withdrawMoney") then return end

    local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)

	TriggerEvent('eAddonaccount:getSharedAccount', org, function(account)
		if amount > 0 and account.money >= amount then
			account.removeMoney(amount)
			xPlayer.addMoney(amount)
			SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à retiré **"..amount.."$** du coffre de l'organisation **"..org.."**", "org")
			TriggerClientEvent('Extasy:ShowNotification', _src, "Vous avez retiré ~r~$"..ESX.Math.GroupDigits(amount))
		else
			TriggerClientEvent('Extasy:ShowNotification', _src, "~r~Vous n'avez pas assez d'argent dans l'organisation")
		end
	end)
end)

RegisterServerEvent('Org:depositMoney')
AddEventHandler('Org:depositMoney', function(token, org, amount)
	if not CheckToken(token, source, "Org:depositMoney") then return end

    local _src = source
	local xPlayer = ESX.GetPlayerFromId(source)

		if amount > 0 and xPlayer.getMoney() >= amount then
			TriggerEvent('eAddonaccount:getSharedAccount', org, function(account)
				xPlayer.removeMoney(amount)
				TriggerClientEvent('Extasy:ShowNotification', _src, "Vous avez déposé ~g~$"..ESX.Math.GroupDigits(amount))
				account.addMoney(amount)
				SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à déposé **"..amount.."$** dans le coffre de l'organisation **"..org.."**", "org")
			end)
		else
			TriggerClientEvent('Extasy:ShowNotification', _src, "Montant invalide")
		end
end)

RegisterServerEvent('Org:Bossvirer')
AddEventHandler('Org:Bossvirer', function(token, target)
	if not CheckToken(token, source, "Org:Bossvirer") then return end

	local _src = source
	local sourceXPlayer = ESX.GetPlayerFromId(_src)
	local sourceJob2 = sourceXPlayer.getJob2()

	if sourceJob2.grade_name == 'boss' then
		local targetXPlayer = ESX.GetPlayerFromIdentifier(target)

		if targetXPlayer then
			local targetJob2 = targetXPlayer.getJob2()
			targetXPlayer.setJob2('unemployed2', 0)
			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
				['@identifier'] = target
			},
				function(result)
				for _,v in pairs(result) do
					MySQL.Async.execute('UPDATE users SET job2 = @job2 WHERE identifier = @identifier', {
						['@job2'] = 'unemployed2',
						['@identifier'] = target
					}, function(rowsChange)
					end)

					MySQL.Async.execute('UPDATE users SET job2_grade = @job2_grade WHERE identifier = @identifier', {
						['@job2_grade'] = 0,
						['@identifier'] = target
					}, function(rowsChange)
					end)
				end
			end)
			TriggerClientEvent('Extasy:ShowNotification', sourceXPlayer.source, ('Vous avez ~r~viré %s~w~.'):format(targetXPlayer.name))
			TriggerClientEvent('Extasy:ShowNotification', targetXPlayer.source, ('Vous avez été ~g~viré par %s~w~.'):format(sourceXPlayer.name))
		else
			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
				['@identifier'] = target
			},
				function(result)
				for _,v in pairs(result) do
					MySQL.Async.execute('UPDATE users SET job2 = @job2 WHERE identifier = @identifier', {
						['@job2'] = 'unemployed2',
						['@identifier'] = target
					}, function(rowsChange)
					end)

					MySQL.Async.execute('UPDATE users SET job2_grade = @job2_grade WHERE identifier = @identifier', {
						['@job2_grade'] = 0,
						['@identifier'] = target
					}, function(rowsChange)
					end)
				end
			end)

			TriggerClientEvent('Extasy:ShowNotification', sourceXPlayer.source, "~g~Vous avez viré le joueur")
		end
	else
		TriggerClientEvent('Extasy:ShowNotification', sourceXPlayer.source, 'Vous n\'avez pas ~r~l\'autorisation~w~.')
	end
end)

RegisterServerEvent('Org:editGang')
AddEventHandler('Org:editGang', function(token, type, gangPos, gangName)
	if not CheckToken(token, source, "Org:editGang") then return end

	local _src = source
	local sourceXPlayer = ESX.GetPlayerFromId(source)

	if type == "orgBoss" then
		MySQL.Async.execute('UPDATE `gangs` SET `orgBoss` = @orgBoss WHERE orgName = @orgName', {
            ['@orgName'] = gangName,
            ['@orgBoss'] = json.encode(gangPos)
        }, function(rowsChange)
        end)
		TriggerClientEvent('Extasy:ShowNotification', _src, 'Position du menu boss modifier')
	end

	if type == "orgGarage" then
		MySQL.Async.execute('UPDATE `gangs` SET `orgGarage` = @orgGarage WHERE orgName = @orgName', {
            ['@orgName'] = gangName,
            ['@orgGarage'] = json.encode(gangPos)
        }, function(rowsChange)
        end)
		TriggerClientEvent('Extasy:ShowNotification', _src, 'Position du garage modifier')
	end

	if type == "orgChest" then
		MySQL.Async.execute('UPDATE `gangs` SET `orgChest` = @orgChest WHERE orgName = @orgName', {
            ['@orgName'] = gangName,
            ['@orgChest'] = json.encode(gangPos)
        }, function(rowsChange)
        end)
		TriggerClientEvent('Extasy:ShowNotification', _src, 'Position du menu boss modifier')
	end

	if type == "orgGSpawn" then
		MySQL.Async.execute('UPDATE `gangs` SET `orgGSpawn` = @orgGSpawn WHERE orgName = @orgName', {
            ['@orgName'] = gangName,
            ['@orgGSpawn'] = json.encode(gangPos)
        }, function(rowsChange)
        end)
		TriggerClientEvent('Extasy:ShowNotification', _src, 'Position spawn véhicule modifier')
	end

	if type == "orgWear" then
		MySQL.Async.execute('UPDATE `gangs` SET `orgWear` = @orgWear WHERE orgName = @orgName', {
            ['@orgName'] = gangName,
            ['@orgWear'] = json.encode(gangPos)
        }, function(rowsChange)
        end)
		TriggerClientEvent('Extasy:ShowNotification', _src, 'Position spawn véhicule modifier')
	end

	if type == "orgGDelete" then
		MySQL.Async.execute('UPDATE `gangs` SET `orgGDelete` = @orgGDelete WHERE orgName = @orgName', {
            ['@orgName'] = gangName,
            ['@orgGDelete'] = json.encode(gangPos)
        }, function(rowsChange)
        end)
		TriggerClientEvent('Extasy:ShowNotification', _src, 'Position spawn véhicule modifier')
	end
end)

ESX.RegisterServerCallback('Org:CanBuy', function (source, cb, price)
	TriggerEvent("ext:AST", source, "Org:CanBuy")

	local xPlayer = ESX.GetPlayerFromId(source)
		
	if xPlayer.getAccount('black_money').money >= price then
		xPlayer.removeAccountMoney('black_money', price)
		cb(true)
	else
		cb(false)
	end
end)
















--- PAS FAIT ---

ESX.RegisterServerCallback('Org:getOtherPlayerDataa', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            job2 = xPlayer.job2.label,
            grade2 = xPlayer.job2.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout(),
            height = xPlayer.get('height'),
            dob = xPlayer.get('dateofbirth')
        }
            if xPlayer.get('sex') == 'm' then data.sex = 'Homme' else data.sex = 'Femme' end

            TriggerEvent('esx_license:getLicenses', target, function(licenses)
                data.licenses = licenses
        cb(data)
        end)
    end
end)


RegisterServerEvent('Org:handcuff')
AddEventHandler('Org:handcuff', function(token, target)
	if not CheckToken(token, source, "Org:handcuff") then return end

  TriggerClientEvent('Org:handcuff', target)
end)

RegisterServerEvent('Org:drag')
AddEventHandler('Org:drag', function(token, target)
	if not CheckToken(token, source, "Org:drag") then return end

  local _source = source
  TriggerClientEvent('Org:drag', target, _source)
end)

RegisterServerEvent('Org:putInVehicle')
AddEventHandler('Org:putInVehicle', function(token, target)
	if not CheckToken(token, source, "Org:putInVehicle") then return end

  TriggerClientEvent('Org:putInVehicle', target)
end)

RegisterServerEvent('Org:OutVehicle')
AddEventHandler('Org:OutVehicle', function(token, target)
	if not CheckToken(token, source, "Org:OutVehicle") then return end

    TriggerClientEvent('Org:OutVehicle', target)
end)


-------------------------------- Fouiller

RegisterNetEvent('Org:confiscatePlayerItem')
AddEventHandler('Org:confiscatePlayerItem', function(token, target, itemType, itemName, amount)
	if not CheckToken(token, source, "Org:confiscatePlayerItem") then return end

    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		
			targetXPlayer.removeInventoryItem(itemName, amount)
			sourceXPlayer.addInventoryItem   (itemName, amount)
            TriggerClientEvent("Extasy:ShowNotification", source, "Vous avez confisqué ~b~"..amount..' '..sourceItem.label.."~s~.")
            TriggerClientEvent("Extasy:ShowNotification", target, "Quelqu'un vous a pris ~b~"..amount..' '..sourceItem.label.."~s~.")
        else
			--TriggerClientEvent("Extasy:ShowNotification", source, "~r~Quantidade inválida")
		end
        
    if itemType == 'item_account' then
        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney   (itemName, amount)
        
        TriggerClientEvent("Extasy:ShowNotification", source, "Vous avez confisqué ~b~"..amount.."€ ~s~argent non déclaré~s~.")
        TriggerClientEvent("Extasy:ShowNotification", target, "Quelqu'un vous a pris ~b~"..amount.."€ ~s~argent non déclaré~s~.")
        
    end

	if itemType == 'item_weapon' then
        if amount == nil then amount = 0 end
        targetXPlayer.removeWeapon(itemName, amount)
        sourceXPlayer.addWeapon   (itemName, amount)

        TriggerClientEvent("Extasy:ShowNotification", source, "Vous avez confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
        TriggerClientEvent("Extasy:ShowNotification", target, "Quelqu'un vous a confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
    end
end)

ESX.RegisterServerCallback('Org:getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("Extasy:ShowNotification", target, "~r~~Quelqu'un vous fouille")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    end
end)

RegisterNetEvent('Org:confiscatePlayerItem')
AddEventHandler('Org:confiscatePlayerItem', function(token, target, itemType, itemName, amount)
	if not CheckToken(token, source, "Org:confiscatePlayerItem") then return end

    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		
			targetXPlayer.removeInventoryItem(itemName, amount)
			sourceXPlayer.addInventoryItem   (itemName, amount)
            TriggerClientEvent("Extasy:ShowNotification", source, "Vous avez confisqué ~b~"..amount..' '..sourceItem.label.."~s~.")
            TriggerClientEvent("Extasy:ShowNotification", target, "Quelqu'un vous a pris ~b~"..amount..' '..sourceItem.label.."~s~.")
        else
			--TriggerClientEvent("Extasy:ShowNotification", source, "~r~Quantidade inválida")
		end
        
    if itemType == 'item_account' then
        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney   (itemName, amount)
        
        TriggerClientEvent("Extasy:ShowNotification", source, "Vous avez confisqué ~b~"..amount.."€ ~s~argent non déclaré~s~.")
        TriggerClientEvent("Extasy:ShowNotification", target, "Quelqu'un vous a pris ~b~"..amount.."€ ~s~argent non déclaré~s~.")
        
    end

	if itemType == 'item_weapon' then
        if amount == nil then amount = 0 end
        targetXPlayer.removeWeapon(itemName, amount)
        sourceXPlayer.addWeapon   (itemName, amount)

        TriggerClientEvent("Extasy:ShowNotification", source, "Vous avez confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
        TriggerClientEvent("Extasy:ShowNotification", target, "Quelqu'un vous a confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
    end
end)