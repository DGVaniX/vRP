local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_factions")

factions = {
	-- {Grup, Lider Grup, Nume Grup}	
	{"cop", "Police Leader", "Police"},
	{"fbiagent", "FBI Leader", "F.B.I"},
	{"ems", "EMS Leader", "E.M.S"},
	{"SWAT", "SWAT Leader", "S.W.A.T"}
}

local function ch_inviteInFaction(player,choice)
	local user_id = vRP.getUserId({player})
	for i, v in pairs(factions) do
		group = v[1]
		if(vRP.hasGroup({user_id, group}))then
			groupLider = v[2]
			groupName = v[3]
			theGroup = tostring(group)
			vRP.prompt({player,"User id: ","",function(player,id)
				id = parseInt(id)
				groupName = tostring(groupName)
				local target = vRP.getUserSource({id})
				if(target)then
					if(vRP.hasGroup({id, theGroup}))then
						vRPclient.notify(player,{"~r~Player is already in faction ~g~"..groupName.."!"})
					else
						vRP.addUserGroup({id,theGroup})
						local name = GetPlayerName(target)
						vRPclient.notify(player,{"~w~You added ~g~"..name.."~w~ in faction ~g~"..groupName.."!"})
						vRPclient.notify(target,{"~w~You were added in ~g~"..groupName.."!"})
					end
				else
					vRPclient.notify(player,{"~r~Player not found!"})
				end
			end})
		end
	end
end

local function ch_removeFromFaction(player,choice)
	local user_id = vRP.getUserId({player})
	for i, v in pairs(factions) do
		group = v[1]
		if(vRP.hasGroup({user_id, group}))then
			groupLider = v[2]
			groupName = v[3]
			theGroup = tostring(group)
			vRP.prompt({player,"User id: ","",function(player,id)
				groupName = tostring(groupName)
				id = parseInt(id)
				local target = vRP.getUserSource({id})
				if(target)then
					if(vRP.hasGroup({id, theGroup}))then
						vRP.removeUserGroup({id,theGroup})
						local name = GetPlayerName(target)
						vRPclient.notify(player,{"~w~You kicked ~g~"..name.." ~w~out of ~g~"..groupName.."!"})
						vRPclient.notify(target,{"~w~You were kicked out from ~g~"..groupName.."!"})
					else
						vRPclient.notify(player,{"~w~Player is not in ~r~"..groupName.."!"})
					end
				else
					vRPclient.notify(player,{"~r~Player not found!"})
				end
			end})
		end
	end
end

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId(data.player)
	if user_id ~= nil then
		local choices = {}
		for i, v in pairs(factions) do
			groupLider = v[2]
			if(vRP.hasGroup({user_id, groupLider}))then
				group = v[1]
				groupName = v[3]
				choices["Leader Menu"] = {function(player,choice)
					vRP.buildMenu({"Leader Menu", {player = player}, function(menu)
						menu.name = "Leader Menu"
						menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
						menu.onclose = function(player) vRP.openMainMenu({player}) end
						menu["Invite Member"] = {ch_inviteInFaction, "Invite member in "..groupName}
						menu["Kick Member"] = {ch_removeFromFaction, "Kick member out of "..groupName}
						vRP.openMenu(player,menu)
					end})
				end, "Leader menu for faction "..groupName}
			end
		end
		add(choices)
	end
end})

local function ch_leaveGroup(player,choice)
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
		for i, v in pairs(factions) do
			group = v[1]
			if(vRP.hasGroup({user_id, group}))then
				groupLider = v[2]
				groupName = v[3]
				theGroup = tostring(group)
				vRP.removeUserGroup({user_id,theGroup})
				vRPclient.notify(player,{"~w~You left ~r~"..groupName.."!"})
				vRP.openMainMenu({player})
				local fMembers = vRP.getUsersByGroup({tostring(theGroup)})
				for i, v in ipairs(fMembers) do
					local member = vRP.getUserSource({tonumber(v)})
					vRPclient.notify(member,{"~r~"..GetPlayerName(player).." ~w~a has left the faction!"})
				end
			end
		end
	end
end

vRP.registerMenuBuilder({"main", function(add, data)
	local user_id = vRP.getUserId({data.player})
	if user_id ~= nil then
		local choices = {}
		for i, v in pairs(factions) do
			group = v[1]
			if(vRP.hasGroup({user_id, group}))then
				groupLider = v[2]
				groupName = v[3]
				choices["Leave Faction"] = {function(player,choice)
					vRP.buildMenu({"Leave faction?", {player = player}, function(menu)
						groupName = tostring(groupName)
						menu.name = "Leave faction?"
						menu.css={top="75px",header_color="rgba(200,0,0,0.75)"}
						menu.onclose = function(player) vRP.openMainMenu({player}) end

						menu["Yes"] = {ch_leaveGroup, "Leave "..groupName}
						menu["No"] = {function(player) vRP.openMainMenu({player}) end}
						vRP.openMenu({player,menu})
					end})
				end, "Leave "..groupName}
			end
		end
		add(choices)
	end
end})

RegisterCommand('f', function(source, args, rawCommand)
	if(args[1] == nil)then
		TriggerClientEvent('chatMessage', source, "^3SYNTAX: /"..rawCommand.." [Message]") 
	else
		local user_id = vRP.getUserId({source})
		theGroup = ""
		for i, v in pairs(factions) do
			if vRP.hasGroup({user_id,tostring(v)}) then
				theGroup = tostring(v[1])
				theName = tostring(v[3])
			end
		end
		local fMembers = vRP.getUsersByGroup({tostring(theGroup)})
		for i, v in ipairs(fMembers) do
			local player = vRP.getUserSource({tonumber(v)})
			TriggerClientEvent('chatMessage', player, "^5["..theName.."] ^7| " .. GetPlayerName(source) .. ": " ..  rawCommand:sub(3))
		end
	end
end)