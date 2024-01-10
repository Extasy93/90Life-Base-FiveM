ESX = nil
local PlayerData = {}
dataNumber = nil
dataLoaded = true

CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end

    ESX.PlayerData = ESX.GetPlayerData()

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    while ESX.GetPlayerData().job2 == nil do
        Wait(0)
    end
end)

LoadData = function()
    if playerJob == 'vcpd' then
        print("^6VCPD data loaded")
        InitVCPD()
    elseif playerJob == 'concess' then
        print("^6Concess data loaded")
        --initData()
    elseif playerJob == 'bikeshop' then
        print("^6Concessionnaire moto data loaded")
        BIKESHOP.initData()
    elseif playerJob == 'Concessionnaire aérien' then
        print("^6Concessionnaire aérien data loaded")
        --initData()
        
    elseif playerJob == 'boatshop' then
        print("^6Concessionnaire bateau data loaded")
        InitBoatshop()
    elseif playerJob == 'ambulance' then
        print("^6VCMS data loaded")
        InitVCMS()
    elseif playerJob == 'tabac' then
        print("^6Tabac & Co data loaded")
        InitTabac()
    elseif playerJob == 'weedshop' then
        print("^6Weedshop data loaded")
        InitWeedshop()
    elseif playerJob == 'weazelnews' then
        print("^6Weazel News data loaded")
        InitWeazelNews()
    elseif playerJob == 'taxi' then
        print("^6Downtown Cab Co data loaded")
        InitTaxi()
    elseif playerJob == 'malibu' then
        print("^6Malibu data loaded")
        InitGrossiste()
        InitMalibu()
    elseif playerJob == 'pizza' then
        print("^6Pizza data loaded")
        InitGrossiste()
        InitPizza()
    elseif playerJob == 'robina' then
        print("^6Robina data loaded")
        InitGrossiste()
        InitRobina()
    elseif playerJob == 'label' then
        print("^6Label data loaded")
        InitLabel()
    elseif playerJob == 'frontpage' then
        print("^6Front Page data loaded")
        InitGrossiste()
        InitFront()
    elseif playerJob == 'vccustoms' then
        print("^6Vice City Customs data loaded")
        InitVcCustoms()
    elseif playerJob == 'avocat' then
        print("^6Avocat data loaded")
        InitAvocat()
    elseif playerJob == 'oceanview' then
        print("^6Ocean View data loaded")
        InitGrossiste()
        InitOceanView()
    elseif playerJob == 'greasychopper' then
        print("^6The Greasy Chopper View data loaded")
        InitGrossiste()
        InitGreasyChopper()
    elseif playerJob == 'cityhall' then
        print("^6City Hall (Mairie) data loaded")
        InitCityHall()
    elseif playerJob == 'icecream' then
        print("^6Ice cream data loaded")
        InitGrossiste()
        InitIce()
    end

    print("^6Player loaded, job '"..string.upper(playerJob).."' grade '"..playerJob_grade.."'")
end

RegisterNetEvent('Jobs:sendNotifToPlayerJob')
AddEventHandler('Jobs:sendNotifToPlayerJob', function(type, msg, pos)
    if playerJob == "vcpd" then 
        if type == 1 then
            Extasy.ShowAdvancedNotification("~b~V.C.P.D", "~r~Alerte", msg, "CHAR_VCPD")

            local radius = AddBlipForRadius(coords, 70.0)
            SetNewWaypoint(coords)
            SetBlipAlpha(radius, 250)
            SetBlipColour(radius, 1)


            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Braquage d'épicerie")
            EndTextCommandSetBlipName(blip)
            Extasy.ShowNotification("~c~Zone afficher pendant 180 Secondes")

            Wait(180*1000)
            RemoveBlip(radius)
            RemoveBlip(blip)
        elseif type == 2 then
            Extasy.ShowNotification(msg)
        elseif type == 3 then
            Extasy.ShowAdvancedNotification("~b~V.C.P.D", "~r~Alerte", msg, "CHAR_VCPD")

            local radius = AddBlipForRadius(coords, 70.0)
            SetNewWaypoint(coords)
            SetBlipAlpha(radius, 250)
            SetBlipColour(radius, 1)


            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Cambriolage de maison")
            EndTextCommandSetBlipName(blip)
            Extasy.ShowNotification("~c~Zone afficher pendant 180 Secondes")

            Wait(180*1000)
            RemoveBlip(radius)
            RemoveBlip(blip)
        end
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
    playerJob = job.name
    playerJob_grade = job.grade
    LoadData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

CreateThread(function()
    while true do
        --if playerInServiceLoop then
            Wait(extasy_core_cfg["time_to_wait_for_reward_service"]*60*1000)

            if extasy_core_cfg["reward_money_service_"..ESX.PlayerData.job.name] ~= nil then
                TriggerServerEvent("Extasy:AddPayToPlayer", token, extasy_core_cfg["reward_money_service_"..ESX.PlayerData.job.name]*extasy_core_cfg["reward_money_service_mult"])
                Extasy.ShowNotification("~g~Vous avez perçu votre salaire en tant que: ~s~"..ESX.PlayerData.job.name.."\n\n~g~Total du salaire perçu: ~s~"..extasy_core_cfg["reward_money_service_"..ESX.PlayerData.job.name]*extasy_core_cfg["reward_money_service_mult"].."$")
            end
        --end
    end
end)

startServiceLoop = function()
    playerInServiceLoop = true
end