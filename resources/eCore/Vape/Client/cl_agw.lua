playerGroup = nil
ESX = nil
firstco = true

TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('ext:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end)

local textaffstat = 100
local animbleed = false
local ped = GetPlayerPed(-1)
local bleedtouch = false
local PlayerData                = {}
local CurrentAction
local HasAlreadyEnteredMarker   = false
local LastZone
local pedfait = false

local weaponlist = {
	"WEAPON_KNIFE",
	"WEAPON_KNUCKLE",
--	"WEAPON_NIGHTSTICK",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_BOTTLE",
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_MACHETE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_SWITCHBLADE",
	"WEAPON_PROXMINE",
	"WEAPON_BZGAS",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_SNOWBALL",
	"WEAPON_FLARE",
	"WEAPON_BALL",
	"WEAPON_REVOLVER",
	"WEAPON_POOLCUE",
	"WEAPON_PIPEWRENCH",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_STUNGUN",
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_GRENADE",
	"WEAPON_STICKYBOMB",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_RAYPISTOL",
	"WEAPON_RAYCARBINE",
	"WEAPON_RAYMINIGUN",
	"WEAPON_DIGISCANNER"
}

function SetWeaponDrops()
	RemoveAllPickupsOfType(14)
end

Citizen.CreateThread(function()
  	Wait(13 * 1000)
  	local armesenstock = false
  	Wait(1)
  	Citizen.CreateThread(function()
  		while true do
  			PlayerData = ESX.GetPlayerData()
  			if ESX.PlayerData.job and PlayerData.job.name == "police" or PlayerData.job.name == "bcso" then
  				--print("Bypass")
			else
				local me = GetPlayerPed(-1)
  				local armesposs = {}
  
  				for w in pairs(weaponlist) do
  					if ESX.GetWeaponLabel(weaponlist[w]) ~= nil then
  						if HasPedGotWeapon(me, GetHashKey(weaponlist[w]), false) then
  							table.insert(armesposs, weaponlist[w])
  							armesenstock = true
  						end
  					end
  				end
  
  				if armesenstock then
  					TriggerServerEvent('overcheckweapon', token, armesposs)
  				end
			end
  			Wait(20 * 1000)
  		end
  	end)
end)

RegisterNetEvent('esx:overRemoveW')
AddEventHandler('esx:overRemoveW', function(weaponName, ammo)
	local playerPed  = GetPlayerPed(-1)
	local weaponHash = GetHashKey(weaponName)

	PlayerData = ESX.GetPlayerData()
	if ESX.PlayerData.job and PlayerData.job.name == "police" or PlayerData.job.name == "bcso" then
		--print("C'est rien c'est les keufs")
	else
		RemoveWeaponFromPed(playerPed, weaponHash)
		RemoveWeaponFromPed(playerPed, weaponHash)
		Citizen.Wait(1000)
		RemoveWeaponFromPed(playerPed, weaponHash)
		Citizen.Wait(1000)
		RemoveWeaponFromPed(playerPed, weaponHash)
		Citizen.Wait(1000)
		RemoveWeaponFromPed(playerPed, weaponHash) -- Autant de fois pour le debug

		print("Tu as cette arme give en inventaire : " .. weaponHash)

		--ExecuteCommand('report Je possède une ' .. weaponName ..' give par un modder. Mais je ne suis peut-êre pas le moddeur !')

		if ammo then
			local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
			local finalAmmo = math.floor(pedAmmo - ammo)
			SetPedAmmo(playerPed, weaponHash, finalAmmo)
		else
			SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
		end
	end
end)

AddEventHandler('esx:addWeapon', function(weaponName, ammo)
	local armesenstock = false
	PlayerData = ESX.GetPlayerData()
	Wait(1000)
     
	if ESX.PlayerData.job and PlayerData.job.name == "police" or PlayerData.job.name == "bcso" then
		-- Bypass
	else
		local me = GetPlayerPed(-1)
		local armesposs = {}

		for w in pairs(weaponlist) do
			if ESX.GetWeaponLabel(weaponlist[w]) ~= nil then
				if HasPedGotWeapon(me, GetHashKey(weaponlist[w]), false) then
					table.insert(armesposs, weaponlist[w])
					armesenstock = true
				end
			end
		end

		if armesenstock then
			TriggerServerEvent('overcheckweapon', token, armesposs)
		end
	end
end)
