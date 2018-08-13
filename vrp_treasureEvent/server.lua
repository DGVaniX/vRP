--Settings--
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_treasureEvent")

local treasureOn = false
local trasureReward = math.random(10000,300000)
local trasureDiamonds = math.random(10,30)

bID = {}

local treasurePos = {
	{-1684.2731933594,-1067.8004150391,2.3339104652405},
	{75.846710205078,7182.7319335938,1.6343230009079},
	{3435.8498535156,6139.5087890625,0.82468450069427},
	{-3423.7138671875,960.45788574219,0.2656427025795},
	{1775.5557861328,-1930.5325927734,131.14338684082},
	{9.7767190933228,4311.58984375,32.258247375488},
	{1316.6146240234,3004.3234863281,44.554100036621},
	{-1039.9487304688,3429.685546875,183.45799255371},
	{1966.4390869141,482.43472290039,161.56465148926},
	{478.20419311523,-3389.8266601563,6.0699110031128}
}

RegisterNetEvent('autoStopTreasureHunt')
AddEventHandler('autoStopTreasureHunt', function()
	treasureOn = false
	TriggerClientEvent('chatMessage', -1, "^8[TREASURE-HUNT] ^8Treasure hunt over, no one found the treasure!")
	local users = vRP.getUsers({})
	for k, v in pairs(users) do
		thePlayer = v
		plyerIndex = k
		for i, v in pairs(treasurePos) do
			local blipID = "vRP:treasureBlip:"..i..":"..plyerIndex
			vRPclient.removeNamedBlip(thePlayer,{blipID})
		end
		local areaID = "vRP:treasureLoc:"..plyerIndex
		vRPclient.removeNamedMarker(thePlayer,{"vRP:treasureMarker:"..plyerIndex})
		vRP.removeArea({thePlayer,areaID})	
	end
end)

function startTreasureHunt()
	if(treasureOn == false)then
		treasureOn = true
		treasureReward = math.random(100000,300000)
		treasureDiamonds = math.random(10,30)
		TriggerClientEvent('chatMessage', -1, "^8[TREASURE-HUNT] ^2A treasure hunt has begun! Go to the right checkpoint ^8(Red Crown) ^2to find the treasure!")
		TriggerClientEvent('chatMessage', -1, "^8[TREASURE-HUNT] ^2The treasure hunt will be over in ^230 minutes!")			
		
		local function treasure_enter(source,area)
			local user_id = vRP.getUserId({source})
			local users = vRP.getUsers({})
			for k, v in pairs(users) do
				thePlayer = v
				plyerIndex = k
				for i, v in pairs(treasurePos) do
					local blipID = "vRP:treasureBlip:"..i..":"..plyerIndex
					vRPclient.removeNamedBlip(thePlayer,{blipID})
				end
				local areaID = "vRP:treasureLoc:"..plyerIndex
				vRPclient.removeNamedMarker(thePlayer,{"vRP:treasureMarker:"..plyerIndex})
				vRP.removeArea({thePlayer,areaID})
			end
		
			vRPclient.notify(source,{"~r~[TRASURE-HUNT] ~g~You received ~r~$"..treasureReward.." ~g~from the treasure!"})
			vRP.giveMoney({user_id,treasureReward})
			vRP.givediamonds({user_id,treasureDiamonds})
			TriggerClientEvent('chatMessage', -1, "^8[TREASURE-HUNT] ^2"..GetPlayerName(source).." found the treasure and received ^5$"..treasureReward)
			treasureOn = false
		end
			local function treasure_leave(source,area)
			return true
		end
		
		local users = vRP.getUsers({})
		for k, v in pairs(users) do
			thePlayer = v
			plyerIndex = k
			for i, v in pairs(treasurePos) do
				local pos = v
				local x, y, z = v[1], v[2], v[3]
				local blipID = "vRP:treasureBlip:"..i..":"..plyerIndex
				vRPclient.setNamedBlip(thePlayer,{blipID,x,y,z,439,49,"Treasure Hunt"})
			end
		end
		
		local randLoc = math.random(#treasurePos)
		
		local x, y, z = treasurePos[randLoc][1], treasurePos[randLoc][2], treasurePos[randLoc][3]
		for i, v in pairs(users) do
			vRP.setArea({v,"vRP:treasureLoc:"..i,x,y,z,1,1.5,treasure_enter,treasure_leave})
			vRPclient.setNamedMarker(v,{"vRP:treasureMarker:"..i,x,y,z,0.7,0.7,0.5,255,245,0,125,150})
	end
	
	SetTimeout(1800000, function()
		if (treasureOn == true) then
				TriggerEvent('autoStopTreasureHunt')
			end
		end)
	end	
end

RegisterCommand("trhunt", function(source, args, rawCommand)
	local user_id = vRP.getUserId({source})
	if user_id ~= nil and vRP.hasPermission({user_id,"admin.tickets"}) then
		if(treasureOn == false)then
			startTreasureHunt()
		else
			vRPclient.notify(source,{"~r~[EVENT] ~r~A treasure hunt is already ongoing!"})
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(3600000)
		startTreasureHunt()
	end
end)
