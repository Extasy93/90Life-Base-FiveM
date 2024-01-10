ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
    end
end)

InWork = false

MenuFarmJobsMine = false

RMenu.Add('Extasy_mine', 'main', RageUI.CreateMenu("Mine", nil))
RMenu:Get('Extasy_mine', 'main'):SetSubtitle("~p~[Boby] ~w~Chef de la Mine")
RMenu:Get('Extasy_mine', 'main').Closed = function()
    MenuFarmJobsMine = false
end

function openFarmJobsMineMenu()
	if not MenuFarmJobsMine then 
		MenuFarmJobsMine = true
		RageUI.Visible(RMenu:Get('Extasy_mine', 'main'), true)
	
		Citizen.CreateThread(function()
			while MenuFarmJobsMine do
            Citizen.Wait(1)
            RageUI.IsVisible(RMenu:Get('Extasy_mine', 'main'), true, true, true, function()

            if not inWork then
                RageUI.Button("Demander à Travailer dans la Mine", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        Extasy.ShowNotification("Alors comme ça tu veux bosser à la ~g~Mine~w~ pas vrai ? Très bien, met un casque et prends tes outils ! Si tu es faible , dis le moi tout de suite !")
                        inWork = true
                        local model = GetEntityModel(GetPlayerPed(-1))
                            TriggerEvent('skinchanger:getSkin', function(skin)
                            if model == GetHashKey("mp_m_freemode_01") then
                                clothesSkin = {
                                    ['bags_1'] = 0, ['bags_2'] = 0,
                                    ['tshirt_1'] = 15, ['tshirt_2'] = 0,
                                    ['torso_1'] = 143, ['torso_2'] = 0,
                                    ['arms'] = 0,
                                    ['pants_1'] = 19, ['pants_2'] = 3,
                                    ['shoes_1'] = 42, ['shoes_2'] = 0,
                                    ['mask_1'] = 0, ['mask_2'] = 0,
                                    ['bproof_1'] = 3,
                                    ['helmet_1'] = 0, ['helmet_2'] = 0
                                }
                            else
                                clothesSkin = {
                                    ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
                                    ['torso_1'] = 81,   ['torso_2'] = 1,
                                    ['decals_1'] = 0,   ['decals_2'] = 0,
                                    ['arms'] = 0,
                                    ['pants_1'] = 18,   ['pants_2'] = 3,
                                    ['shoes_1'] = 26,   ['shoes_2'] = 0,
                                    ['helmet_1'] = 0,  ['helmet_2'] = 0,
                                    ['chain_1'] = -1,    ['chain_2'] = 0,
                                    ['mask_1'] = -1,  	['mask_2'] = 0,
                                    ['bproof_1'] = 5,  	['bproof_2'] = 0,
                                    ['ears_1'] = -1,     ['ears_2'] = 0,
                                    ['bags_1'] = 0,    ['bags_2'] = 0,
                                    ['glasses_1'] = 5,    ['glasses_2'] = 0
                                }
                            end
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                        end)
                        if not ESX.Game.IsSpawnPointClear(vector3(2843.071, 2784.613, 59.94376), 6.0) then
                            local veh = ESX.Game.GetClosestVehicle(vector3(2843.071, 2784.613, 59.94376))
                            TriggerEvent("LS_LSPD:RemoveVeh", token, veh)
                        end
                        ESX.Game.SpawnVehicle(GetHashKey("sadler"), vector3(2843.071, 2784.613, 59.94376), 59.144374847412, function(veh)
                            SetVehicleOnGroundProperly(veh)
                            vehicle = NetworkGetNetworkIdFromEntity(veh)
                        end)
                        DebutTravail("mineur")
                    end
                end)
            else
                RageUI.Button("Arreter De Travailler", "", {}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        Extasy.ShowNotification("Ah ! Tu stop déja ? je savais que tu étais Faible , tiens prend ta paye")
                        inWork = false
                        FinTravail()
                        TriggerEvent("LS_LSPD:RemoveVeh", token, NetworkGetEntityFromNetworkId(vehicle))
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                            local isMale = skin.sex == 0
                            TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                    TriggerEvent('skinchanger:loadSkin', skin)
                                    TriggerEvent('esx:restoreLoadout')
                                end)
                            end)
                        end)
                    end
                end)
            end
        end, function()
        end)   
    end
end)
end
end
