local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_cuffcutter")
vRPcc = Tunnel.getInterface("vRP_cuffcutter","vRP_cuffcutter")

cuffCutters = {
-- 	{Group, x, y, z}
	{"cosanostra", -857.53002929688, -21.677991867065, 40.559711456299},
	{"sicilia", -1503.2708740234,138.91636657714,55.653175354004}
}

RegisterServerEvent("cutCuffs")
AddEventHandler("cutCuffs", function()
	thePlayer = source
	cutChance = math.random(1, 10)
	vRPclient.notify(thePlayer, {"~w~[FLEX] ~g~Trying to cut cuffs..."})
	TriggerClientEvent('freezePlayer', thePlayer)
	SetTimeout(10000, function()
		if (cutChance <= 5) then
			vRPclient.setHandcuffed(thePlayer, {false})
			TriggerClientEvent('unfreezePlayer', thePlayer)
			vRPclient.notify(thePlayer, {"~w~[FLEX] ~g~Cuffs have been cut succesfully!"})
		else
			TriggerClientEvent('unfreezePlayer', thePlayer)
			vRPclient.notify(thePlayer, {"~w~[CUTTER] ~r~The electric cutter's disk has broken!"})
		end
	end)
end)

local function build_client_cutcuff(source)
	thePlayer = source
	for k, v in pairs(cuffCutters) do
		group = v[1]
		x = v[2]
		y = v[3]
		z = v[4]
		
		local function cuffCut_enter(source,area)
			local user_id = vRP.getUserId({source})
			if user_id ~= nil and vRP.hasGroup({user_id,group}) then
				vRPclient.isHandcuffed(source, {}, function(handcuffed)
					if handcuffed then
						TriggerClientEvent("tryCutCuffs", source)
					else
						vRPclient.notify(source, {"~w~[CUTTER] ~r~You don't have any cuffs on!"})
					end
				end)
			end
		end

		local function cuffCut_leave(source,area)
			TriggerClientEvent('unfreezePlayer', source)
		end
		vRPclient.addMarker(source,{x,y,z-1,0.7,0.7,0.5,0,125,255,125,150})
		vRP.setArea({source,"vRP:cuffCutt:"..group,x,y,z,1,1.5,cuffCut_enter,cuffCut_leave})
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	if first_spawn then
		build_client_cutcuff(source)
	end
end)