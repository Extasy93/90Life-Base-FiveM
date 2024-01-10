ESX = nil

TriggerEvent('esxc:getSharedObject', function(obj) ESX = obj end)
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esxc:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

  ESX.RegisterUsableItem('jumelles', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent('jumelles:Active', source)
  end)
end)
