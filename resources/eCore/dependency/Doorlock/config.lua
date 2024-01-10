
cfg_doorlock = {}

cfg_doorlock.DoorList = {



	--------------------
	-- NOUVEAU COMICO --
	--------------------

	-- Porte entrées
	
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = {'police'},
		locked = true,
		distance = 3,
		doors = {
			{
				objName = 'gabz_mrpd_reception_entrancedoor',
				objYaw = 270.0,
				objCoords  = vector3(434.7, -980.75, 30.81)
			},

			{
				objName = 'gabz_mrpd_reception_entrancedoor',
				objYaw = 90.0,
				objCoords = vector3(434.7, -983.0781, 30.8)
			}
		}
	},

	--Portes entrées 2
	{
		textCoords = vector3(441.8, -998.73, 31.5),
		authorizedJobs = {'police'},
		locked = true,
		distance = 3,
		doors = {
			{
				objName = 'gabz_mrpd_reception_entrancedoor',
				objYaw = 360.0,
				objCoords  = vector3(440.7392, -998.7462, 30.8),
			},

			{
				objName = 'gabz_mrpd_reception_entrancedoor',
				objYaw = 180.0,
				objCoords = vector3(443.0618,-998.7462,30.8153),
			}
		}
	},

	-- Portes entrées 3 

	{
		textCoords = vector3(457.24, -972.00, 31.3),
		authorizedJobs = {'police'},
		locked = true,
		distance = 3,
		doors = {
			{
				objName = 'gabz_mrpd_reception_entrancedoor',
				objYaw = 360.0,
				objCoords  = vector3(455.8861, -972.2542, 30.8153),
			},

			{
				objName = 'gabz_mrpd_reception_entrancedoor',
				objYaw = 180.0,
				objCoords = vector3(458.2087, -972.2542, 30.8153),
			}
		}
	},

	-- Bureau du capitaine

	{
		textCoords = vector3(458.6543, -990.00, 31.5),
		authorizedJobs = {'police'},
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'gabz_mrpd_door_05',
				objYaw = 270.0,
				objCoords = vector3(458.6543, -990.6497, 30.8231),
			},
		}
	},
	
	-- Toutes les cellules

	-- Porte d'entrée cellule 1

	{
		textCoords = vector3(476.6156, -1008.08, 26.60),
		authorizedJobs = {'police'},
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'gabz_mrpd_cells_door',
				objYaw = 270.0,
				objCoords = vector3(476.6156, -1008.8754, 26.4800),
			},
		}
	},

	-- Porte d'entrée cellule 2

	{
		textCoords = vector3(482.0083, -1004.1179, 26.4800),
		authorizedJobs = {'police'},
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'gabz_mrpd_cells_door',
				objYaw = 180.0,
				objCoords = vector3(481.0083, -1004.1179, 26.4800),
			},
		}
	},

	-- Cellule 1 

	{
		textCoords = vector3(477.00, -1012.1886, 26.4800),
		authorizedJobs = {'police'},
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'gabz_mrpd_cells_door',
				objYaw = 360.0,
				objCoords = vector3(477.9125, -1012.1886, 26.4800),
			},
		}
	},

	-- Cellule 2

	{
		textCoords = vector3(480.00, -1012.1886, 26.4800),
		authorizedJobs = {'police'},
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'gabz_mrpd_cells_door',
				objYaw = 360.0,
				objCoords = vector3(480.9128, -1012.1886, 26.4800),
			},
		}
	},

	-- Cellule 3

	{
		textCoords = vector3(483.00, -1012.1886, 26.4800),
		authorizedJobs = {'police'},
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'gabz_mrpd_cells_door',
				objYaw = 360.0,
				objCoords = vector3(483.9127, -1012.1886, 26.4800),
			},
		}
	},

	-- Cellule 4

	{
		textCoords = vector3(486.00, -1012.1886, 26.4800),
		authorizedJobs = {'police'},
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'gabz_mrpd_cells_door',
				objYaw = 360.0,
				objCoords = vector3(486.9127, -1012.1886, 26.4800),
			},
		}
	},

	-- Cellule 5

	{
		textCoords = vector3(485.00, -1007.7343, 26.4800),
		authorizedJobs = {'police'},
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'gabz_mrpd_cells_door',
				objYaw = 180.0,
				objCoords = vector3(484.1764, -1007.7343, 26.4800),
			},
		}
	},

	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = {'police'},
		locked = true,
		maxDistance = 4,
		doors = {
			{objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 0.0, objCoords  = vector3(467.3, -1014.4, 26.5)},
			{objHash = GetHashKey('v_ilev_rc_door2'), objHeading = 180.0, objCoords  = vector3(469.9, -1014.4, 26.5)}
		}
	},

	-- Portes arrières

	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = {'police'},
		locked = true,
		distance = 13,
		doors = {
			{
				objName = 'gabz_mrpd_room25_doorframe',
				objYaw = 270.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'gabz_mrpd_room25_doorframe',
				objYaw = 90.0,
				objCoords = vector3(469.9, -1014.4, 26.5)
			}
		}
	},


	-- Garage derrière  

	{
		textCoords = vector3(488.98, -1019.86, 28.21),
		authorizedJobs = {'police'},
		locked = true,
		distance = 15.5,
		doors = {
			{
				objName = 'hei_prop_station_gate',
				objCoords = vector3(488.8948, -1017.2119, 27.1493),
			},
		}
	},




	-------------
	-- BAHAMAS -- 
	-------------

		
	{
		textCoords = vector3(-1393.231, -592.448, 30.02),
		authorizedJobs = { 'bahamas' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor006',
				objYaw = 303.73,
				objCoords  = vector3(-1392.09, -593.34, 30.47)
			},

			{
				objName = 'v_ilev_ph_gendoor006',
				objYaw = 122.49,
				objCoords = vector3(-1393.51, -591.16, 30.47)
			}
		}
	},

	-------------
	-- UNICORN --
	-------------

	-- Portes Unicorn devant
	{
		textCoords = vector3(128.59, -1298.18, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 'prop_strip_door_01',
				objYaw = 30.00,
				objCoords  = vector3(127.95, -1298.50, 29.41)
			}
		}	
	},	

	-- Portes Unicorn arrière
	{
		textCoords = vector3(95.46, -1285.21, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 'prop_magenta_door',
				objYaw = 210.50,
				objCoords  = vector3(96.09, -1284.85, 29.43)
			}
		}	
	},		
	
	-- Portes dans l'Unicorn vestiaire 
	{
		textCoords = vector3(113.56, -1296.74, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 'v_ilev_door_orangesolid',
				objYaw = 300.00,
				objCoords  = vector3(113.98, -1297.43, 29.41)
			}
		}	
	},	
	
	-- Portes dans l'Unicorn bureau patron
	{
		textCoords = vector3(99.75, -1293.32, 29.50),
		authorizedJobs = { 'unicorn' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 'v_ilev_roc_door2',
				objYaw = 30.00,
				objCoords  = vector3(99.08, -1293.70, 29.41)
			}
		}	
	},	

	-------------
	-- weed shop --
	------------- 
	
	{
		textCoords = vector3(376.92, -816.86, 29.65),
		authorizedJobs = { 'weedshop' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 'v_ilev_cd_door3',
				objYaw = 90.00,
				objCoords  = vector3(376.92, -816.86, 29.65)
			},

			{
				objName = 'v_ilec_fib_door3',
				objYaw = 20.50,
				objCoords  = vector3(382.02, -825.06, 29.65)
			},
		}
	},

	-----------------
	-- YELLOW JACK --
	-----------------

	{
		textCoords = vector3(1990.65, 3053.20, 48.00),
		authorizedJobs = { 'yellow' },
		locked = true,
		distance = 2,
		doors = {
			{
				objName = 'v_corp_hicksdoor',
				objYaw = 150.00,
				objCoords  = vector3(1991.106, 3053.105, 47.36528)
			}
		}	
	},


	------------
	-- LOSTMC -- 
	------------
	
	{
		textCoords = vector3(959.73, -141.07, 76.0),
		authorizedJobs = { 'mechanic' },
		locked = true,
		distance = 10,
		size = 2,
		doors = {
			{
				objName = 'prop_fnclink_03gate2',
				objCoords  = vector3(962.4235, -141.7253, 73.6346)
			}
		}	
	},


	------------
	-- BCSO -- 
	------------

	{
		textCoords = vector3(-449.1, 6015.742, 24.82108),
		authorizedJobs = { 'bcso' },
		locked = true,
		distance = 2,
		size = 2,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 45.000080108642,
				objCoords  = vector3(-449.1, 6015.742, 24.82108)
			}
		}	
	},

	{
		textCoords = vector3(-455.5054, 6015.458, 24.82108),
		authorizedJobs = { 'bcso' },
		locked = true,
		distance = 2,
		size = 2,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 315.00006103516,
				objCoords  = vector3(-455.5054, 6015.458, 24.82108)
			}
		}	
	},

	{
		textCoords = vector3(-455.5054, 6015.458, 24.82108),
		authorizedJobs = { 'bcso' },
		locked = true,
		distance = 2,
		size = 2,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 315.00006103516,
				objCoords  = vector3(-455.5054, 6015.458, 24.82108)
			}
		}	
	},

	{
		textCoords = vector3(-451.1762, 6011.128, 24.82108),
		authorizedJobs = { 'bcso' },
		locked = true,
		distance = 2,
		size = 2,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 315.00006103516,
				objCoords  = vector3(-451.1762, 6011.128, 24.82108)
			}
		}	
	},

	{
		textCoords = vector3(-453.333, 6013.286, 24.82108),
		authorizedJobs = { 'bcso' },
		locked = true,
		distance = 2,
		size = 2,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 315.00006103516,
				objCoords  = vector3(-453.333, 6013.286, 24.82108)
			}
		}	
	},

}
	