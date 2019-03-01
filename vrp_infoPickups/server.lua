--[[
========================================================
============ PROJECT: vRP InfoPickups===================
=============== SCRIPTER: DGVaniX ======================
=============== DATE: 13/02/2018 =======================
========================================================
]]

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")

cfg = module("vrp", "cfg/garages")

vehicles = cfg.garage_types

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_infoPickups")
vRPip = {}
Tunnel.bindInterface("vRP_infoPickups",vRPip)
Proxy.addInterface("vRP_infoPickups",vRPip)
vRPipCl = Tunnel.getInterface("vRP_infoPickups","vRP_infoPickups")

MySQL.createCommand("vRP/get_all_users","SELECT * FROM vrp_users ORDER BY id DESC LIMIT 1")

infoPickupsCoords = {
	[1] = {"Total Users",-543.7133178711,-213.69314575196,37.649806976318},
	[2] = {"Online Players", -542.79602050782,-215.35415649414,37.649803161622},
	[3] = {"~g~Welcome to ~r~Server ~b~Name", -533.99639892578,-223.13551330566,37.64977645874},
	[4] = {"", -541.74822998046,-217.162399292,37.649803161622},
	[5] = {"Vehicles List", -544.40100097656,-212.65077209473,37.649806976318}
}
theUsers = 0
theVehicles = 0

vehicles_menu = {name="Vehicles List",css={top="75px", header_color="rgba(0,125,255,0.75)"}}

local function dummyFunction(player, choice)
	return
end

function loadInfoPickups()
	for i, v in pairs(vehicles) do
		for ix, vx in pairs(v) do
			if(tostring(ix) ~= "_config")then
				vehName = tostring(vx[1])
				vehPrice = tonumber(vx[2])
				theVehicles = theVehicles + 1
				vehicles_menu[vehName] = {dummyFunction, "Showroom Price: <font color='red'>$"..vehPrice.."</font>"}
			end
		end
	end
	
	MySQL.query("vRP/get_all_users", {}, function(users, affected)
		if(#users > 0)then
			theUsers = users[1].id
		end
	end)
end

AddEventHandler("onResourceStart", function(res)
	if(res == "vrp_infoPickups")then
		Citizen.Wait(2000)
		loadInfoPickups()		
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	vRPipCl.setClientPickupData(source, {infoPickupsCoords, theUsers, theVehicles, factions})
end)

function vRPip.getAllUsers()
	MySQL.query("vRP/get_all_users", {}, function(users, affected)
		vRPipCl.populateUsers(-1,{users[1].id})
	end)
end

RegisterServerEvent("showVehiclesList")
AddEventHandler("showVehiclesList", function()
	thePlayer = source
	vRP.openMenu({thePlayer,vehicles_menu})
end)