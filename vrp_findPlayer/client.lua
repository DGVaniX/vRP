vRPfpc = {}
Tunnel.bindInterface("vRP_findPlayer",vRPfpc)
vRPserver = Tunnel.getInterface("vRP","vRP_findPlayer")
BMserver = Tunnel.getInterface("vRP_findPlayer","vRP_findPlayer")
vRP = Proxy.getInterface("vRP")

isBlipDrawn = false
waypointBlip = nil
targetPlayer = nil


function drawRouteToPlayer()
	if (isBlipDrawn == false) then
		isBlipDrawn = true
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(targetPlayer), false))
		if(waypointBlip)then
			RemoveBlip(waypointBlip)
			waypoint = AddBlipForCoord(x, y, z)
			SetBlipSprite(waypoint, 280)
			SetBlipColour(waypoint, 49)
			SetNewWaypoint(x, y)
			waypointBlip = waypoint
		else
			waypoint = AddBlipForCoord(x, y, z)
			SetBlipSprite(waypoint, 280)
			SetBlipColour(waypoint, 49)
			SetNewWaypoint(x, y)
			waypointBlip = waypoint
		end
	else
		vRP.notify({"~w~[FIND] ~r~~w~"..GetPlayerName(targetPlayer).."'s ~r~marker has been taken off the map"})
		isBlipDrawn = false
		SetWaypointOff()
		RemoveBlip(waypointBlip)
		waypointBlip = nil
		targetPlayer = nil
	end
end

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		if(targetPlayer)then
			isBlipDrawn = false
			drawRouteToPlayer()
		end
	end
end)

RegisterNetEvent('findPlayerOnMap')
AddEventHandler('findPlayerOnMap', function(target)
	for i = 0, 32 do
		if NetworkIsPlayerConnected(i) then
			local serverID = GetPlayerServerId(i)
			if(serverID == target)then
				targetPlayer = i
			end
		end
	end
	drawRouteToPlayer()
	vRP.notify({"~w~[FIND] ~g~Player ~r~"..GetPlayerName(targetPlayer).." ~g~has been marked on the map"})
end)

RegisterNetEvent('cancelPlayerTracking')
AddEventHandler('cancelPlayerTracking', function()
	isBlipDrawn = true
	drawRouteToPlayer()
end)