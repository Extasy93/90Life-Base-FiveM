cfg_vcpd = {}

cfg_vcpd.badgePos = {
    vector3(3627.13, -5709.49, 5.56),
}

cfg_vcpd.allPointsToKnow = {
    vector3(446.21, -984.56, 29.69),
    vector3(-1100.13, -839.24, 18.0),
    vector3(1853.08, 3687.67, 33.27),
    vector3(-447.91, 6010.7, 39.47),
}

cfg_vcpd.menu = {
    {
        label   = "Interaction citoyen",
        going_menu   = "main_menu_citizen",

        button = {
            {name = "Menotter",                       desc = "Menotte la personne la plus proche",                                         action = function() openClosestPlayer("handcuff") end,},
            {name = "Démenotter",                     desc = "Démenotte la personne la plus proche",                                       action = function() openClosestPlayer("unhandcuff") end,},
            {name = "Fouiller",                       desc = "Fouille la personne la plus proche",                                         action = function() openClosestPlayer("search") end,},
            {name = "Escorter",                       desc = "Attache et porte la personne la plus proche",                                action = function() openClosestPlayer("drag") end,},
            {name = "Mettre dans le véhicule",        desc = "Force la personne la plus proche à aller dans le véhicule le plus proche",   action = function() openClosestPlayer("putInVehicle") end,},
            {name = "Sortir du véhicule",             desc = "Force la personne la plus proche à sortir du véhicule le plus proche",       action = function() openClosestPlayer("putOutVehicle") end,},
            {name = "Amende",                         desc = "Envoie une amende à la personne la plus proche",                             action = function() openClosestPlayer("billing") end,},
        },
    },
    {
        label   = "Interaction véhicule",
        going_menu   = "main_menu_vehicle",

        button = {
            {name = "Faire une recherche",            desc = "Faire une recherche sur le véhicule le plus proche",                         action = function() print("oui") end,},
            {name = "Crochetter",                     desc = "Crochète le véhicule le plus proche",                                        action = function() print("oui") end,},
            {name = "Fourrière",                      desc = "Met en fourrière le véhicule le plus proche",                                action = function() print("oui") end,},
        },
    },
    {
        label   = "Interaction monde",
        going_menu   = "main_menu_world",
    },
    {
        label   = "",
        going_menu   = "",
    },
    {
        label   = "Status de l'agent",
        going_menu   = "main_menu_status",

        button = {
            {name = "Service",                        desc = "Prendre son service/sa fin de service",                                      action = function() print("oui") end,},
            {name = "",                               desc = "",                                                                           action = function() end,},
            {name = "Attente de dispatch",            desc = "Prévient les unités de votre attente",                                       action = function() print("oui") end,},
            {name = "Contrôle routier en cours",      desc = "Prévient les unités de votre contrôle routier en cours",                     action = function() print("oui") end,},
            {name = "Délit de fuite en cours",        desc = "Prévient les unités d'un délit de fuite en cours à votre position",          action = function() print("oui") end,},
            {name = "Poursuite en cours",             desc = "Prévient les unités d'une poursuite en cours à votre position",              action = function() print("oui") end,},
        },
    },
}

cfg_vcpd.garages = {
    {
        value = "car",

        list = {
            {name = "Véhicule #1", hash = "fbi"},
            {name = "Véhicule #2", hash = "fbi2"},
            {name = "Véhicule #3", hash = "police"},
            {name = "Véhicule #4", hash = "police2"},
            {name = "Véhicule #5", hash = "police3"},
            {name = "Véhicule #5", hash = "police41"},
            {name = "Véhicule d'intèrvention rapide", hash = "sheriff"},
            {name = "Hélico", hash = "uh1forest"},
        },

        places = {
            {pos = vector3(3598.10, 5697.40, 11.28), heading = 143.33},
            {pos = vector3(3600.91, 5695.14, 11.28), heading = 140.56},
            {pos = vector3(3603.43, 5692.62, 11.28), heading = 139.62},
            {pos = vector3(3606.32, 5690.24, 11.28), heading = 148.74},
            {pos = vector3(3608.99, 5687.95, 11.28), heading = 138.00},
        },
    },

    {
        value = "boat",

        list = {
            {name = "VCPD Predator", hash = "predator"},
            {name = "VCPD Defender", hash = "15defender"},
        },

        places = {
            {pos = vector3(601.74, -2306.86, 1.0), heading = 175.0},
            {pos = vector3(612.09, -2308.48, 1.0), heading = 175.0},
        },
    },
}

cfg_vcpd.weapons = {
    [0] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
    },
    [1] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
    },
    [2] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
    },
    [3] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "M4",
            item = "WEAPON_CARBINERIFLE",
            price = 30000,
            ammo = 0,
        },
    },
    [4] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "M4",
            item = "WEAPON_CARBINERIFLE",
            price = 30000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe Bullpup",
            item = "WEAPON_BULLPUPSHOTGUN",
            price = 55000,
            ammo = 0,
        },
    },
    [5] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "M4",
            item = "WEAPON_CARBINERIFLE",
            price = 30000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe Bullpup",
            item = "WEAPON_BULLPUPSHOTGUN",
            price = 55000,
            ammo = 0,
        },
        {
            name = "M4 MK2",
            item = "WEAPON_CARBINERIFLE_MK2",
            price = 45000,
            ammo = 0,
        },
    },
    [6] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "M4",
            item = "WEAPON_CARBINERIFLE",
            price = 30000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe Bullpup",
            item = "WEAPON_BULLPUPSHOTGUN",
            price = 55000,
            ammo = 0,
        },
        {
            name = "M4 MK2",
            item = "WEAPON_CARBINERIFLE_MK2",
            price = 45000,
            ammo = 0,
        },
    },
    [7] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "M4",
            item = "WEAPON_CARBINERIFLE",
            price = 30000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe Bullpup",
            item = "WEAPON_BULLPUPSHOTGUN",
            price = 55000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe MK2",
            item = "WEAPON_PUMPSHOTGUN_MK2",
            price = 45000,
            ammo = 0,
        },
        {
            name = "M4 MK2",
            item = "WEAPON_CARBINERIFLE_MK2",
            price = 45000,
            ammo = 0,
        },
    },
    [8] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "M4",
            item = "WEAPON_CARBINERIFLE",
            price = 30000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe Bullpup",
            item = "WEAPON_BULLPUPSHOTGUN",
            price = 55000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe MK2",
            item = "WEAPON_PUMPSHOTGUN_MK2",
            price = 45000,
            ammo = 0,
        },
        {
            name = "M4 MK2",
            item = "WEAPON_CARBINERIFLE_MK2",
            price = 45000,
            ammo = 0,
        },
    },
    [9] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "M4",
            item = "WEAPON_CARBINERIFLE",
            price = 30000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe Bullpup",
            item = "WEAPON_BULLPUPSHOTGUN",
            price = 55000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe MK2",
            item = "WEAPON_PUMPSHOTGUN_MK2",
            price = 45000,
            ammo = 0,
        },
        {
            name = "M4 MK2",
            item = "WEAPON_CARBINERIFLE_MK2",
            price = 45000,
            ammo = 0,
        },
    },
    [10] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "M4",
            item = "WEAPON_CARBINERIFLE",
            price = 30000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe Bullpup",
            item = "WEAPON_BULLPUPSHOTGUN",
            price = 55000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe MK2",
            item = "WEAPON_PUMPSHOTGUN_MK2",
            price = 45000,
            ammo = 0,
        },
        {
            name = "M4 MK2",
            item = "WEAPON_CARBINERIFLE_MK2",
            price = 45000,
            ammo = 0,
        },
    },
    [11] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "M4",
            item = "WEAPON_CARBINERIFLE",
            price = 30000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe Bullpup",
            item = "WEAPON_BULLPUPSHOTGUN",
            price = 55000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe MK2",
            item = "WEAPON_PUMPSHOTGUN_MK2",
            price = 45000,
            ammo = 0,
        },
        {
            name = "M4 MK2",
            item = "WEAPON_CARBINERIFLE_MK2",
            price = 45000,
            ammo = 0,
        },
    },
    [12] = { 
        {
            name = "Matraque",
            item = "WEAPON_NIGHTSTICK",
            price = 0,
            ammo = 0,
        },
        {
            name = "Pistolet de combat",
            item = "WEAPON_COMBATPISTOL",
            price = 500,
            ammo = 0,
        },
        {
            name = "Pistolet lourd",
            item = "WEAPON_HEAVYPISTOL",
            price = 1000,
            ammo = 0,
        },
        {
            name = "Grenade de détresse",
            item = "WEAPON_FLARE",
            price = 250,
            ammo = 0,
        },
        {
            name = "Grenade BZ",
            item = "WEAPON_BZGAS",
            price = 500,
            ammo = 0,
        },
        {
            name = "SMG d'assaut",
            item = "WEAPON_ASSAULTSMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "MP5",
            item = "WEAPON_SMG",
            price = 20000,
            ammo = 0,
        },
        {
            name = "M4",
            item = "WEAPON_CARBINERIFLE",
            price = 30000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe Bullpup",
            item = "WEAPON_BULLPUPSHOTGUN",
            price = 55000,
            ammo = 0,
        },
        {
            name = "Fusil à pompe MK2",
            item = "WEAPON_PUMPSHOTGUN_MK2",
            price = 45000,
            ammo = 0,
        },
        {
            name = "M4 MK2",
            item = "WEAPON_CARBINERIFLE_MK2",
            price = 45000,
            ammo = 0,
        },
    },
}

cfg_vcpd.equipement = {
    --[[{
        name = "Kevlar de combat II",
        sex = "Homme",
        item = "Kevlar",
        draw = 18,
        texture = 5,
        damage = 30,
        price = 150,
        ammo = 0,
        type = "kevlar",
    },
    {
        name = "Kevlar de combat II",
        sex = "Femme",
        item = "Kevlar",
        draw = 20,
        texture = 5,
        damage = 30,
        price = 150,
        ammo = 0,
        type = "kevlar",
    },--]]
    {
        name = "Herse",
        item = "Herse",
        price = 500,
        ammo = 0,
    },
    {
        name = "Bouclier",
        item = "Bouclier",
        price = 900,
        ammo = 0,
    },
    {
        name = "Chargeur Universel",
        item = "Chargeur",
        --price = extasy_core_cfg["ammunation_clip_price"] * 0.80,
        price = 0,
        ammo = 0,
    },
    --[[{
        name = "Poignée",
        item = "Poignee",
        price = 10000,
    },
    {
        name = "Lampe",
        item = "Lampe",
        price = 5000,
    },--]]
}

cfg_vcpd.codes = {
    {
        code = "1",
        msg  = "Délit de fuite en cours",
    },
    {
        code = "2",
        msg  = "Besoin de renforts",
    },
    {
        code = "99",
        msg  = "TOUTES LES UNITÉS DEMANDÉES",
        gravity = 3,
    },
}