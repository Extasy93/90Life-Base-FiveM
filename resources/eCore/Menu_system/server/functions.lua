ESX = nil

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Extasy:StartLegal')
AddEventHandler('Extasy:StartLegal', function(token)
    if not CheckToken(token, source, "Extasy:StartLegal") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local money = 15000
    xPlayer.addMoney(money)
    TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Starter Pack", "~g~ INFO !", "Tu vien de séléctioner le pack ~g~Légal\n" , "CHAR_CASINO_MANAGER", 24,5)
end)

RegisterServerEvent('Extasy:StartIllegal')
AddEventHandler('Extasy:StartIllegal', function(token)
    if not CheckToken(token, source, "Extasy:StartIllegal") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addWeapon("WEAPON_BAT", 1) -- Arme de départ

    TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, "WEAPON_BAT", 1, "Starter Pack")
    
    TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Starter Pack", "~g~ INFO !", "Tu vien de séléctioner le pack ~r~Illégal\n" , "CHAR_CASINO_MANAGER", 24,5)
end)

--FUNCTION BUY ITEMS SHOP/QUINCAILLERIE

RegisterServerEvent('buyBlackItems')
AddEventHandler('buyBlackItems', function(token, thePrice,theItem,theLabel)
    if not CheckToken(token, source, "buyBlackItems") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)


    if xPlayer.getMoney() >= thePrice then
        xPlayer.removeMoney(thePrice)
        xPlayer.addInventoryItem(theItem, 1)
        TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Vendeur ", " illégal !", "~w~ Vous avez payé : ~g~ "..thePrice.. "$", "CHAR_DEFAULT", 24,5)
    else
       TriggerClientEvent('Extasy:showNotification',xPlayer.source,"~w~Vous n'avez pas assez ~h~~r~ d'argent !")
	end
end)

--FUNCTION BUY WEAPONS WEAPON SHOP


RegisterServerEvent('Extasy:buyWeaponShop')
AddEventHandler('Extasy:buyWeaponShop', function(token, theWeapon, thePrice, index, theLabel)
    if not CheckToken(token, source, "Extasy:buyWeaponShop") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if index == 1 then
        if xPlayer.getBank() >= thePrice then
            xPlayer.removeAccountMoney('bank',thePrice)
            xPlayer.addInventoryItem(theWeapon, 1)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~r~Armurerie", "Achat éfféctué", "Vous venez d'acheter ~g~"..theLabel.."", "CHAR_AMMUNATION")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur votre compte")
        end
    elseif index == 2 then
        if xPlayer.getMoney() >= thePrice then
            xPlayer.removeMoney(thePrice)
            xPlayer.addInventoryItem(theWeapon, 1)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~r~Armurerie", "Achat éfféctué", "Vous venez d'acheter ~g~"..theLabel.."", "CHAR_AMMUNATION")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent sur vous")
        end
    elseif index == 3 then
        if xPlayer.getAccount('black_money').money >= thePrice then
            xPlayer.removeAccountMoney('black_money', tonumber(thePrice))
            xPlayer.addInventoryItem(theWeapon, 1)
            TriggerClientEvent('Extasy:ShowAdvancedNotification', xPlayer.source, "~r~Armurerie", "Achat éfféctué", "Vous venez d'acheter ~g~"..theLabel.."", "CHAR_AMMUNATION")
        else
            TriggerClientEvent('Extasy:ShowNotification', xPlayer.source, "~r~Vous n'avez pas assez d'argent de source inconnue")
        end
    end
end)

RegisterServerEvent('buyWeaponsBoutique')
AddEventHandler('buyWeaponsBoutique', function(token, theWeapon,cb,thePrice)
    if not CheckToken(token, source, "buyWeaponsBoutique") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local monnaie = 0
    local weaponData = nil

    for i=1, #Weapon, 1 do
		if Weapon[i].model == thePrice then
			weaponsData = Weapon[i]
			break
		end
	end

    MySQL.Async.fetchAll('SELECT boutiquearg FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function (result)

        if result[1] then

            if result[1].boutiquearg == nil then
                monnaie = 0
            else
                monnaie = tonumber(result[1].boutiquearg)
            end

            if monnaie >= weaponsData.thePrice then
                MySQL.Async.execute(
                'UPDATE users SET boutiquearg = boutiquearg - @price WHERE identifier = @identifier',
                {
                    ['@identifier'] = xPlayer.identifier,
                    ['@price']     = weaponsData.thePrice
                })

                cb(true)
                xPlayer.addWeapon(theWeapon)
                TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, theWeapon, 1, "Boutique")
            else
                local _source = source
                TriggerClientEvent('Extasy:showNotification', _source, 'Veuillez contacter le concessionnaire intérimaire ~r~(Extasy#0093) ~s~sur la radio de la ville pour acheter ce véhicule.')
                cb(false)
            end
        end

    end)

end)


RegisterServerEvent('buyWeaponsIllegals')
AddEventHandler('buyWeaponsIllegals', function(token, theWeapon,thePrice)
    if not CheckToken(token, source, "buyWeaponsIllegals") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= thePrice then
        xPlayer.removeMoney(thePrice)
        xPlayer.addWeapon(theWeapon)
        TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, theWeapon, 250, "Illegal Shop")

        TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Vendeurs d'armes", "~r~ INFO !", "~w~Vous avez achetez une ~h~arme ilégal" , "CHAR_LJT", 24,5)
    else
  	    TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Vendeurs d'armes ", "~r~ INFO !", "~w~Vous n'avez pas assez ~h~ d'argent " , "CHAR_LJT", 24,5)
	end
end)

RegisterServerEvent('buyitemIllegal')
AddEventHandler('buyitemIllegal', function(token, theWeapon,thePrice)
    if not CheckToken(token, source, "buyitemIllegal") then return end
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer.getMoney() >= thePrice then
        xPlayer.removeMoney(thePrice)
        xPlayer.addWeapon(theWeapon)
        TriggerEvent("over:creationarmestupeuxpasdeviner", token, _source, theWeapon, 250, "Illegal Shop2")

        TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Vendeurs d'object", "~r~ INFO !", "~w~Vous avez achetez un ~h~object ilégal" , "CHAR_LJT", 24,5)
    else
  	    TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Vendeurs d'object ", "~r~ INFO !", "~w~Vous n'avez pas assez ~h~ d'argent " , "CHAR_LJT", 24,5)
	end
end)

ESX.RegisterServerCallback('buyLicense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 15000 then
		xPlayer.removeMoney(15000)
        TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Armurier ", "~r~ INFO !", "~w~Vous avez achetez une ~h~license de port d'arme" , "CHAR_AMMUNATION", 24,5)
		TriggerEvent('eLicense:addLicense', source, 'weapon', function()
			cb(true)
		end)
	else
        TriggerClientEvent('Extasy:showAdvancedNotification',xPlayer.source,"Armurier ", "~r~ INFO !", "~w~Vous n'avez pas assez ~h~ d'argent " , "CHAR_AMMUNATION", 24,5)
		cb(false)
	end
end)