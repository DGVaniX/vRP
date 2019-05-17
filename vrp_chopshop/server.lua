local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

cfg = module("vrp_remat", "cfg/vehicles")

vRP = Proxy.getInterface("vRP")
vRPSremat = {}
Tunnel.bindInterface("vRP_remat",vRPSremat)
Proxy.addInterface("vRP_remat",vRPSremat)
vRPclient = Tunnel.getInterface("vRP","vRP_remat")
vRPCremat = Tunnel.getInterface("vRP_remat","vRP_remat")

MySQL = module("vrp_mysql", "MySQL")

MySQL.createCommand("vRP/remat_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
MySQL.createCommand("vRP/remat_get_vehicle","SELECT vehicle FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	vRPclient.addBlip(source,{-45.0849609375,-1081.6473388672,26.687330245972, 68, 49, "ChopShop"})
end)

function vRPSremat.checkVehPrice(vehicle)
	vehicles = cfg.vehicles
	if(vehicle == "")then
		TriggerClientEvent('chatMessage', source, "[ChopShop] ^1You can only chop your own personal vehicle!")
	else
		for i, v in pairs(vehicles) do
			if(i == vehicle)then
				vehName = v[1]
				vehPrice = v[2]
				TriggerClientEvent('chatMessage', source, "[ChopShop] ^2To sell this ^5"..vehName.." ^2 for ^5$"..vehPrice.." ^2type ^1/sellveh")
				break
			end
		end
	end
end

function vRPSremat.sellTheVehicle(vehicle, vtype)
	user_id = vRP.getUserId({source})
	thePlayer = vRP.getUserSource({user_id})
	vehicles = cfg.vehicles
	MySQL.query("vRP/remat_get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicles, affected)
		if #pvehicles > 0 then
			for i, v in pairs(vehicles) do
				if(i == vehicle)then
					MySQL.execute("vRP/remat_vehicle", {user_id = user_id, vehicle = vehicle})
					vehName = v[1]
					vehPrice = v[2]
					vRP.giveMoney({user_id, vehPrice})
					TriggerClientEvent('chatMessage', thePlayer, "[ChopShop] ^2You sold your ^5"..vehName.." ^2 for ^5$"..vehPrice)
					vRPclient.despawnGarageVehicle(thePlayer, {vtype,15})
					break
				end
			end
		end
	end)
end