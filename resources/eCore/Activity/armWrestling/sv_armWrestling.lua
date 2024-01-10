local sessions = {}
local ESX
armWrestlingTable = {}
labelTable = {}

TriggerEvent("ext:getSharedObject", function(obj)
    ESX = obj
end)

RegisterServerEvent('armWrestling:getLeaderboard')
AddEventHandler('armWrestling:getLeaderboard', function(token)
	if not CheckToken(token, source, "armWrestling:getLeaderboard") then return end

	MySQL.Async.fetchAll("SELECT `identifier`, `firstname`, `lastname`, `wins`, `games` FROM `users` ORDER BY `wins` DESC", {}, function(result)
		MySQL.Async.fetchAll("SELECT * FROM `users` WHERE identifier = @identifier", {['@identifier'] = license}, function(result2)
            TriggerClientEvent('armWrestling:sendLeaderboard', -1, result, result2)
        end)
	end)
end)

RegisterServerEvent('armWrestling:lose')
AddEventHandler('armWrestling:lose', function(token)
    if not CheckToken(token, source, "armWrestling:lose") then return end
	local ids = GetPlayerIdentifiers(source)
    local license = GetPlayerLicense(ids)

	MySQL.Async.execute('UPDATE users SET games=games + @games WHERE identifier = @identifier', { ["@identifier"] = license, ["@games"] = 1})
    
	MySQL.Async.fetchAll("SELECT * FROM `users` ORDER BY `wins` DESC", {}, function(result)
        MySQL.Async.fetchAll("SELECT * FROM `users` WHERE identifier = @identifier", {['@identifier'] = license}, function(result2)
            TriggerClientEvent('armWrestling:sendLeaderboard', -1, result, result2)
        end)
	end)
end)

RegisterServerEvent('armWrestling:won')
AddEventHandler('armWrestling:won', function(token)
    if not CheckToken(token, source, "armWrestling:won") then return end
	local ids = GetPlayerIdentifiers(source)
    local license = GetPlayerLicense(ids)

	MySQL.Async.execute('UPDATE users SET wins=wins + @wins WHERE identifier = @identifier', { ["@identifier"] = license, ["@wins"] = 1})
    MySQL.Async.execute('UPDATE users SET games=games + @games WHERE identifier = @identifier', { ["@identifier"] = license, ["@games"] = 1})

	MySQL.Async.fetchAll("SELECT * FROM `users` ORDER BY `wins` DESC", {}, function(result)
		MySQL.Async.fetchAll("SELECT * FROM `users` WHERE identifier = @identifier", {['@identifier'] = license}, function(result2)
            TriggerClientEvent('armWrestling:sendLeaderboard', -1, result, result2)
        end)
	end)
end)

Citizen.CreateThread(function()
    local template = {place1 = 0, place2 = 0, started = false, grade = 0.5}
    for i, _ in pairs(cfg_armWrestling.props) do
        table.insert(sessions, template)
    end
end)

RegisterNetEvent('armWrestling:check_sv')
AddEventHandler('armWrestling:check_sv', function(token, position)
    if not CheckToken(token, source, "armWrestling:check_sv") then return end
    local a = position

    for i, props in pairs(cfg_armWrestling.props) do
        local pos = a - props.pos

        if #vec3(pos) < 1.5 then
            if sessions[i].place1 == 0 and not sessions[i].started then
                sessions[i].place1 = source
                TriggerClientEvent('armWrestling:check_cl', source, 'place1')
            elseif sessions[i].place2 == 0 and sessions[i].place1 ~= 0 then
                sessions[i].place2 = source
                TriggerClientEvent('armWrestling:check_cl', source, 'place2')
            else
                TriggerClientEvent('armWrestling:check_cl', source, 'noplace')
                return
            end

            if sessions[i].place1 ~= 0 and sessions[i].place2 ~= 0 and not sessions[i].started then
                TriggerClientEvent('armWrestling:start_cl', sessions[i].place1)
                TriggerClientEvent('armWrestling:start_cl', sessions[i].place2)
                break
            end

        end
    end
end)

RegisterNetEvent('armWrestling:updategrade_sv')
AddEventHandler('armWrestling:updategrade_sv', function(token, gradeUpValue)
    if not CheckToken(token, source, "armWrestling:updategrade_sv") then return end

    for i, props in pairs(sessions) do

        if props.place1 == source or props.place2 == source then
            props.grade = props.grade + gradeUpValue
            if props.grade <= 0.10 then
                props.grade = -999
            elseif props.grade >= 0.90 then
                props.grade = 999
            end
            
            TriggerClientEvent('armWrestling:updategrade_cl', props.place1, props.grade)
            TriggerClientEvent('armWrestling:updategrade_cl', props.place2, props.grade)
            break
        end

    end

end)

RegisterNetEvent('armWrestling:disband_sv')
AddEventHandler('armWrestling:disband_sv', function(token, position)
    if not CheckToken(token, source, "armWrestling:disband_sv") then return end
    local a2 = position
   
    for i, props in pairs(cfg_armWrestling.props) do
        local pos2 = a2 - props.pos
        local _source = source

        if #vec3(pos2) < 1.5 then
            if sessions[i].place1 == source or sessions[i].place2 == source then
                local k = i
                if sessions[i].place1 ~= 0 then
                    TriggerClientEvent('armWrestling:reset_cl', sessions[k].place1)
                end
                if sessions[i].place2 ~= 0 then
                    TriggerClientEvent('armWrestling:reset_cl', sessions[i].place2)
                end
                Wait(100)
                sessions[i].started = false
                sessions[i].place1 = 0
                sessions[i].place2 = 0
                sessions[i].grade = 0.5        
                break
            end

        end
    end

end)

resetSession = function(i)
    sessions[i] = {place1 = 0, place2 = 0, started = false, grade = 0.5}
end

GetPlayerLicense = function(ids)
	for _,v in pairs(ids) do
	  if string.find(v, 'license') then
		return v
	  end
	end
  
	return false
end


