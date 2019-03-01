local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")
cfg = module("vrp", "cfg/garages")
vehicles = cfg.garage_types

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_carcrusher")

vRPcc = {}
Tunnel.bindInterface("vRP_carcrusher",vRPcc)
Proxy.addInterface("vRP_carcrusher",vRPcc)
vRPccC = Tunnel.getInterface("vRP_carcrusher","vRP_carcrusher")

MySQL.createCommand("vRP/del_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	vRPclient.addBlip(source,{-421.03393554688, -1710.8310546875, 19.439516067504, 68, 49, "Vehicle Crusher"})
end)

RegisterServerEvent("crushVehicle")
AddEventHandler("crushVehicle", function(vtype, vname, vehPrice)
	local user_id = vRP.getUserId({source})
	vRPclient.despawnGarageVehicle(source,{vtype,15})
	MySQL.execute("vRP/del_vehicle", {user_id = user_id, vehicle = vname})
	vRPclient.notify(source, {"~w~[CRUSHER] ~g~You scrapped the vehicle and received ~r~$"..vehPrice})
	vRP.giveMoney({user_id, vehPrice})
end)

function vRPcc.getVehiclesPrices(vname)
	thePrice = 0
	vehName = ""
	for i, v in pairs(vehicles) do
		for ix, vx in pairs(v) do
			if(tostring(ix) ~= "_config") and (tostring(ix) == vname)then
				vehName = tostring(vx[1])
				thePrice = tonumber(vx[2])
				if(thePrice == nil) or (thePrice <= 0)then
					thePrice = 0
				else
					thePrice = math.ceil(thePrice*0.50)
				end
			end
		end
	end
	return thePrice, vehName
end