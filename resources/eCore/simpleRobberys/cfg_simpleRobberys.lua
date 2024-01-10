cfg_simpleRobberys = {}

cfg_simpleRobberys.BlackMoney = false

cfg_simpleRobberys.trolleys = {
    ["cash"] = { 500, 1200 }, 
    ["model"] = GetHashKey("hei_prop_hei_cash_trolly_01"),

    ["pos"] = {
        ["left"] = { 
            ["pos"] = vector3(2322.13, 5875.92, 7.75), 
            ["heading"] = 350.61
        },
        ["right"] = { 
            ["pos"] = vector3(2323.958, 5878.036, 7.758846), 
            ["heading"] = 79.34
        },
        ["left2"] = { 
            ["pos"] = vector3(2319.92, 5878.24, 7.75), 
            ["heading"] = 264.75
        },
        ["right2"] = { 
            ["pos"] = vector3(2322.03, 5880.24, 7.75), 
            ["heading"] = 178.83
        },
    }
}

cfg_simpleRobberys.list = {
    --[[{
        name = "Galerie d'arts",
        pos = vector3(14.94, 137.89, 93.79),

        dst = 2.5,
        helpNotif = "Appuyez sur ~INPUT_CONTEXT~ pour braquer la galerie d'arts",
        showMarker = true,

        key = 38,
        singleKey = true,
        neededCops = 5,
        requiredLevel = 35,
        requiredGang = true,
        notHavingNeededItem = "~r~Vous n'avez pas le niveau nécessaire pour faire ce braquage",

        animation = true,
        animationType = "drilling",
        neededItem = "Perceuse",
        neededItemCount = 1,
        beforeAnimation = false,
        failAnimNotif = "~r~Vous avez cassé votre perceuse",
        notHavingNeededItem = "~r~Vous n'avez pas de perceuse sur vous",
        removeItemOnLose = true,

        openDoor = true,
        doorIndex = 124,

        coords = vector3(14.94, 137.89, 93.79),
        heading = 71.33,

        blip = true,
        blipStatic = false,
        blipSprite = 587,
        blipScale = 0.65,
        blipColor = 1,
        blipName = "Galerie d'arts",

        alertMessage = "Braquage de la galerie d'arts en cours",
        timeRob = 360 * 1000,
        barMessage = "⌛ Braquage de la galerie d'arts en cours...",

        maxDst = 25.0,
        cantNotif = "~r~Cette galerie d'arts a déjà été braquée",
        notEnoughtNotif = "~r~Il n'y a pas assez de policiers pour ce braquage",
        cooldown = 1800,

        rewardType = "chanceInv",
        rewardCount = 5,
        reward = {
            {name = "Tableau_1",   label = "Tableau bas de gamme",    args = {},   chance = 500},
            {name = "Tableau_2",   label = "Tableau moyenne gamme",   args = {},   chance = 250},
            {name = "Tableau_3",   label = "Tableau haut de gamme",     args = {},   chance = 75},
        },
    },--]]
    {
        name = "Coffre-fort Cayo Perico",
        pos = vector3(5010.54, -5757.17, 14.48),

        dst = 2.5,
        helpNotif = "Appuyez sur ~INPUT_CONTEXT~ pour braquer ce coffre fort",
        showMarker = true,

        key = 38,
        singleKey = true,
        neededCops = 7,
        requiredLevel = 35,

        animation = true,
        animationType = "drilling",
        neededItem = "Perceuse_puissante",
        neededItemCount = 1,
        beforeAnimation = false,
        failAnimNotif = "~r~Vous avez cassé votre perceuse puissante",
        notHavingNeededItem = "~r~Vous n'avez pas de perceuse puissante sur vous",
        removeItemOnLose = true,

        coords = vector3(5010.54, -5757.17, 14.48),
        heading = 237.15,

        blip = true,
        blipStatic = true,
        blipSprite = 765,
        blipScale = 0.65,
        blipColor = 1,
        blipName = "Braquage Cayo Perico",

        alertMessage = "Braquage du coffre-fort en cours",
        --timeRob = 300 * 1000,
        timeRob = 3 * 1000,
        barMessage = "⌛ Braquage du coffre-fort en cours...",

        maxDst = 25.0,
        cantNotif = "~r~Ce coffre-fort a déjà été braqué",
        notEnoughtNotif = "~r~Il n'y a pas assez de policiers pour ce braquage",
        cooldown = 1800,

        rewardType = "dirtyMoney",
        reward = 50000,
    },
    {
        name = "Pacific",
        pos = vector3(2325.85, 5860.77, 7.79),

        dst = 2.5,
        helpNotif = "Appuyez sur ~INPUT_CONTEXT~ pour pirater le ~c~terminal du coffre",
        showMarker = true,

        key = 38,
        singleKey = true,
        --neededCops = 7,
        neededCops = 1,
        requiredLevel = 35,

        animation = true,
        animationType = "keystroke",
        neededItem = "USB2",
        neededItemCount = 1,
        beforeAnimation = false,
        failAnimNotif = "~r~Vous avez cassé échoué le piratage",
        notHavingNeededItem = "~r~Vous n'avez pas de clé USB flash sur vous",
        removeItemOnLose = true,

        coords = vector3(2325.85, 5860.77, 7.79),
        heading = 225.908,

        blip = true,
        blipStatic = true,
        blipSprite = 272,
        blipScale = 0.65,
        blipColor = 1,
        blipName = "Braquage Pacific",

        alertMessage = "Piratage du controleur de porte en cours",
        --timeRob = 420 * 1000,
        timeRob = 4 * 1000,
        barMessage = "⌛ Piratage du controleur de porte en cours...",

        maxDst = 25.0,
        cantNotif = "~r~Cet ordinateur a déjà été piraté",
        notEnoughtNotif = "~r~Il n'y a pas assez de policiers pour ce braquage",
        cooldown = 1800,

        rewardType = "dirtyMoney",
        reward = 50000,
    },
}