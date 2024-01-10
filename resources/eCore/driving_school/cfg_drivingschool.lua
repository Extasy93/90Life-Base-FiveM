cfg_drivingschool = {}

CreateThread(function()
    while extasy_core_cfg == nil do Wait(1) end
    cfg_drivingschool.list_licenses = {
        {
            name = "Permis voiture",
            price = extasy_core_cfg["license_car_price"],
            value = "car",
            item = "Permis_voiture",
            label = "Permis voiture",
            want_buy = false
        },
        {
            name = "Permis moto",
            price = extasy_core_cfg["license_bike_price"],
            value = "motorcycle",
            item = "Permis_moto",
            label = "Permis moto",
            want_buy = false
        },
        {
            name = "Permis camion",
            price = extasy_core_cfg["license_truck_price"],
            value = "truck",
            item = "Permis_camion",
            label = "Permis camion",
            want_buy = false
        },
        --{
        --    name = "Permis bateau",
        --    price = extasy_core_cfg["license_boat_price"],
        --    value = "boat",
        --    item = "Permis_bateau",
        --    label = "Permis bateau",
        --    want_buy = false
        --},
    }
end)

cfg_drivingschool.drivings_car = {
    {
        pos = vector3(3748.27, 6226.66, 9.54),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 60km/h", 5000)
        end,
        limit = 60,
    },
    {
        pos = vector3(3753.047, 6434.245, 9.879742),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(3191.197, 6297.461, 15.88855),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(2514.805, 6237.163, 15.2261),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(2314.082, 6276.908, 8.327347),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(2301.923, 6239.571, 9.028552),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(2265.725, 5937.711, 9.051929),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(2375.318, 5918.261, 9.062511),
        action = function()
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(2389.265, 5716.341, 9.391648),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(3302.086, 5751.833, 10.02623),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(3421.33, 5753.303, 9.381906),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(3580.419, 5736.992, 8.719072),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(3679.112, 5810.547, 8.651317),
        action = function()
            FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), true)
			Wait(2500)

			FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
            Extasy.PopupTime("~r~Continuez vers le prochain point sans dépasser 75km/h", 5000)
        end,
        limit = 75,
    },
    {
        pos = vector3(3782.223, 6129.686, 9.145812),
        action = function()
        end,
        limit = 75,
    }
}

cfg_drivingschool.max_errors = 5

cfg_drivingschool.cars_model = {
    {
        model = "issi3",
        spawnPoint = vector3(3782.22, 6129.68, 9.14),
        heading = 93.26,
    },
    {
        model = "enduro",
        spawnPoint = vector3(3782.22, 6129.68, 9.14),
        heading = 93.26,
    },
    {
        model = "hauler",
        spawnPoint = vector3(3782.22, 6129.68, 9.14),
        heading = 93.26,
    },
}