token                = ""
pPed                 = 0
pVeh                 = 0
pVehLast             = 0
currentPlayerCount   = 0
playerInService      = false
playerInServiceLoop  = false
playerPropsMenu      = false
playerTryToTackle    = false

playerIdentity       = {}
playerSocietyWears   = {}
playerMasksData      = {}
bagList              = {
    {
        bag = 40,
    },
    {
        bag = 41,
    },
    {
        bag = 44,
    },
    {
        bag = 45,
    },
    {
        bag = 21,
    },
    {
        bag = 22,
    },
    {
        bag = 23,
    },
    {
        bag = 82,
    },
    {
        bag = 83,
    },
    {
        bag = 84,
    },
    {
        bag = 85,
    },
    {
        bag = 86,
    },
    {
        bag = 87,
    },
    {
        bag = 88,
    },
    {
        bag = 91,
    },
    {
        bag = 92,
    },
    {
        bag = 95,
    }
}

CreateThread(function()
    TriggerServerEvent('Extasy:spawn')
end)

RegisterNetEvent("Extasy:initializeinfo")
AddEventHandler("Extasy:initializeinfo", function(job, grade, skin, lastname, firstname, group, uniqueId, cloths, vip)
    while token == nil do Wait(1) end

    playerJob        = job
    playerJob_grade  = grade
    playerGroup      = group
    playerIdentity.prenom   = lastname
    playerIdentity.nom      = firstname

    if vip ~= nil then
        playerGrade = vip
        loadPlayerVip(vip)
        print("Le joueur a obtenu le grade ^6'"..playerGrade.."'^0, tous les privilèges de ce grade lui ont été ajoutés")
    end

    if playerGroup ~= nil then
        if playerGroup ~= "user" then
            print("Ajout du joueur au cache admin car son groupe est ^6'"..playerGroup.."'")
        end
    end

    if skin ~= nil then
        for k,v in pairs(bagList) do
            if v.bag == skin.bags_1 then
                playerGotBag = true

                if token then
                    TriggerServerEvent("Extasy:iGotBagPlease", token)
                end

                print("Le joueur a un ^6sac, +20 kg sur son inventaire")
            end
        end
    end

    if skin ~= nil then
        if skin.sex == 'mp_f_freemode_01' then
            playerIsMale = false
        elseif skin.sex == 'mp_m_freemode_01' then
            playerIsMale = true
        else
            playerGotBag = true
            print("Le joueur a un ^6ped^0, une fonctionnalité de sac lui a été ajouté")
        end
    end

    while dataLoaded ~= true do Wait(1) end
    LoadData()

    Wait(1500)
    TriggerServerEvent("tattoos:getPlayerTattoos")
    TriggerServerEvent("garage:sendAllVehiclesFromPlayer", token)

    currentPlayerCount = "n/a" -- En attendant de faire la vrai :)

    local i = {
        {"PM_PANE_CFX", "90's Life"},
        {"FE_THDR_GTAO", "~p~90's ~s~Life | ~p~"..GetPlayerName(PlayerId()).."~s~ ["..GetPlayerServerId(PlayerId()).."] | ~p~"..currentPlayerCount.."~s~ joueurs connectés | discord.gg/~p~90Life~s~"},
        {"PM_PANE_LEAVE", "~p~Se déconnecter de ~w~90Life"},
        {"PM_PANE_QUIT", "~r~Quitter FiveM 🐌"}
    }
    for k,v in pairs(i) do
        AddTextEntry(v[1], v[2])
    end

    CreateThread(function()
        while true do
            pPed = GetPlayerPed(-1)
            pVeh = GetVehiclePedIsIn(pPed, 0)
            pVehLast = GetVehiclePedIsIn(pPed, 1)
            SetEntityAsMissionEntity(pVeh, 1, 1)
            SetEntityAsMissionEntity(pVehLast, 1, 1)
            Wait(2000)
        end
    end)

    DecorRegister("aim", 3)
    
    while token == "" do
        Wait(1)
        RageUI.Text({message = "~g~Chargement de votre personnange..."})
        DisableAllControlActions(1)
    end

    --TriggerServerEvent("Extasy:CheckJail", token) -- A crée

    SetWeaponDamageModifier(133987706, 0.0)
    SetWeaponDamageModifier(-1553120962, 0.0)
    
    while true do
        pPed = GetPlayerPed(-1)
        pVeh = GetVehiclePedIsIn(pPed, 0)
        pVehLast = GetVehiclePedIsIn(pPed, 1)
        SetEntityAsMissionEntity(pVeh, 1, 1)
        SetEntityAsMissionEntity(pVehLast, 1, 1)

        SetEntityProofs(pPed, false, true, true, false, false, 0, 0, 0)

        SetVehicleModelIsSuppressed(GetHashKey("model"), true)

        SetVehicleModelIsSuppressed(GetHashKey("armytanker"), true)
        SetVehicleModelIsSuppressed(GetHashKey("armytrailer"), true)
        SetVehicleModelIsSuppressed(GetHashKey("armytrailer2"), true)
        SetVehicleModelIsSuppressed(GetHashKey("baletrailer"), true)
        SetVehicleModelIsSuppressed(GetHashKey("boattrailer"), true)
        SetVehicleModelIsSuppressed(GetHashKey("cablecar"), true)
        SetVehicleModelIsSuppressed(GetHashKey("docktrailer"), true)
        SetVehicleModelIsSuppressed(GetHashKey("freighttrailer"), true)
        SetVehicleModelIsSuppressed(GetHashKey("graintrailer"), true)
        SetVehicleModelIsSuppressed(GetHashKey("proptrailer"), true)
        SetVehicleModelIsSuppressed(GetHashKey("raketrailer"), true)
        SetVehicleModelIsSuppressed(GetHashKey("tr2"), true)
        SetVehicleModelIsSuppressed(GetHashKey("tr3"), true)
        SetVehicleModelIsSuppressed(GetHashKey("tr4"), true)
        SetVehicleModelIsSuppressed(GetHashKey("trflat"), true)
        SetVehicleModelIsSuppressed(GetHashKey("tvtrailer"), true)
        SetVehicleModelIsSuppressed(GetHashKey("tanker"), true)
        SetVehicleModelIsSuppressed(GetHashKey("tanker2"), true)
        SetVehicleModelIsSuppressed(GetHashKey("trailerlarge"), true)
        SetVehicleModelIsSuppressed(GetHashKey("trailerlogs"), true)
        SetVehicleModelIsSuppressed(GetHashKey("trailersmall"), true)
        SetVehicleModelIsSuppressed(GetHashKey("trailers"), true)
        SetVehicleModelIsSuppressed(GetHashKey("trailers2"), true)
        SetVehicleModelIsSuppressed(GetHashKey("trailers3"), true)
        SetVehicleModelIsSuppressed(GetHashKey("trailers4"), true)
        SetVehicleModelIsSuppressed(GetHashKey("airbus"), true)

        SetVehicleModelIsSuppressed(GetHashKey("freight"), true)
        SetVehicleModelIsSuppressed(GetHashKey("freightcar"), true)
        SetVehicleModelIsSuppressed(GetHashKey("freightcont1"), true)
        SetVehicleModelIsSuppressed(GetHashKey("freightcont2"), true)
        SetVehicleModelIsSuppressed(GetHashKey("freightgrain"), true)
        SetVehicleModelIsSuppressed(GetHashKey("metrotrain"), true)
        SetVehicleModelIsSuppressed(GetHashKey("tankercar"), true)
        SetVehicleModelIsSuppressed(GetHashKey("tug"), true)
        SetVehicleModelIsSuppressed(GetHashKey("submersible"), true)
        SetVehicleModelIsSuppressed(GetHashKey("submersible2"), true)

        for k,v in pairs(GetActivePlayers()) do
            local ped = GetPlayerPed(v)
            if DecorExistOn(ped, "aim") then
                if DecorGetInt(ped, "aim") == 1 then
                    SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))
                else
                    SetWeaponAnimationOverride(ped, GetHashKey("Default"))
                end
            else
                SetWeaponAnimationOverride(ped, GetHashKey("Default"))
            end
        end
        Wait(2000)
    end

    Extasy.refreshMenu()
end)

RegisterNetEvent("Extasy:JobRefresh")
AddEventHandler("Extasy:JobRefresh", function(job, grade)
    playerJob       = job
    playerJob_grade = grade
    LoadData()
end)

RegisterNetEvent("Extasy:SendPlayerInventory")
AddEventHandler("Extasy:SendPlayerInventory", function(inv, weight)
    playerInventory = inv
    playerWeight    = weight
end)
 
RegisterNetEvent("Extasy:SendOtherPlayerInventory")
AddEventHandler("Extasy:SendOtherPlayerInventory", function(inv, weight)
    otherInventory   = inv
    otherWeight      = weight
end)

RegisterNetEvent("Jobs:refreshAllWears")
AddEventHandler("Jobs:refreshAllWears", function(_wear)
    playerSocietyWears = _wear
end)

RegisterNetEvent("Extasy:SendToken")
AddEventHandler("Extasy:SendToken", function(NewToken)
    token = NewToken 
end) 