ESX = nil

TriggerEvent("ext:getSharedObject", function(obj) ESX = obj end)

-- source = Buyer
-- sender = Vendeur

RegisterServerEvent('Billing:PayeByBankMoney')
AddEventHandler('Billing:PayeByBankMoney', function(token, id, thePrice, sender, deduce, society, execute, action, hash, name)
    if not CheckToken(token, source, "Billing:PayeByBankMoney") then return end
    local xPlayer = ESX.GetPlayerFromId(id)
    if xPlayer.getBank() >= thePrice then
        xPlayer.removeAccountMoney('bank', thePrice)
        if deduce == nil then
            print(society)
            TriggerClientEvent("billing:isGood", source, thePrice, sender, thePrice, society, execute, action, source, hash, name, shopCart, shopProfit)
            TriggerClientEvent("Extasy:ShowAdvancedNotification", sender, "Transaction effectuée", "Facturation", "La personne vient de payer la facture, votre société a reçu le virement de "..thePrice.."$", "BILLING")
            TriggerClientEvent("Extasy:ShowAdvancedNotification", source, "Transaction effectuée", "Facturation", "Vous avez payé une facture de "..thePrice.."$ ("..society..")", "BILLING")
        else
            print(society)
            TriggerClientEvent("billing:isGood", source, thePrice, sender, deduce, society, execute, action, source, hash, name, shopCart, shopProfit)
            TriggerClientEvent("Extasy:ShowAdvancedNotification", sender, "Transaction effectuée", "Facturation", "La personne vient de payer la facture, votre société a reçu le virement de "..deduce.."$", "BILLING")
            TriggerClientEvent("Extasy:ShowAdvancedNotification", source, "Transaction effectuée", "Facturation", "Vous avez payé une facture de "..deduce.."$ ("..society..")", "BILLING")
        end
    else
        TriggerClientEvent("Extasy:ShowAdvancedNotification", sender, "Erreur", "Facturation", "~r~La personne a essayé de payer mais n'avais pas assez d'argent en banque", "BILLING")
        TriggerClientEvent("Extasy:ShowAdvancedNotification", source, "Erreur", "Facturation", "~r~Vous n'avez pas assez d'argent sur votre compte", "BILLING")
        TriggerClientEvent("billing:isNotGood", source)

        if society == "vccustoms" then
            TriggerClientEvent('VcCustoms:cantBill', source)
            TriggerClientEvent('VcCustoms:resetVehicle', source, VehiclesInShop[xPlayer.identifier])
            VehiclesInShop[xPlayer.identifier] = nil
            return
        end
	end
end)

RegisterServerEvent('Billing:PayeByMoney')
AddEventHandler('Billing:PayeByMoney', function(token, id, thePrice, sender, deduce, society, execute, action, hash, name)
    if not CheckToken(token, source, "Billing:PayeByMoney") then return end

    local xPlayer = ESX.GetPlayerFromId(id)

    if xPlayer.getMoney() >= thePrice then
        xPlayer.removeMoney(thePrice)
        if deduce == nil then
            TriggerClientEvent("billing:isGood", source, thePrice, sender, thePrice, society, execute, action, source, hash, name)
            TriggerClientEvent("Extasy:ShowAdvancedNotification", sender, "Transaction effectuée", "Facturation", "La personne vient de payer la facture, votre société a reçu le virement de "..thePrice.."$", "BILLING")
            TriggerClientEvent("Extasy:ShowAdvancedNotification", source, "Transaction effectuée", "Facturation", "Vous avez payé une facture de "..thePrice.."$ ("..society..")", "BILLING")
        else
            TriggerClientEvent("billing:isGood", source, thePrice, sender, deduce, society, execute, action, source, hash, name)
            TriggerClientEvent("Extasy:ShowAdvancedNotification", sender, "Transaction effectuée", "Facturation", "La personne vient de payer la facture, votre société a reçu le virement de "..deduce.."$", "BILLING")
            TriggerClientEvent("Extasy:ShowAdvancedNotification", source, "Transaction effectuée", "Facturation", "Vous avez payé une facture de "..deduce.."$ ("..society..")", "BILLING")
        end
    else
        TriggerClientEvent("Extasy:ShowAdvancedNotification", sender, "Erreur", "Facturation", "~r~La personne a essayé de payer mais n'avais pas assez d'argent en banque", "BILLING")
        TriggerClientEvent("billing:isNotGood", source)

        if society == "vccustoms" then
            TriggerClientEvent('VcCustoms:cantBill', source)
            TriggerClientEvent('VcCustoms:resetVehicle', source, VehiclesInShop[xPlayer.identifier])
            VehiclesInShop[xPlayer.identifier] = nil
            return
        end
	end
end)

RegisterServerEvent('Billing:notBuy')
AddEventHandler('Billing:notBuy', function(token, sender)
    if not CheckToken(token, source, "Billing:notBuy") then return end
    local xPlayer = ESX.GetPlayerFromId(source)

    TriggerClientEvent("Extasy:ShowAdvancedNotification", sender, "Transaction annulée", "Facturation", "~r~La personne a refusé de payer la facture", "BILLING")
    TriggerClientEvent("Extasy:ShowAdvancedNotification", source, "Transaction annulée", "Facturation", "~r~Vous avez refusé de payer la facture", "BILLING")
    TriggerClientEvent("billing:isNotGood", source)

    if society == "vccustoms" then
        TriggerClientEvent('VcCustoms:cantBill', source)
        TriggerClientEvent('VcCustoms:resetVehicle', source, VehiclesInShop[xPlayer.identifier])
        VehiclesInShop[xPlayer.identifier] = nil
        return
    end
end)

RegisterServerEvent('Extasy:ProcessPaySociety')
AddEventHandler('Extasy:ProcessPaySociety', function(token, society, deduce, sender)
    if not CheckToken(token, source, "Extasy:ProcessPaySociety") then return end

    local xPlayer = ESX.GetPlayerFromId(source)
    local societyAccount = nil

    print("Process Pay: "..society.." for "..deduce.."$")
    TriggerEvent('eAddonaccount:getSharedAccount', "society_"..society, function(account)
        societyAccount = account
    end)

    if societyAccount ~= nil then
        societyAccount.addMoney(deduce)
    end
end)
