cfg_VcCustoms                            = {}

cfg_VcCustoms.pos = {
	garage = {
		position = {x = 2367.2639160156, y = 6467.2915039063, z = 8.2486257553101}
	},

	spawnvoiture = {
		position = {x = 2362.6435546875, y = 6467.25, z = 8.2486257553101, h = 180.09262084960938}
	},
}

cfg_VcCustoms.DrawDistance      = 15.0
cfg_VcCustoms.IsMechanicJobOnly = true
cfg_VcCustoms.IsMotorCycleBikerOnly = false
cfg_VcCustoms.shopProfit = 15

cfg_VcCustoms.Zones = {
	[1] = {
		Pos   = {x = 2384.69, y = 6490.69, z = 10.23},
		Size  = {x = 10.0, y = 10.0, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = 'Vice City Customs',
		Hint  = 'Appuyez sur ~p~[E]~s~ pour ~p~Personnaliser le véhicule'
	},
	[2] = {
		Pos   = {x = 2369.74, y = 6494.62, z = 10.23},
		Size  = {x = 10.0, y = 10.0, z = 0.2},
		Color = {r = 204, g = 204, b = 0},
		Marker= 1,
		Name  = 'Vice City Customs 2',
		Hint  = 'Appuyez sur ~p~[E]~s~ pour ~p~Personnaliser le véhicule'
	},
}

GetPlatesName = function(index)
	if (index == 0) then
		return 'bleu sur blan'
	elseif (index == 1) then
		return 'jaune sur noir'
	elseif (index == 2) then
		return 'jaune sur bleu'
	elseif (index == 3) then
		return 'bleu sur blanc'
	elseif (index == 4) then
		return 'bleu sur blanc 2'
	end
end

cfg_VcCustoms.bodyParts = {
	[1] = {
		mod = 'modSpoilers',
		label = 'Aileron',
		modType = 0,
		items = {
			label = {},
			price = 2.65
		}
	},
	[2] = {
		mod = 'modFrontBumper',
		label = 'Le pare-choc avant',
		modType = 1,
		items = {
			label = {},
			price = 2.12
		}
	},
	[3] = {
		mod = 'modRearBumper',
		label = 'Pare-chocs arrière',
		modType = 2,
		items = {
			label = {},
			price = 2.12
		}
	},
	[4] = {
		mod = 'modSideSkirt',
		label = 'Bas de caisse',
		modType = 3,
		items = {
			label = {},
			price = 2.65
		}
	},
	[5] = {
		mod = 'modExhaust',
		label = 'Pot d\'échapement',
		modType = 4,
		items = {
			label = {},
			price = 2.12
		}
	},
	[6] = {
		mod = 'modFrame',
		label = 'Arcaux',
		modType = 5,
		items = {
			label = {},
			price = 2.12
		}
	},
	[7] = {
		mod = 'modGrille',
		label = 'Grille',
		modType = 6,
		items = {
			label = {},
			price = 1.72
		}
	},
	[8] = {
		mod = 'modHood',
		label = 'Capot',
		modType = 7,
		items = {
			label = {},
			price = 2.88
		}
	},
	[9] = {
		mod = 'modFender',
		label = 'Garde-boue gauche',
		modType = 8,
		items = {
			label = {},
			price = 2.12
		}
	},
	[10] = {
		mod = 'modRightFender',
		label = 'Garde-boue droite',
		modType = 9,
		items = {
			label = {},
			price = 2.12
		}
	},
	[11] = {
		mod = 'modRoof',
		label = 'Toit',
		modType = 10,
		items = {
			label = {},
			price = 2.58
		}
	},
	[12] = {
		mod = 'wheels',
		label = 'Type de roue',
		items = { 'sport', 'muscle', 'lowrider', 'suv', 'allterrain', 'tuning', 'highend', 'motorcycle' },
		modType = 23,
		wheelType = { 0, 1, 2, 3, 4, 5, 7, 6 },
	},
	[13] = {
		mod = 'modFrontWheels',
		label = 'Roues',
		modType = 23,
		items = {
			label = {},
			price = 2.58
		}
	}
}

cfg_VcCustoms.windowTints = { 
	mod = 'windowTint',
	label = { '[1/7]', '[2/7]', '[3/7]', '[4/7]', '[5/7]', '[6/7]', '[7/7]' },
	label1 = 'teinte de fenêtre',
	tint = { -1, 0, 1, 2, 3, 4, 5 },
	price = 2.58
}

cfg_VcCustoms.colorParts = {
	label = { 'Primaire', 'Secondaire', 'Nacrage', 'Fenêtres' },
	mod = { 'primary', 'secondary', 'pearlescent', 'windows' },
	wheelColorPrice = 1.58,
	primaryColorPrice = 3,
	secondaryColorPrice = 2,
	pearlescentColorPrice = 2,
	customPrimaryColorPrice = 2,
	customSecondaryColorPrice = 2,
	primaryPaintFinishPrice = 3,
	secondaryPaintFinishPrice = 2
}

cfg_VcCustoms.resprayTypes = {
	[1] = {
		label = { 'Métallique', 'Mat', 'Utile', 'Dépenses', 'Brossé', 'Autres' },
		mod = { 'metallic', 'matte', 'util', 'worn', 'brushed', 'others'}
	},
	[2] = {
		label = { 'Métallique', 'Mat', 'Utile', 'Dépenses', 'Brossé', 'Autres' },
		mod = { 'metallic', 'matte', 'util', 'worn', 'brushed', 'others' }
	},
	[3] = {
		label = { 'Métallique', 'Mat', 'Utile', 'Dépenses', 'Brossé', 'Autres' },
		mod = { 'metallic', 'matte', 'util', 'worn', 'brushed', 'others' }
	},
	[4] = {
		label = { '[1/7]', '[2/7]', '[3/7]', '[4/7]', '[5/7]', '[6/7]', '[7/7]' },
		tint = { -1, 0, 1, 2, 3, 4, 5 },
		price = 5.58
	}
}

cfg_VcCustoms.tireSmoke = {
	mod = 'modSmokeEnabled',
	label = 'Fumée de pneus',
	mod1 = 'tyreSmokeColor',
	label1 = 'Couleur de Fumée de pneus',
	price = 1.58
}

cfg_VcCustoms.xenon = {
	mod = 'modXenon',
	label = 'Phares',
	mod1 = 'xenonColor',
	label1 = 'Couleur xénon',
	items = {
		label = { '[1/14]', '[2/14]', '[3/14]', '[4/14]', '[5/14]', '[6/14]', '[7/14]', '[8/14]', '[9/14]', '[10/14]', '[11/14]', '[12/14]', '[13/14]', '[14/14]' },
		color = { -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 }
	},
	price = 1.58
}

cfg_VcCustoms.colorPalette = {
	[1] = { 
		metallic = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 49, 50, 51, 52, 53, 54, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 112, 125, 137, 141, 142, 143, 145, 146, 150, 156 }
	},
	[2] = { 
		matte = { 12, 13, 14, 39, 40, 41, 42, 55, 82, 83, 84, 128, 129, 131, 148, 149, 151, 152, 153, 154, 155 }
	},
	[3] = { 
		util = { 15, 16, 17, 18, 19, 20, 43, 44, 45, 56, 57, 75, 76, 77, 78, 79, 80, 81, 108, 109, 110, 122 }
	},
	[4] = { 
		worn = { 21, 22, 23, 24, 25, 26, 47, 48, 58, 59, 60, 85, 86, 87, 113, 114, 115, 116, 121, 123, 124, 126, 130, 132, 133 }
	},
	[5] = { 
		brushed = { 117, 118, 119, 159 }
	},
	[6] = { 
		others = { 120, 127, 134, 135, 136, 138, 139, 140, 144, 147, 157, 158 }
	},
	[7] = {
		personalize = {  }
	},
	[8] = { 
		wheelPrice = 2.58
	}
}

cfg_VcCustoms.paintFinish = { 0, 12, 15, 21, 117, 120 }

cfg_VcCustoms.neons = {
	[1] = {
		mod = 'leftNeon',
		label = 'Néon gauche',
		price = 2.49
	},
	[2] = {
		mod = 'rightNeon',
		label = 'Droite Neon',
		price = 2.49
	},
	[3] = {
		mod = 'frontNeon',
		label = 'Néon avant',
		price = 2.49
	},
	[4] = {
		mod = 'backNeon',
		label = 'Néon arrière',
		price = 2.49
	},
	[5] = {
		label = 'Car neon',
		mod = 'neonColor',
		mod1 = 'neonEnabled',
		price = 2.49
	}
}

cfg_VcCustoms.extras = {
	[1] = {
		mod = 'modPlateHolder',
		label = 'Plaque - arrière',
		modType = 25,
		items = {
			label = {},
			price = 3.49
		}
	},
	[2] = {
		mod = 'modVanityPlate',
		label = 'Plaque - Avant',
		modType = 26,
		items = {
			label = {},
			price = 1.1
		}
	},
	[3] = {
		mod = 'modTrimA',
		label = 'Interieur',
		modType = 27,
		items = {
			label = {},
			price = 3.98
		}
	},
	[4] = {
		mod = 'modOrnaments',
		label = 'Garniture',
		modType = 28,
		items = {
			label = {},
			price = 0.9
		}
	},
	[5] = {
		mod = 'modDashboard',
		label = 'Tableau de bord',
		modType = 29,
		items = {
			label = {},
			price = 2.65
		}
	},
	[6] = {
		mod = 'modDial',
		label = 'Compteur de vitesse',
		modType = 30,
		items = {
			label = {},
			price = 2.19
		}
	},
	[7] = {
		mod = 'modDoorSpeaker',
		label = 'Porte haut parleur',
		modType = 31,
		items = {
			label = {},
			price = 2.58
		}
	},
	[8] = {
		mod = 'modSeats',
		label = 'Siège',
		modType = 32,
		items = {
			label = {},
			price = 2.65
		}
	},
	[9] = {
		mod = 'modSteeringWheel',
		label ='Volant',
		modType = 33,
		items = {
			label = {},
			price = 2.19
		}
	},
	[10] = {
		mod = 'modShifterLeavers',
		label = 'Levier de vitesse',
		modType = 34,
		items = {
			label = {},
			price = 1.26
		}
	},
	[11] = {
		mod = 'modAPlate',
		label = 'Plage arrière',
		modType = 35,
		items = {
			label = {},
			price = 2.19
		}
	},
	[12] = {
		mod = 'modSpeakers',
		label = 'Haut parleur',
		modType = 36,
		items = {
			label = {},
			price = 2.98
		}
	},
	[13] = {
		mod = 'modTrunk',
		label = 'Coffre',
		modType = 37,
		items = {
			label = {},
			price = 2.58
		}
	},
	[14] = {
		mod = 'modHydrolic',
		label = 'Hydraulic',
		modType = 38,
		items = {
			label = {},
			price = 2.12
		}
	},
	[15] = {
		mod = 'modEngineBlock',
		label = 'Block moteur',
		parent = 'cosmetics',
		modType = 39,
		items = {
			label = {},
			price = 12.12
		}
	},
	[16] = {
		mod = 'modAirFilter',
		label = 'Filtre a air',
		modType = 40,
		items = {
			label = {},
			price = 2.72
		}
	},
	[17] = {
		mod = 'modStruts',
		label = 'Entretoises',
		modType = 41,
		items = {
			label = {},
			price = 2.51
		}
	},
	[18] = {
		mod = 'modArchCover',
		label = 'Couverture d\'arche',
		modType = 42,
		items = {
			label = {},
			price = 2.19
		}
	},
	[19] = {
		mod = 'modAerials',
		label = 'Antennes',
		modType = 43,
		items = {
			label = {},
			price = 1.12
		}
	},
	[20] = {
		mod = 'modTrimB',
		label = 'Ailes',
		modType = 44,
		items = {
			label = {},
			price = 2.05
		}
	},
	[21] = {
		mod = 'modTank',
		label = 'Réservoir d\'essence',
		modType = 45,
		items = {
			label = {},
			price = 2.19
		}
	},
	[22] = {
		mod = 'modWindows',
		label = 'Fenêtres',
		modType = 46,
		items = {
			label = {},
			price = 2.19
		}
	},
	[23] = {
		mod = 'modLivery',
		label = 'Autocollants',
		modType = 48,
		items = {
			label = {},
			price = 3.3
		}
	},
	[24] = {
		mod = 'modHorns',
		label = 'Klaxon',
		modType = 14,
		items = {
			label = {},
			price = 3.30
		}
	}
}

cfg_VcCustoms.upgrades = {
	[1]	= {
		mod = 'modArmor',
		label = 'Armure',
		modType = 16,
		items = {
			--[[label = {'Stock', 'Level 1', 'Level 2', 'Level 3', 'Level 4', 'Level 5', 'Level 6'},--]]
			label = {},
			price = { 0, 20.77, 30.28, 50.00, 999.00, 999.00, 999.00 }
		}
	},
	[2]	= {
		mod = 'modEngine',
		label = 'Moteur',
		modType = 11,
		items = {
			--[[label = {'Stock', 'Level 1', 'Level 2', 'Level 3', 'Level 4'},--]]
			label = {},
			price = { 0, 50.00, 70.00, 600.00, 1200.00, 1400.00 }
		}
	},
	[3]	= {
		mod = 'modTransmission',
		label = 'Transmission',
		modType = 13,
		items = {
			--[[label = {'Stock', 'Level 1', 'Level 2', 'Level 3', 'Level 4'},--]]
			label = {},
			price = { 0, 15.00, 17.00, 110.00, 112.00, 115.00 }
		}
	},
	[4]	= {
		mod = 'modBrakes',
		label = 'Frein',
		modType = 12,
		items = {
			--[[label = {'Stock', 'Level 1', 'Level 2', 'Level 3', 'Level 4'},--]]
			label = {},
			price = { 0, 14.65, 19.3, 110.6, 113.95, 115.00, 120.00 }
		}
	},
	[5]	= {
		mod = 'modSuspension',
		label = 'Suspension',
		modType = 15,
		items = {
			--[[label = {'Stock', 'Level 1', 'Level 2', 'Level 3', 'Level 4', 'Level 5'},--]]
			label = {},
			price = { 0, 13.65, 18.3, 111.6, 114.95, 115.00, 119.00 }
		}
	},
	[6]	= {
		mod = 'modTurbo',
		label = 'Turbo',
		modType = 18,
		items = {
			--[[label = {'Stock', 'Level 1'},--]]
			label = {},
			price = { 0, 130.00 }
		}
	}
}