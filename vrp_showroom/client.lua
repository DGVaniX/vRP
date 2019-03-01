
vRP = Proxy.getInterface("vRP")
vRPg = Proxy.getInterface("vRP_garages")
heading = 0

function deleteVehiclePedIsIn()
  local v = GetVehiclePedIsIn(GetPlayerPed(-1),false)
  SetVehicleHasBeenOwnedByPlayer(v,false)
  Citizen.InvokeNative(0xAD738C3085FE7E11, v, false, true) -- set not as mission entity
  SetVehicleAsNoLongerNeeded(Citizen.PointerValueIntInitialized(v))
  Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(v))
end

RegisterNetEvent( 'wk:deleteVehicle2' )
AddEventHandler( 'wk:deleteVehicle2', function()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        local pos = GetEntityCoords( ped )

        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )

                if ( DoesEntityExist( vehicle ) ) then 
                	ShowNotification( "~r~Unable to delete vehicle, try again." )
                else 
                	ShowNotification( "Vehicle deleted." )
                end 
            else 
                ShowNotification( "You must be in the driver's seat!" )
            end 
        else
            local playerPos = GetEntityCoords( ped, 1 )
            local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords( ped, 0.0, distanceToCheck, 0.0 )
            local vehicle = GetVehicleInDirection( playerPos, inFrontOfPlayer )

            if ( DoesEntityExist( vehicle ) ) then 
                SetEntityAsMissionEntity( vehicle, true, true )
                deleteCar( vehicle )

                if ( DoesEntityExist( vehicle ) ) then 
                	ShowNotification( "~r~Unable to delete vehicle, try again." )
                else 
                	ShowNotification( "Vehicle deleted." )
                end 
            else 
                ShowNotification( "You must be in or near a vehicle to delete it." )
            end 
        end 
    end 
end )

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

-- Shows a notification on the player's screen 
function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

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

local fakecar = {model = '', car = nil}
local vehshop_locations = {
{entering = {-30.026309967042,-1105.0656738282,26.422369003296}, inside = {-75.28823852539,-819.08709716796,326.17541503906}, outside = {-29.130708694458,-1081.6518554688,26.638877868652}},
}

local vehshop_blips ={}
local inrangeofvehshop = false
local currentlocation = nil
local boughtcar = false


function vehPrs_drawTxt(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function vehSR_drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end

function vehSR_IsPlayerInRangeOfVehshop()
	return inrangeofvehshop
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
if firstspawn == 0 then
	--326 car blip 227 225
	vehSR_ShowVehshopBlips(true)
	firstspawn = 1
end
end)

function vehSR_ShowVehshopBlips(bool)
	if bool and #vehshop_blips == 0 then
		for station,pos in pairs(vehshop_locations) do
			local loc = pos
			pos = pos.entering
			local blip = AddBlipForCoord(pos[1],pos[2],pos[3])
			-- 60 58 137
			SetBlipSprite(blip,326)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Showroom")
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(vehshop_blips, {blip = blip, pos = loc})
		end
		Citizen.CreateThread(function()
			while #vehshop_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				for i,b in ipairs(vehshop_blips) do
					if IsPlayerWantedLevelGreater(GetPlayerIndex(),0) == false and vehshop.opened == false and IsPedInAnyVehicle(vehSR_LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(vehSR_LocalPed())) < 2.5 then
						--DrawMarker(36,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3]-0.2,0,0,0,0,0,0,0.5,0.3,0.5,0,155,255,150,0,true,0,true)
						vehPrs_drawTxt("Press ~INPUT_CELLPHONE_SELECT~ to talk to the ~r~Sales Agent")
						currentlocation = b
						inrange = true
					end
				end
				inrangeofvehshop = inrange
			end
		end)
	elseif bool == false and #vehshop_blips > 0 then
		for i,b in ipairs(vehshop_blips) do
			if DoesBlipExist(b.blip) then
				SetBlipAsMissionCreatorBlip(b.blip,false)
				Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
			end
		end
		vehshop_blips = {}
	end
end

vehSR_ShowVehshopBlips(true)

function vehSR_f(n)
	return n + 0.0001
end

function vehSR_LocalPed()
	return GetPlayerPed(-1)
end

function vehSR_try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end
function vehSR_firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
--local veh = nil
function vehSR_OpenCreator()
	boughtcar = false
	local ped = vehSR_LocalPed()
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	SetEntityVisible(ped,false)
	vehshop.currentmenu = "main"
	vehshop.opened = true
	vehshop.selectedbutton = 0
end

local vehicle_price = 0
function vehSR_CloseCreator(vehicle,veh_type)
	Citizen.CreateThread(function()
		local ped = vehSR_LocalPed()
		if not boughtcar then
			local pos = currentlocation.pos.entering
			SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			SetEntityVisible(ped,true)
			vRP.teleport({-39.77363204956,-1110.4862060546,26.438457489014})
			SetEntityHeading(ped, 180.0)
			scaleform = nil
		else
			deleteVehiclePedIsIn()
			vRP.teleport({-39.77363204956,-1110.4862060546,26.438457489014})
			SetEntityHeading(ped, 180.0)
			--vRPg.spawnBoughtVehicle({veh_type, vehicle})
			SetEntityVisible(ped,true)
			FreezeEntityPosition(ped,false)
		end
		vehshop.opened = false
		vehshop.menu.from = 1
		vehshop.menu.to = 10
	end)
end

function vehSR_drawMenuButton(button,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function vehSR_drawMenuTitle(txt,x,y)
local menu = vehshop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

simeonX, simeonY, simeonZ = -30.41927909851, -1106.771118164, 26.25236328125

function DrawText3D(x,y,z, text, scl) 

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(1)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
	simeon = 1283141381
	RequestModel( simeon )
	while ( not HasModelLoaded( simeon ) ) do
		Citizen.Wait( 1 )
	end
	theSimeon = CreatePed(4, simeon, simeonX, simeonY, simeonZ, 90, false, false)
	SetModelAsNoLongerNeeded(simeon)
	SetEntityHeading(theSimeon, -15.0)
	FreezeEntityPosition(theSimeon, true)
	SetEntityInvincible(theSimeon, true)
	SetBlockingOfNonTemporaryEvents(theSimeon, true)
	TaskStartScenarioAtPosition(theSimeon, "PROP_HUMAN_SEAT_BENCH", simeonX, simeonY, simeonZ-0.35, GetEntityHeading(theSimeon), 0, 0, false)
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, simeonX, simeonY, simeonZ) < 5.5)then
			DrawText3D(simeonX, simeonY, simeonZ+0.8, "~r~Sales Agent", 1.2)
		end
		Citizen.Wait(0)
	end
end)


function vehSR_tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
function vehSR_Notify(text)
SetNotificationTextEntry('STRING')
AddTextComponentString(text)
DrawNotification(false, false)
end

function vehSR_drawMenuRight(txt,x,y,selected)
	local menu = vehshop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.06, y - menu.height/2 + 0.0028)
end
scaleform = nil
function Initialize(scaleform, price, vehName, speed, acce, brake, trac)
	scaleform = RequestScaleformMovie(scaleform)
	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(0)
	end
	PushScaleformMovieFunction(scaleform, "SET_VEHICLE_INFOR_AND_STATS")
	PushScaleformMovieFunctionParameterString(vehName)
	PushScaleformMovieFunctionParameterString(price)
	PushScaleformMovieFunctionParameterString("MPCarHUD")
	PushScaleformMovieFunctionParameterString("Benefactor")
	PushScaleformMovieFunctionParameterString("Speed")
	PushScaleformMovieFunctionParameterString("Acceleration")
	PushScaleformMovieFunctionParameterString("Brakes")
	PushScaleformMovieFunctionParameterString("Traction")
	PushScaleformMovieFunctionParameterInt(speed or 100)
	PushScaleformMovieFunctionParameterInt(acce or 100)
	PushScaleformMovieFunctionParameterInt(brake or 100)
	PushScaleformMovieFunctionParameterInt(trac or 100)
	PopScaleformMovieFunctionVoid()
	return scaleform
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(fakecar.model ~= nil) and (scaleform ~= nil)then
			local x = 0.67
			local y = 0.52
			local width = 0.65
			local height = width / 0.68
			DrawScaleformMovie(scaleform, x, y, width, height)
		end
	end
end)

function showroom_drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

testDriveCar = nil
testDriveSeconds = 60
isInTestDrive = false
isInCar = false

function destroyTestDriveCar()
	if(testDriveCar ~= nil)then
		if(DoesEntityExist(testDriveCar))then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(testDriveCar))
		end
		testDriveCar = nil
		isInTestDrive = false
	end
	testDriveSeconds = 60
	vRP.teleport({-39.77363204956,-1110.4862060546,26.438457489014})
	SetEntityHeading(GetPlayerPed(-1), 180.0)
	vRP.notify({"~r~The test drive is over!"})
end

AddEventHandler("playerDropped", function()
	if(testDriveCar ~= nil)then
		destroyTestDriveCar()
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1100)
		if(testDriveCar ~= nil) and (isInTestDrive == false) then
			isInTestDrive = true
		else
			isInTestDrive = false
		end
		if(testDriveCar ~= nil)then
			local IsInVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			if(IsInVehicle ~= nil)then
				if(testDriveCar == IsInVehicle)then
					if(testDriveSeconds > 0)then
						testDriveSeconds = testDriveSeconds - 1
					else
						destroyTestDriveCar()
					end
					isInCar = true
				else
					isInCar = false
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(testDriveSeconds < 60)then
			showroom_drawTxt(1.30, 1.40, 1.0,1.0,0.35, "~g~TestDrive: ~r~"..testDriveSeconds.." ~y~Seconds", 255, 255, 255, 255)
		end
		if(isInTestDrive) then
			if(isInCar == false)then
				destroyTestDriveCar()
			end
		end
	end
end)

carPrice = "$0"
local backlock = false
Citizen.CreateThread(function()
	local last_dir
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,201) and vehSR_IsPlayerInRangeOfVehshop() then
			if vehshop.opened then
				vehSR_CloseCreator("","")
			else
				vehSR_OpenCreator()
			end
		end
		if vehshop.opened then
			showroom_drawTxt(0.5, 1.073, 1.0,1.0,0.4, "~r~[ENTER] ~p~-> ~b~Purchase vehicle", 255, 255, 255, 255)
			showroom_drawTxt(0.5, 1.1, 1.0,1.0,0.4, "~r~[E] ~p~-> ~g~Load vehicle texture", 255, 255, 255, 255)
			showroom_drawTxt(0.5, 1.13, 1.0,1.0,0.4, "~r~[F] ~p~-> ~y~Test Drive vehicle", 255, 255, 255, 255)
			local ped = vehSR_LocalPed()
			local menu = vehshop.menu[vehshop.currentmenu]
			vehSR_drawTxt(vehshop.title,1,1,vehshop.menu.x,vehshop.menu.y,1.0, 255,255,255,255)
			vehSR_drawMenuTitle(menu.title, vehshop.menu.x,vehshop.menu.y + 0.08)
			vehSR_drawTxt(vehshop.selectedbutton.."/"..vehSR_tablelength(menu.buttons),0,0,vehshop.menu.x + vehshop.menu.width/2 - 0.0385,vehshop.menu.y + 0.067,0.4, 255,255,255,255)
			local y = vehshop.menu.y + 0.12
			buttoncount = vehSR_tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= vehshop.menu.from and i <= vehshop.menu.to then

					if i == vehshop.selectedbutton then
						selected = true
					else
						selected = false
					end
					vehSR_drawMenuButton(button,vehshop.menu.x,y,selected)
					if button.costs ~= nil then
						if vehshop.currentmenu == "audi" or vehshop.currentmenu == "bmw" or vehshop.currentmenu == "suv-offroad" or vehshop.currentmenu == "gang-cars" or vehshop.currentmenu == "hitman" or vehshop.currentmenu == "truck" or vehshop.currentmenu == "thelostmc" or vehshop.currentmenu == "mercedesbenz" or vehshop.currentmenu == "ferrari" or vehshop.currentmenu == "fast-and-furios" or vehshop.currentmenu == "dacia" or vehshop.currentmenu == "lamborghini" or vehshop.currentmenu == "Aston Martin" or vehshop.currentmenu == "Porche" or vehshop.currentmenu == "Toyota" or vehshop.currentmenu == "cars5" or vehshop.currentmenu == "bikes" or vehshop.currentmenu == "altele" or vehshop.currentmenu == "motociclete" or vehshop.currentmenu == "cop" or vehshop.currentmenu == "fbi" or vehshop.currentmenu == "fisher" or vehshop.currentmenu == "weazelnews" or vehshop.currentmenu == "ems" or vehshop.currentmenu == "uber" or vehshop.currentmenu == "lawyer" or vehshop.currentmenu == "delivery" or vehshop.currentmenu == "repair" or vehshop.currentmenu == "bankdriver" or vehshop.currentmenu == "medicalweed" or vehshop.currentmenu == "vip" or vehshop.currentmenu == "avivip" or vehshop.currentmenu == "helivip" or vehshop.currentmenu == "swat" then
							vehSR_drawMenuRight("$"..button.costs,vehshop.menu.x,y,selected)
							carPrice = "$"..button.costs
						else
							vehSR_drawMenuButton(button,vehshop.menu.x,y,selected)
						end
					end
					y = y + 0.04
					if vehshop.currentmenu == "audi" or vehshop.currentmenu == "bmw" or vehshop.currentmenu == "suv-offroad" or vehshop.currentmenu == "gang-cars" or vehshop.currentmenu == "hitman" or vehshop.currentmenu == "truck" or vehshop.currentmenu == "thelostmc" or vehshop.currentmenu == "mercedesbenz" or vehshop.currentmenu == "ferrari" or vehshop.currentmenu == "fast-and-furios" or vehshop.currentmenu == "dacia" or vehshop.currentmenu == "lamborghini" or vehshop.currentmenu == "Aston Martin" or vehshop.currentmenu == "Porche" or vehshop.currentmenu == "Toyota" or vehshop.currentmenu == "cars5" or vehshop.currentmenu == "bikes" or vehshop.currentmenu == "altele" or vehshop.currentmenu == "motociclete" or vehshop.currentmenu == "cop" or vehshop.currentmenu == "fbi" or vehshop.currentmenu == "fisher" or vehshop.currentmenu == "weazelnews" or vehshop.currentmenu == "ems" or vehshop.currentmenu == "uber" or vehshop.currentmenu == "lawyer" or vehshop.currentmenu == "delivery" or vehshop.currentmenu == "repair" or vehshop.currentmenu == "bankdriver" or vehshop.currentmenu == "medicalweed" or vehshop.currentmenu == "vip" or vehshop.currentmenu == "avivip" or vehshop.currentmenu == "helivip" or vehshop.currentmenu == "swat"  then
						if selected then
							hash = GetHashKey(button.model)
							if IsControlJustPressed(1,23) then
								if(testDriveCar == nil)then
									if DoesEntityExist(fakecar.car) then
										Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
										scaleform = nil
									end
									fakecar = {model = '', car = nil}
									while not HasModelLoaded(hash) do
										RequestModel(hash)
										Citizen.Wait(10)
										showroom_drawTxt(0.935, 0.575, 1.0,1.0,0.4, "~r~LOADING VEHICLE TEXTURE", 255, 255, 255, 255)
									end
									if HasModelLoaded(hash) then
										testDriveCar = CreateVehicle(hash,-914.83026123046,-3287.1538085938,13.521618843078,60.962993621826,false,false)
										SetModelAsNoLongerNeeded(hash)
										TaskWarpPedIntoVehicle(GetPlayerPed(-1),testDriveCar,-1)
										vRP.notify({"~g~You have ~r~1 Minute~g~ to test drive this vehicle!"})
										for i = 0,24 do
											SetVehicleModKit(testDriveCar,0)
											RemoveVehicleMod(testDriveCar,i)
										end
										if(testDriveCar)then
											vehshop.opened = false
											vehshop.menu.from = 1
											vehshop.menu.to = 10
											SetEntityVisible(GetPlayerPed(-1),true)
											FreezeEntityPosition(GetPlayerPed(-1),false)
											scaleform = nil
										end
									end
								end
							end
							if fakecar.model ~= button.model then
								if IsControlJustPressed(1,38) then
									if DoesEntityExist(fakecar.car) then
										Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
										scaleform = nil
									end
									local pos = currentlocation.pos.inside									
									local i = 0
									while not HasModelLoaded(hash) and i < 500 do
										RequestModel(hash)
										Citizen.Wait(10)
										i = i+1
										showroom_drawTxt(0.935, 0.575, 1.0,1.0,0.4, "~r~LOADING VEHICLE TEXTURE", 255, 255, 255, 255)
									end

									-- spawn car
									if HasModelLoaded(hash) then
									--if timer < 255 then
										veh = CreateVehicle(hash,pos[1],pos[2],pos[3],pos[4],false,false)
										FreezeEntityPosition(veh,true)
										SetEntityInvincible(veh,true)
										SetVehicleDoorsLocked(veh,4)
										SetModelAsNoLongerNeeded(hash)
										--SetEntityCollision(veh,false,false)
										TaskWarpPedIntoVehicle(vehSR_LocalPed(),veh,-1)
										for i = 0,24 do
											SetVehicleModKit(veh,0)
											RemoveVehicleMod(veh,i)
										end
										fakecar = { model = button.model, car = veh}
										Citizen.CreateThread(function()
											while DoesEntityExist(veh) do
												Citizen.Wait(25)
												SetEntityHeading(veh, GetEntityHeading(veh)+1 %360)
											end
										end)

										scaleform = Initialize("mp_car_stats_01", carPrice, button.name, button.speed, button.acce, button.brake, button.trac)
									else
										if last_dir then
											if vehshop.selectedbutton < buttoncount then
												vehshop.selectedbutton = vehshop.selectedbutton +1
												if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
													vehshop.menu.to = vehshop.menu.to + 1
													vehshop.menu.from = vehshop.menu.from + 1
												end
											else
												last_dir = false
												vehshop.selectedbutton = vehshop.selectedbutton -1
												if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
													vehshop.menu.from = vehshop.menu.from -1
													vehshop.menu.to = vehshop.menu.to - 1
												end
											end
										else
											if vehshop.selectedbutton > 1 then
												vehshop.selectedbutton = vehshop.selectedbutton -1
												if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
													vehshop.menu.from = vehshop.menu.from -1
													vehshop.menu.to = vehshop.menu.to - 1
												end
											else
												last_dir = true
												vehshop.selectedbutton = vehshop.selectedbutton +1
												if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
													vehshop.menu.to = vehshop.menu.to + 1
													vehshop.menu.from = vehshop.menu.from + 1
												end
											end
										end
									end
								end
							end
						end
					end
					if selected and IsControlJustPressed(1,201) then
						vehSR_ButtonSelected(button)
					end
				end
			end
			if IsControlJustPressed(1,202) then
				vehSR_Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				last_dir = false
				if vehshop.selectedbutton > 1 then
					vehshop.selectedbutton = vehshop.selectedbutton -1
					if buttoncount > 10 and vehshop.selectedbutton < vehshop.menu.from then
						vehshop.menu.from = vehshop.menu.from -1
						vehshop.menu.to = vehshop.menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				last_dir = true
				if vehshop.selectedbutton < buttoncount then
					vehshop.selectedbutton = vehshop.selectedbutton +1
					if buttoncount > 10 and vehshop.selectedbutton > vehshop.menu.to then
						vehshop.menu.to = vehshop.menu.to + 1
						vehshop.menu.from = vehshop.menu.from + 1
					end
				end
			end
		end

	end
end)


function vehSR_round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
function vehSR_ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = vehshop.currentmenu
	local btn = button.name
	if this == "main" then
		if btn == "cars" then
			vehSR_OpenMenu('cars')
		elseif btn == "suv-offroad" then
			vehSR_OpenMenu('suv-offroad')
		elseif btn == "bikes" then
			vehSR_OpenMenu('bikes')
		elseif btn == "motociclete" then
			vehSR_OpenMenu('motociclete')
		elseif btn == "job" then
			vehSR_OpenMenu('job')
		elseif btn == "gang-cars" then
			vehSR_OpenMenu('gang-cars')
		elseif btn == "hitman" then
			vehSR_OpenMenu('hitman')
		elseif btn == "truck" then
			vehSR_OpenMenu('truck')
	    elseif btn == "thelostmc" then
		    vehSR_OpenMenu('thelostmc')
		elseif btn == "vip" then
			vehSR_OpenMenu('vip')
		elseif btn == "aviation" then
			vehSR_OpenMenu('aviation')
		end
	elseif this == "cars" then
		if btn == "audi" then
			vehSR_OpenMenu('audi')
		elseif btn == "bmw" then
			vehSR_OpenMenu('bmw')
		elseif btn == "mercedesbenz" then
			vehSR_OpenMenu('mercedesbenz')
		elseif btn == "ferrari" then
			vehSR_OpenMenu('ferrari')
		elseif btn == "fast-and-furios" then
			vehSR_OpenMenu('fast-and-furios')
		elseif btn == "dacia" then
			vehSR_OpenMenu("dacia")
		elseif btn == "lamborghini" then
			vehSR_OpenMenu('lamborghini')
		elseif btn == "Aston Martin" then
			vehSR_OpenMenu('Aston Martin')
		elseif btn == "Porche" then
			vehSR_OpenMenu('Porche')
		elseif btn == "Toyota" then
			vehSR_OpenMenu('Toyota')
		elseif btn == "cars5" then
			vehSR_OpenMenu('cars5')
		elseif btn == "altele" then
			vehSR_OpenMenu('altele')
		end
	elseif this == "job" then
		if btn == "swat" then
			vehSR_OpenMenu('swat')
		elseif btn == "cop" then
			vehSR_OpenMenu('cop')
		elseif btn == "fbi" then
			vehSR_OpenMenu('fbi')
		elseif btn == "fisher" then
			vehSR_OpenMenu('fisher')
		elseif btn == "weazelnews" then
			vehSR_OpenMenu('weazelnews')
		elseif btn == "ems" then
			vehSR_OpenMenu('ems')
		elseif btn == "uber" then
			vehSR_OpenMenu('uber')
		elseif btn == "lawyer" then
			vehSR_OpenMenu('lawyer')
		elseif btn == "delivery" then
			vehSR_OpenMenu("delivery")
		elseif btn == "repair" then
			vehSR_OpenMenu('repair')
		elseif btn == "bankdriver" then
			vehSR_OpenMenu('bankdriver')
		elseif btn == "medicalweed" then
			vehSR_OpenMenu('medicalweed')
		end
	elseif this == "aviation" then
		if btn == "avivip" then
			vehSR_OpenMenu('avivip')
		elseif btn == "helivip" then
			vehSR_OpenMenu('helivip')
		end
	elseif this == "audi" or this == "bmw" or this == "suv-offroad" or this == "mercedesbenz" or this == "ferrari" or this == "gang-cars" or this == "hitman" or this == "truck" or this == "thelostmc" or this == "fast-and-furios" or this == "dacia" or this == "lamborghini" or this == "Aston Martin" or this == "Porche" or this == "Toyota" or this == "cars5" or this == "bikes" or this == "altele" or this == "cop" or this == "swat" or this == "fbi" or this == "fisher" or this == "weazelnews" or this == "ems" or this == "uber" or this == "lawyer" or this == "delivery" or this == "repair" or this == "bankdriver" or this == "medicalweed" or this == "vip" or this == "avivip" or this == "helivip" or this == "swat" then
		TriggerServerEvent('veh_SR:CheckMoneyForVeh',this,button.model,button.costs,"car",false,false)
	elseif  this == "motociclete" then
		TriggerServerEvent('veh_SR:CheckMoneyForVeh',this,button.model,button.costs,"bike",false,false)
	end
end

RegisterNetEvent('veh_SR:CloseMenu')
AddEventHandler('veh_SR:CloseMenu', function(vehicle, veh_type)
	boughtcar = true
	vehSR_CloseCreator(vehicle,veh_type)
	scaleform = nil
end)

function vehSR_OpenMenu(menu)
	fakecar = {model = '', car = nil}
	vehshop.lastmenu = vehshop.currentmenu
	if menu == "cars" then
		vehshop.lastmenu = "main"
	elseif menu == "suv-offroad"  then
		vehshop.lastmenu = "main"
	elseif menu == "motociclete"  then
		vehshop.lastmenu = "main"
	elseif menu == "gang-cars"  then
		vehshop.lastmenu = "main"
	elseif menu == "hitman"  then
		vehshop.lastmenu = "main"
	elseif menu == "truck"  then
		vehshop.lastmenu = "main"
	elseif menu == "thelostmc"  then
		vehshop.lastmenu = "main"
    elseif menu == "bikes"  then
		vehshop.lastmenu = "main"
	elseif menu == "job"  then
		vehshop.lastmenu = "main"
	elseif menu == "vip"  then
		vehshop.lastmenu = "main"
	elseif menu == "aviation"  then
		vehshop.lastmenu = "main"
	elseif menu == 'race_create_objects' then
		vehshop.lastmenu = "main"
	elseif menu == "race_create_objects_spawn" then
		vehshop.lastmenu = "race_create_objects"
	end
	vehshop.menu.from = 1
	vehshop.menu.to = 10
	vehshop.selectedbutton = 0
	vehshop.currentmenu = menu
end


function vehSR_Back()
	if backlock then
		return
	end
	backlock = true
	if vehshop.currentmenu == "main" then
		vehSR_CloseCreator("","")
	elseif vehshop.currentmenu == "audi" or vehshop.currentmenu == "bmw" or vehshop.currentmenu == "suv-offroad" or vehshop.currentmenu == "gang-cars" or vehshop.currentmenu == "hitman" or vehshop.currentmenu == "truck" or vehshop.currentmenu == "thelostmc" or vehshop.currentmenu == "mercedesbenz" or vehshop.currentmenu == "ferrari" or vehshop.currentmenu == "fast-and-furios" or vehshop.currentmenu == "dacia" or vehshop.currentmenu == "lamborghini" or vehshop.currentmenu == "Aston Martin" or vehshop.currentmenu == "Porche" or vehshop.currentmenu == "Toyota" or vehshop.currentmenu == "cars5" or vehshop.currentmenu == "bikes" or vehshop.currentmenu == "altele" or vehshop.currentmenu == "motociclete" or vehshop.currentmenu == "cop" or vehshop.currentmenu == "swat" or vehshop.currentmenu == "fisher" or vehshop.currentmenu == "weazelnews" or vehshop.currentmenu == "fbi" or vehshop.currentmenu == "ems" or vehshop.currentmenu == "uber" or vehshop.currentmenu == "lawyer" or vehshop.currentmenu == "delivery" or vehshop.currentmenu == "repair" or vehshop.currentmenu == "bankdriver" or vehshop.currentmenu == "medicalweed" or vehshop.currentmenu == "vip" or vehshop.currentmenu == "aviation" then
		if DoesEntityExist(fakecar.car) then
			Citizen.InvokeNative(0xEA386986E786A54F, Citizen.PointerValueIntInitialized(fakecar.car))
			scaleform = nil
		end
		fakecar = {model = '', car = nil}
		vehSR_OpenMenu(vehshop.lastmenu)
	else
		vehSR_OpenMenu(vehshop.lastmenu)
	end

end

function vehSR_stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end