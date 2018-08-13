local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPtow = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_tow")
BMclient = Tunnel.getInterface("vRP_tow","vRP_tow")
Tunnel.bindInterface("vrp_tow",vRPtow)
Proxy.addInterface("vrp_tow",vRPtow)

towGroup = "Tow Truck Company"
impoundFee = 1000
isTowing = {}

local allowedTowModels = { "flatbed" }

function isPlayerTowTrucker(user_id)
	if(vRP.hasGroup({user_id, towGroup}))then
		return true
	else
		return false
	end
	return false
end

function setPlayerAsNotTowing(thePlayer)
	local user_id = vRP.getUserId({thePlayer})
	isTowing[user_id] = nil
end

RegisterServerEvent("setPlayerAsNotTowing")
AddEventHandler("setPlayerAsNotTowing", function(theVehicle)
	local user_id = vRP.getUserId({source})
	isTowing[user_id] = nil
end)

RegisterServerEvent("setPlayerAsTowing")
AddEventHandler("setPlayerAsTowing", function(theVehicle)
	local user_id = vRP.getUserId({source})
	isTowing[user_id] = theVehicle
end)

local function ch_towVehicle(player, choice)
	TriggerClientEvent('towVehicle', player)
	vRP.closeMenu({player})
end

local function ch_unimpoundVehicle(player, choice)
	setPlayerAsNotTowing(player)
	TriggerClientEvent('towVehicle', player)
	vRP.closeMenu({player})
end

local function ch_impoundVehicle(player, choice)
	TriggerClientEvent('deleteTowedVehicle', player)
	local user_id = vRP.getUserId({player})
	vRP.closeMenu({player})
	setPlayerAsNotTowing(player)
	vRP.giveMoney({user_id, impoundFee})
	vRPclient.notify(player, {"~w~[T.T.C] ~g~You impounded the vehicle for ~r~$"..impoundFee})
end

local function ch_repair(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		vRPclient.getNearestVehicle(player, {7}, function(veh)
			if(veh)then
				vRPclient.playAnim(player,{false,{task="WORLD_HUMAN_WELDING"},false})
				SetTimeout(15000, function()
					vRPclient.fixeNearestVehicle(player,{7})
					vRPclient.stopAnim(player,{false})
				end)
			else
				vRPclient.notify(player, {"~w~[T.T.C] ~r~No vehicle nearby"})
			end
		end)
	end
end

local function ch_towMenu(player, choice)
	vRP.buildMenu({"Tow Truck Company", {player = player}, function(menu)
		menu.name = "Tow Truck Company"
		menu.css={top="75px",header_color="rgba(0,255,213,0.75)"}
		menu.onclose = function(player) vRP.openMainMenu({player}) end -- nest menu
		local user_id = vRP.getUserId({player})
		if(isTowing[user_id] == nil)then
			menu["Tow Vehicle"] = {ch_towVehicle,"Tow the vehicle near you"}
		else
			menu["Release Vehicle"] = {ch_unimpoundVehicle,"Release the vehicle from the platform"}
		end
		menu["Repair Vehicle"] = {ch_repair,"Repair vehicle"}
		vRP.openMenu({player,menu})
	end})
end

local function impoundVehicle(player)
	local user_id = vRP.getUserId({player})
	if(isTowing[user_id] ~= nil)then
		vRP.buildMenu({"Tow Vehicle", {player = player}, function(menu2)
			menu2.name = "Tow Vehicle?"
			menu2.css={top="75px",header_color="rgba(0,255,213,0.75)"}
			menu2.onclose = function(player) vRP.closeMenu({player}) end -- nest menu
						
			menu2["Yes"] = {ch_impoundVehicle,"Impound vehicle from the ramp"}
			menu2["No"] = {function(player) vRP.closeMenu({player}) end}
			vRP.openMenu({player,menu2})
		end})
	else
		vRPclient.notify(player,{"~w~[T.T.C] ~r~There's no vehicle on the ramp!"})
	end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source, first_spawn)
	isTowing[user_id] = nil
  
	local function impound_enter()
        local user_id = vRP.getUserId({source})
        if (user_id ~= nil and isPlayerTowTrucker(user_id)) then
			impoundVehicle(source) 
        end
    end

    local function impound_leave()
		vRP.closeMenu({source})
    end
	
	local x, y, z = -453.5848083496,-799.92303466796,30.544145584106
	vRPclient.addMarker(source,{x,y,z-1,2.2,2.2,0.65,0,0,255,213,150})
	vRPclient.addBlip(source,{x,y,z,68,26,"Tow Truck Company"})
    vRP.setArea({source,"vRP:towImpound",x,y,z,3.8,1.5,impound_enter,impound_leave})
end)

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		choices = {}
		if (isPlayerTowTrucker(user_id) == true) then
			choices["T.T.C Company"] = {ch_towMenu, "Tow Truck Company menu"}
		end
		add(choices)
	end
end})