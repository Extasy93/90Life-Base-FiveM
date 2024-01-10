local waitingForClient = 0

RegisterNetEvent("Extasy:ouverturefourC")
AddEventHandler("Extasy:ouverturefourC", function(source)
    TriggerServerEvent("Extasy:ouverturefour", token, source)
end)

local l
local m = -10
local n = -10
local o = 0
local b
local p
local q = 200
local r = "a_m_m_bevhills_01"

local ratiochance = 0

RegisterNetEvent("Extasy:getcustomer")
AddEventHandler("Extasy:getcustomer",function()
    if waitingForClient == 1 then
        Extasy.ShowNotification("~r~Vous attendez déjà un client!")
        return
    end
    waitingForClient = 1
    TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_MOBILE", 0, true)
    Extasy.ShowNotification("~o~[Yencli]:~s~ ~g~Bouge pas j'arrive chercher ma dope 😵")
    Wait(4000)
    ClearPedTasks(GetPlayerPed(-1))
    local s = math.random(1, 2)
    if s == 1 then
        RequestModel("a_f_m_bevhills_02")
        while not HasModelLoaded("a_f_m_bevhills_02") do
            Wait(10)
        end
        r = "a_f_m_bevhills_02"
    else
        RequestModel("a_m_m_bevhills_01")
        while not HasModelLoaded("a_m_m_bevhills_01") do
            Wait(10)
        end
        r = "a_m_m_bevhills_01"
    end
    local t = GetEntityCoords(GetPlayerPed(-1))
    local u = math.random(1, 2)
    local v = math.random(1, 2)
    if u == 1 then
        m = -35
    else
        m = 35
    end
    if v == 1 then
        n = -35
    else
        n = 35
    end
    Wait(500)
    local w, A = GetGroundZFor_3dCoord(t.x + m, t.y + n, t.z, 0)
    l = CreatePed(26, r, t.x + m, t.y + n, A + 0.5, 268.9422, true, true)
    PlaceObjectOnGroundProperly(l)
    SetEntityAsMissionEntity(l)
    SetBlockingOfNonTemporaryEvents(l, true)
    SetPedKeepTask(l, true)
    TaskGoToEntity(l, GetPlayerPed(-1), -1, 3.5, 2.0, 1073741824.0, 0)
    SetPedKeepTask(l, true)
    o = 0
    local B = true
    while B do
        Wait(500)
        local C = GetEntityCoords(l)
        local t = GetEntityCoords(GetPlayerPed(-1))
        q = GetEntityHealth(l)
        local D = Vdist(C.x, C.y, C.z, t.x, t.y, t.z)
        o = o + 1
        if D <= 1.5 or o >= 75 or q < 100 then
            B = false
        end
    end
    if o >= 75 or q < 1.0 then
        Extasy.ShowNotification("~r~Le client a annulé la commande à la dernière minute... Un autre client devrait arriver !")
        waitingForClient = 0
        TaskWanderStandard(l, 10.0, 10)
        SetPedAsNoLongerNeeded(l)
    else
        SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(l) - 180.0)
        RequestAnimDict("mp_common")
        while not HasAnimDictLoaded("mp_common") do
            Citizen.Wait(0)
        end

        b = CreateObject(GetHashKey("prop_weed_bottle"), 0, 0, 0, true)

        AttachEntityToEntity(b,PlayerPedId(),GetPedBoneIndex(PlayerPedId(), 57005),0.13, 0.02,0.0,-90.0, 0,0,1,1,0,1,0,1)

        p = CreateObject(GetHashKey("hei_prop_heist_cash_pile"), 0, 0, 0, true)
        AttachEntityToEntity(p, l, GetPedBoneIndex(l, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
        TaskPlayAnim(GetPlayerPed(-1), "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
        TaskPlayAnim(l, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
        Wait(1550)
        DeleteEntity(b)
        DeleteEntity(p)
        ClearPedTasks(pid)
        ClearPedTasks(l)
        TaskWanderStandard(l, 10.0, 10)
        SetPedAsNoLongerNeeded(l)
        x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
        playerX = tonumber(string.format("%.2f", x))
        playerY = tonumber(string.format("%.2f", y))
        playerZ = tonumber(string.format("%.2f", z))
        TriggerServerEvent("Extasy:udanyzakup", token, playerX, playerY, playerZ)
        Wait(500)
    end
end)

RegisterNetEvent("Extasy:venteok")
AddEventHandler("Extasy:venteok", function()
    waitingForClient = 0
end)

RegisterNetEvent("Call:fours")
AddEventHandler("Call:fours", function()
    local coords = GetEntityCoords(PlayerPedId())
    local lieux = nil
    job = {
        "vcpd",
    }

    msgSellDrugs = "Un trafic de drogues a été apercu dans cette zone !"

    TriggerServerEvent("CORE:SendMsgFours", job, msgSellDrugs, coords)
end)

