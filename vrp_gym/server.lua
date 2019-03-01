--[[
========================================================
=============== PROJECT: vRP Gym =======================
=============== SCRIPTER: DGVaniX ======================
=============== DATE: 03/11/2018 =======================
========================================================
]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_gym")
vRPCgym = Tunnel.getInterface("vRP_gym","vRP_gym")

vRPgym = {}
Tunnel.bindInterface("vRP_gym",vRPgym)
Proxy.addInterface("vRP_gym",vRPgym)

members = {}

gymTable = {
	["biceps1"] = {-1198.9050, -1564.1252, 4.1115, "Z-Bar (Biceps)"},
	["abdo"] = {-1197.7672, -1571.3300, 4.1115, "Crunches"},
	["biceps2"] = {-1210.0610, -1560.6418, 4.1115, "Z-Bar (Biceps)"},
	["yoga"] = {-1204.2547, -1556.8259, 4.1115, "Yoga"},
	["tractiuni1"] = {-1200.1284, -1570.9903, 4.1115, "Pull-Ups"},
	["tractiuni2"] = {-1204.7150, -1564.3831, 4.1115, "Pull-Ups"},
	["flotari"] = {-1194.1945, -1570.1912, 4.1115, "Push-Ups"},
	["bench1"] = {-1197.1033, -1567.5870, 4.1115, "Bench"},
	["bench2"] = {-1200.6325, -1575.8344, 4.1115, "Bench"},
	["bench3"] = {-1206.4871, -1561.5948, 4.1115, "Bench"},
	["bench4"] = {-1201.4362, -1562.7670, 4.1115, "Bench"}
}

theGym = {-1195.4376, -1577.6749, 4.1115}

workouts = {
	["PROP_HUMAN_MUSCLE_CHIN_UPS"] = {"tractiuni1", "tractiuni2"},
	["WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"] = {"biceps1", "biceps2"},
	["WORLD_HUMAN_SIT_UPS"] = {"abdo"},
	["WORLD_HUMAN_YOGA"] = {"yoga"},
	["WORLD_HUMAN_PUSH_UPS"] = {"flotari"},
	["PROP_HUMAN_SEAT_MUSCLE_BENCH_PRESS"] = {"bench1", "bench2", "bench3", "bench4"}
}

gym_menu = {name="Gym Shop",css={top="75px", header_color="rgba(0,125,255,0.75)"}}

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		thePlayer = vRP.getUserSource({user_id})
		vRPCgym.populateGymTable(thePlayer, {gymTable, theGym})
	end
end)

function vRPgym.initWorkout(workout)
	thePlayer = source
	for i, v in pairs(workouts) do
		workTable = v
		for k, vl in pairs(workTable) do
			if(vl == workout)then
				vRPCgym.startWorkout(thePlayer, {i})
				break
			end
		end
	end
end

function vRPgym.gainStrenght(strenght)
	user_id = vRP.getUserId({source})
	
	local parts = splitString("physical.strength",".")
    if #parts == 2 then
        vRP.varyExp({user_id,parts[1],parts[2],tonumber(strenght)})
    end
end

function vRPgym.hasMembership()
	thePlayer = source
	user_id = vRP.getUserId({thePlayer})
	if(user_id ~= nil)then
		if(members[user_id] == true)then
			return true
		else
			return false
		end
	end
end

function buyMembership(player, choice)
	user_id = vRP.getUserId({player})
	if(members[user_id] ~= true)then
		if(vRP.tryPayment({user_id, 1500}))then
			members[user_id] = true
			vRPclient.notify(player, {"~w~[GYM] ~g~You paid $1500 for a 1 day gym membership! You can now use the gym's utilities!"})
		else
			vRPclient.notify(player, {"~w~[GYM] ~r~You don't have enough money for a membership"})
		end
	else
		vRPclient.notify(player, {"~w~[GYM] ~r~You already have a gym membership"})
	end
	vRP.closeMenu({player})
end

function cancelMembership(player, choice)
	user_id = vRP.getUserId({player})
	if(members[user_id] == true)then
		members[user_id] = false
		vRPclient.notify(player, {"~w~[GYM] ~g~You canceled your gym membership"})
	else
		vRPclient.notify(player, {"~w~[GYM] ~r~You don't have a gym membership!"})
	end
	vRP.closeMenu({player})
end



RegisterServerEvent("showGymMenu")
AddEventHandler("showGymMenu", function()
	thePlayer = source
	if(members[user_id] ~= true)then
		gym_menu["Open Membership"] = {buyMembership, "Buy a gym membership for 1 day<br>Price: <font color='red'>$1500</font>"}
		gym_menu["Cancel Membership"] = nil
	else
		gym_menu["Cancel Membership"] = {cancelMembership, "Cancel your membership"}
		gym_menu["Open Membership"] = nil
	end
	vRP.openMenu({thePlayer,gym_menu})
end)
