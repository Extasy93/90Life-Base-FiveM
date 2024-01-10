ESX.RegisterCommand('tp', 'superadmin', function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = _U('command_setcoords'), validate = true, arguments = {
	{name = 'x', help = _U('command_setcoords_x'), type = 'number'},
	{name = 'y', help = _U('command_setcoords_y'), type = 'number'},
	{name = 'z', help = _U('command_setcoords_z'), type = 'number'}
}})

ESX.RegisterCommand('setjob', {'admin', 'mod'}, function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)
	else
		showError(_U('command_setjob_invalid'))
	end
end, true, {help = _U('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'job', help = _U('command_setjob_job'), type = 'string'},
	{name = 'grade', help = _U('command_setjob_grade'), type = 'number'}
}})

ESX.RegisterCommand('setjob2', {'admin', 'mod'}, function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob2(args.job, args.grade)
	else
		showError(_U('command_setjob_invalid'))
	end
end, true, {help = _U('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'job', help = _U('command_setjob_job'), type = 'string'},
	{name = 'grade', help = _U('command_setjob_grade'), type = 'number'}
}})

ESX.RegisterCommand({'car'}, {'mod'}, function(xPlayer, args, showError)
	xPlayer.triggerEvent('esx:spawnVehicles', args.car)
end, false, {help = _U('command_car'), validate = false, arguments = {
	{name = 'car', help = _U('command_car_car'), type = 'any'}
}})

ESX.RegisterCommand({'cardel', 'dv'}, 'mod', function(xPlayer, args, showError)
	xPlayer.triggerEvent('esx:deleteVehicles', args.radius)
end, false, {help = _U('command_cardel'), validate = false, arguments = {
	{name = 'radius', help = _U('command_cardel_radius'), type = 'any'}
}})

ESX.RegisterCommand('setaccountmoney', 'superadmin', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.setAccountMoney(args.account, args.amount)
	else
		showError(_U('command_giveaccountmoney_invalid'))
	end
end, true, {help = _U('command_setaccountmoney'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'account', help = _U('command_giveaccountmoney_account'), type = 'string'},
	{name = 'amount', help = _U('command_setaccountmoney_amount'), type = 'number'}
}})

ESX.RegisterCommand('giveaccountmoney', 'superadmin', function(xPlayer, args, showError)
	if args.playerId.getAccount(args.account) then
		args.playerId.addAccountMoney(args.account, args.amount)
	else
		showError(_U('command_giveaccountmoney_invalid'))
	end
end, true, {help = _U('command_giveaccountmoney'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'account', help = _U('command_giveaccountmoney_account'), type = 'string'},
	{name = 'amount', help = _U('command_giveaccountmoney_amount'), type = 'number'}
}})

--[[ESX.RegisterCommand('giveitem', 'superadmin', function(xPlayer, args, showError)
	args.playerId.addInventoryItem(args.item, args.count)

	print(args.playerId)
	print(args.item)
	print(args.count)
	exports.eCore:SendLog("Le staff **["..args.playerId.."]** "..GetPlayerName(args.playerId).." c'est give x"..args.count.." ["..args.item.."]", "admin")
end, true, {help = _U('command_giveitem'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'item', help = _U('command_giveitem_item'), type = 'item'},
	{name = 'count', help = _U('command_giveitem_count'), type = 'number'}
}})--]]

--[[ESX.RegisterCommand('giveweapon', 'superadmin', function(source, args, user)
	local xPlayer    = ESX.GetPlayerFromId(args[1])
	local weaponName = string.upper(args[2])

	xPlayer.addWeapon(weaponName, tonumber(args[3]))
	TriggerEvent("over:creationarmestupeuxpasdeviner", xPlayer.identifier, weaponName, 250, "Commande staff /giveweapon")
end, true)--]]

--[[ESX.RegisterCommand('giveweaponcomponent', 'admin', function(xPlayer, args, showError)
	if args.playerId.hasWeapon(args.weaponName) then
		local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

		if component then
			if xPlayer.hasWeaponComponent(args.weaponName, args.componentName) then
				showError(_U('command_giveweaponcomponent_hasalready'))
			else
				xPlayer.addWeaponComponent(args.weaponName, args.componentName)
			end
		else
			showError(_U('command_giveweaponcomponent_invalid'))
		end
	else
		showError(_U('command_giveweaponcomponent_missingweapon'))
	end
end, true, {help = _U('command_giveweaponcomponent'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'weaponName', help = _U('command_giveweapon_weapon'), type = 'weapon'},
	{name = 'componentName', help = _U('command_giveweaponcomponent_component'), type = 'string'}
}})--]]

ESX.RegisterCommand({'clear', 'cls'}, 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:clear')
end, false, {help = _U('command_clear')})

ESX.RegisterCommand({'clearall', 'clsall'}, 'mod', function(xPlayer, args, showError)
	TriggerClientEvent('chat:clear', -1)
end, false, {help = _U('command_clearall')})

ESX.RegisterCommand('clearinventory', 'superadmin', function(xPlayer, args, showError)
	for k,v in ipairs(args.playerId.inventory) do
		if v.count > 0 then
			args.playerId.setInventoryItem(v.name, 0)
		end
	end
end, true, {help = _U('command_clearinventory'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('clearloadout', 'superadmin', function(xPlayer, args, showError)
	for k,v in ipairs(args.playerId.loadout) do
		args.playerId.removeWeapon(v.name)
	end
end, true, {help = _U('command_clearloadout'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('setgroup', 'superadmin', function(xPlayer, args, showError)
	args.playerId.setGroup(args.group)
	exports.eCore:SendLog("``Le joueur ["..source.."] "..GetPlayerName(source).." à changer le groupe de ["..tonumber(id).."] "..GetPlayerName(tonumber(id)).." en : ".._group.."``", "group")
end, true, {help = _U('command_setgroup'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'group', help = _U('command_setgroup_group'), type = 'string'},
}})

ESX.RegisterCommand('save', 'user', function(xPlayer, args, showError)
	print(('[ExtendedMode] [^2INFO^7] Manual player data save triggered for "%s"'):format(args.playerId.name))
	ESX.SavePlayer(args.playerId, function(rowsChanged)
		if rowsChanged ~= 0 then
			print(('[ExtendedMode] [^2INFO^7] Saved player data for "%s"'):format(args.playerId.name))
		else
			print(('[ExtendedMode] [^3WARNING^7] Failed to save player data for "%s"! This may be caused by an internal error on the MySQL server.'):format(args.playerId.name))
		end
	end)
end, true, {help = _U('command_save'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('saveall', 'superadmin', function(xPlayer, args, showError)
	print('[ExtendedMode] [^2INFO^7] Manual player data save triggered')
	ESX.SavePlayers(function(result)
		if result then
			print('[ExtendedMode] [^2INFO^7] Saved all player data')
		else
			print('[ExtendedMode] [^3WARNING^7] Failed to save player data! This may be caused by an internal error on the MySQL server.')
		end
	end)
end, true, {help = _U('command_saveall')})

RegisterNetEvent('Extasy:SavePlayer')
AddEventHandler('Extasy:SavePlayer', function(playerid)
	ESX.SavePlayer(playerid)
end)
