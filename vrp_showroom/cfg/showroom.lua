vehshop = {
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
			title = "Showroom",
			name = "main",
			buttons = {
				{name = "cars", description = ""},
				{name = "suv-offroad", description = ""},
				{name = "gang-cars", description = ""},
				{name = "hitman", description = ""},
				{name = "truck", description = ""},
				{name = "thelostmc", description = ""},
				{name = "motociclete", description = ""},
				{name = "job", description = ""},
				{name = "vip", description = ""},
				--{name = "dmd-cars", description = ""},
				{name = "bikes", description = ""},
				{name = "aviation", description = ""},
			}
		},
		["cars"] = {
			title = "cars",
			name = "cars",
			buttons = {
				{name = "audi", description = ''},
				{name = "bmw", description = ''},
				{name = "mercedesbenz", description = ''},
				{name = "ferrari", description = ''},
				{name = "fast-and-furios", description = ''},
				{name = "dacia", description = ''},
				{name = "lamborghini", description = ''},
				{name = "Aston Martin", description = ''},
				{name = "Porche", description = ''},
				{name = "Toyota", description = ''},
				{name = "cars5", description = ''},
				{name = "altele", description = ''},
				--{name = "cycles", description = ''},
			}
		},
		["audi"] = {
			title = "audi",
			name = "audi",
			buttons = {
				{name = "Audi A6 2019", costs = 500000, speed = 40, acce = 50, brake = 60, trac = 30, description = {}, model = "a6avant"},
				{name = "Audi R8", costs = 180000, speed = 45, acce = 60, brake = 60, trac = 40, description = {}, model = "r8ppi"},
				{name = "Audi A8 2017", costs = 700000, speed = 40, acce = 30, brake = 50, trac = 30, description = {}, model = "a8lfsi"},
				{name = "Audi RS7", costs = 500000, speed = 40, acce = 30, brake = 40, trac = 30, description = {}, model = "rs7"},
				{name = "Audi Q8 2019", costs = 800000, speed = 45, acce = 40, brake = 50, trac = 40, description = {}, model = "audiq8"},
			}
		},
		["bmw"] = {
			title = "bmw",
			name = "bmw",
			buttons = {
			    {name = "BMW I8 AC", costs = 10000000, speed = 65, acce = 55, brake = 35, trac = 40, description = {}, model = "bmwi8"},
				{name = "BMW M3", costs = 7000000, speed = 70, acce = 70, brake = 50, trac = 50, description = {}, model = "m3walk"},
				{name = "BMW M3 F80", costs = 500000, speed = 35, acce = 30, brake = 30, trac = 30, description = {}, model = "m3f80"},
				{name = "BMW M4", costs = 7500000, speed = 70, acce = 45, brake = 50, trac = 40, description = {}, model = "m4walk"},
				{name = "BMW M5 E39", costs = 90000, speed = 45, acce = 70, brake = 40, trac = 50, description = {}, model = "bmwe39"},
				{name = "BMW M5 E60", costs = 530000, speed = 50, acce = 20, brake = 40, trac = 30, description = {}, model = "m5e60"},
				{name = "BMW M6 1984", costs = 200000, speed = 50, acce = 40, brake = 40, trac = 30, description = {}, model = "oldm6"},
				{name = "BMW M5 F90", costs = 10000000, description = {}, model = "bmci"},
				{name = "BMW M6", costs = 4000000, speed = 60, acce = 50, brake = 50, trac = 35, description = {}, model = "m6gc"},
				{name = "BMW Seria 7", costs = 2000000, speed = 35, acce = 40, brake = 40, trac = 30, description = {}, model = "750licustom"},
				{name = "BMW Sport", costs = 550000, speed = 55, acce = 60, brake = 50, trac = 50, description = {}, model = "bmwhommage"},
			    {name = "BMW M2", costs = 10000000, speed = 70, acce = 20, brake = 30, trac = 50, description = {}, model = "m2"},
				{name = "BMW X7", costs = 7500000, speed = 55, acce = 60, brake = 50, trac = 50, description = {}, model = "bmwx7"},
				
			}
		},
		["mercedesbenz"] = {
			title = "mercedesbenz",
			name = "mercedesbenz",
			buttons = {
			    {name = "Mercedes SLR", costs = 9000000, speed = 50, acce = 35, brake = 40, trac = 30, description = {}, model = "moss"},
				{name = "Mercedes A45", costs = 350000, speed = 40, acce = 30, brake = 40, trac = 30, description = {}, model = "ma45"},
				{name = "Mercedes AMG GT", costs = 10000000, speed = 90, acce = 70, brake = 35, trac = 50, description = {}, model = "amgwalk"},
				{name = "Mercedes AMG Electric", costs = 4100000, speed = 40, acce = 50, brake = 30, trac = 20, description = {}, model = "slsublue"},
				{name = "Mercedes S600", costs = 500000, speed = 20, acce = 30, brake = 40, trac = 20, description = {}, model = "s500w222"},
				{name = "Mercedes C63 AMG", costs = 500000, speed = 30, acce = 20, brake = 30, trac = 40, description = {}, model = "c63coupe"},
				{name = "AMG Vision GT", costs = 4000000, speed = 60, acce = 50, brake = 50, trac = 40, description = {}, model = "mvisiongt"},
				{name = "Mercedes Gullwing", costs = 600000, speed = 35, acce = 30, brake = 40, trac = 40, description = {}, model = "300gsl"},
				{name = "Mercedes GT63s 2019", costs = 16000000, speed = 35, acce = 30, brake = 40, trac = 40, description = {}, model = "gt63s"},
				{name = "Mercedes X Class", costs = 8000000, speed = 35, acce = 30, brake = 40, trac = 40, description = {}, model = "xclass"},
			}
		},
		["ferrari"] = {
			title = "ferrari",
			name = "ferrari",
			buttons = {
			    {name = "Ferrari LaFerrari", costs = 12500000, speed = 70, acce = 60, brake = 50, trac = 60, description = {}, model = "aperta"},
				{name = "Ferrari LaFerrari 15", costs = 9000000, speed = 35, acce = 20, brake = 40, trac = 20, description = {}, model = "laferrari15"},
				{name = "Ferrari California", costs = 6000000, speed = 35, acce = 20, brake = 40, trac = 20, description = {}, model = "fct"},
				{name = "Ferrari GT C4", costs = 4500000, speed = 70, acce = 55, brake = 70, trac = 50, description = {}, model = "gtcl"},
				{name = "Ferrari IT458", costs = 3100000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "italia458"},
				{name = "Ferrari 458 Spyder", costs = 8000000, speed = 50, acce = 20, brake = 40, trac = 60, description = {}, model = "458spiderwalk"},
				{name = "Ferrari F12", costs = 9000000, speed = 60, acce = 60, brake = 40, trac = 70, description = {}, model = "f12walk"},
				{name = "Ferrari F50", costs = 7000000, speed = 40, acce = 30, brake = 60, trac = 50, description = {}, model = "f50ub"},
				{name = "Ferrari 599", costs = 5000000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "gtbf"},
				--{name = "Ferrari 599XX", costs = 10500000, speed = 60, acce = 60, brake = 70, trac = 60, description = {}, model = "599xxevo"},
				{name = "Ferrari 360", costs = 3000000, speed = 50, acce = 40, brake = 40, trac = 50, description = {}, model = "f360"},
				{name = "Ferrari 812", costs = 6000000, speed = 55, acce = 30, brake = 40, trac = 20, description = {}, model = "ferrari812"},
			}
		},
		["lamborghini"] = {
			title = "lamborghini",
			name = "lamborghini",
			buttons = {
				{name = "Lamborghini Huracan", costs = 8000000, speed = 80, acce = 70, brake = 40, trac = 60, description = {}, model = "huracanwalk"},
				{name = "Lambo Huracan 2", costs = 8000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "huracan"},
				{name = "Lamborghini Aventador", costs = 8500000, speed = 80, acce = 80, brake = 50, trac = 80, description = {}, model = "aventadorwalk"},
				{name = "Lamborghini Centenario", costs = 15000000, speed = 100, acce = 100, brake = 100, trac = 70, description = {}, model = "lp770r"},
				{name = "Lamborghini Murcielago", costs = 5500000, speed = 70, acce = 50, brake = 40, trac = 60, description = {}, model = "vesper"},
				{name = "Lamborghini Mura", costs = 6500000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "miura"},
			    {name = "Lamborghini Gallardo", costs = 2500000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "gallardo"},
			}
		},
		["Aston Martin"] = {
			title = "Aston Martin",
			name = "Aston Martin",
			buttons = {
			    {name = "Aston Martin xTreme", costs = 4000000, speed = 50, acce = 40, brake = 40, trac = 40, description = {}, model = "db11"},
			    {name = "Aston Martin GT12", costs = 5000000, speed = 45, acce = 30, brake = 40, trac = 40, description = {}, model = "vgt12"},
				{name = "Aston Martin VANTAGE 2019", costs = 5200000, speed = 60, acce = 40, brake = 40, trac = 40, description = {}, model = "amv19"},
			}
		},
		["Porche"] = {
			title = "Porche",
			name = "Porche",
			buttons = {
			    {name = "Porsche GT3RS", costs = 2000000, speed = 60, acce = 50, brake = 40, trac = 40, description = {}, model = "911gtrs"},
				{name = "Porsche Panamera", costs = 4000000, speed = 55, acce = 60, brake = 70, trac = 20, description = {}, model = "pturismo"},
				{name = "Porsche Panamera2", costs = 4500000, speed = 60, acce = 20, brake = 40, trac = 20, description = {}, model = "panamera17turbo"},
			}
		},
		["fast-and-furios"] = {
			title = "Fast And Furios",
			name = "Fast And Furios",
			buttons = {
				{name = "Gtr34", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "2f2fgtr34"},
				{name = "Gts", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "2f2fgts"},
				{name = "Mk4", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "2f2fmk4"},
				{name = "Mle7", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "2f2fmle7"},
				{name = "Wrx", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "ff4wrx"},
				{name = "R34", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "fnf4r34"},
				{name = "Lan", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "fnflan"},
				{name = "Mits", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "fnfmits"},
				{name = "Fmk4", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "fnfmk4"},
				{name = "GtX", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "gtx"},
				{name = "Frx", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "2f2frx7"},
				{name = "2000", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "2f2fs2000"},
				{name = "Dom", costs = 10000000, speed = 60, acce = 50, brake = 70, trac = 60, description = {}, model = "fnfrx7dom"},
				{name = "Sultan V8", costs = 5000000, speed = 55, acce = 50, brake = 70, trac = 50, description = {}, model = "sultanrsv8"},
			}
		},
		["dacia"] = {
			title = "dacia",
			name = "dacia",
			buttons = {
				{name = "Dacia Duster 2014", costs = 14000, speed = 30, acce = 20, brake = 40, trac = 20, description = {}, model = "daduster"},
				{name = "Dacia Sandero 2014", costs = 8000, speed = 30, acce = 20, brake = 40, trac = 20, description = {}, model = "sandero"},
				{name = "Dacia Sandero Stepway 2014", costs = 10000, speed = 30, acce = 20, brake = 40, trac = 20, description = {}, model = "sanderos2"},
				{name = "Pony", costs = 15000, speed = 30, acce = 20, brake = 40, trac = 20, description = {}, model = "pony"},
				{name = "Burrito", costs = 10000, speed = 30, acce = 20, brake = 40, trac = 20, description = {}, model = "burrito"},
			}
		},
		["Toyota"] = {
			title = "dacia",
			name = "dacia",
			buttons = {
			    {name = "Toyota GT86", costs = 200000, speed = 50, acce = 40, brake = 40, trac = 20, description = {}, model = "gt86"},
				{name = "Toyota Supra", costs = 230000, speed = 55, acce = 60, brake = 40, trac = 60, description = {}, model = "supra2"},
				{name = "Camioneta Calimon", costs = 2000000, speed = 55, acce = 60, brake = 40, trac = 60, description = {}, model = "80elcamino"},
				{name = "Dead Ringer", costs = 2300000, speed = 55, acce = 60, brake = 40, trac = 60, description = {}, model = "deadringer"},
			}
		},
		["cars5"] = {
			title = "cars5",
			name = "cars5",
			buttons = {
			    {name = "T20", costs = 3000000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "t20"},
			    {name = "Bullet", costs = 350000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "bullet"},
				{name = "Drift Tampa", costs = 850000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "tampa2"},
				{name = "Ruston", costs = 750000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "ruston"},
			    {name = "Entity XF", costs = 250000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "entityxf"},
			    {name = "FMJ", costs = 700000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "fmj"},
				{name = "Coquette Classic", costs = 300000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "coquette2"},
			    {name = "Itali GTB Custom", costs = 800000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "italigtb2"},
			    {name = "Nero Custom", costs = 1000000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "nero2"},
				{name = "Nero", costs = 800000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "nero"},
			    {name = "RE-7B", costs = 850000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "le7b"},
			    {name = "Tempesta", costs = 950000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "tempesta"},
			    {name = "Turismo R", costs = 350000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "turismor"},
			    {name = "Tyrus", costs = 730000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "tyrus"},
			    {name = "Specter Custom", costs = 450000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "specter2"},
			    {name = "ETR1", costs = 700000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "sheava"},
			    {name = "811", costs = 500000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "pfister811"},
				{name = "Elegy", costs = 150000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "elegy"},
				{name = "GP1", costs = 150000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "gp1"},
				{name = "Cheetah", costs = 1300000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "cheetah"},
				{name = "Tampa", costs = 72000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "tampa"},
				{name = "Verkierer", costs = 110000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "verlierer2"},
				{name = "Infernus", costs = 250000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "infernus"},
				{name = "Lynx", costs = 170000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "lynx"},
				{name = "Vacca", costs = 340000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "vacca"},
				{name = "Zentorno", costs = 1500000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "zentorno"},
				{name = "X80 Proto", costs = 4500000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "prototipo"},
				{name = "Reaper", costs = 500000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "reaper"},
				{name = "XA21", costs = 1300000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "xa21"},
				{name = "Tesla 2020", costs = 4300000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "tr22"},
			}
		},
		["altele"] = {
			title = "altele",
			name = "altele",
			buttons = {
				{name = "Koenigsegg Agera", costs = 7000000, speed = 90, acce = 80, brake = 70, trac = 80, description = {}, model = "acsr"},
				{name = "Chevrolet Corvette ZR1", costs = 2000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "zr1c3"},
				{name = "Nissan GTR R35", costs = 800000, speed = 55, acce = 40, brake = 40, trac = 50, description = {}, model = "gtrc"},
				{name = "Lc", costs = 2000000, speed = 40, acce = 30, brake = 40, trac = 20, description = {}, model = "lc"},
				{name = "Alfa Romeo Spider", costs = 4500000, speed = 40, acce = 30, brake = 40, trac = 40, description = {}, model = "spider115"},
				{name = "Hummer H2", costs = 2000000, speed = 60, acce = 40, brake = 50, trac = 70, description = {}, model = "h2m"},
				{name = "RollsRoyce Wraith", costs = 25000000, speed = 60, acce = 60, brake = 50, trac = 70, description = {}, model = "wraith"},
				{name = "Pontiac", costs = 1000000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "firebird"},
				--{name = "Lykan HyperSport", costs = 4100000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "lykan"},
				--{name = "Mustang", costs = 8000000, speed = 60, acce = 40, brake = 40, trac = 30, description = {}, model = "rmodmustang"},
				{name = "Tesla Model S", costs = 500000, speed = 60, acce = 50, brake = 40, trac = 40, description = {}, model = "models"},
				{name = "Dodge Challenger Demon", costs = 500000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "demon"},
				{name = "Bentley GT", costs = 500000, speed = 40, acce = 20, brake = 40, trac = 30, description = {}, model = "gt2012"},
				{name = "VW Passat", costs = 500000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "vwstance"},
				{name = "Mini John Cooper", costs = 20000, speed = 30, acce = 20, brake = 40, trac = 20, description = {}, model = "miniub"},
				{name = "Mitsubishi Lancer", costs = 35000, speed = 30, acce = 20, brake = 40, trac = 20, description = {}, model = "kuruma"},
				{name = "Subaru Impreza", costs = 280000, speed = 45, acce = 30, brake = 40, trac = 20, description = {}, model = "ysbrimps11"},
			}
		},
		["motociclete"] = {
			title = "motociclete",
			name = "motociclete",
			buttons = {
				{name = "Innovation", costs = 300000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "innovation"},
			    {name = "Sanchez", costs = 150000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "sanchez"},
				{name = "Kawasaki", costs = 500000, speed = 45, acce = 40, brake = 40, trac = 20, description = {}, model = "zx10r"},
				{name = "Yamaha R1", costs = 600000, speed = 55, acce = 40, brake = 40, trac = 40, description = {}, model = "r1"},
				{name = "Agusta F4 RR", costs = 900000, speed = 90, acce = 80, brake = 70, trac = 80, description = {}, model = "f4rr"},
				{name = "Thrust", costs = 110000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "thrust"},
				{name = "Sanchez 2", costs = 150000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "Sanchez2"},
				{name = "Street Blazer", costs = 2000000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "blazer4"},
				{name = "Bagger", costs = 100000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "bagger"},
				{name = "Vader", costs = 500000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "vader"},
				{name = "F131 ", costs = 45000, speed = 60, acce = 40, brake = 40, trac = 50, description = {}, model = "f131"},
				{name = "BMW S1000 RR", costs = 500000, speed = 60, acce = 30, brake = 40, trac = 40, description = {}, model = "bmws"},
				{name = "Ninja H2R", costs = 550000, speed = 70, acce = 60, brake = 40, trac = 50, description = {}, model = "ninjah2"},
				{name = "Zombie Bobber", costs = 600000, speed = 40, acce = 50, brake = 30, trac = 40, description = {}, model = "zombiea"},
			}
		},
		["bikes"] = {
			title = "bikes",
			name = "bikes",
			buttons = {
				{name = "BMX", costs = 5000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "bmx"},
				{name = "Fixter", costs = 2000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "Fixter"},
				{name = "TRIBIKE", costs = 50000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "tribike"},
				{name = "TRIBIKE2", costs = 50000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "tribike2"},
				{name = "TRIBIKE3", costs = 50000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "tribike3"},
				{name = "Mountain Bike", costs = 100000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "scorcher"},
			}
		},
		["suv-offroad"] = {
			title = "suv-offroad",
			name = "suv-offroad",
			buttons = {
			    {name = "Dubsta 6x6", costs = 800000, speed = 40, acce = 20, brake = 40, trac = 20, description = {}, model = "dubsta3"},
			    {name = "Jeep Trailcat", costs = 1000000, speed = 30, acce = 20, brake = 40, trac = 20, description = {}, model = "trailcat"},
			    {name = "Jeep Qiugejpa", costs = 200000, speed = 40, acce = 40, brake = 40, trac = 50, description = {}, model = "qiugejpa"},
				{name = "Mercedes-Benz G65", costs = 200000, speed = 65, acce = 40, brake = 50, trac = 60, description = {}, model = "G65"},
				{name = "Audi SQ7 2016", costs = 500000, speed = 40, acce = 40, brake = 40, trac = 20, description = {}, model = "SQ72016"},
			    {name = "BMW X6M", costs = 1000000, speed = 70, acce = 40, brake = 40, trac = 40, description = {}, model = "x6m"},
				{name = "BMW X5 E53", costs = 300000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "x5e53"},
				{name = "Lamborghini Urus", costs = 6500000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "urus2018"},
				{name = "Range Rover", costs = 500000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "evoq"},
				{name = "Bentley Bentayga", costs = 650000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "urus"},
				{name = "Volvo V60", costs = 8000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "vb60"},
				{name = "Nissan Patrol", costs = 200000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "patrold"},
				{name = "Nissan Titan", costs = 3000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "nissantitan17"},
				{name = "Porche Cayenne S", costs = 500000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "pcs18"},
				{name = "Dubsta", costs = 400000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "dubsta"},
			}
		},
		["gang-cars"] = {
			title = "gang-cars",
			name = "gang-cars",
			buttons = {
			    {name = "Mercedes Limousine", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "alpha"},
				{name = "Cadillac Limousine", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "limoxts"},
				{name = "Hermes", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "hermes"},
				{name = "Hustler", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "hustler"},
				{name = "Z-type", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "ztype"},
				{name = "Roosevelt", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "btype"},
				{name = "Super Diamond", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "superd"},
				{name = "RangeRover", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "SVR14"},
				{name = "RollsRoyce Phantom", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "rrphantom"},
				{name = "Seven70", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "seven70"},
				{name = "Nightshade", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "nightshade"},
				{name = "Windsor", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "windsor"},
				{name = "Moonbeam", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "moonbeam"},
				{name = "Buccaneer", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "buccaneer2"},
				{name = "Lamborghini Centenario", costs = 10000000, speed = 100, acce = 100, brake = 100, trac = 100, description = {}, model = "lp770r"},
				{name = "Pontiac", costs = 1000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "firebird"},
				{name = "Hotrod", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "hotrod2"},
				{name = "Volatus", costs = 25000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "volatus"},
				{name = "2016 GTA Spano", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "spano2016"},
			}
		},
		["hitman"] = {
			title = "hitman",
			name = "hitman",
			buttons = {
			    {name = "Mercedes Limousine", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "alpha"},
				{name = "Cadillac Limousine", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "limoxts"},
				{name = "Hermes", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "hermes"},
				{name = "Hustler", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "hustler"},
				{name = "Z-type", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "ztype"},
				{name = "Havok", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "havok"},
				{name = "RollsRoyce Phantom", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "rrphantom"},
				{name = "Volatus", costs = 25000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "volatus"},
			}
		},
		["truck"] = {
			title = "truck",
			name = "truck",
			buttons = {
			    {name = "Kamaz 2012", costs = 200000, speed = 35, acce = 20, brake = 40, trac = 20, description = {}, model = "kamaz"},
				{name = "Kamaz 2017", costs = 1000000, speed = 40, acce = 30, brake = 40, trac = 30, description = {}, model = "k54115"},
				{name = "Daf Truck", costs = 2500000, speed = 45, acce = 30, brake = 40, trac = 40, description = {}, model = "daf"},
				{name = "Man 2017", costs = 2800000, speed = 50, acce = 30, brake = 40, trac = 50, description = {}, model = "man"},
				{name = "Haul Master", costs = 5000000, speed = 55, acce = 30, brake = 40, trac = 60, description = {}, model = "haulmaster2"},
				{name = "Nav America", costs = 6000000, speed = 60, acce = 30, brake = 40, trac = 70, description = {}, model = "nav9800"},
				{name = "Phantom", costs = 6500000, speed = 65, acce = 30, brake = 40, trac = 80, description = {}, model = "phantom3"},
				{name = "MTL 2018", costs = 7000000, speed = 70, acce = 30, brake = 40, trac = 90, description = {}, model = "ramvan"},
			}
		},
		["thelostmc"] = {
			title = "The Lost Mc",
			name = "The Lost Mc",
			buttons = {
			    {name = "Deamon 1", costs = 85000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "deamon"},
				{name = "Deamon 2", costs = 90000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "deamon2"},
				{name = "Ruffian", costs = 74000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "ruffian"},
				{name = "Innovation", costs = 300000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "innovation"},
				{name = "Chimera", costs = 40000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "chimera"},
				{name = "Hexer", costs = 300000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "hexer"},
			}
		},
		["job"] = {
			title = "job",
			name = "job",
			buttons = {
				{name = "swat", description = ''},
				{name = "cop", description = ''},
				--{name = "fbi", description = ''},
				{name = "fisher", description = ''},
				{name = "weazelnews", description = ''},
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
			    {name = "McLaren P1", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polp1"},
			    {name = "Mustang", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "policegt350r"},
				--{name = "Subaru Police", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "policesu"},
			    {name = "Chiron COP", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polchiron"},
				{name = "Lexus GS350", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polgs350"},
				{name = "Police Ferarri", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polf430"},
				{name = "Audi A4 2017", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "police2"},
				{name = "Volkswagen Passat", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "police3"},
				{name = "Volkswagen Polo", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "sheriff"},
				{name = "Maserati Ghibli", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "ghispo2"},
				{name = "Porsche 718 Cayman", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "pol718"},
				{name = "Fenyr Cop", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "wmfenyrcop"},
				{name = "BMW X5", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "fbi"},
				{name = "BMW E60", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "police"},
				{name = "Maverick", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polmav"}
			}
		},
		
		["swat"] = {
			title = "swat",
			name = "swat",
			buttons = {
				{name = "Nismo Swat", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "rmodpolice"},
				--{name = "Haitun Heli", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "haitun"},
				{name = "C7R Swat", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "corvettepd"},
				{name = "Dodge Viper Swat", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polsrt10"},
				{name = "Pagani Zonda Swat", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polzonda"},
				{name = "Aventa Swat", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polaventa"},
				{name = "Insurgent Swat", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "insurgent2"},
				{name = "Duba Swat", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "riot"},
				{name = "Insurgent Riot", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "gurkha"},
				{name = "Frogger", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "frogger"},
			}
		},
		
		["fisher"] = {
			title = "fisher",
			name = "fisher",
			buttons = {
				{name = "fisherboat", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "suntrap"},
			}
		},
		
		["weazelnews"] = {
			title = "weazelnews",
			name = "weazelnews",
			buttons = {
			{name = "Rumpo", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "rumpo"},
			{name = "News Van", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "newsvan"},
			{name = "News Maverick", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "maverick2"},
			}
		},
		
		["fbi"] = {
			title = "fbi",
			name = "fbi",
			buttons = {
			    --{name = "Fbi", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "fbi"},
				--{name = "Fbi2", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "fbi2"},
				--{name = "McLaren P1", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polp1"},
				--{name = "Frogger", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "frogger2"},
				--{name = "Pol Chager 1970", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polchall70"},
			}
		},
		
		["ems"] = {
			title = "ems",
			name = "ems",
			buttons = {
			    {name = "Reno Super", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polrs"},
				{name = "Maseratti", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "ghispo2"},
				{name = "Bmw X5", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "fbi"},
				{name = "VW Ambulance", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "ambulanc2"},
				{name = "Volvo", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "lguard"},
				{name = "M.B. AMG", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "policeold2"},
				{name = "M.B. AMG SL", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "slsdp"},
				{name = "VW Arteon", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "polarteon"},
				{name = "Lamborghini", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "police3"},
				{name = "Tahoe", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "hwaycar4"},
				{name = "Ambulance", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "ambulance"},
				{name = "Elicopter EMS", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "supervolito2"},
				{name = "Fire Truk", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "firetruk"},
			}
		},
		
		["uber"] = {
			title = "uber",
			name = "uber",
			buttons = {
				{name = "Tesla", costs = 200000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "teslax"},
			}
		},
		
		["lawyer"] = {
			title = "lawyer",
			name = "lawyer",
			buttons = {
				{name = "lawyercar1", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "panto"},
			}
		},
		
		["delivery"] = {
			title = "delivery",
			name = "delivery",
			buttons = {
				{name = "deliverycar1", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "faggio3"},
				{name = "deliverycar2", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "c10custom"},
			}
		},
		
		["repair"] = {
			title = "repair",
			name = "repair",
			buttons = {
				{name = "repaircar1", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "towtruck"},
				{name = "repaircar2", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "utillitruck3"},
				{name = "Masina Tractare", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "flatbed"},
			}
		},
		
		["bankdriver"] = {
			title = "bankdriver",
			name = "bankdriver",
			buttons = {
				{name = "bankdrivercar1", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "stockade"},
			}
		},
		
		["medicalweed"] = {
			title = "medicalweed",
			name = "medicalweed",
			buttons = {
				{name = "medicalweedcar1", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "pony2"},
			}
		},
		["vip"] = {
			title = "vip",
			name = "vip",
			buttons = {
				{name = "Maybach Exelero", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "exelero"},
				{name = "Porsche 918", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "918"},
				{name = "Bugati Chiron", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "chiron17"},
				{name = "Devel Sixteen", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "develSix"},
				{name = "Chevrolet 1996", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "stingray66"},
				{name = "Jaguar C-X75", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "cx75"},
				{name = "Ferrari XXK", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "fxxk16"},
				{name = "Lamborghini Veneno", costs = 11000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "veneno"},
				{name = "Dodge Charger", costs = 15000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "rt70"},
				{name = "Alpine A110-50", costs = 3000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "a11050"},
				{name = "Promod Stallion", costs = 5000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "promod_stallion"},
				{name = "Shotaro", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "shotaro"},
				{name = "Swift Deluxe Gold", costs = 5000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "swift2"},
				{name = "Luxor Deluxe Gold", costs = 5000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "luxor2"},
				{name = "Ford 350 D", costs = 0, speed = 50, acce = 20, brake = 40, trac = 20,description = {}, model = "18f350d"},
			}
		},
		-----------------------------------------
		["aviation"] = {
			title = "aviation",
			name = "aviation",
			buttons = {
				{name = "avivip", description = ''},
				{name = "helivip", description = ''},
			}
		},
		["avivip"] = {
			title = "avivip",
			name = "avivip",
			buttons = {
				{name = "Besra", costs = 30000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "besra"},
			}
		},
		["helivip"] = {
			title = "helivip",
			name = "helivip",
			buttons = {
				{name = "Swift Deluxe Gold", costs = 5000000, speed = 50, acce = 20, brake = 40, trac = 20, description = {}, model = "swift2"},
			}
		},

	}
}

return vehshop