ESX = nil
TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('Serflex', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("Extasy:useSerflex", source)
	TriggerClientEvent('Extasy:ShowNotification', source, 'Vous avez utilisé x1 Serflex')
end)

ESX.RegisterUsableItem('Chaise', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("Extasy:usechaise", source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez utilisé une chaise de jardin vert'))
end)

ESX.RegisterUsableItem('Chaise2', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("Extasy:usechaise2", source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez utilisé une chaise de jardin plad'))
end)

ESX.RegisterUsableItem('margarita', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('margarita', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 90)
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé une pizza margarita'))
end)

ESX.RegisterUsableItem('pizzapepperoni', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pizzapepperoni', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 90)
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé une pizza pepperoni'))
end)

ESX.RegisterUsableItem('pizzajambonchampignon', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('pizzajambonchampignon', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 90)
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé une pizza jambon champignons'))
end)

ESX.RegisterUsableItem('mozzarellasticks', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('mozzarellasticks', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé un mozzarella stick'))
end)

ESX.RegisterUsableItem('cacahuète', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cacahuète', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé des cacahuètes'))
end)

ESX.RegisterUsableItem('bretzels', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bretzels', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé un bretzel'))
end)

ESX.RegisterUsableItem('barrechocolat', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('barrechocolat', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé un bretzel'))
end)

ESX.RegisterUsableItem('saucisson', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('saucisson', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé du saucisson'))
end)

ESX.RegisterUsableItem('cookie', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('cookie', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé un cookie'))
end)

ESX.RegisterUsableItem('popcorn', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('popcorn', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé du popcorn'))
end)

ESX.RegisterUsableItem('Donut', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Donut', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé un Donut'))
end)

ESX.RegisterUsableItem('vine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('vine', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu du vin'))
end)

ESX.RegisterUsableItem('Heineken', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Heineken', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu une Heineken'))
end)

ESX.RegisterUsableItem('Sprunk', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Sprunk', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu une Sprunk'))
end)

ESX.RegisterUsableItem('redbull', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('redbull', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu une Redbull'))
end)

ESX.RegisterUsableItem('limonade', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('limonade', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu une limonade'))
end)

ESX.RegisterUsableItem('icetea', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('icetea', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un icetea'))
end)

ESX.RegisterUsableItem('drpepper', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('drpepper', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un Dr Pepper'))
end)

ESX.RegisterUsableItem('jus_raisin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('jus_raisin', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un jus de raisin'))
end)


ESX.RegisterUsableItem('jusfruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('jusfruit', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un jus de fruit'))
end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('bread', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé du pain'))
end)

ESX.RegisterUsableItem('barre_proteine', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('barre_proteine', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé une Barre Protéinée'))
end)

ESX.RegisterUsableItem('Shaker', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Shaker', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)   
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un Shaker'))
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('water', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)   
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu de l\'eau'))
end)

ESX.RegisterUsableItem('Biere', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Biere', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)   
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu de la Biere'))
end)

ESX.RegisterUsableItem('Whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Whisky', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)   
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu de la Whisky'))
end)

ESX.RegisterUsableItem('fanta', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('fanta', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)   
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez bu un fanta'))
end)

ESX.RegisterUsableItem('sprite', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sprite', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez bu un sprite'))
end)

ESX.RegisterUsableItem('Jus_orange', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Jus_orange', 1)
	TriggerClientEvent("Extasy:AddThirst", source, 30)
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez bu un Jus d\'orange'))
end)

ESX.RegisterUsableItem('Chips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('Chips', 1)
	TriggerClientEvent("Extasy:AddHunger", source, 30)
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé des chips'))
end)

ESX.RegisterUsableItem('cheesebows', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cheesebows', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	

	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé des chips fromage'))
end)

ESX.RegisterUsableItem('chips', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('chips', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	

	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé des chips barbecue'))
end)

ESX.RegisterUsableItem('pizza', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('pizza', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé une pizza'))
end)

ESX.RegisterUsableItem('frite', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('frite', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	

	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé des frite'))
end)


ESX.RegisterUsableItem('banana', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('banana', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé une banane'))
end)


ESX.RegisterUsableItem('hamburger', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hamburger', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé un hambuger'))
end)

ESX.RegisterUsableItem('HotDog', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('HotDog', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé un HotDog'))
end)


ESX.RegisterUsableItem('soda', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('soda', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onSoda', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un soda'))
end)

ESX.RegisterUsableItem('cocacola', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cocacola', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onCanette', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un coca bien frais chakal'))
end)

ESX.RegisterUsableItem('raisin', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('raisin', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('tu as mangé du raisin'))

end)


ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tequila', 1)
 
	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	
	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu de la tequilla'))
end)

ESX.RegisterUsableItem('jagerbomb', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
 
	xPlayer.removeInventoryItem('jagerbomb', 1)
 
	TriggerClientEvent("Extasy:AddHunger", source, 30)
    

	TriggerClientEvent('esx_optionalneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un jagerbomb'))
end)

ESX.RegisterUsableItem('grapperaisin', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('grapperaisin', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrinkGrapperaisin', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Vous avez mangé une grappe de raisin'))
end)

ESX.RegisterUsableItem('martini', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('martini', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrinkMartini', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un martini'))
end)

ESX.RegisterUsableItem('rhum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhum', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onDrinkRhum', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu du rhum'))
end)

ESX.RegisterUsableItem('whisky', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('whisky', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onDrinkWhisky', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu du whisky'))
end)

ESX.RegisterUsableItem('vodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodka', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onDrinkVodka', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu de la vodka'))
end)

ESX.RegisterUsableItem('saucisson', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('saucisson', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('tu as manger du saucisson'))
end)

ESX.RegisterUsableItem('breadsaucisson', function(source)

local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('breadsaucisson', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('tu a manger du saucisson dans le pain'))
end)

ESX.RegisterUsableItem('hamburgerplate', function(source)

local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('hamburgerplate', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('tu as mager un hamburgerplate'))
end)

ESX.RegisterUsableItem('bolcacahuetes', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('bolcacahuetes', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	

	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('tu as mager un bol de cacahuetes'))

end)

ESX.RegisterUsableItem('bolnoixcajou', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('bolnoixcajou', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	

	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('tu as mager un bol de noix de cajoux'))

end)

ESX.RegisterUsableItem('bolpistache', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('bolpistache', 1)

	TriggerClientEvent("Extasy:AddHunger", source, 30)
    
	

	TriggerClientEvent('eBasicneeds:onEat', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('tu as mager un bol de psitache'))

end)


ESX.RegisterUsableItem('whiskycoca', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('whiskycoca', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un whisky coca'))

end)

ESX.RegisterUsableItem('vodkaenergy', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('vodkaenergy', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu une vodka energiser'))

end)

ESX.RegisterUsableItem('vodkafruit', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('vodkafruit', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu une voka jus de friut'))

end)

ESX.RegisterUsableItem('rhumfruit', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('rhumfruit', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un rhum jus de fruit'))

end)

ESX.RegisterUsableItem('teqpaf', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('teqpaf', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu une tequilla frapper'))

end)

ESX.RegisterUsableItem('Champagne', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('Champagne', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un Champagne'))

end)


ESX.RegisterUsableItem('rhumcoca', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('rhumcoca', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un rhum coca'))

end)


ESX.RegisterUsableItem('mojito', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('mojito', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un mojito'))

end)

ESX.RegisterUsableItem('metreshooter', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('metreshooter', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un metreshooter'))

end)

ESX.RegisterUsableItem('jagercerbere', function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('jagercerbere', 1)

	TriggerClientEvent("Extasy:AddThirst", source, 30)
    
	TriggerClientEvent('eBasicneeds:onDrink', source)
	TriggerClientEvent('Extasy:ShowNotification', source, ('Tu as bu un jagercerbere'))

end)

ESX.RegisterUsableItem('lockpickcar', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('lockpickcar', 1)

	TriggerClientEvent('Lockpickcar:open', source)
end)

TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local playerId = tonumber(args[1])

		-- is the argument a number?
		if playerId then
			-- is the number a valid player?
			if GetPlayerName(playerId) then
				--print(('eBasicneeds: %s à soigné %s'):format(GetPlayerIdentifier(source, 1), GetPlayerIdentifier(playerId, 1)))
				TriggerClientEvent('eBasicneeds:healPlayer', playerId)
				TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'Vous avez été soigné.' } })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Joueur non connecté.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'ID Incorrecte.' } })
		end
	else
		--print(('eBasicneeds: %s healed self'):format(GetPlayerIdentifier(source, 1)))
		TriggerClientEvent('eBasicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', params = {{name = 'playerId', help = '(optional) player id'}}})