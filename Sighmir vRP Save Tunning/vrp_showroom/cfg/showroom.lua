local vehshop = {
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.1,
		y = 0.08,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "Los Santos Showroom",
			name = "main",
			buttons = {
				{name = "masini", description = ""},
				{name = "suv-offroad", description = ""},
				{name = "gang-cars", description = ""},
				{name = "motociclete", description = ""},
				{name = "job", description = ""},
				{name = "vip", description = ""},
				{name = "biciclete", description = ''},
				{name = "aviatie", description = ''},
			}
		},
		["masini"] = {
			title = "masini",
			name = "masini",
			buttons = {
				{name = "audi", description = ''},
				{name = "bmw", description = ''},
				{name = "mercedesbenz", description = ''},
				{name = "ferrari", description = ''},
				{name = "fast-and-furios", description = ''},
				{name = "dacia", description = ''},
				{name = "jdm", description = ''},
				{name = "cars5", description = ''},
				{name = "altele", description = ''},
				--{name = "cycles", description = ''},
			}
		},
		["audi"] = {
			title = "audi",
			name = "audi",
			buttons = {
				{name = "Audi RS3", costs = 650000, description = {}, model = "rs3"},
			    {name = "Audi SQ7 2016", costs = 1000000, description = {}, model = "SQ72016"},			
			    {name = "Audi RS7", costs = 600000, description = {}, model = "rs7"},
			    {name = "Audi A8", costs = 600000, description = {}, model = "a8fsi"},
			    {name = "Audi R8", costs = 900000, description = {}, model = "r8ppi"},
			}
		},
		["bmw"] = {
			title = "bmw",
			name = "bmw",
			buttons = {
			    {name = "BMW M2", costs = 600000, description = {}, model = "m2"},
			    {name = "BMW M3", costs = 500000, description = {}, model = "m3f80"},
			    {name = "BMW M3 E92", costs = 555000, description = {}, model = "m3e92"},
                {name = "BMW E30", costs = 500000, description = {}, model = "m3e30"},			
			    {name = "BMW M4", costs = 600000, description = {}, model = "m4f82"},
			    {name = "BMW M5 F90", costs = 800000, description = {}, model = "bmci"},
				{name = "BMW M6", costs = 800000, description = {}, model = "m6f13"},
                {name = "BMW 7", costs = 1000000, description = {}, model = "lumma750"},			
			    {name = "BMW I8", costs = 1100000, description = {}, model = "i8"},
				{name = "BMW X5", costs = 400000, description = {}, model = "x5m13"},
				{name = "BMW X6", costs = 1500000, description = {}, model = "x6m"},
			}
		},
		["mercedesbenz"] = {
			title = "mercedesbenz",
			name = "mercedesbenz",
			buttons = {
			    {name = "Mercedes Benz ML Brabus", costs = 250000, description = {}, model = "mlbrabus"},			
			    {name = "Mercedes Benz AMG c63", costs = 800000, description = {}, model = "c63s"},
			    {name = "Mercedes Vision GT", costs = 5000000, description = {}, model = "mvisiongt"},
			    {name = "Mercedes A45AMG", costs = 600000, description = {}, model = "a45amg"},
			    {name = "Mercedes GLE450", costs = 700000, description = {}, model = "mbgle"},
				{name = "Mercedes GT", costs = 550000, description = {}, model = "amggt"},
				{name = "Mercedes GL63", costs = 450000, description = {}, model = "gl63"},
				{name = "Mercedes G65", costs = 655000, description = {}, model = "g65amg"},
			}
		},
		["ferrari"] = {
			title = "ferrari",
			name = "ferrari",
			buttons = {
			    {name = "Ferrari LaFerrari", costs = 2500000, description = {}, model = "aperta"},
				{name = "Ferrari 458", costs = 2000000, description = {}, model = "italia458"},
			}
		},
		["fast-and-furios"] = {
			title = "fast-and-furios",
			name = "fast-and-furios",
			buttons = {
				{name = "Gtr34", costs = 10000000, description = {}, model = "2f2fgtr34"},
				{name = "Gts", costs = 10000000, description = {}, model = "2f2fgts"},
				{name = "Mk4", costs = 10000000, description = {}, model = "2f2fmk4"},
				{name = "Mle7", costs = 10000000, description = {}, model = "2f2fmle7"},
				{name = "Wrx", costs = 10000000, description = {}, model = "ff4wrx"},
				{name = "R34", costs = 10000000, description = {}, model = "fnf4r34"},
				{name = "Lan", costs = 10000000, description = {}, model = "fnflan"},
				{name = "Mits", costs = 10000000, description = {}, model = "fnfmits"},
				{name = "Fmk4", costs = 10000000, description = {}, model = "fnfmk4"},
				{name = "Rx7", costs = 10000000, description = {}, model = "fnfrx7"},
				{name = "GtX", costs = 10000000, description = {}, model = "gtx"},
			}
		},
		["dacia"] = {
			title = "dacia",
			name = "dacia",
			buttons = {
			    {name = "Dacia 1310", costs = 10000, description = {}, model = "1310s"},
				{name = "Dacia Logan", costs = 5000, description = {}, model = "logan"},
				{name = "Dacia Duster 2014", costs = 14000, description = {}, model = "daduster"},
				{name = "Dacia Sandero 2014", costs = 8000, description = {}, model = "sandero"},
				{name = "Dacia Sandero Stepway 2014", costs = 10000, description = {}, model = "sanderos2"},
			}
		},
		["jdm"] = {
			title = "jdm",
			name = "jdm",
			buttons = {
			    {name = "Porsche 911R", costs = 1000000, description = {}, model = "p911r"},
			    {name = "Porsche Cayman GT4 2016", costs = 1100000, description = {}, model = "cayman16"},
			    {name = "1958 Porsche 718", costs = 400000, description = {}, model = "718"},			
			    {name = "Porsche Panamera", costs = 900000, description = {}, model = "pturismo"},
			    {name = "Porsche CayenneS", costs = 600000, description = {}, model = "cayenne"},
			    {name = "Porsche Carrera GT", costs = 1900000, description = {}, model = "cgt"},			
			    {name = "Porsche Panamera Turismo", costs = 2000000, description = {}, model = "pturismo"},	
			    {name = "Porsche Turbo S Cabriolet", costs = 2400000, description = {}, model = "911tbs"},			
		        {name = "Porsche 911 GT3RS", costs = 2800000, description = {}, model = "911gtrs"},
				{name = "Volkswagen Golf V GTI", costs = 500000, description = {}, model = "golfgti"},	
			    {name = "Volkswagen Golf MK1", costs = 50000, description = {}, model = "golf1"},
			    {name = "Volkswagen Golf MK7", costs = 500000, description = {}, model = "golf7"},
			    {name = "Volkswagen Passat", costs = 350000, description = {}, model = "passat"},
			}
		},
		["cars5"] = {
			title = "cars5",
			name = "cars5",
			buttons = {
			    {name = "T20", costs = 3000000, description = {}, model = "t20"},
			    {name = "Bullet", costs = 350000, description = {}, model = "bullet"},
				{name = "Drift Tampa", costs = 850000, description = {}, model = "tampa2"},
				{name = "Ruston", costs = 750000, description = {}, model = "ruston"},
			    {name = "Entity XF", costs = 500000, description = {}, model = "entityxf"},
			    {name = "GP1", costs = 150000, description = {}, model = "gp1"},
			    {name = "FMJ", costs = 700000, description = {}, model = "fmj"},
				{name = "Coquette Classic", costs = 300000, description = {}, model = "coquette2"},
				{name = "Z-Type", costs = 300000, description = {}, model = "ztype"},
			    {name = "Itali GTB Custom", costs = 800000, description = {}, model = "italigtb2"},
			    {name = "Nero Custom", costs = 1000000, description = {}, model = "nero2"},
				{name = "Nero", costs = 800000, description = {}, model = "nero"},
			    {name = "RE-7B", costs = 850000, description = {}, model = "le7b"},
			    {name = "Tempesta", costs = 950000, description = {}, model = "tempesta"},
			    {name = "Turismo R", costs = 350000, description = {}, model = "turismor"},
			    {name = "Tyrus", costs = 730000, description = {}, model = "tyrus"},
			    {name = "Specter Custom", costs = 450000, description = {}, model = "specter2"},
			    {name = "ETR1", costs = 700000, description = {}, model = "sheava"},
			    {name = "811", costs = 500000, description = {}, model = "pfister811"},
				{name = "Elegy", costs = 150000, description = {}, model = "elegy"},
				{name = "GP1", costs = 150000, description = {}, model = "gp1"},
				{name = "Cheetah", costs = 1300000, description = {}, model = "cheetah"},
				{name = "Tampa", costs = 72000, description = {}, model = "tampa"},
				{name = "Verkierer", costs = 110000, description = {}, model = "verlierer2"},
				{name = "Infernus", costs = 250000, description = {}, model = "infernus"},
				{name = "Lynx", costs = 170000, description = {}, model = "lynx"},
				{name = "Vacca", costs = 340000, description = {}, model = "vacca"},
				{name = "Zentorno", costs = 1500000, description = {}, model = "zentorno"},
				{name = "X80 Proto", costs = 4500000, description = {}, model = "prototipo"},
				{name = "Reaper", costs = 500000, description = {}, model = "reaper"},
				{name = "XA21", costs = 1300000, description = {}, model = "xa21"},
			}
		},
		["altele"] = {
			title = "altele",
			name = "altele",
			buttons = {
			    {name = "Mustang", costs = 0, description = {}, model = "rmodmustang"},
				{name = "Bentley Bentayga", costs = 500000, description = {}, model = "urus"},
				{name = "Jaguar F-Pace S", costs = 400000, description = {}, model = "fpace"},	
                {name = "Honda Civic", costs = 250000, description = {}, model = "hondacivictr"},					
			    {name = "Toyota GT86", costs = 300000, description = {}, model = "gt86"},
			    {name = "Seat Leon", costs = 100000, description = {}, model = "seatleon"},
			    {name = "Ford Mustang GT", costs = 1200000, description = {}, model = "mgt"},
			    {name = "AstonExtreme", costs = 1000000, description = {}, model = "db11"},			
			    {name = "Lamborghini Huracan", costs = 8000000, description = {}, model = "huralbnormal"},
			    {name = "Viper", costs = 1200000, description = {}, model = "viper"},			
			    {name = "Chevrolet Camaro", costs = 1500000, description = {}, model = "cczl"},
			    {name = "Honda S2000", costs = 2000000, description = {}, model = "ap2"},
			    {name = "Mazda 6", costs = 35000, description = {}, model = "na6"},
			    {name = "Dacia Sandero", costs = 25000, description = {}, model = "sandero"},				
		        {name = "Dacia Logan", costs = 18000, description = {}, model = "logan"},
			    {name = "Dacia Duster", costs = 30000, description = {}, model = "daduster"},
			    {name = "Dacia 1310 Sport", costs = 100000, description = {}, model = "1310s"},			
			    {name = "Mitsubishi EVO10", costs = 300000, description = {}, model = "evo10"},			
			    {name = "Nissan 370Z", costs = 1000000, description = {}, model = "370z"},
			    {name = "Nissan Titan", costs = 600000, description = {}, model = "nissantitan17"},			
			    {name = "Alfa Romeo Giulia", costs = 1500000, description = {}, model = "giulia"},
			    {name = "Nissan Skyline", costs = 800000, description = {}, model = "skyline"},
			    {name = "Jeep SRT", costs = 300000, description = {}, model = "srt8"},	
                {name = "Lamborghini Urus", costs = 1200000, description = {}, model = "urus2018"},					
			    {name = "2006 Mitsubishi Lancer Evolution IX P1", costs = 400000, description = {}, model = "fnflan"},	
			    {name = "1999 Nissan Skyline GT-R 34", costs = 400000, description = {}, model = "2f2fgtr34"},
				{name = "Bentley Continental", costs = 955000, description = {}, model = "contgt13"},
				{name = "Pontiac", costs = 1000000, description = {}, model = "firebird"},
			    {name = "Nissan GTR", costs = 800000, description = {}, model = "gtr"},
			    {name = "Maserati", costs = 700000, description = {}, model = "mlnovitec"},
			    {name = "McLaren P1", costs = 2250000, description = {}, model = "p1"},
			    {name = "Toyota Supra", costs = 1100000, description = {}, model = "supra2"},
			    {name = "Chevrolet Corvette", costs = 2800000, description = {}, model = "c7"},
			    {name = "Aston Martin", costs = 1100000, description = {}, model = "ast"},
			}
		},
		["motociclete"] = {
			title = "motociclete",
			name = "motociclete",
			buttons = {
				{name = "Innovation", costs = 300000, description = {}, model = "innovation"},
				{name = "Hexer", costs = 300000, description = {}, model = "hexer"},
			    {name = "Sanchez", costs = 150000, description = {}, model = "sanchez"},
				{name = "Gargoyle", costs = 720000, description = {}, model = "gargoyle"},
				{name = "Kawasaki", costs = 500000, description = {}, model = "zx10r"},
				{name = "Bmw Lecto", costs = 700000, description = {}, model = "lectro"},
				{name = "Yamaha R1", costs = 150000, description = {}, model = "r1"},
				{name = "Agusta F4 RR", costs = 900000, description = {}, model = "f4rr"},
				{name = "Thrust", costs = 110000, description = {}, model = "thrust"},
				{name = "Sanchez 2", costs = 150000, description = {}, model = "Sanchez2"},
				{name = "Raptor", costs = 350000, description = {}, model = "raptor"},
				{name = "Street Blazer", costs = 2000000, description = {}, model = "blazer4"},
				{name = "Sovereign", costs = 1700000, description = {}, model = "sovereign"},
				{name = "Daemon", costs = 740000, description = {}, model = "daemon"},
				{name = "Akuma", costs = 1500000, description = {}, model = "akuma"},
				{name = "Bagger", costs = 100000, description = {}, model = "bagger"},
				{name = "Vader", costs = 500000, description = {}, model = "vader"},
				{name = "F131", costs = 45000, description = {}, model = "f131"},
				{name = "BMW S1000 RR", costs = 500000, description = {}, model = "bmws"},
				{name = "Ninja H2R", costs = 550000, description = {}, model = "ninjah2"},
				{name = "Zombie Bobber", costs = 600000, description = {}, model = "zombiea"},
			}
		},
		["biciclete"] = {
			title = "biciclete",
			name = "biciclete",
			buttons = {
				{name = "BMX", costs = 5000, description = {}, model = "bmx"},
				{name = "Fixter", costs = 2000, description = {}, model = "Fixter"},
				{name = "TRIBIKE", costs = 50000, description = {}, model = "tribike"},
				{name = "TRIBIKE2", costs = 50000, description = {}, model = "tribike2"},
				{name = "TRIBIKE3", costs = 50000, description = {}, model = "tribike3"},
				{name = "Mountain Bike", costs = 100000, description = {}, model = "scorcher"},
			}
		},
		["suv-offroad"] = {
			title = "suv-offroad",
			name = "suv-offroad",
			buttons = {
			    {name = "Volswagen Touareg R50", costs = 0, description = {}, model = "r50"},
			    {name = "Dubsta 6x6", costs = 800000, description = {}, model = "dubsta3"},
				{name = "Jeep Wrangler", costs = 250000, description = {}, model = "rubi3d"},
				{name = "Audi SQ7 2016", costs = 500000, description = {}, model = "SQ72016"},
			    {name = "BmW X6M", costs = 1000000, description = {}, model = "x6m"},
				{name = "BMW X5 E53", costs = 300000, description = {}, model = "x5e53"},
				{name = "Lamborghini Urus", costs = 700000, description = {}, model = "urus2018"},
                {name = "Jaguar F-Pace S", costs = 550000, description = {}, model = "fpace"},
				{name = "Range Rover", costs = 500000, description = {}, model = "evoq"},
				{name = "Bentley Bentayga", costs = 650000, description = {}, model = "urus"},
				{name = "Porche Cayenne S", costs = 500000, description = {}, model = "pcs18"},
			}
		},
		["gang-cars"] = {
			title = "gang-cars",
			name = "gang-cars",
			buttons = {
				{name = "CLS", costs = 0, description = {}, model = "cls2015"},
				{name = "Vito", costs = 0, description = {}, model = "v250"},
				{name = "Hummer 6x6", costs = 0, description = {}, model = "h6"},
				{name = "Jeep OffRoad", costs = 0, description = {}, model = "qiugejpa"},
				{name = "Rolls Royce Phantom", costs = 0, description = {}, model = "rrphantom"},
				{name = "BMW", costs = 0, description = {}, model = "750li"},
				{name = "2014RangeRoverSport", costs = 0, description = {}, model = "SVR14"},
				{name = "SuperVolito", costs = 0, description = {}, model = "supervolito"},
			}
		},
		["job"] = {
			title = "job",
			name = "job",
			buttons = {
				{name = "cop", description = ''},
				{name = "fbi", description = ''},
				{name = "fisher", description = ''},
				{name = "ems", description = ''},
				{name = "uber", description = ''},
				{name = "lawyer", description = ''},
				{name = "delivery", description = ''},
				{name = "repair", description = ''},
				{name = "bankdriver", description = ''},
				{name = "medicalweed", description = ''},
			}
		},
		["cop"] = {
			title = "cop",
			name = "cop",
			buttons = {
			    {name = "Police Cruiser", costs = 0, description = {}, model = "police"},
				{name = "Dodge Sheriff", costs = 0, description = {}, model = "police2"},
			    {name = "McLaren", costs = 0, description = {}, model = "polmp4"},
			    {name = "Police3", costs = 0, description = {}, model = "police3"},
			    {name = "Police4", costs = 0, description = {}, model = "police4"},
			    {name = "Police SUV", costs = 0, description = {}, model = "police5"},
			    {name = "Police K9", costs = 0, description = {}, model = "police6"},
			    {name = "Police7", costs = 0, description = {}, model = "police8"},
				{name = "Police8", costs = 0, description = {}, model = "policet"},
				{name = "Policet", costs = 0, description = {}, model = "sheriff3"},
				{name = "Sheriff", costs = 0, description = {}, model = "sheriff2"},
				{name = "Sheriff SUV", costs = 0, description = {}, model = "sheriff"},
				{name = "2015 Sheriff", costs = 0, description = {}, model = "riot"},
				{name = "SWAT", costs = 0, description = {}, model = "fbi"},
				{name = "Unmarked", costs = 0, description = {}, model = "fbi3"},
				{name = "Kuruma", costs = 0, description = {}, model = "ghispo2"},
				{name = "Police Maserati", costs = 0, description = {}, model = "polf430"},
				{name = "Police Ferarri", costs = 0, description = {}, model = "pol718"},
				{name = "Police Porsche", costs = 0, description = {}, model = "polchiron"},
				{name = "Police Chiron", costs = 0, description = {}, model = "polgs350"},
				{name = "Police Lexus", costs = 0, description = {}, model = "police2"},
				{name = "Police Audi", costs = 0, description = {}, model = "hwaycar3"},
				{name = "Trooper SUV", costs = 0, description = {}, model = "hwaycar5"},
			}
		},
		
		["fisher"] = {
			title = "fisher",
			name = "fisher",
			buttons = {
				{name = "fisherboat", costs = 0, description = {}, model = "suntrap"},
			}
		},
		
		["fbi"] = {
			title = "fbi",
			name = "fbi",
			buttons = {
			    {name = "FBI", costs = 0, description = {}, model = "fbi"},
				{name = "FBI", costs = 0, description = {}, model = "fbi3"},
				{name = "FBI", costs = 0, description = {}, model = "polmav"},
			}
		},
		
		["ems"] = {
			title = "ems",
			name = "ems",
			buttons = {
			    {name = "Reno Super", costs = 0, description = {}, model = "polrs"},
				{name = "Lamborghini", costs = 0, description = {}, model = "police3"},
				{name = "Tahoe", costs = 0, description = {}, model = "hwaycar4"},
				{name = "AMBULANCE", costs = 0, description = {}, model = "ambulance"},
				{name = "EMS Bike", costs = 0, description = {}, model = "policeb"},
				{name = "Elicopter EMS", costs = 0, description = {}, model = "supervolito2"},
				{name = "Fire Truk", costs = 0, description = {}, model = "firetruk"},
			}
		},
		
		["uber"] = {
			title = "uber",
			name = "uber",
			buttons = {
				{name = "Tesla", costs = 200000, description = {}, model = "teslax"},
			}
		},
		
		["lawyer"] = {
			title = "lawyer",
			name = "lawyer",
			buttons = {
				{name = "lawyercar1", costs = 0, description = {}, model = "panto"},
			}
		},
		
		["delivery"] = {
			title = "delivery",
			name = "delivery",
			buttons = {
				{name = "deliverycar1", costs = 0, description = {}, model = "faggio3"},
				{name = "deliverycar2", costs = 0, description = {}, model = "c10custom"},
			}
		},
		
		["repair"] = {
			title = "repair",
			name = "repair",
			buttons = {
				{name = "repaircar1", costs = 0, description = {}, model = "towtruck2"},
				{name = "repaircar2", costs = 0, description = {}, model = "utillitruck3"},
			}
		},
		
		["bankdriver"] = {
			title = "bankdriver",
			name = "bankdriver",
			buttons = {
				{name = "bankdrivercar1", costs = 0, description = {}, model = "stockade"},
			}
		},
		
		["medicalweed"] = {
			title = "medicalweed",
			name = "medicalweed",
			buttons = {
				{name = "medicalweedcar1", costs = 0, description = {}, model = "pony2"},
			}
		},
		["vip"] = {
			title = "vip",
			name = "vip",
			buttons = {
				{name = "Bugatti Veyron", costs = 0, description = {}, model = "bugatti"},
				{name = "Lamborghini Centenario", costs = 0, description = {}, model = "lp770r"},
				{name = "Koenigsegg Reger", costs = 0, description = {}, model = "regera"},
				{name = "Rolls Royce Sport", costs = 0, description = {}, model = "wraith"},
				{name = "Dodge Viper", costs = 0, description = {}, model = "vipertt"},
				{name = "Ford HOONIGAN", costs = 0, description = {}, model = "fordh"},
				{name = "2014RangeRoverSport", costs = 0, description = {}, model = "SVR14"},				
				{name = "2018 Lamborghini Aventador S", costs = 0, description = {}, model = "aventadors"},
				{name = "Bugatti Chiron", costs = 0, description = {}, model = "2017chiron"},
				{name = "Maybach Exelero", costs = 0, description = {}, model = "exelero"},
				{name = "Lamborghini Veneno", costs = 0, description = {}, model = "veneno"},
				{name = "Dodge Challenger", costs = 0, description = {}, model = "rampage10"},
			}
		},
		["aviatie"] = {
			title = "aviatie",
			name = "aviatie",
			buttons = {
				{name = "avivip", description = ''},
				{name = "helivip", description = ''},
			}
		},
		["avivip"] = {
			title = "avivip",
			name = "avivip",
			buttons = {
				{name = "Besra", costs = 30000000, description = {}, model = "besra"},
			}
		},
		["helivip"] = {
			title = "helivip",
			name = "helivip",
			buttons = {
				{name = "Volatus", costs = 25000000, description = {}, model = "volatus"},
				{name = "Super Volito", costs = 0, description = {}, model = "supervolito"},
			}
		},

	}
}

return vehshop