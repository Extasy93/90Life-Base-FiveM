ESX                    = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

local arrayWeight = Coffre.localWeight
local VehicleList = { }
local VehicleInventory = {}

--[[AddEventHandler('onMySQLReady', function ()
	MySQL.Async.execute( 'DELETE FROM `trunk_inventory` WHERE `owned` = 0', {})
end)]]

function getItemWeight(item)
  local weight = 0
  local itemWeight = 0
    if item ~= nil then
      itemWeight = Coffre.DefaultWeight
      if arrayWeight[item] ~= nil then
        itemWeight = arrayWeight[item]
      end
    end
  return itemWeight
end

function getInventoryWeight(inventory)
  local weight = 0
  local itemWeight = 0
  if inventory ~= nil then
	  for i=1, #inventory, 1 do
	    if inventory[i] ~= nil then
	      itemWeight = Coffre.DefaultWeight
	      if arrayWeight[inventory[i].name] ~= nil then
	        itemWeight = arrayWeight[inventory[i].name]
	      end
	      weight = weight + (itemWeight * (inventory[i].count or 1))
	    end
	  end
  end
  return weight
end

function getTotalInventoryWeight(plate)
  local total
  TriggerEvent('esx_truck:getSharedDataStore',plate,function(store)
    local W_weapons = getInventoryWeight(store.get('weapons') or {})
    local W_coffre = getInventoryWeight(store.get('coffre') or {})
    local W_blackMoney =0
    local blackAccount = (store.get('black_money')) or 0

    if blackAccount ~=0 then
      W_blackMoney = blackAccount[1].amount /10
    end
    total = W_weapons + W_coffre + W_blackMoney 
  end)
  return total
end

ESX.RegisterServerCallback('esx_truck:getInventoryV',function(source,cb,plate)
  TriggerEvent('esx_truck:getSharedDataStore',plate,function(store)
    local blackMoney = 0
    local items      = {}
    local weapons    = {}
    weapons = (store.get('weapons') or {})

    local blackAccount = (store.get('black_money')) or 0

    if blackAccount ~=0 then
      blackMoney = blackAccount[1].amount
    end

    local coffre = (store.get('coffre') or {})
    for i=1,#coffre,1 do
      table.insert(items,{name=coffre[i].name,count=coffre[i].count,label=ESX.GetItemLabel(coffre[i].name)})
    end

    local weight = getTotalInventoryWeight(plate)
    cb({
    blackMoney = blackMoney,
    items      = items,
    weapons    = weapons,
    weight     = weight
    })
  end)
end)

RegisterServerEvent('esx_truck:getItem')
AddEventHandler('esx_truck:getItem', function(token, plate, type, item, count)
  if not CheckToken(token, source, "esx_truck:getItem") then return end

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)

  if type == 'item_standard' then

    TriggerEvent('esx_truck:getSharedDataStore', plate, function(store)
      local coffre = (store.get('coffre') or {})
      for i=1, #coffre,1 do
        if coffre[i].name == item then
          if (coffre[i].count >= count and count > 0) then
            xPlayer.addInventoryItem(item, count)
            SendLog("``Le joueur [".._source.."] "..GetPlayerName(_source).." à retiré "..item.." x"..count.." dans le véhicule ["..plate.."]``", "veh")
            if (coffre[i].count - count) == 0 then
              table.remove(coffre,i)
            else
              coffre[i].count = coffre[i].count - count
            end
            break
          else
            TriggerClientEvent('Extasy:showNotification', _source, '~r~Quantité invalide')
          end
        end
      end


      store.set('coffre',coffre)
    end)
  end

  if type == 'item_account_black' then

    TriggerEvent('esx_truck:getSharedDataStore', plate, function(store)

      local blackMoney = store.get('black_money')
      if (blackMoney[1].amount >= count and count > 0) then
        blackMoney[1].amount = blackMoney[1].amount - count
        store.set('black_money', blackMoney)
        xPlayer.addAccountMoney("black_money", count)
      else
        TriggerClientEvent('Extasy:showNotification', _source,'Montant invalide')
      end
    end)

  end

  if type == 'item_weapon' then

    TriggerEvent('esx_truck:getSharedDataStore',  plate, function(store)

      local storeWeapons = store.get('weapons')

      if storeWeapons == nil then
        storeWeapons = {}
      end

      local weaponName   = nil
      local ammo         = nil

      for i=1, #storeWeapons, 1 do
        if storeWeapons[i].name == item then

          weaponName = storeWeapons[i].name
          ammo       = storeWeapons[i].ammo

          table.remove(storeWeapons, i)

          break
        end
      end

      store.set('weapons', storeWeapons)

      xPlayer.addWeapon(weaponName, ammo)
      TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, weaponName, ammo, "Depuis le coffre d'un vehicule")
    end)
  end
end)

RegisterServerEvent('esx_truck:putItem')
AddEventHandler('esx_truck:putItem', function(token, plate, type, item, count,max)
  if not CheckToken(token, source, "esx_truck:putItem") then return end

  local _source      = source
  local xPlayer      = ESX.GetPlayerFromId(_source)
  local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

  if type == 'item_standard' then

    local playerItemCount = xPlayer.getInventoryItem(item).count

    if (playerItemCount >= count and count > 0 )then


      TriggerEvent('esx_truck:getSharedDataStore', plate, function(store)
        local found = false
        local coffre = (store.get('coffre') or {})


        for i=1,#coffre,1 do
          if coffre[i].name == item then
            coffre[i].count = coffre[i].count + count
            found = true
          end
        end
        if not found then
          table.insert(coffre, {
            name = item,
            count = count
          })
        end
        if (getTotalInventoryWeight(plate)+(getItemWeight(item)*count))>max then
            TriggerClientEvent('Extasy:showNotification', _source, 'plus de place dans le ~r~ coffre')
        else
          store.set('coffre', coffre)
          xPlayer.removeInventoryItem(item, count)
          SendLog("``Le joueur [".._source.."] "..GetPlayerName(_source).." à déposé "..item.." x"..count.." dans le véhicule ["..plate.."]``", "veh")
        end
      end)

    else
      TriggerClientEvent('Extasy:showNotification', _source, 'Quantité invalide')
    end

  end

  if type == 'item_account_black' then

    local playerAccountMoney = xPlayer.getAccount(item).money


    if (playerAccountMoney >= count and count > 0) then


      TriggerEvent('esx_truck:getSharedDataStore', plate , function(store)

        local blackMoney = (store.get('black_money') or nil)
        if blackMoney ~= nil then
          blackMoney[1].amount = blackMoney[1].amount + count
        else
          blackMoney = {}
          table.insert(blackMoney,{amount=count})
        end

        if (getTotalInventoryWeight(plate)+blackMoney[1].amount/10) > max then
          TriggerClientEvent('Extasy:showNotification', _source, 'plus de place dans le ~r~ coffre')
        else
          xPlayer.removeAccountMoney(item, count)
          store.set('black_money', blackMoney)
        end
      end)

    else
      TriggerClientEvent('Extasy:showNotification', _source, 'Montant invalide')
    end

  end


  if type == 'item_weapon' then

    TriggerEvent('esx_truck:getSharedDataStore', plate, function(store)

      local storeWeapons = store.get('weapons')

      if storeWeapons == nil then
        storeWeapons = {}
      end

      table.insert(storeWeapons, {
        name = item,
        ammo = count
      })
      if (getTotalInventoryWeight(plate)+(getItemWeight(item)))>max then
          TriggerClientEvent('Extasy:showNotification', _source, 'plus de place dans le ~r~ coffre')
      else
        store.set('weapons', storeWeapons)
        xPlayer.removeWeapon(item)
        TriggerEvent("over:logsmoicadelete", _source, item, 0)
      end
    end)

  end

end)