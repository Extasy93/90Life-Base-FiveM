Config = {}
Config.Locale = 'fr'

Config.Accounts = {
	bank = _U('account_bank'),
	black_money = _U('account_black_money'),
	money = _U('account_money')
}

Config.FirstSpawnCoords = {x = -235.48, y = -2003.06, z = 24.68, heading = 7.48}

Config.StartingAccountMoney = {money = 5000, bank = 0}

Config.EnableSocietyPayouts = false -- payer à partir du compte de la société dans lequel le joueur est employé? Exigence: esx_society
Config.EnableJob2Payouts 	= true -- les joueurs reçoivent également de l'argent de leur deuxième emploi si activé
Config.DisableWantedLevel   = true
Config.EnableHud            = false -- activer le hud par défaut? Afficher le travail et les comptes actuels (noir, banque et espèces)
Config.EnablePvP            = true -- activer le pvp?
Config.MaxWeight            = 24000   -- le poids maximum de l'inventaire sans sac à dos (c'est en grammes, pas en kg!)

Config.EnableDebug          = true
Config.PrimaryIdentifier	= "license:" -- Options: steam, licence (club social), fivem, discord, xbl, live (steam par défaut, recommandé: fivem) cela DEVRAIT aussi fonctionner avec la plupart des scripts plus anciens!

-- Le modèle de lecteur par défaut que vous utiliserez si aucun autre script ne contrôle votre modèle de lecteur
Config.DefaultPlayerModel	= `mp_m_freemode_01` 
Config.DefaultPickupModel = `prop_money_bag_01`