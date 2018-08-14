local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
local vehshop = module("vrp_showroom", "cfg/showroom")

MySQL = module("vrp_mysql", "MySQL")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_showroom")
Gclient = Tunnel.getInterface("vRP_garages","vRP_showroom")

-- vehicle db / garage and lscustoms compatibility

MySQL.createCommand("vRP/add_custom_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,veh_type) VALUES(@user_id,@vehicle,@vehicle_plate,@veh_type)")
 

function getPrice( category, model )
    for i,v in ipairs(vehshop.menu[category].buttons) do
      if v.model == model then
          return v.costs
      end
    end
    return nil 
end

-- SHOWROOM
RegisterServerEvent('veh_SR:CheckMoneyForVeh')
AddEventHandler('veh_SR:CheckMoneyForVeh', function(category, vehicle, price ,veh_type)
  local user_id = vRP.getUserId({source})
  local player = vRP.getUserSource({user_id})
  MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
	if #pvehicle > 0 then
		vRPclient.notify(player,{"~r~Vehicle already owned."})
	else
	    local actual_price = getPrice( category, vehicle)
		if actual_price == nil then
		    print( "Masina "..vehicle.." din categoria "..category.." nu are pret setat" )
			vRPclient.notify(player,{"~r~This car is out of stock"})
			return 
		end
		if  actual_price ~= price then
			print( "Player-ul cu id-ul "..user_id.. " e suspect de Cheat Engine.")
		end	
		if vRP.tryFullPayment({user_id,actual_price}) then
			vRP.getUserIdentity({user_id, function(identity)
              MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vehicle, vehicle_plate = "P "..identity.registration, veh_type = veh_type})
			end})
			TriggerClientEvent('veh_SR:CloseMenu', player)
			vRPclient.notify(player,{"Paid ~r~"..actual_price.."$."})
			vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
		else
			vRPclient.notify(player,{"~r~Not enough money."})
		end
	end
  end)
end)

RegisterServerEvent('veh_SR:CheckMoneyForBasicVeh')
AddEventHandler('veh_SR:CheckMoneyForBasicVeh', function(user_id, vehicle, price ,veh_type)
  local player = vRP.getUserSource({user_id})
  MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = vehicle}, function(pvehicle, affected)
	if #pvehicle > 0 then
		vRPclient.notify(player,{"~r~Vehicle already owned."})
		vRP.giveMoney({user_id,price})
	else
        vRPclient.notify(player,{"Paid ~r~"..price.."$."})
		vRP.getUserIdentity({user_id, function(identity)
          MySQL.query("vRP/add_custom_vehicle", {user_id = user_id, vehicle = vehicle, vehicle_plate = "P "..identity.registration, veh_type = veh_type})
		vRPclient.notify(player,{"Pentru a ridica masina viziteaza orice garaj."})
		end})
	end
  end)
end)
