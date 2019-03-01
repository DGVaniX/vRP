--[[
========================================================
=============== PROJECT: vRP Gym =======================
=============== SCRIPTER: DGVaniX ======================
=============== DATE: 03/11/2018 =======================
========================================================
]]

vRPgymC = {}
Tunnel.bindInterface("vRP_gym",vRPgymC)
Proxy.addInterface("vRP_gym",vRPgymC)
vRP = Proxy.getInterface("vRP")
vRPserver = Tunnel.getInterface("vRP_gym","vRP_gym")

gymTable = nil
theGym = nil

incircle = false
inWorkout = false
flexing = false

workDone = 0

function vRPgymC.populateGymTable(theWorkouts, gym)
	gymTable = theWorkouts
	theGym = gym
end

function gym_DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

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
	while true do
		Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, -1212.3618, -1576.8405, 4.1115) < 10.0)then
			DrawText3D(-1212.3618, -1576.8405, 4.1115+0.4, "~y~Flex", 1.2)
			DrawMarker(21, -1212.3618, -1576.8405, 4.1115, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 0, 255, 0, 0, 0, 1)
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, -1212.3618, -1576.8405, 4.1115) < 0.25)then
				incircle = true
				if(incircle == true) then
					if(flexing == false)then
						gym_DisplayHelpText("Press ~INPUT_CONTEXT~ to ~g~Flex Muscles")
						if(IsControlJustReleased(1, 51))then
							flexing = true
							TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_MUSCLE_FLEX", 0, true)
						end
					end
				end
			elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, -1212.3618, -1576.8405, 4.1115) > 0.25)then
				incircle = false
			end
			if(flexing == true)then
				gym_DisplayHelpText("Press ~INPUT_CONTEXT_SECONDARY~ to stop flexing")
				if(IsControlJustReleased(1, 44))then
					ClearPedTasksImmediately(GetPlayerPed(-1))
					flexing = false
				end
			end
		end
		if(theGym ~= nil)then
			if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, theGym[1], theGym[2], theGym[3]) < 10.0)then
				DrawText3D(theGym[1], theGym[2], theGym[3]+0.4, "~y~Gym Shop", 1.2)
				DrawMarker(21, theGym[1], theGym[2], theGym[3], 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 255, 255, 0, 255, 0, 0, 0, 1)
				if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, theGym[1], theGym[2], theGym[3]) < 1.0)then
					incircle = true
					if(incircle == true) then
						gym_DisplayHelpText("Press ~INPUT_CONTEXT~ to access the ~g~Gym Shop")
						if(IsControlJustReleased(1, 51))then
							inGymCircle = true
							TriggerServerEvent("showGymMenu")
						end
					end
				elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, theGym[1], theGym[2], theGym[3]) > 1.0)then
					incircle = false
				end
			end
		end
		
		if(gymTable ~= nil)then
			for i, v in pairs(gymTable) do
				x, y, z = v[1], v[2], v[3]
				if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 18.0)then
					DrawText3D(x,y,z+0.4, "~y~"..v[4], 1.2)
					DrawMarker(21, x, y, z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 153, 255, 255, 0, 0, 0, 1)
					if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) < 0.25)then
						incircle = true
						if(incircle == true) then
							if(inWorkout == false)then
								gym_DisplayHelpText("Press ~INPUT_CONTEXT~ to ~g~"..v[4])
								if(IsControlJustReleased(1, 51))then
									vRPserver.hasMembership({}, function(membership)
										if(membership)then
											vRPserver.initWorkout({i})
										else
											vRP.notify({"~w~[GYM] ~r~You don't have a gym membership!"})
										end
									end)
								end
							end
						end
					elseif(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, x, y, z) > 0.25)then
						incircle = false
					end
					if(inWorkout == true)then
						gym_DisplayHelpText("Press ~INPUT_CONTEXT_SECONDARY~ to stop the exercise")
						if(IsControlJustReleased(1, 44))then
							ClearPedTasksImmediately(GetPlayerPed(-1))
							inWorkout = false
							workDone = 0
						end
					end
				end
			end
		end
	end
end)

function round(x, n)
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end

function randomFloat(lower, greater)
	x = lower + math.random()  * (greater - lower);
	result = string.format("%0.1f", x)
    return result
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		if(inWorkout) and (workDone < 5)then
			workDone = workDone + 1
			strenght = randomFloat(0.19, 1.5)
			vRPserver.gainStrenght({strenght})
			vRP.notify({"~g~You feel your muscles pump and your arms getting sore!"})
		end
	end
end)

function vRPgymC.startWorkout(workout)
	if(inWorkout == false)then
		inWorkout = true		
		--[[if(workout == "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS")then
			coords = GetEntityCoords(GetPlayerPed(-1))
			TaskStartScenarioAtPosition(GetPlayerPed(-1), "PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS", coords.x, coords.y, coords.z-0.1, GetEntityHeading(GetPlayerPed(-1)), 0, 0, false)
		else]]
			TaskStartScenarioInPlace(GetPlayerPed(-1), workout, 0, true)
		--end
	end
end