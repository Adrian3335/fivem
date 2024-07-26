return {
	General = {
		name = 'Sklep',
		blip = {
			id = 59, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'burger', price = 10 },
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'phone', price = 150 },
			{ name = 'scratchcard', price = 1000 },
			{ name = 'scratchcardgold', price = 2500 },
			{ name = 'scratchcardpremium', price = 5000 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
		}, targets = {
			{ loc = vec3(25.06, -1347.32, 29.5), length = 0.7, width = 0.5, heading = 0.0, minZ = 29.5, maxZ = 29.9, distance = 1.5 },
			{ loc = vec3(-3039.18, 585.13, 7.91), length = 0.6, width = 0.5, heading = 15.0, minZ = 7.91, maxZ = 8.31, distance = 1.5 },
			{ loc = vec3(-3242.2, 1000.58, 12.83), length = 0.6, width = 0.6, heading = 175.0, minZ = 12.83, maxZ = 13.23, distance = 1.5 },
			{ loc = vec3(1728.39, 6414.95, 35.04), length = 0.6, width = 0.6, heading = 65.0, minZ = 35.04, maxZ = 35.44, distance = 1.5 },
			{ loc = vec3(1698.37, 4923.43, 42.06), length = 0.5, width = 0.5, heading = 235.0, minZ = 42.06, maxZ = 42.46, distance = 1.5 },
			{ loc = vec3(1960.54, 3740.28, 32.34), length = 0.6, width = 0.5, heading = 120.0, minZ = 32.34, maxZ = 32.74, distance = 1.5 },
			{ loc = vec3(548.5, 2671.25, 42.16), length = 0.6, width = 0.5, heading = 10.0, minZ = 42.16, maxZ = 42.56, distance = 1.5 },
			{ loc = vec3(2678.29, 3279.94, 55.24), length = 0.6, width = 0.5, heading = 330.0, minZ = 55.24, maxZ = 55.64, distance = 1.5 },
			{ loc = vec3(2557.19, 381.4, 108.62), length = 0.6, width = 0.5, heading = 0.0, minZ = 108.62, maxZ = 109.02, distance = 1.5 },
			{ loc = vec3(373.13, 326.29, 103.57), length = 0.6, width = 0.5, heading = 345.0, minZ = 103.57, maxZ = 103.97, distance = 1.5 },
		}
	},

	Gasoline = {
		name = 'Sklep',
		label = "Otwórz Sklep",
		blip = {
			id = 59, colour = 69, scale = 0.8},
		inventory = {
			{ name = 'burger', price = 10 },
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'phone', price = 150 },
			{ name = 'scratchcard', price = 1000 },
			{ name = 'scratchcardgold', price = 2500 },
			{ name = 'scratchcardpremium', price = 5000 },
		}, locations = {
			vec3(-47.45, -1757.85, 29.42),
			vec3(1164.17, -323.21, 69.21),
			vec3(-706.73, -913.98, 19.22),
			vec3(-1820.35, 793.59, 138.12),
			vec3(1698.16, 4923.58, 42.06)
		}, targets = {
			{ loc = vec3(-47.45, -1757.85, 29.42), length = 4.0, width = 0.8, heading = 140.0, minZ = 28.42, maxZ = 29.87, distance = 1.5 },
			{ loc = vec3(1164.17, -323.21, 69.21), length = 4.0, width = 0.8, heading = 190.0, minZ = 68.21, maxZ = 69.66, distance = 1.5 },
			{ loc = vec3(-706.73, -913.98, 19.22), length = 4.0, width = 0.8, heading = 180.0, minZ = 18.22, maxZ = 19.67, distance = 1.5 },
			{ loc = vec3(-1820.35, 793.59, 138.12), length = 4.0, width = 0.8, heading = 222.0, minZ = 137.12, maxZ = 138.57, distance = 1.5 },
			{ loc = vec3(1698.16, 4923.58, 42.06), length = 4.0, width = 0.8, heading = 235.0, minZ = 41.06, maxZ = 42.51, distance = 1.5 }
		}
	},

	jeliwery = {
		name = 'Jubiler',
		blip = {
			id = 674, colour = 30, scale = 0.8
		},
		inventory = {
			{ name = 'zegarek', price = 1200 },
		},
		locations =	{
			vec3(-624.61, -231.17, 38.06)
		},
		targets = {
			{ loc = vec3(-624.61, -231.17, 38.06), length = 0.7, width = 0.5, heading = 0.0, minZ = 29.5, maxZ = 29.9, distance = 1.5 },
		}
	},

	Liquor = {
		name = 'Sklep',
		blip = {
			id = 93, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'burger', price = 15 },
			{ name = 'phone', price = 150 },
			{ name = 'scratchcard', price = 1000 },
			{ name = 'scratchcardgold', price = 2500 },
			{ name = 'scratchcardpremium', price = 5000 },
		}, locations = {
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319)
		}, targets = {
			{ loc = vec3(1134.9, -982.34, 46.41), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(-1222.33, -907.82, 12.43), length = 0.6, width = 0.5, heading = 32.7, minZ = 12.3, maxZ = 12.7, distance = 1.5 },
			{ loc = vec3(-1486.67, -378.46, 40.26), length = 0.6, width = 0.5, heading = 133.77, minZ = 40.1, maxZ = 40.5, distance = 1.5 },
			{ loc = vec3(-2967.0, 390.9, 15.14), length = 0.7, width = 0.5, heading = 85.23, minZ = 15.0, maxZ = 15.4, distance = 1.5 },
			{ loc = vec3(1165.95, 2710.20, 38.26), length = 0.6, width = 0.5, heading = 178.84, minZ = 38.1, maxZ = 38.5, distance = 1.5 },
			{ loc = vec3(1393.0, 3605.95, 35.11), length = 0.6, width = 0.6, heading = 200.0, minZ = 35.0, maxZ = 35.4, distance = 1.5 }
		}
	},

	PoliceArmoury = {
		name = 'Zbrojownia',
		groups = shared.police,
		blip = {
			id = 110, colour = 84, scale = 0
		}, inventory = {
			{ name = 'ammo-pistol', price = 0, },
			{ name = 'ammo-rifle', price = 0, },
			{ name = 'WEAPON_FLASHLIGHT', price = 0 },
			{ name = 'WEAPON_NIGHTSTICK', price = 0 },
			{ name = 'WEAPON_FLASHBANG', price = 0 },
			{ name = 'GPS', price = 0 },
			{ name = 'bodycam', price = 0 },
			{ name = 'lockpick', price = 0 },
			{ name = 'WEAPON_GLOCK', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_MK47FM', price = 0, metadata = { registered = true, serial = 'POL' } },
			{ name = 'WEAPON_STUNGUN', price = 0, metadata = { registered = true, serial = 'POL'} }
		}, locations = {
			vec3(482.48, -995.28, 30.68)
		}, targets = {
			{ loc = vec3(482.48, -995.28, 30.68), length = 2, width = 2, heading = 0, minZ = 27.49, maxZ = 31.49, distance = 6 }
		}
	},

	BurgerShot = {
		name = 'BurgerShot',
		blip = {
			id = 103, colour = 47, scale = 0.9
		}, inventory = {
			{ name = 'waniliashake', price = 20 },
			{ name = 'morelshake', price = 10 },
			{ name = 'bsfries', price = 15 },
			{ name = 'chickenburger', price = 15 },
			{ name = 'cheeseburger', price = 15 },
			{ name = 'bswrap', price = 15 },
			{ name = 'bsnuggets', price = 15 },
		}, locations = {
			vec3(-1194.3062, -891.9728, 13.9952)
		}, targets = {
			{ loc = vec3(-1194.4426, -892.0577, 13.9952), length = 2.1, width = 2.3, heading = 126.6940, minZ = 13.80, maxZ = 14.35, distance = 1.5 },
		}
	},

	Wloska = {
		name = 'Włoska Restauracja',
		blip = {
			id = 93, colour = 35, scale = 0.9
		}, inventory = {
			{ name = 'sernik', price = 200 },
			{ name = 'morelshake', price = 10 },
		}, locations = {
			vec3(-1461.0707, -350.1021, 44.7809)
		}, targets = {
			{ loc = vec3(-1462.83, -349.33, 44.78), length = 1, width = 1, heading = 40, minZ = 44.70, maxZ = 44.99, distance = 1.5 },
		}
	},

	YouTool = {
		name = 'Sklep Techniczny',
		blip = {
			id = 402, colour = 69, scale = 0.9
		}, inventory = {
			{ name = 'lockpick', price = 100 },
			{ name = 'paperbag', price = 100 },
			{ name = 'torba', price = 500 },
		}, locations = {
			vec3(2748.0, 3473.0, 55.67),
			vec3(342.99, -1298.26, 32.51)
		}, targets = {
			{ loc = vec3(55.3032, -1739.5057, 29.5901), length = 1.9, width = 1.8, heading = 233.265, minZ = 29.50, maxZ = 29.99, distance = 3.0 }
		}
	},

	Ammunation = {
		name = 'Ammunation',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'ammo-9', price = 50, license = 'weapon'},
			{ name = 'WEAPON_SWITCHBLADE', price = 600 },
			{ name = 'WEAPON_KNIFE', price = 700 },
			{ name = 'WEAPON_BAT', price = 500 },
			{ name = 'WEAPON_PISTOL', price = 10000, metadata = { registered = true } }
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
			{ loc = vec3(-660.92, -934.10, 21.94), length = 0.6, width = 0.5, heading = 180.0, minZ = 21.8, maxZ = 22.2, distance = 2.0 },
			{ loc = vec3(808.86, -2158.50, 29.73), length = 0.6, width = 0.5, heading = 360.0, minZ = 29.6, maxZ = 30.0, distance = 2.0 },
			{ loc = vec3(1693.57, 3761.60, 34.82), length = 0.6, width = 0.5, heading = 227.39, minZ = 34.7, maxZ = 35.1, distance = 2.0 },
			{ loc = vec3(-330.29, 6085.54, 31.57), length = 0.6, width = 0.5, heading = 225.0, minZ = 31.4, maxZ = 31.8, distance = 2.0 },
			{ loc = vec3(252.85, -51.62, 70.0), length = 0.6, width = 0.5, heading = 70.0, minZ = 69.9, maxZ = 70.3, distance = 2.0 },
			{ loc = vec3(23.68, -1106.46, 29.91), length = 0.6, width = 0.5, heading = 160.0, minZ = 29.8, maxZ = 30.2, distance = 2.0 },
			{ loc = vec3(2566.59, 293.13, 108.85), length = 0.6, width = 0.5, heading = 360.0, minZ = 108.7, maxZ = 109.1, distance = 2.0 },
			{ loc = vec3(-1117.61, 2700.26, 18.67), length = 0.6, width = 0.5, heading = 221.82, minZ = 18.5, maxZ = 18.9, distance = 2.0 },
			{ loc = vec3(841.05, -1034.76, 28.31), length = 0.6, width = 0.5, heading = 360.0, minZ = 28.2, maxZ = 28.6, distance = 2.0 }
		}
	},

	BlackMarketArms = {
		name = 'Black Market (Arms)',
		inventory = {
			{ name = 'WEAPON_DAGGER', price = 5000, metadata = { registered = false	}, currency = 'black_money' },
			{ name = 'WEAPON_CERAMICPISTOL', price = 50000, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'at_suppressor_light', price = 50000, currency = 'black_money' },
			{ name = 'ammo-rifle', price = 1000, currency = 'black_money' },
			{ name = 'hackerdevice', price = 10000, currency = 'black_money' },
			{ name = 'ammo-rifle2', price = 1000, currency = 'black_money' },
			{ name = 'gasmask', price = 1000, currency = 'black_money' },
			{ name = 'cutter', price = 4000, currency = 'black_money' },
			{ name = 'WEAPON_MINISMG', price = 135000, currency = 'black_money' },
			{ name = 'WEAPON_MICROSMG', price = 100000, currency = 'black_money' },
			{ name = 'weapon_bzgas', price = 10000, currency = 'black_money' },
		}, locations = {
			vec3(309.09, -913.75, 56.46)
		}, targets = {

		}
	},

	VendingMachineDrinks = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
		}
	}
}
