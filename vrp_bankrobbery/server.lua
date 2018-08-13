local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_bank")

local bankBox = {
	[1] = {name = "Diamonds", reward = 22000, from = 1, to = 4},
	[2] = {name = "Gold Bars", reward = 10000, from = 2, to = 5},
	[3] = {name = "Documents", reward = 3000, from = 5, to = 8},
	[4] = {name = "Jewelry", reward = 9000, from = 3, to = 10},
	[5] = {name = "Paintings", reward = 11000, from = 1, to = 3}
}

local launderLoc = {
	-- Langa cop
	[1] = {x = 1338.7458496094, y = 4359.654296875, z = 44.366901397705 },
	[2] = {x = 1417.8709716797, y = 6343.9287109375, z = 24.000860214233 },
	[3] = {x = 714.49639892578, y = 4102.02734375, z = 35.783344268799 },
	
	-- Langa baza swat
    [4] = {x = 166.54945373535, y = 2229.1828613281, z = 90.757232666016 },
	[5] = {x = 3817.4770507813, y = 4482.4047851563, z = 5.9926805496216 },
	[6] = {x = -1928.8021240234, y = 2060.0844726563, z = 140.83753967285 },
	
	-- fleca ALTA oras
    [7] = {x = -1111.3193359375, y = 4937.11328125, z = 218.38598632813 },
	[8] = {x = 1210.9002685547, y = 1857.9873046875, z = 78.911552429199 },
	[9] = {x = 2158.9123535156, y = 4789.8051757813, z = 41.121669769287 },
	
	-- fleca Burton oras
    [10] = {x = 2527.7387695313, y = 2586.2150878906, z = 37.944881439209 },
	[11] = {x = 2030.2705078125, y = 4980.2529296875, z = 42.098243713379 },
	[12] = {x = -571.10955810547, y = -1776.3297119141, z = 23.180351257324 },
 
 	-- blaine
    [13] = {x = -1657.4659423828, y = -982.48443603516, z = 8.166971206665 },
	[14] = {x = 1510.0239257813, y = -2720.6242675781, z = 3.9769735336304 },
	[15] = {x = 2220.9243164063, y = 5614.3930664063, z = 54.715099334717 },
	---Yacht Beach
	[16] = {x = 3092.9914550782, y = -4702.6416015625, z = 18.315107345582},
	[17] = {x = -3033.0319824218, y = 556.57482910156, z = 7.5076842308044},
	[18] = {x = -411.80749511718, y = -2707.1264648438, z = 7.5076842308044}
}

local banks = {
	["fleeca"] = {
		position = { ['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.36802482605 },
		nameofbank = "Fleeca Bank",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleeca2"] = {
		position = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.697026252747 },
		nameofbank = "Fleeca Bank (Highway)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["blainecounty"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		nameofbank = "Blaine County Savings",
		lastrobbed = 0,
		from = 13,
		to = 15
	},
	["fleeca3"] = {
		position = { ['x'] = -1211.6306152344, ['y'] = -335.71124267578, ['z'] = 37.7 },
		nameofbank = "Fleeca Bank (Vinewood Hills)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleeca4"] = {
		position = { ['x'] = -354.452575683594, ['y'] = -53.8204879760742, ['z'] = 48.5463104248047 },
		nameofbank = "Fleeca Bank (Burton)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleeca5"] = {
		position = { ['x'] = 309.967376708984, ['y'] = -283.033660888672, ['z'] = 53.6745223999023 },
		nameofbank = "Fleeca Bank (Alta)",
		lastrobbed = 0,
		from = 1,
		to = 12
	},
	["fleeca6"] = {
		position = { ['x'] = 1176.86865234375, ['y'] = 2711.91357421875, ['z'] = 38.097785949707 },
		nameofbank = "Fleeca Bank (Desert)",
		lastrobbed = 0,
		from = 13,
		to = 15
	},
	["fleeca7"] = {
		position = { ['x'] = -2068.9252929688, ['y'] = -1023.221496582, ['z'] = 11.91005039215 },
		nameofbank = "Yacht Luxury(Beach)",
		lastrobbed = 0,
		from = 16,
		to = 18
	},
	["pacific"] = {
		position = { ['x'] = 255.001098632813, ['y'] = 225.855895996094, ['z'] = 101.005694274902 },
		nameofbank = "Pacific Standard PDB (Downtown Vinewood)",
		lastrobbed = 0,
		from = 1,
		to = 12
	}
}

local robbers = {}

function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

RegisterServerEvent('es_bank:toofar')
AddEventHandler('es_bank:toofar', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_bank:toofarlocal', source)
		robbers[source] = nil
		swat = vRP.getUsersByGroup({"SWAT"}) 
		cops = vRP.getUsersByGroup({"cop"})
		fbiagent = vRP.getUsersByGroup({"fbiagent"})
		for i, v in pairs(swat) do
			local thePlayer = vRP.getUserSource({v})
			TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery stopped at: ^2" .. banks[robb].nameofbank)
		end
		for i, v in pairs(cops) do
			local thePlayer = vRP.getUserSource({v})
			TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery stopped at: ^2" .. banks[robb].nameofbank)
		end
		for i, v in pairs(fbiagent) do
			local thePlayer = vRP.getUserSource({v})
			TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery stopped at: ^2" .. banks[robb].nameofbank)
		end
	end
end)

RegisterServerEvent('es_bank:playerdied')
AddEventHandler('es_bank:playerdied', function(robb)
	if(robbers[source])then
		TriggerClientEvent('es_bank:playerdiedlocal', source)
		robbers[source] = nil
		swat = vRP.getUsersByGroup({"SWAT"}) 
		cops = vRP.getUsersByGroup({"cop"})
		fbiagent = vRP.getUsersByGroup({"fbiagent"})
		for i, v in pairs(swat) do
			local thePlayer = vRP.getUserSource({v})
			TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery stopped at: ^2" .. banks[robb].nameofbank)
		end
		for i, v in pairs(cops) do
			local thePlayer = vRP.getUserSource({v})
			TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery stopped at: ^2" .. banks[robb].nameofbank)
		end
		for i, v in pairs(fbiagent) do
			local thePlayer = vRP.getUserSource({v})
			TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery stopped at: ^2" .. banks[robb].nameofbank)
		end
	end
end)

RegisterServerEvent('playerDropped')
AddEventHandler('playerDropped', function(robb)
	if(robbers[source])then
		TriggerClientEvent('playerDropped', source)
		robbers[source] = nil
		swat = vRP.getUsersByGroup({"SWAT"}) 
		cops = vRP.getUsersByGroup({"cop"})
		fbiagent = vRP.getUsersByGroup({"fbiagent"})
		for i, v in pairs(swat) do
			local thePlayer = vRP.getUserSource({v})
			TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "The thief has disconnected, the robbery is over")
		end
		for i, v in pairs(cops) do
			local thePlayer = vRP.getUserSource({v})
			TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "The thief has disconnected, the robbery is over")
		end
		for i, v in pairs(fbiagent) do
			local thePlayer = vRP.getUserSource({v})
			TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "The thief has disconnected, the robbery is over")
		end
	end
end)

bID = {}

RegisterServerEvent('es_bank:rob')
AddEventHandler('es_bank:rob', function(robb)
	user_id = vRP.getUserId({source})
	local player = vRP.getUserSource({user_id})
	local bank = banks[robb]
	if (os.time() - bank.lastrobbed) < 1200 and bank.lastrobbed ~= 0 then
		TriggerClientEvent('chatMessage', player, '[ROB]', {255, 0, 0}, "This bank was recently robbed. Please wait: ^2" .. (2400 - (os.time() - bank.lastrobbed)) .. "^0 seconds.")
		return
	end
	swat = vRP.getUsersByGroup({"SWAT"})
	cops = vRP.getUsersByGroup({"cop"})
	fbiagent = vRP.getUsersByGroup({"fbiagent"})
	if (vRP.hasGroup({user_id,"SWAT"}) or vRP.hasGroup({user_id,"cop"}) or vRP.hasGroup({user_id,"ems"}) or vRP.hasGroup({user_id,"fbiagent"})) then
		vRPclient.notify(player,{"~r~Governmentel factions cannot rob banks."})
		return		
	else
		local enforcers = tonumber(#cops) + tonumber(#swat) + tonumber(#fbiagent)
		if (enforcers >= 2) then
			if banks[robb] then
				if (robbers[player] == nil) then
					local bank = banks[robb]
					for i, v in pairs(swat) do
						local thePlayer = vRP.getUserSource({v})
						TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery in progress at ^2" .. bank.nameofbank)
					end
					for i, v in pairs(cops) do
						local thePlayer = vRP.getUserSource({v})
						TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery in progress at ^2" .. bank.nameofbank)
					end
					for i, v in pairs(cops) do
						local thePlayer = vRP.getUserSource({v})
						TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery in progress at ^2" .. bank.nameofbank)
					end
					TriggerClientEvent('chatMessage', player, '[ROB]', {255, 0, 0}, "You have started a robbery at: ^2" .. bank.nameofbank .. "^0, don't go too far away!")
					TriggerClientEvent('chatMessage', player, '[ROB]', {255, 0, 0}, "Hold the bank for ^1 8 ^minutes to steal the goods!")
					TriggerClientEvent('chatMessage', -1, '[WEAZEL NEWS]', {255, 0, 0}, "^4The police ^0is warning ^3civilians ^0to avoid going near: ^2" .. bank.nameofbank)
					robb = robb
					
					TriggerClientEvent('es_bank:currentlyrobbing', player, robb)
					banks[robb].lastrobbed = os.time()
					robbers[player] = robb
					savedSource = player
					SetTimeout(480000, function()
						if(user_id)then
							if (robbers[player] ~= nil) then								
								locRand = math.random(bank.from, bank.to)
								launderLc = launderLoc[locRand]
								x, y, z = launderLc.x, launderLc.y, launderLc.z
								
								TriggerClientEvent('es_bank:robberycomplete', player, x, y, z)
								
								rndDmd = math.random(bankBox[1].from, bankBox[1].to)
								rndGold = math.random(bankBox[2].from, bankBox[2].to)
								rndDocs = math.random(bankBox[3].from, bankBox[3].to)
								rndJew = math.random(bankBox[4].from, bankBox[4].to)
								rndPaint = math.random(bankBox[5].from, bankBox[5].to)
								
								local theBlip = vRPclient.addBlip(player,{x,y,z,431,49,"Sell Stolen Goods"}, function(id)
									user_id = vRP.getUserId({player})
									bID[user_id] = id
								end)
								local theMarker = vRPclient.setNamedMarker(player,{"vRP:robberyLaunderM",x,y,z-1,0.7,0.7,0.5,0,255,125,125,150})
								vRPclient.setGPS(player,{x,y})
								
								local function launder_enter(source,area)
									local user_id = vRP.getUserId({source})
									if(robbers[source])then
										SetTimeout(400, function()
											vRPclient.removeNamedMarker(source,{"vRP:robberyLaunderM"})
											vRPclient.removeArea({source,"vRP:launderLoc"})	
											vRPclient.removeBlip(source,{bID[user_id]})
											bID[user_id] = nil
										end)
										
										totalMoney = tonumber((rndDmd * bankBox[1].reward) + (rndGold * bankBox[2].reward) + (rndDocs * bankBox[3].reward) + (rndJew * bankBox[4].reward) + (rndPaint * bankBox[5].reward))
										theJackpot = math.random(1,20)
										treasureDiamond = math.random(70,100)
                                     
										vRPclient.notify(source,{"~w~[ROB] ~g~You received ~r~$"..totalMoney.." ~g~dirty money!"})
										vRP.giveInventoryItem({user_id, "dirty_money", totalMoney, false})	
										robbers[source] = nil
										
										TriggerClientEvent('es_bank:stopRobbery', player)
									end
								end
								
								local function launder_leave(source,area)
									return true
								end
								vRP.setArea({player,"vRP:launderLoc",x,y,z,1,1.5,launder_enter,launder_leave})
								vRPclient.notify(player,{"~w~[ROB] ~g~Loot:\n~w~"..rndDmd.. " ~r~" ..bankBox[1].name.."\n~w~"..rndGold.." ~r~"..bankBox[2].name .."\n~w~"..rndDocs.." ~r~"..bankBox[3].name.."\n~w~"..rndJew.." ~r~"..bankBox[4].name})
								vRPclient.notify(player,{"~w~"..rndPaint.." ~r~"..bankBox[5].name..""})
								TriggerClientEvent('chatMessage', player, '[ROB]', {255, 0, 0}, "Go to the ^1'red dollar' ^0on the map to sell the stolen goods!")
								
								for i, v in pairs(swat) do
									local thePlayer = vRP.getUserSource({v})
									TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery over at: ^2" .. bank.nameofbank .. "^0! Catch the thief before he sells the stolen goods!")
								end
								for i, v in pairs(cops) do
									local thePlayer = vRP.getUserSource({v})
									TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery over at: ^2" .. bank.nameofbank .. "^0! Catch the thief before he sells the stolen goods!")
								end
								for i, v in pairs(fbiagent) do
									local thePlayer = vRP.getUserSource({v})
									TriggerClientEvent('chatMessage', thePlayer, '[ROB]', {255, 0, 0}, "Robbery over at: ^2" .. bank.nameofbank .. "^0! Catch the thief before he sells the stolen goods!")
								end
							else 
								return
							end
						end
					end)
				else
					vRPclient.notify(player,{"~r~You are already robbing a bank"})
				end	
			end
		else
			vRPclient.notify(player,{"~r~Not enough cops/SWATs online."})
		end
	end
end)