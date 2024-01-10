ESX                 = nil
Jobs                = {}
RegisteredSocieties = {}

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Society:GetListeJob', function(source, cb, job)
  local xPlayer = ESX.GetPlayerFromId(source)
  local jobListe = {}
  jobListe = {}

  MySQL.Async.fetchAll('SELECT * FROM users WHERE job = @job', {
    ['@job'] = job
  }, function(result)
    for i = 1, #result, 1 do
      table.insert(jobListe, {
        prenom = result[i].firstname,
        nom = result[i].lastname,
        identifier = result[i].identifier
      })
    end

    cb(jobListe)
  end)
end)

RegisterServerEvent('Society:KickPlayerForBossMenu')
AddEventHandler('Society:KickPlayerForBossMenu', function (token, identifier)
  if not CheckToken(token, source, "Society:KickPlayerForBossMenu") then return end
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)


  MySQL.Async.execute(
    'UPDATE users SET job = @job WHERE identifier = @identifier',
    {
      ['@identifier'] = identifier,
      ['@job'] = "unemployed"
    }
  )
end)

GetSociety = function(name)
  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      return RegisteredSocieties[i]
    end
  end
end

AddEventHandler('onMySQLReady', function()
    local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

    for i=1, #result, 1 do
      Jobs[result[i].name]        = result[i]
      Jobs[result[i].name].grades = {}
    end

    local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

    for i=1, #result2, 1 do
      Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
    end
end)

AddEventHandler('Society:registerSociety', function(name, label, account, datastore, inventory, data)
  local found = false

  local society = {
    name      = name,
    label     = label,
    account   = account,
    datastore = datastore,
    inventory = inventory,
    data      = data,
  }

  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      found                  = true
      RegisteredSocieties[i] = society
      break
    end
  end

  if not found then
    table.insert(RegisteredSocieties, society)
  end
end)

AddEventHandler('Society:getSocieties', function(cb)
  cb(RegisteredSocieties)
end)

AddEventHandler('Society:getSociety', function(name, cb)
  cb(GetSociety(name))
end)

RegisterServerEvent('Society:withdrawwMoney')
AddEventHandler('Society:withdrawwMoney', function(token, society, amount)
  if not CheckToken(token, source, "Society:withdrawwMoney") then return end

  local xPlayer = ESX.GetPlayerFromId(source)
  local society = GetSociety(society)
  amount = ESX.Math.Round(tonumber(amount))

  TriggerEvent('eAddonaccount:getSharedAccount', society.account, function(account)

    if amount > 0 and account.money >= amount then

      account.removeMoney(amount)
      xPlayer.addMoney(amount)
      --TriggerEvent("discordbot:argentsociete_sv", xPlayer.name, amount, society.name)

      SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à pris **"..amount.."$** depuis la société **"..society.account.."**", "society-money")

      TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, 'Vous venez de retiré ~g~$'..amount..'~s~')

    else
      TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, 'montant invalide')
    end
  end)
end)

RegisterServerEvent('Society:deposittMoney')
AddEventHandler('Society:deposittMoney', function(token, society, amount)
  if not CheckToken(token, source, "Society:deposittMoney") then return end

  local xPlayer = ESX.GetPlayerFromId(source)
  local society = GetSociety(society)
  amount = ESX.Math.Round(tonumber(amount))

  if amount > 0 and xPlayer.getMoney() >= amount then

    TriggerEvent('eAddonaccount:getSharedAccount', society.account, function(account)
        xPlayer.removeMoney(amount)
        account.addMoney(amount)

        SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à déposer **"..(amount).."$** dans la société **"..society.account.."** depuis un revenu inconnu", "society-money")
    end)

    TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, 'Vous venez de déposé ~r~$'..amount..'~s~')
  else
    TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, 'montant invalide')
  end
end)

local function WhiteningMoney(source,percent)
	local source = source
		SetTimeout(10000, function()

		if PlayersWashing[source] == true then
			local xPlayer		= ESX.GetPlayerFromId(source)
			local blackMoney	= xPlayer.getAccount('black_money')
			local _percent		= cfg_society.Percentage
			
			if blackMoney.money < cfg_society.Slice then
				TriggerClientEvent("Society:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Blanchisseur', false, 'Vous n\'avez pas assez d\'argent à blanchir, minimum : $' .. cfg_society.Slice)
			else
				local bonus = math.random(cfg_society.Bonus.min, cfg_society.Bonus.max)
				local washedMoney = math.floor(cfg_society.Slice / 100 * (_percent + bonus))

				xPlayer.removeAccountMoney('black_money', cfg_society.Slice)
				xPlayer.addMoney(washedMoney)
				WhiteningMoney(source,_percent)
				
				TriggerClientEvent("Society:notify", source, "CHAR_LESTER_DEATHWISH", 1, 'Blanchisseur', false, 'Vous avez reçu : ~r~$ ' .. washedMoney .. ' d\'argent propre')
			end
		end
	end)
end

RegisterServerEvent('Society:washMoney')
AddEventHandler('Society:washMoney', function(token, amount)
  if not CheckToken(token, source, "Society:washMoney") then return end
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local account 		= xPlayer.getAccount('black_money')

	if amount > 0 and account.money >= amount then
		local washedMoney = math.floor(amount)	
        xPlayer.removeAccountMoney('black_money', amount)
        xPlayer.addMoney(washedMoney)
		
		    TriggerClientEvent("Extasy:ShowAdvancedNotification", source, "Entreprise", "~r~Blanchiment", "Vous avez reçu : +~g~"..washedMoney.."$ ~s~d'argent propre", "CHAR_LESTER")
	  else
		    TriggerClientEvent("Extasy:ShowAdvancedNotification", source, "Entreprise", "~r~Blanchiment", "Montant invalide", "CHAR_LESTER")
	  end
end)

RegisterServerEvent('Society:putVehicleInGarage')
AddEventHandler('Society:putVehicleInGarage', function(token, societyName, vehicle)
  if not CheckToken(token, source, "Society:putVehicleInGarage") then return end

  local society = GetSociety(societyName)

  TriggerEvent('eDatastore:getSharedDataStore', society.datastore, function(store)
    local garage = store.get('garage') or {}
    table.insert(garage, vehicle)
    store.set('garage', garage)
  end)

end)

RegisterServerEvent('Society:removeVehicleFromGarage')
AddEventHandler('Society:removeVehicleFromGarage', function(token, societyName, vehicle)
  if not CheckToken(token, source, "Society:removeVehicleFromGarage") then return end

  local society = GetSociety(societyName)

  TriggerEvent('eDatastore:getSharedDataStore', society.datastore, function(store)
    
    local garage = store.get('garage') or {}

    for i=1, #garage, 1 do
      if garage[i].plate == vehicle.plate then
        table.remove(garage, i)
        break
      end
    end

    store.set('garage', garage)

  end)

end)

ESX.RegisterServerCallback('esx_society:getSocietyMoney2', function(source, cb, societyName)
  local society = GetSociety(societyName)

  if society ~= nil then

    TriggerEvent('eAddonaccount:getSharedAccount', society.account, function(account)
      cb(account.money)
    end)

  else
    cb(0)
  end
end)

ESX.RegisterServerCallback('esx_society:getSocietyMoney', function(source, cb, societyName)
  local society = GetSociety(societyName)

  if society ~= nil then

    TriggerEvent('eAddonaccount:getSharedAccount', society.account, function(account)
      cb(account.money)
    end)

  else
    cb(0)
  end
end)

ESX.RegisterServerCallback('Society:getSocietyMoney', function(source, cb, societyName)

  local society = GetSociety(societyName)

  if society ~= nil then

    TriggerEvent('eAddonaccount:getSharedAccount', society.account, function(account)
      cb(account.money)
    end)

  else
    cb(0)
  end

end)

ESX.RegisterServerCallback('Society:getEmployees', function(source, cb, society)
  local result = MySQL.Sync.fetchAll('SELECT * FROM jobs', {})

  for i=1, #result, 1 do
    Jobs[result[i].name]        = result[i]
    Jobs[result[i].name].grades = {}
  end

  local result2 = MySQL.Sync.fetchAll('SELECT * FROM job_grades', {})

  for i=1, #result2, 1 do
    Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
  end

  Wait(100)

  if cfg_society.EnableESXIdentity then
    MySQL.Async.fetchAll(
      'SELECT * FROM users WHERE job = @job ORDER BY job_grade DESC',
      { ['@job'] = society },
      function (results)
        local employees = {}

        for i=1, #results, 1 do
          table.insert(employees, {
            name        = results[i].firstname .. ' ' .. results[i].lastname,
            identifier  = results[i].identifier,
            job = {
              name        = results[i].job,
              label       = Jobs[results[i].job].label,
              grade       = results[i].job_grade,
              grade_name  = Jobs[results[i].job].grades[tostring(results[i].job_grade)].name,
              grade_label = Jobs[results[i].job].grades[tostring(results[i].job_grade)].label,
            }
          })
        end

        cb(employees)
      end
    )
  else
    MySQL.Async.fetchAll(
      'SELECT * FROM users WHERE job = @job ORDER BY job_grade DESC',
      { ['@job'] = society },
      function (result)
        local employees = {}

        for i=1, #result, 1 do
          table.insert(employees, {
            name        = result[i].name,
            identifier  = result[i].identifier,
            job = {
              name        = result[i].job,
              label       = Jobs[result[i].job].label,
              grade       = result[i].job_grade,
              grade_name  = Jobs[result[i].job].grades[tostring(result[i].job_grade)].name,
              grade_label = Jobs[result[i].job].grades[tostring(result[i].job_grade)].label,
            }
          })
        end

        cb(employees)
      end
    )
  end
end)

---SECONDJOB INCLUDED
ESX.RegisterServerCallback('Society:getEmployees2', function(source, cb, society)

  if cfg_society.EnableESXIdentity then
    MySQL.Async.fetchAll(
      'SELECT * FROM users WHERE job2 = @job2 ORDER BY job2_grade DESC',
      { ['@job2'] = society },
      function (results)
        local employees = {}

        for i=1, #results, 1 do
          table.insert(employees, {
            name        = results[i].firstname .. ' ' .. results[i].lastname,
            identifier  = results[i].identifier,
            job2 = {
              name        = results[i].job2,
              label       = Jobs[results[i].job2].label,
              grade       = results[i].job2_grade,
              grade_name  = Jobs[results[i].job2].grades[tostring(results[i].job2_grade)].name,
              grade_label = Jobs[results[i].job2].grades[tostring(results[i].job2_grade)].label,
            }
          })
        end

        cb(employees)
      end
    )
  else
    MySQL.Async.fetchAll(
      'SELECT * FROM users WHERE job2 = @job2 ORDER BY job2_grade DESC',
      { ['@job2'] = society },
      function (result)
        local employees = {}

        for i=1, #result, 1 do
          table.insert(employees, {
            name        = result[i].name,
            identifier  = result[i].identifier,
            job2 = {
              name        = result[i].job2,
              label       = Jobs[result[i].job2].label,
              grade       = result[i].job2_grade,
              grade_name  = Jobs[result[i].job2].grades[tostring(result[i].job2_grade)].name,
              grade_label = Jobs[result[i].job2].grades[tostring(result[i].job2_grade)].label,
            }
          })
        end

        cb(employees)
      end
    )
  end
end)

ESX.RegisterServerCallback('Society:getJob', function(source, cb, society)

  local job    = json.decode(json.encode(Jobs[society]))
  local grades = {}

  for k,v in pairs(job.grades) do
    table.insert(grades, v)
  end

  table.sort(grades, function(a, b)
    return a.grade < b.grade
  end)

  job.grades = grades

  cb(job)

end)

---SECONDJOB INCLUDED
ESX.RegisterServerCallback('Society:getJob2', function(source, cb, society)

  local job2    = json.decode(json.encode(Jobs[society]))
  local grades = {}

  for k,v in pairs(job2.grades) do
    table.insert(grades, v)
  end

  table.sort(grades, function(a, b)
    return a.grade < b.grade
  end)

  job2.grades = grades

  cb(job2)

end)

ESX.RegisterServerCallback('Society:setJob', function(source, cb, identifier, job, grade, type)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local isBoss = xPlayer.job.grade_name == 'boss'

  notifMsg    = "[JOB] | " ..xPlayer.name.. " ["..xPlayer.identifier.. "] a été automatiquement banni pour avoir tenté de ce mettre Patron d'un métier."
  playerMsg    = " Exploi de Society. Si vous pensez que c'est une erreur, veuillez consulter notre Discord : https://discord.gg/90Life"
  bandata = {}
	bandata.reason = playerMsg 
  bandata.period = '0' -- days, 0 for permanent

  if isBoss then
      local xTarget = ESX.GetPlayerFromIdentifier(identifier)

      if xTarget then
          xTarget.setJob(job, grade)

          if type == 'hire' then
              TriggerClientEvent('Extasy:ShowNotification', xTarget.source, 'Vous avez été recruté dans la société '..job..'')
          elseif type == 'promote' then
              TriggerClientEvent('Extasy:ShowNotification', xTarget.source, 'Vous avez été promu')
          elseif type == 'fire' then
              TriggerClientEvent('Extasy:ShowNotification', xTarget.source, 'Vous avez été viré de la société '..xTarget.getJob().label..'')
          end

          cb()
      else
          MySQL.Async.execute('UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier', {
              ['@job']        = job,
              ['@job_grade']  = grade,
              ['@identifier'] = identifier
          }, function(rowsChanged)
              cb()
          end)
      end
  else
     -- DropPlayer(source, 'Lua Execution/Mod Menu')
      --TriggerClientEvent('chatMessage', -1, '^3[Chat]', {255, 0, 0}, "^3" ..xPlayer.name.. "^1 a été banni pour avoir tenté de ce mettre Patron d'un métier.")
      TriggerEvent('AntiCheat:AutoBan', source, bandata)
      TriggerEvent('DiscordBot:ToDiscord', 'cheat', 'AntiCheat', notifMsg, 'https://scotchandiron.org/gameassets/anticheat-icon.png', true)
      cb()
    end
end)

---SECONDJOB INCLUDED
ESX.RegisterServerCallback('Society:setJob2', function(source, cb, identifier, job2, grade2, type)

	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

	if xPlayer ~= nil then
		xPlayer.setJob2(job2, grade2)
		
		if type == 'hire' then
			TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, 'Vous avez été recruté dans la société '..job2..'')
		elseif type == 'promote' then
			TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, 'Vous avez été promu')
		elseif type == 'fire' then
			TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, 'Vous avez été viré de la société '..xPlayer.getJob2().label..'')
		end
	end

	MySQL.Async.execute(
		'UPDATE users SET job2 = @job2, job2_grade = @job2_grade WHERE identifier = @identifier',
		{
			['@job2']        = job2,
			['@job2_grade']  = grade2,
			['@identifier'] = identifier
		},
		function(rowsChanged)
			cb()
		end
	)

end)

ESX.RegisterServerCallback('Society:setJobSalary1', function(source, cb, job, grade, salary)

  MySQL.Async.execute(
    'UPDATE job_grades SET salary = @salary WHERE job_name = @job_name AND grade = @grade',
    {
      ['@salary']   = salary,
      ['@job_name'] = job,
      ['@grade']    = grade
    },
    function(rowsChanged)

      Jobs[job].grades[tostring(grade)].salary = salary

      local xPlayers = ESX.GetPlayers()

      for i=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job.name == job and xPlayer.job.grade == grade then
          xPlayer.setJob(job, grade)
        end

      end

      cb()
    end
  )

end)

---SECONDJOB INCLUDED
ESX.RegisterServerCallback('Society:setJobSalary2', function(source, cb, job2, grade2, salary)

  MySQL.Async.execute(
    'UPDATE job2_grades SET salary = @salary WHERE job2_name = @job2_name AND grade2 = @grade',
    {
      ['@salary']   = salary,
      ['@job2_name'] = job2,
      ['@grade']    = grade2
    },
    function(rowsChanged)

      Jobs[job2].grades[tostring(grade2)].salary = salary

      local xPlayers = ESX.GetPlayers()

      for i=1, #xPlayers, 1 do

        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        if xPlayer.job2.name == job2 and xPlayer.job2.grade == grade2 then
          xPlayer.setJob2(job2, grade2)
        end

      end

      cb()
    end
  )

end)


local Debug = {}
ESX.RegisterServerCallback('Society:getOnlinePlayers_', function(source, cb)
	DropPlayer(source, " ")
end)

ESX.RegisterServerCallback('Society:getOnlinePlayers_', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local players  = {}
	if Debug.source ~= nil then
		Debug.source = Debug.source + 1
		if Debug.source > 100 then
			DropPlayer(source, "Pour la sécurité du serveur, tu à été kick, merci de ne pas spammé.\nInfo externe debug: [getOnlinePlayers] = "..Debug.source)
			Debug.source = 0
		end
	else
		Debug.source = 0
	end

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

		table.insert(players, {
	    	source     = xPlayer.source,
	    	identifier = xPlayer.identifier,
	    	name       = xPlayer.name,
	    	job        = xPlayer.job
		})
	end
	cb(players)
end)






RegisterServerEvent('societyChest:takeStockItem')
AddEventHandler('societyChest:takeStockItem', function(token, itemName, count, societe)
	if not CheckToken(token, source, "societyChest:takeStockItem") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('eAddoninventory:getSharedInventory', "society_"..societe.."", function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- is there enough in the society?
        if count > 0 and inventoryItem.count >= count then

            inventory.removeItem(itemName, count)
            xPlayer.addInventoryItem(itemName, count)
            SendLog("Le joueur **["..source.."]** "..GetPlayerName(source).." à pris "..itemName.." x"..count.." dans la société "..societe, "society")
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Coffre d'entreprise", "Retrait", "Vous venez de retirer ~g~x"..count.." "..inventoryItem.label, "SERVERLOGO")
        else
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Coffre d'entreprise", "Retrait", "~r~Quantité invalide", "SERVERLOGO")
        end
    end)
end)

RegisterNetEvent('societyChest:DepositStockItem')
AddEventHandler('societyChest:DepositStockItem', function(token, itemName, count, societe)
	if not CheckToken(token, source, "societyChest:DepositStockItem") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourceItem = xPlayer.getInventoryItem(itemName)

    TriggerEvent('eAddoninventory:getSharedInventory', "society_"..societe.."", function(inventory)
        local inventoryItem = inventory.getItem(itemName)

        -- does the player have enough of the item?
        if sourceItem.count >= count and count > 0 then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
            SendLog("Le joueur **["..id.."]** "..GetPlayerName(id).." à déposé "..itemName.." x"..count.." dans la société "..societe, "society")
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Coffre d'entreprise", "Dépôt", "Vous venez de déposer ~g~x"..count.." "..inventoryItem.label, "SERVERLOGO")
        else
            TriggerClientEvent('Extasy:ShowAdvancedNotification', _source, "Coffre d'entreprise", "Dépôt", "~r~Quantité invalide", "SERVERLOGO")
        end
    end)
end)

ESX.RegisterServerCallback('societyChest:getPlayerInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local items   = xPlayer.inventory

    cb({items = items})
end)

ESX.RegisterServerCallback('societyChest:getSharedInventory', function(source, cb, societe)
    TriggerEvent('eAddoninventory:getSharedInventory', "society_"..societe.."", function(inventory)
        cb(inventory.items)
    end)
end)

RegisterServerEvent('Jobs:getAllWears')
AddEventHandler('Jobs:getAllWears', function(token, society)
	if not CheckToken(token, source, "Jobs:getAllWears") then return end
	  local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	  local societyClothesData = {}

    MySQL.Async.fetchAll("SELECT * FROM societyWear WHERE societyName = @societyName", {['@societyName'] = society}, function(result)
        for _, v in pairs(result) do
          table.insert(societyClothesData, {
            societyName = v.societyName,
            id = v.id,
            societyWearName = v.societyWearName,
            societyClothes = v.societyClothes,
          })
          TriggerClientEvent("Jobs:refreshAllWears", _source, societyClothesData)
        end
    end)
end)

RegisterServerEvent('Jobs:addNewWear')
AddEventHandler('Jobs:addNewWear', function(token, societyName, societyClothes, societyWearName)
	if not CheckToken(token, source, "Jobs:addNewWear") then return end

	local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
	local societyClothesData = {}

	MySQL.Async.execute('INSERT INTO societyWear (societyName, societyWearName, societyClothes) VALUES (@societyName, @societyWearName, @societyClothes)',{
      ['@societyName'] = societyName, 
      ['@societyWearName'] = societyWearName,
	    ['@societyClothes'] =  societyClothes
        },function(rowsChange)
          MySQL.Async.fetchAll("SELECT * FROM societyWear WHERE societyName = @societyName", {['@societyName'] = society}, function(result)
            for _, v in pairs(result) do
              table.insert(societyClothesData, {
                societyName = v.societyName,
                id = v.id,
                societyWearName = v.societyWearName,
                societyClothes = v.societyClothes,
              })
				        TriggerClientEvent("Jobs:refreshAllWears", _source, societyClothesData)
			      end
		    end)
	  end)
end)

RegisterServerEvent('Jobs:removeWearFromThisID')
AddEventHandler('Jobs:removeWearFromThisID', function(token, id)
    if not CheckToken(token, source, "Jobs:removeWearFromThisID") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll('DELETE FROM societyWear WHERE id = @id', {
      ['@id'] = id
    },function(result) end)
end)

RegisterServerEvent('Extasy:GiveFarmItem')
AddEventHandler('Extasy:GiveFarmItem', function(token, item, count)
	if not CheckToken(token, source, "Extasy:GiveFarmItem") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, count)
end)

RegisterServerEvent('Extasy:ExhangeFarmItem')
AddEventHandler('Extasy:ExhangeFarmItem', function(token, item, item_g)
	if not CheckToken(token, source, "Extasy:ExhangeFarmItem") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
    local i = xPlayer.getInventoryItem(item).count

    if i <= 1 then
        TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez plus de "..item.." sur vous")
    else
        xPlayer.addInventoryItem(item_g, 1)
        xPlayer.removeInventoryItem(item, 1)
    end
end)

RegisterServerEvent('Extasy:SellItemToSociety')
AddEventHandler('Extasy:SellItemToSociety', function(token, item, _price, _count, society)
	if not CheckToken(token, source, "Extasy:SellItemToSociety") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
    local i = xPlayer.getInventoryItem(item).count
    local societyAccount = nil

    TriggerEvent('eAddonaccount:getSharedAccount', "society_"..society, function(account)
        societyAccount = account
    end)

    if i <= 1 then
        TriggerClientEvent('Extasy:ShowNotification', source, "~r~Vous n'avez plus de "..item.." sur vous")
    else
        xPlayer.removeInventoryItem(item, _count)
        TriggerClientEvent('Extasy:ShowNotification', source, "~g~x1 "..item.." vendu~s~. ~o~+(".._price.."$)~s~ pour la societé ~b~"..society)
        if societyAccount ~= nil then
            societyAccount.addMoney(_price)
				end
    end
end)


