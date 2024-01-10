MySQL.ready(function ()
	Citizen.CreateThreadNow(function()
		Wait(15000)
		print("^4["..GetCurrentResourceName().."]: ^7Démarrage de la sauvegarde de la bdd dans le fichier: ^3"..cfg_savesql.file_name.."^7")
		local dados = nil
		local erro = false
		
		local logFile,errorReason = io.open(cfg_savesql.file_name,"w")
		if not logFile then return print("^8["..GetCurrentResourceName().."]: "..errorReason.."^7") end
		
		dados = MySQL.Sync.fetchAll("SHOW CREATE DATABASE `"..cfg_savesql.database.."`;", {})
		if dados then
			dados[1]["Create Database"] = dados[1]["Create Database"]:gsub("CREATE DATABASE", "CREATE DATABASE IF NOT EXISTS")
			logFile:write(dados[1]["Create Database"]..";\n\n")
			logFile:write("USE `"..cfg_savesql.database.."`;\n\n")
			for k,v in pairs(cfg_savesql.tables) do
				dados = MySQL.Sync.fetchAll("SHOW CREATE TABLE `"..cfg_savesql.database.."`.`"..v.."`;", {})
				if dados then
					dados[1]["Create Table"] = dados[1]["Create Table"]:gsub("CREATE TABLE", "CREATE TABLE IF NOT EXISTS")
					logFile:write(dados[1]["Create Table"]..";\n\n")
				
					if not cfg_savesql.structure_only then
						local insert = ""
						local linha = ""
						local columns = {}
						dados = MySQL.Sync.fetchAll("SELECT * FROM `information_schema`.`COLUMNS` WHERE TABLE_SCHEMA='"..cfg_savesql.database.."' AND TABLE_NAME='"..v.."' ORDER BY ORDINAL_POSITION;", {})
						for i,j in pairs(dados) do
							columns[i] = j['COLUMN_NAME']
							if insert == "" then
								insert = "INSERT INTO `"..v.."` (`"..j['COLUMN_NAME'].."`"
							else
								insert = insert..",`"..j['COLUMN_NAME'].."`"
							end
						end
						insert = insert..") VALUES\n"
						dados = MySQL.Sync.fetchAll("SELECT * FROM `"..v.."`", {})
						for i,j in pairs(dados) do
							linha = ""
							for l,m in pairs(columns) do
								if linha == "" then
									linha =  "\t("..trataTipo(j[m])
								else
									linha = linha..", "..trataTipo(j[m])
								end
							end
							if i == #dados then
								linha = linha..");\n"
							else
								linha = linha.."),\n"
							end
							insert = insert..linha
						end
						logFile:write(insert.."\n\n")
					end
					if cfg_savesql.debug then
						print("^4["..GetCurrentResourceName().."]: ^7Sauvegarde de la table: ^3"..v.."^7")
					end
				else
					print("^4["..GetCurrentResourceName().."]: ^8Table non valide: `"..cfg_savesql.database.."`.`"..v.."`^7")
					erro = true
				end
			end
		else
			print("^4["..GetCurrentResourceName().."]: ^8Base de données invalide: `"..cfg_savesql.database.."`^7")
			erro = true
		end
		
		print("^4["..GetCurrentResourceName().."]: ^7Fin de la sauvegarde de la bdd de 90's Life !")
		if erro then
			print("^4["..GetCurrentResourceName().."]: ^8Erreur de sauvegarde...^7")
		else
			print("^4["..GetCurrentResourceName().."]: ^2Sauvegarde faite avec succès !^7")
		end
		
		logFile:close()
	end)
end)

function trataTipo(node)
	if type(node) == "number" then
		return(node)
	elseif type(node) == "string" then
		return("'"..node.."'")
	elseif type(node) == "nil" then
		return("NULL")
	elseif type(node) == "boolean" then
		if node == true then
			return(1)
		else
			return(0)
		end
	else
		print("["..GetCurrentResourceName().."]: Type de données non valide: "..node.."("..type(node)..")")
	end
end


-- Debug functions
function sprint(sql)
	print("\n")
	print(sql)
	print_table(MySQL.Sync.fetchAll(sql, {}))
	print("\n")
end
function print_table(node)
    local cache, stack, output = {},{},{}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k,v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k,v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then

                if (string.find(output_str,"}",output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str,"\n",output_str:len())) then
                    output_str = output_str .. "\n"
                end

                -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
                table.insert(output,output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "["..tostring(k).."]"
                else
                    key = "['"..tostring(k).."']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = "..tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = {\n"
                    table.insert(stack,node)
                    table.insert(stack,v)
                    cache[node] = cur_index+1
                    break
                else
                    output_str = output_str .. string.rep('\t',depth) .. key .. " = '"..tostring(v).."'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                -- close the table
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
    table.insert(output,output_str)
    output_str = table.concat(output)

    print(output_str)
end