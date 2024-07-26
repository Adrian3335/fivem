return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['sim'] = {
		label = 'Karta SIM',
		weight = 50,
		stack = false,
		close = true,
		description = nil,
	},

	['paragon'] = {
		label = 'Paragon',
		weight = 10,
		stack = true,
		close = true,
		description = nil,
	},

	['diamond'] = {
		label = 'Diament',
		weight = 500,
	},

	['gold'] = {
		label = 'Złoto',
		weight = 300,
	},

	['contract'] = {
		label = 'Kontrakt Samochodowy',
		weight = 50,
		stack = false,
		close = true,
		description = nil,
	}, 

	['sus_key'] = {
		label = 'Podejrzany Klucz',
		weight = 50,
		stack = false,
		close = true,
		description = nil,
	}, 

	['suscase'] = {
		label = 'Podejrzana Skrzynia',
		weight = 100,
		stack = false,
		close = true,
		description = nil,
		client = {
			event = 'many-keyrun:OpenNormal'
		}
	}, 

	['suscase_bad'] = {
		label = 'Podejrzana Skrzynia',
		weight = 100,
		stack = false,
		close = true,
		description = nil,
		client = {
			event = 'many-keyrun:OpenBad'
		}
	}, 

	['suscase_good'] = {
		label = 'Podejrzana Skrzynia',
		weight = 100,
		stack = false,
		close = true,
		description = nil,
		client = {
			event = 'many-keyrun:OpenGood'
		}
	}, 

	['syringe'] = {
		label = 'Strzykawka',
		weight = 50,
	}, 

	['teddybear'] = {
		label = 'Miś',
		weight = 50,
	}, 

	['tissues'] = {
		label = 'Chusteczki',
		weight = 10,
	}, 

	['toast'] = {
		label = 'Tost',
		weight = 30,
	}, 

	['trophy'] = {
		label = 'Trofeum',
		weight = 100,
	}, 

	['pierscionek'] = {
		label = 'Pierścionek',
		weight = 50,
	}, 

	['pearls'] = {
		label = 'Perły',
		weight = 50,
	}, 

	['pc'] = {
		label = 'Komputer',
		weight = 1000,
	}, 

	['scratchcard'] = {
		label = 'Zdrapka',
		weight = 1,
	}, 

	['scratchcardgold'] = {
		label = 'Zdrapka Gold',
		weight = 1,
	}, 

	['scratchcardpremium'] = {
		label = 'Zdrapka Premium',
		weight = 1,
	}, 

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['apteczka'] = {
		label = 'Apteczka',
		weight = 50,
	}, 

	['mask'] = {
		label = 'Maska',
		weight = 50,
		stack = false,
		close = true,
		client = {
			usetime = 0,
			event = 'clothes:mask'
		}
	},

	['ears'] = {
		label = 'Akcesoria na uszy',
		weight = 20,
		stack = false,
		close = true,
		client = {
			usetime = 0,
			event = 'clothes:ears'
		}
	},

	['glasses'] = {
		label = 'Okulary',
		weight = 20,
		stack = false,
		close = true,
		client = {
			usetime = 0,
			event = 'clothes:glasses'
		}
	},

	['helmet'] = {
		label = 'Nakrycie głowy',
		weight = 20,
		stack = false,
		close = true,
		client = {
			usetime = 0,
			event = 'clothes:helmet'
		}
	},

	['bag'] = {
		label = 'Torba',
		weight = 50,
		stack = false,
		close = true,
		client = {
			usetime = 0,
			event = 'clothes:bag'
		}
	},

	['torso'] = {
		label = 'Góra',
		weight = 40,
		stack = false,
		close = true,
		client = {
			usetime = 0,
			event = 'clothes:torso'
		}
	},

	['jeans'] = {
		label = 'Spodnie',
		weight = 40,
		stack = false,
		close = true,
		client = {
			usetime = 0,
			event = 'clothes:jeans'
		}
	},

	['shoes'] = {
		label = 'Buty',
		weight = 40,
		stack = false,
		close = true,
		client = {
			usetime = 0,
			event = 'clothes:shoes'
		}
	},

	['gloves'] = {
		label = 'Rękawiczki',
		weight = 20,
		stack = false,
		close = true,
		client = {
			usetime = 0,
			event = 'clothes:gloves'
		}
	},

	['meth'] = {
		label = 'Metamfetamina',
		weight = 20,
		description = 'Brudny pieniądz lub niezła faza',
		usetime = 5000,
		client = {
			event = 'many-meth:useMeth'
		}
	},

	['drift_chip'] = {
		label = 'Chip do driftu',
		weight = 20,
		description = 'Miej go przy sobie, a stanie się magia'
	},

	['card_hack'] = {
		label = 'Karta ATM',
		weight = 20
	},

	['meth_2'] = {
		label = 'Samarka Mety',
		weight = 10
	},

	['spray'] = {
		label = 'Spray',
		weight = 100,
		stack = true,
		close = true
	},
	
	['spray_remover'] = {
		label = 'Ścierka',
		weight = 10,
		description = 'Zmyjesz tym brzydkie malowidła'
	},

	['black_money'] = {
		label = 'Nieoznakowana Gotówka',
		description = 'Z taką gotówką nie pokazuj się przy policji'
	},

	['burger'] = {
		label = 'Burger',
		weight = 20,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
		},
	},

	['crisps'] = {
		label = 'Chipsy',
		weight = 20,
		client = {
			status = { hunger = 150000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 3500,
		},
	},

	['donut'] = {
		label = 'Donut',
		weight = 10,
		client = {
			status = { hunger = 150000 },
			anim = 'eating',
			prop = 'donut',
			usetime = 3500,
		},
	},


	['cola'] = {
		label = 'eCola',
		weight = 30,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
		}
	},

	['parachute'] = {
		label = 'Spadochron',
		weight = 4000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['fixkit'] = {
		label = 'Zestaw Naprawczy',
		weight = 500,
	},

	['drillpurple'] = {
		label = 'Fioletowa Wiertarka',
		weight = 500,
	},

	['drillred'] = {
		label = 'Wiertarka do szkła',
		weight = 500,
	},

	['glass_drill'] = {
		label = 'Wiertło do szkła',
		weight = 500,
	},

	['torba'] = {
		label = 'Torba',
		weight = 50,
		stack = false,
		close = false,
		consume = 0,
		description = 'Pomieści wiele rzeczy'
	},

	['binoculars'] = {
		label = 'Lornetka',
		weight = 50,
		client = {
			event = 'jumelles:Active'
		},
		description = 'Przyjrzyj się bliżej i uważniej'
	},

    ['drill'] = {
	    label = 'Wiertarka',
		weight = 500,
    },

    ['finger_print'] = {
	    label = 'Płytka z odciskiem palca',
		weight = 80,
    },

	['vh3000'] = {
	    label = 'VH 3000',
		weight = 500,
    },

    ['vh_disk'] = {
	    label = 'Dysk',
		weight = 600,
    },

	['pouchbag'] = {
	    label = 'Sakiewka z biżuterią',
		weight = 300,
    },

	['red_diamond'] = {
		label = 'Czerwony Diament',
		weight = 500,
	},

	['panther'] = {
		label = 'Figurka Pantery',
		weight = 600,
	},

	['gold_necklace'] = {
		label = 'Złoty Naszyjnik',
		weight = 300,
	},

	['ancient_bottle'] = {
		label = 'Antyczna Butla',
		weight = 900,
	},

	['paintingg'] = {
		label = 'Obraz Sztuka',
		weight = 1000,
	},

	['paintingf'] = {
		label = 'Obraz Fabryka',
		weight = 1000,
	},

	['paintingh'] = {
		label = 'Obraz Biznes',
		weight = 1000,
	},

	['paintingj'] = {
		label = 'Obraz Trzy Kobiety',
		weight = 1000,
	},	

	['whitediamond'] = {
		label = 'Biały Diament',
		weight = 400,
	},

	['reddiamond'] = {
		label = 'Czerwony Diament',
		weight = 400,
	},

	['bluediamond'] = {
		label = 'Niebieski Diament',
		weight = 400,
	},

	['yellowdiamond'] = {
		label = 'Żółty Diament',
		weight = 400,
	},

	['diamondneck'] = {
		label = 'Diamentowy Łańcuszek',
		weight = 200,
	},

	['device'] = {
		label = 'Urządzenie',
		weight = 400,
	},

    ['pac_code'] = {
	    label = 'Szyfr do sejfu',
	    weight = 10,
    },

    ['weird_phone'] = {
	    label = 'Dziwny Telefon',
	    weight = 50,
    },

    ['pacificos'] = {
	    label = 'Pendrive PacificOS',
	    weight = 50,
    },

    ['id_card'] = {
	    label = 'Karta Dostępu',
	    weight = 50,
    },

	['electric_card'] = {
	    label = 'Karta Pracownika Elektrownii',
	    weight = 50,
    },

	['thermite_bomb'] = {
	    label = 'Termit',
	    weight = 80,
    },

	['c4_bomb'] = {
	    label = 'Bomba C4',
	    weight = 200,
    },

	['laptop_h'] = {
	    label = 'Laptop',
	    weight = 150,
    },

	['laptop'] = {
	    label = 'Laptop',
	    weight = 150,
    },

	['keya'] = {
	    label = 'Klucz A',
	    weight = 30,
    },

	['keyb'] = {
	    label = 'Klucz B',
	    weight = 30,
    },

	['keyc'] = {
	    label = 'Klucz C',
	    weight = 30,
    },

	['green_pendrive'] = {
	    label = 'Zielony Pendrive',
	    weight = 50,
    },

	['black_pendrive'] = {
	    label = 'Czarny Pendrive',
	    weight = 50,
    },

	['blue_pendrive'] = {
	    label = 'Niebieski Pendrive',
	    weight = 50,
    },

	['paintinga'] = {
	    label = 'Obraz Kosmita',
	    weight = 1000,
    },

	['paintingb'] = {
	    label = 'Obraz Człowiek',
	    weight = 1000,
    },

	['garbage'] = {
		label = 'Śmieć',
		weight = 5,
	},

	['paperbag'] = {
		label = 'Papierowa Torba',
		weight = 5,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
		weight = 20
	},

	['panties'] = {
		label = 'Majtki',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['masturbator'] = {
		label = 'Masturbator',
		weight = 20,
		allowArmed = false,
		client = {
			status = { stress = -100000 },
			anim = { dict = 'timetable@trevor@skull_loving_bear', clip = 'skull_loving_bear' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 12500,
			disable = { move = true, combat = true},
		}
	},

	['lockpick'] = {
		label = 'Wytrych',
		weight = 150,
		client = {
			event = 'many-lockpick:Start'
		},
	},

	['rope'] = {
		label = 'Lina',
		weight = 150,
		client = {
			event = 'many-interactions:AdvancedCuff'
		}
    },

	['handcuffs'] = {
		label = 'Kajdanki',
		weight = 150,
		client = {
			event = 'kaho:MenuKajdanek'
		}
    },

	['headbag'] = {
		label = 'Worek',
		weight = 100,
    },

	['gps'] = {
		label = 'Policyjny GPS',
		weight = 100,
		client = {
			remove = function()
				TriggerEvent('many-gps:LostGPS')
			end,
			event = 'many-gps:toggleDuty'
		},
    },

	['uvlight'] = {
		label = 'Latarka UV',
		weight = 50,
    },

	['bodycam'] = {
		label = 'Bodycam',
		weight = 50,
    },

	['policekevlar'] = {
		label = 'Policyjna Kamizelka',
		weight = 1000,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 4500
		}
    },
	
	['policeheavykevlar'] = {
		label = 'Ciężka Policyjna Kamizelka',
		weight = 2000,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 6500
		}
    },

	['carkey'] = {
		label = 'Kluczyki do auta',
		weight = 15,
		stack = false,
		consume = 0,
	},

	['phone'] = {
		label = 'Telefon',
		weight = 50,
		stack = false,
		consume = 0,
		client = {
			event = 'gks:use'
		}
	},

	['money'] = {
		label = 'Gotówka',
		description = 'Spora ilość gotówki nigdy nie zaszkodzi'
	},

	['lighter'] = {
		label = 'Zapalniczka',
		weight = 15,
		description = 'Przydatne do zapalenia niektórych rzeczy'
	},

	['redw'] = {
		label = 'Red Wood',
		weight = 15,
		description = 'Paczka czerwonych lolków'
	},

	['marlboro'] = {
		label = 'Malboro',
		weight = 15,
		description = 'Paczka malboro'
	},

	['redwcig'] = {
		label = 'Papieros',
		weight = 15,
		description = 'Papieros z red woodów'
	},

	['marlborocig'] = {
		label = 'Papieros',
		weight = 15,
		description = 'Papieros z malboro'
	},

	['mustard'] = {
		label = 'Musztarda',
		weight = 20,
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
		}
	},

	['water'] = {
		label = 'Woda',
		weight = 20,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
		}
	},

	['beer'] = {
		label = 'Piwo',
		weight = 20,
		client = {
			status = { drunk = 75000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 3000,
			cancel = true,
		}
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true,
		client = {
			event = 'ls-radio:use'
		}
    },

	['armour'] = {
		label = 'Kamizelka',
		weight = 1000,
		stack = false,
		description = 'Nigdy nie wiadomo kiedy się przyda',
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
		}
	},

	['cotton'] = {
		label = 'Bawełna',
		weight = 15,
	},

	['cloth_pack'] = {
		label = 'Paczka Ubrań',
		weight = 10,
	},

	['case_beta'] = {
		label = 'Skrzynia Beta',
		weight = 50,
	},

	['case_alpha'] = {
		label = 'Skrzynia Alpha',
		weight = 50,
	},

	['case_quadra'] = {
		label = 'Skrzynia Quadra',
		weight = 50,
	},

	['case_xmas'] = {
		label = 'Skrzynia Xmas',
		weight = 50,
	},

	['rubber'] = {
		label = 'Guma',
		weight = 50,
	},

	['metal'] = {
		label = 'Metal',
		weight = 100,
	},

	['recycleparts'] = {
		label = 'Części recyklingowe',
		weight = 30,
	},

	['plastic'] = {
		label = 'Plastik',
		weight = 40,
	},

	['paper'] = {
		label = 'Papier',
		weight = 10,
	},

	['dust'] = {
		label = 'Proch',
		weight = 10,
	},

	['metalparts'] = {
		label = 'Części metalowe',
		weight = 80,
	},

	['empty_nitro'] = {
		label = 'Pusta Butla',
		weight = 10,
	},

	['nitro_gas'] = {
		label = 'Gaz N2O',
		weight = 500,
	},

	['screwdriver'] = {
		label = 'Śrubokręt',
		weight = 50,
	},

	['wodka'] = {
		label = 'Wódka',
		weight = 50,
		usetime = 4500,
		client = {
			status = { drunk = 100000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_vodka_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
		}
	},

	['whiskey'] = {
		label = 'Whiskey',
		weight = 50,
		usetime = 3500,
		client = {
			status = { drunk = 90000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_vodka_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
		}
	},

	['piwo'] = {
		label = 'Piwo',
		weight = 30,
		usetime = 3500,
		client = {
			status = { drunk = 70000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_vodka_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
		}
	},

	['microwave'] = {
		label = 'Mikrofala',
		weight = 500,
	},

	['mixer'] = {
		label = 'Mikser',
		weight = 200,
	},

	['console'] = {
		label = 'Konsola',
		weight = 500,
	},

	['chain'] = {
		label = 'Łańcuszek',
		weight = 50,
	},

	['lamp'] = {
		label = 'Lampa',
		weight = 700,
	},

	['speaker'] = {
		label = 'Głośnik',
		weight = 500,
	},

	['tv'] = {
		label = 'Telewizor',
		weight = 1200,
		client = {
			add = function()
				local playerPed = PlayerPedId()
				local bone = GetPedBoneIndex(playerPed, 0xE5F3)
				local coords = GetEntityCoords(playerPed)
				DisableControlAction(0, 21, true)
				PC = CreateObject('prop_tv_02', coords.x, coords.y, coords.z, false, false, false)
				AttachEntityToEntity(PC, playerPed, bone, 0.0, 0.24, 0.10, 340.0, 330.0, 330.0, true, true, false, true, 1, true)
				exports['many-base']:playAnim(playerPed, 'anim@heists@box_carry@', 'idle', -1, true)
			end,
			remove = function()
				DetachEntity(PC, false, false)
				DeleteEntity(PC)
				ClearPedTasks(PlayerPedId())
				EnableControlAction(0, 21, true)
			end,
		}
	},

	['statue'] = {
		label = 'Figurka',
		weight = 50,
		client = {
			add = function()
				local playerPed = PlayerPedId()
				local bone = GetPedBoneIndex(playerPed, 0xE5F3)
				local coords = GetEntityCoords(playerPed)
				DisableControlAction(0, 21, true)
				figurka = CreateObject('hei_prop_drug_statue_01', coords.x, coords.y, coords.z, false, false, false)
				AttachEntityToEntity(figurka, playerPed, bone, 0.22, 0.40, 0.0, 340.0, 330.0, 330.0, true, true, false, true, 1, true)
				exports['many-base']:playAnim(playerPed, 'anim@heists@box_carry@', 'idle', -1, true)
			end,
			remove = function()
				DetachEntity(figurka, false, false)
				DeleteEntity(figurka)
				ClearPedTasks(PlayerPedId())
				EnableControlAction(0, 21, true)
			end,
		}
	},

	['tree_lumber'] = {
		label = 'Tarcica Drewna',
		weight = 10,
	},

	['tree_bark'] = {
		label = 'Kora Drzewna',
		weight = 10,
	},

	['wood_plank'] = {
		label = 'Drewniana Deska',
		weight = 30,
	},

	--[[

    # ROBOTA JABŁKARZA ;3

	]]

	['apples'] = {
		label = 'Skrzynka Jabłek',
		weight = 50,
		client = {
			add = function()
				local playerPed = PlayerPedId()
				local bone = GetPedBoneIndex(playerPed, 0xE5F3)
				local coords = GetEntityCoords(playerPed)
				DisableControlAction(0, 21, true)
				jabluszka = CreateObject('prop_apple_box_01', coords.x, coords.y, coords.z, false, false, false)
				--AttachEntityToEntity
				AttachEntityToEntity(jabluszka, playerPed, bone, 0.1, 0.24, 0.10, 340.0, 330.0, 330.0, true, true, false, true, 1, true)
				exports['many-base']:playAnim(playerPed, 'anim@heists@box_carry@', 'idle', -1, true)
			end,
			remove = function()
				DetachEntity(jabluszka, false, false)
				DeleteEntity(jabluszka)
				ClearPedTasks(PlayerPedId())
				EnableControlAction(0, 21, true)
			end,
		}
	},

	['uwu_waffles'] = {
		label = 'Gofry',
		weight = 20,
	},

	['uwu_cake'] = {
		label = 'Ciastko',
		weight = 20,
	},

	['uwu_chocolate'] = {
		label = 'Czekolada',
		weight = 20,
	},

	['uwu_bubbletea'] = {
		label = 'Bubble Tea',
		weight = 20,
	},

	['uwu_toy'] = {
		label = 'Zabawka',
		weight = 30,
		consume = 1,
		stack = false,
		client = {
			event = 'many-uwucafe:OpenToy'
		}
	},

	['scrap'] = {
		label = 'Złom',
		weight = 80,
		client = {
			add = function()
				local playerPed = PlayerPedId()
				local bone = GetPedBoneIndex(playerPed, 0xE5F3)
				local coords = GetEntityCoords(playerPed)
				local prop = 'imp_prop_impexp_engine_part_01a'
				local random = math.random(1, 3)
				if random == 1 then
					prop = 'imp_prop_impexp_engine_part_01a'
				elseif random == 2 then
					prop = 'imp_prop_impexp_exhaust_01'
				elseif random == 3 then
					prop = 'imp_prop_impexp_tyre_03a'
				end
				DisableControlAction(0, 21, true)
				zlom = CreateObject(prop, coords.x, coords.y, coords.z, false, false, false)
				AttachEntityToEntity(zlom, playerPed, bone, 0.1, 0.24, 0.10, 340.0, 330.0, 330.0, true, true, false, true, 1, true)
				exports['many-base']:playAnim(playerPed, 'anim@heists@box_carry@', 'idle', -1, true)
			end,
			remove = function()
				DetachEntity(zlom, false, false)
				DeleteEntity(zlom)
				ClearPedTasks(PlayerPedId())
				EnableControlAction(0, 21, true)
			end,
		}
	},

	['mieso'] = {
		label = 'Mięso',
		weight = 50,
		client = {
			add = function()
				local playerPed = PlayerPedId()
				local bone = GetPedBoneIndex(playerPed, 0xE5F3)
				local coords = GetEntityCoords(playerPed)
				DisableControlAction(0, 21, true)
				stek = CreateObject('steki', coords.x, coords.y, coords.z, false, false, false)
				--AttachEntityToEntity(entity1, entity2, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, vertexIndex, fixedRot)
				AttachEntityToEntity(stek, playerPed, bone, 0.21, 0.21, 0, 410.0, 380.0, 250.0, true, true, false, true, 1, true)
				exports['many-base']:playAnim(playerPed, 'anim@heists@box_carry@', 'idle', -1, true)
			end,
			remove = function()
				DetachEntity(stek, false, false)
				DeleteEntity(stek)
				ClearPedTasks(PlayerPedId())
				EnableControlAction(0, 21, true)
			end,
		}
	},

	['mieso_mielone'] = {
		label = 'Mięso Mielone',
		weight = 50,
	},

	['cowhead'] = {
		label = 'Głowa Krowy',
		weight = 70,
		client = {
			add = function()
				local playerPed = PlayerPedId()
				local bone = GetPedBoneIndex(playerPed, 0xE5F3)
				local coords = GetEntityCoords(playerPed)
				DisableControlAction(0, 21, true)
				head = CreateObject(1245918393, coords.x, coords.y, coords.z, false, false, false)
				--AttachEntityToEntity(entity1, entity2, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, vertexIndex, fixedRot)
				AttachEntityToEntity(head, playerPed, bone, 0.0, 0.24, 0, 340.0, 230.0, 230.0, true, true, false, true, 1, true)
				exports['many-base']:playAnim(playerPed, 'anim@heists@box_carry@', 'idle', -1, true)
			end,
			remove = function()
				DetachEntity(head, false, false)
				DeleteEntity(head)
				ClearPedTasks(PlayerPedId())
				EnableControlAction(0, 21, true)
			end,
		}
	},

	['beefcheeks'] = {
		label = 'Policzki Wołowe',
		weight = 30,
	},

	['beeftongues'] = {
		label = 'Języki Wołowe',
		weight = 30,
	},

	['packedmeat'] = {
		label = 'Paczka Mięsa',
		weight = 40,
	},

	['fish1'] = {
		label = 'Ryba',
		weight = 50,
	},

	['fish2'] = {
		label = 'Ryba',
		weight = 50,
	},

	['fish3'] = {
		label = 'Ryba',
		weight = 50,
	},

	['fish4'] = {
		label = 'Ryba',
		weight = 50,
	},

	['fish5'] = {
		label = 'Ryba',
		weight = 50,
	},

	['fishing_rod'] = {
		label = 'Wędka',
		weight = 400,
		client = {
			event = 'many_fishingjob:ThrowRod'
		}
	},

	['ammobox-9'] = {
		label = 'Paczka Amunicji',
		weight = 20,
		stack = false,
		consume = 1,
	},

	['pistol_craft_1'] = {
		label = 'Część pistoletu',
		weight = 50,
		description = 'Typ: Pistolet Bojowy'
	},

	['pistol_craft_2'] = {
		label = 'Część pistoletu',
		weight = 50,
		description = 'Typ: Pistolet Bojowy'
	},

	['pistol_craft_3'] = {
		label = 'Szkielet Pistoletu',
		weight = 50,
		description = 'Typ: Pistolet Bojowy'
	},

	['ak_box'] = {
		label = 'Tajemnicza Skrzynia',
		weight = 30,
	},

	['ak_craft_1'] = {
		label = 'Część karabinu',
		weight = 50,
		description = 'Typ: Karabin Szturmowy'
	},

	['ak_craft_2'] = {
		label = 'Część karabinu',
		weight = 50,
		description = 'Typ: Karabin Szturmowy'
	},

	['ak_craft_3'] = {
		label = 'Szkielet Karabinu',
		weight = 50,
		description = 'Typ: Karabin Szturmowy'
	},

	['carbine_craft_1'] = {
		label = 'Część karabinu',
		weight = 50,
		description = 'Typ: Karabin Szturmowy MK2'
	},

	['carbine_craft_2'] = {
		label = 'Część karabinu',
		weight = 50,
		description = 'Typ: Karabin Szturmowy MK2'
	},

	['carbine_craft_3'] = {
		label = 'Szkielet Karabinu',
		weight = 50,
		description = 'Typ: Karabin Szturmowy MK2'
	},

	['ammo_prototype'] = {
		label = 'Prototyp Amunicji',
		weight = 10,
	},

	['weap_device'] = {
		label = 'Urządzenie',
		weight = 50,
	},

	['weap_info'] = {
		label = 'Informacje o przemycie',
		weight = 10,
	},

	['weap_pack'] = {
		label = 'Tajemnicza Paczka',
		weight = 30,
		client = {
			add = function()
				local playerPed = PlayerPedId()
				local bone = GetPedBoneIndex(playerPed, 0xE5F3)
				local coords = GetEntityCoords(playerPed)
				DisableControlAction(0, 21, true)
				Pack = CreateObject('prop_cs_cardbox_01', coords.x, coords.y, coords.z, false, false, false)
				AttachEntityToEntity(Pack, playerPed, bone, 0.0, 0.24, 0.10, 340.0, 330.0, 330.0, true, true, false, true, 1, true)
				exports['many-base']:playAnim(playerPed, 'anim@heists@box_carry@', 'idle', -1, true)
			end,
			remove = function()
				DetachEntity(Pack, false, false)
				DeleteEntity(Pack)
				ClearPedTasks(PlayerPedId())
				EnableControlAction(0, 21, true)
			end,
		}
	},

	['arcade_coin'] = {
		label = 'Złoty Żeton Arcade',
		weight = 20,
	},

	['arcade_chips'] = {
		label = 'Żeton Arcade',
		weight = 20,
	},

	['animal_drink'] = {
		label = 'Animal Drink',
		weight = 20,
		consume = 1,
		stack = false,
		client = {
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `p_cs_script_bottle_s`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 3500,
			cancel = true,
		}
	},

	['shield_potion'] = {
		label = 'Potka',
		weight = 20,
		consume = 1,
		stack = false,
		client = {
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `p_cs_script_bottle_s`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 3500,
			cancel = true,
		}
	},

	['heist_drink'] = {
		label = 'Heist Drink',
		weight = 20,
		consume = 1,
		stack = false,
		client = {
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `p_cs_script_bottle_s`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 4500,
			cancel = true,
		}
	},

	['lemon_plant'] = {
		label = 'Nasiono Lemon Haze',
		weight = 20,
	},

	['lemon_pack'] = {
		label = 'Paczka z Lemon Haze',
		weight = 20,
	},

	['lemon'] = {
		label = 'Gram Lemon Haze',
		weight = 20,
	},

	['amnesia_plant'] = {
		label = 'Nasiono Amnesia Haze',
		weight = 20,
	},

	['amnesia_pack'] = {
		label = 'Paczka z Amnesia Haze',
		weight = 20,
	},

	['amnesia'] = {
		label = 'Gram Amnesia Haze',
		weight = 20,
	},

	['humane_box'] = {
		label = 'Metalowa Skrzynka',
		weight = 30,
	},

	['humane_safed_box'] = {
		label = 'Zabezpieczona Metalowa Skrzynka',
		weight = 30,
	},

	['humane_fiolka'] = {
		label = 'Fiolka z wirusem',
		weight = 100,
	},

	['black_pass'] = {
		label = 'Black Market Pass',
		weight = 50,
	},

	['wetsuit'] = {
		label = 'Strój do nurkowania',
		weight = 500,
	},

	['big_drill'] = {
		label = 'Wielkie Wiertło',
		weight = 1500,
	},

	['thermite'] = {
		label = 'Termit',
		weight = 500
	},

	['bolt_cutter'] = {
		label = 'Nożyce',
		weight = 500
	},

	['cutter'] = {
		label = 'Nóż',
		weight = 100
	},

	['hack_usb'] = {
		label = 'usb',
		weight = 100
	},

	['hackerDevice'] = {
		label = 'hackerDevice',
		weight = 100
	},

	['tabletorg'] = {
		label = 'Tablet Organizacji',
		weight = 100
	},


	["alive_chicken"] = {
		label = "Living chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["bread"] = {
		label = "Bread",
		weight = 1,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	["carokit"] = {
		label = "Body Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["clothe"] = {
		label = "Cloth",
		weight = 1,
		stack = true,
		close = true,
	},

	["copper"] = {
		label = "Copper",
		weight = 1,
		stack = true,
		close = true,
	},

	["cutted_wood"] = {
		label = "Cut wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["essence"] = {
		label = "Gas",
		weight = 1,
		stack = true,
		close = true,
	},

	["fabric"] = {
		label = "Fabric",
		weight = 1,
		stack = true,
		close = true,
	},

	["fish"] = {
		label = "Fish",
		weight = 1,
		stack = true,
		close = true,
	},

	["fixtool"] = {
		label = "Repair Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["gazbottle"] = {
		label = "Gas Bottle",
		weight = 2,
		stack = true,
		close = true,
	},

	["iron"] = {
		label = "Iron",
		weight = 1,
		stack = true,
		close = true,
	},

	["marijuana"] = {
		label = "Marijuana",
		weight = 2,
		stack = true,
		close = true,
	},

	["medikit"] = {
		label = "Medikit",
		weight = 2,
		stack = true,
		close = true,
	},

	["packaged_chicken"] = {
		label = "Chicken fillet",
		weight = 1,
		stack = true,
		close = true,
	},

	["packaged_plank"] = {
		label = "Packaged wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol"] = {
		label = "Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol_raffin"] = {
		label = "Processed oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["slaughtered_chicken"] = {
		label = "Slaughtered chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["stone"] = {
		label = "Stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["washed_stone"] = {
		label = "Washed stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["wood"] = {
		label = "Wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["wool"] = {
		label = "Wool",
		weight = 1,
		stack = true,
		close = true,
	},

	["blowpipe"] = {
		label = "Blowtorch",
		weight = 2,
		stack = true,
		close = true,
	},
}