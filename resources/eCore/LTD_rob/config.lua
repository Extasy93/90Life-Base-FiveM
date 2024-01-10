ConfigLTD = {}
Translation = {}

ConfigLTD.Shopkeeper = 416176080 -- hash
ConfigLTD.Locale = 'en' 

ConfigLTD.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0, money = {5000, 15000}, cops = 1, blip = true, name = "~o~24/7 MID", cooldown = {hour = 2, minute = 0, second = 1}, robbed = false},
    {coords = vector3(-705.73, -914.91, 19.22-0.98), heading = 91.0, money = {7500, 19500}, cops = 1, blip = true, name = "~o~7/11 LTD", cooldown = {hour = 2, minute = 0, second = 1}, robbed = false}

}

Translation = {
    ['en'] = {
        ['shopkeeper'] = 'commerçant',
        ['robbed'] = ": J'ai déjà été volé, ~r~je n'ai plus d'argent!",
        ['cashrecieved'] = 'Vous avez:',
        ['currency'] = '$',
        ['scared'] = 'Effrayé:',
        ['no_cops'] = 'Il n\'y a ~r~ pas ~w~ assez de policers en service!',
        ['cop_msg'] = 'Une photo du voleur a été prise par la caméra CCTV!',
        ['set_waypoint'] = 'Définir le waypoint vers le magasin',
        ['hide_box'] = 'Fermer cette boîte',
        ['robbery'] = '~r~Vol en cours',
        ['walked_too_far'] = 'Vous êtes allé trop loin!'
    }
}