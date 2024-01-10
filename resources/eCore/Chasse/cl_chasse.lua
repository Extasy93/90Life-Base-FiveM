local animals =  {
    {
        model = "a_c_deer",
    },
    {
        model = "a_c_boar",
    },
    {
        model = "a_c_coyote",
    },

}

local dstMax = 600.0
local entityMax = 10
local random = 100
local CreatePed = {
    z = 3.0,
    type = 28,
    heading = 100.0,
    network = false,
    NetEntity = true,
}
local wander = 99999999.0
local wander2 = 10.0
local spriteID = 141
local scale = 0.80
local noise = 100.0
local healthCheck = 50.0
local dict = "anim@mp_snowball"
local anim = "pickup_snowball"

local OpenHunterMenu = false

RMenu.Add('Extasy_hunter_menu', 'hunter', RageUI.CreateMenu("Chasse","Que souhaitez-vous faire ?"))
RMenu:Get('Extasy_hunter_menu', 'hunter').Closed = function()
    OpenHunterMenu = false
    RageUI.CloseAll()
    FreezeEntityPosition(GetPlayerPed(-1), false)
end

RMenu.Add('Extasy_hunter_menu', 'hunter_sell', RageUI.CreateSubMenu(RMenu:Get('Extasy_hunter_menu', 'hunter'), "Vente chasse", nil))
RMenu:Get('Extasy_hunter_menu', 'hunter_sell').Closed = function()end

local itemsToSell = items
local VehiculeDeChasse = nil

function OpenHunterDialog()
    FreezeEntityPosition(GetPlayerPed(-1), true)
    if not OpenHunterMenu then 
        OpenHunterMenu = true
		RageUI.Visible(RMenu:Get('Extasy_hunter_menu', 'hunter'), true)

		Citizen.CreateThread(function()
			while OpenHunterMenu do
				Citizen.Wait(1)

                RageUI.IsVisible(RMenu:Get('Extasy_hunter_menu', 'hunter'), true, false, true, function()

                RageUI.Separator('Vous avez tuées: ~r~~h~'..Huntkills..'~s~~h~ bêtes !')
                RageUI.ButtonWithStyle("Acheter un permis de chasse", nil, {RightLabel = "~g~500$"}, true, function(_,_,s)
                    if s then 
                        TriggerServerEvent('BuyPermisChasse', token, 500)
                        NotifHunt("~r~ Vous êtes sortis de la zone, vous avez donc rendu votre fusil de chasse !")
                    end
                end)
                RageUI.ButtonWithStyle("Récupèrer une arme de chasse", "Attention, l'arme de chasse doit etre déposé après votre partie de chasse. De lourde amendes sont prévue en cas de non respect.", {}, true, function(_,_,s)
                    if s then 
                        TriggerServerEvent("GetWeaponsChasse", token) 
                    end
                end)
                RageUI.ButtonWithStyle("Récupèrer une arme de chasse pro", "Arme réservée au pro de la chasse, ~r~"..Huntkills.."~w~/100", {RightLabel = Huntkills.."/100"}, Huntkills >= 100, function(_,_,s)
                    if s then 
                        TriggerServerEvent("GetWeaponsChasse2", token)
                    end
                end)

                if VehiculeDeChasse == nil then
                    RageUI.ButtonWithStyle("Récupèrer son véhicule de chasse", "Attention, vous avez les cléfs de ce véhicules mais sa n'est pas le votre !", { RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                            SpawnVehicleHunter(GetHashKey("rebel"), vector3(-1491.41, 4989.64, 62.65), 172.47, function(veh)
                                VehiculeDeChasse = VehToNet(veh)
                            end)
                        end
                    end)
                else
                    RageUI.ButtonWithStyle("Ranger son véhicule de chasse", nil, { RightLabel = "→→" }, true, function(_,_,s)
                        if s then
                            print(VehiculeDeChasse)
                            TriggerServerEvent("DeleteEntityHunt", token, VehiculeDeChasse)
                            VehiculeDeChasse = nil
                        end
                    end)
                end
            
                RageUI.ButtonWithStyle("Déposer son arme de chasse", nil, { RightLabel = "→" }, true, function(_,_,s)
                    if s then
                        TriggerServerEvent("RemoveWeaponsChasse", token, source)
	                    RemoveWeaponFromPed(GetPlayerPed(-1), "WEAPON_SNIPERRIFLE")
                        RemoveWeaponFromPed(GetPlayerPed(-1), "WEAPON_MUSKET")
                    end
                end)

                RageUI.ButtonWithStyle("Vendre ses gains", nil, { RightLabel = "→→" }, true, function(_,_,s)
                end, RMenu:Get('Extasy_hunter_menu', 'hunter_sell'))
            
                RageUI.ButtonWithStyle("Classement [BIENTÔT]", nil, { RightLabel = "→→" }, false, function(_,_,s)
                end, RMenu:Get('Extasy_hunter_menu', 'hunter_classement')) -- Menu pas encore crée 
            end, function()
            end)

            RageUI.IsVisible(RMenu:Get('Extasy_hunter_menu', 'hunter_sell'), true, true, true, function()

                RageUI.Separator("~g~Vente des gains/loots")

                RageUI.ButtonWithStyle("Vendre de la viande", nil, { RightLabel = "~r~x15" }, true, function(_,_,s)
                    if s then 
                        TriggerServerEvent("Extasy:huntSell", token)
                    end
                end)
            end, function()
            end)   
        end
    end)
end
end

function SpawnVehicleHunter(model, coords, heading, cb)
	LoadModelHunter(model)
	local vehicle = CreateVehicle(model, coords, heading, 1, 0)
	SetVehicleDirtLevel(vehicle, 0.0)
	SetEntityCoordsNoOffset(vehicle, coords.x, coords.y, coords.z+0.5, 0.0, 0.0, 0.0)
	SetVehicleOnGroundProperly(vehicle)
	SetEntityHeading(vehicle, heading)
	DecorSetBool(vehicle, "veh_allowed", true)
	SetEntityAsMissionEntity(vehicle, 1, 1)
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
	if cb ~= nil then 
		cb(vehicle)
	end 
	--SetModelAsNoLongerNeeded(model)
end

function LoadModelHunter(_model) 
	if not IsCuffed then 
		IsCuffed = true
	end
	local model = _model 
	if IsModelInCdimage(model) then
		RequestModel(model)
		while not HasModelLoaded(model) do
			print("Waiting model "..model)
			Wait(100)
		end
		--SetModelAsNoLongerNeeded(model)
	else
		--Notif("Modèle inconnu")
	end
	IsCuffed = false
end

function LoadModelHunt(_model) 
    local model = _model 
    if IsModelInCdimage(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            print("Waiting model "..model)
            Wait(100)
        end
    else
        NotifHunt("Modèle inconnu")
    end
    IsCuffed = false
end

function NotifHunt(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end

local PointCentralDeChasse = vector3(-1567.7, 4484.3, 21.4)
local Entity = {}
local Animals = animals

local loots = {}
local Spawning = false

Citizen.CreateThread(function()
    while true do
        local dst = GetDistanceBetweenCoords(PointCentralDeChasse, GetEntityCoords(GetPlayerPed(-1)), false)

        if dst <= dstMax then
            Spawning = true

            if #Entity < entityMax then
                Wait(1)
                local animal = Animals[math.random(1,#Animals)]
                LoadModelHunt(GetHashKey(animal.model))
                local spawnPointx = PointCentralDeChasse.x+math.random(-random,random)
                local spawnPointy = PointCentralDeChasse.y+math.random(-random,random)
                local spawnPointz = PointCentralDeChasse.z+math.random(-random,random)
                local _,z = GetGroundZFor_3dCoord(spawnPointx, spawnPointy, spawnPointz)
                local _entity = CreatePed_(CreatePed.type, GetHashKey(animal.model), spawnPointx, spawnPointy, z+CreatePed.z, CreatePed.heading, CreatePed.network, CreatePed.NetEntity)
                if DoesEntityExist(_entity) then
                    TaskWanderStandard(_entity, wander, wander2)
                    local _blip = AddBlipForEntity(_entity)
                    SetBlipSprite(_blip, spriteID)
                    SetBlipScale(_blip, scale)
                    SetPlayerNoiseMultiplier(GetPlayerIndex(), noise)
                    table.insert(Entity, {entity = _entity, blip = _blip, coords = GetBlipCoords(_blip)})
                end
            end

            for k,v in pairs(Entity) do
                if GetEntityHealth(v.entity) < healthCheck then
                    local source = GetPedSourceOfDeath(v.entity)
                    if source == GetPlayerPed(-1) then
                        NotifHunt("Tu as tué un animal ! Récupère son loot.")
                        CheckSuccesHunter()
                        RemoveBlip(v.blip)
                        table.insert(loots, v.entity)
                        LoopLoot()
                        table.remove(Entity, k)
                    end
                end
            end
        else
            Spawning = false

            if #Entity > 0 then
                for k,v in pairs(Entity) do
                    RemoveBlip(v.blip)
                    DeleteEntity(v.entity)
                    DeletePed(v.entity)
                    table.remove(Entity, k)
                end
            end

            Citizen.CreateThread(function()
                while true do
                    Wait(20000)

                    --RemoveWeaponFromPed(GetPlayerPed(-1), "WEAPON_SNIPERRIFLE")
                    --RemoveWeaponFromPed(GetPlayerPed(-1), "WEAPON_MUSKET")
                    --TriggerServerEvent("RemoveWeaponsChasse", token, source)
                end
            end)
        end

        if Spawning then 
            Wait(1000)
        else
            Wait(10*1000)
        end
    end
end)

PlayAnimHunt = function(dict, anim, flag, blendin, blendout, playbackRate, duration)
	if blendin == nil then blendin = 1.0 end
	if blendout == nil then blendout = 1.0 end
	if playbackRate == nil then playbackRate = 1.0 end
	if duration == nil then duration = -1 end
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Wait(1) print("Waiting for "..dict) end
	TaskPlayAnim(GetPlayerPed(-1), dict, anim, blendin, blendout, duration, flag, playbackRate, 0, 0, 0)
	RemoveAnimDict(dict)
end	

local looping = false
function LoopLoot()
    if looping then return end
    Citizen.CreateThread(function()
        looping = true
        while #loots > 0 do
            for k,v in pairs(loots) do
                local dst = #(GetEntityCoords(v) - GetEntityCoords(GetPlayerPed(-1)))
                DrawMarker(0, GetEntityCoords(v), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 500.0, 0, 255, 0, 100, 0, 1, 2, 0, nil, nil, 0)

                if not DoesEntityExist(v) then
                    table.remove(loots, k) 
                end
                if dst <= 1.5 then
                    PlayAnimHunt(dict, anim, 1)
                    Wait(2000)
                    ClearPedTasks(GetPlayerPed(-1))
                    TakeHuntLoot()
                    DeleteEntity(v)
                    DeletePed(v)
                end
            end
            Wait(1)
        end
        looping = false
    end)
end


Citizen.CreateThread(function()
    Wait(2000)
    while true do
        if Spawning then 
            Wait(2000)
        else
            Wait(5*1000)
        end

        for k,v in ipairs(Entity) do
            local OldC = GetBlipCoords(v.blip)
            OldC = vector3(OldC.x, OldC.y, 0.0)
            Wait(500)
            local NewC = GetBlipCoords(v.blip)
            NewC = vector3(NewC.x, NewC.y, 0.0)
            if OldC == NewC then
                if IsEntityDead(v.entity) then
                    local source = GetPedSourceOfDeath(v.entity)
                    if source ~= GetPlayerPed(-1) then
                        DeleteEntity(v.entity)
                        DeletePed(v.entity)
                        RemoveBlip(v.blip)
                    end
                else
                    DeleteEntity(v.entity)
                    DeletePed(v.entity)
                    RemoveBlip(v.blip)   
                end
            end

            local dst = GetDistanceBetweenCoords(GetEntityCoords(v.entity), GetEntityCoords(GetPlayerPed(-1)), true)
            if dst >= 150 then
                DeleteEntity(v.entity)
                DeletePed(v.entity)
                RemoveBlip(v.blip)
            end

            if dst < 100.0 then
                if not IsEntityDead(v.entity) then
                    PlayPain(v.entity, 7, 0.0)
                    SetPedScream(v.entity)
                end
            end

            if dst < 40.0 then
                Citizen.CreateThread(function()
                    TaskSmartFleeCoord(v.entity, GetEntityCoords(GetPlayerPed(-1)), 100.0, 5000, 0, 0)
                    Wait(4000)
                    TaskWanderStandard(_entity, 99999999.0, 10)
                end)
            end


            if not DoesEntityExist(v.entity) then
                RemoveBlip(v.blip)
                table.remove(Entity, k)
            end
        end
    end
end)

function TakeHuntLoot()
    SetAudioFlag("LoadMPData", true)
    local RandomHunt = math.random(1,5)
    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    TriggerServerEvent("Extasy:huntFarm", token, RandomHunt)
    NotifHunt('Tu as trouvé ~g~'..RandomHunt..'~s~ ~g~Viandes')
end

RegisterNetEvent("core:ShowPermisChasse")
AddEventHandler("core:ShowPermisChasse", function()
    SendActionTxt("Montre son permis de chasse")
end)

Huntkills = 0

Citizen.CreateThread(function()
    Huntkills = GetResourceKvpInt("hunting")
    if Huntkills == nil then
        Huntkills = 0
    end
    --print("Hunter kills "..Huntkills)
end)

local succesHunter = {
    [1] = {
        texte = "Première chasse!"
    },
    [5] = {
        texte = "Amateur de chasse!"
    },
    [10] = {
        texte = "Néophyte de la chasse!"
    },
    [20] = {
        texte = "20 bêtes tuées"
    },
    [30] = {
        texte = "30 bêtes tuées"
    },
    [40] = {
        texte = "40 bêtes tuées"
    },
    [50] = {
        texte = "Chasseur aguerri!"
    },
    [60] = {
        texte = "60 bêtes tuées"
    },
    [70] = {
        texte = "70 bêtes tuées"
    },
    [80] = {
        texte = "80 bêtes tuées"
    },
    [90] = {
        texte = "90 bêtes tuées"
    },
    [100] = {
        texte = "Pro de la chasse!",
        suplementaire = "Tu as maintenant accès au fusil de précision de chasseur!",
    },
}

Citizen.CreateThread(function()
    local Last10 = 100
    for i = 100, 1000 do
        if i == Last10 + 10 then
            succesHunter[Last10] = {texte = Last10.." bêtes tuées"}
            Last10 = Last10 + 10
        end
    end
end)

function CheckSuccesHunter()
    Huntkills = Huntkills + 1
    if succesHunter[Huntkills] ~= nil then
        TriggerEvent("Ambiance:PlayUrl", token, "SUCCES", "https://www.youtube.com/watch?v=VpwqsYA44JI", 0.4, false )
        Wait(1000)
        SendNUIMessage({ 
            succesHunter = true
        })
        NotifHunt("~y~SUCCES!\n~w~"..succesHunter[Huntkills].texte)
        if succesHunter[Huntkills].suplementaire ~= nil then
            NotifHunt("~y~SUCCES!\n~w~"..succesHunter[Huntkills].suplementaire)
        end
    end
    SetResourceKvpInt("hunting", Huntkills)
end