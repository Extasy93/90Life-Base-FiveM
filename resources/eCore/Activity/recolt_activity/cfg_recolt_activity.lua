cfg_recolt_activity = {}

cfg_recolt_activity.points = {
    {
        pos      = vector3(241.75, 6517.93, 31.22),
        item     = "Orange",
        count    = 1,
        size     = 45.0,
        time     = 12000,
        marker   = false,
        msg      = "Appuyez sur ~INPUT_CONTEXT~ pour récolter des ~o~oranges",

        sprite  = 568,
        display = 4,
        scale   = 0.55,
        colour  = 44,
        name    = "Champs d'orange'",
    },
    {
        pos      = vector3(351.24, 6517.93, 28.72),
        item     = "Pomme",
        count    = 1,
        size     = 45.0,
        time     = 12000,
        marker   = false,
        msg      = "Appuyez sur ~INPUT_CONTEXT~ pour récolter des ~g~pommes",

        sprite  = 568,
        display = 4,
        scale   = 0.55,
        colour  = 43,
        name    = "Champs de pommes",
    },
    {
        pos      = vector3(2021.24, 4892.93, 42.72),
        item     = "Framboises",
        count    = 1,
        size     = 45.0,
        time     = 12000,
        marker   = false,
        msg      = "Appuyez sur ~INPUT_CONTEXT~ pour récolter des ~r~framboises",

        sprite  = 568,
        display = 4,
        scale   = 0.55,
        colour  = 48,
        name    = "Champs de framboises",
    },
    {
        pos      = vector3(2058.1, 4930.59, 40.96),
        item     = "Framboises",
        count    = 1,
        size     = 45.0,
        time     = 12000,
        marker   = false,
        msg      = "Appuyez sur ~INPUT_CONTEXT~ pour récolter des ~r~framboises",

        sprite  = 568,
        display = 4,
        scale   = 0.55,
        colour  = 48,
        name    = "Champs de framboises",
    },
    {
        pos      = vector3(1953.91, 4856.37, 45.39),
        item     = "Mures",
        count    = 1,
        size     = 45.0,
        time     = 12000,
        marker   = false,
        msg      = "Appuyez sur ~INPUT_CONTEXT~ pour récolter des ~p~mûres",

        sprite  = 568,
        display = 4,
        scale   = 0.55,
        colour  = 23,
        name    = "Champs de mûres",
    },
    {
        pos      = vector3(1885.32, 5065.06, 48.5),
        item     = "Myrtilles",
        count    = 1,
        size     = 45.0,
        time     = 12000,
        marker   = false,
        msg      = "Appuyez sur ~INPUT_CONTEXT~ pour récolter des ~b~myrtilles",

        sprite  = 568,
        display = 4,
        scale   = 0.55,
        colour  = 27,
        name    = "Champs de myrtilles",
    },
}

Citizen.CreateThread(function()
    while extasy_core_cfg == nil do Wait(1) end
    cfg_recolt_activity.items = {
        {
            item = {
                {name="Framboises",price=extasy_core_cfg["framboise_price"]},
                {name="Mures",price=extasy_core_cfg["mure_price"]},
                {name="Myrtilles",price=extasy_core_cfg["myrtille_price"]},
                {name="Pomme",price=extasy_core_cfg["pomme_price"]},
                {name="Orange",price=extasy_core_cfg["orange_price"]},
            },
        },
    }
end)