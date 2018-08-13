local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_findPlayer")

vRPfp = {}
Tunnel.bindInterface("vRP_findPlayer",vRPfp)
Proxy.addInterface("vRP_findPlayer",vRPfp)
vRPfpC = Tunnel.getInterface("vRP_findPlayer","vRP_findPlayer")

playersTracking = {}
playersToFind = {}


local function findThePlayer(player,choice)
	local user_id = vRP.getUserId({player})
	target = playersToFind[choice]
	if(user_id == target)then
		vRPclient.notify(player,{"~r~You cannot locate yourself!"})
	else
		theTarget = vRP.getUserSource({target})
		TriggerClientEvent("findPlayerOnMap", player, theTarget)
		playersTracking[user_id] = target
		vRP.closeMenu({player})
	end
end
	
local function cancelTracking(player,choice)
	local user_id = vRP.getUserId({player})
	TriggerClientEvent("cancelPlayerTracking", player)
	playersTracking[user_id] = nil
	vRP.closeMenu({player})
end

AddEventHandler('playerDropped', function()
	local trackedPlayer = source
	users = vRP.getUsers({})
	for i, v in pairs(users) do
		local user_id = vRP.getUserId({v})
		local trackedPlr = playersTracking[user_id]
		if(trackedPlr == trackedPlayer)then
			TriggerClientEvent("cancelPlayerTracking", v)
			vRP.notify(v, {"~w~[FIND] ~r~Player ~w~"..GetPlayerName(trackedPlr).." ~r~has quit the game!"})
		end
	end
end)

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		if(vRP.hasPermission({user_id, "hitman.findPlayers"}))then
			choices["Find Player"] = {function(player,choice)
				users = vRP.getUsers({})
				vRP.buildMenu({"Players to Find", {player = player}, function(menu)
					menu.name = "Players to Find"
					menu.css={top="75px",header_color="rgba(235,0,0,0.75)"}
					menu.onclose = function(player) vRP.openMainMenu({player}) end	
					if(playersTracking[user_id] == nil)then
						myName = tostring(GetPlayerName(player))
						for k,v in pairs(users) do
							playerName = tostring(GetPlayerName(v))
							playersToFind[playerName] = tonumber(k)
							menu[playerName] = {findThePlayer, "Mark the player on the map"}
						end
					else
						menu["Cancel Marker"] = {cancelTracking, "Cancel the marker"}
					end
					vRP.openMenu({player, menu})
				end})
			end, "Find a player on the map!"}
		end
		add(choices)
	end
end})