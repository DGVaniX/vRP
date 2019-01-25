local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPajail = {}
Tunnel.bindInterface("vRP_ajal",vRPajail)

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_ajal")

local jX, jY, jZ = 1687.8145751953,2518.6625976563,-120.84989929199 -- JAIL POSITION

local aUnjailed = {}
function ajail_clock(target_id,timer)
  local target = vRP.getUserSource({tonumber(target_id)})
  local users = vRP.getUsers({})
  local online = false
  for k,v in pairs(users) do
	if tonumber(k) == tonumber(target_id) then
	  online = true
	end
  end
  if online then
    if timer>0 then
	  vRPclient.notify(target, {"~r~Remaining time: " .. timer .. " minute(s)."})
      vRP.setUData({tonumber(target_id),"vRP:admin:jail:time",json.encode(timer)})
	  SetTimeout(60*1000, function()
		for k,v in pairs(aUnjailed) do -- check if player has been unjailed by cop or admin
		  if v == tonumber(target_id) then
	        aUnjailed[v] = nil
		    timer = 0
		  end
		end
		vRP.setHunger({tonumber(target_id), 0})
		vRP.setThirst({tonumber(target_id), 0})
	    ajail_clock(tonumber(target_id),timer-1)
	  end) 
    else 
	  vRPclient.teleport(target,{425.7607421875,-978.73425292969,30.709615707397}) -- teleport to outside jail
	  vRPclient.setHandcuffed(target,{false})
      vRPclient.notify(target,{"~b~You have been set free. Please follow the rules!"})
	  vRP.setUData({tonumber(target_id),"vRP:admin:jail:time",json.encode(-1)})
    end
  end
end

local a_jail = {function(player,choice) 
	vRP.prompt({player,"Players ID:","",function(player,target_id) 
		if target_id ~= nil and target_id ~= "" then 
			vRP.prompt({player,"Jail Time in minutes:","",function(player,jail_time)
				if jail_time ~= nil and jail_time ~= "" then 
					vRP.prompt({player,"Jail Reason:","",function(player,jail_reason)
						if jail_reason ~= nil and jail_reason ~= "" then 
							local target = vRP.getUserSource({tonumber(target_id)})
							if target ~= nil then
								if tonumber(jail_time) > 500 then
									jail_time = 500
								end
								if tonumber(jail_time) < 1 then
									jail_time = 1
								end
								vRPclient.teleport(target,{jX, jY, jZ}) -- teleport to inside jail
								TriggerClientEvent('chatMessage', -1, "[Admin Jail]", {0,0,0}, "^1Admin ^2"..GetPlayerName(player).." ^1has jailed ^2"..GetPlayerName(target).." ^1for ^2"..jail_time.." ^1minutes")
								TriggerClientEvent('chatMessage', -1, "[Admin Jail]", {0,0,0}, "^1Reason: ^2"..jail_reason)
								ajail_clock(tonumber(target_id),tonumber(jail_time))
								vRPclient.setHandcuffed(target,{true})
							end
						else
							vRPclient.notify(player,{"~r~Invalid reason."})
						end
					end})
				else
					vRPclient.notify(player,{"~r~The jail time can't be empty."})
				end
			end})
		else
			vRPclient.notify(player,{"~r~No player ID selected."}) 
		end
	end})
end,"Send a player to admin jail."}

local a_unjail = {function(player,choice) 
	vRP.prompt({player,"Player ID:","",function(player,target_id) 
		if target_id ~= nil and target_id ~= "" then 
			vRP.getUData({tonumber(target_id),"vRP:admin:jail:time",function(value)
				if value ~= nil then
					custom = json.decode(value)
					if custom ~= nil then
						local user_id = vRP.getUserId({player})
						if tonumber(custom) > 0 or vRP.hasPermission({user_id,"admin.ajail"}) then
							local target = vRP.getUserSource({tonumber(target_id)})
							if target ~= nil then
								aUnjailed[target] = tonumber(target_id)
								vRPclient.notify(player,{"~g~Target will be released soon."})
							else
								vRPclient.notify(player,{"~r~That ID seems invalid."})
							end
						else
							vRPclient.notify(player,{"~r~Target is not jailed."})
						end
					end
				end
			end})
		else
			vRPclient.notify(player,{"~r~No player ID selected."})
		end 
	end})
end,"Frees a jailed player."}

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
	local target = vRP.getUserSource({user_id})
	SetTimeout(35000,function()
		local custom = {}
		vRP.getUData({user_id,"vRP:jail:time",function(value)
			if value ~= nil then
				custom = json.decode(value)
				if custom ~= nil then
					if tonumber(custom) > 0 then
						vRPclient.teleport(target,{1687.8145751953,2518.6625976563,-120.84989929199}) -- teleport inside jail
						ajail_clock(tonumber(user_id),tonumber(custom))
					end
				end
			end
		end})
	end)
end)

vRP.registerMenuBuilder({"admin", function(add, data)
  local user_id = vRP.getUserId({data.player})
  if user_id ~= nil then
    local choices = {}

	if vRP.hasPermission({user_id,"admin.ajail"}) then
      choices["Admin Jail"] = a_jail -- admin jail
    end
	
	if vRP.hasPermission({user_id,"admin.ajail"}) then
      choices["Admin UnJail"] = a_unjail -- admin jail
    end
	
    add(choices)
  end
end})
