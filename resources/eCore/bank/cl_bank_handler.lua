bank_transac = {}

Citizen.CreateThread(function()
    encoded = GetResourceKvpString("transaction")
    if encoded ~= nil then
        decodebank_transac(encoded)
    else
        bank_transac = {}
    end
end)

Encodebank_transac = function(transac)
    local encoded = json.encode(transac)
    SetResourceKvp("transaction", encoded)
end

decodebank_transac = function(transac)
    local decoded = json.decode(transac)
    bank_transac = decoded
end

Addbank_transac = function(t_n, t_a, t_t)
    table.insert(bank_transac, {name=t_n, amount=t_a, type=t_t})
    Encodebank_transac(bank_transac)
end

ClearTransaction = function()
    bank_transac = {}
    Encodebank_transac(bank_transac)
end

local cam = nil
local ATMs = {
    GetHashKey("prop_atm_01"),
    GetHashKey("prop_atm_02"),
    GetHashKey("prop_atm_03"),
    GetHashKey("prop_fleeca_atm"),
}

checkATM = function()
    local ped       = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)

    for k,v in pairs(ATMs) do
        obj = Extasy.GetClosestObject(pedCoords, 3.0, v)

        if obj then
            break
        end
    end
    if not obj then
        Extasy.ShowNotification("~r~Aucun ATM à proximité")
    else
        local c    = GetOffsetFromEntityInWorldCoords(obj, 0.0, -0.6, 1.2)
        local ctoc = GetOffsetFromEntityInWorldCoords(obj, 0.0, 0.0, 0.9)

        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)

        SetCamActive(cam, 1)
        SetCamCoord(cam, c)
        SetCamFov(cam, 55.0)
        PointCamAtCoord(cam, ctoc)
        RenderScriptCams(1, 1, 1000, 0, 0)
        TaskTurnPedToFaceEntity(ped, obj, 2500)

        Wait(1000)

        openATM()
    end
end

killCam = function()
    RenderScriptCams(0, 1, 1000, 0, 0)
    Wait(1000)
    SetCamActive(cam, 0)
    cam = nil
    
    RageUI.Visible(RMenu:Get('bank', 'main_menu'), true)
end

local aBlips = {}
local aList = {
    {id = 277, x = 89.75, y = 2.35, z = 68.31},
    {id = 277, x = 1167.02, y = -456.32, z = 66.79},
    {id = 277, x = -386.733, y = 6045.953, z = 31.501},
    {id = 277, x = -284.037, y = 6224.385, z = 31.187},
    {id = 277, x = -284.037, y = 6224.385, z = 31.187},
    {id = 277, x = -135.165, y = 6365.738, z = 31.101},
    {id = 277, x = -110.753, y = 6467.703, z = 31.784},
    {id = 277, x = -94.9690, y = 6455.301, z = 31.784},
    {id = 277, x = 155.4300, y = 6641.991, z = 31.784},
    {id = 277, x = 174.6720, y = 6637.218, z = 31.784},
    {id = 277, x = 1703.138, y = 6426.783, z = 32.730},
    {id = 277, x = 1735.114, y = 6411.035, z = 35.164},
    {id = 277, x = 1702.842, y = 4933.593, z = 42.051},
    {id = 277, x = 1967.333, y = 3744.293, z = 32.272},
    {id = 277, x = 1821.917, y = 3683.483, z = 34.244},
    {id = 277, x = 1174.532, y = 2705.278, z = 38.027},
    {id = 277, x = 540.0420, y = 2671.007, z = 42.177},
    {id = 277, x = 2564.399, y = 2585.100, z = 38.016},
    {id = 277, x = 2558.683, y = 349.6010, z = 108.050},
    {id = 277, x = 2558.051, y = 389.4817, z = 108.660},
    {id = 277, x = 1077.692, y = -775.796, z = 58.218},
    {id = 277, x = 1139.018, y = -469.886, z = 66.789},
    {id = 277, x = 1168.975, y = -457.241, z = 66.641},
    {id = 277, x = 1153.884, y = -326.540, z = 69.245},
    {id = 277, x = 381.2827, y = 323.2518, z = 103.270},
    {id = 277, x = 236.4638, y = 217.4718, z = 106.840},
    {id = 277, x = 265.0043, y = 212.1717, z = 106.780},
    {id = 277, x = 285.2029, y = 143.5690, z = 104.970},
    {id = 277, x = 157.7698, y = 233.5450, z = 106.450},
    {id = 277, x = -164.568, y = 233.5066, z = 94.919},
    {id = 277, x = -1827.04, y = 785.5159, z = 138.020},
    {id = 277, x = -1409.39, y = -99.2603, z = 52.473},
    {id = 277, x = -1205.35, y = -325.579, z = 37.870},
    {id = 277, x = -1215.64, y = -332.231, z = 37.881},
    {id = 277, x = -2072.41, y = -316.959, z = 13.345},
    {id = 277, x = -2975.72, y = 379.7737, z = 14.992},
    {id = 277, x = -2962.60, y = 482.1914, z = 15.762},
    {id = 277, x = -2955.70, y = 488.7218, z = 15.486},
    {id = 277, x = -3044.22, y = 595.2429, z = 7.595},
    {id = 277, x = -3144.13, y = 1127.415, z = 20.868},
    {id = 277, x = -3241.10, y = 996.6881, z = 12.500},
    {id = 277, x = -3241.11, y = 1009.152, z = 12.877},
    {id = 277, x = -1305.40, y = -706.240, z = 25.352},
    {id = 277, x = -538.225, y = -854.423, z = 29.234},
    {id = 277, x = -711.156, y = -818.958, z = 23.768},
    {id = 277, x = -717.614, y = -915.880, z = 19.268},
    {id = 277, x = -526.566, y = -1222.90, z = 18.434},
    {id = 277, x = -256.831, y = -719.646, z = 33.444},
    {id = 277, x = -203.548, y = -861.588, z = 30.205},
    {id = 277, x = 112.4102, y = -776.162, z = 31.427},
    {id = 277, x = 112.9290, y = -818.710, z = 31.386},
    {id = 277, x = 119.9000, y = -883.826, z = 31.191},
    {id = 277, x = 149.4551, y = -1038.95, z = 29.366},
    {id = 277, x = -846.304, y = -340.402, z = 38.687},
    {id = 277, x = -1204.35, y = -324.391, z = 37.877},
    {id = 277, x = -1216.27, y = -331.461, z = 37.773},
    {id = 277, x = -56.1935, y = -1752.53, z = 29.452},
    {id = 277, x = -261.692, y = -2012.64, z = 30.121},
    {id = 277, x = -273.001, y = -2025.60, z = 30.197},
    {id = 277, x = 314.187, y = -278.621, z = 54.170},
    {id = 277, x = -351.534, y = -49.529, z = 49.042},
    {id = 277, x = 24.589, y = -946.056, z = 29.357},
    {id = 277, x = -254.112, y = -692.483, z = 33.616},
    {id = 277, x = -1570.197, y = -546.651, z = 34.955},
    {id = 277, x = -1415.909, y = -211.825, z = 46.500},
    {id = 277, x = -1430.112, y = -211.014, z = 46.500},
    {id = 277, x = 33.232, y = -1347.849, z = 29.497},
    {id = 277, x = 129.216, y = -1292.347, z = 29.269},
    {id = 277, x = 287.645, y = -1282.646, z = 29.659},
    {id = 277, x = 289.012, y = -1256.545, z = 29.440},
    {id = 277, x = 295.839, y = -895.640, z = 29.217},
    {id = 277, x = 1686.753, y = 4815.809, z = 42.008},
    {id = 277, x = -302.408, y = -829.945, z = 32.417},
    {id = 277, x = 5.134, y = -919.949, z = 29.557}
}

Citizen.CreateThread(function()
    while true do
        local pPed = GetPlayerPed(-1)
        local pCoords = GetEntityCoords(pPed)
        for k,v in pairs(aList) do
            local dst = GetDistanceBetweenCoords(pCoords, vector3(v.x, v.y, v.z), false)

            if dst < 150.0 then
                if not DoesBlipExist(aBlips[k]) then
                    AddTextEntry('BLIPS_ATM_'..k, "ATM")

                    aBlips[k] = AddBlipForCoord(v.x, v.y, v.z)
                    SetBlipSprite(aBlips[k], v.id)
                    SetBlipDisplay(aBlips[k], 4)
                    SetBlipScale(aBlips[k], 0.9)
                    SetBlipColour(aBlips[k], 2)
                    SetBlipAsShortRange(aBlips[k], true)

                    BeginTextCommandSetBlipName('BLIPS_ATM_'..k)
                    EndTextCommandSetBlipName(aBlips[k])
                end
            else
                RemoveBlip(aBlips[k])
            end
        end
        Wait(750)
    end
end)

RegisterNetEvent("bank:useCard")
AddEventHandler("bank:useCard", function()
    RageUI.CloseAll()
    checkATM()
end)