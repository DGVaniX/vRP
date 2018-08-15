
MySQL.createCommand("vRP/sell_vehicle_player","UPDATE vrp_user_vehicles SET user_id = @user_id, vehicle_plate = @registration WHERE user_id = @oldUser AND vehicle = @vehicle")

-- sell vehicle
veh_actions[lang.vehicle.sellTP.title()] = {function(playerID,player,vtype,name)
	if playerID ~= nil then
		vRPclient.getNearestPlayers(player,{15},function(nplayers)
			usrList = ""
			for k,v in pairs(nplayers) do
				usrList = usrList .. "[" .. vRP.getUserId(k) .. "]" .. GetPlayerName(k) .. " | "
			end
			if usrList ~= "" then
				vRP.prompt(player,"Players Nearby: " .. usrList .. "","",function(player,user_id) 
					user_id = user_id
					if user_id ~= nil and user_id ~= "" then 
						local target = vRP.getUserSource(tonumber(user_id))
						if target ~= nil then
							vRP.prompt(player,"Price $: ","",function(player,amount)
								if (tonumber(amount)) and (tonumber(amount) > 0) then
									MySQL.query("vRP/get_vehicle", {user_id = user_id, vehicle = name}, function(pvehicle, affected)
										if #pvehicle > 0 then
									              	vRPclient.notify(player,{"~r~The player already has this vehicle type."})
										else
											local tmpdata = vRP.getUserTmpTable(playerID)
											if tmpdata.rent_vehicles[name] == true then
												vRPclient.notify(player,{"~r~You cannot sell a rented vehicle!"})
												return
											else
												vRP.request(target,GetPlayerName(player).." wants to sell: " ..name.. " Price: $"..amount, 10, function(target,ok)
													if ok then
														local pID = vRP.getUserId(target)
														local money = vRP.getMoney(pID)
														if (tonumber(money) >= tonumber(amount)) then
															vRPclient.despawnGarageVehicle(player,{vtype,15}) 
															vRP.getUserIdentity(pID, function(identity)
																MySQL.execute("vRP/sell_vehicle_player", {user_id = user_id, registration = "P "..identity.registration, oldUser = playerID, vehicle = name}) 
															end)
															vRP.giveMoney(playerID, amount)
															vRP.setMoney(pID,money-amount)
															vRPclient.notify(player,{"~g~You have successfully sold the vehicle to ".. GetPlayerName(target).." for $"..amount.."!"})
															vRPclient.notify(target,{"~g~"..GetPlayerName(player).." has successfully sold you the car for $"..amount.."!"})
														else
															vRPclient.notify(player,{"~r~".. GetPlayerName(target).." doesn't have enough money!"})
															vRPclient.notify(target,{"~r~You don't have enough money!"})
														end
													else
														vRPclient.notify(player,{"~r~"..GetPlayerName(target).." has refused to buy the car."})
														vRPclient.notify(target,{"~r~You have refused to buy "..GetPlayerName(player).."'s car."})
													end
												end)
											end
											vRP.closeMenu(player)
										end
									end) 
								else
									vRPclient.notify(player,{"~r~The price of the car has to be a number."})
								end
							end)
						else
							vRPclient.notify(player,{"~r~That ID seems invalid."})
						end
					else
						vRPclient.notify(player,{"~r~No player ID selected."})
					end
				end)
			else
				vRPclient.notify(player,{"~r~No player nearby."})
			end
		end)
	end
end, lang.vehicle.sellTP.description()}
