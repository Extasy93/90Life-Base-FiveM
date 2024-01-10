ESX                    = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Extasy:DeleteTenue')
AddEventHandler('Extasy:DeleteTenue', function(token, id,label)
  if not CheckToken(token, source, "Extasy:DeleteTenue") then return end

  MySQL.Async.execute('DELETE FROM user_tenue WHERE id = @id',
    {
      ['@id'] =  id
    }
  )
  TriggerClientEvent("Extasy:ShowNotification", source, "Tenue supprimé")
end)

RegisterServerEvent('Extasy:RenameTenue')
AddEventHandler('Extasy:RenameTenue', function(token, id,label)
  if not CheckToken(token, source, "Extasy:RenameTenue") then return end
  MySQL.Async.execute(
    'UPDATE user_tenue SET label = @label WHERE id = @id',
    {
      ['@id'] = id,
      ['@label'] = label

    }
  )
  TriggerClientEvent("Extasy:showNotification",source,"Vous avez bien renommé votre tenue en "..label)
end)

ESX.RegisterServerCallback('Extasy:getMask', function(source, cb)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  
  MySQL.Async.fetchAll(
    'SELECT * FROM user_accessories WHERE identifier = @identifier',
    {
        ['@identifier'] = xPlayer.identifier
    },
    function(result)
      cb(result)
  end)
end)

ESX.RegisterServerCallback('Extasy:BuyVetement', function (source, cb, price)
	local _source = source
  local xPlayer  = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
    xPlayer.removeMoney(price)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent('Extasy:SaveTenueS')
AddEventHandler('Extasy:SaveTenueS', function(token, label,skin)
  if not CheckToken(token, source, "Extasy:SaveTenueS") then return end
  local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
  MySQL.Async.execute(
    'INSERT INTO user_tenue (identifier,label,tenue) VALUES(@identifier,@label,@skin)',
    {
      ['@label'] = label, 
      ['@skin'] = json.encode(skin),

    ['@identifier'] =  xPlayer.identifier
    }
  )

end)

RegisterServerEvent("Extasy:GetTenues")
AddEventHandler("Extasy:GetTenues", function(token)
  if not CheckToken(token, source, "Extasy:GetTenues") then return end
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll(
      'SELECT * FROM user_tenue WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.identifier
      },
      function(result)
          TriggerClientEvent("clothes:receveClothes", _source, result)
      end
    )
end)

RegisterServerEvent('Extasy:Delclo')
AddEventHandler('Extasy:Delclo', function(token, id,label,data)
  if not CheckToken(token, source, "Extasy:Delclo") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

			

			
			MySQL.Async.execute(
				'DELETE FROM user_accessories where id = @id',
				{
					['@id']   = id,

		
				}
			)
      TriggerClientEvent('Extasy:showNotification', _source, '~r~-1 '.. label)
      TriggerClientEvent("Extasy:SyncAccess",source)

end)

RegisterServerEvent("Extasy:SetNewMasque")
AddEventHandler("Extasy:SetNewMasque", function(token, mask,variation,type,label)
  if not CheckToken(token, source, "Extasy:SetNewMasque") then return end
  maskx = {mask_1=mask,mask_2=variation}
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.getMoney() >= 25 then
    xPlayer.removeMoney(25)
  MySQL.Async.execute(
    'INSERT INTO user_accessories (identifier,mask,type,label) VALUES(@identifier,@mask,@type,@label)',
    {
      
      ['@mask'] = json.encode(maskx),
      ['@type'] = type,
      ['@label'] = label,
    ['@identifier'] =  xPlayer.identifier
    }
  )
  TriggerClientEvent("Extasy:SyncAccess",source)
  TriggerClientEvent("Extasy:showNotification",source,"~g~Vous avez reçu un nouveau " .. type .."~n~~r~-25$" )
else
  TriggerClientEvent('Extasy:showNotification', _source, 'Pas assez d\'argent (25$)')
end
end)



RegisterServerEvent('Extasy:GiveAccessories')
AddEventHandler('Extasy:GiveAccessories', function(token, target,id,label)
  if not CheckToken(token, source, "Extasy:GiveAccessories") then return end
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayer2 = ESX.GetPlayerFromId(target)
	MySQL.Async.execute(
		'UPDATE user_accessories SET identifier = @identifier WHERE id = @id',
		{
			['@identifier']   = xPlayer2.identifier,
			['@id'] = id

		}
	)
			TriggerClientEvent('Extasy:showNotification', _source, '~r~-1 '.. label)
			TriggerClientEvent('Extasy:showNotification', target, '~g~+1 '.. label)
		
			TriggerClientEvent("Extasy:SyncAccess",source)
			TriggerClientEvent("Extasy:SyncAccess",target)

end)

RegisterServerEvent('Extasy:GiveClothes')
AddEventHandler('Extasy:GiveClothes', function(token, item, count, data, label)
	if not CheckToken(token, source, "Extasy:GiveClothes") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local FinalResult = {}

    --xPlayer.addInventoryItem(item, count)

    print(data)
    print(label)

    MySQL.Async.execute('INSERT INTO player_clothes (identifier, data, label) VALUES (@identifier, @data, @label)',{
        ['@identifier']  = xPlayer.identifier,
        ['@data']        = json.encode(data),
        ['@label']       = label, 
      },function(rowsChange)
            MySQL.Async.fetchAll('SELECT * FROM player_clothes WHERE identifier = @identifier',
            {
                ['@identifier'] = xPlayer.identifier
            },
            function(result)
                for _,v in pairs(result) do
                    d = json.decode(v.data)
                    table.insert(FinalResult, {
                        id   	 	    = v.id,
                        identifier  = v.identifier,
                        data      	= d,
                        label   	  = v.label
                    })
                    TriggerClientEvent("Extasy:sendClothesData", _source, FinalResult)
                end
            end)
      end)
end)

RegisterServerEvent('Extasy:updateNameForThisClothes')
AddEventHandler('Extasy:updateNameForThisClothes', function(token, id, newName)
	if not CheckToken(token, source, "Extasy:updateNameForThisClothes") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local FinalResult = {}

    MySQL.Async.execute('UPDATE player_clothes SET label = @label WHERE id = @id', {
		['@id'] = id,
		['@label'] = newName
	}, function()
	end)

	MySQL.Async.fetchAll('SELECT * FROM player_clothes WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.identifier
      },
      function(result)
        for _,v in pairs(result) do
          d = json.decode(v.data)
            table.insert(FinalResult, {
              id   	 	= v.id,
              identifier  = v.identifier,
              data      	= d,
              label   	= v.label
            })
			      TriggerClientEvent("Extasy:sendClothesData", _source, FinalResult)
        end
    end)
end)

RegisterServerEvent('Extasy:deleteThisClothes')
AddEventHandler('Extasy:deleteThisClothes', function(token, id)
	if not CheckToken(token, source, "Extasy:deleteThisClothes") then return end

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local FinalResult = {}

    MySQL.Async.execute('DELETE FROM player_clothes WHERE id = @id', {
		['@id'] = id
	}, function()
	end)

	MySQL.Async.fetchAll('SELECT * FROM player_clothes WHERE identifier = @identifier',
      {
        ['@identifier'] = xPlayer.identifier
      },
      function(result)
		for _,v in pairs(result) do
			d = json.decode(v.data)
            table.insert(FinalResult, {
              id   	 	    = v.id,
              identifier  = v.identifier,
              data      	= d,
              label   	  = v.label
            })
			      TriggerClientEvent("Extasy:sendClothesData", _source, FinalResult)
        end
    end)
end)