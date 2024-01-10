ESX = nil
local animalerie_open = false
local pet_open = false
local PetName = ""
Animal = {}
Animal.data = {}

local ped, model, object, animation = {}, {}, {}, {}
local status = 100
local objCoords
local come = 0
local isAttached, getball, inanimation, balle = false ,false, false, false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	DoRequestModel(-1788665315) -- chien
	DoRequestModel(1682622302) -- loup
	DoRequestModel(-541762431) -- lapin
	DoRequestModel(1318032802) -- husky
	DoRequestModel(-1323586730) -- cochon
	DoRequestModel(1125994524) -- caniche
	DoRequestModel(1832265812) -- carlin
	DoRequestModel(882848737) -- retriever
	DoRequestModel(1126154828) -- berger
	DoRequestModel(-1384627013) -- westie
	DoRequestModel(351016938)  -- rottweiler
end)

RMenu.Add('Extasy_animalerie', 'main_menu', RageUI.CreateMenu("Animalerie", "Que souhaitez-vous acheter ?", 1, 100))
RMenu.Add('Extasy_animalerie', 'pet_menu', RageUI.CreateMenu("Mes animaux", "Gestion de vos animaux", 1, 100))
RMenu:Get('Extasy_animalerie', 'main_menu').Closed = function()
    animalerie_open = false
end
RMenu:Get('Extasy_animalerie', 'pet_menu').Closed = function()
    pet_open = false
end

openAnimalerieMenu = function()
    if animalerie_open then
        animalerie_open = false
        return
    else
        animalerie_open = true
        Citizen.CreateThread(function()
			RageUI.Visible(RMenu:Get('Extasy_animalerie', 'main_menu'), true)
            while animalerie_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('Extasy_animalerie', 'main_menu'), true, true, true, function()
					RageUI.Separator("~p~← Animaux disponibles →");
					for k,v in pairs(cfg_animalerie.pets) do
						RageUI.Button("• "..v.label, nil, {RightLabel = "~p~["..Extasy.Math.GroupDigits(v.price).."$]"}, true, function(h, a, s) 
							if s then
								ESX.TriggerServerCallback('Extasy:buyPet', function(boughtPed)
									if boughtPed then
										RageUI.CloseAll()
										pet_open = false
									end
								end, v.label)
							end
						end)
                    end
                end, function()
                end)
            end
        end)
    end
end

openPetMenu = function()
    if pet_open then
        pet_open = false
        return
    else
        pet_open = true
        Citizen.CreateThread(function()
			RageUI.Visible(RMenu:Get('Extasy_animalerie', 'pet_menu'), true)
            while pet_open do
                Wait(1)
                RageUI.IsVisible(RMenu:Get('Extasy_animalerie', 'pet_menu'), true, true, true, function()
					if come == 1 then
						RageUI.Separator("Nom de votre animal - ~o~"..PetName.."~s~")
						RageUI.Separator("Taux de faim - ~p~"..status.."%~s~")

						RageUI.Separator("")

						RageUI.Button("Donner de la nourriture", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
							if s then
								local inventory = ESX.GetPlayerData().inventory
								local coords1   = GetEntityCoords(PlayerPedId())
								local coords2   = GetEntityCoords(ped)
								local distance  = GetDistanceBetweenCoords(coords1, coords2, true)

								local count = 0
								for i=1, #inventory, 1 do
									if inventory[i].name == 'croquettes' then
										count = inventory[i].count
									end
								end
								if distance < 5 then
									if count >= 1 then
										if status < 100 then
											status = status + math.random(2, 15)
											Extasy.ShowNotification('Vous avez nourri votre animal.')
											TriggerServerEvent('Extasy:consumePetFood', token)
											if status > 100 then
												status = 100
											end
										else
											Extasy.ShowNotification('Votre animal n\'a plus faim.')
										end
									else
										Extasy.ShowNotification('~r~Tu n\'as pas de nourriture pour ton animal ! ~s~')
									end
								else
									Extasy.ShowNotification('~r~Votre animal est trop loin ! ~s~')
								end
							end
						end)

						RageUI.Button("Mettre dans la niche", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
							if s then
								local GroupHandle = GetPlayerGroup(PlayerId())
								local coords      = GetEntityCoords(PlayerPedId())
	
								Extasy.ShowNotification('L\'animal est retourné dans votre maison / hôtel')
	
								SetGroupSeparationRange(GroupHandle, 1.9)
								SetPedNeverLeavesGroup(ped, false)
								TaskGoToCoordAnyMeans(ped, coords.x + 40, coords.y, coords.z, 5.0, 0, 0, 786603, 0xbf800000)
	
								Citizen.Wait(5000)
								DeleteEntity(ped)
								come = 0
	
								RageUI.CloseAll()
								pet_open = false
							end
						end)

						RageUI.Button("Changer de nom", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
							if s then
								local NewPetName = KeyboardInput('Inscrivez le nouveau nom de votre animal', 'Roger', 20)

								TriggerServerEvent("Extasy:ChangePetName", token, NewPetName)

								ESX.TriggerServerCallback('Extasy:getPetName', function(result)
									PetName = result
								end)

								Wait(1000)

								Extasy.ShowNotification('Le nom de votre animal a été changé par: ~o~'..NewPetName)
							end
						end)

						RageUI.Separator("")

						RageUI.Button("Ordonner de ne pas bouger", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
							if s then
								if not IsPedSittingInAnyVehicle(ped) then
									if isAttached == false then
										attached()
										isAttached = true
									else
										detached()
										isAttached = false
									end
									else
									Extasy.ShowNotification('~r~On attache pas un animal dans un véhicule !~s~')
								end
							end
						end)
				
						local playerPed = PlayerPedId()
						local vehicle  = GetVehiclePedIsUsing(playerPed)
						local coords   = GetEntityCoords(playerPed)
						local coords2  = GetEntityCoords(ped)
						local distance = GetDistanceBetweenCoords(coords, coords2, true)

						RageUI.Button("Ordonner de descendre du véhicule", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
							if s then
								if IsPedSittingInAnyVehicle(playerPed) then
									if distance < 8 then
										attached()
										Citizen.Wait(200)
										if IsVehicleSeatFree(vehicle, 1) then
											SetPedIntoVehicle(ped, vehicle, 1)
											isInVehicle = true
										elseif IsVehicleSeatFree(vehicle, 2) then
											isInVehicle = true
											SetPedIntoVehicle(ped, vehicle, 2)
										elseif IsVehicleSeatFree(vehicle, 0) then
											isInVehicle = true
											SetPedIntoVehicle(ped, vehicle, 0)
										end
				
										RageUI.CloseAll()
										pet_open = false
									else
										Extasy.ShowNotification('~r~Votre animal est trop loin du véhicule ! ~s~')
									end
								else
									Extasy.ShowNotification('Vous devez être dans un vehicule !')
								end
							end
						end)

						RageUI.Button("Ordonner de monter dans le véhicule", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
							if s then
								if not IsPedSittingInAnyVehicle(playerPed) then
									SetEntityCoords(ped, coords,1,0,0,1)
									Citizen.Wait(100)
									detached()
									isInVehicle = false
									RageUI.CloseAll()
									pet_open = false
								else
									Extasy.ShowNotification('Vous êtes toujours dans un véhicule')
								end
							end
						end)

						RageUI.Separator("")

						if not inanimation then
							if pet ~= 'chat' then
								RageUI.Button("Ordonner d'aller chercher la balle", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
									if s then
										local pedCoords = GetEntityCoords(ped)
										object = GetClosestObjectOfType(pedCoords, 190.0, GetHashKey('w_am_baseball'))
						
										if DoesEntityExist(object) then
											balle = true
											objCoords = GetEntityCoords(object)
											TaskGoToCoordAnyMeans(ped, objCoords, 5.0, 0, 0, 786603, 0xbf800000)
											local GroupHandle = GetPlayerGroup(PlayerId())
											SetGroupSeparationRange(GroupHandle, 1.9)
											SetPedNeverLeavesGroup(ped, false)
											RageUI.CloseAll()
											pet_open = false
										else
											Extasy.ShowNotification('Tu n\'as pas de ~b~balle~s~')
										end	
									end
								end)
							end
				

							if Animal.data.follow == nil then Animal.data.follow = false end
                            if Animal.data.follow then
                                RageUI.Button("Ordonner de suivre", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                    if s then
                                        CreateThread(function()
                                            FollowAnimal(ped)
                                        end)
                                    end
                                end)
                            else
                                RageUI.Button("Ordonner de ne plus suivre", nil, {RightLabel = "→→→"}, true, function(h, a, s)
                                    if s then
                                        CreateThread(function()
                                            FollowAnimal(ped)
                                        end)
                                    end
                                end)
                            end

							RageUI.Button("Ordonner de venir au pied", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
								if s then
									local coords = GetEntityCoords(PlayerPedId())
									TaskGoToCoordAnyMeans(ped, coords, 5.0, 0, 0, 786603, 0xbf800000)
									Extasy.ShowNotification('L\'animal vient à vos pieds')
								end
							end)
				
							if pet == 'Chien' then
								RageUI.Button("Ordonner de s'asseoir", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
									if s then
										DoRequestAnimSet('creatures@rottweiler@amb@world_dog_sitting@base')
										TaskPlayAnim(ped, 'creatures@rottweiler@amb@world_dog_sitting@base', 'base' ,8.0, -8, -1, 1, 0, false, false, false)
										inanimation = true
										RageUI.CloseAll()
										pet_open = false
									end
								end)
								RageUI.Button("Ordonner de se coucher", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
									if s then
										DoRequestAnimSet('creatures@rottweiler@amb@sleep_in_kennel@')
										TaskPlayAnim(ped, 'creatures@rottweiler@amb@sleep_in_kennel@', 'sleep_in_kennel' ,8.0, -8, -1, 1, 0, false, false, false)
										inanimation = true
										RageUI.CloseAll()
										pet_open = false
									end
								end)
							elseif pet == 'Chat' then
								RageUI.Button("Ordonner de se coucher", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
									if s then
										DoRequestAnimSet('creatures@cat@amb@world_cat_sleeping_ground@idle_a')
										TaskPlayAnim(ped, 'creatures@cat@amb@world_cat_sleeping_ground@idle_a', 'idle_a' ,8.0, -8, -1, 1, 0, false, false, false)
										inanimation = true
										RageUI.CloseAll()
										pet_open = false
									end
								end)
							elseif pet == 'Loup' then
								RageUI.Button("Ordonner de se coucher", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
									if s then
										DoRequestAnimSet('creatures@coyote@amb@world_coyote_rest@idle_a')
										TaskPlayAnim(ped, 'creatures@coyote@amb@world_coyote_rest@idle_a', 'idle_a' ,8.0, -8, -1, 1, 0, false, false, false)
										inanimation = true
										RageUI.CloseAll()
										pet_open = false
									end
								end)
							elseif pet == 'Carlin' then
								RageUI.Button("Ordonner de s'asseoir", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
									if s then
										DoRequestAnimSet('creatures@carlin@amb@world_dog_sitting@idle_a')
										TaskPlayAnim(ped, 'creatures@carlin@amb@world_dog_sitting@idle_a', 'idle_b' ,8.0, -8, -1, 1, 0, false, false, false)
										inanimation = true
										RageUI.CloseAll()
										pet_open = false
									end
								end)
							elseif pet == 'Retriever' then
								RageUI.Button("Ordonner de s'asseoir", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
									if s then
										DoRequestAnimSet('creatures@retriever@amb@world_dog_sitting@idle_a')
										TaskPlayAnim(ped, 'creatures@retriever@amb@world_dog_sitting@idle_a', 'idle_c' ,8.0, -8, -1, 1, 0, false, false, false)
										inanimation = true
										RageUI.CloseAll()
										pet_open = false
									end
								end)
							elseif pet == 'Rottweiler' then
								RageUI.Button("Ordonner de s'asseoir", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
									if s then
										DoRequestAnimSet('creatures@rottweiler@amb@world_dog_sitting@idle_a')
										TaskPlayAnim(ped, 'creatures@rottweiler@amb@world_dog_sitting@idle_a', 'idle_c' ,8.0, -8, -1, 1, 0, false, false, false)
										inanimation = true
										RageUI.CloseAll()
										pet_open = false
									end
								end)
							end
						else
							RageUI.Button("Ordonner de se lever", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
								if s then
									ClearPedTasks(ped)
									inanimation = false
									RageUI.CloseAll()
									pet_open = false
								end
							end)
						end
					else
						RageUI.Button("Appeler votre animal", nil, {RightLabel = "~p~→→"}, true, function(h, a, s) 
							if s then
								ESX.TriggerServerCallback('Extasy:getPet', function(pet)
									if pet == 'Chien' then
										model = -1788665315
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Chat' then
										model = 1462895032
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Loup' then
										model = 1682622302
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Lapin' then
										model = -541762431
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Husky' then
										model = 1318032802
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Cochon' then
										model = -1323586730
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Caniche' then
										model = 1125994524
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Carlin' then
										model = 1832265812
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Retriever' then
										model = 882848737
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Berger allemand' then
										model = 1126154828
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Westie' then
										model = -1384627013
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Rottweiler' then
										model = 351016938
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									elseif pet == 'Chop' then
										model = 351016938
										come = 1
										openchien()
										SetEntityHealth(ped, 100.0)
        								TaskFollowToOffsetOfEntity(ped, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
									else
										Extasy.ShowNotification("Vous n'avez pas d'animal")
									end
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

FollowAnimal = function(pedA)
    RequestAnimDict('rcmnigel1c') 
    while not HasAnimDictLoaded('rcmnigel1c') do 
        Wait(0) 
    end

    TaskPlayAnim(PlayerPedId(), 'rcmnigel1c', 'hailing_whistle_waive_a', 8.0, -8, 100.0, 48, 0, false, false, false)

    if not Animal.data.follow then
        ClearPedTasks(pedA)
        Animal.data.follow = true
    else
        TaskFollowToOffsetOfEntity(pedA, PlayerPedId(), 0.5, 0.0, 0.0, 7.0, -1, 0.0, 1)
        SetPedKeepTask(pedA, true)
        Animal.data.follow = false
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30)

		if balle then
			local coords1 = GetEntityCoords(PlayerPedId())
			local coords2 = GetEntityCoords(ped)
			local distance  = GetDistanceBetweenCoords(objCoords, coords2, true)
			local distance2 = GetDistanceBetweenCoords(coords1, coords2, true)

			if distance < 0.5 then
				local boneIndex = GetPedBoneIndex(ped, 17188)
				AttachEntityToEntity(object, ped, boneIndex, 0.120, 0.010, 0.010, 5.0, 150.0, 0.0, true, true, false, true, 1, true)
				TaskGoToCoordAnyMeans(ped, coords1, 5.0, 0, 0, 786603, 0xbf800000)
				balle = false
				getball = true
			end
		end

		if getball then
			local coords1 = GetEntityCoords(PlayerPedId())
			local coords2 = GetEntityCoords(ped)
			local distance2 = GetDistanceBetweenCoords(coords1, coords2, true)

			if distance2 < 1.5 then
				DetachEntity(object,false,false)
				Citizen.Wait(50)
				SetEntityAsMissionEntity(object)
				DeleteEntity(object)
				GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_BALL"), 1, false, true)
				local GroupHandle = GetPlayerGroup(PlayerId())
				SetGroupSeparationRange(GroupHandle, 999999.9)
				SetPedNeverLeavesGroup(ped, true)
				SetPedAsGroupMember(ped, GroupHandle)
				getball = false
			end
		end
	end
end)

function attached()
	local GroupHandle = GetPlayerGroup(PlayerId())
	SetGroupSeparationRange(GroupHandle, 1.9)
	SetPedNeverLeavesGroup(ped, false)
	FreezeEntityPosition(ped, true)
end

function detached()
	local GroupHandle = GetPlayerGroup(PlayerId())
	SetGroupSeparationRange(GroupHandle, 999999.9)
	SetPedNeverLeavesGroup(ped, true)
	SetPedAsGroupMember(ped, GroupHandle)
	FreezeEntityPosition(ped, false)
end

function openchien()
	ESX.TriggerServerCallback('Extasy:getPetName', function(result)
		PetName = result
	end)
	RageUI.CloseAll()
	pet_open = false
	local playerPed = PlayerPedId()
	local LastPosition = GetEntityCoords(playerPed)
	local GroupHandle = GetPlayerGroup(PlayerId())

	DoRequestAnimSet('rcmnigel1c')

	TaskPlayAnim(playerPed, 'rcmnigel1c', 'hailing_whistle_waive_a' ,8.0, -8, -1, 120, 0, false, false, false)

	Citizen.SetTimeout(3000, function()
		ped = CreatePed(28, model, LastPosition.x +1, LastPosition.y +1, LastPosition.z -1, 1, 1)

		SetPedAsGroupLeader(playerPed, GroupHandle)
		SetPedAsGroupMember(ped, GroupHandle)
		SetPedNeverLeavesGroup(ped, true)
		SetPedCanBeTargetted(ped, false)
		SetEntityAsMissionEntity(ped, true,true)

		status = math.random(40, 90)
		Citizen.Wait(5)
		attached()
		Citizen.Wait(5)
		detached()
	end)
	Wait(4000)
	openPetMenu()
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)

		if come == 1 then
			status = status - 1
		end

		if status == 0 then
			TriggerServerEvent('Extasy:petDied', token)
			DeleteEntity(ped)
			Extasy.ShowNotification('votre animal est mort de faim !')
			come = 3
			status = "die"
		end
	end
end)

function DoRequestModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(500)
	end
end

function DoRequestAnimSet(anim)
	RequestAnimDict(anim)
	while not HasAnimDictLoaded(anim) do
		Citizen.Wait(500)
	end
end
