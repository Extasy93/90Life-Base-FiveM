ESX = {}
ESX.Players = {}
ESX.UsableItemsCallbacks = {}
ESX.Items = {}
ESX.ServerCallbacks = {}
ESX.TimeoutCount = -1
ESX.CancelledTimeouts = {}
ESX.Pickups = {}
ESX.PickupId = 0
ESX.Jobs = {}
ESX.RegisteredCommands = {}

-- Add a seperate table for ExtendedMode functions, but using metatables to limit feature usage on the ESX table
-- This is to provide backward compatablity with ESX but not add new features to the old ESX tables.
-- Note: Please add all new namespaces to ExM _after_ this block
do
    local function processTable(thisTable)
        local thisObject = setmetatable({}, {
            __index = thisTable
        })
        for key, value in pairs(thisTable) do
            if type(value) == "table" then
                thisObject[key] = processTable(value)
            end
        end
        return thisObject
    end
    ExM = processTable(ESX)
end

AddEventHandler('ext:getSharedObject', function(cb)
	cb(ESX)
end)

exports("getSharedObject", function()
	return ESX
end)

exports("getExtendedModeObject", function()
	return ExM
end)

-- Globals to check if OneSync or Infinity for exclusive features
ExM.IsOneSync = GetConvar('onesync_enabled', false) == 'true'
ExM.IsInfinity = GetConvar('onesync_enableInfinity', false) == 'true'

ExM.DatabaseReady = false
ExM.DatabaseType = nil

print('[ExtendedMode] [^2INFO^7] Demarrage du mode Extended par Extasy#0093...')

MySQL.ready(function()
	print('[ExtendedMode] [^2INFO^7] Verification de votre base de donnees [90\'s Life]...')
	
	-- Check the information schema for the tables that match the esx ones
	MySQL.Async.fetchAll("SELECT TABLE_NAME AS 't', COLUMN_NAME AS 'c' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'users' or TABLE_NAME = 'user_inventory' or TABLE_NAME = 'user_accounts'", {}, function(informationSchemaResult)
		local databaseCheckFunction = function()
			-- Ensure we have a result that we can iterate
			if type(informationSchemaResult) ~= "table" then
				print('[ExtendedMode] [^1ERROR^7] Votre base de donnees n\'est pas compatible avec ExtendedMode !\nS\'il s\'agit d\'une nouvelle installation, vous avez peut-être oublie d\'importer le modèle SQL.')
				error()
			end

			-- Coagulate table columns from results
			local tableMatchings = {}
			for _, data in ipairs(informationSchemaResult) do
				tableMatchings[data.t] = tableMatchings[data.t] or {}
				tableMatchings[data.t][data.c] = true
			end

			-- Check for invalid scenarios
			if not tableMatchings["users"] then
				print("[ExtendedMode] [^1ERROR^7] Votre base de donnees n\'est pas compatible avec ExtendedMode !\nVous n\'avez pas de table d'utilisateurs. Veuillez importer le modèle SQL qui se trouve dans le repertoire des ressources.")
				error()
			else
				if tableMatchings["users"]["inventory"] and tableMatchings["users"]["accounts"] then
					ExM.DatabaseType = "newesx"
				elseif tableMatchings["user_inventory"] and tableMatchings["user_accounts"] then
					ExM.DatabaseType = "es+esx"
				else
					print("[ExtendedMode] [^1ERROR^7] Votre base de donnees n\'est pas compatible avec ExtendedMode !\nVous n'avez nulle part ou stocker l'inventaire ou les informations de compte.\nLa reimportation du modèle SQL peut regler ce problème !")
					error()
				end
			end

			-- Do some other database type validation... (this is temporary!)
			if ExM.DatabaseType then
				if ExM.DatabaseType == "es+esx" then
					print("[ExtendedMode] [^1ERROR^7] Votre base de donnees utilise le format de stockage 'es+esx'.\nCette version d'ExtendedMode n'est pas encore totalement compatible avec ce format de stockage.\nVous pouvez essayer de migrer automatiquement votre base de donnees au bon format en utilisant la commande ^4`migratedb`^0 directement dans la console de votre serveur.")
					error()
				elseif ExM.DatabaseType == "newesx" then -- redundant check as there are no other database types but oh well, future proofing I guess
					print(("[ExtendedMode] [^2INFO^7] Votre base de donnees utilise le format de stockage '%s', demarrage..."):format(ExM.DatabaseType))
				else
					print(("[ExtendedMode] [^2INFO^7] Votre base de donnees utilise le format de stockage '%s', qui n'est ^1pas^7 compatible avec ExtendedMode !"):format(ExM.DatabaseType))
					error()
				end
			else
				print("[ExtendedMode] [^1ERROR^7] Une erreur inconnue s'est produite lors de la determination du format de stockage de votre base de donnees !")
				error()
			end
		end

		if pcall(databaseCheckFunction) then
			MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
				for k,v in ipairs(result) do
					ESX.Items[v.name] = {
						label = v.label,
						weight = v.weight,
						rare = v.rare,
						limit = v.limit,
						canRemove = v.can_remove
					}
				end
			end)
		
			MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(jobs)
				for k,v in ipairs(jobs) do
					ESX.Jobs[v.name] = v
					ESX.Jobs[v.name].grades = {}
				end
		
				MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(jobGrades)
					for k,v in ipairs(jobGrades) do
						if ESX.Jobs[v.job_name] then
							ESX.Jobs[v.job_name].grades[tostring(v.grade)] = v
						else
							--print(('[ExtendedMode] [^3WARNING^7] Ignorer le job "%" en raison d\'un job manquant'):format(v.job_name))
						end
					end
		
					for k2,v2 in pairs(ESX.Jobs) do
						if ESX.Table.SizeOf(v2.grades) == 0 then
							ESX.Jobs[v2.name] = nil
							--print(('[ExtendedMode] [^3WARNING^7] Ignorer les grade "%" parce qu\'aucun jobs_grade n\'a ete trouvee'):format(v2.name))
						end
					end
				end)
			end)
	
			-- Wait for the db sync function to be ready incase it isn't ready yet somehow.
			if not ESX.StartDBSync or not ESX.StartPayCheck then
				print('[ExtendedMode] [^2INFO^7] ExtendedMode a ete initialise correctement')
				while not ESX.StartDBSync and not ESX.StartPayCheck do
					Wait(1000)
				end
			end
	
			ExM.DatabaseReady = true
	
			-- Start DBSync and the paycheck
			ESX.StartDBSync()
			--ESX.StartPayCheck()
	
			print('[ExtendedMode] [^2INFO^7] ExtendedMode a ete initialise correctement')
		else
			print('[ExtendedMode] [^1ERROR^7] ExtendedMode n\'a pas ete en mesure d\'initialiser la base de donnees et ne peut pas continuer, voir ci-dessus pour plus d\'informations.')
		end
	end)
end)

RegisterServerEvent('Extasy:InitialiseBddForOrg')
AddEventHandler('Extasy:InitialiseBddForOrg', function()
	print('[ExtendedMode] [^2INFO^7] RE-Verification la BDD [90\'s Life] pour les organisation ...')
	
	-- Check the information schema for the tables that match the esx ones
	MySQL.Async.fetchAll("SELECT TABLE_NAME AS 't', COLUMN_NAME AS 'c' FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'users' or TABLE_NAME = 'user_inventory' or TABLE_NAME = 'user_accounts'", {}, function(informationSchemaResult)

		MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
			for k,v in ipairs(result) do
				ESX.Items[v.name] = {
					label = v.label,
					weight = v.weight,
					rare = v.rare,
					limit = v.limit,
					canRemove = v.can_remove
				}
			end
		end)
	
		MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(jobs)
			for k,v in ipairs(jobs) do
				ESX.Jobs[v.name] = v
				ESX.Jobs[v.name].grades = {}
			end
	
			MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(jobGrades)
				for k,v in ipairs(jobGrades) do
					if ESX.Jobs[v.job_name] then
						ESX.Jobs[v.job_name].grades[tostring(v.grade)] = v
					--else
						--print(('[ExtendedMode] [^3WARNING^7] Ignorer le job "%" en raison d\'un job manquant'):format(v.job_name))
					end
				end
	
				for k2,v2 in pairs(ESX.Jobs) do
					if ESX.Table.SizeOf(v2.grades) == 0 then
						ESX.Jobs[v2.name] = nil
						--print(('[ExtendedMode] [^3WARNING^7] Ignorer les grade "%" parce qu\'aucun jobs_grade n\'a ete trouvee'):format(v2.name))
					end
				end
			end)
		end)

		if not ESX.StartDBSync or not ESX.StartPayCheck then
			print('[ExtendedMode] [^2INFO^7] ExtendedMode a été re-initialise correctement')
			while not ESX.StartDBSync and not ESX.StartPayCheck do
				Wait(1000)
			end
		end

		ExM.DatabaseReady = true

		ESX.StartDBSync()
	end)
end)

RegisterServerEvent('esx:clientLog')
AddEventHandler('esx:clientLog', function(msg)
	if Config.EnableDebug then
		print(('[ExtendedMode] [^2TRACE^7] %s^7'):format(msg))
	end
end)

RegisterServerEvent('esx:triggerServerCallback')
AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
	local playerId = source

	--print("Trigger SPAM:^6 "..name)

	ESX.TriggerServerCallback(name, requestId, playerId, function(...)
		TriggerClientEvent('esx:serverCallback', playerId, requestId, ...)
	end, ...)
end)
